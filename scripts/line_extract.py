import sys

def year_in_line(line, year):
    return (line.split()[-3] == str(year))

def line_is_printable(line):
    try:
        line.decode('ascii')
    except UnicodeDecodeError:
        return False
    else:
        return True

def strip_data(line):
    """Removes the year column and number
    of books column. Keeps the ngram and the count"""
    line_items = line.split()
    clean_data = line_items[:-3] + [line_items[-2]]
    return ((' '.join(clean_data)).strip())

def extract(year):
    for line in sys.stdin:
        if year_in_line(line, year):
            print(strip_data(line))
  

if __name__ == "__main__":
    year = sys.argv[1] 
    extract(year)
