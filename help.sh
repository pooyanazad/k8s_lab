#!/bin/bash
# help.sh
# Script to display help information about available scripts

# Set colors for output
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${CYAN}=== Kubernetes Lab Help ===${NC}"
echo ""

echo -e "${YELLOW}Available Scripts:${NC}"
echo ""

# Setup
echo -e "${GREEN}SETUP:${NC}"
echo -e "  ${CYAN}setup-cluster.sh${NC} - Create a Kubernetes cluster with 1 master and 2 worker nodes"
echo -e "  ${CYAN}setup-cluster.ps1${NC} - Windows version of the setup script"

# Deployment
echo ""
echo -e "${GREEN}DEPLOYMENT:${NC}"
echo -e "  ${CYAN}deploy-sample-app.sh${NC} - Deploy a sample NGINX application to the cluster"
echo -e "  ${CYAN}deploy-sample-app.ps1${NC} - Windows version of the deployment script"

# Status
echo ""
echo -e "${GREEN}STATUS:${NC}"
echo -e "  ${CYAN}check-cluster-status.sh${NC} - Check the status of the cluster and its components"
echo -e "  ${CYAN}check-cluster-status.ps1${NC} - Windows version of the status check script"

# Cleanup
echo ""
echo -e "${GREEN}CLEANUP:${NC}"
echo -e "  ${CYAN}cleanup-cluster.sh${NC} - Delete the cluster and clean up resources"
echo -e "  ${CYAN}cleanup-cluster.ps1${NC} - Windows version of the cleanup script"

# Configuration
echo ""
echo -e "${GREEN}CONFIGURATION:${NC}"
echo -e "  ${CYAN}kind-config.yaml${NC} - Configuration file for the Kubernetes cluster"
echo -e "  ${CYAN}sample-deployment.yaml${NC} - Sample application deployment configuration"

echo ""
echo -e "${YELLOW}For more information, see the README.md file.${NC}"