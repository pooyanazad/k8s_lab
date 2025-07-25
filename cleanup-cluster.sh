#!/bin/bash
# cleanup-cluster.sh
# Script to clean up the Kubernetes cluster and all resources

# Set colors for output
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if kind is installed
if ! command -v kind &> /dev/null; then
  echo -e "${YELLOW}kind is not installed. Nothing to clean up.${NC}"
  exit 0
fi

# Check if the cluster exists
cluster_exists=false
if kind get clusters 2>/dev/null | grep -q "k8s-lab"; then
  cluster_exists=true
fi

# Delete the cluster if it exists
if $cluster_exists; then
  echo -e "${CYAN}Deleting Kubernetes cluster 'k8s-lab'...${NC}"
  kind delete cluster --name k8s-lab
  echo -e "${GREEN}Cluster deleted successfully.${NC}"
else
  echo -e "${YELLOW}No 'k8s-lab' cluster found. Nothing to delete.${NC}"
fi

# Clean up any temporary files
echo -e "${CYAN}Cleaning up temporary files...${NC}"
if [ -f "dashboard-adminuser.yaml" ]; then
  rm dashboard-adminuser.yaml
fi

echo -e "${GREEN}Cleanup completed.${NC}"
echo -e "\n${YELLOW}If you want to completely uninstall kind and kubectl, you can run:${NC}"

# Detect OS
OS="$(uname -s)"
case "${OS}" in
  Linux*)
    echo -e "${YELLOW}sudo rm -f /usr/local/bin/kind /usr/local/bin/kubectl${NC}"
    ;;
  Darwin*)
    # macOS
    echo -e "${YELLOW}brew uninstall kind kubectl${NC}"
    ;;
  *)
    echo -e "${YELLOW}Please remove kind and kubectl manually.${NC}"
    ;;
esac