#!/bin/bash

LOG="/tmp/docs_hover.log"
echo "$(date): Starting script" > "$LOG"

# 1. Cleanup
pkill -f "docs_popup"
pgrep -f "docs_hover.sh" | grep -v $$ | xargs kill -9 2>/dev/null
sleep 0.1

# 2. Launch (No pager -p for faster interaction)
kitty --class "docs_popup" --title "Proactive Guide" bash -c "/home/zviel/.config/hypr/scripts/docs_view.sh" &
echo "$(date): Kitty launched" >> "$LOG"

# 3. Find window
ADDR=""
for i in {1..30}; do
    ADDR=$(hyprctl clients -j | jq -r '.[] | select(.class == "docs_popup") | .address' | head -n 1)
    if [ -n "$ADDR" ] && [ "$ADDR" != "null" ]; then break; fi
    sleep 0.1
done

[ -z "$ADDR" ] && exit 1

check_hover() {
    INFO=$(hyprctl clients -j | jq -r ".[] | select(.address == \"$ADDR\")")
    if [ -z "$INFO" ] || [ "$INFO" = "null" ]; then return 2; fi
    WX=$(echo "$INFO" | jq -r '.at[0]')
    WY=$(echo "$INFO" | jq -r '.at[1]')
    WW=$(echo "$INFO" | jq -r '.size[0]')
    WH=$(echo "$INFO" | jq -r '.size[1]')
    CUR=$(hyprctl cursorpos)
    CX=$(echo "$CUR" | cut -d',' -f1 | tr -d ' ')
    CY=$(echo "$CUR" | cut -d',' -f2 | tr -d ' ')
    if (( CX >= WX && CX <= WX + WW && CY >= WY && CY <= WY + WH )); then return 0; else return 1; fi
}

# STAGE 1: Wait for hover
while true; do
    check_hover
    [ $? -eq 0 ] && break
    [ $? -eq 2 ] && exit 0
    sleep 0.1
done

# STAGE 2: Wait for exit
OUT_COUNT=0
while true; do
    check_hover
    STATUS=$?
    if [ $STATUS -eq 2 ]; then exit 0; fi
    if [ $STATUS -eq 1 ]; then
        ((OUT_COUNT++))
        if [ $OUT_COUNT -ge 5 ]; then
            hyprctl dispatch closewindow address:"$ADDR"
            exit 0
        fi
    else
        OUT_COUNT=0
    fi
    sleep 0.1
done
