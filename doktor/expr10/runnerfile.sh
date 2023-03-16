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
	case $1 in
		"p") overview="proposal" ;;
		"n") overview="normal" ;;
		"e") overview="empty" ;;
		* ) overview="error" ;;
	esac
	timestamp=$(date "+%Y-%m-%d-%H-%M-%S")
	list="front paper author fulltext thumbnail stats"
	mkdir logs-$timestamp
	for l in $list
	do
		echo "collect from $l"
		pod=$(kubectl get pod -n $l | grep app | awk '{print $1}')
		kubectl logs $pod -c istio-proxy -n $l > logs-$timestamp/${timestamp}_${l}.log
	done
	echo "$overview" > logs-$timestamp/OVERVIEW
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

task_apply-filter-e() {
	./filter-deploy.sh empty
}

task_do-e() {
	typename='empty'
	curl -X POST --data-urlencode "payload={\"channel\": \"#times-koyama\", \"username\": \"experiment-notice\", \"text\": \"e実験はじめ\", \"icon_emoji\": \":ghost:\"}" $(cat .slack-webhook)
	task_reset
	sleep 10
        task_apply-filter-e
	sleep 3
	task_load
	task_log-collect e
	task_log-summary
	curl -X POST --data-urlencode "payload={\"channel\": \"#times-koyama\", \"username\": \"experiment-notice\", \"text\": \"e実験おわり\", \"icon_emoji\": \":ghost:\"}" $(cat .slack-webhook)
}

task_do-p() {
	typename='proposal'
	curl -X POST --data-urlencode "payload={\"channel\": \"#times-koyama\", \"username\": \"experiment-notice\", \"text\": \"p実験はじめ\", \"icon_emoji\": \":ghost:\"}" $(cat .slack-webhook)
	task_reset
	sleep 10
	task_apply-filter-p
	sleep 3
	task_load
	task_log-collect p
	task_log-summary
	curl -X POST --data-urlencode "payload={\"channel\": \"#times-koyama\", \"username\": \"experiment-notice\", \"text\": \"p実験おわり\", \"icon_emoji\": \":ghost:\"}" $(cat .slack-webhook)
}

task_do-n() {
	typename='normal'
	curl -X POST --data-urlencode "payload={\"channel\": \"#times-koyama\", \"username\": \"experiment-notice\", \"text\": \"n実験はじめ\", \"icon_emoji\": \":ghost:\"}" $(cat .slack-webhook)
	task_reset
	sleep 10
	task_apply-filter-n
	sleep 3
	task_load
	task_log-collect n
	task_log-summary
	curl -X POST --data-urlencode "payload={\"channel\": \"#times-koyama\", \"username\": \"experiment-notice\", \"text\": \"n実験おわり\", \"icon_emoji\": \":ghost:\"}" $(cat .slack-webhook)
}

task_latency-summary() {
	log_files=$(find . -wholename "./logs-*/load-*.log")
	for lf in $log_files
	do
		echo "Latency Summary: $lf"
		basedir=$(echo $lf | cut -f2 -d/)
		cat $lf | sort -k 4,5 | datamash -g 4 median 5 count 5 sum 5 > $basedir/summary.log
	done
}

task_log-length-summary() {
	log_files=$(find . -wholename "./logs-*/*front.log2")
	for lf in $log_files
	do
		dirname=$(echo $lf | cut -f2 -d/)
		echo "length summary: $lf"
		cat $lf | awk '{print length($0)}' | datamash min 1 q1 1 median 1 q3 1 max 1 > $dirname/summary.log-length
		cat $lf | awk '{print length($0)}' | sort -n | datamash -g 1 count 1 > $dirname/summary.log-length-count
	done
}

task_length-response-summary() {
	log_files=$(find . -wholename "./logs-*/2023*.log2")
	for lf in $log_files
	do
		dirname=$(echo $lf | cut -f2 -d/)
		echo $lf
		echo -e "#bytes\t#duration" > $dirname/summary.length-response
		awk '{print $11"\t"$12}' < $lf >> $dirname/summary.length-response
	done
}
