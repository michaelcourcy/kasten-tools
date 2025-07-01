# Goal

This project provides a Dockerfile to build a Docker image based on the kanister tool image. The image includes essential tools for development and operations on kubernetes and kasten, specifically `helm`, `kubectl`, `jq`, `curl`, and `netcat`. 

restic, kopia and kando are provided by the base image `gcr.io/kasten-images/kanister-tools:7.5.1`.

## Limitation 

This image is only for amd64 architecture.

# Building the Docker Image

## Use the default version of each tool defined in the Dockerfile 

To build the Docker image with the default version of each tool defined in the Dockerfile, you can use the following command:

```
docker build --platform linux/amd64 -t michaelcourcy/kasten-tools:8.0.2 .
```

## Change the version of helm, kubectl and kasten

```
HELM_VERSION=3.7.1
KUBECTL_VERSION=1.32.0
KASTEN_VERSION=8.0.2

REGISTRY=docker.io
IMAGE=$REGISTRY/michaelcourcy/kasten-tools
TAG=$KASTEN_VERSION-helm$HELM_VERSION-kubectl$KUBECTL_VERSION

docker build --platform linux/amd64 \
     -t $IMAGE:$TAG \
     --build-arg HELM_VERSION=$HELM_VERSION \
     --build-arg KUBECTL_VERSION=$KUBECTL_VERSION \
     --build-arg KASTEN_VERSION=$KASTEN_VERSION \
     .

# make a simpler tag 
docker tag $IMAGE:$TAG $IMAGE:$KASTEN_VERSION
docker push $IMAGE:$TAG
docker push $IMAGE:$KASTEN_VERION
```

- For `kubectl` version check https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
- For `helm`version check https://github.com/helm/helm/releases 

## Usage

After building the image, you can run it using:

```
docker run -it michaelcourcy/kasten-tools:8.0.2 
```

This will start a shell with the installed tools available for use. But the main usage if for kasten blueprint. 
You can test it in the kasten-io namespace 
```
kubectl -n kasten-io run ktools -it --rm --image michaelcourcy/kasten-tools:8.0.2 --command -- /bin/sh
```

