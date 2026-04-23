# 🔗 Resources & Snippets

## 🌐 Useful Links
*   [Hyprland Wiki](https://wiki.hyprland.org)
*   [Arch Wiki](https://wiki.archlinux.org)
*   [DaVinci Resolve Linux Guide](https://www.blackmagicdesign.com/support)

## 💻 CLI Snippets
### Transcode for Resolve (Linux)
```bash
ffmpeg -i input.mp4 -c:v dnxhd -profile:v dnxhr_hq -c:a pcm_s16le output.mov
```

### Clean Package Cache
```bash
sudo pacman -Sc
```
