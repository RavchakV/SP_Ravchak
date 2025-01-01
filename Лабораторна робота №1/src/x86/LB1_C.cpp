#include <stdio.h>
extern "C" unsigned int calc(short, char, int);
extern "C" unsigned int K = 0x2B05025;
int main()
{
	short B;
	char C;
	int E;
	int X;
	printf("Enter numbers:\n");
	printf("B = ");
	scanf_s("%hd", &B);
	printf("C = ");
	scanf_s("%hhd", &C);
	printf("E = ");
	scanf_s("%d", &E);
	printf("\n=(K-B-C)*2+E/4 = %x\n", ((K - B - C) * 2) + (E / 4));
	X = calc(B, C, E);
	printf("\nResult of procedure calc is: %x\n", X);
	return 0;
}