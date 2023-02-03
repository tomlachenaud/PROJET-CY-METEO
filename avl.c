#include"AVL.h"

int main(){
    char aa[6];
    char a[100];
    char w;
    double x =0;
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
        tri(c);
        while (w!= ';'){
        w=fgetc(test);
    }
    atof(fgets(a,100,test));
    w='O';
    x=c;
        }
        
    }
    fclose(test);
}
