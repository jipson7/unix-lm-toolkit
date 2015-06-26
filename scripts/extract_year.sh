#!/bin/bash

function displayHelp(){
    echo "Invalid Arguments"
    echo "Proper usage is: "
    echo "      ./extract_year.sh <input-dir> <output-dir> <temp_dir> <year>"
    echo ""
    echo "<input-dir>           : Dir containing zipped google gz files"
    echo "<output-dir>          : Dir to output google-year wngram's to"
    echo "<year>                : year to extract from google ngrams"
    exit 0
}

function execute(){
    for f in $ngram_dir/*.gz; do
        echo "Processing $f ..."
		mainfile="${f##*/}"
		rootname="${mainfile%.*}"
		wext=".w5gram"
        zcat < $f | python line_extract.py $year | sort >> $outputdir/$rootname$wext
    done

}

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    displayHelp
fi

ngram_dir=$1
outputdir=$2
year=$3


if [ ! -d "$ngram_dir" ]; then
    echo "$ngram_dir does not exist. Please ensure you entered the proper path"
fi

if [ ! -d "$outputdir" ]; then
    echo "Output directory does not exist"
    while true; do
        read -p "Do you wish to create it? " yn
        case $yn in
            [Yy]* ) mkdir $outputdir; break;;
            [Nn]* ) echo "exiting..."; exit;;
            * ) echo "Please enter yes or no";;
        esac
    done
fi

if [ "$year" -gt 2008 -a "$year" -lt 1500 ]; then
    echo "Year must be between 1500 and 2008, please check the argument before continuing."
fi

execute
