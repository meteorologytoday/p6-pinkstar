use v6;
use Test;

use lib 'p6src';
use lib 'p6lib';

use RawSocket;
use SocketConst;

plan 1;

my $s = socket(2,3,255);

isnt $s, -1, "Socket number is -1 on failure.";

