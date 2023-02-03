#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct chainon {
    double val;
    struct chainon* suivant;
}chainon;

chainon *creationchainon(double a){
    chainon*p1=malloc(sizeof(*p1));
    if(p1==NULL){
        exit (1);
    }
    p1->val=a;
    p1->suivant=NULL;
    return p1;
}

chainon *insertdebut(chainon*pliste, double a){
    chainon*nouveau=creationchainon(a);
    nouveau->suivant=pliste;
    return nouveau;
}

chainon *insertcroissant (chainon*pliste, double a ){
    chainon*nouveau=malloc(sizeof(*nouveau));
    nouveau->val=a;
    chainon*p1=pliste;
    if (pliste == NULL){
        pliste=creationchainon(nouveau->val);
    }
    else if(pliste->val>a){
        pliste=insertdebut(pliste,a);
    }
    else{
        while((p1->suivant!=NULL) && (p1->suivant->val<a)){
            p1=p1->suivant;
        }
        if(p1->suivant==NULL){
            p1->suivant = nouveau;
        }
        else{
            nouveau->suivant=p1->suivant;
            p1->suivant=nouveau;
            
        }

    }
    return pliste;
}

chainon *insertdecroissant (chainon*pliste, double a ){
    chainon*nouveau=malloc(sizeof(*nouveau));
    nouveau->val=a;
    chainon*p1=pliste;
    if (pliste == NULL){
        pliste=creationchainon(nouveau->val);
    }
    else if(pliste->val<a){
        pliste=insertdebut(pliste,a);
    }
    else{
        while((p1->suivant!=NULL) && (p1->suivant->val>a)){
            p1=p1->suivant;
        }
        if(p1->suivant==NULL){
            p1->suivant = nouveau;
        }
        else{
            nouveau->suivant=p1->suivant;
            p1->suivant=nouveau;
            
        }

    }
    return pliste;
}

void afficheliste(chainon *pliste){
    if(pliste==NULL){
        printf ("La liste est nulle");
    }
    else{
        while(pliste!=NULL){
        printf("%lf -- ",pliste->val);
        pliste=pliste->suivant;
        }
    }
}


void printfile(chainon *pliste, FILE * file){
    if(pliste==NULL){
        printf ("La liste est nulle");
    }
    else{
        while(pliste!=NULL){
        fprintf(file,"%lf",pliste->val);
        pliste=pliste->suivant;
        }
    }
}

chainon* tri (double x){
	FILE * test = fopen("test.txt","r");
    chainon *test1=NULL;
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
    test1=insertcroissant (test1,b);
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
    return test1;
}

