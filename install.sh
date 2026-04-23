#!/bin/bash
# 🚀 Zviel's Quick Install Script

REPO_DIR="$HOME/docs"
CONF_DIR="$HOME/.config"

# If folder doesn't exist, clone it first (handling the curl | bash use case)
if [ ! -d "$REPO_DIR" ]; then
    echo "📥 Cloning repository..."
    gh repo clone zvielkoren/my-linux-configs "$REPO_DIR"
fi

cd "$REPO_DIR" || exit

echo "🔧 Starting installation..."

# Create config dir if missing
mkdir -p "$CONF_DIR"

# Symlink configurations
configs=("hypr" "waybar" "kitty" "rofi" "wofi" "dunst")

for folder in "${configs[@]}"; do
    if [ -d "$REPO_DIR/config/$folder" ]; then
        echo "🔗 Linking $folder..."
        if [ -d "$CONF_DIR/$folder" ] && [ ! -L "$CONF_DIR/$folder" ]; then
            mv "$CONF_DIR/$folder" "$CONF_DIR/${folder}_backup_$(date +%F_%T)"
        fi
        ln -sfn "$REPO_DIR/config/$folder" "$CONF_DIR/$folder"
    fi
done

# Ensure scripts are executable
chmod +x "$REPO_DIR/config/hypr/scripts/"*.sh
chmod +x "$REPO_DIR/sync.sh"

# Add aliases
for shell_conf in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if [ -f "$shell_conf" ]; then
        grep -q "alias doc=" "$shell_conf" || echo "alias doc='$REPO_DIR/config/hypr/scripts/docs_view.sh'" >> "$shell_conf"
        grep -q "alias sync=" "$shell_conf" || echo "alias sync='$REPO_DIR/sync.sh'" >> "$shell_conf"
        echo "✅ Updated $(basename "$shell_conf")"
    fi
done

echo "🎉 Installation complete! Type 'doc' to start."
