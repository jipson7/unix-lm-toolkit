import sys
import os.path
import sets

def display_help():
    print("Invalid Arguments")
    print("Proper Usage:")
    print("     python create_vocab.py <input_file>")
    print("Output should be piped or redirected")
    sys.exit(0)

def in_vocab(word):
    if word in vocab_set:
        return True
    else:
        vocab_set.add(word)
        return False

def build_vocab():
    with open(input_file) as i:
        for line in i:
            words = line.split()[:-1]
            for word in words:
                if not in_vocab(word):
                    print(word)

try:
    input_file = sys.argv[1]
except Exception:
    display_help()

if not os.path.exists(input_file):
    print("Input file does not exist")
    display_help()

vocab_set = sets.Set()

build_vocab()
