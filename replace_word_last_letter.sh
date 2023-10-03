#!/bin/bash

# Check if all three parameters are provided
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <input_file> <word> <newLetter>"
  exit 1
fi

# Assign parameters to variables
input_file="$1"
word="$2"
newLetter="$3"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  echo "Error: Input file '$input_file' not found."
  exit 1
fi

# Use sed to replace the last letter of each occurrence of 'word' with 'newLetter'
sed -i "s/$word\(.\)/$newLetter\1/g" "$input_file"

echo "Replacement complete. Updated file: $input_file"
