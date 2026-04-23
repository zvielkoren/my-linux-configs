#!/bin/bash
# 🚀 Zviel's Quick Install Script
# Restores all configurations and documentation from the Git repo

REPO_DIR="$HOME/docs"
CONF_DIR="$HOME/.config"

echo "🔧 Starting installation..."

# Create config dir if missing
mkdir -p "$CONF_DIR"

# Symlink configurations
configs=("hypr" "waybar" "kitty" "rofi" "wofi" "dunst")

for folder in "${configs[@]}"; do
    if [ -d "$REPO_DIR/config/$folder" ]; then
        echo "🔗 Linking $folder..."
        # Backup existing if it's not a link
        if [ -d "$CONF_DIR/$folder" ] && [ ! -L "$CONF_DIR/$folder" ]; then
            mv "$CONF_DIR/$folder" "$CONF_DIR/${folder}_backup_$(date +%F_%T)"
        fi
        ln -sfn "$REPO_DIR/config/$folder" "$CONF_DIR/$folder"
    fi
done

# Ensure scripts are executable
chmod +x "$REPO_DIR/config/hypr/scripts/"*.sh

# Add aliases to .bashrc and .zshrc if they don't exist
for shell_conf in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if [ -f "$shell_conf" ]; then
        if ! grep -q "alias doc=" "$shell_conf"; then
            echo "alias doc='$REPO_DIR/config/hypr/scripts/docs_view.sh'" >> "$shell_conf"
            echo "✅ Added 'doc' alias to $(basename "$shell_conf")"
        fi
    fi
done

echo "🎉 Installation complete! Restart Hyprland to see changes."
