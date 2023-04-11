IMAGE=thetorproject/snowflake-proxy

.PHONY: tag
tag:
	@[ "${VERSION}" ] || ( echo "Env var VERSION is not set."; exit 1 )
	docker tag $(IMAGE) $(IMAGE):$(VERSION)
	docker tag $(IMAGE) $(IMAGE):latest

.PHONY: release
release:
	@[ "${VERSION}" ] || ( echo "Env var VERSION is not set."; exit 1 )
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):latest

.PHONY: build
build:
	docker buildx build --platform linux/amd64,linux/arm64,linux/arm,linux/386,linux/mips,linux/mipsle,linux/mips64,linux/mips64le --build-arg VERSION=$(VERSION) -t $(IMAGE) .

.PHONY: build-and-release
build-and-release:
	docker buildx build --platform linux/amd64,linux/arm64,linux/arm,linux/386,linux/mips,linux/mipsle,linux/mips64,linux/mips64le --build-arg VERSION=$(VERSION) -t $(IMAGE):$(VERSION) -t $(IMAGE):latest --push .

.PHONY: deploy
deploy:
	docker-compose up -d snowflake-proxy
