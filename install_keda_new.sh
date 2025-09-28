#!/bin/bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
    echo "❌ Usage: $0 <resource-group> <aks-cluster>"
    exit 1
fi

RESOURCE_GROUP=$1
CLUSTER_NAME=$2

echo "🔗 Getting credentials for AKS cluster..."
az aks get-credentials -g "$RESOURCE_GROUP" -n "$CLUSTER_NAME" --overwrite-existing

echo "📦 Adding KEDA Helm repo..."
helm repo add kedacore https://kedacore.github.io/charts
helm repo update

echo "✅ Installing/Upgrading KEDA..."
helm upgrade --install keda kedacore/keda \
  --namespace keda \
  --create-namespace \
  --version 2.14.0

echo "⏳ Waiting for KEDA deployments..."
kubectl rollout status deployment/keda-operator -n keda --timeout=180s
kubectl rollout status deployment/keda-admission-webhooks -n keda --timeout=180s
kubectl rollout status deployment/keda-operator-metrics-apiserver -n keda --timeout=180s

echo "🎉 KEDA is ready!"
