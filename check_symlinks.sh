#!/bin/bash

DIRS="actions apps categories devices emblems emotes mimetypes places status ui"
thisdir="$(dirname "$(readlink -f "$0")")"
cd "$thisdir"

failed=false

find $DIRS -type l -name "*.svg" -print0 | while IFS= read -r -d '' file; do
    target="$(readlink "$file")"
    prefix="$(echo "$file" | sed 's,/[^/]*$,,')"
    if [[ -L "$prefix/$target" ]]; then
        echo "Symlink \"$file\" points to other symlink \"$prefix/$target\"" >&2
        failed=true
    fi
done

if $failed; then
    exit 1
fi
