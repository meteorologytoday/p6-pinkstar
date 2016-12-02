use v6;
use Test;

use lib 'p6src';
use lib 'p6lib';

use NativeCall;
use RawSocket;
use SockConst;

plan 1;

my iphdr $iphdr = iphdr.new;

$iphdr.version: 100;
$iphdr.ttl = 8;
$iphdr.protocol = 33;

say cbyteorder;

send2($iphdr, "test");
