DOCKER_IMAGE := rwinfosec-nginx-modsecurity
GIT_VERSION := $(shell git rev-parse HEAD)

docker-build:
	docker build \
	-t ${DOCKER_IMAGE}:${GIT_VERSION} \
	-t ${DOCKER_IMAGE} \
	-f docker/Dockerfile .

run-local:
	cat docker-compose.yml | docker-compose  --project-name simple-web-app -f /dev/stdin up -d
