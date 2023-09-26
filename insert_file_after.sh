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

# Find the line number of the delimiter in the main file
delimiter_line=$(grep -n "$delimiter" "$main_file" | cut -d: -f1)

if [ -n "$delimiter_line" ]; then
    # Insert the content of the file to insert after the delimiter line
    head -n "$delimiter_line" "$main_file" > "$temp_file"
    cat "$file_to_insert" >> "$temp_file"
    tail -n +"$((delimiter_line + 1))" "$main_file" >> "$temp_file"
else
    # If the delimiter doesn't exist, append the content of the file to insert
    cat "$main_file" > "$temp_file"
    cat "$file_to_insert" >> "$temp_file"
fi

# Replace the main file with the temporary file
mv "$temp_file" "$main_file"

echo "File '$file_to_insert' inserted into '$main_file' after the delimiter '$delimiter'."
