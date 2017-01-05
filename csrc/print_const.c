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

int main(int argc, char **argv) {

	module("SockConst");

	class_head("Domain");
	def("AF_INET", AF_INET);
	def("PF_INET", PF_INET);
	def("AF_PACKET", AF_PACKET);
	class_tail();

	class_head("Type");
	def("SOCK_RAW", SOCK_RAW);	
	class_tail();

	class_head("Protocol");
	def("IPPROTO_RAW", IPPROTO_RAW);	
	def("IPPROTO_TCP", IPPROTO_TCP);	
	def("ETH_P_ALL"  , htons(ETH_P_ALL));	
	def("", IPPROTO_TCP);	
	class_tail();

	return 0;
}
