FROM nvcr.io/nvidia/jax:26.02-py3

LABEL org.opencontainers.image.source="https://github.com/ETHRoboticsClub/docker-images"
LABEL org.opencontainers.image.description="JAX base image for RL Robotics Team"
LABEL maintainer="ETHRoboticsClub"

COPY install-shared.sh /tmp/install-shared.sh
RUN chmod +x /tmp/install-shared.sh && /tmp/install-shared.sh && rm /tmp/install-shared.sh

RUN useradd -m -s /bin/bash runner
USER runner
WORKDIR /home/runner
