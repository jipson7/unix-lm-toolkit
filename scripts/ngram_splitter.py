import sys
import os

class Extractor:
    year = None

    def __init__(self, year):
        self.year = year

    def open_output_file(self, output_name):
        try:
            output_file = open(output_name, 'w+')
        except IOError as ioprob:
            print(ioprob)
            sys.exit(0)

        return output_file

    def extract_to(self, output_name):
        output_file = self.open_output_file(output_name)
        
        for line in sys.stdin:
            if self.year_in_line(line):
                output_file.write(self.strip_data(line))

        output_file.close()

    def year_in_line(self, line):
        return (line.split()[-3] == str(self.year))

    def strip_data(self, line):
        """Removes last 2 columns of google n-gram data
        as it is unneeded for building LM"""
        #return ((line.strip()).rsplit(' ', 2)[0] + '\n')
        return (' '.join(line.split()[:-3]) + '\n')

def throw_help():
    print("Invalid arguments\n \
        Proper usage of split is:\n \
            zcat infile.gz | python ngram_splitter.py <outputfile> <year>")
    sys.exit(0)

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
    if os.path.isfile(sys.argv[1]):
        print("Output file already exists")
    if not check_number(sys.argv[2]):
        throw_help()
    ex = Extractor(sys.argv[2])
    ex.extract_to(sys.argv[1])

        

if __name__ == "__main__":
    run_splitter()

