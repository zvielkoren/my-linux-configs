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

## 🚀 Custom Domain: get.zviel.com
To make your installer available via your own domain, use a **Cloudflare Worker** with this logic:

```javascript
// Cloudflare Worker for get.zviel.com
addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})

async function handleRequest(request) {
  const GITHUB_TOKEN = "your_personal_access_token";
  const REPO_URL = "https://raw.githubusercontent.com/zvielkoren/my-linux-configs/master/install.sh";
  
  return fetch(REPO_URL, {
    headers: {
      'Authorization': `token ${GITHUB_TOKEN}`,
      'Accept': 'application/vnd.github.v3.raw'
    }
  })
}
```

Once set up, you can install your system with:
`curl -sL get.zviel.com | bash`
