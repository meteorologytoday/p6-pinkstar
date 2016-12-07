use v6;

use BaseClass;
use NetPacker8;

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
		my @p := NetPacker8.new;
		
		@p
			.write-x8(4, self.fields<Version>, self.fields<ihl>)
			.write-x8(6, self.fields<dscp>, self.fields<ecn>)
			.write16(self.fields<tot_len>)
			.write16(self.fields<id>)
			.write-x16(3, self.fields<flag>, self.fields<frag>)
			.write8(self.fields<ttl>)
			.write8(self.fields<protocol>)
			.write16(self.fields<checksum>)
			.write32(self.fields<s_addr>)
			.write32(self.fields<d_addr>);

#		say "WHERE: {@p.WHERE}, size: {@p.elems}, pos: {@p.pos}";
		@p;
	}

}
