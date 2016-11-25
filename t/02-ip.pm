use v6;
use Test;

use lib 'p6src';
use lib 'p6lib';

use Layers;

plan 1;

my $packet =  Layers::inet4.new;

$packet.print-fields;




