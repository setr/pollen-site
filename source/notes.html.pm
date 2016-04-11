#lang pollen
◊define-meta[tags]{notes, help}
◊define-meta[title]{Pollen Notes}

◊section{Pollen Files}
============
Pollen uses double-extension syntax. Extension#1 is the output format, and Extension#2 is the input format. (ie file.html.pmd)
◊filen{.txt} => text file
◊filen{.html} => html file
◊filen{.p} => pollen "null" extension; does nothing, but seperates our source from output. template.html == template.html.p
◊filen{.pp} => pollen preprocess
◊filen{.pmd} => preprocess then markdown
◊filen{.pm} => pollen markup (using file pollen.rkt for rules)
◊filen{.rkt} => racket source file
◊filen{pollen.rkt} => markdown ruleset
◊filen{template.html} => default template to insert into
◊filen{index.ptree} => file to specify navigation order (for prev, next etc)

alt + shift + v = 
◊snip{|variable|} for markdown-variable insertion
◊snip{(function)} for markdown-function call
◊snip{{tag}} for markdown-tag call
◊snip{tag{◊snip{|variable|} ◊snip{|variable|}}}

◊section{Pollen Template}
===============

◊filen{template.html.p}

◊snip{<html> ... </html>}
standard html file, .p passes it to pollen so we can apply racket code using 
◊snip{(->html)} converts X-expression to html
◊snip{(->html (html (head (meta #:charset "UTF-8")) (body doc)))}
=> 
◊highlight['html]{
<html> <head> <meta charset="UTF-8"> </meta> 
<body> |body| </body>
</head>}

the whole post-processed file will get stored in the variable ◊snip{|doc|} as a string
so basic template would hard define our html, head etc tags
and then we can just do something like ◊snip{<body> ◊snip{(->html doc)} </body>} for simple insertion of the source.

◊section{Pollen New-Markdown}
===================
pollen.rkt => auto-imported source file. local > parent; parent is not loaded if local dir has pollen.rkt
◊snip{(require "../pollen.rkt")}◊sidenote{I'll probably want to do code-snippets similarly to code styling instead of highlighting.} => import parent's pollen.rkt
◊snip{(provide (all-from-out "../pollen.rkt")} => re-exports everything from parent's pollen.rkt.
◊snip{(provide (all-defined-out))} => provides all definitions in the file to any files who (require) this file. racket functions are private-by-default

◊highlight['racket]{
(define (em . elements)
  (txepr 'extra-big empty elements))
  (+ 1 2 3 4 5)}
=> example of a redefining the em tag. "◊func{.} elements" == ◊func{&rest} elements ⇒ all other input pulled in as a list called elements
texpr => builds a new X-expression from a (tag, attribute-list, list-of-elements)

the (root) tag contains the entire document. Any functions attached to the root can operate on everything.

◊highlight['racket]{
(require pollen/decode txepr)
(define (root . elements)
   (txepr 'root empty (decode-elements elements
      #:txepr-elements-proc decode-paragraphs
      #:string-proc (compose1 smart-quotes smart-dashes))))}
=> applies (decode-elements) to everything in the document. decode-elements operates on special characters
=> applies functions to element types
=> decode-paragraphs converts newlines to <br> and such (applied to any text-expression, due to ◊snip{#:txexpr-elements proc})
=> ◊snip{#:string-proc} only applies to strings, which is only where smart-quotes/dashes would be relevant
=> (compose1) creates one function out of many (each function applied in order. 
=> ◊snip{decode-elements} consumes dicts, so only one function per variable. hence (compose1) for multiple functions
=> ◊extlink["http://docs.racket-lang.org/pollen/Decode.html#%28def._%28%28lib._pollen%2Fdecode..rkt%29._decode-elements%29%29"]{Decode Documentation}


◊section{Pollen multi-output targets}
===========================
special output extension ◊filen{.poly}. ie file.poly.pm
for defining output to other (non-html) programs. ie LaTeX
future investigation if necessary => ◊extlink["http://docs.racket-lang.org/pollen/fourth-tutorial.html"]{Pollen Poly Docs}

◊section{Pollen MathJax and Code-Highlighting}
====================================
Note: Both are extremely simple to add
◊extlink["http://docs.racket-lang.org/pollen/mini-tutorial.html"]{Pollen MathJax}


◊section{Pollen Programming Notes}
========================
Pollen allows any command to pass. If ◊snip{(function)} is not defined, it is assumed to be a tag, and just inserted.
  This means it would probably be good to have a validator run ala gwern.
◊snip{|doc|} contains the output of the source
◊snip{|meta|} is a dict containing metadata for your document; not included in the output post-compilation.
◊snip{(define-meta cat "chopper")}
    ◊func{here-path} is the only auto-defined metadata, which simply contains the absolute path to the file.
we can retrieve data from ◊snip{|meta|} by using ◊func{select}
    ◊snip{(select 'cat metas)} => "chopper"
The metas for each source file is sotred in cached-metas

If we wanted, say, a ToC, we can get it from the metas.
◊highlight['racket]{
#lang racket/base
; imports the whole pollen source file
(require "pollen-source.rkt")
; imports *only* the metas dict (more efficient)
(require (submod "pollen-source.rkt" metas))
}


◊section{Useful Extensions}
=================
Tag-Counter (footnotes !)
    ◊extlink["https://github.com/malcolmstill/pollen-count"]{Pollen-Count}

Tufte CSS
    ◊extlink["https://github.com/popopome/pollentufte"]{Tufte CSS}
    
Implemented in Pollen 
    ◊extlink["https://github.com/fasiha/pollen-guie"]{Pollen-Tufte}


◊section{Useful Typographic Notes}
========================
Letter Spacing
    ◊extlink["http://webtypography.net/2.1.6"]{Web Typography}

