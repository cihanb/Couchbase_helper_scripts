#!/usr/bin/python
import sys
import socket

#parse commandline
if (len(sys.argv) == 1):
	#no argument - fall back to default filename my_couchbase_hosts.txt
	hosts_file = "my_couchbase_hosts.txt"

elif ((sys.argv[1] == "-help") or (sys.argv[1] == "-h") or (sys.argv[1] == "--help") or (sys.argv[1] == "-?")):
	#argument for help
	print ('''list_couchbase_hosts_ssh.py:
Script spits out a properly formatted ssh command for all nodes specified through couchbase_hosts file
Example:
	python list_couchbase_hosts_ssh.py couchbase_hosts.txt

If the couchbase_hosts file is not specified, default file named my_couchbase_hosts.txt is used to acquire the list of couchbase server nodes. 
For details on the formatting of the couchbase_hosts.txt file, see the sample file here: https://raw.githubusercontent.com/cihanb/Couchbase_helper_scripts/master/sample_couchbase_hosts.txt''')
	sys.exit(0)
else:
	#argument for list of couchbase nodes
	hosts_file = sys.argv[1]

#open hosts file
f = open(hosts_file, 'r')
lines=sum(1 for line in open(hosts_file,))
for i in range(0, lines):
	line = f.readline()
	if (line[0] == "#"):
		continue
	port_num,ssh_host,cert_file = line.split(",")
	print ('ssh -p %s %s -i %s -o StrictHostKeyChecking=no' % (port_num.strip(),ssh_host,cert_file.strip()))
f.close()
