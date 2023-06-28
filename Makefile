ACCOUNT_NAME := "soloradish"
PROJECT_NAME := "s6-overlay-showcase"
PKG := "github.com/$(ACCOUNT_NAME)/$(PROJECT_NAME)"
PKG_LIST := $(shell go list ${PKG}/...)

GO_FILES := $(shell find . -name '*.go' | grep -v _test.go)
DOCKER_IMAGE_NAME := "ghcr.io/$(ACCOUNT_NAME)/$(PROJECT_NAME)"
DOCKER_IMAGE_TAG := "latest"

.PHONY: all docker_build build

all: build docker_build


build:
	@echo "  >  Building binary..."
	@CGO_ENABLED=0 GOOS=linux go build -o .targets/$(PROJECT_NAME) -v

docker_build:
	@echo "  >  Building docker image..."
	@docker build -f s6/simple-with-env/Dockerfile -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .

	@echo "  >  Building docker image..."
	@docker build -f non-s6/simple-with-env/Dockerfile -t $(DOCKER_IMAGE_NAME)-non-s6:$(DOCKER_IMAGE_TAG) .
