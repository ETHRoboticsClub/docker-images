FROM pytorch/pytorch:2.10.0-cuda13.0-cudnn9-runtime

LABEL org.opencontainers.image.source="https://github.com/ETHRoboticsClub/docker-images"
LABEL org.opencontainers.image.description="PyTorch base image for RL Robotics Team"
LABEL maintainer="ETHRoboticsClub"

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    tmux \
    vim \
    htop \
    curl \
    wget \
    ffmpeg \
    cmake \
    build-essential \
    pkg-config \
    libavformat-dev \
    libavcodec-dev \
    libavdevice-dev \
    libavutil-dev \
    libswscale-dev \
    libswresample-dev \
    libavfilter-dev \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash researcher
USER researcher
WORKDIR /home/researcher
