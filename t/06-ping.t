use v6;

use BaseClass;
use Protocol;

my $packet = Protocol::inet4.new;
my $icmp = Protocol::icmp.new;

$packet <-- $icmp;

$icmp.set-fields :type(8) :code(0) :checksum(0xab);

$icmp.print-serialized;
$packet.print-serialized;
