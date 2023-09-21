# Docker image name
DOCKER_IMAGE_NAME :=erasmolpa/sonarqube-exporter:latest

# Exposed port for the Docker container
DOCKER_EXPOSED_PORT := 9119

# Directory of the Python application
#APP_DIR := sonarqube-exporter/core
PP_DIR := core

# Kaniko configuration
KANIKO_IMAGE := gcr.io/kaniko-project/executor:latest

#DOCKERFILE := sonarqube-exporter/Dockerfile
DOCKERFILE := Dockerfile
CONTEXT_DIR := sonarqube-exporter

# Env Variables for sonar
SONAR_URL := http://localhost:8080
SONAR_USER := admin
SONAR_PASSWORD := admin1

# Helm release name
HELM_RELEASE_NAME := sonarqube-release

# Local port for Helm port forwarding
HELM_LOCAL_PORT := 9000

# Directory where Helm charts are located
HELM_CHART_DIR := chart/sonarqube-exporter

# Commands for building Docker image with Kaniko kubectl delete pod kaniko-build
build-kaniko:
	kubectl run --image=$(KANIKO_IMAGE) kaniko-build \
		--restart=Never \
		--overrides='{"apiVersion":"v1","spec":{"containers":[{"name":"kaniko-build","image":"$(KANIKO_IMAGE)","args":["--dockerfile=$(DOCKERFILE)","--context=$(CONTEXT_DIR)","--destination=$(DOCKER_IMAGE_NAME)"]}]}}'

# Commands for building Docker image with Kaniko kubectl delete pod kaniko-build
build-docker:
	docker build -t $(DOCKER_IMAGE_NAME) .

# Commands for running the Docker container
run-docker:
	docker run -p $(DOCKER_EXPOSED_PORT):$(DOCKER_EXPOSED_PORT) \
  	  -e SONAR_URL=$(SONAR_URL) \
 	  -e SONAR_USER=$(SONAR_USER) \
  	  -e SONAR_PASSWORD=$(SONAR_PASSWORD) \
  	  --rm $(DOCKER_IMAGE_NAME)

# Commands for stopping and removing the running Docker container
stop-docker:
	docker stop $$(docker ps -q --filter ancestor=$(DOCKER_IMAGE_NAME)) || true

# Commands for cleaning up the Docker image
clean-docker:
	docker rmi $(DOCKER_IMAGE_NAME) || true

# Commands for installing Helm chart
install-helm:
	helm install $(HELM_RELEASE_NAME) $(HELM_CHART_DIR) \
		--kubeconfig $(KUBECONFIG) \
		-f $(HELM_CHART_DIR)/values.yaml \
		--wait

# Commands for deleting Helm release
delete-helm:
	helm delete $(HELM_RELEASE_NAME) --kubeconfig $(KUBECONFIG)

# Commands for Helm port forwarding
forward-helm:
	kubectl port-forward --kubeconfig $(KUBECONFIG) \
		$$(kubectl get pods --kubeconfig $(KUBECONFIG) -l app.kubernetes.io/name=$(HELM_RELEASE_NAME) -o jsonpath='{.items[0].metadata.name}') \
		$(HELM_LOCAL_PORT):$(HELM_LOCAL_PORT)

# "help" target to display a list of available commands and descriptions
help:
	@echo "Usage: make <command>"
	@echo ""
	@echo "Available commands:"
	@echo "  build-docker      Build Docker image with Kaniko"
	@echo "  run-docker        Run the Docker container"
	@echo "  stop-docker       Stop and remove the running Docker container"
	@echo "  clean-docker      Clean up the Docker image"
	@echo "  install-helm      Install Helm chart"
	@echo "  delete-helm       Delete Helm release"
	@echo "  forward-helm      Start Helm port forwarding"
	@echo "  help              Display this list of commands"

.PHONY: build-docker run-docker stop-docker clean-docker install-helm delete-helm forward-helm help
