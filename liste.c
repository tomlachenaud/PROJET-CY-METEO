#include"liste.h"
int main(){
    char aa[6];
    char a[100];
    char w;
    double x =0;
    FILE * test2 = fopen("test2.txt","a");
    FILE * test = fopen("test.txt","r");
    while ((!feof(test))){
        double c =atof(fgets(aa,6,test));
        if(x==c){
            while (w!= ';'){
        w=fgetc(test);
    }
    atof(fgets(a,100,test));
    w='O';
        }
        else{
        chainon* test1 = tri(c);
        while(test1!=NULL){
        fprintf(test2,"%lf;%lf\n",c,test1->val);
        test1=test1->suivant;
        }
        while (w!= ';'){
        w=fgetc(test);
    }
    atof(fgets(a,100,test));
    w='O';
    x=c;
        }
        
    }
    fclose(test);
    fclose(test2);
}
