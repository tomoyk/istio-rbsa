#!/bin/bash

task_deploy() {
	kubectl apply -f complete-doktor-customize2.yml
	./configmap-deploy.sh
	./filter-deploy.sh
}

task_log-p() {
	pod=$(kubectl get pod -n paper | grep app | awk '{print $1}')
	echo $pod
	kubectl logs $pod -n paper -c istio-proxy | grep "\[2023" | tee p.log
}

task_log-f() {
	pod=$(kubectl get pod -n front | grep app | awk '{print $1}')
	echo $pod
	kubectl logs $pod -n front -c istio-proxy | grep "\[2023" | tee f.log
}

task_reset() {
	list="front paper author fulltext thumbnail stats"
	for l in $list
	do
		pod=$(kubectl get pod -n $l | grep app | awk '{print $1}')
		kubectl delete pod $pod -n $l
	done
}

task_log-collect() {
	timestamp=$(date "+%Y-%m-%d-%H-%M-%S")
	list="front paper author fulltext thumbnail stats"
	mkdir logs-$timestamp
	for l in $list
	do
		echo "collect from $l"
		pod=$(kubectl get pod -n $l | grep app | awk '{print $1}')
		kubectl logs $pod -c istio-proxy -n $l > logs-$timestamp/${timestamp}_${l}.log
	done
}

task_log-summary() {
	log_files=$(find . -wholename "./logs-*/*.log")
	for lf in $log_files
	do
		echo "Summary: $lf"
		grep "^\[2023" $lf > ${lf}2
	done
}

task_load() {
	./load-access/loader.sh
}

task_apply-filter-p() {
	./filter-deploy.sh proposal
}

task_apply-filter-n() {
	./filter-deploy.sh normal
}

task_do-p() {
	task_reset
	sleep 10
	task_apply-filter-p
	sleep 3
	task_load
	task_log-collect
	task_log_summary
	curl -X POST --data-urlencode "payload={\"channel\": \"#times-koyama\", \"username\": \"experiment-notice\", \"text\": \"実験おわった\", \"icon_emoji\": \":ghost:\"}" $(cat .slack-webhook)
}
