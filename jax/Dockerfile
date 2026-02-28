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

RUN if getent passwd 1000 > /dev/null 2>&1; then \
        usermod -l researcher -d /home/researcher -m -s /bin/bash "$(getent passwd 1000 | cut -d: -f1)"; \
    else \
        useradd -m -s /bin/bash -u 1000 researcher; \
    fi
USER researcher
WORKDIR /home/researcher
