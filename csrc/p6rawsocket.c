#include<errno.h>
#include<stdio.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include <unistd.h>
#include <sys/types.h>

int p6_socket(int domain, int type, int protocol) {
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

ssize_t p6_send(int sockfd, const void *buf, size_t len, int flags) {
	return send(sockfd, buf, len, flags);
}


void p6_setsockopt();
void p6_htonl();
void p6_ntohl();
void p6_htons();
void p6_ntohs();

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

