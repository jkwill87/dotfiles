#!/bin/bash

while IFS= read -r -d '' file; do
    TITLE=`ffprobe -loglevel 8 -show_entries format_tags=Title -of default=noprint_wrappers=1:nokey=1 "$file"`
    if [ ! -z "$TITLE" ]; then
        echo $TITLE
        mkvpropedit  "$file" -e info -s title=""
    fi
done < <(fd --extension mkv --print0)
