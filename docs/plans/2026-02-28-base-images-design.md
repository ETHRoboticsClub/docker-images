# Base Docker Images for RL Robotics Team

## Goal

Provide base Docker images for the RL Robotics team to use on Kubernetes. Two images: one for PyTorch workloads, one for JAX workloads. Both include CUDA.

## Base Images

- **PyTorch**: `pytorch/pytorch:2.10.0-cuda13.0-cudnn9-runtime`
- **JAX**: `nvcr.io/nvidia/jax:26.02-py3`

## Repo Structure

```
docker-images/
├── pytorch/
│   └── Dockerfile
├── jax/
│   └── Dockerfile
├── .github/
│   └── workflows/
│       └── build-push.yml
└── README.md
```

## What Each Dockerfile Adds

- System utilities: `git`, `tmux`, `vim`, `htop`, `curl`, `wget`
- Non-root user for k8s pod security
- Image labels (maintainer, source repo, base image)

## CI/CD

- GitHub Actions workflow builds both images on push to `main` and on version tags
- Pushes to GitHub Container Registry:
  - `ghcr.io/ethroboticsclub/pytorch:latest`
  - `ghcr.io/ethroboticsclub/jax:latest`

## Registry

GitHub Container Registry (`ghcr.io`)
