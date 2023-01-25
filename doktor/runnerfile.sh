#!/bin/bash

task_deploy() {
	kuebctl apply -f complete-doktor-customize2.yml
	./configmap-deploy.sh
	./filter-deploy.sh
}
