#include<errno.h>
#include<stdio.h>
#include<sys/socket.h>
#include<netinet/in.h>


int p6_socket(int domain, int type, int protocol) {
	int s = socket(domain, type, protocol);

	if(s == -1) {
		perror("Open socket: ");
	}

	return s;
}

void main() {
	printf("PF_INET: %d, SOCK_RAW: %d, IPPTOTO_TCP: %d\n", PF_INET, SOCK_RAW, IPPROTO_TCP);
	p6_socket(PF_INET, SOCK_RAW, IPPROTO_TCP);
	p6_socket(2, 3, 0);
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

