#!/bin/bash

# Nombre del secreto
SECRET_NAME="sonar-secret"

# Valores de usuario y contraseña
SONAR_USER="admin"
SONAR_PASSWORD="admin1"

# Codificar los valores en base64
BASE64_USER=$(echo -n "$SONAR_USER" | base64)
BASE64_PASSWORD=$(echo -n "$SONAR_PASSWORD" | base64)

# Crear el archivo YAML para el secreto
cat <<EOF > sonar-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: $SECRET_NAME
type: Opaque
data:
  SONAR_USER: $BASE64_USER
  SONAR_PASSWORD: $BASE64_PASSWORD
EOF

# Aplicar el secreto
kubectl apply -f sonar-secret.yaml -n monitoring
