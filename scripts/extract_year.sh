#!/bin/bash

function displayHelp(){
    echo "Invalid Arguments"
    echo "Proper usage is: "
    echo "      ./extract_year.sh <input-dir> <output-dir> <year>"
    echo ""
    echo "<input-dir>           : Directory containing zipped google gz files"
    echo "<output-dir>          : Directory to place processed files in"
    echo "<year>                : year to extract from google ngrams"
    exit 0
}

function execute(){
    mkdir -p $output_dir

    finalfile="google-lm-$year"

    if [ -f $finalfile ]; then
        echo "Cannot merge files. $finalfile already exists"
    fi

    touch $output_dir/$finalfile


    for f in $ngram_dir/*.gz; do
        echo "Processing $f ..."
        STEM=$(basename "${f}" .gz)
		yearext="-$year"
		zcat < $f | python ngram_splitter.py $output_dir/$STEM$yearext $year

        echo "Merging $STEM$yearext ..."

        cat $output_dir/$STEM$yearext >> $output_dir/$finalfile
    done

    

}

ngram_dir=$1
output_dir=$2
year=$3

if [ -z "$ngram_dir" ] || [ -z "$output_dir" ] || [ -z "$year" ]; then
    displayHelp
fi

if [ ! -d "$ngram_dir" ]; then
    displayHelp
fi

if (( $year > 2008 )) || (( $year < 1500 )); then
    displayHelp
fi

execute
