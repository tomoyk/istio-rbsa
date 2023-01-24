task_setup() {
	kubectl create namespace sock-shop
	kubectl label namespace sock-shop istio-injection=enabled
	kubectl apply -f json-lua/json-lua-configmap.yml
	kubectl apply -f sock-shop/istio-gw.yml
	kubectl apply -f sock-shop/complete-demo-custom2.yml
}

task_default() {
	task_deploy
}

task_log() {
	pod_name=$(kubectl get pod -n sock-shop | grep front-end | awk '{print $1}')
	kubectl logs $pod_name -n sock-shop -c istio-proxy | grep lua
}

task_log2() {
	pod_name=$(kubectl get pod -n sock-shop | grep front-end | awk '{print $1}')
	kubectl logs $pod_name -n sock-shop -c istio-proxy -f | grep -v lua
}

task_tail() {
	pod_name=$(kubectl get pod -n sock-shop | grep front-end | awk '{print $1}')
	kubectl logs $pod_name -n sock-shop -c istio-proxy -f | grep lua
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

task_gen() {
	basedir=custom-istio
	istioctl kube-inject \
	--injectConfigFile $basedir/inject-config.yml \
	--meshConfigFile $basedir/mesh-config.yml \
	--valuesFile $basedir/inject-values.yml \
	--filename sock-shop/complete-demo.yml > sock-shop/complete-demo-custom.yml

	env/bin/python istio-customizer.py
}

task_deploy2() {
	kubectl create namespace sock-shop
	kubectl label namespace sock-shop istio-injection=enabled
	kubectl apply -f sock-shop/complete-demo-custom2.yml
}
