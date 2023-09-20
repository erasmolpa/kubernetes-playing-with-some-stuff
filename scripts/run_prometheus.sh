helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
kubectl create namespace monitoring
helm upgrade --install prometheus -n monitoring ./kube-prometheus-stack 

# for downloading the charts locally 
## helm pull prometheus-community/kube-prometheus-stack --untar 
## helm pull sonarqube/sonarqube --untar
