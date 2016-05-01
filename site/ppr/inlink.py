#!/usr/bin/env python
from bs4 import BeautifulSoup, SoupStrainer
import re
from os import listdir
from os.path import isfile, join
from jinja2 import Environment, FileSystemLoader
from collections import defaultdict

roothtmldir = 'www/html'
env = Environment(loader=FileSystemLoader('.'))
template = env.get_template('tag-template.html')
# ismodified? filename htmlcontent

def normalize(text):
    return text.strip().lower()

def gettitle(html):
    parse = SoupStrainer('h1', id='title')
    realtitle = BeautifulSoup(html, 'lxml', parse_only=parse).get_text()
    return realtitle

def inlinking(htmlbody):
    outfiles = []
    inlinks = dict()
    for f, html in htmlbody:   
        realtitle = gettitle(html)
        normal = normalize(realtitle)
        inlinks[normal] = (realtitle, f)

    for f, html in htmlbody:
        changed = False

        html = BeautifulSoup(html, 'lxml')
        for link in html.findAll('a', {'class':'inlink'}):
            # if already linked to another file, it was probably previously processed.
            # no need to touch.
            if ".html" in link['href']:
                break

            text = link['href']
            text = normalize(text)

            if not link.get_text().strip():
                link.string = link[text][0]
                link.string = link['href'] # paste non-normalized text

            if text not in inlinks:
                print "Hey! You've got an inlink in %s that doesn't match any title I know of: %s" % (f, text)
            else:
                _ , link['href'] = inlinks[text]
                changed = True
                print "found a link! %s: %s;\nMapping to %s: %s (RealTitle:" % (f, text, text, inlinks[text]) 
        filename = htmldir + "/" + f
        outfiles.append((filename, html.prettify("utf-8")))
    return outfiles
        
        #if changed:
        #    with open(join(htmldir, f), "wb") as fh:
        #        fh.write(html.prettify("utf-8"))

def tagging(htmlbody):
    tagdict = defaultdict(list)
    mybody = list(htmlbody)
    for f, html in htmlbody:
        title = gettitle(html)

        parse = SoupStrainer('div', {'class': 'tags'})
        soup = BeautifulSoup(html, 'lxml', parse_only=parse)    
        # all links within the tags section
        for tag in soup.findAll('a'):
            tagname = tag.string.strip()
            ref = '../../' + f
            tagdict[tagname].append((title, ref))
    for tag in tagdict:
        f = "%s/tags/%s.html" % (htmldir, tag)
        html = template.render(tag=tag, files=tagdict[tag])
        mybody.append((f, html))
    return mybody

#     for tag in tagdict:
#         with open("%s/tags/%s.html" % (htmldir, tag), "wb") as fh:
#             fh.write(template.render(tag=tag, files=tagdict[tag]))

htmldir = '../www/html'
htmlfiles = [f for f in listdir(htmldir) if isfile(join( htmldir, f )) and re.match('.*\.html$', f )]
htmlbody = [(f, open(join(htmldir, f), 'r').read()) for f in htmlfiles]

htmlbody = inlinking(htmlbody)
htmlbody = tagging(htmlbody)

for f, html in htmlbody:
    with open(f, "wb") as fh:
        print f
        fh.write(html)
