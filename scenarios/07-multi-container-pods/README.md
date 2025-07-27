# Multi-Container Pods

This scenario demonstrates how to create and manage multi-container pods in Kubernetes. Multi-container pods are useful for implementing sidecar, ambassador, or adapter patterns.

## Components

- **pod.yaml**: Defines a pod with multiple containers that work together

## Instructions

1. Apply the pod configuration:
   ```bash
   kubectl apply -f scenarios/07-multi-container-pods/pod.yaml
   ```

2. Check the pod status:
   ```bash
   kubectl get pods
   ```

3. View the logs from the main container:
   ```bash
   kubectl logs multi-container-pod -c main-container
   ```

4. View the logs from the sidecar container:
   ```bash
   kubectl logs multi-container-pod -c sidecar-container
   ```

5. Execute a command in the main container:
   ```bash
   kubectl exec -it multi-container-pod -c main-container -- /bin/sh
   ```

6. Access the shared volume from both containers:
   ```bash
   # From main container
   kubectl exec -it multi-container-pod -c main-container -- ls -la /shared-data
   
   # From sidecar container
   kubectl exec -it multi-container-pod -c sidecar-container -- ls -la /shared-data
   ```

## Cleanup

```bash
kubectl delete -f scenarios/07-multi-container-pods/pod.yaml
```

## Notes

- Containers in the same pod share the same network namespace and can communicate via localhost
- Containers can share volumes for file-based communication
- Each container should have a single responsibility (separation of concerns)
- Common patterns include:
  - Sidecar: Enhances the main container (e.g., logging agent)
  - Ambassador: Proxies network traffic to/from the main container
  - Adapter: Standardizes and normalizes output from the main container