# Instructions for using the bash script build-and-deploy.sh to build a Docker image and deploy an application

This bash script `build-and-deploy.sh ` automates the process of building a Docker image, sending it to a remote Docker Hub repository and deploying the application to Kubernetes using Helm.

## Using the script

### 1. Cloning the repository and setting up the environment

git clone URL of your repository.git
cd repository folder name

### 2. Running the bash script

./build-and-deploy.sh

### The script will ask you for login information to the Docker Hub (username and password). After that, he will perform the following actions:

Builds a Docker image based on the configuration from the values file.yaml
Will send the Docker image to the Docker Hub
Will deploy the application to Kubernetes using Helm

### Note

Make sure that you have the right environment configured to work with Docker, Kubernetes, and Helm.
Before using the script, make sure that you have the necessary dependencies installed and your environment is ready to work with Docker and Kubernetes.