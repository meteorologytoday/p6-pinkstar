#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <sys/types.h>
#include <asm/byteorder.h>
#include <netinet/ip.h>      // ip header definition


#include <pinkstar.cpp>

#define BUFSIZE 65536

void print_bytes(char * p, size_t len, size_t n) {
	char line[3*n+10+n+1];  // n Hex bytes + 10 whitespace + n ascii + \0
	char * line_p = line;
	char hex[] = "0123456789ABCDEF";

	char c;
	size_t lines = size_t(len / n)+1;
	size_t print_n; 
	for(size_t l = 0; l < lines; ++l) {

		if(l < lines-1) {
			print_n = n;
		} else {
			print_n = len % n;
		}

		for(size_t i = 0; i < print_n; ++i) {
			c = *(p+l*n+i);
			*(line_p++) = hex[(c >> 4) & 0xF];
			*(line_p++) = hex[c & 0xF];
			*(line_p++) = (char) 0x20;
		}

		for(size_t i = 0; i < n - print_n; ++i) {
			strncpy(line_p, "   ", 3);
			line_p += 3;
		}

		strncpy(line_p, "          ", 10); line_p += 10;
	
		for(size_t i = 0; i < print_n; ++i) {

			c = *(p+l*n+i);
			if(c >= 32 && c <= 126 ) {
				*(line_p++) = c;
			} else {
				*(line_p++) = '.';
			}
		}
	
		*line_p = '\0';
		printf("%s\n", line);
		line_p = line;
	}
}


int main() {
	int sd = p6_socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
	char buf[BUFSIZE];
	printf("Start sniffing...\n");
	while(1) {
		ssize_t recv_len = p6_recv_inet4(sd, (P6UINT8 *) buf, BUFSIZE);
		if(recv_len == -1) {
			perror("Receving packet.");
			return 1;
		} 
		if(recv_len != 0) {
			printf("Receive %d bytes.\n", recv_len);
			print_bytes(buf, recv_len, 16);
			return 0;
		}

	}
	printf("Ends sniffing.\n");
	return 0;
}
