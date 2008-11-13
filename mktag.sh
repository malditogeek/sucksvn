#!/bin/bash
# Mauro Pompilio 2008

WTF=" Create a tag and check out a local copy. "

if [ "$1" = "--help" ] || [ ! -n "$1" ];then
  echo $WTF
  echo " USAGE: mktag.sh <tag_name>"
else
  # Logging
  MSG="[SucksVN] Creating tag: $1"
  echo $MSG
  echo "[`date +"%Y%m%d %H:%M"`] New tag: $1" >> $SVNLOG
  
  # Tagging
  svn copy svn+ssh://$SVNUSER@$SVNURL/trunk svn+ssh://$SVNUSER@$SVNURL/tags/$1 -m "$MSG"
  
  # Cheking out and setting up DB
  echo " + Checking out a local copy."
  svn checkout svn+ssh://$SVNUSER@$SVNURL/tags/$1 $SVNPATH/tags/$1

  if [ -f $SVNPATH/shared/database.yml ]; then
    echo " + Linking database.yml"
    ln -s $SVNPATH/shared/database.yml $SVNPATH/tags/$1/config/database.yml
  else
    echo " - Not setting up DB."
  fi
  
  echo " + Checked out to: $SVNPATH/tags/$1"
fi
