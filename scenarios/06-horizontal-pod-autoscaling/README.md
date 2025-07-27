# Horizontal Pod Autoscaling

This scenario demonstrates how to implement Horizontal Pod Autoscaling (HPA) in Kubernetes. HPA automatically scales the number of pods in a deployment based on observed CPU utilization or other select metrics.

## Components

- **deployment.yaml**: Defines a deployment with resource requests and limits
- **hpa.yaml**: Configures the Horizontal Pod Autoscaler
- **load-generator.yaml**: A simple pod that can be used to generate load for testing the autoscaler

## Instructions

1. Apply the deployment:
   ```bash
   kubectl apply -f scenarios/06-horizontal-pod-autoscaling/deployment.yaml
   ```

2. Apply the HPA configuration:
   ```bash
   kubectl apply -f scenarios/06-horizontal-pod-autoscaling/hpa.yaml
   ```

3. Check the HPA status:
   ```bash
   kubectl get hpa
   ```

4. To test the autoscaler, apply the load generator:
   ```bash
   kubectl apply -f scenarios/06-horizontal-pod-autoscaling/load-generator.yaml
   ```

5. Monitor the HPA as it scales the deployment:
   ```bash
   kubectl get hpa -w
   ```

6. In another terminal, monitor the pods:
   ```bash
   kubectl get pods -w
   ```

## Cleanup

```bash
kubectl delete -f scenarios/06-horizontal-pod-autoscaling/load-generator.yaml
kubectl delete -f scenarios/06-horizontal-pod-autoscaling/hpa.yaml
kubectl delete -f scenarios/06-horizontal-pod-autoscaling/deployment.yaml
```

## Notes

- The metrics-server must be installed in your cluster for HPA to work
- The load generator creates artificial CPU load to trigger the autoscaler
- In a real environment, actual user traffic would trigger scaling