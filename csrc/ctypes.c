#include<stdio.h>
#include<sys/socket.h>


#define SZ(type) sizeof(type)

void printsize(char *typename, size_t size) {
	printf("%s=%d\n", typename, size);
}


int main() {

	printsize("size_t",  SZ(size_t));
	printsize("ssize_t", SZ(ssize_t));
	printsize("int", SZ(int));
	printsize("short", SZ(short));

	return 0;
}
