# 🌐 Networking & SSH

## 🔍 Connection Info
*   `ip addr` - Show local IP addresses.
*   `curl ifconfig.me` - Show public IP address.
*   `nmcli device wifi list` - List available Wi-Fi networks.

## 🔑 SSH & Remote
*   `ssh-keygen -t ed25519` - Generate a secure SSH key.
*   `ssh-copy-id user@host` - Copy your key to a remote server.
*   `ssh user@ip` - Connect to remote server.

## 📂 File Sharing
### Quick Python Web Server
```bash
python -m http.server 8080
```
(Share files in current folder at `http://your-ip:8080`)

### Copy via SCP
```bash
scp file.zip user@host:/path/to/destination
```
