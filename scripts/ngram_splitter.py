import sys


class Extractor:
    ngram_file = None
    year = None

    def __init__(self, filename, year):
        self.ngram_file = filename
        self.year = year

    def open_output_file(self, output_name):
        try:
            output_file = open(output_name, 'w+')
        except IOError as ioprob:
            print(ioprob)
            sys.exit(0)

        return output_file

    def extract_to(self, output_name=None):
        if output_name is None:
            output_name = ngram_file + year

        output_file = self.open_output_file(output_name)
        
        #Open the input file
        with open(self.ngram_file) as ngram:
            for line in ngram:
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
        

