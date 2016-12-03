use v6;

use BaseClass;

unit module Layers;

class inet4 is BaseClass::Structure does BaseClass::Serializable is export {
	my @.init_fields = <Version ihl dscp ecn tot_len id flag frag ttl protocol checksum s_addr d_addr opt>;

	multi method new {
		self.bless;
	}

	submethod BUILD {
		self.initField(inet4.init_fields);
	}

	method serialize {

	}

}
