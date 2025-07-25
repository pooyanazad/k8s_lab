#!/bin/bash
# deploy-sample-app.sh
# Script to deploy a sample application to the Kubernetes cluster

# Set colors for output
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if the cluster is running
if ! kubectl cluster-info &> /dev/null; then
  echo -e "${RED}Kubernetes cluster is not running. Please run setup-cluster.sh first.${NC}"
  exit 1
fi

# Deploy the sample application
echo -e "${CYAN}Deploying sample NGINX application...${NC}"
kubectl apply -f scenarios/00-sample-deployment/sample-deployment.yaml

# Install NGINX Ingress Controller
echo -e "${CYAN}Installing NGINX Ingress Controller...${NC}"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml

# Wait for the ingress controller to be ready
echo -e "${YELLOW}Waiting for NGINX Ingress Controller to be ready...${NC}"
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

# Check the status of the deployment
echo -e "${CYAN}Checking deployment status...${NC}"
kubectl get deployments
kubectl get services
kubectl get ingress

echo -e "\n${GREEN}Sample application deployed successfully!${NC}"
echo -e "${YELLOW}You can access the NGINX application at http://localhost/${NC}"
echo -e "${YELLOW}Note: It may take a minute for the ingress to be fully configured.${NC}"

echo -e "\n${CYAN}To check the status of the pods, run:${NC}"
echo -e "${YELLOW}kubectl get pods${NC}"

echo -e "\n${CYAN}To delete the sample application, run:${NC}"
echo -e "${YELLOW}kubectl delete -f scenarios/00-sample-deployment/sample-deployment.yaml${NC}"