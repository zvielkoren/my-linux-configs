# 🪝 System Hooks & Automation

Technical documentation for the custom scripts and hooks driving your Linux environment.

## 1. Proactive Documentation System (`SUPER + D`)
This system uses a "Hover & Auto-Close" logic.

| Script | Function |
| :--- | :--- |
| `docs_hover.sh` | **The Hook:** Launches the popup and monitors the mouse. If the mouse leaves the window area, it kills the process. |
| `docs_view.sh` | **The UI:** Uses `glow` for markdown rendering and `fzf` for the "TAB Search" feature. |

*   **Hook Logic:** Uses `hyprctl cursorpos` and `hyprctl clients` to calculate if the cursor is within the geometry of the "docs_popup" window.

## 2. Environment Switcher (`SUPER + ALT + [D/G/E]`)
A dynamic configuration loader that swaps system behavior on the fly.

| Hook | Result |
| :--- | :--- |
| `switch_env.sh` | Symlinks different `.conf` files to `current_env.conf` and calls `hyprctl reload`. |

*   **Profiles:**
    *   **Dev:** Optimizes for coding and terminals.
    *   **Gaming:** Disables effects/blur for maximum FPS.
    *   **Editing:** Optimizes color/layout for DaVinci Resolve.

## 3. Emoji & Clipboard (`SUPER + .` / `SUPER + V`)
Integrated Wayland utilities for text manipulation.

*   **Emoji Hook:** `wofi-emoji` -> `wtype`. It doesn't just copy; it simulates keystrokes to "paste" into apps like DaVinci Resolve that might block standard clipboard hooks.
*   **Clipboard Hook:** `wl-paste --watch cliphist store`. A background hook that listens to the Wayland clipboard and stores history in a local database.

---
*Created by zviel*
