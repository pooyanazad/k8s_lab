# Scenario 12: Working with Helm Charts

This scenario demonstrates how to use Helm, the package manager for Kubernetes, to deploy applications using Helm charts.

## Prerequisites

- A running Kubernetes cluster (you can use the setup script in the root directory)
- Helm CLI installed on your local machine

## Components

- `mychart/` - A simple Helm chart with the following structure:
  - `Chart.yaml` - Contains chart metadata
  - `values.yaml` - Default configuration values
  - `templates/` - Directory containing template files
    - `deployment.yaml` - Template for Kubernetes Deployment
    - `service.yaml` - Template for Kubernetes Service
    - `configmap.yaml` - Template for Kubernetes ConfigMap
    - `_helpers.tpl` - Helper templates for common label patterns
    - `NOTES.txt` - Usage notes displayed after installation

## What You'll Learn

- How to create a basic Helm chart
- How to install, upgrade, and uninstall applications using Helm
- How to customize deployments using values files
- How to work with Helm templates and functions

## Application Steps

### 1. Install Helm

If you haven't installed Helm yet, follow the [official installation guide](https://helm.sh/docs/intro/install/).

### 2. Examine the Chart Structure

Explore the files in the `mychart/` directory to understand the structure of a Helm chart:

```bash
cd scenarios/12-helm-charts
ls -la mychart
```

### 3. Install the Chart

```bash
# Install the chart with the release name "myapp"
helm install myapp ./mychart
```

### 4. Customize the Installation

Create a custom values file (`custom-values.yaml`):

```yaml
replicaCount: 2

service:
  type: NodePort

config:
  message: "Hello, customized Helm!"
  color: green
```

Install with custom values:

```bash
helm install myapp-custom ./mychart -f custom-values.yaml
```

Alternatively, use the `--set` flag for simple customizations:

```bash
helm install myapp-custom ./mychart --set service.type=NodePort --set replicaCount=2
```

### 5. Upgrade the Release

```bash
# Upgrade the existing release
helm upgrade myapp ./mychart --set replicaCount=3
```

## Verification

### 1. List Helm Releases

```bash
helm list
```

### 2. Check Deployed Resources

```bash
# Check the pods created by the Helm release
kubectl get pods

# Check the services
kubectl get services

# Check the configmaps
kubectl get configmaps

# Or check all resources with a specific label
kubectl get all -l app.kubernetes.io/instance=myapp
```

### 3. View Release Information

```bash
helm status myapp
helm get manifest myapp
helm get values myapp
```

### 4. Test the Application

```bash
# For ClusterIP service (default)
kubectl port-forward svc/myapp-mychart 8080:80
# Then visit http://localhost:8080 in your browser

# For NodePort service (if configured)
minikube service myapp-custom-mychart --url  # If using Minikube
```

## Cleanup

```bash
# Uninstall the releases
helm uninstall myapp
helm uninstall myapp-custom
```

## Key Concepts

1. **Chart**: A Helm package containing all resource definitions needed to run an application on Kubernetes.

2. **Release**: An instance of a chart running in a Kubernetes cluster.

3. **Repository**: A place where charts can be stored and shared.

4. **Values**: Configuration that can be supplied to customize a chart installation.

5. **Templates**: YAML files that use the Go templating language to generate Kubernetes manifests.

6. **Hooks**: Special templates that allow chart developers to intervene at certain points in a release's lifecycle.

7. **Dependencies**: Charts can depend on other charts, allowing for composition of applications.