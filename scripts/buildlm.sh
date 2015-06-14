#!/bin/bash

function displayHelp() {
    echo "Invalid input arguments"
    echo "usage:"
    echo "       ./buildlm.sh -i <someinput.txt> -o <someoutput.binlm>"
    echo ""
    exit 0
}

function buildDefaultLm() {
    wfreq=".wfreq"
    vocab=".vocab"
    idngram=".idngram"
    mkdir -p intermediate-files/$outfilebody/temp

    cat $infile | text2wfreq > intermediate-files/$outfilebody/$outfilebody$wfreq

    cat intermediate-files/$outfilebody/$outfilebody$wfreq | wfreq2vocab > \
        intermediate-files/$outfilebody/$outfilebody$vocab

    cat $infile | text2idngram -temp intermediate-files/$outfilebody/temp \
        -vocab intermediate-files/$outfilebody/$outfilebody$vocab > \
        intermediate-files/$outfilebody/$outfilebody$idngram

    idngram2lm -idngram intermediate-files/$outfilebody/$outfilebody$idngram \
        -vocab intermediate-files/$outfilebody/$outfilebody$vocab \
        -binary ./$outfilebody$outfileext

    rm -rf intermediate-files/$outfilebody/temp

}


function checkIfFilesExist(){
    if [ ! -f "$infile" ]; then
        echo "Input file does not exist, exiting..."
        exit 0
    fi
    if [ -f "$outfile" ]; then
        echo "$outfile already exists."
        while true; do
            read -p "Do you wish to override it? " yn
            case $yn in
                [Yy]* ) rm $outfile; break;;
                [Nn]* ) echo "exiting..."; exit;;
                * ) echo "Please enter yes or no";;
            esac
        done
    fi

    buildDefaultLm
}
dot="."
infile=$2
outfile=$4

if [ -z "$infile" ] || [ -z "$outfile" ]; then
    displayHelp
fi

outfilebody=${outfile%.*}
outfileext=$dot${outfile##*.}

if [ "$1" = "-i" ] && [ "$3" = "-o" ]; then
    checkIfFilesExist
else
    displayHelp
fi

