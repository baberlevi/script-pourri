#!/bin/bash

#looking for condo modules we don't have in RISA
#risa modules at ~/rit/modules
#condo modules at ~/condo-modules

for module in $(find ~/condo-modules/ -name .git -prune -o -type f -print| cut -f 5,6 -d "/"); do
  if [ ! -f ~/rit/modules/$module ]; then
    echo $module >> ./data/missing_risa.txt
  fi
done
