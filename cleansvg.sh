#!/bin/sh

if ! which svgcleaner; then
    echo "svgcleaner is not installed" >&2
    exit 1
fi

svgcleaner \
    --indent 2 \
    --convert-shapes no \
    --ungroup-defs no \
    --ungroup-groups no \
    --group-by-style no \
    --trim-ids no \
    "$1" "$2"
