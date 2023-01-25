#!/bin/bash

task_deploy() {
	kuebctl apply -f complete-doktor-customize2.yml
	./configmap-deploy.sh
	./filter-deploy.sh
}

task_log() {
	pod=$(kubectl get pod -n paper | grep app | awk '{print $1}')
	kubectl logs $pod -n paper -c istio-proxy 
}

