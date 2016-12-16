use v6;
unit module BaseClass;

role Serializable is export {

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

	method initField (@fields) {
		for @fields {
			%!fields{$_.key} = $_.value;
			#say "{$_.key}\t=>\t{$_.value}";
		}

		$!payload = "";
	}

	method set-fields(*%h) {
		for %h.kv -> $k, $v {
			%!fields{$k} = $v;
		}
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


proto infix:["<--"](Any $a, Any $b) is export {*}

multi sub infix:["<--"](Structure $a, Structure $b) is export {
	$a.payload = $b;
}

multi sub infix:["<--"](Structure $a, Str $b) is assoc<left> is export {
	$a.payload = $b;
}

#multi sub postcircumfix:<{ }>(Structure $a, $key) is rw is export {
#	$a.fields{$key};
#}


