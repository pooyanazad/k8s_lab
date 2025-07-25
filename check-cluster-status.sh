#!/bin/bash
# check-cluster-status.sh
# Script to check the status of the Kubernetes cluster and its components

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

# Function to display section headers
show_header() {
  echo -e "\n${CYAN}=== $1 ===${NC}"
}

# Check cluster info
show_header "Cluster Information"
kubectl cluster-info

# Check nodes
show_header "Nodes"
kubectl get nodes -o wide

# Check namespaces
show_header "Namespaces"
kubectl get namespaces

# Check pods in all namespaces
show_header "Pods in All Namespaces"
kubectl get pods --all-namespaces

# Check deployments
show_header "Deployments"
kubectl get deployments --all-namespaces

# Check services
show_header "Services"
kubectl get services --all-namespaces

# Check ingresses
show_header "Ingresses"
kubectl get ingress --all-namespaces

# Check persistent volumes
show_header "Persistent Volumes"
kubectl get pv

# Check persistent volume claims
show_header "Persistent Volume Claims"
kubectl get pvc --all-namespaces

# Check storage classes
show_header "Storage Classes"
kubectl get sc

# Check resource usage
show_header "Resource Usage"
kubectl top nodes
echo -e "\n${YELLOW}Pod resource usage:${NC}"
kubectl top pods --all-namespaces

echo -e "\n${GREEN}Cluster status check completed.${NC}"