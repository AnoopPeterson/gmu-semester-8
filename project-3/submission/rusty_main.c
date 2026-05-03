#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

extern int rusty_main();

int input_v = 20;
char *S0 = "%d";
char *S1 = "%d ";


int rusty_input() {
	int d = 0;
	if (!isatty(fileno(stdin))) {
		if (scanf("%d", &d) == 1) return d;
	}
	return rand() % input_v;
}

int
main(int argc, char **argv) {
	time_t t;
	srand((unsigned) time(&t));
	if (argc > 1) input_v = atoi(argv[1]);
	if (input_v <= 0) input_v = 20;
	rusty_main();
	return 0;
}
