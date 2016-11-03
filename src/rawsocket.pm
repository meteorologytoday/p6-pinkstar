use v6;
use NativeCall;

use lib '.';
use SOCKET_CONSTANTS;


my $lib = 'p6rawsocket';


sub socket(int16, int16, int16) returns int16 is native('./p6rawsocket') is symbol('p6_socket') { ... }

#my $s = socket(2, 0, 0);

say "AF_INET = " ~ SOCKET_CONSTANTS::Domain.AF_INET;
say "IPPROTO_TCP = " ~ SOCKET_CONSTANTS::Protocol.IPPROTO_TCP;
