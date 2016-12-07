use v6;
use Test;

use lib 'p6src';
use lib 'p6lib';

use BaseClass;
use Layers;


plan 1;

my $packet =  Layers::inet4.new;
my $packet2 =  Layers::inet4.new;

# Test opeartor &infix:["<--"]
$packet <-- $packet2 <-- "This is message!";

say "\n===\nStringify packet";
say ~$packet;

for $packet.serialize {
	say "[$_]";
}
