#!/bin/bash
mkfifo /tmp/spackpipe1;
mkfifo /tmp/spackpipe2;
ls -1 /opt/rit/app | \
        xargs -I pkgname sh -c \
	"(spack --color never find pkgname | grep -i 'no package' | cut -d ':' -f 2 )" > /tmp/spackpipe1 & \
        xargs -I pkg2 sh -c "script -q --return -c \"spack --color never list pkg2 ; echo 'looking for pkg2' \" /tmp/spackpipe2 & sed -n -e '/[1-9] packages./,/looking for/ p' < /tmp/spackpipe2  >> spack_installable_we_need " < /tmp/spackpipe1 ;

rm /tmp/spackpipe1;
rm /tmp/spackpipe2;
