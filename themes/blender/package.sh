#! /usr/bin/env bash
set -euo pipefail

DIR=$(dirname $(realpath $0))
FILES=("Tokyo_Night.xml" "blender_manifest.toml")
FILENAME="tokyonight_blender.zip"
MISSING=()

cd "$DIR"
for file in "${FILES[@]}"; do
    if ! [[ -e "$file" ]]; then
        MISSING+=($file)
    fi
done

if [[ ${#MISSING[@]} -gt 0 ]]; then
    echo "The following files cannot be found:"
    for file in "${MISSING[@]}"; do
        printf "\t- $file\n"
    done
    exit 1
fi

if zip -q9r "$FILENAME" . -i "${FILES[@]}"; then
    echo "Successfully packaged '$FILENAME'."
    exit 0
fi 
exit 1
