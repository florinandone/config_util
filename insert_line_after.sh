#!/bin/bash

# Check for the correct number of arguments
if [ $# -ne 3 ]; then
    echo "Usage: $0 <input_file> <keyword> <new_line> <output_file>"
    exit 1
fi

input_file="$1"
keyword="$2"
new_line="$3"
output_file="$4"

# Read the input file line by line
while IFS= read -r line; do
    # Append the current line to the output file
    echo "$line" >> "$output_file"
    
    # Check if the line contains the specified keyword
    if [[ $line == *"$keyword"* ]]; then
        # Insert the new line after the line containing the keyword
        echo "$new_line" >> "$output_file"
    fi
done < "$input_file"

echo "Insertion complete. Check $output_file for the modified content."
