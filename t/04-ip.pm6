use v6;
use Test;

use lib 'p6src';
use lib 'p6lib';

use BaseClass;
use Protocol;


plan 1;

my $packet = Protocol::inet4.new;

$packet <-- "Pink stars are falling in line...";

$packet.print-serialized :grouping(32);
