#!/bin/bash
echo Start of entry;
echo $'\n'"git status: $(git status)"$'\n';
DIR="art";
status=false;
if [ -d "$DIR" ]; then
    echo "changing directory to $DIR";
    cd $DIR;
    TODATE=$(date +%F);
    if [ "$(ls -A)" ]; then
        find *.* -type f -exec echo Found file {} \;
        for f in *.*
            do
                if [ ! -d "../arts" ]; then
                    mkdir "../arts"
                fi
                echo "entring: $f => "../arts/$f"";
                echo $'\t'$TODATE:$'\n'$'\t'$'\t'image:"$f"$'\n'$'\t'$'\t'title:""$'\n'$'\t'$'\t'caption:"" > tmp;
                cat "../_config.yml" tmp > "../config.yml";
                status=true;
            done
        if [ "$status" = true ]; then
            echo "changing directory to root of this repo";
            cd ..;
            echo "deleting $DIR";
            rm -r -f $DIR;
            echo $'\n'"git status: $(git status)"$'\n';
            git config --global user.name XinYaanZyoy && git config --global user.email XinYaanZyoy@gmail.com
            git add . && git commit -m "entry: $(date)"
            git push "https://XinYaanZyoy:$GH_PAT@github.com/XinYaanZyoy/Maitri_Art_Gallery.git" HEAD:master
        fi
    else
        echo "$DIR is Empty; Skipping Transformation!";
    fi
else
    echo "$DIR doesn't exist!";
fi
echo End Of Transformation;
