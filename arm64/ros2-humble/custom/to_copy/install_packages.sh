#! /bin/bash

#1#
echo "Start to install necessary packages for ROS and Gazebo..."

wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc | sudo tee /etc/apt/trusted.gpg.d/kitware.asc

apt-get update && apt-get install -q -y \
    apt-utils \
    build-essential \
    bc \
    cmake \
    curl \
    git \
    lsb-release \
    libboost-dev \
    sudo \
    nano \
    net-tools \
    tmux \
    tmuxinator \
    wget \
    ranger \
    htop \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    vim \
    v4l-utils \
#imagemagic    

#2#
echo "Start to move the copied files..." 

mv bash .bashrc
mv aliases .bash_aliases
mv vimrc .vimrc
mv tmux .tmux.conf
mkdir -p .config/ranger
mv ranger .config/ranger/rc.conf
