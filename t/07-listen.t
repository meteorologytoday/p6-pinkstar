use v6;

use BaseClass;
use SockConst;
use Protocol;
use NativeCall;
use Packer;

class IPSniffer {
	multi method new {
		self.bless;
	}

	submethod BUILD {

	}

	method beg-sniff {

		my size_t $bufsize = 65536;
		my $recv_len;

		my int $sd = socket(SockConst::Domain.AF_PACKET, SockConst::Type.SOCK_RAW, SockConst::Protocol.ETH_P_ALL);
		my @buf := CArray[uint8].new;
		@buf[$bufsize] = 0;

		loop {
			$recv_len = recv_inet4($sd, @buf, $bufsize);
			
		}
		
		
	}

	method ouch {
		
	}

	method pop {
		
	}
}




my $sniffer = IPSniffer.new;

$sniffer.beg-sniff :count(10)

while $sniffer.ouch {
	my $packet = $sniffer.pop
	print ~$packet
}
