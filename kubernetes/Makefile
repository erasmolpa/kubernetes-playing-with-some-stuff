AKS_CLUSTER_NAME := my-aks-cluster

AKS_RESOURCE_GROUP := my-aks-rg

AKS_CLUSTER_CONTEXT := $(AKS_CLUSTER_NAME)_$(AKS_RESOURCE_GROUP)

AZ_AUTH := az aks get-credentials --name $(AKS_CLUSTER_NAME) --resource-group $(AKS_RESOURCE_GROUP) --overwrite-existing

SONARQUBE_RELEASE := sonarqube
SONAR_NAMESPACE := sonarqube
SONARQUBE_LOCAL_PORT := 9000

KUBE_PROMETHEUS_RELEASE := kube-prometheus
KUBE_PROMETHEUS_LOCAL_PORT := 9090
KUBE_PROMETHEUS_NAMESPACE := monitoring
# Directorios de los paquetes Helm
SONARQUBE_CHART_DIR := sonarqube
KUBE_PROMETHEUS_CHART_DIR := kube-prometheus-stack

# Directorio donde se encuentra tu archivo de configuración Kubeconfig (si es necesario)
KUBECONFIG := ~/.kube/config

# Commands to install Helm charts
CREATE_NAMESPACE_SONARQUBE := kubectl create namespace $(SONAR_NAMESPACE)
INSTALL_SONARQUBE := helm install $(SONARQUBE_RELEASE) $(SONARQUBE_CHART_DIR) \
    --kubeconfig $(KUBECONFIG) --namespace $(SONAR_NAMESPACE) \
    -f $(SONARQUBE_CHART_DIR)/values.yaml --wait

CREATE_NAMESPACE_PROMETHEUS := kubectl create namespace $(KUBE_PROMETHEUS_NAMESPACE)

INSTALL_KUBE_PROMETHEUS := helm install $(KUBE_PROMETHEUS_RELEASE) $(KUBE_PROMETHEUS_CHART_DIR) \
    --kubeconfig $(KUBECONFIG) --namespace $(KUBE_PROMETHEUS_NAMESPACE) \
    -f $(KUBE_PROMETHEUS_CHART_DIR)/values.yaml --wait

# Commands to delete Helm releases
DELETE_SONARQUBE := helm delete $(SONARQUBE_RELEASE) --kubeconfig $(KUBECONFIG) --namespace $(SONAR_NAMESPACE)
DELETE_KUBE_PROMETHEUS := helm delete $(KUBE_PROMETHEUS_RELEASE) --kubeconfig $(KUBECONFIG) --namespace $(KUBE_PROMETHEUS_NAMESPACE)

# Commands for port forwarding
PORT_FORWARD_SONARQUBE := kubectl port-forward --kubeconfig $(KUBECONFIG) \
    $$(kubectl get pods --kubeconfig $(KUBECONFIG) -l app.kubernetes.io/name=$(SONARQUBE_RELEASE) -o jsonpath='{.items[0].metadata.name}') \
    $(SONARQUBE_LOCAL_PORT):$(SONARQUBE_LOCAL_PORT) --namespace $(SONAR_NAMESPACE)

PORT_FORWARD_KUBE_PROMETHEUS := kubectl port-forward --kubeconfig $(KUBECONFIG) \
    $$(kubectl get pods --kubeconfig $(KUBECONFIG) -l app.kubernetes.io/name=$(KUBE_PROMETHEUS_RELEASE) -o jsonpath='{.items[0].metadata.name}') \
    $(KUBE_PROMETHEUS_LOCAL_PORT):$(KUBE_PROMETHEUS_LOCAL_PORT) --namespace $(KUBE_PROMETHEUS_NAMESPACE)

aks-auth:
	$(AZ_AUTH)
	
install-sonarqube:
	
	$(CREATE_NAMESPACE_SONARQUBE)

	$(INSTALL_SONARQUBE)

delete-sonarqube:
	$(DELETE_SONARQUBE)

forward-sonarqube:
	$(PORT_FORWARD_SONARQUBE)

install-kube-prometheus:
    
	$(CREATE_NAMESPACE_PROMETHEUS)

	$(INSTALL_KUBE_PROMETHEUS)

delete-kube-prometheus:
	$(DELETE_KUBE_PROMETHEUS)

forward-kube-prometheus:
	$(PORT_FORWARD_KUBE_PROMETHEUS)

forward-grafana: 
	kubectl port-forward svc/kube-prometheus-grafana 8088:80 -n monitoring

# "help" target to display a list of commands and descriptions
help:
	@echo "Usage: make <command>"
	@echo ""
	@echo "Available commands:"
	@echo "  install-sonarqube         Install SonarQube using Helm"
	@echo "  delete-sonarqube          Delete SonarQube Helm release"
	@echo "  forward-sonarqube         Start SonarQube port forwarding"
	@echo "  install-kube-prometheus   Install kube-prometheus-stack using Helm"
	@echo "  delete-kube-prometheus    Delete kube-prometheus-stack Helm release"
	@echo "  forward-kube-prometheus   Start kube-prometheus-stack port forwarding"
	@echo "  help                      Display this list of commands"