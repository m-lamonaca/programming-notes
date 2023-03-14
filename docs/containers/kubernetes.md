# Kubernetes

## `kubectl`

### `kubectl get`

```sh
kubectl config get-contexts  # list available contexts

kubectl get namespaces  # list namespaces inside current context

kubectl get pod -n|--namespace <namespace>  # list pods inside namespace
kubectl get pod [-n|--namespace <namespace>] <pod> -o|--output jsonpath='{.spec.containers[*].name}'  # list containers inside pod
```

### `kubectl exec`

```sh
kubectl exec [-i|--stdin] [-t|--tty] [-n|--namespace <namespace>] <pod> [-c|--container <container>] -- <command>  # execute a command inside a container
```
### `kubectl logs`

```sh
kubectl logs [-f|--follow] [-n|--namespace <namespace>] <pod> [-c|--container]  # get pod/container logs
```