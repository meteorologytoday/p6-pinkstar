use v6;

use BaseClass;
use Packer;

unit module Protocol;

class inet4 is BaseClass::Structure does BaseClass::Serializable is export {
	my @.init_fields = <Version ihl dscp ecn tot_len id flag frag ttl protocol checksum s_addr d_addr opt>;

	multi method new {
		self.bless;
	}	

	submethod BUILD {
		self.initField(inet4.init_fields);
	}

	method serialize returns Array {
		NetPacker8.new
			.write-x8(4, self.fields<Version>, self.fields<ihl>)
			.write-x8(6, self.fields<dscp>, self.fields<ecn>)
			.write16(self.fields<tot_len>)
			.write16(self.fields<id>)
			.write-x16(3, self.fields<flag>, self.fields<frag>)
			.write8(self.fields<ttl>)
			.write8(self.fields<protocol>)
			.write16(self.fields<checksum>)
			.write32(self.fields<s_addr>)
			.write32(self.fields<d_addr>)
			.write-payload(self.payload);
	}

}


class icmp is BaseClass::Structure does BaseClass::Serializable is export {
	my @.init_fields = <type code checksum rest>;

	multi method new {
		self.bless;
	}	

	submethod BUILD {
		self.initField(icmp.init_fields);
	}

	method serialize returns Array {
		self.cal-checksum;

		NetPacker8.new
			.write8(self.fields<type>)
			.write8(self.fields<code>)
			.write16(self.fields<checksum>)
			.write32(self.fields<rest>)
			.write-payload(self.payload);
	}

	method cal-checksum {
		self.fields<checksum> = 
		    ( ( self.fields<type> +< 8 ) 
		    + ( self.fields<code> +& 0xFF )
		    + ((self.fields<rest> +> 16 ) )
		    +   self.fields<rest> ) +& 0xFFFF;
	}

}
