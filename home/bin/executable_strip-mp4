#!/bin/bash

while IFS= read -r -d '' file; do
    TITLE=`ffprobe -loglevel 8 -show_entries format_tags=Title -of default=noprint_wrappers=1:nokey=1 "$file"`
    if [ ! -z "$TITLE" ]; then
        echo "$TITLE"
        rm -f /tmp/tmp.mp4
        ffmpeg -nostdin -loglevel panic -i "$file" -c copy -metadata title="" /tmp/tmp.mp4
        mv /tmp/tmp.mp4 "$file"
    fi
done < <(fd --extension mp4 --print0)
