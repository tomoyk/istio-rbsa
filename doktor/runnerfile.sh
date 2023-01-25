#!/bin/bash

task_deploy() {
	kubectl apply -f complete-doktor-customize2.yml
	./configmap-deploy.sh
	./filter-deploy.sh
}

task_log-p() {
	pod=$(kubectl get pod -n paper | grep app | awk '{print $1}')
	echo $pod
	kubectl logs $pod -n paper -c istio-proxy | tail
}

task_log-f() {
	pod=$(kubectl get pod -n front | grep app | awk '{print $1}')
	echo $pod
	kubectl logs $pod -n front -c istio-proxy | tail
}
