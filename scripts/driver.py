import sys
import os.path

from ngram_splitter import Extractor


def throw_help():
    print("Invalid arguments\n \
        Proper usage of split is:\n \
            python driver.py split <inputfile> <outputfile> <year>")

def check_number(year):
    try:
        num_year = int(year)
        if (num_year < 1500) or (num_year > 2008):
            print("Year must be between 1500 and 2008 incl.") 
            return False
        return True
    except ValueError:
        print("Year must be numeric")
        return False

def run_splitter():
    if not os.path.isfile(sys.argv[2]):
        print("Input file does not exist")
        throw_help()
    if os.path.isfile(sys.argv[3]):
        print("Output file already exists")
    if not check_number(sys.argv[4]):
        throw_help()
    ex = Extractor(sys.argv[2], sys.argv[4])
    ex.extract_to(sys.argv[3])

try:
    if sys.argv[1] == "split":
        run_splitter()
    else:
        throw_help()
except IndexError:
    throw_help()
