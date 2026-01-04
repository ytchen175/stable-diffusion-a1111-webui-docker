@echo off
setlocal enabledelayedexpansion

title Stable Diffusion A1111 WebUI Docker

echo ========================================
echo  Stable Diffusion A1111 WebUI Docker
echo ========================================
echo.

docker version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker is not running. Please start Docker Desktop first.
    pause
    exit /b 1
)

set "MODEL_DIR=data\models\Stable-diffusion"
set "HAS_MODEL=0"

if exist "%MODEL_DIR%\*.safetensors" set "HAS_MODEL=1"
if exist "%MODEL_DIR%\*.ckpt" set "HAS_MODEL=1"

if "!HAS_MODEL!"=="0" (
    echo ========================================
    echo  No model found in %MODEL_DIR%
    echo ========================================
    echo.
    echo   [Y] I will place my own model now
    echo   [N] Download SD 1.5 model automatically
    echo.
    set /p CHOICE="Your choice (Y/N): "

    if /i "!CHOICE!"=="Y" (
        echo.
        echo Please place your model file in:
        echo   %CD%\%MODEL_DIR%\
        echo.
        pause

        set "HAS_MODEL=0"
        if exist "%MODEL_DIR%\*.safetensors" set "HAS_MODEL=1"
        if exist "%MODEL_DIR%\*.ckpt" set "HAS_MODEL=1"

        if "!HAS_MODEL!"=="0" (
            echo.
            echo [ERROR] Still no model found. Exiting.
            pause
            exit /b 1
        )
    ) else (
        echo.
        echo Downloading SD 1.5 model...
        echo.
        docker compose --profile download run --rm download
        if errorlevel 1 (
            echo [ERROR] Download failed.
            pause
            exit /b 1
        )
    )
)

docker image inspect sd-a1111-webui:latest >nul 2>&1
if errorlevel 1 (
    echo.
    echo Building Docker image... This may take 10-20 minutes.
    echo.
    docker compose --profile auto build
    if errorlevel 1 (
        echo [ERROR] Build failed.
        pause
        exit /b 1
    )
)

echo.
echo Stopping existing container...
docker compose --profile auto down 2>nul

echo.
echo ========================================
echo  Starting WebUI...
echo  Open: http://localhost:7860
echo  Press Ctrl+C to stop
echo ========================================
echo.

docker compose --profile auto up
