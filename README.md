# gitlab

Add the GitLab Helm repository:
```bash
helm repo add gitlab https://charts.gitlab.io/
```

Install GitLab:
```
helm upgrade -i gitlab gitlab/gitlab \
  --create-namespace \
  --namespace gitlab \
  --set certmanager-issuer.email=shubhamtatvamasi@gmail.com
```


MetalLB IP for minikube:
```bash
kubectl create -f - << EOF
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  namespace: metallb-system
  name: ip-pool
spec:
  addresses:
  - $(kubectl get nodes -o jsonpath='{ $.items[*].status.addresses[?(@.type=="InternalIP")].address }')/32
EOF
```
