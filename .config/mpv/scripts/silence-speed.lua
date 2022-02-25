-- Stolen and modified from https://github.com/aidangoettsch/mpv-silence-speed

utils = require 'mp.utils'

skip = false
-- Max noise (dB) and min silence duration (s) to trigger
opts = { quietness = -30, duration = 1/6, end_offset = 1, silence_speed = 5 }

silence_start = 0
silence_end = 0
silence_end_off = 0
in_silence = false
prev_speed = 1

function setOptions()
    local options = require 'mp.options'
    options.read_options(opts)
end

function setSpeed(speed)
    -- mp.commandv("show-text", 'Speeding up: ' .. speed, 1000)
    mp.set_property('speed', speed)
end

function getSpeed()
    return mp.get_property_native('speed')
end

function initAudioFilter()
    local af_table = mp.get_property_native('af')
    table.insert(af_table, 1, {
        enabled = false,
        label   = 'silencedetect',
        name    = 'lavfi',
        params  = { graph = 'silencedetect=noise=' .. opts.quietness .. 'dB:duration=' .. opts.duration }
    })
    -- af_table[#af_table + 1] = {
    --     enabled = false,
    --     label   = 'silencedetect',
    --     name    = 'lavfi',
    --     params  = { graph = 'silencedetect=noise=' .. opts.quietness .. 'dB:duration=' .. opts.duration }
    -- }
    mp.set_property_native('af', af_table)
end

function setAudioFilter(enabled)
    local af_table = mp.get_property_native('af')
    if #af_table > 0 then
        for i = #af_table, 1, -1 do
            if af_table[i].label == 'silencedetect' then
                af_table[i].enabled = enabled
                mp.set_property_native('af', af_table)
                break
            end
        end
    end
end

function silenceTrigger(name, value)
    -- mp.commandv("show-text", 'Silence triggered', 10000)
    if value == '{}' or value == nil then
        return
    end
    local silence_data = utils.parse_json(value)
    silence_start = tonumber(silence_data["lavfi.silence_start"])
    silence_end = tonumber(silence_data["lavfi.silence_end"])
    if silence_end == nil then
        silence_end = 0
    end
    -- mp.commandv("show-text", 'Silence triggered: (' .. silence_start .. ', ' .. silence_end .. ')')
    silence_end_off = silence_end - opts.end_offset
end

function playbackTimeTrigger(name, value)
    if value == '{}' or value == nil or not enabled then
        return
    end

    local timestamp = tonumber(value)

    if timestamp < 1 then
        return
    end

    if silence_start < timestamp and (silence_end <= silence_start or timestamp < silence_end_off) then
        if not in_silence then
            in_silence = true
            prev_speed = getSpeed()
        end
        setSpeed(opts.silence_speed)
    else
        if in_silence then
            in_silence = false
            setSpeed(prev_speed)
        end
    end
end

enabled = false

function toggleKeypress()
    enabled = not enabled
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
    opts.silence_speed = opts.silence_speed * 1.10
    showSilenceSpeed()
end

function silenceSlowdown()
    opts.silence_speed = opts.silence_speed / 1.10
    showSilenceSpeed()
end

initAudioFilter()
mp.observe_property('af-metadata/silencedetect', 'string', silenceTrigger)
mp.observe_property('time-pos', 'string', playbackTimeTrigger)
mp.add_key_binding('Ctrl+M', 'toggle-skip-silence', toggleKeypress)
mp.add_key_binding('Ctrl+]', 'silence-speedup', silenceSpeedup)
mp.add_key_binding('Ctrl+[', 'silence-slowdown', silenceSlowdown)
