#!/bin/bash
# Interactive viewer for documentation in ~/docs/

DOC="$HOME/docs/PROACTIVE_GUIDE.md"

show_guide() {
    clear
    if [ ! -f "$DOC" ]; then
        echo -e "\e[1;31mError: File not found: $DOC\e[0m"
        echo -e "Press [SPACE] to select a different file or [Q] to quit."
    else
        echo -e "\e[1;32m📄 Current: $(basename "$DOC")\e[0m"
        echo "--------------------------------"
        glow --pager=false "$DOC"
    fi
    echo ""
    echo -e "\e[1;34m[TAB]\e[0m Search  |  \e[1;33m[SPACE]\e[0m Switch File  |  \e[1;31m[Q]\e[0m Close"
}

search_docs() {
    if [ ! -f "$DOC" ]; then return; fi
    grep -E '^#+ ' "$DOC" | fzf --header "Search Guide Sections" \
        --preview "grep -A 50 {} $DOC | glow -s dark" \
        --preview-window=right:60% --reverse
}

switch_file() {
    # Find all .md files in the docs dir
    SELECTED=$(find "$HOME/docs" -maxdepth 1 -name "*.md" | fzf --header "Select Documentation File" --reverse)
    if [ -n "$SELECTED" ]; then
        DOC="$SELECTED"
    fi
}

# Initial view
show_guide

# Using IFS= to ensure spaces and tabs are captured correctly
while IFS= read -rsn1 key; do
    case "$key" in
        $'\t') 
            search_docs
            show_guide
            ;;
        " ") 
            switch_file
            show_guide
            ;;
        q|Q)
            exit 0
            ;;
    esac
done
