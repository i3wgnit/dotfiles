#!/bin/bash
wait_file() {
  local file="$1"; shift
  local wait_seconds="${1:-10}"; shift # 10 seconds as default timeout
  local count=0

  until test $((count++)) -eq $wait_seconds -o -f "$file" ; do sleep 1; done
  echo $count
}

clip=$(xclip -selection c -o)
temp_dir=$(mktemp -d)
trap "rm -Rf -- \"$temp_dir\"" EXIT
cd -- "$temp_dir"
format=${@:-"-F"}
echo "$clip"
echo "$temp_dir"
echo "$format"

if test "-F" = "$format" ; then
    format=""
    /usr/bin/youtube-dl --verbose --list-formats -- "$clip"
    until [ -n "$format" ]; do
        read -a format -p "Format: "
    done
fi

if test "n" != "$format"; then
    /usr/bin/termite -t "youtube-dl" -e "youtube-dl --no-part --format \"$format\" --all-subs -- \"$clip\"" &
    ytdl=$!
    trap "kill $ytdl" EXIT
    echo $ytdl
    file="$()"
    while read -r line; do
        echo $line
        sleep $(wait_file "$file" 99)
        if [ -f "$file" ]; then
            echo Found
        fi
        /usr/bin/mpv --sub-auto=all "$file"
    done < <(youtube-dl --format "$format" --get-filename "$clip")
fi
