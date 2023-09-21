# Variables
$SONARQUBE_RELEASE = "sonarqube-release"
$SONARQUBE_LOCAL_PORT = 9000
$KUBE_PROMETHEUS_RELEASE = "kube-prometheus-release"
$KUBE_PROMETHEUS_LOCAL_PORT = 9090
$SONARQUBE_CHART_DIR = "sonarqube"
$KUBE_PROMETHEUS_CHART_DIR = "kube-prometheus-stack"
$SONAR_NAMESPACE = "sonarqube"
$KUBE_PROMETHEUS_NAMESPACE = "monitoring"

# Directory where your Kubeconfig file is located (if needed)
$KUBECONFIG = "~/.kube/config"

# Commands to install Helm charts
$INSTALL_SONARQUBE = "helm install $SONARQUBE_RELEASE $SONARQUBE_CHART_DIR --kubeconfig $KUBECONFIG --namespace $SONAR_NAMESPACE -f $SONARQUBE_CHART_DIR/values.yaml --wait"
$INSTALL_KUBE_PROMETHEUS = "helm install $KUBE_PROMETHEUS_RELEASE $KUBE_PROMETHEUS_CHART_DIR --kubeconfig $KUBECONFIG --namespace $KUBE_PROMETHEUS_NAMESPACE -f $KUBE_PROMETHEUS_CHART_DIR/values.yaml --wait"

# Commands to delete Helm releases
$DELETE_SONARQUBE = "helm delete $SONARQUBE_RELEASE --kubeconfig $KUBECONFIG --namespace $SONAR_NAMESPACE"
$DELETE_KUBE_PROMETHEUS = "helm delete $KUBE_PROMETHEUS_RELEASE --kubeconfig $KUBECONFIG --namespace $KUBE_PROMETHEUS_NAMESPACE"

# Commands for port forwarding#$PORT_FORWARD_SONARQUBE = "kubectl port-forward --kubeconfig $KUBECONFIG $(kubectl get pods --kubeconfig $KUBECONFIG -l app.kubernetes.io/name=$SONARQUBE_RELEASE -o jsonpath='{.items[0].metadata.name}') $SONARQUBE_LOCAL_PORT:$SONARQUBE_LOCAL_PORT --namespace $SONAR_NAMESPACE"
#$PORT_FORWARD_SONARQUBE = "kubectl port-forward --kubeconfig $KUBECONFIG $($(kubectl get pods --kubeconfig $KUBECONFIG -l app.kubernetes.io/name=$SONARQUBE_RELEASE -o jsonpath='{.items[0].metadata.name}')) $SONARQUBE_LOCAL_PORT:$SONARQUBE_LOCAL_PORT --namespace $SONAR_NAMESPACE"
#$PORT_FORWARD_KUBE_PROMETHEUS = "kubectl port-forward --kubeconfig $KUBECONFIG $($(kubectl get pods --kubeconfig $KUBECONFIG -l app.kubernetes.io/name=$KUBE_PROMETHEUS_RELEASE -o jsonpath='{.items[0].metadata.name}')) $KUBE_PROMETHEUS_LOCAL_PORT:$KUBE_PROMETHEUS_LOCAL_PORT --namespace $KUBE_PROMETHEUS_NAMESPACE"

# "help" function to display a list of commands and descriptions
function Show-Help {
    Write-Host "Usage: .\script.ps1 <command>"
    Write-Host ""
    Write-Host "Available commands:"
    Write-Host "  install-sonarqube         Install SonarQube using Helm in the $SONAR_NAMESPACE namespace"
    Write-Host "  delete-sonarqube          Delete SonarQube Helm release in the $SONAR_NAMESPACE namespace"
    Write-Host "  forward-sonarqube         Start SonarQube port forwarding in the $SONAR_NAMESPACE namespace"
    Write-Host "  install-kube-prometheus   Install kube-prometheus-stack using Helm in the $KUBE_PROMETHEUS_NAMESPACE namespace"
    Write-Host "  delete-kube-prometheus    Delete kube-prometheus-stack Helm release in the $KUBE_PROMETHEUS_NAMESPACE namespace"
    Write-Host "  forward-kube-prometheus   Start kube-prometheus-stack port forwarding in the $KUBE_PROMETHEUS_NAMESPACE namespace"
    Write-Host "  help                      Display this list of commands"
}

# Parse command-line arguments
if ($args.Count -eq 0) {
    Show-Help
    exit
}

# Execute the selected command
$command = $args[0]
switch ($command) {
    "install-sonarqube" { Invoke-Expression $INSTALL_SONARQUBE }
    "delete-sonarqube" { Invoke-Expression $DELETE_SONARQUBE }
    "forward-sonarqube" { Invoke-Expression $PORT_FORWARD_SONARQUBE }
    "install-kube-prometheus" { Invoke-Expression $INSTALL_KUBE_PROMETHEUS }
    "delete-kube-prometheus" { Invoke-Expression $DELETE_KUBE_PROMETHEUS }
    "forward-kube-prometheus" { Invoke-Expression $PORT_FORWARD_KUBE_PROMETHEUS }
    "help" { Show-Help }
    default {
        Write-Host "Invalid command. Use 'help' to see available commands."
    }
}
