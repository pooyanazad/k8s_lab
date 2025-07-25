# Scenario 3: ConfigMaps and Secrets

This scenario demonstrates how to use ConfigMaps and Secrets to configure applications in Kubernetes.

## Objective

Learn how to create and use ConfigMaps and Secrets to provide configuration and sensitive data to applications.

## Files

- `configmap.yaml`: Contains the ConfigMap definition
- `secret.yaml`: Contains the Secret definition
- `deployment.yaml`: Contains a Deployment that uses the ConfigMap and Secret

## Steps

1. Make sure your cluster is running:

   ```bash
   kubectl get nodes
   ```

2. Create the ConfigMap and Secret:

   ```bash
   kubectl apply -f configmap.yaml
   kubectl apply -f secret.yaml
   ```

3. Check the ConfigMap and Secret:

   ```bash
   kubectl get configmaps
   kubectl get secrets
   ```

4. Deploy the application that uses the ConfigMap and Secret:

   ```bash
   kubectl apply -f deployment.yaml
   ```

5. Check the deployment and pods:

   ```bash
   kubectl get deployments
   kubectl get pods
   ```

6. Verify the ConfigMap and Secret are being used:

   ```bash
   # Get the pod name
   POD_NAME=$(kubectl get pods -l app=nginx-config -o jsonpath="{.items[0].metadata.name}")
   
   # Check environment variables from ConfigMap
   kubectl exec $POD_NAME -- env | grep NGINX_
   
   # Check environment variables from Secret
   kubectl exec $POD_NAME -- env | grep DB_
   
   # Check mounted ConfigMap
   kubectl exec $POD_NAME -- cat /etc/nginx/conf.d/default.conf
   ```

7. Access the application:

   ```bash
   kubectl port-forward service/nginx-config-service 8080:80
   ```

   Then access http://localhost:8080 in your browser

## Cleanup

```bash
kubectl delete -f deployment.yaml
kubectl delete -f secret.yaml
kubectl delete -f configmap.yaml
```

## Key Concepts

- **ConfigMap**: Stores non-confidential configuration data as key-value pairs
- **Secret**: Stores sensitive information such as passwords, tokens, or keys
- **Environment Variables**: A way to pass configuration to containers
- **Volume Mounting**: Another way to provide configuration files to containers