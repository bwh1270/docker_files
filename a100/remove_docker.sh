#!/usr/bin/env bash

# 1) 실행 중인 컨테이너 모두 종료
sudo docker ps -aq | xargs -r sudo docker stop
sudo docker ps -aq | xargs -r sudo docker rm

# 2) Docker 패키지 제거
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker.io

# 3) NVIDIA Docker 관련 패키지 제거
sudo apt-get purge -y nvidia-docker2 nvidia-container-toolkit nvidia-container-runtime

# 4) 사용하지 않는 패키지/의존성 정리
sudo apt-get autoremove -y
sudo apt-get autoclean -y

# 5) 남아 있는 Docker 데이터 삭제 (⚠️ 이미지/볼륨 다 날아감)
sudo rm -rf /var/lib/docker /var/lib/containerd

