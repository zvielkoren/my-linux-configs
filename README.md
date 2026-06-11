# 🖥️ Zviel's Linux Configurations & Docs

A fully automated, searchable documentation system and environment manager supporting both KDE Plasma 6 and Hyprland.

## 🚀 Quick Install (One-Liner)

Run this command to install or configure your environment instantly:

```bash
curl -sL getlinux.zviel.com/index.sh | bash
```

*Note: The script will prompt you to choose between **KDE Plasma** or **Hyprland** configuration.*

## 📁 Repository Structure

*   `config/` - Symlinked configurations for Plasma (Kitty, Quickshell) and Hyprland (Waybar, Rofi, Dunst).
*   `*.md` - Searchable documentation library.
*   `install.sh` - The master installation script with environment selection.
*   `sync.sh` - One-word backup script (`sync`).

## ⌨️ Key Workflows

### KDE Plasma Mode
*   **Default Terminal**: Kitty configured with Breeze Dark theme & padding.
*   **Layout Toggle**: `Alt + Shift` for quick Hebrew/English switching.
*   **Desktop UI**: Quickshell custom system status and media widget control.

### Hyprland Mode (Tiling WM)
*   **Open Docs**: `SUPER + D` or `doc`
*   **Search Docs**: `TAB` (inside viewer)
*   **Switch Guide**: `SPACE` (inside viewer)
*   **Open Sidebar**: Click 'Z' on top bar
*   **Emoji Picker**: `SUPER + .`
*   **Sync to Git**: `sync`

## 🛠️ Environment Switcher (Hyprland Only)
Change your system mode on the fly with:
*   `SUPER + Alt + D` - **Dev Mode**
*   `SUPER + Alt + G` - **Gaming Mode**
*   `SUPER + Alt + E` - **Editing Mode**

---
*Maintained by zviel*
