#!/bin/bash
# 🚀 Zviel's Quick Install Script (Plasma & Hyprland Edition)

REPO_DIR="$HOME/docs"
CONF_DIR="$HOME/.config"

# If folder exists, update it. If not, clone it.
if [ -d "$REPO_DIR" ]; then
    echo "📂 Directory exists. Updating..."
    cd "$REPO_DIR" && git pull
else
    echo "📥 Cloning repository..."
    gh repo clone zvielkoren/my-linux-configs "$REPO_DIR"
fi

cd "$REPO_DIR" || exit

echo "============================================="
echo "⚙️ Select Desktop Environment to Configure:"
echo "============================================="
echo "1) KDE Plasma (Default Terminal: Kitty, Breeze Dark theme, Alt+Shift layout)"
echo "2) Hyprland (Tiling window manager setup with waybar, dunst, rofi)"
read -r -p "Enter selection [1 or 2]: " choice

# Default to Plasma if invalid choice
if [[ "$choice" != "1" && "$choice" != "2" ]]; then
    echo "⚠️ Invalid selection. Defaulting to KDE Plasma."
    choice="1"
fi

if [ "$choice" = "1" ]; then
    echo "💎 Configuring KDE Plasma..."
    
    # 1. Install/Ensure Plasma & KDE cli tools & Kitty & Quickshell are installed
    if command -v pacman &> /dev/null; then
        echo "📦 Installing required packages..."
        sudo pacman -S --needed --noconfirm plasma-desktop kde-cli-tools kitty quickshell
    fi
    
    # 2. Symlink configurations relevant to Plasma
    configs=("kitty" "quickshell")
    for folder in "${configs[@]}"; do
        if [ -d "$REPO_DIR/config/$folder" ]; then
            echo "🔗 Linking $folder..."
            if [ -d "$CONF_DIR/$folder" ] && [ ! -L "$CONF_DIR/$folder" ]; then
                mv "$CONF_DIR/$folder" "$CONF_DIR/${folder}_backup_$(date +%F_%T)"
            fi
            ln -sfn "$REPO_DIR/config/$folder" "$CONF_DIR/$folder"
        fi
    done
    
    # 3. Configure defaults via kwriteconfig6 if available
    if command -v kwriteconfig6 &> /dev/null; then
        echo "🔧 Setting Kitty as default terminal..."
        kwriteconfig6 --file kdeglobals --group General --key TerminalApplication kitty --notify
        kwriteconfig6 --file kdeglobals --group General --key TerminalService kitty.desktop --notify
        
        echo "🔧 Setting Alt+Shift layout switching..."
        kwriteconfig6 --file kxkbrc --group Layout --key Options grp:alt_shift_toggle --notify
    fi
    
    # 4. Copy customized Breeze Dark config to kitty
    echo "🎨 Ensuring Breeze Dark Kitty theme is applied..."
    mkdir -p "$CONF_DIR/kitty"
    cp "$REPO_DIR/config/kitty/kitty.conf" "$CONF_DIR/kitty/kitty.conf"

else
    echo "🌀 Configuring Hyprland..."
    
    # 1. Install Hyprland packages
    if command -v pacman &> /dev/null; then
        echo "📦 Installing required packages..."
        sudo pacman -S --needed --noconfirm hyprland waybar dunst rofi wofi kitty quickshell playerctl brightnessctl wireplumber
    fi
    
    # 2. Symlink all configurations
    configs=("hypr" "waybar" "kitty" "rofi" "wofi" "dunst" "quickshell")
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
fi

chmod +x "$REPO_DIR/sync.sh"
chmod +x "$REPO_DIR/install.sh"

# Add aliases
for shell_conf in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if [ -f "$shell_conf" ]; then
        if [ "$choice" = "2" ]; then
            grep -q "alias doc=" "$shell_conf" || echo "alias doc='$REPO_DIR/config/hypr/scripts/docs_view.sh'" >> "$shell_conf"
        fi
        grep -q "alias sync=" "$shell_conf" || echo "alias sync='$REPO_DIR/sync.sh'" >> "$shell_conf"
        grep -q "alias commit=" "$shell_conf" || echo "alias commit='$REPO_DIR/commit.sh'" >> "$shell_conf"
        echo "✅ Updated $(basename "$shell_conf")"
    fi
done

echo "🎉 Installation complete!"
