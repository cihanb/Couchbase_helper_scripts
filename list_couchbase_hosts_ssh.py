#!/usr/bin/python
import sys
import socket

#my_couchbase_hosts.txt is thee corrected version of the sample_couchbase_hosts.txt file
f = open("my_couchbase_hosts.txt", 'r')
lines=sum(1 for line in open("my_couchbase_hosts.txt"))
for i in range(0, lines):
	line = f.readline()
	if (line[0] == "#"):
		continue
	port_num,ssh_host,cert_file = line.split(",")
	print ('ssh -p %s %s -i %s -o StrictHostKeyChecking=no' % (port_num.strip(),ssh_host,cert_file.strip()))
f.close()
