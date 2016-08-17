lftp -u <yourusername> -e "mirror -c -v -p --reverse --only-missing --include-glob=somfile-split.tar.lz4?? /<localdir> <box_dir_no_leading_trailing_slash>" ftp://ftp.box.com
