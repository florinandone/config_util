#!/bin/bash

# Check if all required arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 input_file old_word new_word"
    exit 1
fi

# Assign command-line arguments to variables
input_file="$1"
old_word="$2"
new_word="$3"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' does not exist."
    exit 1
fi

# Extract the directory and extension from the input file
directory=$(dirname "$input_file")
extension="${input_file##*.}"

# Create the output filename using the new word and the same extension
output_file="${directory}/${new_word}.${extension}"

# Use grep and cat to replace the word and save it to the output file
cat "$input_file" | grep -o '\w*\|[^[:space:]]*' | sed "s/$old_word/$new_word/g" > "$output_file"

# Output confirmation message
echo "Word '$old_word' replaced with '$new_word' in $input_file and saved as $output_file"
