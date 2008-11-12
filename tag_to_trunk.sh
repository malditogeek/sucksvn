#!/bin/bash
# Mauro Pompilio 2008

WTF=" Merge a tag into the local trunk. "

if [ "$1" = "--help" ] || [ ! -n "$1" ];then
  echo $WTF
  echo " USAGE: tag_to_trunk.sh <tag_name>"
else
  # Logging
  echo "[SucksVN] Merging TAG \"$1\" into TRUNK"
  echo "[`date +"%Y%m%d %H:%M"`] Trunk <= $1 tag" >> $SVNLOG
  
  # Getting revision
  echo " + Using the last --stop-on-copy revision on the tag."
  REV=`svn log --stop-on-copy svn+ssh://$SVNUSER@$SVNURL/tags/$1 | egrep 'r[0-9]+' | tail -n1 | cut -f 1 -d "|" | sed s/r// | tr -d " "`
  echo " + Using revision $REV"
  
  # Merging
  svn merge -r$REV:HEAD svn+ssh://$SVNUSER@$SVNURL/tags/$1 $SVNPATH/trunk
fi 
