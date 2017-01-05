P6INT32 p6_setsockopt(P6INT32 sockfd, P6INT32 level, P6INT32 optname, P6PTR optval, P6SOCKLEN_T optlen) {
	return setsockopt(sockfd, level, optname, optval, optlen);
}

P6UINT32 p6_htonl(P6UINT32 hostlong)  { return htonl(hostlong);  }
P6UINT32 p6_ntohl(P6UINT32 netlong)   { return htonl(netlong);   }
P6UINT16 p6_htons(P6UINT16 hostshort) { return htons(hostshort); }
P6UINT16 p6_ntohs(P6UINT16 netshort)  { return ntohs(netshort); }


void * addr2str(uint32_t addr, char * str) {
	sprintf(str, "%d.%d.%d.%d", \
		addr >> 24, \
		(addr >> 16) & 0xFF,
		(addr >>  8) & 0xFF,
		addr & 0xFF);

	return str;
}

P6SSIZE_T p6_recv_inet4(P6INT32 sd, P6UINT8 * buf, P6SIZE_T buf_size) {
	return recvfrom(sd, buf, buf_size, 0, NULL, NULL);
}

P6INT32 p6_send_inet4(P6INT32 sd, P6UINT8 * data, P6UINT32 c_len) {
	struct iphdr hdr;
	void * p = data;
	char addr_str[64];

	print_byte_sequence(data, c_len);

	hdr.version = ( *((uint8_t *)p) >> 4 ) & 0xF;
	hdr.ihl     = *((uint8_t *)p) & 0xF;

	p = data + 1;
	hdr.tos = *((uint8_t *)p);

	p = data + 2;
	hdr.tot_len = *((uint16_t *)p);

	p = data + 4;
	hdr.id = *((uint16_t *)p);

	p = data + 8;
	hdr.ttl = *((uint8_t *)p);

	p = data + 9;
	hdr.protocol = *((uint8_t *)p);

	p = data + 10;
	hdr.check = *((uint16_t *)p);

	p = data + 12;
	hdr.saddr = *((uint32_t *)p);

	p = data + 16;
	hdr.daddr = *((uint32_t *)p);

	#ifdef DEBUG

	print_byte_sequence((uint8_t *) &hdr, sizeof(hdr));


	printf("version: %d\n", hdr.version);
	printf("ihl: %d\n", hdr.ihl);
	printf("tos: %d\n", hdr.tos);
	printf("tot_len: %d\n", ntohs(hdr.tot_len));
	printf("id: %d\n", ntohs(hdr.id));
	printf("ttl: %d\n", hdr.ttl);
	printf("protocol: %d\n", hdr.protocol);
	printf("check: %d\n", ntohs(hdr.check));
	printf("saddr: %s\n", addr2str(ntohl(hdr.saddr), addr_str));
	printf("daddr: %s\n", addr2str(ntohl(hdr.daddr), addr_str));

	#endif

	struct sockaddr_in d_sin;
	d_sin.sin_family = AF_INET;
	d_sin.sin_port = 0;
	d_sin.sin_addr.s_addr = hdr.daddr;

	printf("hdr.tot_len = %d\n", ntohs(hdr.tot_len));

	errno = 0;
	ssize_t sent_bytes = sendto(sd, data, htons(hdr.tot_len), 0, (struct sockaddr *) &d_sin, sizeof(d_sin));
	if (sent_bytes < 0) {
		perror("sendto\n");
	} else {
		printf("Packet sent. Length: %d bytes.\n", sent_bytes);
	}

	return (sent_bytes == -1) ? -1 : (P6INT32) sent_bytes ;
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


