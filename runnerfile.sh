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

task_deploy-filter() {
	kubectl delete -f my-envoy-filter.yml
	kubectl apply -f my-envoy-filter.yml
	kubectl get pod
	kubectl get envoyfilter
}

task_gen() {
	basedir=custom-istio
	istioctl kube-inject \
	--injectConfigFile $basedir/inject-config.yml \
	--meshConfigFile $basedir/mesh-config.yml \
	--valuesFile $basedir/inject-values.yml \
	--filename sock-shop/complete-demo.yml > sock-shop/complete-demo-custom.yml

	env/bin/python istio-customizer.py
}

task_deploy() {
	kubectl create namespace sock-shop
	kubectl label namespace sock-shop istio-injection=enabled
	kubectl apply -f sock-shop/complete-demo-custom2.yml
}