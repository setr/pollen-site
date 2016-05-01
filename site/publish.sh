#!/usr/bin/env bash
DIRECTORY="/Users/neil/blog/site"
if [ ! -d $DIRECTORY ]; then
    echo "I am meant to be executed in $DIRECTORY, but it doesn't seem to exist.
        As this script will remove directories, please ensure you fix the problem,
        or the script."
    exit 0
fi

# make sure our working directory is correct..
cd $DIRECTORY
rm -rf www/
mkdir www/
# temp directory because I don't want pollen garbage (cache, output files) 
# in my working directory
mkdir temp
cp -r ../source ../css ../js temp/
mv temp/source temp/html
cd temp

# because pollen render is broken
# tell it to render a directory and it reads the path as dir/dir/
# so we have to go into each folder first, and render from there
cd html && raco pollen render 

cd ../css && raco pollen render 
cat *.css | csso > mangled.css  # css minifying

cd ../js && raco pollen render

cd $DIRECTORY

# files that we don't want to get published, but pollen won't skip over
rm temp/html/template.html  
rm temp/html/null.null

raco pollen publish temp/ www/

rm -rf temp

mkdir www/html/tags/

cd ppr  
./tag_and_inlink.py
#./tag-gen.py

cd $DIRECTORY
