use v6;
use experimental :pack;
unit module BaseClass;

role Serializable {

	method serialize() returns Positional:D { ... }
	method print-serialized(:$grouping = 32) {
		my @buf := self.serialize;
		my $i = 0;

		for @buf {
			print $_.fmt("%02x");
			if ++$i >= $grouping {
				print "\n";
				$i -= $grouping;
			} else {
				print " ";
			}
		}

		print "\n";
	}
}

role Structure is export {

	has %.fields;
	has $.payload is rw;

	method initField (@fields) { # prevent flattening
		for @fields {
			%!fields{$_} = -1;
		}

		$!payload = "";
	}
}

multi sub prefix:<~>(Structure $s) is export {
	my Str $l = "";
	for $s.fields {
		$l ~= ~$_ ~ "\n";
	}
	$l ~= "Payload: [" ~ ~$s.payload ~ "]";

	$l;
}


proto infix:["<--"](Any $a, Any $b) {*}

multi sub infix:["<--"](Structure $a, Structure $b) {
	$a.payload = $b;
}

multi sub infix:["<--"](Structure $a, Str $b) is assoc<left> is export {
	$a.payload = $b;
}

