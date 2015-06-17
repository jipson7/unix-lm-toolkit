#!/bin/bash

function displayHelp(){
    echo "Invalid Arguments"
    echo "Proper usage is: "
    echo "      ./extract_year.sh <input-dir> <output-dir> <year> <--keep-originals>"
    echo ""
    echo "<input-dir>           : Directory containing zipped google gz files"
    echo "<output-dir>          : Directory to place processed files in"
    echo "<year>                : year to extract from google ngrams"
    echo "<--keep-originals>    : Optional flag to keeps original gz files"
    exit 0
}

function execute(){
    mkdir -p $output_dir

    dash="-"

    for f in $ngram_dir/*.gz; do
        STEM=$(basename "${f}" .gz)
		yearext="-$year"
		zcat < $f | python ngram_splitter.py $output_dir/$STEM$yearext $year
        if [ $keep_true -eq 0 ]; then
            rm $f
        fi
    done

}

ngram_dir=$1
output_dir=$2
year=$3
keep=$4
keep_true=0

if [ -z "$ngram_dir" ] || [ -z "$output_dir" ] || [ -z "$year" ]; then
    displayHelp
fi

if [ ! -d "$ngram_dir" ]; then
    displayHelp
fi

if (( $year > 2008 )) && (( $year < 1500 )); then
    displayHelp
fi

if [ ! -z "$keep" ]; then
    if [[ $keep = "--keep-originals" ]]; then
        keep_true=1
    else
        displayHelp
    fi
fi

execute
