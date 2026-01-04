# Stable Diffusion A1111 WebUI Docker

**[English](README.md)** | 繁體中文

使用 Docker 輕鬆部署 [AUTOMATIC1111 Stable Diffusion WebUI](https://github.com/AUTOMATIC1111/stable-diffusion-webui)。

> 基於 [AbdBarho/stable-diffusion-webui-docker](https://github.com/AbdBarho/stable-diffusion-webui-docker)

## 功能特色

- 一鍵設定與啟動
- 自動下載 SD 1.5 模型或使用自己的模型
- 主機掛載 volumes，方便管理模型、擴充套件和輸出
- 常用操作無需進入容器
- 預設配置 NVIDIA GPU 與 CUDA 12.1

| 文生圖 | 圖生圖 | 額外處理 |
|--------|--------|----------|
| ![](https://user-images.githubusercontent.com/24505302/189541954-46afd772-d0c8-4005-874c-e2eca40c02f2.jpg) | ![](https://user-images.githubusercontent.com/24505302/189541956-5b528de7-1b5d-479f-a1db-d3f5a53afc59.jpg) | ![](https://user-images.githubusercontent.com/24505302/189541957-cf78b352-a071-486d-8889-f26952779a61.jpg) |

---

## 快速開始

### 1. Clone

```bash
git clone https://github.com/your-repo/stable-diffusion-a1111-webui-docker.git
cd stable-diffusion-a1111-webui-docker
```

### 2. 執行

**Windows:**
```
雙擊 webui-user.bat
```

**Linux/Mac:**
```bash
./webui-user.sh
```

腳本會：
1. 檢查模型是否存在
2. 如果沒有模型，詢問你要：
   - **[Y]** 放置自己的模型，然後繼續
   - **[N]** 自動下載 SD 1.5 模型
3. 建置 Docker 映像（僅首次，約 10-20 分鐘）
4. 啟動 WebUI

### 3. 存取

開啟瀏覽器: http://localhost:7860

按 `Ctrl+C` 停止。

---

## 資料夾結構

```
stable-diffusion-a1111-webui-docker/
├── data/
│   ├── models/
│   │   ├── Stable-diffusion/       # Checkpoint 模型
│   │   ├── VAE/                    # VAE 模型
│   │   ├── Lora/                   # LoRA 模型
│   │   ├── ControlNet/             # ControlNet 模型
│   │   └── hypernetworks/          # Hypernetworks
│   ├── embeddings/                 # Embeddings
│   └── config/auto/
│       └── extensions/             # 在此 git clone 擴充套件
├── output/                         # 生成的圖片
├── webui-user.bat                  # Windows 啟動腳本
└── webui-user.sh                   # Linux/Mac 啟動腳本
```

---

## 常用操作

### 安裝擴充套件

```bash
cd data/config/auto/extensions
git clone https://github.com/xxxxx/extension-name.git
```

重啟 WebUI 即可生效。

### 設定 VAE

Settings > Stable Diffusion > SD VAE > 選擇你的 VAE > Apply settings > Reload UI

---

## 疑難排解

### Stability-AI Repository 找不到

修改 `services/AUTOMATIC1111/Dockerfile`：

```dockerfile
# 將這行
RUN . /clone.sh stable-diffusion-stability-ai https://github.com/Stability-AI/stablediffusion.git cf1d67a6fd5ea1aa600c4df58e5b47da45f6bdbf

# 改為
RUN . /clone.sh stable-diffusion-stability-ai https://github.com/joypaul162/Stability-AI-stablediffusion.git f16630a927e00098b524d687640719e4eb469b76
```

然後重新建置: `docker compose --profile auto build`

---

## 其他注意事項

- **GPU**: 需要 NVIDIA GPU 並安裝 Container Toolkit
- **Port**: 預設 7860，可透過 `WEBUI_PORT` 環境變數修改
- **記憶體**: 預設啟用 `--medvram` 和 `--xformers`

## 版本

- AUTOMATIC1111 WebUI: v1.9.4
- PyTorch: 2.3.0
- CUDA: 12.1

---

## 致謝

- [AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui)
- [AbdBarho/stable-diffusion-webui-docker](https://github.com/AbdBarho/stable-diffusion-webui-docker)
