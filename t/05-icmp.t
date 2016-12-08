use v6;
use Test;

use lib 'p6src';
use lib 'p6lib';

use BaseClass;
use Protocol;


plan 1;

my $packet = Protocol::inet4.new;
my $icmp = Protocol::icmp.new;

$icmp.fields<type> = 2;


$packet <-- $icmp;

say "ICMP serialize: ";
$icmp.print-serialized :grouping(32);

say "Packet <-- ICMP serialize: ";
$packet.print-serialized :grouping(32);
