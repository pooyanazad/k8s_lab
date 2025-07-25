# Scenario 4: Health Checks

This scenario demonstrates how to implement health checks (liveness and readiness probes) in Kubernetes.

## Objective

Learn how to configure liveness and readiness probes to improve application reliability and availability.

## Files

- `deployment.yaml`: Contains a Deployment with liveness and readiness probes

## Steps

1. Make sure your cluster is running:

   ```bash
   kubectl get nodes
   ```

2. Deploy the application with health checks:

   ```bash
   kubectl apply -f deployment.yaml
   ```

3. Check the deployment and pods:

   ```bash
   kubectl get deployments
   kubectl get pods
   ```

4. Watch the pod status to see the probes in action:

   ```bash
   kubectl get pods -l app=nginx-health -w
   ```

5. Simulate a failure to see the liveness probe in action:

   ```bash
   # Get the pod name
   POD_NAME=$(kubectl get pods -l app=nginx-health -o jsonpath="{.items[0].metadata.name}")
   
   # Remove the health check file to simulate failure
   kubectl exec $POD_NAME -- rm /usr/share/nginx/html/health
   ```

   Watch the pod get restarted due to the liveness probe failure

6. Check the pod events to see the probe actions:

   ```bash
   kubectl describe pod $POD_NAME
   ```

7. Access the application:

   ```bash
   kubectl port-forward service/nginx-health-service 8080:80
   ```

   Then access http://localhost:8080 in your browser

## Cleanup

```bash
kubectl delete -f deployment.yaml
```

## Key Concepts

- **Liveness Probe**: Determines if a container is running properly
- **Readiness Probe**: Determines if a container is ready to receive traffic
- **Startup Probe**: Determines when a container application has started
- **Probe Types**: HTTP, TCP, and Exec probes
- **Probe Parameters**: initialDelaySeconds, periodSeconds, timeoutSeconds, successThreshold, failureThreshold