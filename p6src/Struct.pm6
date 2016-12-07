use v6;


unit module Struct;

class NetPacker8 is export {
	has Positional $!buf;
	has int  $!pos;

	multi method new(:$buf) {
		self.bless :$buf;
	}

	submethod BUILD(:$!buf) {
		$!pos = 0;	
	}

	method write-x8(int $x, int $val1, int $val2) returns NetPacker8 {
		my int $mask1 = ( 1 +< $x ) - 1;
		my int $mask2 = ( 1 +< ( 8 - $x ) ) - 1;
		$!buf[$!pos++] = ( ($val1 +& $mask1) +< ( 8 - $x ) ) +|  ( $val2 +& $mask2 );
		self;
	}

	method write-x16(int $x, int $val1, int $val2) returns NetPacker8 {
		my int $mask1 = ( 1 +< $x ) - 1;
		my int $mask2 = ( 1 +< ( 16 - $x ) ) - 1;
		$!buf[$!pos++] = ( ($val1 +& $mask1) +< ( 16 - $x ) ) +|  ( $val2 +& $mask2 );
		self;
	}

	method write8(int $val) returns NetPacker8 {
		$!buf[$!pos++] = $val +& 0xFF;
		self;
	}

	method write16(int $val) returns NetPacker8 {
		$!buf[$!pos++] = ( $val +> 8 ) +& 0xFF;
		$!buf[$!pos++] =   $val        +& 0xFF;
		self;
	}

	method write32(int $val) returns NetPacker8 {
		$!buf[$!pos++] = ( $val +> 24 ) +& 0xFF;
		$!buf[$!pos++] = ( $val +> 16 ) +& 0xFF;
		$!buf[$!pos++] = ( $val +>  8 ) +& 0xFF;
		$!buf[$!pos++] =   $val         +& 0xFF;
		self;
	}

}
