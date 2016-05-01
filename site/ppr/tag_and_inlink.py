#!/usr/bin/env python
from bs4 import BeautifulSoup, SoupStrainer
import re
from os import listdir
from os.path import isfile, join
from jinja2 import Environment, FileSystemLoader
from collections import defaultdict
from pprint import pprint


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
    errorlist = []
    for f, html in htmlbody:   
        realtitle = gettitle(html)
        normal = normalize(realtitle)
        inlinks[normal] = (realtitle, f)

    for f, html in htmlbody:

        html = BeautifulSoup(html, 'lxml')
        for link in html.findAll('a', {'class':'inlink'}):
            # if already linked to another file, it was probably previously processed.
            # no need to touch.
            if ".html" in link['href']:
                break

            text = link['href']
            text = normalize(text)

            if not link.get_text().strip():
                #link.string = link[text][0]
                link.string = link['href'] # paste non-normalized text

            if text not in inlinks:
                errorlist.append("In %s, found %s." % (f, text))
            else:
                _ , link['href'] = inlinks[text]
                #print "found a link! %s: %s;\nMapping to %s: %s (RealTitle:" % (f, text, text, inlinks[text]) 
        filename = f
        outfiles.append((f, html.prettify("utf-8")))
    if errorlist:
        print "INLINK ERRORS"
        print "Could not match the following titles to any document:"
        pprint(errorlist)
        print "------"
        print "Here's the list of names I know of: "
        print
        pprint(inlinks.keys())
        
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
            ref = '../' + f
            tagdict[tagname].append((title, ref))
    for tag in tagdict:
        f = "tags/%s.html" % tag
        #f = "%s/tags/%s.html" % (htmldir, tag)
        html = template.render(tag=tag, files=tagdict[tag])
        mybody.append((f, html))
    return mybody

#     for tag in tagdict:
#         with open("%s/tags/%s.html" % (htmldir, tag), "wb") as fh:
#             fh.write(template.render(tag=tag, files=tagdict[tag]))

htmldir = '../www/html/'
htmlfiles = [f for f in listdir(htmldir) if isfile(join( htmldir, f )) and re.match('.*\.html$', f )]
htmlbody = [(f, open(join(htmldir, f), 'r').read()) for f in htmlfiles]
# [ (filepath, html) ]
# filepaths need to be relative to www/html/ dir
htmlbody = inlinking(htmlbody) # substitutes in-links
htmlbody = tagging(htmlbody) # adds a bunch of tag-page-lists into /tags

for f, html in htmlbody:
    with open(join(htmldir, f), "wb") as fh:
        fh.write(html)
