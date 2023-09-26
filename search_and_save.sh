#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <filename> <word>"
    exit 1
fi

filename="$1"
word="$2"

if [ ! -f "$filename" ]; then
    echo "The file '$filename' does not exist."
    exit 1
fi

# Extract the folder path and file extension
file_path="$(dirname "$filename")"
file_extension="${filename##*.}"

# Create the output filename using the word and the original extension
output_filename="${file_path}/${word}.${file_extension}"

# Use grep to search for the word in the file and redirect the output to the output file
grep -F "$word" "$filename" > "$output_filename"

if [ $? -eq 0 ]; then
    echo "Content containing '$word' saved to '$output_filename'."
else
    echo "The word '$word' was not found in the file '$filename'."
fi
