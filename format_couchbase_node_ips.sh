#!/bin/sh
IFS=$'\r\n'
GLOBIGNORE='*'
eval 'value=($(python format_couchbase_hosts_ssh.py))'
for i in ${value[@]}; do
	eval $i 'ifconfig'
	cmd="$i 'ifconfig | grep 10.0.0. | cut -d\":\" -f 2 | cut -d\" \" -f 1'"
    node_ip=$(eval $cmd)
    echo $node_ip >> output_couchbase_node_ips.txt
done
