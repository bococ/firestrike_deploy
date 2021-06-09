kubectl -n firestrike-world2 get rs -o json|jq -r '.items[] | select(.spec.replicas | contains(0)) | "kubectl delete rs --namespace=\(.metadata.namespace) \(.metadata.name)"'
