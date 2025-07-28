# Network Policies in Kubernetes

This scenario demonstrates how to use Kubernetes Network Policies to control traffic flow between pods in a cluster.

## Prerequisites

- A Kubernetes cluster with a network plugin that supports Network Policies (e.g., Calico, Weave Net, Cilium)
- kubectl configured to communicate with your cluster

## Components

1. **namespace.yaml**: Defines the namespaces used in this scenario
2. **nginx-deployment.yaml**: Deploys an Nginx server in the default namespace
3. **client-pods.yaml**: Creates client pods in different namespaces for testing
4. **default-deny-policy.yaml**: Blocks all ingress traffic to the default namespace
5. **allow-from-prod-policy.yaml**: Allows traffic only from the prod namespace

## Application

1. Create the namespaces:

```bash
kubectl apply -f scenarios/09-network-policies/namespace.yaml
```

2. Deploy the Nginx server:

```bash
kubectl apply -f scenarios/09-network-policies/nginx-deployment.yaml
```

3. Create the client pods:

```bash
kubectl apply -f scenarios/09-network-policies/client-pods.yaml
```

## Testing Network Connectivity (Before Policies)

1. Get the Nginx pod IP:

```bash
NGINX_POD_IP=$(kubectl get pod -l app=nginx -o jsonpath='{.items[0].status.podIP}')
echo $NGINX_POD_IP
```

2. Test connectivity from the prod namespace:

```bash
kubectl exec -n prod prod-client -- curl -s --connect-timeout 5 $NGINX_POD_IP
```

3. Test connectivity from the dev namespace:

```bash
kubectl exec -n dev dev-client -- curl -s --connect-timeout 5 $NGINX_POD_IP
```

Both should return the Nginx welcome page HTML.

## Applying Network Policies

1. Apply the default deny policy:

```bash
kubectl apply -f scenarios/09-network-policies/default-deny-policy.yaml
```

2. Test connectivity again from both namespaces:

```bash
kubectl exec -n prod prod-client -- curl -s --connect-timeout 5 $NGINX_POD_IP
kubectl exec -n dev dev-client -- curl -s --connect-timeout 5 $NGINX_POD_IP
```

Both should time out, as all traffic is now blocked.

3. Apply the policy to allow traffic from prod:

```bash
kubectl apply -f scenarios/09-network-policies/allow-from-prod-policy.yaml
```

4. Test connectivity again:

```bash
kubectl exec -n prod prod-client -- curl -s --connect-timeout 5 $NGINX_POD_IP
kubectl exec -n dev dev-client -- curl -s --connect-timeout 5 $NGINX_POD_IP
```

Now, only the prod namespace should be able to connect to the Nginx pod.

## Cleanup

```bash
kubectl delete -f scenarios/09-network-policies/allow-from-prod-policy.yaml
kubectl delete -f scenarios/09-network-policies/default-deny-policy.yaml
kubectl delete -f scenarios/09-network-policies/client-pods.yaml
kubectl delete -f scenarios/09-network-policies/nginx-deployment.yaml
kubectl delete -f scenarios/09-network-policies/namespace.yaml
```

## Key Concepts

- **Network Policies**: Kubernetes resources that control the traffic flow between pods
- **Ingress Rules**: Control incoming traffic to pods
- **Egress Rules**: Control outgoing traffic from pods
- **Selectors**: Define which pods a policy applies to
- **Default Deny**: Block all traffic unless explicitly allowed
- **Namespace Isolation**: Control traffic between different namespaces