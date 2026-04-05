#!/data/data/com.termux/files/usr/bin/bash

# Vocabulary file location
VOCAB_FILE="$HOME/vocab_list.txt"

# Function to add a new word
add_word() {
    echo "$1" >> "$VOCAB_FILE"
    echo "✅ Word '$1' added to your vocabulary list."
}

# Function to list all saved words
list_words() {
    if [ -f "$VOCAB_FILE" ]; then
        echo "📚 Your Vocabulary List:"
        cat -n "$VOCAB_FILE"
    else
        echo "No words saved yet."
    fi
}

# Function to search word meaning using dictionary API
search_word() {
    word=$1
    echo "🔍 Searching meaning for '$word'..."
    curl -s "https://api.dictionaryapi.dev/api/v2/entries/en/$word" | jq '.[0].meanings[0].definitions[0].definition'
}

# Menu
while true; do
    echo -e "\n--- Vocabulary Builder ---"
    echo "1. Add a new word"
    echo "2. List saved words"
    echo "3. Search word meaning"
    echo "4. Exit"
    read -p "Choose an option: " choice

    case $choice in
        1)
            read -p "Enter word: " new_word
            add_word "$new_word"
            ;;
        2)
            list_words
            ;;
        3)
            read -p "Enter word to search: " search
            search_word "$search"
            ;;
        4)
            echo "Goodbye 👋"
            exit 0
            ;;
        *)
            echo "Invalid option. Try again."
            ;;
    esac
done
