# For anyone reading this program code it literally does nothing. It converts map file from binary to variable and writes the file back in hex. I wrote it at 3 AM and I genuinely dont know what it supposed to do. I'm still leaving it in just in case I want to do something with it.

#UPDATE: Oke worked on this a little more and now it detects crudely if there is any 'sign' in the level AKA if there is any actual ASCII string longer than 3 characters.

import binascii
import re
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
    
    # Gets binary, hex and string data into accesible variable
    def get_data(self):
        with open(self.full_path, 'rb') as file:
            self.binary_data = file.read()
            self.hex_data = binascii.hexlify(self.binary_data)
            
            #Replace all unwanted binary into underscore character
            REPLACE = [b'\x00', b'\x0D', b'\x0A', b'\x0B', b'\x09', b'\x01', b'\x04', b'\x08', b'\xEF', b'\xBF', b'\xBD', b'\x02', b'\x12', b'\x0C', b'\x03', b'\x1E', b'\x0F', b'\x5F', b'\x05', b'\x14', b'\x10', b'\x7F', b'\x0E', b'\x06', b'\x15', b'\x07', b'\x2C', b'\x2E', b'\x60', b'\x13', b'\x11']
            self.bin_cleaned = self.binary_data
            
            for condition in REPLACE:
                self.bin_cleaned = self.bin_cleaned.replace(condition, b'\x5F')
            
            self.string_bin = str(self.bin_cleaned.decode('ascii', 'ignore'))
            self.string_bin_no_header = self.string_bin[80:]
    
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

    #Ensuring that the file is correct format
    if map.extension == 'lmp':
        map.get_data()
        map.is_map = True
    else:
        continue
    
    
    #Matching anything longer than 3 characters to find any sign
    #Also skipping the header info to not trigger detection
    regex_rule = r'[a-zA-Z \\n]{3,}'
    regex = re.search(regex_rule, map.string_bin_no_header)
    
    if regex == None:
        continue
    
    with open(map.output_file, 'w') as file:
        file.write(str(map.string_bin_no_header))