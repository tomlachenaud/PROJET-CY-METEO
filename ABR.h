#include "fonctions.h"

PArbre InsereABR(PArbre A, double x)
{
	if (!A) return creerArbre(x);
	if (x < A->elmt)
		A->fg = InsereABR(A->fg, x);
	else
		if (x > A->elmt)
			A->fd = InsereABR(A->fd, x);
	return A;
}

void tri (double x){
	FILE * test = fopen("test.txt","r");
	FILE * test2 = fopen("test2.txt","a");
    fprintf(test2,"%d",10);
    PArbre test1=NULL;
    char a [100];
    char aa [6];
    char w;
    double min, max, moy,i;
    min=10000000000000;
    moy=0;
    max=0;
    i=0;
    while (!feof(test)){
        double c =atof(fgets(aa,6,test));
        if(c == x){
        while (w!= ';'){
        w=fgetc(test);
    }
    double b = atof(fgets(a,100,test));
    test1=InsereABR(test1,b);
    w='O';
    i++;
    moy=moy+b;
    if(min>b){
        min=b;
    }
    else {
        min=min;
    }
    if(max<b){
        max=b;
    }
    else {
        max=max;
    }
    moy=moy/i;
    }
    else{
        while (w!= ';'){
        w=fgetc(test);
    }
    atof(fgets(a,100,test));
    w='O';
    }
    }
    printf("la moyenne est : %lf, le max est : %lf et le min est %lf\n",moy, max, min);
    fclose(test);
    fclose(test2);
}



