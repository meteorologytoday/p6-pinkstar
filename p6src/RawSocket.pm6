use v6;
unit module RawSocket;

use NativeCall;

constant libpath = "clib/pinkstar"; 

class iphdr is repr('CStruct') is export {

	has uint8  $.version_ihl;
	has uint8  $.tos      is rw;
	has uint16 $.tot_len  is rw;
	has uint16 $.id       is rw;
	has uint16 $.frag_off is rw;
	has uint8  $.ttl      is rw;
	has uint8  $.protocol is rw;
	has uint16 $.check    is rw;
	has uint32 $.saddr    is rw;
	has uint32 $.daddr    is rw;

	method version(int $val) {
		$!version_ihl = ( cbyteorder() == 0 )
						?? ( $!version_ihl +& 0xF0 ) +| (   $val        +& 0xF  )
						!! ( $!version_ihl +&  0xF ) +| ( ( $val +< 4 ) +& 0xF0 );
	}

	method ihl(int $val) {
		$!version_ihl = ( cbyteorder() == 0 )
						?? ( $!version_ihl +& 0xF   ) +| ( ( $val +< 4 ) +& 0xF0 )
						!! ( $!version_ihl +& 0xF0  ) +| (   $val        +&  0xF );
	}

	method clone-fields(%t) {
		self.version(%t<version>);
		self.ihl(%t<ihl>);

		$!
	}
}

sub cbyteorder() returns uint32 is native(libpath) is symbol('p6_cbyteorder') is export { ... }
sub send(int32, int32, int32) returns size_t is native(libpath) is symbol('p6_send') is export { ... }
sub send_inet4(int32, CArray[uint8], uint32, uint32) returns int32 is native(libpath) is symbol('p6_send_inet4') is export { ... }
sub send_test(int32, iphdr, CArray[uint8], uint32) returns int32 is native(libpath) is symbol('p6_send_test') is export { ... }
sub socket(int32, int32, int32) returns int32 is native(libpath) is symbol('p6_socket') is export { ... }
sub close(int32) returns int32 is native(libpath) is symbol('p6_close') is export { ... }

sub htonl(uint32) returns uint32 is native(libpath) is symbol('p6_htonl') is export { ... }
sub ntohl(uint32) returns uint32 is native(libpath) is symbol('p6_ntohl') is export { ... }
sub htons(uint16) returns uint16 is native(libpath) is symbol('p6_htons') is export { ... }
sub ntohs(uint16) returns uint16 is native(libpath) is symbol('p6_ntohs') is export { ... }

sub print_byte_sequence(CArray[uint8], size_t) is native(libpath) is symbol('print_byte_sequence') is export { ... }
