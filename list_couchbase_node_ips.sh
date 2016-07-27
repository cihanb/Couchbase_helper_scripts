#!/bin/sh
IFS=$'\r\n'
GLOBIGNORE='*'
eval 'value=($(python list_couchbase_hosts_ssh.py))'
for i in ${value[@]}; do
	cmd="$i 'ifconfig | grep 10.0.0. | cut -d\":\" -f 2 | cut -d\" \" -f 1'"
    node_ip=$(eval $cmd)
    echo $node_ip
done
