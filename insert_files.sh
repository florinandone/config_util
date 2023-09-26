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

# Get the directory of the main file
main_dir=$(dirname "$main_file")

# Create a temporary file
temp_file=$(mktemp)

# Prepare a list of files to insert
inserted_files=()

# Iterate through the list of extra files
for extra_file in "$@"; do
    # Construct the full path for the extra file
    full_extra_file="${main_dir}/${extra_file}"
    
    if [ -f "$full_extra_file" ]; then
        inserted_files+=("$full_extra_file")
    else
        echo "Warning: File '$full_extra_file' does not exist. Skipping."
    fi
done

# Use awk to process the main file and insert the content of the extra files after the delimiter
awk -v delim="$delimiter" -v files_to_insert="${inserted_files[*]}" '
    BEGIN { inside_block = 0; file_index = 1 }
    
    # Split the files_to_insert variable into an array
    function split_files(array, str) {
        n = split(str, a)
        for (i = 1; i <= n; i++) {
            array[i] = a[i]
        }
        return n
    }

    # Process each line of the input file
    {
        # Check if the line is the delimiter
        if ($0 == delim) {
            inside_block = 1
            next
        }

        # If inside the delimiter block, insert the content of the next file
        if (inside_block == 1 && file_index <= split_files(files_array, files_to_insert)) {
            while ((getline line < files_array[file_index]) > 0) {
                print line
            }
            close(files_array[file_index])
            file_index++
        }
        
        # Print the current line
        print $0
    }
' "$main_file" > "$temp_file"

# Replace the original main file with the modified content
mv "$temp_file" "$main_file"

echo "Insertion complete."
