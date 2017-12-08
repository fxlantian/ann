#include "utils.h"

#define M 8
double cos1[M][M+13];
double temp2d[M][M+23];
double block[M][M+43];
double sum2[M][M];

void init_array()
{
    int i, j;

    for (i=0; i<M; i++) {
        for (j=0; j<M; j++) {
            cos1[i][j] = (1+(i*j)%1024)/2.0;
            block[i][j] = (1+(i*j)%1024)/2.0;
        }
    }
}

int main()
{
	int i, j, k, l, m, n, o, t;

	init_array();

	for (i = 0; i < M; i++)
		for (j = 0; j < M; j++) {
		    temp2d[i][j] = 0.0;
		    for (k = 0; k < M; k++)
			temp2d[i][j] = temp2d[i][j] + block[i][k] * cos1[j][k];
	}

	for (i = 0; i < M; i++)
		for (j = 0; j < M; j++) {
		    sum2[i][j] = 0.0;
		    for (k = 0; k < M; k++)
			sum2[i][j] = sum2[i][j] + cos1[i][k] * temp2d[k][j];
		    block[i][j] = (sum2[i][j]);
	}

	eoc(0);
}
