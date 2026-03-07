#!/usr/bin/env bash
set -euo pipefail

apt-get update && apt-get install -y --no-install-recommends \
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
    unzip \
    && rm -rf /var/lib/apt/lists/*

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

./aws/install

rm -rf awscliv2.zip aws/