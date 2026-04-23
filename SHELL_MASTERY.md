# 🐚 Shell Mastery & Bash Tips

## 🏃 Process Management
*   `top` or `btop` - View running processes.
*   `ps aux | grep <name>` - Find a specific process ID (PID).
*   `kill <PID>` - Gracefully stop a process.
*   `kill -9 <PID>` - Force kill a stuck process.
*   `pkill <name>` - Kill all processes by name (e.g., `pkill firefox`).

## 🔍 Searching & Finding
*   `grep -r "text" .` - Search for "text" in all files in current folder.
*   `find . -name "*.log"` - Find all files ending in `.log`.
*   `history | grep <cmd>` - Find a command you ran in the past.

## 📁 File Permissions (The Basics)
*   `chmod +x script.sh` - Make a script executable.
*   `chmod 644 file` - Standard file (Read/Write for you, Read for others).
*   `sudo chown $USER:$USER file` - Take ownership of a file.

## ➡️ Redirection & Pipes
*   `command > file.txt` - Save output to file (Overwrites).
*   `command >> file.txt` - Append output to file.
*   `command 2> error.log` - Save only errors to a file.
*   `ls | wc -l` - Count how many files are in a folder.

## 🪟 PowerShell to Bash (Quick Translation)
| PowerShell Command | Bash (Linux) Equivalent |
| :--- | :--- |
| `irm <url> | iex` | `curl -sL <url> | bash` |
| `ls` or `dir` | `ls` or `eza` |
| `cd` | `cd` or `z` |
| `rm -Recurse -Force` | `rm -rf` |
| `$env:VARIABLE = "val"` | `export VARIABLE="val"` |

## 🛠️ Productivity
*   `alias name='command'` - Create a temporary shortcut.
*   `export PATH=$PATH:/your/path` - Add a folder to your system commands.

---
*Maintained by zviel*
