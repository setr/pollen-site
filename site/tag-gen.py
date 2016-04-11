#!/usr/bin/env python
from bs4 import BeautifulSoup
from collections import defaultdict
import re
from os import listdir
from os.path import isfile, join
from jinja2 import Environment, FileSystemLoader

htmlfiles = [f for f in listdir('www/html') if isfile(join('www/html', f))]
htmlfiles = [f for f in htmlfiles if re.match('.*\.html$', f)]

env = Environment(loader=FileSystemLoader('.'))
template = env.get_template('tag-template.html')

tagdict = defaultdict(list)
for f in htmlfiles:
    fi = 'www/html/' + f
    soup = BeautifulSoup(open(fi), 'lxml')
    print fi
    print soup.body.h1.string
    title = soup.body.h1.string
    for tag in soup.find("div", class_="tags").children:
        if tag.name == "a": 
            tagname = tag.string
            ref = '../' + f
            tagdict[tagname].append((title, ref))
            print tag.string

           #print tag['href']
    print '--------------'
print tagdict

print '\n\n\n'
for tag in tagdict:
    # print tag
    # for title, ref in tagdict[tag]:
    #     print title,':::', ref
    # print '----------'
    with open("www/html/tags/%s.html" % tag, "wb") as fh:
        fh.write(template.render(tag=tag, files=tagdict[tag]))


