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

# Use awk to insert the content after the delimiter
awk -v d="$delimiter" -v insert_file="$file_to_insert" '
    BEGIN { found = 0 }
    /d/ {
        print $0
        if (!found) {
            system("cat " insert_file)
            found = 1
        }
        next
    }
    { print $0 }
' "$main_file" > "$main_file.tmp" && mv "$main_file.tmp" "$main_file"

echo "File '$file_to_insert' inserted into '$main_file' after the delimiter '$delimiter'."
