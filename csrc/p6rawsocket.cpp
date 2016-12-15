#include<errno.h>
#include<stdio.h>
#include<stdlib.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include <unistd.h>
#include <sys/types.h>
#include <asm/byteorder.h>
#include "pinkstar_ctypes.h"
#include<netinet/ip.h>    //Provides declarations for ip header

/* Info about sock_raw please refer to : man 7 RAW */


extern "C" { // prevent from c++ name mangling

//typedef struct iphdr p6_iphdr;
/*
struct p6_iphdr {
	P6UINT32 version;
  	P6UINT32 ihl;
	P6UINT32 tos;
	P6UINT32 tot_len;
	P6UINT32 id;
	P6UINT32 frag_off;
	P6UINT32 ttl;
	P6UINT32 protocol;
	P6UINT32 check;
	P6UINT32 saddr;
	P6UINT32 daddr;
};
*/

struct iphdr& p6_allocate_iphdr() {
	return *( (struct iphdr*) malloc(sizeof(struct iphdr)) );
}

P6INT32 p6_cbyteorder() {

#if defined(__LITTLE_ENDIAN_BITFIELD)
	return 0;
#elif defined (__BIG_ENDIAN_BITFIELD)
	return 1;
#else
#error	"Please fix <asm/byteorder.h>"
#endif

}

void p6_setup_header_inet4(struct iphdr &hdr) {
	
}


P6INT32 p6_send_inet4(P6INT32 sd, struct iphdr &hdr, P6CHAR *data, P6UINT32 c_len) {

	struct sockaddr_in d_sin;
	d_sin.sin_family = AF_INET;
	d_sin.sin_port = 0;
	d_sin.sin_addr.s_addr = hdr.daddr;

	printf("hdr.tot_len = %d\n", hdr.tot_len);

	errno = 0;
	if(sendto(sd, data, hdr.tot_len, 0, (struct sockaddr *) &d_sin, sizeof(d_sin)) < 0) {
		perror("sendto\n");
	} else {
		printf("Packet sent. Length: %d bytes.\n", hdr.tot_len);
	}

	return sd;
}

P6INT32 p6_send_test(P6INT32 sd, struct iphdr &hdr, P6CHAR *data, P6UINT32 c_len) {
	printf("send_test\n");

	struct sockaddr_in d_sin;
	d_sin.sin_family = AF_INET;
	d_sin.sin_port = 0;
	d_sin.sin_addr.s_addr = 1;

	printf("C size of header: %d\n", sizeof(hdr));
	for(int i=0; i < sizeof(hdr) ; ++i) {
		printf("%c - ", *((char *) (&hdr + i)) );
	}
	printf("\n");

	errno = 0;
	printf("This is a test\n");


	return sd;
}





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

P6INT32 p6_close(P6INT32 fd) {
	return close(fd);
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

	errno = 0;
	int s = socket(AF_INET, SOCK_DGRAM, IPPROTO_TCP);
	if(s == -1) {
		perror("socket");
	}

	return 0;

/*
	char msg[10];
	int i;
	for(i = 0; i < 10; ++i) { msg[i] = (char)((int)('a') + i); }
	for(i = 0; i < 10; ++i) { printf("msg[%d] = %c\n", i, msg[i]); }

	printf("Going to open socket...\n");
	P6INT32 s = p6_socket(PF_INET, SOCK_RAW, IPPROTO_RAW);

	int enable = 1;
	if( setsockopt(s, IPPROTO_IP, IP_HDRINCL, &enable, sizeof(enable)) < 0 ) {
		perror("setsockopt");
	}
	printf("Going to send msg...\n");

	while(1) {
		printf("Send msg...");
		int result = p6_send(s, msg, 10, 0);
		printf("done\n");

		if(result == -1) {
			perror("Error while sending msg.");
			break;
		}
	}

	printf("Exiting program...\n");
	return 0;
*/
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
}
