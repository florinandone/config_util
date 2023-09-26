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

# Create temporary files for content before and after the delimiter
before_delimiter_file=$(mktemp)
after_delimiter_file=$(mktemp)

# Use awk to process the main file
awk -v d="$delimiter" -v before="$before_delimiter_file" -v after="$after_delimiter_file" '
    BEGIN { found = 0 }
    $0 ~ d {
        found = 1
        next
    }
    {
        if (found == 0) {
            print $0 >> before
        } else {
            print $0 >> after
        }
    }
' "$main_file"

# Concatenate content before, content to insert, and content after
cat "$before_delimiter_file" "$file_to_insert" "$after_delimiter_file" > "$main_file.tmp"
mv "$main_file.tmp" "$main_file"

# Clean up temporary files
rm -f "$before_delimiter_file" "$after_delimiter_file"

echo "File '$file_to_insert' inserted into '$main_file' after the delimiter '$delimiter'."
