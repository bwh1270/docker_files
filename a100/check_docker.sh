#!/usr/bin/env bash

# Docker 버전
docker --version

# NVIDIA GPU 접근 확인
docker run --rm --gpus all nvidia/cuda:12.8.0-base-ubuntu22.04 nvidia-smi

docker images -a

docker info | grep -i runtime
