#!/bin/bash

#looking for condo modules we don't have in RISA
#risa modules at ~/rit/modules
#condo modules at ~/condo-modules

for module in $(find ~/condo-modules/ -type f -print | cut -f 2,3 -d "/"); do
  if [! -f ~/rit/modules/$module]; then
    echo $module >> missing_risa.txt
  fi
done
