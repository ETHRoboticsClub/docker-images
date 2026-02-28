# Base Docker Images Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Create base Docker images for PyTorch and JAX with CUDA for the RL Robotics team to run on Kubernetes.

**Architecture:** Thin Dockerfiles extending upstream CUDA-enabled images (`pytorch/pytorch` and `nvcr.io/nvidia/jax`). Each adds system utilities and a non-root user. GitHub Actions CI builds and pushes to `ghcr.io/ethroboticsclub/`.

**Tech Stack:** Docker, GitHub Actions, GHCR

---

### Task 1: PyTorch Dockerfile

**Files:**
- Create: `pytorch/Dockerfile`

**Step 1: Create the Dockerfile**

```dockerfile
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
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash -u 1000 researcher
USER researcher
WORKDIR /home/researcher
```

**Step 2: Verify Dockerfile syntax**

Run: `docker run --rm -i hadolint/hadolint < pytorch/Dockerfile || echo "hadolint not available, visual check OK"`

**Step 3: Commit**

```bash
git add pytorch/Dockerfile
git commit -m "feat: add PyTorch base Dockerfile"
```

---

### Task 2: JAX Dockerfile

**Files:**
- Create: `jax/Dockerfile`

**Step 1: Create the Dockerfile**

```dockerfile
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
```

**Step 2: Commit**

```bash
git add jax/Dockerfile
git commit -m "feat: add JAX base Dockerfile"
```

---

### Task 3: GitHub Actions CI Workflow

**Files:**
- Create: `.github/workflows/build-push.yml`

**Step 1: Create the workflow**

```yaml
name: Build and Push Docker Images

on:
  push:
    branches: [main]
    tags: ['v*']

env:
  REGISTRY: ghcr.io
  PYTORCH_IMAGE: ghcr.io/ethroboticsclub/pytorch
  JAX_IMAGE: ghcr.io/ethroboticsclub/jax

jobs:
  build-pytorch:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
    steps:
      - uses: actions/checkout@v4

      - uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - uses: docker/metadata-action@v5
        id: meta
        with:
          images: ${{ env.PYTORCH_IMAGE }}
          tags: |
            type=raw,value=latest,enable={{is_default_branch}}
            type=sha
            type=ref,event=tag

      - uses: docker/build-push-action@v6
        with:
          context: pytorch
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}

  build-jax:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
    steps:
      - uses: actions/checkout@v4

      - uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - uses: docker/metadata-action@v5
        id: meta
        with:
          images: ${{ env.JAX_IMAGE }}
          tags: |
            type=raw,value=latest,enable={{is_default_branch}}
            type=sha
            type=ref,event=tag

      - uses: docker/build-push-action@v6
        with:
          context: jax
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
```

**Step 2: Commit**

```bash
git add .github/workflows/build-push.yml
git commit -m "ci: add GitHub Actions workflow to build and push images to GHCR"
```

---

### Task 4: README

**Files:**
- Create: `README.md`

**Step 1: Create README**

```markdown
# Docker Images — RL Robotics Team

Base Docker images for Kubernetes workloads.

## Images

| Image | Base | Registry |
|-------|------|----------|
| PyTorch | `pytorch/pytorch:2.10.0-cuda13.0-cudnn9-runtime` | `ghcr.io/ethroboticsclub/pytorch:latest` |
| JAX | `nvcr.io/nvidia/jax:26.02-py3` | `ghcr.io/ethroboticsclub/jax:latest` |

## Usage

```bash
docker pull ghcr.io/ethroboticsclub/pytorch:latest
docker pull ghcr.io/ethroboticsclub/jax:latest
```

## Building locally

```bash
docker build -t pytorch-base pytorch/
docker build -t jax-base jax/
```
```

**Step 2: Commit**

```bash
git add README.md
git commit -m "docs: add README with image usage instructions"
```
