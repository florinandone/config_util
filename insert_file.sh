#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <main_file> <file_to_insert> <delimiter>"
    exit 1
fi

main_file="$1"
file_to_insert="$2"
delimiter="$3"

if [ ! -f "$main_file" ]; then
    echo "The main file '$main_file' does not exist."
    exit 1
fi

if [ ! -f "$file_to_insert" ]; then
    echo "The file to insert '$file_to_insert' does not exist."
    exit 1
fi

# Create a temporary file
temp_file=$(mktemp)

# Check if the delimiter exists in the main file
if grep -q "$delimiter" "$main_file"; then
    # Split the main file into two parts using the delimiter
    awk -v d="$delimiter" 'BEGIN {RS=d; ORS=""} NR == 1 {print; exit}' "$main_file" > "$temp_file"
    cat "$file_to_insert" >> "$temp_file"
    awk -v d="$delimiter" 'BEGIN {RS=d; ORS=""} NR > 1 {print d $0}' "$main_file" >> "$temp_file"
else
    # If the delimiter doesn't exist, simply append the content of the file to insert
    cat "$main_file" > "$temp_file"
    echo "$delimiter" >> "$temp_file"
    cat "$file_to_insert" >> "$temp_file"
fi

# Replace the main file with the temporary file
mv "$temp_file" "$main_file"

echo "File '$file_to_insert' inserted into '$main_file' after the delimiter '$delimiter'."
