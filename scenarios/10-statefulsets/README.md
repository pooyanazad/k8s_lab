# StatefulSets in Kubernetes

This scenario demonstrates how to use StatefulSets in Kubernetes to manage stateful applications.

## Prerequisites

- A running Kubernetes cluster
- kubectl command-line tool configured to communicate with your cluster

## Components

This scenario includes the following files:

- `statefulset.yaml`: Defines a StatefulSet for a web application with persistent storage
- `service.yaml`: Defines a headless service for the StatefulSet
- `pvc.yaml`: Defines a PersistentVolumeClaim template for the StatefulSet

## Application

1. Create the StatefulSet and associated resources:

```bash
kubectl apply -f service.yaml
kubectl apply -f statefulset.yaml
```

2. Wait for the StatefulSet pods to be ready:

```bash
kubectl get pods -w
```

## Verification

1. Verify that the StatefulSet pods have been created with predictable names:

```bash
kubectl get pods
```

You should see pods named `web-0`, `web-1`, and `web-2`.

2. Verify that each pod has its own PersistentVolumeClaim:

```bash
kubectl get pvc
```

You should see PVCs named `www-web-0`, `www-web-1`, and `www-web-2`.

3. Access the pods individually using their stable network identities:

```bash
kubectl run -i --tty --image=busybox:1.28 dns-test --restart=Never --rm /bin/sh
```

Once inside the container, run:

```bash
nslookup web-0.nginx
nslookup web-1.nginx
nslookup web-2.nginx
```

## Scaling

1. Scale the StatefulSet up:

```bash
kubectl scale statefulset web --replicas=5
```

2. Scale the StatefulSet down:

```bash
kubectl scale statefulset web --replicas=2
```

Notice that pods are created and terminated in reverse ordinal order.

## Cleanup

Delete the StatefulSet and associated resources:

```bash
kubectl delete statefulset web
kubectl delete service nginx
kubectl delete pvc -l app=nginx
```

## Key Concepts

- **StatefulSets**: Kubernetes workload API object used to manage stateful applications
- **Stable Network Identity**: Each pod in a StatefulSet has a stable hostname based on its ordinal index
- **Ordered Deployment**: Pods are created, updated, and deleted in a predictable order
- **Stable Storage**: Each pod can have its own persistent storage that survives pod rescheduling