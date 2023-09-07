# Add docker-selenium helm repository
helm repo add docker-selenium https://www.selenium.dev/docker-selenium

# Update charts from docker-selenium repo
helm repo update
kubectl create namespace qa
helm upgrade --install -n qa selenium-grid docker-selenium/selenium-grid --set isolateComponents=true

kubectl apply -f keda_selenium_trigger.yaml