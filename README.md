Repo of a few useful scripts for couchbase server deployments

## Getting Started
To get started, edit the _sample_couchbase_hosts.txt_ file to point to the hosts in the cluster. You 
will be feeding this file into many of the scripts.

## Scripts
* exec_command_on_all_nodes.sh: Allows executing a given command on all nodes.

    ```
    ./exec_command_on_all_nodes 'sudo service ntp status'
    ```
* list_couchbase_node_ips.sh: Return IPs of all nodes in the cluster.

    ```
    ./list_couchbase_node_ips.sh
    ```
* list_couchbase_hosts_ssh.py: used to generate the proper SSH for all hosts. typically

    ```
    python list_couchbase_hosts_ssh.py
    ```  
