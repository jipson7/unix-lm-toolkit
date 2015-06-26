#!/bin/bash

function displayHelp() {
    echo "Invalid input arguments"
    echo "usage:"
    echo "       ./buildlm_from_wngram.sh <Input-w5gram-dir> <output-bin-dir>"
    echo ""
    echo "       It is suggested to use an empty output directory..."
    echo ""
    exit 0
}

function buildDefaultLm() {
    tempdir="$outdir/temp"
    mkdir -p $tempdir

    vocabext=".vocab"
    idgramext=".idgram"
    binext=".binlm"

    for f in $indir/*.w5gram; do
        echo "Processing $f ..."
        mainfile="${f##*/}"
        rootname="${mainfile%.*}"
        binfile=$outdir/$rootname$binext
        vocabfile=$tempdir/$rootname$vocabext
        idgramfile=$tempdir/$rootname$idgramext
        python create_vocab.py $f | sort --dictionary-order >> $vocabfile
        wngram2idngram -vocab $vocabfile -temp $tempdir -n 5 < $f > $idgramfile
        idngram2lm -idngram $idgramfile -vocab $vocabfile -bin_input -n 5 -binary $binfile
    done

    echo "All done!"

}


function checkIfFilesExist(){
    if [ ! -d "$indir" ]; then
        echo "Input directory does not exist, exiting..."
        exit 0
    fi

    if [ ! -d "$outdir" ]; then
        echo "Output directory does not exist"
        while true; do
            read -p "Do you wish to create it? " yn
            case $yn in
                [Yy]* ) mkdir $outdir; break;;
                [Nn]* ) echo "exiting..."; exit;;
                * ) echo "Please enter yes or no";;
            esac
        done
    fi

    buildDefaultLm
}

if [ -z "$1" ] || [ -z "$2" ]; then
    displayHelp
fi

dot="."
indir=$1
outdir=$2

tempfile="${infile##*/}"

infileroot="${tempfile%.*}"

checkIfFilesExist
