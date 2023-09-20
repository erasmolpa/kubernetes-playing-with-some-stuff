
helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube
helm repo update
kubectl create namespace sonarqube
helm upgrade --install sonarqube -n sonarqube ./sonarqube 
echo 'for get access to sonar locally, just run the following command --> kubectl port-forward svc/sonarqube-sonarqube -n sonarqube 9000'