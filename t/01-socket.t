use v6;
use Test;

use lib 'p6src';
use lib 'p6lib';

use RawSocket;
use SockConst;

plan 1;

my $s = socket(SockConst::Domain.AF_INET, SockConst::Type.SOCK_RAW, SockConst::Protocol.IPPROTO_RAW);

isnt $s, -1, "Socket number is -1 on failure.";

