=begin info

Module: Packer
Author: Hsu, Tien-Yiao
Modified Date: 2016-12-09
Description:

Module Packer provides NetPacker8 (Net-endianess, 8 bits per element)
with methods to input data without worry about endianess.

=end info

use v6;

use BaseClass;
use NativeCall;

unit module Packer;

class NetPacker8 is Array is export {
	has uint $.pos is rw = 0;

	multi method new {
		self.bless;
	}

	submethod BUILD {
	}

	method write-x8(int $x, int $val1, int $val2) returns NetPacker8 {
		my int $mask1 = ( 1 +< $x ) - 1;
		my int $mask2 = ( 1 +< ( 8 - $x ) ) - 1;
		self[$!pos++] = ( ($val1 +& $mask1) +< ( 8 - $x ) ) +|  ( $val2 +& $mask2 );
		self;
	}

	method write-x16(int $x, int $val1, int $val2) returns NetPacker8 {
		my int $mask1 = ( 1 +< $x ) - 1;
		my int $mask2 = ( 1 +< ( 16 - $x ) ) - 1;
		my int $tmp = ( ($val1 +& $mask1) +< ( 16 - $x ) ) +|  ( $val2 +& $mask2 );
		self[$!pos++] = ( $tmp +> 8 ) +& 0xFF;
		self[$!pos++] =   $tmp        +& 0xFF;
		self;
	}

	method write8(int $val) returns NetPacker8 {
		self[$!pos++] = $val +& 0xFF;
		self;
	}

	method write16(int $val) returns NetPacker8 {
		self[$!pos++] = ( $val +> 8 ) +& 0xFF;
		self[$!pos++] =   $val        +& 0xFF;
		self;
	}

	method write32(int $val) returns NetPacker8 {
		self[$!pos++] = ( $val +> 24 ) +& 0xFF;
		self[$!pos++] = ( $val +> 16 ) +& 0xFF;
		self[$!pos++] = ( $val +>  8 ) +& 0xFF;
		self[$!pos++] =   $val         +& 0xFF;
		self;
	}

	multi method write-payload(BaseClass::Serializable $a) returns NetPacker8 {
		self.write-payload($a.serialize);
	}

	multi method write-payload(@a) returns NetPacker8 {
		for @a {
			self[$!pos++] = $_ +& 0xFF;
		}
		self;
	}

	multi method write-payload(Str $s, :$encoding = 'ascii') returns NetPacker8 {
		for $s.encode(:$encoding) {
			self[$!pos++] = $_ +& 0xFF;
		}

		self;
	}

	method get-CArray returns CArray[uint8] {
		my @arr := CArray[uint8].new;
		for 0..(self.elems - 1) {
			@arr[$_] = self[$_];
		}
		
		@arr;
	}
}
