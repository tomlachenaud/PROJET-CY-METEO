#include<stdio.h>
#include<stdlib.h>
#include<string.h>

typedef struct abr{
	double elmt;
	struct abr* fg;
	struct abr* fd;
	int h;
	int equilibre;
	}Arbre;

typedef Arbre* PArbre;

PArbre creerArbre(double x) {
	PArbre A;
	A=malloc(sizeof(Arbre));
	if(A==NULL){
		exit(1);
	}
	*A=(Arbre){ x, NULL, NULL, 0 };
	return A;
}

void traiter(double x){
	printf("%lf",x);	
}

void tricroissant(PArbre A){ //équivalent parcoursinfixe
	if (A!=NULL){
		tricroissant(A->fg);
		traiter(A->elmt);
		tricroissant(A->fd);
	}
}

void tridecroissant(PArbre A){ //équivalent inverse parcoursinfixe
	if (A!=NULL){
		tridecroissant(A->fd);
		traiter(A->elmt);
		tridecroissant(A->fg);
	}
}

double min(double a, double b){
	if(a<b){
		return a;
		}
}

double max(double a, double b){
	if(a>b){
		return a;
		}
}


