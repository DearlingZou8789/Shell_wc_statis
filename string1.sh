# !/bin/bash

string="My long String"
if [[ $string == *"My long"* ]]; then
    echo "It's there!"
fi
