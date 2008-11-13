#!/bin/bash
# Mauro Pompilio 2008

WTF=" Check out a branch. "

if [ "$1" = "--help" ] || [ ! -n "$1" ];then
  echo $WTF
  echo " USAGE: getbranch.sh <branch_name>"
else
  # Logging
  MSG="[SucksVN] Checking out branch: $1"
  echo $MSG
  echo "[`date +"%Y%m%d %H:%M"`] New branch: $1" >> $SVNLOG
  
  # Cheking out and setting up DB
  echo " + Checking out a local copy"
  svn checkout svn+ssh://$SVNUSER@$SVNURL/branches/$1 $SVNPATH/branches/$1

  if [ -f $SVNPATH/shared/database.yml ]; then
    echo " + Linking database.yml"
    ln -s $SVNPATH/shared/database.yml $SVNPATH/branches/$1/config/database.yml
  else
    echo " - Not setting up DB."
  fi
  
  echo " + Checked out to: $SVNPATH/branches/$1"
fi
