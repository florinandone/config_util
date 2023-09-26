#!/bin/bash

# Check if all required arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 input_file start_delimiter end_delimiter"
    exit 1
fi

# Assign command-line arguments to variables
input_file="$1"
start_delimiter="$2"
end_delimiter="$3"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' does not exist."
    exit 1
fi

# Create a temporary file
temp_file=$(mktemp)

# Initialize a flag to determine if lines should be deleted
delete_lines=0

# Use a while loop to process the input file line by line
while IFS= read -r line; do
    if [[ $line == *"$start_delimiter"* ]]; then
        # Set the flag to start deleting lines
        delete_lines=1
    fi

    if [ $delete_lines -eq 0 ]; then
        # Preserve lines before the start delimiter
        echo "$line" >> "$temp_file"
    else
        if [[ $line == *"$end_delimiter"* ]]; then
            # Reset the flag when the end delimiter is encountered
            delete_lines=0
        elif [[ $line != *" "* ]]; then
            # Preserve lines without spaces between the delimiters
            echo "$line" >> "$temp_file"
        fi
    fi
done < "$input_file"

# Replace the original file with the modified content
mv "$temp_file" "$input_file"

# Output confirmation message
echo "Lines between '$start_delimiter' and '$end_delimiter' containing spaces deleted in $input_file"
