#!/usr/bin/env bash

set -e

DOCKER_REPO="tanayas13"
IMAGE_NAME="my-quizz-ci-cd"

docker run -d --name quizz-app -p 5173:5173 "${DOCKER_REPO}/${IMAGE_NAME}"