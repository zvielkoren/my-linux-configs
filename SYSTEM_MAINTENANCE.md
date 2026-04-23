# 🛠️ System Maintenance (Arch Linux)

## 📦 Package Management
*   `sudo pacman -Syu` - Full system update.
*   `sudo pacman -S <pkg>` - Install package.
*   `sudo pacman -Rns <pkg>` - Remove package and its unused dependencies.
*   `yay -S <pkg>` - Install from the AUR.

## 🧹 Disk Cleanup
*   `sudo pacman -Sc` - Clean unused package cache.
*   `yay -Sc` - Clean AUR cache.
*   `ncdu /` - Visual disk usage analyzer (Run to find big files).
*   `journalctl --vacuum-time=2weeks` - Clear system logs older than 2 weeks.

## ⚙️ Service Management
*   `systemctl status <service>` - Check if a service is running.
*   `systemctl restart <service>` - Restart a service (e.g., `NetworkManager`).
*   `journalctl -xe` - View recent system errors.
