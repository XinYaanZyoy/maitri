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
       echo "_${line%.*}.md"
       if [ $i -ne 0 ]; then
           if [ -f "${line}" ]; then
               if [ -f "_${line%.*}.md" ]; then
                   echo "IMPOSSIBLE! it can't exist at both the places!";
               else
                   echo "it was created!";
                   echo "creating "_${line%.*}.md"";
                   fname="$(basename $line)";
                   echo "---"$'\n'"layout: caption"$'\n'"title: ${fname%.*}"$'\n'"image: ${line}"$'\n'"permalink: captions/${fname%.*}"$'\n'"---"$'\n''# '"Heading"$'\n'"Caption" > "_${line%.*}.md"
               fi
           else
               if [ -f "_${line%.*}.md" ]; then
                   echo "it was deleted!";
                   rm -f "_${line%.*}.md";
               else
                   echo "IMPOSSIBLE! it can't exist nowhere! it has to exist somewhere!";
               fi
           fi
       fi
       (( i++ ))
    done < changes
    echo "removing changes file"
    rm -f changes;
    echo $'\n'"git status: $(git status)"$'\n';
    git config --global user.name XinYaanZyoy && git config --global user.email XinYaanZyoy@gmail.com
    git add . && git commit -m "Art Entry: $(date)"
    echo $'\n'"git status: $(git status)"$'\n';
    git push "https://XinYaanZyoy:$GH_PAT@github.com/XinYaanZyoy/Art_Gallery.git" HEAD:master
else
    echo "$DIR doesn\'t exist!";
fi
echo End Of Entry;
