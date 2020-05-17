#! /bin/bash

Container=$(docker ps | grep remote-atom)
	i=1
	echo "Stopping Remote Atom Docker Container"
	sleep 1

	if [[ $Container != "" ]]; then
		while [[ $Container != "" && $i < 3 ]]; do
			echo "Attempt: " && echo $i
	 		echo "Running: " && echo $Container
			echo "Attempting to Killing Container"
			sleep 1
			docker stop remote-atom
			sleep 1
			((++i))
			Container=$(pgrep -f "jupyter-notebook")
		done

		if [ $i -ge 5 ]; then
			echo "*****Kill attempts on remote Atom docker container Failed****"
			echo "*************Exiting Script*************"
			exit 2
		fi

	else
		echo "Remote Atom docker container not running"
	fi

	if [[ $i > 1 ]]; then
		echo "Kill attempts successful"
	fi
