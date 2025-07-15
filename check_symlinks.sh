#!/bin/bash

DIRS="actions apps categories devices emblems emotes mimetypes places status ui"
thisdir="$(dirname "$(readlink -f "$0")")"
cd "$thisdir" || exit 1

check_symlinks() {
    # shellcheck disable=SC2086
    find $1 -type l -name "*.svg" -print0 | while IFS= read -r -d '' file
    do
        target="$(readlink "$file")"
        # shellcheck disable=SC2001
        prefix="$(echo "$file" | sed 's,/[^/]*$,,')"
        if [[ ! -f "$prefix/$target" ]]; then
            echo "Symlink \"$file\" is broken and points to \"$prefix/$target\"" \
                | tee /dev/stderr
        elif [[ -L "$prefix/$target" ]]; then
            echo "Symlink \"$file\" points to other symlink \"$prefix/$target\"" \
                | tee /dev/stderr
        fi
    done
}

if [[ -n "$(check_symlinks "$DIRS")" ]]; then
    exit 1
fi
