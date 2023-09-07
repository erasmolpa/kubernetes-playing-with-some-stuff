helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube
helm repo update
kubectl create namespace sonarqube
helm upgrade --install -n sonarqube sonarqube sonarqube/sonarqube


helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
kubectl create namespace monitoring
helm upgrade --install -n monitoring prometheus prometheus-community/kube-prometheus-stack

# for downloading the charts locally 
## helm pull prometheus-community/kube-prometheus-stack --untar 
## helm pull sonarqube/sonarqube --untar