# Jobs and CronJobs in Kubernetes

This scenario demonstrates how to use Jobs and CronJobs in Kubernetes to run batch processes and scheduled tasks.

## Components

1. **job.yaml**: Defines a Kubernetes Job that runs a container to completion
2. **cronjob.yaml**: Defines a Kubernetes CronJob that runs a container on a schedule

## Job

A Job creates one or more Pods and ensures that a specified number of them successfully terminate. As pods successfully complete, the Job tracks the successful completions. When a specified number of successful completions is reached, the task (Job) is complete.

## CronJob

A CronJob creates Jobs on a repeating schedule. It's useful for creating periodic and recurring tasks, like running backups, sending emails, or cleaning up resources.

## Application

1. Apply the Job:

```bash
kubectl apply -f scenarios/08-jobs-and-cronjobs/job.yaml
```

2. Apply the CronJob:

```bash
kubectl apply -f scenarios/08-jobs-and-cronjobs/cronjob.yaml
```

## Verification

1. Check the status of the Job:

```bash
kubectl get jobs
kubectl describe job hello
```

2. Check the pods created by the Job:

```bash
kubectl get pods --selector=job-name=hello
```

3. Check the logs of the Job pod:

```bash
kubectl logs -l job-name=hello
```

4. Check the status of the CronJob:

```bash
kubectl get cronjobs
kubectl describe cronjob hello-cron
```

5. Check the Jobs created by the CronJob:

```bash
kubectl get jobs --selector=job-name=hello-cron-*
```

## Cleanup

1. Delete the Job:

```bash
kubectl delete -f scenarios/08-jobs-and-cronjobs/job.yaml
```

2. Delete the CronJob:

```bash
kubectl delete -f scenarios/08-jobs-and-cronjobs/cronjob.yaml
```

## Key Concepts

- **Jobs**: Run a task to completion
- **CronJobs**: Run tasks on a schedule
- **Completions**: Number of pods that should complete successfully
- **Parallelism**: Number of pods that can run in parallel
- **Schedule**: Cron-like schedule for recurring jobs
- **Suspend**: Temporarily disable a CronJob
- **Concurrency Policy**: How to handle concurrent executions