#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <input_file> <old_word> <new_word>"
    exit 1
fi

input_file="$1"
old_word="$2"
new_word="$3"

if [ ! -f "$input_file" ]; then
    echo "The input file '$input_file' does not exist."
    exit 1
fi

# Extract the folder path and file extension
file_path="$(dirname "$input_file")"
file_extension="${input_file##*.}"

# Create the output filename using the same name as the input file
output_file="${file_path}/${new_word}.${file_extension}"

# Use sed to replace old_word with new_word in the input file and save it to the output file
sed "s/$old_word/$new_word/g" "$input_file" > "$output_file"

echo "Word '$old_word' replaced with '$new_word' in the new file '${output_file}'."
