#!/bin/sh
IFS=$'\r\n'
GLOBIGNORE='*'

#display help if not commandline parameter
if [[ $1 == "" ]]
then
  echo "Provide a command to run on all nodes."
  echo "Following example confirms there is a listener active on port 8091 across all nodes"
  echo "  ./exec_command_on_all_nodes.sh 'netstat -a | grep 8091'"
  exit 0
fi

eval 'value=($(python list_couchbase_hosts_ssh.py))'
for i in ${value[@]}; do
	cmd="$i '$1'"
    node_output=$(eval $cmd)
    cmd="$i 'ifconfig | grep 10.0.0. | cut -d\":\" -f 2 | cut -d\" \" -f 1'"
    node_ip=$(eval $cmd)
    echo "################################## NODE: $node_ip - START ##################################"
    echo "$node_output"
    echo "################################## NODE: $node_ip - END   ##################################"
done
