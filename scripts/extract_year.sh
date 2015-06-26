#!/bin/bash

function displayHelp(){
    echo "Invalid Arguments"
    echo "Proper usage is: "
    echo "      ./extract_year.sh <input-dir> <output-file> <temp_dir> <year>"
    echo ""
    echo "<input-dir>           : Directory containing zipped google gz files"
    echo "<output-file>         : File to output google-year ngram to"
    echo "<temp_dir>            : Self explanatory"
    echo "<year>                : year to extract from google ngrams"
    exit 0
}

function execute(){
    touch $output_file
    for f in $ngram_dir/*.gz; do
        echo "Processing $f ..."
        zcat < $f | python line_extract.py $year | sort -T $tempdir --dictionary-order -o $output_file
    done

}

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
    displayHelp
fi

ngram_dir=$1
output_file=$2
tempdir=$3
year=$4


if [ ! -d "$ngram_dir" ]; then
    echo "$ngram_dir does not exist. Please ensure you entered the proper path"
fi

if [ -f "$output_file" ]; then
    echo "$output_file already exists, please remove it before running"
fi

if [ ! -d "$tempdir" ]; then
    echo "Temporary directory does not exist"
    while true; do
        read -p "Do you wish to create it? " yn
        case $yn in
            [Yy]* ) mkdir $tempdir; break;;
            [Nn]* ) echo "exiting..."; exit;;
            * ) echo "Please enter yes or no";;
        esac
    done
fi


if [ "$year" -gt 2008 -a "$year" -lt 1500 ]; then
    echo "Year must be between 1500 and 2008, please check the argument before continuing."
fi

execute
