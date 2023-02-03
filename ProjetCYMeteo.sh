#!/bin/bash

string=$@
#RECOVER THE NAME OF THE FILE CHOSEN BY THE USER 
while getopts f: flag
do
    case "${flag}" in 
        f) filename=${OPTARG};;
    esac
done
cp $filename meteo_filtered_data_v1.csv
echo $filename
cut -d ';' -f 1 meteo_filtered_data_v1.csv | sort > IDStation.txt
#########
#VERIFY IF THE MOD CHOSEN BY THE USER IS CORRECT
for a in "$@"; do
if [ $a != "-t1" ] && [ $a != "-t2" ] && [ $a != "-t3" ] && [ $a != "-p1" ] && [ $a != "-p2" ] && [ $a != "-p3" ] && [ $a != "-w" ] && [ $a != "-m" ] && [ $a != "-h" ] && [ $a != "-F" ]&& [ $a != "-G" ] && [ $a != "-S" ] && [ $a != "-A" ] && [ $a != "-O" ] && [ $a != "-Q" ] && [ $a != "--help" ] && [ $a != "--avl" ] && [ $a != "--abr" ] && [ $a != "--tab" ] && [ $a != "-d" ] && [ $a != "-f" ]
then
e=$((e+1))
fi
if [[ $e -ge 2 ]]; then
echo 'error please choose a different mod'
exit
fi
if [[ $a == '-G' ]] || [[ $a == '-F' ]] || [[ $a == '-A' ]] || [[ $a == '-S' ]] || [[ $a == '-O' ]] || [[ $a == '-Q' ]]; then
b=$((b+1))
fi
if [[ $b -ge 2 ]]; then
echo 'error please choose only one localisation'
exit
fi
done
##########
#MOD HELP IF THE USER WANT TO KNOW THE COMMAND
if [[ $string =~ '--help' ]]; then
echo 'if you want a location tap -G, -F, -A, -O, -Q, -S'
echo 'if you want the wind tap -w'
echo 'if you want the temperature tap -t 1, -t 2, -t 3'
echo 'if you want the pressure tap -p 1, -p 2, -p 3'
echo 'if you want the height tap -h'
echo 'if you want the moisture tap -m'
echo 'if you want the date tap -d'
echo 'use --tab, --abr or --avl to filter the folder'
echo 'you have to use -f with a csv file following to execute the programm'
echo 'please notice that you cannot use the date and localisation in one command'
echo 'please notice that you can only use one mod of localisation'
exit
fi
#######

######################################################################
#LOCATION

######################################################################
##FRANCE



if [[ $string =~ '-G' ]] || [[ $string =~ '-F' ]] || [[ $string =~ '-A' ]] || [[ $string =~ '-S' ]] || [[ $string =~ '-O' ]] || [[ $string =~ '-Q' ]]&&([[ $string =~ '-w' ]] || [[ $string =~ '-h' ]] || [[ $string =~ '-t 1' ]] || [[ $string =~ '-t 2' ]] || [[ $string =~ '-t 3' ]] || [[ $string =~ '-p 1' ]] || [[ $string =~ '-p 2' ]] || [[ $string =~ '-p 3' ]] || [[ $string =~ '-m' ]] || [[ $string =~ '--tab' ]] || [[ $string =~ '--avl' ]] || [[ $string =~ '--abr' ]]); then
    if [[ $string =~ '-d' ]]; then
    echo 'error'
    elif [[ $string =~ '-F' ]]; then
