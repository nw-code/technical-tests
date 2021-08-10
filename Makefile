IMAGE_TAG := 0.1.0
export IMAGE_TAG

ifndef DOCKER_HUB_REPO
        $(error DOCKER_HUB_REPO is not set)
endif

ifndef DOCKER_HUB_TOKEN
        $(error DOCKER_HUB_TOKEN is not set)
endif

ifndef DOCKER_HUB_USERNAME
        $(error DOCKER_HUB_USERNAME is not set)
endif

.PHONY: apply
apply: manifests/kustomization.yaml
	kubectl apply --kustomize manifests

.PHONY: build
build:
	docker build -t $(DOCKER_HUB_REPO):$(IMAGE_TAG) .

.PHONY: clean
clean:
	rm -f manifests/kustomization.yaml

.PHONY: login
login:
	@docker login -u $(DOCKER_HUB_USERNAME) -p $(DOCKER_HUB_TOKEN)

.PHONY: manifests/kustomization.yaml
manifests/kustomization.yaml:
	scripts/gen_kustomization.yaml > $@

.PHONY: push
push: login
	docker push $(DOCKER_HUB_REPO):$(IMAGE_TAG)
