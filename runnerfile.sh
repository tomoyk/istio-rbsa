task_default() {
	task_deploy
}

task_log() {
	pod_name=$(kubectl get pod -n sock-shop | grep front-end | awk '{print $1}')
	kubectl logs $pod_name -n sock-shop -c istio-proxy | grep lua
}

task_logs() {
	task_log
}

task_deploy() {
	kubectl delete -f my-envoy-filter.yml
	kubectl apply -f my-envoy-filter.yml
	kubectl get pod
	kubectl get envoyfilter
}

task_apply() {
	task_deploy
}
