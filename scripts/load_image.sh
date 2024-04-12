#!/usr/bin/env bash

set -e

#Docker repository and image name
DOCKER_REPO="tanayas13"
IMAGE_NAME="my-quizz-ci-cd"

# Pull the Docker image from the repository
docker pull "${DOCKER_REPO}/${IMAGE_NAME}"
