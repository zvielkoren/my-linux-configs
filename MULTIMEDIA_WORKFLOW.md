# 🎬 Multimedia & Editing Workflow

## 🎥 FFmpeg Pro Tips
### Transcode for DaVinci Resolve
```bash
ffmpeg -i input.mp4 -c:v prores_ks -profile:v 3 -c:a pcm_s16le output.mov
```

### Quickly Trim a Video (No re-encoding)
```bash
ffmpeg -ss 00:00:10 -i input.mp4 -to 00:00:30 -c copy output.mp4
```

### Extract Audio from Video
```bash
ffmpeg -i video.mp4 -q:a 0 -map a audio.mp3
```

## 📸 Image Manipulation (Magick)
*   `magick image.png image.jpg` - Convert format.
*   `magick input.jpg -resize 50% output.jpg` - Resize image.
*   `magick -density 300 input.pdf output.png` - PDF to Image.

## 🎙️ Audio Control
*   `pavucontrol` - GUI for audio routing.
*   `wpctl status` - Check Pipewire/Wireplumber status.
