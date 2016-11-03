# p6-sockraw-ipprotoraw

A perl6 socket package focus on SOCK_RAW and IPPROTO_RAW which enables one to create its own ip packet.

Goal is to setup a C equivalent:

	#include<sys/socket.h>
	socket(AF_INET, SOCK_RAW, IPPROTO_RAW);

