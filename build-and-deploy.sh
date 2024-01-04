#!/bin/bash

# Reading values from values.yaml
REPOSITORY=$(yq r my-nginx-app/values.yaml 'image.repository')
TAG=$(yq r my-nginx-app/values.yaml 'image.tag')

# Asking user for Docker Hub credentials
read -p "Enter Docker Hub username: " USERNAME
read -s -p "Enter Docker Hub password: " PASSWORD
echo

# Log in to Docker Hub using provided credentials
if ! docker login -u "$USERNAME" -p "$PASSWORD"; then
    echo "Failed to log in to Docker Hub. Exiting."
    exit 1
fi

# Building the Docker image of the server
if ! docker build -t "$REPOSITORY:$TAG" .; then
    echo "Failed to build the Docker image. Exiting."
    exit 1
fi

# Pushing the Docker image to a remote repository
if ! docker push "$REPOSITORY:$TAG"; then
    echo "Failed to push the Docker image. Exiting."
    exit 1
fi

# Set KUBECONFIG environment variable
export KUBECONFIG=~/.kube/config

# Check if KUBECONFIG environment variable is set
if [ -z "$KUBECONFIG" ]; then
    echo "Failed to set KUBECONFIG environment variable. Please configure kubectl to access your cluster."
    exit 1
fi

echo "KUBECONFIG environment variable has been configured. Deploying with Helm."
helm install my-nginx-app ./my-nginx-app
