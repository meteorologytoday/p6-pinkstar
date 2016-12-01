unit module SOCKET_CONSTANTS;
class Domain {
	my $.AF_INET := 2; 
	my $.PF_INET := 2; 
}
class Type {
	my $.SOCK_RAW := 3; 
}
class Protocol {
	my $.IPPROTO_RAW := 255; 
	my $.IPPROTO_TCP := 6; 
}
