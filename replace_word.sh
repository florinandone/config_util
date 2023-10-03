#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 4 ]; then
  echo "Usage: $0 <input_file> <old_word> <new_word> <output_file>"
  exit 1
fi

# Store the arguments in meaningful variable names
input_file="$1"
old_word="$2"
new_word="$3"
output_file="$4"

# Check if the input file exists
if [ ! -e "$input_file" ]; then
  echo "Error: Input file '$input_file' not found."
  exit 1
fi

# Perform the word replacement and save it to the output file
sed "s/$old_word/$new_word/g" "$input_file" > "$output_file"

echo "Word replacement complete. Output saved to '$output_file'."
