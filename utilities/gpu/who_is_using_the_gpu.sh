#!/bin/bash
ps -up $(nvidia-smi | tail -n 30 | head -n -1 | tr -s " " | cut -d " " -f 3 )
# todo: find a more elegant way determine where the process list starts
