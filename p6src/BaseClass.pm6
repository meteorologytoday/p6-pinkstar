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

multi sub prefix:<~>(Field $f) {
	"{$f.name} ({$f.size})";
}

class Structure is export {

	has Field @.fields;


	multi method new {
		self.bless;
	}

	submethod BUILD {
	}

	method initField (**@fields) { # prevent flattening
		for @fields {
			@!fields.push: Field.new($_[0], $_[1]);
		}
	}

	method print-fields {
		for @!fields {
			say ~$_;
		}
	}
}
