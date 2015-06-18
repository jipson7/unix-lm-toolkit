import sys
import os.path
import sets

def display_help():
    print("Invalid Arguments")
    print("Proper Usage:")
    print("     python create_vocab.py <input_file> <output_file>")
    sys.exit(0)

def in_vocab(word):
    if word in vocab_set:
        return True
    else:
        vocab_set.add(word)
        return False

def build_vocab():
    o = open(output_file, 'w+')
    with open(input_file) as i:
        for line in i:
            words = line.split()[:-1]
            for word in words:
                if not in_vocab(word):
                    o.write(word)
                    o.write('\n')
    o.close()

try:
    input_file = sys.argv[1]
    output_file = sys.argv[2]
except Exception:
    display_help()

if not os.path.exists(input_file):
    print("Input file does not exist")
    display_help()

if os.path.exists(output_file):
    print("Output file already exists. Select a different one.")
    display_help()

vocab_set = sets.Set()

build_vocab()
