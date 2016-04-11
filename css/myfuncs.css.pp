#lang pollen
◊(require racket/format)
◊(define (css-transition background time)
   (format "
        -moz-transition-property: ~a;
        -webkit-transition-property: ~a;
        transition-property: ~a;
        -moz-transition-duration: ~a;
        -webkit-transition-duration: ~a;
        transition-duration: ~a;"  background background background time time time))

.section,
.definition { /*font-family: et-book-roman-old-style; */
              color: rgb(0,0,100);
              font-variant: small-caps;
              text-transform: lowercase;
              text-align: right;
              float: left;
              clear: left;
              margin-left: -24%;
              width: 20%;
              margin-top:0;
              margin-bottom: 0;
              font-size: 1.3rem;
              line-height 1.3;
              vertical-align: baseline;
              position: relative; }

.function-name { color: darkcyan;}
             
.filename { color: darkolivegreen; }

snip,
.pollen-meta { 
    font-weight: bold;
    font-family: 'Source Code Pro', monospace;}

      
a:hover {
    background: #fbf3f3;
    border-radius: 8px;
    ◊(css-transition "background" "0.2s")
}

/* all of this is to just tell links to stop being special little shits */
/* butterick applies the same, but globally (applied to *)
/* i'm not _that_ interested in styling this shit
*/
a {
    ◊(css-transition "background" "0.2s")
    text-decoration:inherit;
    font-weight: inherit;
    font-style: inherit;
    font-size: inherit;
    text-decoration: inherit;
    color: #933;
}

a.extlink:after {
    /* no space, then degree-symbol */
    content: "\FEFF \00B0";
    margin-left: 0.10em;
    font-size: 90%;
    top: -0.10em;
    color: #933;
}
