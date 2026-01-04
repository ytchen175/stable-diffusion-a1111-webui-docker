# Stable Diffusion A1111 WebUI Docker

**[繁體中文](README_zh-TW.md)** | EN

Run [AUTOMATIC1111 Stable Diffusion WebUI](https://github.com/AUTOMATIC1111/stable-diffusion-webui) on Docker with easy setup.

> Based on [AbdBarho/stable-diffusion-webui-docker](https://github.com/AbdBarho/stable-diffusion-webui-docker)

## Features

- One-click setup and launch
- Auto-download SD 1.5 model or use your own
- Host-mounted volumes for models, extensions, and outputs
- No need to enter the container for common operations
- Pre-configured for NVIDIA GPU with CUDA 12.1

| Text to Image | Image to Image | Extras |
|---------------|----------------|--------|
| ![](https://user-images.githubusercontent.com/24505302/189541954-46afd772-d0c8-4005-874c-e2eca40c02f2.jpg) | ![](https://user-images.githubusercontent.com/24505302/189541956-5b528de7-1b5d-479f-a1db-d3f5a53afc59.jpg) | ![](https://user-images.githubusercontent.com/24505302/189541957-cf78b352-a071-486d-8889-f26952779a61.jpg) |

---

## Quick Start

### 1. Clone

```bash
git clone https://github.com/your-repo/stable-diffusion-a1111-webui-docker.git
cd stable-diffusion-a1111-webui-docker
```

### 2. Run

**Windows:**
```
Double-click webui-user.bat
```

**Linux/Mac:**
```bash
./webui-user.sh
```

The script will:

```
========================================
 Stable Diffusion A1111 WebUI Docker
========================================

========================================
 No model found in data\models\Stable-diffusion
========================================

  [Y] I will place my own model now
  [N] Download SD 1.5 model automatically

Your choice (Y/N):
```

1. Check if models exist
2. If no model found, ask you to:
   - **[Y]** Place your own model, then continue
   - **[N]** Auto-download SD 1.5 model
3. Build Docker image (first time only, ~10-20 min)
4. Start WebUI


### 3. Access

Open browser: http://localhost:7860

Press `Ctrl+C` to stop.

---

## Directory Structure

```
stable-diffusion-a1111-webui-docker/
├── data/
│   ├── models/
│   │   ├── Stable-diffusion/       # Checkpoint models
│   │   ├── VAE/                    # VAE models
│   │   ├── Lora/                   # LoRA models
│   │   ├── ControlNet/             # ControlNet models
│   │   └── hypernetworks/          # Hypernetworks
│   ├── embeddings/                 # Embeddings
│   └── config/auto/
│       └── extensions/             # Git clone extensions here
├── output/                         # Generated images
├── webui-user.bat                  # Windows launcher
└── webui-user.sh                   # Linux/Mac launcher
```

---

## Common Operations

### Install Extensions

```bash
cd data/config/auto/extensions
git clone https://github.com/xxxxx/extension-name.git
```

Restart WebUI to apply.

### Set VAE

Settings > Stable Diffusion > SD VAE > Select your VAE > Apply settings > Reload UI

---

## Troubleshooting

### Stability-AI Repository Not Found

Modify `services/AUTOMATIC1111/Dockerfile`:

```dockerfile
# Change this
RUN . /clone.sh stable-diffusion-stability-ai https://github.com/Stability-AI/stablediffusion.git cf1d67a6fd5ea1aa600c4df58e5b47da45f6bdbf

# To this
RUN . /clone.sh stable-diffusion-stability-ai https://github.com/joypaul162/Stability-AI-stablediffusion.git f16630a927e00098b524d687640719e4eb469b76
```

Then rebuild: `docker compose --profile auto build`

---

## Notes

- **GPU**: Requires NVIDIA GPU with Container Toolkit
- **Port**: Default 7860, change via `WEBUI_PORT` env variable
- **Memory**: `--medvram` and `--xformers` enabled by default

## Version

- AUTOMATIC1111 WebUI: v1.9.4
- PyTorch: 2.3.0
- CUDA: 12.1

---

## Thanks

- [AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui)
- [AbdBarho/stable-diffusion-webui-docker](https://github.com/AbdBarho/stable-diffusion-webui-docker)
