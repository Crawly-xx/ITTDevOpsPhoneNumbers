#!/bin/bash

# check if the country code is provided as a parameter
if [ $# -eq 0 ]; then
    echo "Usage: $0 <country code> <net_number>"
    exit 1
fi

# read the country code parameter
country_code=$1
net_number=$2

# read the name of the input file
read -p "Enter the name of the input file: " input_file

# check if the input file exists
if [ ! -f $input_file ]; then
    echo "Input file not found!"
    exit 1
fi

# read the name of the output file
read -p "Enter the name of the output file: " output_file

# add the country code to phone numbers in the input file and save to the output file
while read line; do
    # skip empty lines and lines starting with #
    if [[ -z $line || ${line:0:1} == "#" ]]; then
        echo $line >> $output_file
        continue
    fi

    # extract the phone number
    phone_number=$(echo $line | cut -d ' ' -f 1)

    # add the country code to the phone number & write to the output field
    phone_number="$country_code$net_number$phone_number"
    echo "$phone_number" >> $output_file

done < $input_file

echo "Done!"