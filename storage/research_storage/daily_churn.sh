#!/bin/bash


for filename in $(ls) ; do
	cat $filename | cut -f 1 -d ' ' | grep -v -e 'Size' -e '==' | paste -sd+ | bc >> "churn_report"
done

