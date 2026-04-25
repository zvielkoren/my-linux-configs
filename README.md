# 🖥️ Zviel's Linux Configurations & Docs

A fully automated, searchable documentation system and Hyprland configuration for Arch Linux.

## 🚀 Quick Install (One-Liner)

Run this command to install or update your configurations instantly from your custom domain:

```bash
curl -sL getlinux.zviel.com/index.sh | bash
```

*Note: For this to work, ensure your GitHub Pages is set to the `gh-pages` branch.*

## 📁 Repository Structure

*   `config/` - Symlinked configurations for Hyprland, Quickshell, Kitty, etc.
*   `*.md` - Searchable documentation library.
*   `install.sh` - The master installation and symlinking script.
*   `sync.sh` - One-word backup script (`sync`).

## ⌨️ Key Workflows

| Action | Shortcut / Command |
| :--- | :--- |
| **Open Docs** | `SUPER + D` or `doc` |
| **Search Docs** | `TAB` (inside viewer) |
| **Switch Guide** | `SPACE` (inside viewer) |
| **Open Sidebar** | Click 'Z' on top bar |
| **Emoji Picker** | `SUPER + .` |
| **Sync to Git** | `sync` |

## 🛠️ Environment Switcher
Change your system mode on the fly with:
*   `SUPER + Alt + D` - **Dev Mode**
*   `SUPER + Alt + G` - **Gaming Mode**
*   `SUPER + Alt + E` - **Editing Mode**

---
*Maintained by zviel*
