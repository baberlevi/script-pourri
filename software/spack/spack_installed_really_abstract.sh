#!/bin/bash
spack find --explicit --variants | grep -v -e '\-\-' -e 'installed' | sed 's/ /,/' | sed 's/patches\S*//g' | sed 's/@\S*//g' | sort | uniq > abstract_specs.txt
