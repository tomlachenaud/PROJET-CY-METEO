#include"fonctions.h"
#include<math.h>
PArbre rotationGauche(PArbre A) {
	PArbre B = A->fd;
	int a = A->equilibre;
	int b = B->equilibre;
	A->fd = B->fg;			// Rotation
	B->fg = A;
	A->equilibre = a - max(b, 0) - 1;
	B->equilibre = min(min(a - 2, a + b -2), b - 1);
	return B;
}

PArbre rotationDroite(PArbre A) {
	PArbre B = A->fg;
	int a = A->equilibre;
	int b = B->equilibre;
	A->fg = B->fd;			// Rotation
	B->fd = A;
	A->equilibre = a - min(b, 0) + 1;
	B->equilibre = max(max(a + 2, a + b + 2), b + 1);
	return B;
}

PArbre doubleRotationGauche(PArbre A) {
	A->fd = rotationDroite(A->fd);
	return rotationGauche(A);
}

PArbre doubleRotationDroite(PArbre A) {
	A->fg = rotationGauche(A->fg);
	return rotationDroite(A);
}

PArbre equilibrerAVL(PArbre A) {
	if (A->equilibre == 2)
		if (A->fd->equilibre >= 0)
			return rotationGauche(A);
		else
			return doubleRotationGauche(A);
	else
		if (A->equilibre == -2)
			if (A->fg->equilibre <= 0)
				return rotationDroite(A);
			else
				return doubleRotationDroite(A);
	return A;
}

PArbre ajoutAVL(PArbre A, double x, int *h) {
	if (A==NULL) {
		*h = 1;
		return creerArbre(x);
	}
	if (x > A->elmt)
		A->fd = ajoutAVL(A->fd, x, h);
	else if (x < A->elmt) {
		A->fg = ajoutAVL(A->fg, x, h);
		*h = -*h;
	} else { // x == A->elmt
		*h = 0;
		return A;
	}
	if (*h != 0) { // sinon pas de changement d'équilibre
		A->equilibre = A->equilibre + *h;
		A = equilibrerAVL(A);
		if (A->equilibre == 0)
			*h = 0;
		else
			*h = 1;
	}
	return A;
}

PArbre ajouterAVL(PArbre A, double x) {
	int h = 0;		// variable d'equilibre
	return ajoutAVL(A, x, &h);
}

void tri(double x){
	FILE * test = fopen("test.txt","r");
	FILE * test2 = fopen("test2.txt","a");
    PArbre A=NULL;
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
    A=ajouterAVL(A,b);
    tricroissant(A);
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



