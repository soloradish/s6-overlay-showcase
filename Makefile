ACCOUNT_ANAME := "soloradish"
PROJECT_NAME := "s6-overlay-showcase"
PKG := "github.com/$(ACCOUNT_ANAME)/$(PROJECT_NAME)"
PKG_LIST := $(shell go list ${PKG}/...)

GO_FILES := $(shell find . -name '*.go' | grep -v _test.go)
DOCKER_IMAGE_NAME := "$(ACCOUNT_ANAME)/$(PROJECT_NAME)"
DOCKER_IMAGE_TAG := "latest"

.PHONY: all docker_build build

all: build docker_build

ARCH := $(shell if [ `uname -m` = "arm64" ]; then echo "aarch64"; else uname -m; fi)


build:
	@echo "  >  Building binary..."
	@CGO_ENABLED=0 GOOS=linux go build -o .targets/$(PROJECT_NAME) -v

docker_build:
	@echo "  >  Building docker image..."
	@docker build -f s6/simple-with-env/Dockerfile --build-arg ARCH=$(ARCH) -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .

push: docker_build
	@echo "  >  Pushing the Docker image..."
	@docker push $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)

