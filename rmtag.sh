#!/bin/bash
# Mauro Pompilio 2008

WTF=" Remove the remote and local copies of a tag."

if [ "$1" = "--help" ] || [ ! -n "$1" ];then
  echo $WTF
  echo " USAGE: rmtag.sh <tag_name>"
else
  # Logging
  MSG="[SucksVN] Removing tag: $1"
  echo $MSG
  echo "[`date -R`] Deleted tag: $1" >> $SVNLOG
  
  # Removing remote and local tag
  svn rm svn+ssh://$SVNUSER@$SVNURL/tags/$1 -m "$MSG"
  rm -rf $SVNPATH/tags/$1
  
  echo " + Removed tag and local working copy: $SVNPATH/tags/$1"
fi
