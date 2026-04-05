#!/data/data/com.termux/files/usr/bin/bash

# CONFIG: Set your full paths here
SOURCE_DIR="/data/data/com.termux/files/home/storage/downloads/d-videos"
TARGET_DIR="/data/data/com.termux/files/home/storage/downloads/d-audio"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

echo "Checking for new videos in $SOURCE_DIR..."

# Loop through mp4, mkv, and webm files
for vid in "$SOURCE_DIR"/*.{mp4,mkv,webm}; do
    # Check if files actually exist to avoid errors
    [ -e "$vid" ] || continue
    
    # Get the filename without the path and extension
    filename=$(basename "$vid")
    basename="${filename%.*}"
    
    # Check if MP3 already exists in target folder
    if [ ! -f "$TARGET_DIR/$basename.mp3" ]; then
        echo "Converting: $filename"
        ffmpeg -i "$vid" -vn -q:a 2 "$TARGET_DIR/$basename.mp3" -y -loglevel quiet
    fi
done

echo "Auto-conversion complete."

