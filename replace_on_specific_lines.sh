#!/bin/bash

if [ $# -lt 4 ]; then
    echo "Usage: $0 <file> <old_word> <new_word> <word1> [word2] [word3] ..."
    exit 1
fi

file="$1"
old_word="$2"
new_word="$3"
shift 3 # Remove the first three arguments

if [ ! -f "$file" ]; then
    echo "The file '$file' does not exist."
    exit 1
fi

# Join the specified words into a regex pattern
pattern=$(IFS='|'; echo "$*")

# Use sed to replace old_word with new_word only on lines containing the specified words
sed -i "/\($pattern\)/ s/$old_word/$new_word/g" "$file"

echo "Replacement of '$old_word' with '$new_word' on lines containing '$*' in '$file' completed."
