#!/bin/bash

#install dbf tools from xbase
sudo yum -y install perl-DBD-XBase

#Whitehouse call to action on traffic fatalities: https://www.whitehouse.gov/blog/2016/08/29/2015-traffic-fatalities-data-has-just-been-released-call-action-download-and-analyze
#as of this writing 20160908, the NHTSA csv formatted crash data files are not available
#download the dbf files, and convert them
mkdir -p data/nhtsa/dbf
cd data/nhtsa
wget ftp://ftp.nhtsa.dot.gov/fars/2015/National/FARS2015NationalDBF.zip
unzip -d dbf FARS2015NationalDBF.zip
mkdir -p csv

#convert the files to csv
ls -1 dbf | cut -f 1 -d '.' | xargs -I dbffile sh -c 'dbfdump.pl --fs "," dbf/dbffile.dbf > csv/dbffile.csv'

#get column names from dbf
#dbfdump.pl --info accident.dbf | cut -f 2 | cut -f 1 -d ' ' | tail -n +10 | awk '{print $1" string,"}'
