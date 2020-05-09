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
       echo "_$DIR/${'${line}'%.*}.md"
       if [ -f "_$DIR/${'${line}'%.*}.md" ]; then
           if [ -f "_$DIR/${'${line}'%.*}.md" ]; then
               echo "IMPOSSIBLE! it can't exist at both the places!";
           else
               echo "it was created!";
               echo "creating "_$DIR/${'${line}'%.*}.md"";
               echo "---$'\n'layout: caption$'\n'title: ${'${line}'%.*}$'\n'image: ${line}$'\n'permalink: 'captions/'${'${line}'%.*}---$'\n'" > "_$DIR/${'${line}'%.*}.md";
           fi
       else
           if [ -f "_$DIR/${'${line}'%.*}.md" ]; then
               echo "it was deleted!";
               rm -f "_$DIR/${'${line}'%.*}.md";
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
