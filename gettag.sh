#!/bin/bash
# Mauro Pompilio 2008

WTF=" Check out a tag. "

if [ "$1" = "--help" ] || [ ! -n "$1" ];then
  echo $WTF
  echo " USAGE: gettag.sh <tag_name>"
else
  # Logging
  MSG="[SucksVN] Checking out tag: $1"
  echo $MSG
  echo "[`date -R`] New tag: $1" >> $SVNLOG
  
  # Cheking out and setting up DB
  svn checkout svn+ssh://$SVNUSER@$SVNURL/tags/$1 $SVNPATH/tags/$1
  ln -s $SVNPATH/shared/database.yml $SVNPATH/tags/$1/config/database.yml
  
  echo " + Checked out to: $SVNPATH/tags/$1"
fi
