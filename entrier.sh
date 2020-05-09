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
       echo "_${line}"
       if [ -f "${line}" ]; then
           if [ -f "_${line}" ]; then
               echo "IMPOSSIBLE! it can't exist at both the places!";
           else
               echo "it was created!";
               echo "creating '_${line}'";
               echo "---$'\n'layout: caption$'\n'title: ${${line}%.*}$'\n'image: ${line}$'\n'permalink: 'captions/'${${line}%.*}---$'\n'" > "_${line}";
           fi
       else
           if [ -f "_${line}" ]; then
               echo "it was deleted!";
               rm -f "_${line}";
           else
               echo "IMPOSSIBLE! it can't exist nowhere! it has to exist somewhere!";
           fi
       fi
    (( count++ ))
    done < changes
else
    echo "$DIR doesn't exist!";
fi
echo End Of Entry;
