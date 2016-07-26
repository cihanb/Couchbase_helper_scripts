#!/usr/bin/python
import sys
import socket

#file=sys.argv[1]
f = open("couchbase_hosts.txt", 'r')
lines=sum(1 for line in open("couchbase_hosts.txt"))
for i in range(0, lines):
	line = f.readline()
	if (line[0] == "#"):
		continue
	port_num,ssh_host,cert_file = line.split(",")
	print'ssh -p %s %s -i %s -o StrictHostKeyChecking=no' % (port_num.strip(),ssh_host,cert_file.strip())
f.close()
