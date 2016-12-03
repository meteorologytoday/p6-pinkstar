use v6;

unit module BaseClass;

role Serializable {
	method serialize() returns buf8:D { ... }
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
	my str $l = "";
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

