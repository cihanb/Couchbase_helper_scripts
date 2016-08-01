#!/bin/sh
IFS=$'\r\n'
GLOBIGNORE='*'
GREEN=`tput setaf 2`
RESET=`tput sgr0`

#display help if not commandline parameter
if [[ $1 == "" ]]
then
  echo "Provide a command to run on all nodes specified by the couchbase_hosts file. If couchbase_hosts file isn't specified, the default couchbase_hosts file (my_couchbase_hosts.txt) is used."
  echo ""
  echo "Following example confirms there is a listener active on port 8091 across all nodes"
  echo "  ./exec_command_on_all_nodes.sh 'netstat -a | grep 8091' 'prod_couchbase_hosts.txt'" 
  exit 0
fi
if [[ $2 == "" ]]
then
  echo "You have not provided a couchbase_hosts file. Will be using the my_couchbase_hosts.txt file as default to iterate over couchbase server nodes."
  couchbase_hosts=""
else
  couchbase_hosts=$2
fi

cmd='value=($(python list_couchbase_hosts_ssh.py '$couchbase_hosts'))'
eval $cmd
for i in ${value[@]}; do
  cmd="$i '$1'"
  echo ""
  echo "#############################################################################################"
  echo "# RUNNING: "$cmd
  node_output=$(eval $cmd)
  cmd="$i 'ifconfig | grep 10.0.0. | cut -d\":\" -f 2 | cut -d\" \" -f 1'"
  node_ip=$(eval $cmd)
  echo "################################## NODE: $node_ip - START ##################################"
  echo "$node_output"
  echo "################################## NODE: $node_ip - END   ##################################"
done
