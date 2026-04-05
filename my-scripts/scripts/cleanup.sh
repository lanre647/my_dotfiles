#!/bin/bash
# Path to your downloads folder
TARGET="/sdcard/Download"

# Find files older than 1 day (+1) and delete them
# Change +1 to +7 for a week
find "$TARGET" -type f -mtime +1 -delete

termux-toast "Cleanup Complete: Old downloads removed."

