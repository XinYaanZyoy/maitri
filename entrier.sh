#!/bin/bash
echo Start of Entry;
echo $'\n'"git status: $(git status)"$'\n';
DIR="arts";
status=false;
if [ -d "$DIR" ]; then
    git log -1 --name-only --oneline > changes
    i=0
    while read -r line; do
       printf '%d %s\n' "$i" "${line}"
       if [ -f "${line}" ]; then
           if [ -f "_${line}" ]; then
               echo "IMPOSSIBLE!";
           else
               echo "it was created!";
           fi
       else
           if [ -f "_${line}" ]; then
               echo "it was deleted!";
           else
               echo "IMPOSSIBLE!";
           fi
       fi
    (( count++ ))
    done < changes
else
    echo "$DIR doesn't exist!";
fi
echo End Of Entry;
