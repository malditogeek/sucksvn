#!/bin/bash
# Mauro Pompilio 2008

WTF=" Create a branch and check out a local copy."

if [ "$1" = "--help" ] || [ ! -n "$1" ];then
  echo $WTF
  echo " USAGE: mkbranch.sh <branch_name>"
else
  # Logging
  MSG="[SucksVN] Creating branch: $1"
  echo $MSG
  echo "[`date -R`] New branch: $1" >> $SVNLOG
  
  # Branching
  svn copy svn+ssh://$SVNUSER@$SVNURL/trunk svn+ssh://$SVNUSER@$SVNURL/branches/$1 -m "$MSG"
  
  # Cheking out and setting up DB
  svn checkout svn+ssh://$SVNUSER@$SVNURL/branches/$1 $SVNPATH/branches/$1
  ln -s $SVNPATH/shared/database.yml $SVNPATH/tags/$1/config/database.yml
  
  echo " + Checked out to: $SVNPATH/branches/$1"
fi
