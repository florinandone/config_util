#!/bin/bash

# Check if all required arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 main_file delimiter insert_file"
    exit 1
fi

# Assign command-line arguments to variables
main_file="$1"
delimiter="$2"
insert_file="$3"

# Check if the main file exists
if [ ! -f "$main_file" ]; then
    echo "Error: Main file '$main_file' does not exist."
    exit 1
fi

# Check if the insert file exists
if [ ! -f "$insert_file" ]; then
    echo "Error: Insert file '$insert_file' does not exist."
    exit 1
fi

# Create a temporary file
temp_file=$(mktemp)

# Use awk to insert the content of the insert file after the delimiter in the main file
awk -v delim="$delimiter" '
    BEGIN { found = 0 }
    $0 == delim { found = 1; print; system("cat insert_file"); next }
    found { print; }
' insert_file="$insert_file" "$main_file" > "$temp_file"

# Replace the original main file with the modified content
mv "$temp_file" "$main_file"

echo "Content from '$insert_file' inserted after the delimiter in '$main_file'."
