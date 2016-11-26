use v6;

unit module BaseClass;

class Field is export {

	has Str $.name;
	has Int $.size;  # size in bits

	multi method new(*%h) {
		self.bless(%h);
	}

	multi method new(Str $name, Int $size) {
		self.bless(:$name, :$size);
	}

	submethod BUILD(:$!name, :$!size) {}

}

multi sub prefix:<~>(Field $f) is export {
	"{$f.name} ({$f.size})";
}

class Structure is export {

	has Field @.fields;
	has $.payload is rw;


	multi method new {
		self.bless;
	}

	submethod BUILD {
	}

	method initField (**@fields) { # prevent flattening
		for @fields {
			@!fields.push: Field.new($_[0], $_[1]);
		}

		$!payload = "";
	}

	method print-fields {
		for @!fields {
			say ~$_;
		}
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

