use v6;

use BaseClass;

unit module Layers;

class inet4 is BaseClass::Structure is export {

	multi method new {
		self.bless;
	}

	submethod BUILD {

		self.initField(
			("Version", 4), 
			("IHL", 4), 
			("DSCP", 6), 
			("ECN", 2), 
			("TotalLength", 16), 
			("Identification", 8), 
			("Flags", 3), 
			("FragmentOffset", 13), 
			("ttl", 8), 
			("Protocol", 8), 
			("Checksum", 16), 
			("SourceIP", 32), 
			("DestinationIP", 32),
			("Options", -1)
		);
	}

}
