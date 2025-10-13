#!/usr/bin/env bash
set -Eeuo pipefail

CONTAINER_NAME=$1
IMAGE_NAME=$2
PORT=$3

if [[ -z "$CONTAINER_NAME" || -z "$IMAGE_NAME" || -z "$PORT" ]]; then
  echo "Usage: $0 <container_name> <image> <port>"
  exit 1
fi

SSH_ARGS=()
if [[ -n "${SSH_AUTH_SOCK:-}" ]]; then
  mkdir -p "$HOME/.ssh"
  ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh_auth_sock"
  SSH_ARGS=(-v "$HOME/.ssh/ssh_auth_sock:/ssh-agent" -e SSH_AUTH_SOCK=/ssh-agent)
fi

docker run -it --gpus all \
  --name $CONTAINER_NAME \
  -p ${PORT}:6021 \
  --ipc=host \
  --shm-size=32g \
  --ulimit memlock=-1:-1 \
  --ulimit stack=67108864 \
  "${SSH_ARGS[@]}" \
  -e TZ=Asia/Seoul \
  -e PASSWORD="123" \
  $IMAGE_NAME \
  bash -lc "code-server --bind-addr 0.0.0.0:6021 --auth password /root"
