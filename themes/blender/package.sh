#! /usr/bin/env bash
set -euo pipefail

DIR=$(dirname $(realpath $0))
FILES=("Tokyo_Night.xml" "blender_manifest.toml")
FILENAME="tokyonight_blender.zip"
MISSING=()

for f in "${!FILES[@]}"; do
    file="$DIR/${FILES[f]}"
    if ! [[ -e "$file" ]]; then
        MISSING+=(${FILES[f]})
    fi
    FILES[f]=$file
done

if [[ ${#MISSING[@]} -gt 0 ]]; then
    echo "The following files cannot be found:"
    for file in "${MISSING[@]}"; do
        printf "\t$file\n"
    done
    exit 1
fi

zip -q "$DIR/$FILENAME" "${FILES[@]}"
echo "Successfully packaged '$FILENAME'."
exit 0
