-- Stolen and modified from https://github.com/aidangoettsch/mpv-silence-speed
script_name = 'silencespeed'

mp = require 'mp'
msg = require 'mp.msg'
options = require 'mp.options'
utils = require 'mp.utils'

-- Max noise (dB) and min silence duration to trigger
opts = {
    quietness = -50,
    quietness_inc = 1,
    duration = 1/6,
    start_offset = 1/6,
    end_offset = 1/3,
    speed_mult = 1.10,
    silence_speed = 3
}

doing_silence = false
enabled = false
in_silence = false
silence_queued = nil
old_speed = 1
silence_start = -1
silence_end = -1

function setSpeed(speed)
    msg.verbose('setting speed:', speed)
    mp.set_property('speed', speed)
end

function setSilenceSpeed(speed)
    opts.silence_speed = speed
    if enabled and in_silence then
        setSpeed(opts.silence_speed)
    end
    setAudioFilterParams()
end

function getSpeed()
    return mp.get_property_native('speed')
end

function queueSilence()
    msg.trace('queued silence')
    if silence_queued == nil then
        silence_queued = mp.add_periodic_timer(0.05, updateSilence)
    end

    if not silence_queued:is_enabled() then
        silence_queued:resume()
    end
end

function unqueueSilence()
    msg.trace('unqueued silence')
    if silence_queued ~= nil then
        silence_queued:stop()
    end
end

function updateSilence()
    msg.trace('update silence')

    -- Return if no silences were queued
    if not silence_queued or silence_start < 0 then
        unqueueSilence()
        return
    end

    local timestamp = mp.get_property_native('time-pos')
    if timestamp == nil then
        return
    end
    msg.trace('update silence:', silence_start, timestamp, silence_end)

    if silence_start + (opts.start_offset * old_speed) < timestamp then
        local ad_infinitum = silence_end <= silence_start
        local do_silence = timestamp < silence_end - (opts.end_offset * opts.silence_speed)

        in_silence = ad_infinitum or do_silence
        maybeSetSilence()

        if ad_infinitum or not do_silence then
            unqueueSilence()
        end
    else
        in_silence = false
        maybeSetSilence()
    end
end

function foundSilence(name, value)
    msg.trace('found silence')
    if value == '{}' or value == nil then
        return
    end
    msg.trace('found silence:', value)
    local silence_data = utils.parse_json(value)
    silence_start = tonumber(silence_data["lavfi.silence_start"])
    silence_end = tonumber(silence_data["lavfi.silence_end"])
    if silence_end == nil then
        silence_end = 0
    end

    msg.debug('found silence:', silence_start, silence_end)
    queueSilence()
    updateSilence()
end

function maybeSetSilence()
    msg.trace('maybe set silence:', in_silence)
    if not enabled then
        return
    end

    setSilence(in_silence)
end

function setSilence(enabled)
    msg.debug('set silence', enabled, in_silence, doing_silence)
    if enabled and in_silence then
        if not doing_silence then
            doing_silence = true
            old_speed = getSpeed()
            setSpeed(opts.silence_speed)
        end
    elseif doing_silence then
        updateOldSpeed()
        doing_silence = false
        setSpeed(old_speed)
    end
end

function init()
    local af_table = mp.get_property_native('af')
    table.insert(
        af_table, 1, {
            enabled = false,
            label   = script_name,
            name    = 'lavfi',
            params  = { graph = 'silencedetect=noise=' .. opts.quietness .. 'dB:duration=' .. opts.duration * opts.silence_speed }
    })
    mp.set_property_native('af', af_table)
end

function setAudioFilterParams()
    local af_table = mp.get_property_native('af')
    for i, _ in ipairs(af_table) do
        if af_table[i].label == script_name then
            af_table[i].params = { graph = 'silencedetect=noise=' .. opts.quietness .. 'dB:duration=' .. opts.duration * opts.silence_speed }
            mp.set_property_native('af', af_table)
            break
        end
    end
end

function setAudioFilter(enabled)
    local af_table = mp.get_property_native('af')
    for i, _ in ipairs(af_table) do
        if af_table[i].label == script_name then
            af_table[i].enabled = enabled
            mp.set_property_native('af', af_table)
            break
        end
    end
end

function toggleKeypress()
    enabled = not enabled
    setSilence(enabled)
    setAudioFilter(enabled)

    if enabled then
        mp.commandv("show-text", 'Silence speed enabled')
    else
        mp.commandv("show-text", 'Silence speed disabled')
    end
end

function showSilenceSpeed()
    mp.commandv("show-text", string.format('Silence speed: %.2f', opts.silence_speed))
end

function silenceSpeedup()
    updateOldSpeed()
    setSilenceSpeed(opts.silence_speed * opts.speed_mult)
    showSilenceSpeed()
end

function silenceSlowdown()
    updateOldSpeed()
    setSilenceSpeed(opts.silence_speed / opts.speed_mult)
    showSilenceSpeed()
end

function updateOldSpeed()
    if doing_silence then
        old_speed = old_speed * getSpeed() / opts.silence_speed
    end
end

function showQuietness()
    mp.commandv("show-text", string.format('Silence quietness: %2ddB', opts.quietness))
end

function quietnessUp()
    opts.quietness = opts.quietness + opts.quietness_inc
    setAudioFilterParams()
    showQuietness()
end

function quietnessDown()
    opts.quietness = opts.quietness - opts.quietness_inc
    setAudioFilterParams()
    showQuietness()
end

options.read_options(opts)
init()

mp.observe_property('af-metadata/' .. script_name, 'string', foundSilence)
mp.add_key_binding('Ctrl+M', 'toggle-skip-silence', toggleKeypress)
mp.add_key_binding('Ctrl+]', 'silence-speedup', silenceSpeedup)
mp.add_key_binding('Ctrl+[', 'silence-slowdown', silenceSlowdown)
mp.add_key_binding('Ctrl+}', 'silence-quietnessup', quietnessUp)
mp.add_key_binding('Ctrl+{', 'silence-quietnessdown', quietnessDown)
