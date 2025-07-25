#!/bin/bash
# setup-cluster.sh
# Script to set up a Kubernetes cluster with 1 master and 2 worker nodes using kind

# Set colors for output
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

echo -e "${CYAN}Checking prerequisites...${NC}"

# Check for Docker
if ! command_exists docker; then
  echo -e "${RED}Docker is required but not installed.${NC}"
  echo -e "${YELLOW}Please install Docker and run this script again.${NC}"
  exit 1
fi

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
  echo -e "${RED}Docker is not running. Please start Docker and run this script again.${NC}"
  exit 1
fi

# Install kubectl if not present
if ! command_exists kubectl; then
  echo -e "${YELLOW}Installing kubectl...${NC}"
  
  # Detect OS
  OS="$(uname -s)"
  case "${OS}" in
    Linux*)
      curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
      chmod +x kubectl
      sudo mv kubectl /usr/local/bin/
      ;;
    Darwin*)
      # macOS
      brew install kubectl || {
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"
        chmod +x kubectl
        sudo mv kubectl /usr/local/bin/
      }
      ;;
    *)
      echo -e "${RED}Unsupported operating system: ${OS}${NC}"
      exit 1
      ;;
  esac
fi

# Install kind if not present
if ! command_exists kind; then
  echo -e "${YELLOW}Installing kind...${NC}"
  
  # Detect OS
  OS="$(uname -s)"
  case "${OS}" in
    Linux*)
      curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
      chmod +x ./kind
      sudo mv ./kind /usr/local/bin/kind
      ;;
    Darwin*)
      # macOS
      brew install kind || {
        curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-darwin-amd64
        chmod +x ./kind
        sudo mv ./kind /usr/local/bin/kind
      }
      ;;
    *)
      echo -e "${RED}Unsupported operating system: ${OS}${NC}"
      exit 1
      ;;
  esac
fi

# Create the cluster using the configuration file
echo -e "${CYAN}Creating Kubernetes cluster with 1 master and 2 worker nodes...${NC}"
kind create cluster --name k8s-lab --config kind-config.yaml

# Verify the cluster is running
echo -e "${CYAN}Verifying cluster status...${NC}"
kubectl cluster-info
kubectl get nodes

# Install Kubernetes Dashboard (optional)
echo -e "${CYAN}Installing Kubernetes Dashboard...${NC}"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

# Create a service account for dashboard access
echo -e "${CYAN}Creating dashboard service account and cluster role binding...${NC}"
cat <<EOF | kubectl apply -f -
kind: ServiceAccount
apiVersion: v1
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF

# Get the token for dashboard login
echo -e "${CYAN}Getting dashboard access token...${NC}"
kubectl -n kubernetes-dashboard create token admin-user

# Instructions to access the dashboard
echo -e "\n${GREEN}Your Kubernetes cluster is ready!${NC}"
echo -e "\n${YELLOW}To access the Kubernetes Dashboard:${NC}"
echo -e "${YELLOW}1. Run: kubectl proxy${NC}"
echo -e "${YELLOW}2. Open: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/${NC}"
echo -e "${YELLOW}3. Use the token displayed above to log in${NC}"

echo -e "\n${YELLOW}To delete the cluster when you're done:${NC}"
echo -e "${YELLOW}kind delete cluster --name k8s-lab${NC}"