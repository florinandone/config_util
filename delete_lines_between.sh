#!/bin/bash

# Check if all required arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 input_file start_delimiter end_delimiter"
    exit 1
fi

# Assign command-line arguments to variables
input_file="$1"
start_delimiter="$2"
end_delimiter="$3"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' does not exist."
    exit 1
fi

# Create a temporary file
temp_file=$(mktemp)

# Use sed to delete lines between the start and end delimiters containing spaces
sed "/$start_delimiter/,/$end_delimiter/ s/.*[[:space:]].*//" "$input_file" > "$temp_file"

# Replace the original file with the modified content
mv "$temp_file" "$input_file"

# Output confirmation message
echo "Lines between '$start_delimiter' and '$end_delimiter' containing spaces deleted in $input_file"
