use v6;

use BaseClass;
use Protocol;

my $packet = Protocol::inet4.new;
my $icmp = Protocol::icmp.new;

$packet <-- $icmp;



$packet.set-fields :d_addr(0x12345678) :s_addr(0xabcdefab);
$icmp.set-fields :type(8) :code(0) :checksum(0xab) :d_addr(0x8888);

#$icmp.print-serialized;
#$packet.print-serialized;




$packet.emit;

