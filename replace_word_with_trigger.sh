#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 5 ]; then
  echo "Usage: $0 <input_file> <trigger_word> <old_word> <new_word> <output_file>"
  exit 1
fi

# Store the arguments in meaningful variable names
input_file="$1"
trigger_word="$2"
old_word="$3"
new_word="$4"
output_file="$5"

# Check if the input file exists
if [ ! -e "$input_file" ]; then
  echo "Error: Input file '$input_file' not found."
  exit 1
fi

# Perform the word replacement and save it to the output file
awk -v trigger="$trigger_word" -v old="$old_word" -v new="$new_word" '{
  if ($0 ~ trigger) {
    gsub(old, new);
  }
  print
}' "$input_file" > "$output_file"

echo "Word replacement complete. Output saved to '$output_file'."
