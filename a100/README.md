# A100 Server Docker

### Tested Environment (AiMS Lab)
- OS: Ubuntu 22.04.5 (Jammy)
- Docker: 28.4.0 (공식 repo 설치된 최신 Docker CE)
- GPU: NVIDIA A100 (CUDA 12.8, 드라이버 570.172.08)

(※) You can check your server following command:
```bash
cat /etc/os-release
docker --version 
which docker
nvidia-smi
```


## Example to set-up 
1. If docker has already installed in your server, then remove all.
    ```bash
    ./remove_docker.sh
    ```

2. Install docker and nvidia-toolkit.
    ```bash
    ./install_docker.sh
    ```

3. Add user to Docker group.
    
    This step let you removing from adding sudo in front of the docker command.
    ```bash
    sudo usermod -aG docker <username>
    newgrp docker
    docker ps
    ```

4. Check the installation.
    ```bash
    ./check_docker.sh
    ``` 

5. Add the following line:
    ```bash
    sudo vim /etc/docker/daemon.json
    {  
        "runtimes": {  
            "nvidia": {  
                "args": [],  
                "path": "nvidia-container-runtime"  
            }  
        },  
        "exec-opts": ["native.cgroupdriver=cgroupfs"]  
    }
    sudo systemctl restart dockers
    ```
    You can save and exit by ```esc:wq``` in vim.

6. If your server has docker image then, make the docker containder.
    ```bash
    bash docker_run.sh <container_name> <image_name>:<tag> <port>
    ```
    Last argument is the port forwarding. That means you can enter the container with this port.

7. Connect the Code Server when it is activated.
    ```bash
    <host_server_ip>:<port>
    ```

8. Make visualizing available in Code-server (e.g., md-preview, image, mp4, etc.)
    1. Go to ```chrome://flags/#unsafely-treat-insecure-origin-as-secure``` in Chrome.
    2. Type ```<host_server_ip>:<port>```, change button available and restart.


## Terminal command
```bash
# check image
docker images

# check container
docker ps -a

# detach container (this is not command but short-key)
ctrl+p >> ctrl+q

# close container 
docker stop <container_name>

# restart and attach
docker restart <container_name> && docker attach <container_name>

# save to image
docker commit <container_name> <image_name>:<tag>

# save to .tar and load it
docker save -o <save_name.tar> <image_name>:<tag>
docker load -i <save_name.tar>

# remove image
docker rmi <image_name>:<tag>
docker rmi <image_id> 

# remove container
docker rm <container_name>
```

### Tips
#### Functions
```bash
vim ~/.bash_aliases
dra() {
    docker restart "$1" && docker attach "$1"
}
```

#### Example of bash run script 
```bash
# >>> WB >>>
parse_git_branch() {
    git branch 2> /dev/null | grep '^*' | sed 's/* //'
}
export PS1="\[\e[0;32m\][\A] \u@:\w\[\e[0;33m\](\$(parse_git_branch))\[\e[m\]\$ "

alias s="source ~/.bashrc"
alias rm='rm -i'

export PATH=/usr/local/cuda-12.2/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.2/lib64:$LD_LIBRARY_PATH
# <<< WB <<<
```