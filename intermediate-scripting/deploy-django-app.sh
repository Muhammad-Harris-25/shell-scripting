#!/bin/bash
set -euo pipefail

echo "************* DEPLOYMENT STARTED ********"

APP_DIR="$HOME/shell-scripting/intermediate-scripting/django-notes-app"
IMAGE_NAME="notes-app"
CONTAINER_NAME="notes-app"

# clone on first run (main branch)
if [[ ! -d "$APP_DIR/.git" ]]; then
  git clone -b main https://github.com/LondheShubham153/django-notes-app.git "$APP_DIR"
else
  git -C "$APP_DIR" fetch --all
  git -C "$APP_DIR" reset --hard origin/main
fi

# ensure docker
if ! command -v docker >/dev/null 2>&1; then
  sudo apt-get update -y
  sudo apt-get install -y docker.io
  sudo systemctl enable --now docker
fi

# build in the correct directory (where Dockerfile is)
cd "$APP_DIR"
docker build -t "$IMAGE_NAME" .

# replace existing container
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true
docker run -d --name "$CONTAINER_NAME" -p 8000:8000 "$IMAGE_NAME"

echo "********** DEPLOYMENT DONE **********"
echo "Open: http://<EC2-PUBLIC-IP>:8000"

