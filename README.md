# p6-pinkstar

An attempt to write a Scapy equivalent, experimental tool on perl6.

We use perl6 NativeCall coupled with kernel functions provided by C to manipulate the packet. PCAP would be considered in the future for data-link layer.

Current developement environment is CentOS 7.2



# Setup

## Make

	make            # compile c library and export c constant
	make clean      # remove files

## Environment variable
	. setup.sh      # must use "." to ensure variable P6LIBPATH is exported



# TODO

## Low-level side

- Write send function for ip packet.
- Write recive functions for packet sniffing.

## High-level side

- Implement inet4 "emit" method.
- Write heirachical OSI-model like classes.
