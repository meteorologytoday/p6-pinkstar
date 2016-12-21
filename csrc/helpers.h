void print_byte_sequence(uint8_t * p, size_t len) {
	char hex[] = "0123456789ABCDEF";
	for(size_t i = 0; i < len; ++i) {
		uint8_t c = *(((uint8_t *)p) + i);
		printf("%c%c ", hex[c >> 4], hex[c & 0xF]);
		if(i % 16 == 0 && i != 0) {
			printf("\n");
		}
	}

	if(len % 16 != 0) {
		printf("\n");
	}
}

