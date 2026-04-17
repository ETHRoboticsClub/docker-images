FROM pytorch/pytorch:2.10.0-cuda13.0-cudnn9-runtime

LABEL org.opencontainers.image.source="https://github.com/ETHRoboticsClub/docker-images"
LABEL org.opencontainers.image.description="PyTorch base image for RL Robotics Team"
LABEL maintainer="ETHRoboticsClub"

COPY install-shared.sh /tmp/install-shared.sh
RUN chmod +x /tmp/install-shared.sh && /tmp/install-shared.sh && rm /tmp/install-shared.sh
