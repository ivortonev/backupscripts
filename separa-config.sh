#!/bin/bash

FIND=/usr/bin/find
CUT=/usr/bin/cut
SORT=/usr/bin/sort
UNIQ=/usr/bin/uniq
SED=/bin/sed
MKDIR=/bin/mkdir
MV=/bin/mv
XZ=/usr/bin/xz

cd /home/confbackup

ARQUIVO=`$FIND -maxdepth 1 -type f | $CUT -f 1-4 -d "-" | $CUT -f 2 -d "/" | $SORT -n | $UNIQ `

for a in $ARQUIVO ; do
	DIR=`echo $a | $SED -e 's/-/\//g'`
	if [ ! -d $DIR ]; then
		$MKDIR -p $DIR;
	fi
	$MV $a* $DIR
done

LISTA=`$FIND -mindepth 3 -type f  | grep -v xz$`

for i in $LISTA ; do
	$XZ -z -9 -e $i
done;
