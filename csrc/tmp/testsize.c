#include<stdio.h> //for printf
#include<string.h> //memset
#include<sys/socket.h>    //for socket ofcourse
#include<stdlib.h> //for exit(0);
#include<errno.h> //For errno - the error number
#include<netinet/tcp.h>   //Provides declarations for tcp header
#include<netinet/ip.h>    //Provides declarations for ip header

void main(int n, char** args) {


	printf("size of socketaddr: %d bytes.\n", sizeof(struct sockaddr));
	printf("size of socketaddr_in: %d bytes.\n", sizeof(struct sockaddr_in));



}

