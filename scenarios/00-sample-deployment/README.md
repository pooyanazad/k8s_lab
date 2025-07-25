# Sample Deployment

This is a basic sample deployment to test your Kubernetes cluster.

## Objective

Verify that your Kubernetes cluster is working correctly by deploying a simple NGINX application with a Service and Ingress.

## Files

- `sample-deployment.yaml`: Contains the Deployment, Service, and Ingress definitions

## Steps

1. Make sure your cluster is running:

   ```bash
   kubectl get nodes
   ```

2. Deploy the sample application:

   ### Windows

   ```powershell
   .\deploy-sample-app.ps1
   ```

   ### Linux/macOS

   ```bash
   chmod +x deploy-sample-app.sh
   ./deploy-sample-app.sh
   ```

   Or manually apply the configuration:

   ```bash
   kubectl apply -f sample-deployment.yaml
   ```

3. Check the deployment status:

   ```bash
   kubectl get deployments
   kubectl get pods
   kubectl get services
   kubectl get ingress
   ```

4. Access the application:

   Once the Ingress is set up, you can access the application at http://localhost/

## Cleanup

```bash
kubectl delete -f sample-deployment.yaml
```

## Key Concepts

- **Deployment**: Manages the creation and updating of Pods
- **Service**: Exposes an application running on a set of Pods
- **Ingress**: Manages external access to services in a cluster