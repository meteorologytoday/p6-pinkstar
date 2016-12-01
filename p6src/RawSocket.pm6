use v6;
unit module RawSocket;

use NativeCall;

constant libpath = "clib/p6rawsocket"; 

sub socket(int32, int32, int32) returns int32 is native(libpath) is symbol('p6_socket') is export { ... }

sub send(int32, int32, int32) returns size_t is native(libpath) is symbol('p6_send') is export { ... }

sub htonl(uint32) returns uint32 is native(libpath) is symbol('p6_htonl') is export { ... }
sub ntohl(uint32) returns uint32 is native(libpath) is symbol('p6_ntohl') is export { ... }
sub htons(uint16) returns uint16 is native(libpath) is symbol('p6_htons') is export { ... }
sub ntohs(uint16) returns uint16 is native(libpath) is symbol('p6_ntohs') is export { ... }
