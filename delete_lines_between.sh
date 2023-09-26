#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <input_file> <start_delimiter> <end_delimiter>"
    exit 1
fi

input_file="$1"       # The file from which lines should be removed
start_delimiter="$2"  # The starting delimiter
end_delimiter="$3"    # The ending delimiter

# Check if the input file exists
if [ ! -e "$input_file" ]; then
    echo "Input file '$input_file' does not exist."
    exit 1
fi

# Create a temporary file for the updated content
temp_file="temp_output.txt"

# Use grep to find the line numbers of the start and end delimiters
start_line=$(grep -n "$start_delimiter" "$input_file" | cut -d ":" -f 1)
end_line=$(grep -n "$end_delimiter" "$input_file" | cut -d ":" -f 1)

# Check if the delimiters were found
if [ -z "$start_line" ] || [ -z "$end_line" ]; then
    echo "Start or end delimiter not found in the input file."
    exit 1
fi

# Copy lines before the start delimiter to the temporary file
head -n "$((start_line - 1))" "$input_file" > "$temp_file"

# Add the start delimiter to the temporary file
echo "$start_delimiter" >> "$temp_file"

# Add the end delimiter to the temporary file
echo "$end_delimiter" >> "$temp_file"

# Copy lines after the end delimiter to the temporary file
tail -n "+$((end_line + 1))" "$input_file" >> "$temp_file"

# Replace the input file with the temporary file
mv "$temp_file" "$input_file"

echo "Lines between '$start_delimiter' and '$end_delimiter' deleted successfully."
