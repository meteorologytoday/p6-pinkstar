use v6;
use Test;

use NativeCall;
use RawSocket;
use SockConst;

plan 1;

my iphdr $iphdr = iphdr.new;

$iphdr.version: 100;
$iphdr.ttl = 8;
$iphdr.protocol = 33;

say cbyteorder;

my $word = CArray[uint8].new;

$word[0] = 56;
$word[1] = 70;
$word[2] = 71;
$word[3] = 55;
send2($iphdr, $bufw, 4);


say "New Test";
