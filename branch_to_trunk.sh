#!/bin/bash
# Mauro Pompilio 2008

WTF=" Merge a branch into the local trunk."

if [ "$1" = "--help" ] || [ ! -n "$1" ];then
  echo $WTF
  echo " USAGE: branch_to_trunk.sh <branch_name>"
else
  # Logging
  echo "[SucksVN] Merging BRANCH \"$1\" into TRUNK"
  echo "[`date +"%Y%m%d %H:%M"`] Trunk <= $1 branch" >> $SVNLOG
  
  # Getting the latest update revision
  echo " + Using the last --stop-on-copy revision on the branch."
  REV=`svn log --stop-on-copy svn+ssh://$SVNUSER@$SVNURL/branches/$1 | egrep 'r[0-9]+' | tail -n1 | cut -f 1 -d "|" | sed s/r// | tr -d " "`
  
  echo " + Using revision $REV"
  
  # Update
  echo " + Updating local trunk."
  svn update $SVNPATH/trunk

  # Merge
  echo " + Merging \"$1\"..."
  svn merge -r$REV:HEAD svn+ssh://$SVNUSER@$SVNURL/branches/$1 $SVNPATH/trunk
fi
