#Language Modeling Scripts and Toolkit

Toolkit is a 'fork' of the CMU-Cambridge Statistical Language Modeling Tookit v2 available [here](http://www.speech.cs.cmu.edu/SLM_info.html)

Additional scripts added by yours truly to facilitate some work with the toolkit and manipulation of the google corpus.

#Documentation:

##Scripts

extract_year.sh - Takes in a directory containing google ngram gz files (currently only works with5 grams) and a given year, and outputs a file containing only the ngrams of that given year. The resulting file is a merge of all previously separate gz files. Uses the line_extractor.py script.

line_extractor.py - python script that takes in a pipe from the above script. And outputs only the (formatted) lines if they contain the specified year.

create_vocab.py - Python script that takes an extracted year and creates a vocabulary file. (A set of all unique words)

buildlm.sh - Shell script to build a binary LM from a text file, requires toolkit to be installed

endian_test.cpp - C++ command line tool to test endian-ness of machine it's compiled on. Used to determine proper parameters for installation of toolkit below.


```

python driver.py split <inputfile> <outputfile> <year-to-extract>

```

####TODO

* Implement an algorithm to separate entire corpus by year
* Implement a library to normalize raw text used to build lm
* and more

> Below is the documentation for the original CMU toolkit

##Toolkit

For installation and usage instructions for the toolkit, see 

doc/toolkit_documentation.html

(for the sake of convenience, the installation instructions are also
given below).

####Installation:

For "little-endian" machines the installation procedure is simply to type

  cd src
  make install

The executables will then be copied into the bin/ directory, and the
library file SLM2.a will be copied into the lib/ directory.

For "big-endian" machines the variable "BYTESWAP_FLAG" will 
need to be set in the Makefile. This can be done by editing 
src/Makefile directly, so that the line

BYTESWAP_FLAG  = -DSLM_SWAP_BYTES

is changed to 

\#BYTESWAP_FLAG  = -DSLM_SWAP_BYTES

Then the program can be installed as before.

If you are unsure of the "endian-ness" of your machine, then the shell
script endian.sh should be able to provide some assistance.

In case of problems, then more information can be found by examining
src/Makefile.

Files:

doc/toolkit_documentation.html   The standard html documentation for the 
   toolkit. View using netscape or equivalent.

doc/toolkit_documentation_no_tables.html   As above, but doesn't use 
   tables, so is suitable for use with browsers which don't support
   tables (eg lynx).

doc/toolkit_documentation.txt   The documentation in flat text.

doc/change_log.html   List of changes from version to version.

doc/change_log.txt   The above in flat text. 

src/*.c src/*.h  The toolkit source files

src/Makefile  The standard make file.

src/install-sh  Shell script to install executables in the appropriate
   directory. An improvement on cp, as it will check to see whether it is 
   about to overwrite an execuatable which is already in use.

include/SLM2.h   File containing all of src/*.h, allowing 
   functions from the toolkit to be included in new software.

bin/   Directory where executables will be installed.

lib/   Directory where SLM2.a will be stored (useful in conjunction with 
   include/SLM2.h for including functions from the toolkit to be included 
   in new software.)





