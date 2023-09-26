#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <main_file> <insert_file> <delimiter>"
    exit 1
fi

main_file="$1"      # The file where you want to insert content
insert_file="$2"    # The file you want to insert
delimiter="$3"      # The delimiter

# Check if the main file exists
if [ ! -e "$main_file" ]; then
    echo "Main file '$main_file' does not exist."
    exit 1
fi

# Check if the delimiter is found in the main file
if ! grep -q "$delimiter" "$main_file"; then
    echo "Delimiter '$delimiter' not found in the main file."
    exit 1
fi

# Find the line number of the first occurrence of the delimiter in the main file
line_number=$(grep -n "$delimiter" "$main_file" | head -n 1 | cut -d ":" -f 1)

# Create a temporary file for the updated content
temp_file="temp_main.txt"

# Split the main file into two parts: before and after the delimiter
head -n "$line_number" "$main_file" > "$temp_file"
tail -n +$((line_number + 1)) "$main_file" >> "$temp_file"

# Append the content of the insert file after the delimiter
cat "$insert_file" >> "$temp_file"

# Replace the main file with the temporary file
mv "$temp_file" "$main_file"

echo "Content inserted successfully."
