# Kubernetes Lab Setup

This repository contains scripts to quickly set up a local Kubernetes cluster with 1 master node and 2 worker nodes using [kind](https://kind.sigs.k8s.io/) (Kubernetes in Docker).

## Quick Help

To see a list of all available scripts and their purposes:

```bash
chmod +x help.sh
./help.sh
```

## Prerequisites

- Docker Engine (for Linux) or Docker Desktop (for macOS)
- Internet connection to download necessary components

## Quick Start

1. Open Terminal
2. Navigate to this directory
3. Make the script executable and run it:

```bash
chmod +x setup-cluster.sh
./setup-cluster.sh
```

The script will:
- Install kubectl and kind (if not already installed)
- Create a Kubernetes cluster with 1 master and 2 worker nodes
- Install the Kubernetes Dashboard
- Create an admin user for the dashboard
- Display the token for dashboard login

## Deploying a Sample Application

After setting up the cluster, you can deploy a sample NGINX application:

```bash
chmod +x deploy-sample-app.sh
./deploy-sample-app.sh
```

This will deploy:
- An NGINX deployment with 3 replicas
- A ClusterIP service
- An Ingress resource
- The NGINX Ingress Controller

Once deployed, you can access the application at http://localhost/

## Accessing the Kubernetes Dashboard

After running the setup script:

1. Start the kubectl proxy:
```bash
kubectl proxy
```

2. Open the following URL in your browser:
```
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```

3. Use the token displayed by the setup script to log in

## Cluster Configuration

The cluster is configured with:
- 1 control-plane (master) node
- 2 worker nodes
- Port forwarding for ingress (80, 443)

You can modify the configuration in the `kind-config.yaml` file.

## Checking Cluster Status

To check the status of your cluster and all its components:

```bash
chmod +x check-cluster-status.sh
./check-cluster-status.sh
```

This will display information about:
- Cluster information
- Nodes
- Namespaces
- Pods, Deployments, Services, and Ingresses
- Persistent Volumes and Claims
- Resource usage

## Cleaning Up

To delete the cluster and clean up all resources when you're done:

```bash
chmod +x cleanup-cluster.sh
./cleanup-cluster.sh
```

This will:
- Delete the Kubernetes cluster
- Remove any temporary files created during setup
- Provide instructions for completely uninstalling kind and kubectl if desired

## Troubleshooting

### Docker Issues

If you encounter Docker-related errors:
- Make sure Docker is running
- Ensure your user is in the docker group

### Resource Issues

If the cluster fails to start due to resource constraints:
- Ensure your system has enough resources (CPU/memory) for running Kubernetes
- Close unnecessary applications to free up memory

## Additional Resources

- [kind Documentation](https://kind.sigs.k8s.io/docs/user/quick-start/)
- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Kubernetes Dashboard](https://github.com/kubernetes/dashboard)