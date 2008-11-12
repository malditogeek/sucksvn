#!/bin/bash
# Mauro Pompilio 2008

WTF=" Update a local branch with the latest modifications in the trunk. "

if [ "$1" = "--help" ] || [ ! -n "$1" ];then
  echo $WTF
  echo " USAGE: trunk_to_branch.sh <branch_name>"
else
  # Logging
  echo "[SucksVN] Updating BRANCH \"$1\" with the latest TRUNK updates."
  echo "[`date -R`] Trunk => $1 branch" >> $SVNLOG
  
  # Getting the latest update revision
  REV=`svn log --stop-on-copy svn+ssh://$SVNUSER@$SVNURL/branches/$1 |egrep "trunk_to_branch_update" -A 0 -B 2 -m 1 |head -n1 |cut -f 1 -d "|" |sed s/r// |tr -d " "`

  # If not available, use the stop-on-copy revision
  if [ -n "$REV" ]; then
    echo " + Updating since the last 'trunk_to_branch_update'."
  else
    echo " + Using the last --stop-on-copy revision."
    REV=`svn log --stop-on-copy svn+ssh://$SVNUSER@$SVNURL/branches/$1 |egrep 'r[0-9]+' |tail -n1 |cut -f 1 -d "|" |sed s/r// |tr -d " "`
  fi

  MERGEREV=`expr $REV - 1`
  echo " + Using revision $MERGEREV"
  
  # Merging
  echo " + Merging..."
  svn merge -r$MERGEREV:HEAD svn+ssh://$SVNUSER@$SVNURL/trunk $SVNPATH/branches/$1
  
  echo ""
  echo " + IMPORTANT: Fix the conflicts and commit with the 'trunk_to_branch_update' message."
fi
