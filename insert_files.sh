#!/bin/bash

# Check if at least three arguments are provided
if [ "$#" -lt 3 ]; then
    echo "Usage: $0 main_file delimiter file1 [file2 file3 ...]"
    exit 1
fi

# Assign command-line arguments to variables
main_file="$1"
delimiter="$2"
shift 2  # Remove the first two arguments from the list

# Check if the main file exists
if [ ! -f "$main_file" ]; then
    echo "Error: Main file '$main_file' does not exist."
    exit 1
fi

# Iterate through the list of files and insert their content after the delimiter
for file in "$@"; do
    if [ ! -f "$file" ]; then
        echo "Warning: File '$file' does not exist. Skipping."
    else
        # Insert the content of the file after the delimiter in the main file
        awk -v delim="$delimiter" '1; $0 == delim {while((getline line < ARGV[1]) > 0) print line; close(ARGV[1])}' "$file" "$main_file" > temp_file
        mv temp_file "$main_file"
        echo "Content from '$file' inserted after the delimiter in '$main_file'."
    fi
done

echo "Insertion complete."
