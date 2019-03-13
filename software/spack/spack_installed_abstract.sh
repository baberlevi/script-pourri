#!/bin/bash
for package in $(spack find -l | grep -v '\-\-' | xargs -n2 echo | tr ' ' ,)
do 
    hash=$(echo $package | cut -d ',' -f 1 | grep -i -e [0-9,a-z] ) 
    pkgname=$(echo $package | cut -d ',' -f 2 | cut -d '@' -f 1 | grep -i -e [0-9,a-z] ) 
    spack spec /$hash | grep -v -e Input -e ----- | head -n 1 | sed 's/arch.*$//g' | sed 's/%gcc\S*//g' | sed 's/@\S*//g' | sed 's/patches\S*//g' > $pkgname.abstract
done
