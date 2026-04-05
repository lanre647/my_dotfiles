#!/bin/bash
# Path to the folder you want to wipe (change 'SecretFolder' to your target)
TARGET="$HOME/storage/downloads/.folder"

if [ -d "$TARGET" ]; then
 rm -rf "$TARGET"/*
 termux-tts-speak "The package has been burned."
  else
 termux-tts-speak "Target folder not found. Nothing to destroy."
 fi
            
