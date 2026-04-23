# 🖥️ Zviel's Linux Configurations & Docs

A fully automated, searchable documentation system and Hyprland configuration for Arch Linux.

## 🚀 Quick Install (One-Liner)

Run this command to install or update your configurations instantly:

```bash
gh api repos/zvielkoren/my-linux-configs/contents/install.sh -H "Accept: application/vnd.github.v3.raw" | bash
```

*Note: You must have the GitHub CLI (`gh`) installed and be logged in.*

## 📁 Repository Structure

*   `config/` - Symlinked configurations for Hyprland, Waybar, Kitty, etc.
*   `*.md` - Searchable documentation library.
*   `install.sh` - The master installation and symlinking script.
*   `sync.sh` - One-word backup script (`sync`).

## ⌨️ Key Workflows

| Action | Shortcut / Command |
| :--- | :--- |
| **Open Docs** | `SUPER + D` or `doc` |
| **Search Docs** | `TAB` (inside viewer) |
| **Switch Guide** | `SPACE` (inside viewer) |
| **Emoji Picker** | `SUPER + .` |
| **Sync to Git** | `sync` |

## 🛠️ Environment Switcher
Change your system mode on the fly with:
*   `SUPER + Alt + D` - **Dev Mode**
*   `SUPER + Alt + G` - **Gaming Mode**
*   `SUPER + Alt + E` - **Editing Mode**

---
*Maintained by zviel*
