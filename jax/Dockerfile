FROM nvcr.io/nvidia/jax:26.02-py3

LABEL org.opencontainers.image.source="https://github.com/ETHRoboticsClub/docker-images"
LABEL org.opencontainers.image.description="JAX base image for RL Robotics Team"
LABEL maintainer="ETHRoboticsClub"

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    tmux \
    vim \
    htop \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash -u 1000 researcher
USER researcher
WORKDIR /home/researcher
