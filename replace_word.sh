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

# Use sed to replace the word in the input file and save it in place
sed -i "s/\b$old_word\b/$new_word/g" "$input_file"

# Output confirmation message
echo "Word '$old_word' replaced with '$new_word' in $input_file"
