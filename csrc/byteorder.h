P6INT32 p6_cbyteorder() {

#if defined(__LITTLE_ENDIAN_BITFIELD)
	return 0;
#elif defined (__BIG_ENDIAN_BITFIELD)
	return 1;
#else
#error	"Please fix <asm/byteorder.h>"
#endif

}


