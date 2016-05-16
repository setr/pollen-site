#!/usr/bin/env python
from bs4 import BeautifulSoup, SoupStrainer
import re
from os import listdir
from os.path import isfile, join, basename
from jinja2 import Environment, FileSystemLoader
from collections import defaultdict
from pprint import pprint
from mincss.processor import Processor


roothtmldir = 'www/html'
env = Environment(loader=FileSystemLoader('.'))
template = env.get_template('tag-template.html')
index = env.get_template('tag2.html')
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
    indexdict = defaultdict(list)
    mybody = list(htmlbody)
    for f, html in htmlbody:
        title = gettitle(html)

        parse = SoupStrainer('div', {'class': 'tags'})
        soup = BeautifulSoup(html, 'lxml', parse_only=parse)    
        # all links within the tags section
        for tag in soup.findAll('a'):
            tagname = tag.string.strip()
            ref = '/html/' + f
            indexdict[tagname].append((title, f))
            tagdict[tagname].append((title, ref))

    # All-Tag Index
    # list of (tag, tagdict[tag])
    inject = [(tag, tag.title(), indexdict[tag]) for tag in indexdict]
    mybody.append(('index.html', index.render(files=inject)))

    for tag in tagdict:
        f = "tags/%s.html" % tag
        #f = "%s/tags/%s.html" % (htmldir, tag)
        html = template.render(tag=tag, files=tagdict[tag])
        mybody.append((f, html))
    return mybody

def updatecss(htmlbody):
    outfiles = list()
    for f, html in htmlbody:
        parse = SoupStrainer('link', {'href': '../css/mangled.css'})
        soup = BeautifulSoup(html, 'lxml')
        for link in soup.find_all(parse):
            base = f.split('.')[0]
            print base
            css = '/css/%s.css' % base
            link['href'] = css
        outfiles.append((f, soup.prettify("utf-8")))
    return outfiles 
def gencss(htmldir, htmlfiles):
    fullpaths = map(lambda x: join(htmldir, x), htmlfiles)
    basenames = map(lambda x: x.split('.')[0], htmlfiles)
    cssdir = '../www/css/'
    p = Processor(optimize_lookup=True)
    for f, b in zip(fullpaths, basenames):
        p.process(f)
        for css in p.links:
            cssfile = join(cssdir, b) + ".css"
            with open(cssfile, 'wb') as fh:
                fh.write(css.after)

htmldir = '../www/html/'
htmlfiles = [f for f in listdir(htmldir) if isfile(join( htmldir, f )) and re.match('.*\.html$', f )]
htmlbody = [(f, open(join(htmldir, f), 'r').read()) for f in htmlfiles]
# [ (filepath, html) ]
# filepaths need to be relative to www/html/ dir
htmlbody = inlinking(htmlbody) # substitutes in-links
htmlbody = tagging(htmlbody) # adds a bunch of tag-page-lists into /tags

# css was for mincss, but this is a bad idea
# individual mincss'd files for each page would kill caching
# gencss(htmldir, htmlfiles)
# htmlbody = updatecss(htmlbody)

for f, html in htmlbody:
    with open(join(htmldir, f), "wb") as fh:
        fh.write(html)
