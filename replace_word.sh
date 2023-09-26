#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <filename> <searchword> <replaceword>"
    exit 1
fi

filename="$1"
searchword="$2"
replaceword="$3"

# Call the search_and_save.sh script to create the new file
./search_and_save.sh "$filename" "$searchword"

# Check if the search_and_save.sh script was successful
if [ $? -eq 0 ]; then
    # Replace the searchword with replaceword in the new file
    sed -i "s/$searchword/$replaceword/g" "${searchword}.${filename##*.}"
    echo "Word '$searchword' replaced with '$replaceword' in the new file."
else
    echo "Error occurred while creating the new file with searchword."
fi
