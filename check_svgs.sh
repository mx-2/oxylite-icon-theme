#!/bin/bash

DIRS="actions apps categories devices emblems emotes mimetypes places preferences status ui"
thisdir="$(dirname "$(readlink -f "$0")")"
cd "$thisdir" || exit 1

check_svgs() {
    # shellcheck disable=SC2086
    find $1 -type f -name "*.svg" -print0 | while IFS= read -r -d '' file
    do
        if ! grep -q 'width="256"' "$file"; then
            echo "\"$file\" has incorrect width" | tee /dev/stderr
        fi

        if ! grep -q 'height="256"' "$file"; then
            echo "\"$file\" has incorrect height" | tee /dev/stderr
        fi

        if grep -q 'inkscape:' "$file"; then
            echo "\"$file\" is not a regular SVG" | tee /dev/stderr
        fi

        if grep -q '<svg$' "$file"; then
            echo "\"$file\" needs cleansvg" | tee /dev/stderr
        fi
    done
}

if [[ -n "$(check_svgs "$DIRS")" ]]; then
    exit 1
fi