###WIND
#SEARCH THE RIGHT ID OF THE STATIONS AND COPY ONLY THE RIGHT COLUMN IN A NEW FILE (IT IS THE SAME FOR ALL THE PROGRAMM)
    if [[ $string =~ '-w' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 | sort -n | grep -n '07005' | cut -d ':' -f 1 > winddir.txt
        lmin=$(head -1 winddir.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 | sort -n | grep -n '07790' | cut -d ':' -f 1 > winddirMax.txt
        lmax=$(tail -1 winddirMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 | sort -n | sed -n "$lmin,$lmax"'p' > winddir.txt
        rm winddirMax.txt
        
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 | sort -n | grep -n '07005' | cut -d ':' -f 1 > windspeF.txt
        lmin=$(head -1 windspeF.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 | sort -n | grep -n '07790' | cut -d ':' -f 1 > windspeFMax.txt
        lmax=$(tail -1 windspeFMax.txt) 

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 | sort -n | sed -n "$lmin,$lmax"'p' > windspeF.txt
        rm windspeFMax.txt
        #THIS PART IS FOR THE FILTER IN .C BUT HERE WE DECIDED THAT WE WILL NOT USE IT EVEN IF IT WORK BECAUSE IT TOOK TO MUCH TIME TO EXECUTE IT
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    fi

###HEIGHT

    if [[ $string =~ '-h' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 | sort -n | grep -n '07005' | cut -d ':' -f 1 > heightF.txt
        lmin=$(head -1 heightF.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 | sort -n | grep -n '07790' | cut -d ':' -f 1 > heightFMax.txt
        lmax=$(tail -1 heightFMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 | sort -n |  sed -n "$lmin,$lmax"'p' | uniq | sort -t ";" -k 2nr > filteredfile.txt
        rm heightFMax.txt


        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    gnuplot -p Graph.sh
fi

###TEMPERATURE

    if [[ $string =~ '-t 1' ]]; then

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 | sort -n | grep -n '07005' | cut -d ':' -f 1 > temperature1F.txt
        lmin=$(head -1 temperature1F.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 | sort -n | grep -n '07790' | cut -d ':' -f 1 > temperature1FMax.txt
        lmax=$(tail -1 temperature1FMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 | sort -n |  sed -n "$lmin,$lmax"'p' > temperature1F.txt
        rm temperature1FMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    fi
    if [[ $string =~ '-t 2' ]]; then 

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '07005' | cut -d ':' -f 1 > temperature2TEMPF.txt
        lmin=$(head -1 temperature2TEMPF.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '07790' | cut -d ':' -f 1 > temperature2FMAX.txt
        lmax=$(tail -1 temperature2FMAX.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n |  sed -n "$lmin,$lmax"'p' > temperature2TEMPF.txt
        cut -d ';' -f 2,3 temperature2TEMPF.txt > temperature2F.txt
        rm temperature2FMAX.txt
        rm temperature2TEMPF.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi

    if [[ $string =~ '-t 3' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '07005' | cut -d ':' -f 1 > temperature3F.txt
        lmin=$(head -1 temperature3F.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '07790' | cut -d ':' -f 1 > temperature3FMax.txt
        lmax=$(tail -1 temperature3FMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n |  sed -n "$lmin,$lmax"'p' > temperature3F.txt
        rm temperature3FMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###PRESSURE

    if [[ $string =~ '-p 1' ]]; then
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 | sort -n | grep -n '07005' | cut -d ':' -f 1 > pressure1F.txt
        lmin=$(head -1 pressure1F.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 | sort -n | grep -n '07790' | cut -d ':' -f 1 > pressure1FMax.txt
        lmax=$(tail -1 pressure1FMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 | sort -n |  sed -n "$lmin,$lmax"'p' > pressure1F.txt
        rm pressure1FMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-p 2' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '07005' | cut -d ':' -f 1 > pressure2TEMPF.txt
        lmin=$(head -1 pressure2TEMPF.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '07790' | cut -d ':' -f 1 > pressure2FMAX.txt
        lmax=$(tail -1 pressure2FMAX.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n |  sed -n "$lmin,$lmax"'p' > pressure2TEMPF.txt
        cut -d ';' -f 2,3 pressure2TEMPF.txt > pressure2F.txt
        rm pressure2FMAX.txt
        rm pressure2TEMPF.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-p 3' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '07005' | cut -d ':' -f 1 > pressure3F.txt
        lmin=$(head -1 pressure3F.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '07790' | cut -d ':' -f 1 > pressure3FMax.txt
        lmax=$(tail -1 pressure3FMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n |  sed -n "$lmin,$lmax"'p' > pressure3F.txt
        rm pressure3FMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi


###MOISTURE

    if [[ $string =~ '-m' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 | sort -n | grep -n '07005' | cut -d ':' -f 1 > moistureF.txt
        lmin=$(head -1 moistureF.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 | sort -n | grep -n '07790' | cut -d ':' -f 1 > moistureFMax.txt
        lmax=$(tail -1 moistureFMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 | sort -n |  sed -n "$lmin,$lmax"'p' > moistureF.txt
        rm moistureFMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    fi

######################################################################

######################################################################
##GUYANE FRANÇAISE

elif [[ $string =~ '-G' ]]; then 

###WIND

    if [[ $string =~ '-w' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 | sort -n | grep -n '81401' | cut -d ':' -f 1 > winddirG.txt
        lmin=$(head -1 winddirG.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 | sort -n | grep -n '81415' | cut -d ':' -f 1 > winddirGMax.txt
        lmax=$(tail -1 winddirGMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 | sort -n | sed -n "$lmin,$lmax"'p' > winddirG.txt
        rm winddirGMax.txt
        
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 | sort -n | grep -n '81401' | cut -d ':' -f 1 > windspeG.txt
        lmin=$(head -1 windspeG.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 | sort -n | grep -n '81415' | cut -d ':' -f 1 > windspeGMax.txt
        lmax=$(tail -1 windspeGMax.txt) 

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 | sort -n | sed -n "$lmin,$lmax"'p' > windspeG.txt
        rm windspeGMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###HEIGHT

    if [[ $string =~ '-h' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 | sort -n | grep -n '81401' | cut -d ':' -f 1 > heightG.txt
        lmin=$(head -1 heightG.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 | sort -n | grep -n '81415' | cut -d ':' -f 1 > heightGMax.txt
        lmax=$(tail -1 heightGMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 | sort -n |  sed -n "$lmin,$lmax"'p' | uniq | sort -t ";" -k 2nr > heightG.txt
        rm heightGMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###TEMPERATURE

    if [[ $string =~ '-t 1' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 | sort -n | grep -n '81401' | cut -d ':' -f 1 > temperature1G.txt
        lmin=$(head -1 temperature1G.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 | sort -n | grep -n '81415' | cut -d ':' -f 1 > temperature1GMax.txt
        lmax=$(tail -1 temperature1GMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 | sort -n |  sed -n "$lmin,$lmax"'p' > temperature1G.txt
        rm temperature1GMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
   fi 
    if [[ $string =~ '-t 2' ]]; then 

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '81401' | cut -d ':' -f 1 > temperature2TEMPG.txt
        lmin=$(head -1 temperature2TEMPG.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '81415' | cut -d ':' -f 1 > temperature2GMAX.txt
        lmax=$(tail -1 temperature2GMAX.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n |  sed -n "$lmin,$lmax"'p' > temperature2TEMPG.txt
        cut -d ';' -f 2,3 temperature2TEMPG.txt > temperature2G.txt
        rm temperature2GMAX.txt
        rm temperature2TEMPG.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi

    if [[ $string =~ '-t 3' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '81401' | cut -d ':' -f 1 > temperature3G.txt
        lmin=$(head -1 temperature3G.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '81415' | cut -d ':' -f 1 > temperature3GMax.txt
        lmax=$(tail -1 temperature3GMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n |  sed -n "$lmin,$lmax"'p' > temperature3G.txt
        rm temperature3GMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###PRESSURE

    if [[ $string =~ '-p 1' ]]; then
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 | sort -n | grep -n '81401' | cut -d ':' -f 1 > pressure1G.txt
        lmin=$(head -1 pressure1G.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 | sort -n | grep -n '81415' | cut -d ':' -f 1 > pressure1GMax.txt
        lmax=$(tail -1 pressure1GMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 | sort -n |  sed -n "$lmin,$lmax"'p' > pressure1G.txt
        rm pressure1GMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-p 2' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '81401' | cut -d ':' -f 1 > pressure2TEMPG.txt
        lmin=$(head -1 pressure2TEMPG.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '81415' | cut -d ':' -f 1 > pressure2GMAX.txt
        lmax=$(tail -1 pressure2GMAX.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n |  sed -n "$lmin,$lmax"'p' > pressure2TEMPG.txt
        cut -d ';' -f 2,3 pressure2TEMPG.txt > pressure2G.txt
        rm pressure2GMAX.txt
        rm pressure2TEMPG.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    fi

    if [[ $string =~ '-p 3' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '81401' | cut -d ':' -f 1 > pressure3G.txt
        lmin=$(head -1 pressure3G.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '81415' | cut -d ':' -f 1 > pressure3Gmax.txt
        lmax=$(tail -1 pressure3GMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n |  sed -n "$lmin,$lmax"'p' > pressure3G.txt
        rm pressure3GMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi


###MOISTURE

    if [[ $string =~ '-m' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 | sort -n | grep -n '81401' | cut -d ':' -f 1 > moistureG.txt
        lmin=$(head -1 moistureG.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 | sort -n | grep -n '81415' | cut -d ':' -f 1 > moistureGMax.txt
        lmax=$(tail -1 moistureGMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 | sort -n |  sed -n "$lmin,$lmax"'p' > moistureG.txt
        rm moistureGMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    fi

######################################################################

######################################################################
##SAINT PIERRE ET MIQUELON

elif [[ $string =~ '-S' ]]; then

###WIND

    if [[ $string =~ '-w' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 | sort -n | grep '71805' | uniq | sed -n '1!p' | sed -n '1!p' > winddirS.txt
        
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 | sort -n | grep '71805' | uniq > windspeS.txt
        
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###HEIGHT

    if [[ $string =~ '-h' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 | sort -n | grep '71805' | uniq | sort -t ";" -k 2nr > heightS.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###TEMPERATURE

    if [[ $string =~ '-t 1' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 | sort -n | grep '71805' > temperature1S.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
  fi  
    if [[ $string =~ '-t 2' ]]; then 

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep '71805' > temperature2STemp.txt
        cut -d ';' -f 2,3 temperature2STemp.txt > temperature2S.txt
        rm temperature2STemp.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-t 3' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep '71805' > temperature3S.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###PRESSURE

    if [[ $string =~ '-p 1' ]]; then
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 | sort -n | grep '71805' > pressure1S.txt
    #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-p 2' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep '71805' > pressure2STemp.txt
        cut -d ';' -f 2,3 pressure2STemp.txt > pressure2S.txt
        rm pressure2STEMP.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-p 3' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep '71805' > pressure3S.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###MOISTURE

    if [[ $string =~ '-m' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 | sort -n | grep '71805' > moistureS.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    fi
######################################################################

######################################################################
##ANTILLE

elif [[ $string =~ '-A' ]]; then

###WIND

    if [[ $string =~ '-w' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 | sort -n | grep -n '78890' | cut -d ':' -f 1 > winddirA.txt
        lmin=$(head -1 winddirA.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 | sort -n | grep -n '78925' | cut -d ':' -f 1 > winddirAMax.txt
        lmax=$(tail -1 winddirAMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 | sort -n | sed -n "$lmin,$lmax"'p' > winddirA.txt
        rm winddirAMax.txt
        
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 | sort -n | grep -n '78890' | cut -d ':' -f 1 > windspeA.txt
        lmin=$(head -1 windspeA.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 | sort -n | grep -n '78925' | cut -d ':' -f 1 > windspeAMax.txt
        lmax=$(tail -1 windspeAMax.txt) 

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 | sort -n | sed -n "$lmin,$lmax"'p' > windspeA.txt
        rm windspeAMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###HEIGHT

    if [[ $string =~ '-h' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 | sort -n | grep -n '78890' | cut -d ':' -f 1 > heightA.txt
        lmin=$(head -1 heightA.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 | sort -n | grep -n '78925' | cut -d ':' -f 1 > heightAMax.txt
        lmax=$(tail -1 heightAMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 | sort -n |  sed -n "$lmin,$lmax"'p' | uniq | sort -t ";" -k 2nr > heightA.txt
        rm heightAMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###TEMPERATURE

    if [[ $string =~ '-t 1' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 | sort -n | grep -n '78890' | cut -d ':' -f 1 > temperature1A.txt
        lmin=$(head -1 temperature1A.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 | sort -n | grep -n '78925' | cut -d ':' -f 1 > temperature1AMax.txt
        lmax=$(tail -1 temperature1AMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 | sort -n |  sed -n "$lmin,$lmax"'p' > temperature1A.txt
        rm temperature1AMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    fi
    if [[ $string =~ '-t 2' ]]; then 

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '78890' | cut -d ':' -f 1 > temperature2TEMPA.txt
        lmin=$(head -1 temperature2TEMPA.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '78925' | cut -d ':' -f 1 > temperature2AMAX.txt
        lmax=$(tail -1 temperature2AMAX.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n |  sed -n "$lmin,$lmax"'p' > temperature2TEMPA.txt
        cut -d ';' -f 2,3 temperature2TEMPA.txt > temperature2A.txt
        rm temperature2AMAX.txt
        rm temperature2TEMPA.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi

    if [[ $string =~ '-t 3' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '78890' | cut -d ':' -f 1 > temperature3A.txt
        lmin=$(head -1 temperature3A.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '78925' | cut -d ':' -f 1 > temperature3AMax.txt
        lmax=$(tail -1 temperature3AMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n |  sed -n "$lmin,$lmax"'p' > temperature3A.txt
        rm temperature3AMax.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###PRESSURE

    if [[ $string =~ '-p 1' ]]; then
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 | sort -n | grep -n '78890' | cut -d ':' -f 1 > pressure1A.txt
        lmin=$(head -1 pressure1A.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 | sort -n | grep -n '78925' | cut -d ':' -f 1 > pressure1AMax.txt
        lmax=$(tail -1 pressure1AMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 | sort -n |  sed -n "$lmin,$lmax"'p' > pressure1A.txt
        rm pressure1AMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-p 2' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '78890' | cut -d ':' -f 1 > pressure2TEMPA.txt
        lmin=$(head -1 pressure2TEMPA.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '78925' | cut -d ':' -f 1 > pressure2AMAX.txt
        lmax=$(tail -1 pressure2AMAX.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n |  sed -n "$lmin,$lmax"'p' > pressure2TEMPA.txt
        cut -d ';' -f 2,3 pressure2TEMPA.txt > pressure2A.txt
        rm pressure2AMAX.txt
        rm pressure2TEMPA.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-p 3' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '78890' | cut -d ':' -f 1 > pressure3A.txt
        lmin=$(head -1 pressure3A.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '78925' | cut -d ':' -f 1 > pressure3Amax.txt
        lmax=$(tail -1 pressure3AMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n |  sed -n "$lmin,$lmax"'p' > pressure3A.txt
        rm pressure3AMax.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi


###MOISTURE

    if [[ $string =~ '-m' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 | sort -n | grep -n '78890' | cut -d ':' -f 1 > moistureA.txt
        lmin=$(head -1 moistureA.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 | sort -n | grep -n '78925' | cut -d ':' -f 1 > moistureAMax.txt
        lmax=$(tail -1 moistureAMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 | sort -n |  sed -n "$lmin,$lmax"'p' > moistureA.txt
        rm moistureAMax.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    fi
######################################################################

######################################################################
##OCEAN INDIEN

elif [[ $string =~ '-O' ]]; then

###WIND

    if [[ $string =~ '-w' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 | sort -n | grep -n '61968' | cut -d ':' -f 1 > winddirO.txt
        lmin=$(head -1 winddirO.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 | sort -n | grep -n '67005' | cut -d ':' -f 1 > winddirOMax.txt
        lmax=$(tail -1 winddirOMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 | sort -n | sed -n "$lmin,$lmax"'p' > winddirO.txt
        rm winddirOMax.txt
        
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 | sort -n | grep -n '61968' | cut -d ':' -f 1 > windspeO.txt
        lmin=$(head -1 windspeO.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 | sort -n | grep -n '67005' | cut -d ':' -f 1 > windspeOMax.txt
        lmax=$(tail -1 windspeOMax.txt) 

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 | sort -n | sed -n "$lmin,$lmax"'p' > windspeO.txt
        rm windspeOMax.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    fi

###HEIGHT

    if [[ $string =~ '-h' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 | sort -n | grep -n '61968' | cut -d ':' -f 1 > heightO.txt
        lmin=$(head -1 heightO.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 | sort -n | grep -n '67005' | cut -d ':' -f 1 > heightOMax.txt
        lmax=$(tail -1 heightOMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 | sort -n |  sed -n "$lmin,$lmax"'p' | uniq | sort -t ";" -k 2nr > heightO.txt
        rm heightOMax.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###TEMPERATURE

    if [[ $string =~ '-t 1' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 | sort -n | grep -n '61968' | cut -d ':' -f 1 > temperature1O.txt
        lmin=$(head -1 temperature1O.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 | sort -n | grep -n '67005' | cut -d ':' -f 1 > temperature1OMax.txt
        lmax=$(tail -1 temperature1OMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 | sort -n |  sed -n "$lmin,$lmax"'p' > temperature1O.txt
        rm temperature1OMax.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
   fi 
    if [[ $string =~ '-t 2' ]]; then 

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '61968' | cut -d ':' -f 1 > temperature2TEMPO.txt
        lmin=$(head -1 temperature2TEMPO.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '67005' | cut -d ':' -f 1 > temperature2OMAX.txt
        lmax=$(tail -1 temperature2OMAX.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n |  sed -n "$lmin,$lmax"'p' > temperature2TEMPO.txt
        cut -d ';' -f 2,3 temperature2TEMPO.txt > temperature2O.txt
        rm temperature2OMAX.txt
        rm temperature2TEMPO.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi

    if [[ $string =~ '-t 3' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '61968' | cut -d ':' -f 1 > temperature3O.txt
        lmin=$(head -1 temperature3O.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep -n '67005' | cut -d ':' -f 1 > temperature3OMax.txt
        lmax=$(tail -1 temperature3OMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n |  sed -n "$lmin,$lmax"'p' > temperature3O.txt
        rm temperature3OMax.txt
      #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###PRESSURE

    if [[ $string =~ '-p 1' ]]; then
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 | sort -n | grep -n '61968' | cut -d ':' -f 1 > pressure1O.txt
        lmin=$(head -1 pressure1O.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 | sort -n | grep -n '67005' | cut -d ':' -f 1 > pressure1OMax.txt
        lmax=$(tail -1 pressure1OMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 | sort -n |  sed -n "$lmin,$lmax"'p' > pressure1O.txt
        rm pressure1OMax.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    fi

    if [[ $string =~ '-p 2' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '61968' | cut -d ':' -f 1 > pressure2TEMPO.txt
        lmin=$(head -1 pressure2TEMPO.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '67005' | cut -d ':' -f 1 > pressure2OMAX.txt
        lmax=$(tail -1 pressure2OMAX.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n |  sed -n "$lmin,$lmax"'p' > pressure2TEMPO.txt
        cut -d ';' -f 2,3 pressure2TEMPO.txt > pressure2O.txt
        rm pressure2OMAX.txt
        rm pressure2TEMPO.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    fi

    if [[ $string =~ '-p 3' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '61968' | cut -d ':' -f 1 > pressure3O.txt
        lmin=$(head -1 pressure3O.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep -n '67005' | cut -d ':' -f 1 > pressure3Omax.txt
        lmax=$(tail -1 pressure3OMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n |  sed -n "$lmin,$lmax"'p' > pressure3O.txt
        rm pressure3OMax.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi


###MOISTURE

    if [[ $string =~ '-m' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 | sort -n | grep -n '61968' | cut -d ':' -f 1 > moistureO.txt
        lmin=$(head -1 moistureO.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 | sort -n | grep -n '67005' | cut -d ':' -f 1 > moistureOMax.txt
        lmax=$(tail -1 moistureOMax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 | sort -n |  sed -n "$lmin,$lmax"'p' > moistureO.txt
        rm moistureOMax.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    fi

######################################################################

######################################################################
##ANTARCTIQUE

elif [[ $string =~ '-Q' ]]; then
    if [[ $string =~ '-d' ]]; then
    echo 'error'
    fi
###WIND

    if [[ $string =~ '-w' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 | sort -n | grep '89642' > winddirQ.txt
        
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 | sort -n | grep '89642' > windspeQ.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###HEIGHT

    if [[ $string =~ '-h' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 | sort -n | grep '89642' | uniq | sort -t ";" -k 2nr > heightQ.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###TEMPERATURE

    if [[ $string =~ '-t 1' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 | sort -n | grep '89642' > temperature1Q.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-t 2' ]]; then 

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep '89642' > temperature2QTemp.txt
        cut -d ';' -f 2,3 temperature2QTemp.txt > temperature2Q.txt
        rm temperature2QTemp.txt
        #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-t 3' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n | grep '89642' > temperature3Q.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###PRESSURE

    if [[ $string =~ '-p 1' ]]; then
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 | sort -n | grep '89642' > pressure1Q.txt
    #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-p 2' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep '89642' > pressure2QTemp.txt
        cut -d ';' -f 2,3 pressure2QTemp.txt > pressure2Q.txt
        rm pressure2QTemp.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-p 3' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n | grep '89642' > pressure3Q.txt
      #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###MOISTURE

    if [[ $string =~ '-m' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 | sort -n | grep '89642' > moistureQ.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi

    fi
fi


##DATE 
elif [[ $string =~ '-d' ]] && ([[ $string =~ '-w' ]] || [[ $string =~ '-h' ]] || [[ $string =~ '-t 1' ]] || [[ $string =~ '-t 2' ]] || [[ $string =~ '-t 3' ]] || [[ $string =~ '-p 1' ]] || [[ $string =~ '-p 2' ]] || [[ $string =~ '-p 3' ]] || [[ $string =~ '-m' ]] || [[ $string =~ '--tab' ]] || [[ $string =~ '--avl' ]] || [[ $string =~ '--abr' ]]); then
#IT ALLOW TO THE USER TO CHOOSE A DATE BUT ASK HIM TO WRITE AGAIN IF THE DATE IS IN THE WRONG FORMAT OR IS NOT BETWEEN 2010 AND 2022
    echo 'Please choose the starting year :'
    read Ymin
    while [ "$Ymin" -lt 2010 ] || [ "$Ymin" -gt 2022 ]
    do
    echo 'Please choose the starting year :'
    read Ymin
    done
    echo 'Please choose the starting month :'
    read Mmin
    while [ "$Mmin" -lt 01 ] || [ "$Mmin" -gt 12 ]
    do
    echo 'Please choose the starting month :'
    read Mmin
    done
    echo 'Please choose the starting day :'
    read Dmin

    if [[ $Mmin = '01' ]] || [[ $Mmin = 'O3' ]] || [[ $Mmin = '05' ]] || [[ $Mmin = '07' ]] || [[ $Mmin = '08' ]] || [[ $Mmin = '10' ]] || [[ $Mmin = '12' ]]; then
    while [ "$Dmin" -lt 01 ] || [ "$Dmin" -gt 31 ]
    do
    echo 'Please choose the starting day ;'
    read Dmin
    done
    elif [[ $Mmin = '04' ]] || [[ $Mmin = 'O6' ]] || [[ $Mmin = '09' ]] || [[ $Mmin = '11' ]]; then
    while [ "$Dmin" -lt 01 ] || [ "$Dmin" -gt 30 ]
    do
    echo 'Please choose the starting day ;'
    read Dmin
    done
    elif [[ $Mmin = '02' ]]; then
    while [ "$Dmin" -lt 01 ] || [ "$Dmin" -gt 28 ]
    do
    echo 'Please choose the starting day ;'
    read Dmin
    done
    fi

######################################################################

    echo 'Please choose the ending year :'
    read Ymax
    while [ "$Ymax" -lt 2010 ] || [ "$Ymax" -gt 2022 ] || [ "$Ymax" -lt "$Ymin" ]
    do
    echo 'Please choose the ending year :'
    read Ymax
    done

    echo 'Please choose the ending month :'
    read Mmax
    if [[ $Ymax = $Ymin ]]; then
    while [ "$Mmax" -lt 01 ] || [ "$Mmax" -gt 12 ] || [ "$Mmax" -lt "$Mmin" ]
    do
    echo 'Please choose the ending month :'
    read Mmax
    done
    else while [ "$Mmax" -lt 01 ] || [ "$Mmax" -gt 12 ]
    do
    echo 'Please choose the ending month :'
    read Mmax
    done
    if [[ $Mmax = '01' ]] || [[ $Mmax = 'O3' ]] || [[ $Mmax = '05' ]] || [[ $Mmax = '07' ]] || [[ $Mmax = '08' ]] || [[ $Mmax = '10' ]] || [[ $Mmax = '12' ]]; then
        while [ "$Dmax" -lt 01 ] || [ "$Dmax" -gt 31 ] || [ "$Dmax" -lt "$Dmin" ]
        do
        echo 'Please choose the ending day ;'
        read Dmax
        done
        elif [[ $Mmax = '04' ]] || [[ $Mmax = 'O6' ]] || [[ $Mmax = '09' ]] || [[ $Mmax = '11' ]]; then
        while [ "$Dmax" -lt 01 ] || [ "$Dmax" -gt 30 ] || [ "$Dmax" -lt "Dmin" ]
        do
        echo 'Please choose the ending day ;'
        read Dmax
        done
        elif [[ $Mmax = '02' ]]; then
        while [ "$Dmax" -lt 01 ] || [ "$Dmax" -gt 28 ] || [ "$Dmax" -lt "$Dmin" ]
        do
        echo 'Please choose the ending day ;'
        read Dmax
        done
        elif [[ $Mmax = '01' ]] || [[ $Mmax = 'O3' ]] || [[ $Mmax = '05' ]] || [[ $Mmax = '07' ]] || [[ $Mmax = '08' ]] || [[ $Mmax = '10' ]] || [[ $Mmax = '12' ]]; then
        while [ "$Dmax" -lt 01 ] || [ "$Dmax" -gt 31 ]
        do
        echo 'Please choose the ending day ;'
        read Dmax
        done
        elif [[ $Mmax = '04' ]] || [[ $Mmax = 'O6' ]] || [[ $Mmax = '09' ]] || [[ $Mmax = '11' ]]; then
        while [ "$Dmax" -lt 01 ] || [ "$Dmax" -gt 30 ]
        do
        echo 'Please choose the ending day ;'
        read Dmax
        done
        elif [[ $Mmax = '02' ]]; then
        while [ "$Dmax" -lt 01 ] || [ "$Dmax" -gt 28 ]
        do
        echo 'Please choose the ending day ;'
        read Dmax
        done
        fi
    fi

    echo 'Please choose the ending day :'
    read Dmax
    if [[ $Ymax = $Ymin ]] && [[ $Mmax = $Mmin ]]; then
        if [[ $Mmax = '01' ]] || [[ $Mmax = 'O3' ]] || [[ $Mmax = '05' ]] || [[ $Mmax = '07' ]] || [[ $Mmax = '08' ]] || [[ $Mmax = '10' ]] || [[ $Mmax = '12' ]]; then
        while [ "$Dmax" -lt 01 ] || [ "$Dmax" -gt 31 ] || [ "$Dmax" -lt "$Dmin" ]
        do
        echo 'Please choose the ending day ;'
        read Dmax
        done
        elif [[ $Mmax = '04' ]] || [[ $Mmax = 'O6' ]] || [[ $Mmax = '09' ]] || [[ $Mmax = '11' ]]; then
        while [ "$Dmax" -lt 01 ] || [ "$Dmax" -gt 30 ] || [ "$Dmax" -lt "Dmin" ]
        do
        echo 'Please choose the ending day ;'
        read Dmax
        done
        elif [[ $Mmax = '02' ]]; then
        while [ "$Dmax" -lt 01 ] || [ "$Dmax" -gt 28 ] || [ "$Dmax" -lt "$Dmin" ]
        do
        echo 'Please choose the ending day ;'
        read Dmax
        done
        elif [[ $Mmax = '01' ]] || [[ $Mmax = 'O3' ]] || [[ $Mmax = '05' ]] || [[ $Mmax = '07' ]] || [[ $Mmax = '08' ]] || [[ $Mmax = '10' ]] || [[ $Mmax = '12' ]]; then
        while [ "$Dmax" -lt 01 ] || [ "$Dmax" -gt 31 ]
        do
        echo 'Please choose the ending day ;'
        read Dmax
        done
        elif [[ $Mmax = '04' ]] || [[ $Mmax = 'O6' ]] || [[ $Mmax = '09' ]] || [[ $Mmax = '11' ]]; then
        while [ "$Dmax" -lt 01 ] || [ "$Dmax" -gt 30 ]
        do
        echo 'Please choose the ending day ;'
        read Dmax
        done
        elif [[ $Mmax = '02' ]]; then
        while [ "$Dmax" -lt 01 ] || [ "$Dmax" -gt 28 ]
        do
        echo 'Please choose the ending day ;'
        read Dmax
        done
        fi
    #else echo 'error'
    min=$Ymin-$Mmin-$Dmin
    max=$Ymax-$Mmax-$Dmax
    #SET VARIABLES FOR THE DATE MINIMUM AND TGE DATE MAXIMUM
    echo $min
    echo $max
    fi
###WIND

    if [[ $string =~ '-w' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,4 | sort -t ";" -k 2 | grep -n "$min" | cut -d ':' -f 1 > winddirD.txt 
        lmin=$(head -1 winddirD.txt) 
        

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,4 | sort -t ";" -k 2 | grep -n "$max" | cut -d ':' -f 1 > winddirDmax.txt
        lmax=$(tail -1 winddirDmax.txt)
#SEARCH IN THE FILE THE FIRST LINE AND THE LAST LINE THAT MATCH WITH THE DATE AND COPY ALL THAT IS IN BETWEEN
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,4 | sort -t ";" -k 2| sed -n "$lmin,$lmax"'p' | sort -n > winddirD.txt 
        rm winddirDmax.txt

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,5 | sort -t ";" -k 2 | grep -n "$min" | cut -d ':' -f 1 > windspeD.txt 
        lmin=$(head -1 windspeD.txt)   

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,5 | sort -t ";" -k 2 | grep -n "$max" | cut -d ':' -f 1 > windspeDmax.txt 
        lmax=$(tail -1 windspeDmax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,4 | sort -t ";" -k 2 | sed -n "$lmin,$lmax"'p' | sort -n > windspeD.txt 
        rm windspeDmax.txt
     #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###HEIGHT

    if [[ $string =~ '-h' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,14 | sort -t ";" -k 2 | grep -n "$min" | cut -d ':' -f 1 > heightD.txt    
        lmin=$(head -1 heightD.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,14 | sort -t ";" -k 2 | grep -n "$max" | cut -d ':' -f 1 > heightDLmax.txt
        lmax=$(tail -1 heightDLmax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,4 | sort -t ";" -k 2 | sed -n "$lmin,$lmax"'p' | uniq | sort -t ";" -k 2nr > heightD.txt
        rm heightDLmax.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###TEMPERATURE

    if [[ $string =~ '-t 1' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -t ";" -k 2 | grep -n "$min" | cut -d ':' -f 1 > temp1D.txt    
        lmin=$(head -1 temp1D.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -t ";" -k 2 | grep -n "$max" | cut -d ':' -f 1 > temp1DLmax.txt
        lmax=$(tail -1 temp1DLmax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,4 | sort -t ";" -k 2 | sed -n "$lmin,$lmax"'p' > temp1D.txt 

        rm temp1DLmax.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-t 2' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -t ";" -k 2 | grep -n "$min" | cut -d ':' -f 1 > temp2D.txt    
        lmin=$(head -1 temp2D.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -t ";" -k 2 | grep -n "$max" | cut -d ':' -f 1 > temp2DLmax.txt
        lmax=$(tail -1 temp2DLmax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,4 | sort -t ";" -k 2 | sed -n "$lmin,$lmax"'p' > temp2D.txt 
        rm temp2DLmax.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-t 3' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -t ";" -k 2 | grep -n "$min" | cut -d ':' -f 1 > temp3D.txt    
        lmin=$(head -1 temp3D.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -t ";" -k 2 | grep -n "$max" | cut -d ':' -f 1 > temp3DLmax.txt
        lmax=$(tail -1 temp3DLmax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,4 | sort -t ";" -k 2 | sed -n "$lmin,$lmax"'p' > temp3D.txt 

        rm temp3DLmax.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
###PRESSURE

    if [[ $string =~ '-p 1' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -t ";" -k 2 | grep -n "$min" | cut -d ':' -f 1 > pressure1D.txt    
        lmin=$(head -1 pressure1D.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -t ";" -k 2 | grep -n "$max" | cut -d ':' -f 1 > pressure1DLmax.txt
        lmax=$(tail -1 pressure1DLmax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,4 | sort -t ";" -k 2 | sed -n "$lmin,$lmax"'p' > pressure1D.txt 

        rm pressure1DLmax.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-p 2' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -t ";" -k 2 | grep -n "$min" | cut -d ':' -f 1 > pressure2D.txt  
        lmin=$(head -1 pressure2D.txt)  

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -t ";" -k 2 | grep -n "$max" | cut -d ':' -f 1 > pressure2DLmax.txt
        lmax=$(tail -1 pressure2DLmax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,4 | sort -t ";" -k 2 | sed -n "$lmin,$lmax"'p' > pressure2D.txt 

        rm pressure2DLmax.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
    if [[ $string =~ '-p 3' ]]; then
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -t ";" -k 2 | grep -n "$min" | cut -d ':' -f 1 > pressure3D.txt   
        lmin=$(head -1 pressure3D.txt) 

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -t ";" -k 2 | grep -n "$max" | cut -d ':' -f 1 > pressure3DLmax.txt
        lmax=$(tail -1 pressure3DLmax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,4 | sort -t ";" -k 2 | sed -n "$lmin,$lmax"'p' > pressure3D.txt 

        rm pressure3DLmax.txt
      #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    fi
###MOISTURE

    if [[ $string =~ '-m' ]]; then 
        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,6 | sort -t ";" -k 2 | grep -n "$min" | cut -d ':' -f 1 > moistureD.txt    
        lmin=$(head -1 moistureD.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,6 | sort -t ";" -k 2 | grep -n "$max" | cut -d ':' -f 1 > moistureDLmax.txt
        lmax=$(tail -1 moistureDLmax.txt)

        sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,4 | sort -t ";" -k 2 | sed -n "$lmin,$lmax"'p' | cut -d ';' -f 1,3 | sort -n > moistureD.txt 
        rm moistureDLmax.txt
       #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    fi


######################################################################

######################################################################
#THE MOD WITHOUT ANYTHING (LOCATION OR DATE)
#WIND
elif  [[ $string =~ '-w' ]] || [[ $string =~ '-h' ]] || [[ $string =~ '-t 1' ]] || [[ $string =~ '-t 2' ]] || [[ $string =~ '-t 3' ]] || [[ $string =~ '-p 1' ]] || [[ $string =~ '-p 2' ]] || [[ $string =~ '-p 3' ]] || [[ $string =~ '-m' ]] || [[ $string =~ '--tab' ]] || [[ $string =~ '--avl' ]] || [[ $string =~ '--abr' ]]; then
if [[ $string =~ '-w' ]]; then 
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 | sort -n > winddir.txt
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 | sort -n > windspe.txt
   #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
    fi

        #mettre graphique juste après 
#HEIGHT

if [[ $string =~ '-h' ]]; then
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 | sort -n | uniq | sort -t ";" -k 2nr > height.txt
   #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
#TEMPERATURE

if [[ $string =~ '-t 1' ]]; then
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 | sort -n > temperature1.txt
   #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
if [[ $string =~ '-t 2' ]]; then 
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 2,11 | sort -n > temperature2.txt
   #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
if [[ $string =~ '-t 3' ]]; then
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 | sort -n > temperature3.txt
   #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
#PRESSURE

if [[ $string =~ '-p 1' ]]; then
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 | sort -n > pressure1.txt 
   #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi

if [[ $string =~ '-p 2' ]]; then 
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 2,7 | sort -n > pressure2.txt
    #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
if [[ $string =~ '-p 3' ]]; then
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 | sort -n > pressure3.txt
   #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi
#MOISTURE

if [[ $string =~ '-m' ]]; then 
    sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 | sort -n > moisture.txt
    #if [[ $string =~ '--abr' ]]; then 
        #gcc -o abr2 abr2.c
        #./abr2
    #elif [[ $string =~ '--avl' ]]; then 
        #gcc -o avl2 avl2.c
        #./avl2
   # elif [[ $string =~ '--tab' ]]; then 
        #gcc -o liste2 liste2.c
       # ./liste2
    #else 
       # gcc -o avl2 avl2.c
       #./avl2
   # fi
fi



    else echo 'error'
    fi 
