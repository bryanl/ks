deploy ?= deploy.env
include $(deploy)
export $(shell sed 's/=.*//' $(deploy))

VERSION=$(shell ./scripts/version.sh)

.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build the container
	docker build -t $(APP_NAME) .

build-nc: ## Build the container without caching
	docker build --no-cache -t $(APP_NAME) .

release: build-nc publish ## Make a release by building and publishing the current version and latest tagged containers to Docker Hub..

publish: publish-latest publish-version ## Publish the current version and latest tagged containers to Docker Hub

publish-latest: tag-latest ## Publish the 'latest' tagged container to Docker Hub
	@echo 'publish latest to Docker Hub'
	docker push $(APP_NAME):latest

publish-version: tag-version ## Publish the current version tagged container to Docker Hub
	@echo 'publish latest to Docker Hub'
	docker push $(APP_NAME):$(VERSION)

tag-latest: ## Generate latest tagged container
	@echo 'create tag latest'
	docker tag $(APP_NAME) $(APP_NAME):latest

tag-version: ## Generate current version tagged container
	@echo 'create tag $(VERSION)'
	docker tag $(APP_NAME) $(APP_NAME):$(VERSION)