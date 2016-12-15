use v6;

use RawSocket;
use SockConst;
use BaseClass;
use Packer;
use NativeCall;
unit module Protocol;

class inet4 is BaseClass::Structure does BaseClass::Serializable is export {
	my @.init_fields = {
		:version(0),
		:ihl(0),
		:dscp(0),
		:ecn(0),
		:tot_len(0),
		:id(0),
		:flag(0),
		:ttl(16),
		:protocol(0),
		:checksum(0),
		:s_addr(0),
		:d_addr(0),
		:opt(0)
	};

	has int $!opt-len = 0;

	multi method new {
		self.bless;
	}	

	submethod BUILD {
		self.initField(inet4.init_fields);
	}

	method serialize returns Array {
		say ~self.fields;
		NetPacker8.new
			.write-x8(4, self.fields<version>, self.fields<ihl>)
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

	method cal-checksum {
		
	}

	method wrap-up(*%h) {

		self.fields<tot_len> = 128 + $!opt-len;
		
		# TODO
		# self.fields<checksum> = self.cal-checksum;
		
		

	}

	method emit {

		self.wrap-up;

		my $data = self.serialize.get-CArray;
		my $header = RawSocket::iphdr.new;

		$header.clone-fields(self.fields);

		my int $sd = socket(SockConst::Domain.AF_INET, SockConst::Type.SOCK_RAW, SockConst::Protocol.IPPROTO_RAW);


		my $result = send_inet4($sd, $header, $data, $data.elems, 1);
		say "Result: $result";
		
	}
}


class icmp is BaseClass::Structure does BaseClass::Serializable is export {
	my @.init_fields = {
		:type(0),
		:code(0),
		:checksum(0),
		:rest(0)
	};

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
