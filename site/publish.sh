#!/usr/bin/env bash
shopt -s extglob

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
rm !(mangled.css)
cp mangled.css tagstyle.css

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
### MINCSS ###
# start up a simple webserver so the css paths function correctly
cd www
python -m SimpleHTTPServer 8000 &
serverpid=$!

# mincss removes any css that isn't being used by the site
# finds the lowest_common_denominator
# not doing it on an individual basis, because we'd be worse off due to caching.
# not using it through python because it's not as effective, for whatever reason
serverpath="http://localhost:8000/"
args=""
for f in `ls html/*.html`; do
    args+="$serverpath$f "
done
echo $args

# mincss the notes
mincss $args --outputdir css/
# mincss a single tag-file (since they're all going to be the same)
mincss "$serverpath$(ls html/tags/*.html | head -n 1)" --outputdir css/
kill $serverpid

# cd $DIRECTORY
# # tags only get generated after
# # only one tag file is necessary
# cd www/html/tags
# a=$(ls *.html | head -n 1)
# mincss $a --outputdir ../../css/

#cd $DIRECTORY && rm www/css/before_* # get rid of the backup files from mincss
