#!/bin/bash
# Mauro Pompilio 2008

WTF=" Remove the remote and local copies of a branch."

if [ "$1" = "--help" ] || [ ! -n "$1" ];then
  echo $WTF
  echo " USAGE: rmbrach.sh <branch_name>"
else
  # Logging
  MSG="[SucksVN] Removing branch: $1"
  echo $MSG
  echo "[`date +"%Y%m%d %H:%M"`] Deleted branch: $1" >> $SVNLOG
  
  # Removing remote and local branch
  svn rm svn+ssh://$SVNUSER@$SVNURL/branches/$1 -m "$MSG"
  rm -rf $SVNPATH/branches/$1
  
  echo " + Removed branch and local working copy: $SVNPATH/branches/$1"
fi
