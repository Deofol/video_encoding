#!/bin/bash

read -p "Enter the input directory" input_dir
read -p "Enter the output directory" output_dir

codec="libx264" # Change this to the desired codec
crf="23"        # Constant Rate Factor (adjust as needed)

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Find all video files in the input directory and its subdirectories
find "$input_dir" -type f -name "*.mp4" -o -name "*.mkv" -o -name "*.avi" | while read -r input_file; do
    # Generate the output filename and directory structure
    relative_path="${input_file#$input_dir}"
    output_file="$output_dir${relative_path%.*}.mp4"

    echo "Re-encoding: $input_file"

    # Re-encode the video using ffmpeg
    ffmpeg -i "$input_file" -c:v $codec -crf $crf "$output_file"
done

echo "Re-encoding complete!"
