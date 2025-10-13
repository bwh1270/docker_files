# A100 Docker Installation

## Environment

### Check your server
```bash
cat /etc/os-release
docker --version 
which docker
nvidia-smi
```

### Our server
- OS: Ubuntu 22.04.5 (Jammy)
- Docker: 28.4.0 (공식 repo 설치된 최신 Docker CE)
- GPU: NVIDIA A100 (CUDA 12.8, 드라이버 570.172.08)

## Usage
Note: You might add the ```sudo```.

1. If docker has already installed in your server, then remove all.
    ```bash
    ./remove_docker.sh
    ```

2. Install docker and nvidia-toolkit
    ```bash
    ./install_docker.sh
    ```

3. Add user to Docker group
    ```bash
    sudo usermod -aG docker <username>
    newgrp docker
    docker ps
    ```

4. Check the installation
    ```bash
    ./check_docker.sh
    ``` 

5. Add the following line:
    ```bash
    sudo vim /etc/docker/daemon.json
    sudo systemctl restart dockers
    {  
        "runtimes": {  
            "nvidia": {  
                "args": [],  
                "path": "nvidia-container-runtime"  
            }  
        },  
        "exec-opts": ["native.cgroupdriver=cgroupfs"]  
    }
    ```

6. Make the Docker Containder
    ```bash
    bash docker_run.sh <container_name> <image_name>:<tag> <port>
    ```

7. Connect the Code Server
    ```bash
    165.194.11.44:<port>
    ```

8. Make Visualizing Available in Code-server
    1. 크롬에서 ```chrome://flags/#unsafely-treat-insecure-origin-as-secure``` 로 접속
    2. ```http://165.194.11.44:<port>``` 입력 후 재시작


## Usage 2.

- Save docker container to docker image
    '''bash
    # save to image
    docker commit <container_name> <image_name>:<tag>

    # save to .tar and load it
    docker save - o <save_name.tar> <image_name>:<tag>
    docker load -i <save_name.tar>
    '''

- CLI
    '''bash
    docker images
    docker rmi <image_id>

    docker ps -a
    docker stop <container_name>
    docker rm <container_name>


    docker restart <container_name> && docker attach <container_name>
    ctrl+p >> ctrl+q (detach)

    # (tip) in ~/.bash_aliases
    dra() {
        docker restart "$1" && docker attach "$1"
    }
    '''