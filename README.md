# script-pourri

Unrelated scripts, not worth creating repos for individually, but little examples that will save me time by having them readily accessible so I don't need to lookup syntax or option flags again.

* boxftp.sh - Reverse mirror upload a directory to box via ftp (make sure ~/.lftprc is setup for ssl)
  * set ftp:ssl-force yes
  * set ftp:ssl-protect-data yes
  * set ftp:ssl-auth TLS
* daily_churn.sh - read in a bunch of text files with file size usage per day (one file per user folder), sum up by day and output so I can look at daily delta
* turtle_data_cleanup.r - read in a tsv, do some data manipulation, output csv
