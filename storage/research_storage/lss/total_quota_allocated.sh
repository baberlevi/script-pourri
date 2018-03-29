#!/bin/bash
gluster volume quota lss list | tr -s " " | cut -d ' ' -f 2 | cut -d '.' -f 1 | grep -v -e '-' -e 'Path' | paste -s -d + - | bc
