#!/bin/bash

function displayHelp(){
    echo "Invalid Arguments"
    echo "Proper usage is: "
    echo "      ./extract_year.sh <input-dir> <output-file> <year>"
    echo ""
    echo "<input-dir>           : Directory containing zipped google gz files"
    echo "<output-file>         : File to output google-year ngram to"
    echo "<year>                : year to extract from google ngrams"
    exit 0
}

function execute(){

    touch $output_file

    for f in $ngram_dir/*.gz; do
        echo "Processing $f ..."
        zcat < $f | python line_extract.py $year >> $output_file
    done

}

ngram_dir=$1
output_file=$2
year=$3

if [ -z "$ngram_dir" ] || [ -z "$output_file" ] || [ -z "$year" ]; then
    displayHelp
fi

if [ ! -d "$ngram_dir" ]; then
    echo "$ngram_dir does not exist. Please ensure you entered the proper path"
fi

if [ -f "$output_file" ]; then
    echo "$output_file already exists, please remove it before running"
fi

if [ "$year" -gt 2008 -a "$year" -lt 1500 ]; then
    echo "Year must be between 1500 and 2008, please check the argument before continuing."
fi

execute
