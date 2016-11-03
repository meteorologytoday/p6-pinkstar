#include<stdio.h>
#include<sys/socket.h>
#include<netinet/in.h>

void def(char *str, int val) {
	printf("\tmy $.%s := %d; \n", str, val);
}

void class_head(char *classname) {
	printf("class %s {\n", classname);
}

void class_tail() {
	printf("}\n");
}

void module(char *m) {
	printf("unit module %s;\n", m);
}

void main() {

	module("SOCKET_CONSTANTS");

	class_head("Domain");
	def("AF_INET", AF_INET);
	class_tail();

	class_head("Type");
	def("SOCK_RAW", SOCK_RAW);	
	class_tail();

	class_head("Protocol");
	def("IPPROTO_IP", IPPROTO_IP);	
	def("IPPROTO_TCP", IPPROTO_TCP);	
	class_tail();

}
