# 🚀 ULTIMATE PROACTIVE GUIDE

This guide contains everything you need to navigate your system at light speed.

## ⌨️ Global Hotkeys (SUPER / mainMod)

| Key Combination | Action |
| :--- | :--- |
| `SUPER + Q` | Open Terminal (**Kitty**) |
| `SUPER + D` | **Open this Guide** (TAB to Search) |
| `SUPER + T` | Open Browser (**Firefox**) |
| `SUPER + E` | Open File Manager (**Thunar**) |
| `SUPER + R` | Open App Launcher (**Rofi**) |
| `SUPER + .` | **Emoji Keyboard** (Wofi-emoji) |
| `SUPER + V` | **Clipboard History** (Cliphist + Wofi) |
| `SUPER + L` | Lock Screen (**Hyprlock**) |
| `SUPER + C` | Close Active Window |
| `SUPER + M` | Exit Hyprland (Logout) |
| `SUPER + [1-9]` | Switch to Workspace 1-9 |
| `SUPER + SHIFT + [1-9]` | Move window to Workspace 1-9 |
| `SUPER + ALT + D` | Switch to **Dev** Environment |
| `SUPER + ALT + G` | Switch to **Gaming** Environment |
| `SUPER + ALT + E` | Switch to **Editing** Environment |
| `SUPER + ALT + C` | Switch to **Custom UI** Environment |
| `SUPER + ALT + H` | Switch to **Cyber/Hacker** Environment |
| `Print Screen` | Screenshot (Select Area -> Clipboard) |

## 🎨 Quickshell & Modern UI

Your system features a custom, high-performance UI built with **Quickshell** (QtQuick/QML).

| Component | Description | Interaction |
| :--- | :--- | :--- |
| **Pill Bar** | Floating top bar with logo and metrics. | Click 'Z' to open Dashboard. |
| **Swisher Sidebar** | MMACK-style animated side dashboard. | Slide-in menu for apps & media. |
| **System Metrics** | Real-time CPU, RAM, and Clock. | Updates every 3 seconds. |
| **App Grid** | Staggered entrance icons for key apps. | Click to launch, auto-closes menu. |
| **Media Controller** | Integrated Playerctl controls. | Play, Pause, Next, Previous. |

### 🔧 UI Commands
*   `pkill quickshell; quickshell` - Restart the UI after edits.
*   `~/.config/quickshell/shell.qml` - The source code for your UI.

## 🛠️ Productivity Boosters (CLI)

| Command | Modern Tool | What it does |
| :--- | :--- | :--- |
| `cd` | `z` / `zoxide` | Jumps to frequent folders. Try `z Downloads` |
| `ls` | `ls` / `eza` | Lists files with icons/colors. Try `ll` or `tree` |
| `cat` | `cat` / `bat` | Reads files with syntax highlighting. |
| `top` | `top` / `btop` | Beautiful system resource monitor. |
| `find` | `fd` | Fast file finder. `fd filename` |
| `man` | `tldr` | Quick cheatsheet for any command. `tldr tar` |
| `Ctrl + R` | `fzf` | Search your command history instantly. |
| `Ctrl + T` | `fzf` | Search and find files in the current folder. |

## 🐍 Python & Dev Commands

| Command | Action |
| :--- | :--- |
| `Python: Select Interpreter` | Switch between Python versions/venvs. |
| `Python: Start Terminal REPL` | Open an interactive Python shell. |
| `Shift + Enter` | Run selected code in the terminal. |
| `npx skills find <topic>` | Search for new AI agent capabilities. |
| `doc` | Render this guide in any terminal. |

## 🔍 Documentation & Search (Meta)

This system is built to be self-documenting and fast.

| Action | Shortcut | Result |
| :--- | :--- | :--- |
| **Open Guide** | `SUPER + D` | Opens this popup window. |
| **Search Mode** | `TAB` | Swaps to fuzzy search (`fzf`) to find specific info. |
| **Preview** | `Auto` | Side-panel shows content as you scroll in search. |
| **Close** | `Q` or `Esc` | Closes the documentation popup. |
| **Edit Guide** | `nano ~/PROACTIVE_GUIDE.md` | Add your own notes here; it updates instantly. |

## 🎬 DaVinci Resolve Pro Tips (Linux)

| Action | Shortcut | Why it's Pro |
| :--- | :--- | :--- |
| **Playback** | `J` `K` `L` | Press `L` or `J` multiple times for fast-forward/rewind. |
| **Ripple Delete** | `Shift + Backspace` | Deletes a clip and closes the gap automatically. |
| **Razor Cut** | `Ctrl + B` | Slices the clip at playhead without changing tools. |
| **Zoom to Fit** | `Shift + Z` | Instantly see your entire timeline. |
| **Full Screen** | `Ctrl + F` | Toggle full-screen preview. |
| **Nudge** | `,` and `.` | Move selected clip frame-by-frame. |

### 🚀 Linux Performance Boosters
*   **Intermediate Codecs:** Linux Resolve (Free) hates H.264. Transcode to **ProRes** or **DNxHR** for buttery smooth editing.
*   **Render Cache:** Set `Playback > Render Cache > Smart`. It pre-renders heavy effects in the background.
*   **Proxy Media:** Right-click clips -> `Generate Proxy Media` for 4K editing on older hardware.
*   **GPU Mode:** In Preferences, manually set GPU to **CUDA** (Nvidia) or **OpenCL** (AMD) instead of "Auto".

## 📦 System Maintenance (Arch Linux)

| Task | Command |
| :--- | :--- |
| Update Everything | `sudo pacman -Syu` |
| Install a Package | `sudo pacman -S <name>` |
| Search for Package | `pacman -Ss <query>` |
| Clean Package Cache | `sudo pacman -Sc` |
| Check Disk Usage | `df -h` |
| View System Logs | `journalctl -xe` |

## 🔄 Quick Restore (New Machine)
To install this entire setup on a new machine:
```bash
curl -sL https://getlinux.zviel.com/install.sh | bash
```
```

---
*Maintained by zviel*
