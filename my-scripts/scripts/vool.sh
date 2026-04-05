#!/data/data/com.termux/files/usr/bin/bash

# Database file path
DB="$HOME/vool_db.txt"

# Ensure the database exists
touch "$DB"

# Function to add a word
add_word() {
    read -p "Enter word: " word
    read -p "Enter definition: " def
    echo "$word | $def" >> "$DB"
    echo -e "\n[✔] Added: $word"
}

# Function to search for a word
search_word() {
    read -p "Search for: " query
    echo -e "\n-- Results --"
    grep -i "$query" "$DB" || echo "No matches found."
}

# Function to list all words (alphabetical)
list_words() {
    echo -e "\n-- Your Collection --"
    sort "$DB" | column -t -s "|"
}

# Main Menu
echo "--- Termux Vocab Builder ---"
echo "1) Add Word"
echo "2) Search"
echo "3) List All"
echo "4) Exit"
read -p "Choose an option: " opt

case $opt in
    1) add_word ;;
    2) search_word ;;
    3) list_words ;;
    4) exit ;;
    *) echo "Invalid option." ;;
esac

