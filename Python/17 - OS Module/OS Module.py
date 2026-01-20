import os

# Creating a folder
os.mkdir("data")

# Creating a series of folder at once
if os.path.exists("data"):
    for i in range(10):
        os.mkdir(f"data/Day - {i}")

# Renaming folders
if os.path.exists('data'):
    for i in range(9):
        os.rename(f"data/Day - {i}", f"data/Tutorial - {i}")

# List of folders / Files inside a folder
files_and_folders = os.listdir('data')
print(files_and_folders)

# folders in folder
for i in range(9):
    files_and_folders = os.listdir(f'data/Tutorial - {i}')
    print(files_and_folders)

# Which directory you are at? - return a complete path
import os
print(os.getcwd())

# Changing the directory
import os
os.chdir('/Programming')
print(os.getcwd())


import os
import regex as re

if os.path.exists('9 - Miscellaneous'):
    for i in os.listdir('9 - Miscellaneous'):
        match = re.match(r'\d+\s-\s(.*)', i) 
        if match: 
            new_name = match.group(1)
            os.rename('9 - Miscellaneous/' + i, '9 - Miscellaneous/' + new_name)