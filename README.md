- pytorch/Dockerfile — base image extending pytorch/pytorch:2.10.0-cuda13.0-cudnn9-runtime   
  - jax/Dockerfile — base image extending nvcr.io/nvidia/jax:26.02-py3                         
  - .github/workflows/build-push.yml — CI that builds & pushes both images to                  
  ghcr.io/ethroboticsclub/ on push to main                  
  - templates/pytorchjob.yaml — PyTorchJob manifest for ArgoCD
 


make sure the Kubeflow Training Operator is installed on your EKS cluster, otherwise the PyTorchJob CRD won't be recognized. Command 4 Check : kubectl get crd pytorchjobs.kubeflow.org 
