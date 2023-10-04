#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <input_file> <old_word> <new_word> <output_file>"
    exit 1
fi

input_file="$1"
old_word="$2"
new_word="$3"
output_file="$4"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' does not exist."
    exit 1
fi

# Perform the replacement and save the result to the output file
sed "0,/$old_word/s//$new_word/" "$input_file" > "$output_file"

echo "Replacement of '$old_word' with '$new_word' in '$input_file' completed. Result saved in '$output_file'."
