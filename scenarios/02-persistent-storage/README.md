# Scenario 2: Persistent Storage

This scenario demonstrates how to use persistent storage in Kubernetes.

## Objective

Learn how to create and use PersistentVolumes and PersistentVolumeClaims to provide persistent storage for applications.

## Files

- `pv-pvc.yaml`: Contains the PersistentVolume and PersistentVolumeClaim definitions
- `deployment.yaml`: Contains a Deployment that uses the PersistentVolumeClaim

## Steps

1. Make sure your cluster is running:

   ```bash
   kubectl get nodes
   ```

2. Create the PersistentVolume and PersistentVolumeClaim:

   ```bash
   kubectl apply -f pv-pvc.yaml
   ```

3. Check the status of the PV and PVC:

   ```bash
   kubectl get pv
   kubectl get pvc
   ```

4. Deploy the application that uses the PVC:

   ```bash
   kubectl apply -f deployment.yaml
   ```

5. Check the deployment and pods:

   ```bash
   kubectl get deployments
   kubectl get pods
   ```

6. Verify the persistent storage is working:

   ```bash
   # Get the pod name
   POD_NAME=$(kubectl get pods -l app=nginx-pv -o jsonpath="{.items[0].metadata.name}")
   
   # Create a test file in the volume
   kubectl exec $POD_NAME -- sh -c "echo 'Hello from persistent storage' > /usr/share/nginx/html/index.html"
   
   # Access the service
   kubectl port-forward service/nginx-pv-service 8080:80
   ```

   Then access http://localhost:8080 in your browser

7. Delete the pod and verify the data persists when a new pod is created:

   ```bash
   kubectl delete pod $POD_NAME
   # Wait for the new pod to be created
   sleep 5
   POD_NAME=$(kubectl get pods -l app=nginx-pv -o jsonpath="{.items[0].metadata.name}")
   # Check if the file still exists
   kubectl exec $POD_NAME -- cat /usr/share/nginx/html/index.html
   ```

## Cleanup

```bash
kubectl delete -f deployment.yaml
kubectl delete -f pv-pvc.yaml
```

## Key Concepts

- **PersistentVolume (PV)**: A piece of storage in the cluster
- **PersistentVolumeClaim (PVC)**: A request for storage by a user
- **StorageClass**: Describes the "class" of storage
- **Volume Mounting**: Attaching persistent storage to containers