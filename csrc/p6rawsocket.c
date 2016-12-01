#include<errno.h>
#include<stdio.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include <unistd.h>
#include <sys/types.h>

#include "pinkstar_ctypes.h"




P6INT32 p6_socket(P6INT32 domain, P6INT32 type, P6INT32 protocol) {
	printf("init errno: [%d]\n", errno);
	char cwd[1024];
	getcwd(cwd, sizeof(cwd));
	printf("uid: %d; euid: %d\n", getuid(), geteuid());
	printf("cwd: %s\n", cwd);
	printf("(%d, %d, %d)\n", domain, type, protocol);
	errno=0;
	int s = socket(domain, type, protocol);
	printf("errno: [%d], s = %d\n", errno, s);
	perror("Open socket");
	return s;
}

P6SSIZE_T p6_send(P6INT32 sockfd, P6PTR buf, P6SIZE_T len, P6INT32 flags) {
	return send(sockfd, buf, len, flags);
}


P6INT32 p6_setsockopt(P6INT32 sockfd, P6INT32 level, P6INT32 optname, P6PTR optval, P6SOCKLEN_T optlen) {
	return setsockopt(sockfd, level, optname, optval, optlen);
}

P6UINT32 p6_htonl(P6UINT32 hostlong)  { return htonl(hostlong);  }
P6UINT32 p6_ntohl(P6UINT32 netlong)   { return htonl(netlong);   }
P6UINT16 p6_htons(P6UINT16 hostshort) { return htons(hostshort); }
P6UINT16 p6_ntohs(P6UINT16 netshort)  { return ntohs(netshort); }

int main(int argc, char **argv) {
	p6_socket(PF_INET, SOCK_RAW, IPPROTO_RAW);
	return 0;
}




/*
int getsockopt(int sockfd, int level, int optname, void *optval, socklen_t *optlen);
int setsockopt(int sockfd, int level, int optname, const void *optval, socklen_t optlen);
*/

/*
    Generic checksum calculation function
*/

unsigned short p6_csum(unsigned short *ptr,int nbytes) {
    register long sum;
    unsigned short oddbyte;
    register short answer;
 
    sum=0;
    while(nbytes>1) {
        sum+=*ptr++;
        nbytes-=2;
    }
    if(nbytes==1) {
        oddbyte=0;
        *((u_char*)&oddbyte)=*(u_char*)ptr;
        sum+=oddbyte;
    }
 
    sum = (sum>>16)+(sum & 0xffff);
    sum = sum + (sum>>16);
    answer=(short)~sum;
     
    return(answer);
}

