#!/bin/bash

ENV=$1
CONF_DIR="$HOME/.config/hypr"
CURRENT_CONF="$CONF_DIR/current_env.conf"

case $ENV in
    dev)
        ln -sf "$CONF_DIR/env_dev.conf" "$CURRENT_CONF"
        notify-send "Environment Switched" "Mode: 🛠️ Developing" -i utilities-terminal
        ;;
    gaming)
        ln -sf "$CONF_DIR/env_gaming.conf" "$CURRENT_CONF"
        notify-send "Environment Switched" "Mode: 🎮 Gaming & Streaming" -i controller
        ;;
    editing)
        ln -sf "$CONF_DIR/env_editing.conf" "$CURRENT_CONF"
        notify-send "Environment Switched" "Mode: 🎬 Editing" -i video-x-generic
        ;;
    *)
        echo "Usage: $0 {dev|gaming|editing}"
        exit 1
        ;;
esac

# Reload Hyprland config
hyprctl reload
