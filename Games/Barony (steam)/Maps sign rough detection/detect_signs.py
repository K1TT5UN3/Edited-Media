# For anyone reading this program code it literally does nothing. It converts map file from binary to variable and writes the file back in hex. I wrote it at 3 AM and I genuinely dont know what it supposed to do. I'm still leaving it in just in case I want to do something with it.

import binascii
from os import listdir
from os.path import isfile, join


# Class for one map file for further editing
class map_file:

    def __init__(self, full_name):
        # All needed variations of name and path
        self.is_map = False
        self.full_name = full_name
        self.full_path = './maps/' + full_name
        self.name = full_name[:-4]
        self.extension = full_name[-3:]
        self.output_file = './outputs/' + full_name[:-4]
    
    # Gets binary and hex data into accesible variable
    def get_binary(self):
        with open(self.full_path, 'rb') as file:
            self.binary_data = file.read()
            self.hex_data = binascii.hexlify(self.binary_data)
    
    # Create output file based on given data while staying attached to original file
    # data -> Any type = Any given data that will be written into the file. Can be both binary and text.
    # name -> String = Any name that will be appended to output file name.
    # if_binary -> Bool = Flag used to allow writing in both binary mode and regular mode.
    def output_file(self, data, name, if_binary=False):
        
        if if_binary == True:
            flags = 'wb'
        else:
            flags = 'w'
        
        out_file_name = self.output_file + '__' + name
        
        with open(out_file_name, flags) as file:
            file.write(data)


# Reading all files in maps directory
all_map_files = [f for f in listdir('./maps') if isfile(join('./maps', f))]


# Turn each file into object and insert into list
map_list = []

for map in all_map_files:
    map_list.append(map_file(map))


# Compute every needed data in each map file and export it to a file.
for map in map_list:

    if map.extension == 'lmp':
        map.get_binary()
        map.is_map = True
    
    with open(map.output_file, 'w') as file:
        file.write(str(map.binary_data.decode("ascii", 'replace')))
