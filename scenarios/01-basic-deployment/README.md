# Scenario 1: Basic Deployment

This scenario demonstrates how to create a basic deployment in Kubernetes.

## Objective

Learn how to deploy a simple application to Kubernetes and expose it via a Service.

## Files

- `deployment.yaml`: Contains the Deployment and Service definitions

## Steps

1. Make sure your cluster is running:

   ```bash
   kubectl get nodes
   ```

2. Apply the deployment:

   ```bash
   kubectl apply -f deployment.yaml
   ```

3. Check the deployment status:

   ```bash
   kubectl get deployments
   kubectl get pods
   ```

4. Check the service:

   ```bash
   kubectl get services
   ```

5. Access the application:

   ```bash
   # Get the port of the service
   kubectl get service nginx-basic-service
   ```

   Then access the application at http://localhost:<PORT>

## Cleanup

```bash
kubectl delete -f deployment.yaml
```

## Key Concepts

- **Deployment**: Manages the creation and updating of Pods
- **Pod**: The smallest deployable unit in Kubernetes
- **Service**: Exposes an application running on a set of Pods
- **NodePort**: Exposes the Service on each Node's IP at a static port