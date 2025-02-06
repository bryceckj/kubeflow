kubectl apply -f crd-gateways-kubeflow.yaml -n kubeflow 
sleep 5
kubectl create -n istio-system secret tls istio-ingressgateway-certs --key key.pem --cert cert.pem

istio_pod=`kubectl get pod -n istio-system -l app=istio-ingressgateway | awk '(NR>1){print $1}'`
kubectl delete pod $istio_pod -n istio-system

#kubectl create configmap dex --from-file=config.yaml=dex-config.yaml -n auth --dry-run=client -oyaml | kubectl apply -f -
#kubectl rollout restart deployment dex -n auth

