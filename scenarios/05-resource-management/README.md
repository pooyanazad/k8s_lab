# Scenario 5: Resource Management

This scenario demonstrates how to manage resources (CPU and memory) in Kubernetes.

## Objective

Learn how to configure resource requests and limits, and how to use ResourceQuotas and LimitRanges.

## Files

- `namespace.yaml`: Contains the Namespace with ResourceQuota and LimitRange
- `deployment.yaml`: Contains a Deployment with resource requests and limits

## Steps

1. Make sure your cluster is running:

   ```bash
   kubectl get nodes
   ```

2. Create the namespace with ResourceQuota and LimitRange:

   ```bash
   kubectl apply -f namespace.yaml
   ```

3. Check the namespace, ResourceQuota, and LimitRange:

   ```bash
   kubectl get namespace resource-demo
   kubectl get resourcequota -n resource-demo
   kubectl get limitrange -n resource-demo
   ```

4. Deploy the application with resource requests and limits:

   ```bash
   kubectl apply -f deployment.yaml
   ```

5. Check the deployment and pods:

   ```bash
   kubectl get deployments -n resource-demo
   kubectl get pods -n resource-demo
   ```

6. Check resource usage:

   ```bash
   kubectl describe resourcequota -n resource-demo
   ```

7. Try to exceed the ResourceQuota by scaling the deployment:

   ```bash
   kubectl scale deployment nginx-resources -n resource-demo --replicas=5
   ```

   This should fail because it would exceed the ResourceQuota

8. Check the pod details to see the resource configuration:

   ```bash
   POD_NAME=$(kubectl get pods -n resource-demo -l app=nginx-resources -o jsonpath="{.items[0].metadata.name}")
   kubectl describe pod $POD_NAME -n resource-demo
   ```

## Cleanup

```bash
kubectl delete -f deployment.yaml
kubectl delete -f namespace.yaml
```

## Key Concepts

- **Resource Requests**: The minimum amount of resources a container needs
- **Resource Limits**: The maximum amount of resources a container can use
- **ResourceQuota**: Limits the total resource consumption of a namespace
- **LimitRange**: Sets default resource requests and limits for containers in a namespace
- **QoS Classes**: Guaranteed, Burstable, and BestEffort