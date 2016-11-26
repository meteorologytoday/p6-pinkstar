# p6-sockraw-ipprotoraw

A perl6 socket package focus on SOCK_RAW and IPPROTO_RAW which enables one to create its own ip packet.

PCAP would be considered.

Goal is to setup a C equivalent:

	#include<sys/socket.h>
	socket(AF_INET, SOCK_RAW, IPPROTO_RAW);


Current developement environment is CentOS 7.2

Another goal is to make a Scapy equivalent.
