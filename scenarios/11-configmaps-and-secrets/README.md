# ConfigMaps and Secrets in Kubernetes

This scenario demonstrates how to use ConfigMaps and Secrets in Kubernetes to manage configuration data and sensitive information.

## Prerequisites

- A running Kubernetes cluster
- kubectl command-line tool configured to communicate with your cluster

## Components

This scenario includes the following files:

- `configmap.yaml`: Defines a ConfigMap with configuration data
- `secret.yaml`: Defines a Secret with sensitive information
- `pod-configmap.yaml`: Defines a Pod that uses the ConfigMap
- `pod-secret.yaml`: Defines a Pod that uses the Secret

## Application

### ConfigMaps

1. Create the ConfigMap:

```bash
kubectl apply -f configmap.yaml
```

2. Create a Pod that uses the ConfigMap:

```bash
kubectl apply -f pod-configmap.yaml
```

### Secrets

1. Create the Secret:

```bash
kubectl apply -f secret.yaml
```

2. Create a Pod that uses the Secret:

```bash
kubectl apply -f pod-secret.yaml
```

## Verification

### ConfigMaps

1. View the ConfigMap:

```bash
kubectl get configmap game-config -o yaml
```

2. Check the environment variables in the Pod:

```bash
kubectl exec config-env-pod -- env | grep SPECIAL
```

3. Check the mounted ConfigMap volume:

```bash
kubectl exec config-vol-pod -- ls /config
kubectl exec config-vol-pod -- cat /config/game.properties
```

### Secrets

1. View the Secret (note that the values are base64 encoded):

```bash
kubectl get secret db-credentials -o yaml
```

2. Check the environment variables in the Pod:

```bash
kubectl exec secret-env-pod -- env | grep DB_
```

3. Check the mounted Secret volume:

```bash
kubectl exec secret-vol-pod -- ls /etc/db-credentials
kubectl exec secret-vol-pod -- cat /etc/db-credentials/username
```

## Cleanup

Delete all resources created in this scenario:

```bash
kubectl delete pod config-env-pod config-vol-pod secret-env-pod secret-vol-pod
kubectl delete configmap game-config
kubectl delete secret db-credentials
```

## Key Concepts

- **ConfigMaps**: Store non-confidential configuration data as key-value pairs
- **Secrets**: Store sensitive information such as passwords, OAuth tokens, and SSH keys
- **Environment Variables**: Inject configuration data into containers as environment variables
- **Volume Mounts**: Mount configuration data as files in the container's filesystem