kubectl create namespace monitoring
helm upgrade --install -n monitoring prometheus kube-prometheus-stack 

