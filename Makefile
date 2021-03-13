DOCKER_IMAGE := rwinfosec-nginx-modsecurity
GIT_VERSION := $(shell git rev-parse HEAD)

docker-build:
	docker build \
	-t ${DOCKER_IMAGE}:${GIT_VERSION} \
	-f docker/Dockerfile .