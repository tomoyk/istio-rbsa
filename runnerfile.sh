task_default() {
	kubectl delete -f my-envoy-filter.yml
	kubectl apply -f my-envoy-filter.yml
}

task_log() {
	pod_name=$(kubectl get pod -n sock-shop | grep front-end | awk '{print $1}')
	kubectl logs $pod_name -n sock-shop -c istio-proxy | grep lua
}
