#!/bin/bash
# Interactive viewer for PROACTIVE_GUIDE.md with "Tabs" (View/Search)

DOC="$HOME/PROACTIVE_GUIDE.md"

show_guide() {
    clear
    glow "$DOC"
    echo ""
    echo -e "\e[1;34m[TAB]\e[0m Search Docs  |  \e[1;31m[Q]\e[0m Close"
}

search_docs() {
    # Extract headers for searching
    grep -E '^#+ ' "$DOC" | fzf --header "Search Guide Sections (Enter to View)" \
        --preview "grep -A 50 {} $DOC | glow -s dark" \
        --preview-window=right:60%
}

# Initial view
show_guide

while true; do
    read -rsn1 key
    case "$key" in
        $'\t') # Tab key
            search_docs
            show_guide
            ;;
        q|Q)
            exit 0
            ;;
    esac
done
