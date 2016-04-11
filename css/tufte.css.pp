#lang pollen
/* Import ET Book styles
   adapted from https://github.com/edwardtufte/et-book/blob/gh-pages/et-book.css */

@charset "UTF-8";

@font-face {
  font-family: "et-book";
  src: url("Fonts/et-book/et-book-roman-line-figures/et-book-roman-line-figures.eot");
  src: url("Fonts/et-book/et-book-roman-line-figures/et-book-roman-line-figures.eot?#iefix") format("embedded-opentype"), url("Fonts/et-book/et-book-roman-line-figures/et-book-roman-line-figures.woff") format("woff"), url("Fonts/et-book/et-book-roman-line-figures/et-book-roman-line-figures.ttf") format("truetype"), url("Fonts/et-book/et-book-roman-line-figures/et-book-roman-line-figures.svg#etbookromanosf") format("svg");
  font-weight: normal;
  font-style: normal
}

@font-face {
  font-family: "et-book";
  src: url("Fonts/et-book/et-book-display-italic-old-style-figures/et-book-display-italic-old-style-figures.eot");
  src: url("Fonts/et-book/et-book-display-italic-old-style-figures/et-book-display-italic-old-style-figures.eot?#iefix") format("embedded-opentype"), url("Fonts/et-book/et-book-display-italic-old-style-figures/et-book-display-italic-old-style-figures.woff") format("woff"), url("Fonts/et-book/et-book-display-italic-old-style-figures/et-book-display-italic-old-style-figures.ttf") format("truetype"), url("Fonts/et-book/et-book-display-italic-old-style-figures/et-book-display-italic-old-style-figures.svg#etbookromanosf") format("svg");
  font-weight: normal;
  font-style: italic
}

@font-face {
  font-family: "et-book";
  src: url("Fonts/et-book/et-book-bold-line-figures/et-book-bold-line-figures.eot");
  src: url("Fonts/et-book/et-book-bold-line-figures/et-book-bold-line-figures.eot?#iefix") format("embedded-opentype"), url("Fonts/et-book/et-book-bold-line-figures/et-book-bold-line-figures.woff") format("woff"), url("Fonts/et-book/et-book-bold-line-figures/et-book-bold-line-figures.ttf") format("truetype"), url("Fonts/et-book/et-book-bold-line-figures/et-book-bold-line-figures.svg#etbookromanosf") format("svg");
  font-weight: bold;
  font-style: normal
}

@font-face {
  font-family: "et-book-roman-old-style";
  src: url("Fonts/et-book/et-book-roman-old-style-figures/et-book-roman-old-style-figures.eot");
  src: url("Fonts/et-book/et-book-roman-old-style-figures/et-book-roman-old-style-figures.eot?#iefix") format("embedded-opentype"), url("Fonts/et-book/et-book-roman-old-style-figures/et-book-roman-old-style-figures.woff") format("woff"), url("Fonts/et-book/et-book-roman-old-style-figures/et-book-roman-old-style-figures.ttf") format("truetype"), url("Fonts/et-book/et-book-roman-old-style-figures/et-book-roman-old-style-figures.svg#etbookromanosf") format("svg");
  font-weight: normal;
  font-style: normal;
}

/* Tufte CSS styles */
html { font-size: .8em; }

body { width: 87.5%;
       margin-left: auto;
       margin-right: auto;
       padding-left: 20.5%;
       /*font-family: et-book, Palatino, "Palatino Linotype", "Palatino LT STD", "Book Antiqua", Georgia, serif; */
       font-family: 'Montserrat', sans-serif;
       /* background-color: #fffff8; */
       background-color: #ffffff
       color: #111;
       max-width: 1400px;
       counter-reset: sidenote-counter; }

h1 { font-weight: 400;
     margin-top: 4rem;
     margin-bottom: 1.5rem;
     font-size: 3.2rem;
     line-height: 1; }

h2 { font-weight: 400;
     margin-top: 2.1rem;
     margin-bottom: 0;
     font-size: 2.2rem;
     line-height: 1; }

h3 { font-weight: 400;
     font-size: 1.7rem;
     margin-top: 2rem;
     margin-bottom: 0;
     line-height: 1; }

p.subtitle { font-style: italic;
             margin-top: 1rem;
             margin-bottom: 1rem;
             font-size: 1.8rem;
             display: block;
             line-height: 1; }

.numeral { font-family: et-book-roman-old-style; }

.danger { color: red; }

article { position: relative;
          padding: 5rem 0rem; }

section { padding-top: 1rem;
          padding-bottom: 1rem; }

p, ol, ul { font-size: 1.3rem; }

p { line-height: 2rem;
    margin-top: 1.4rem;
    margin-bottom: 1.4rem;
    padding-right: 0;
    vertical-align: baseline; }

/* Chapter Epigraphs */
div.epigraph { margin: 5em 0; }

div.epigraph > blockquote { margin-top: 3em;
                            margin-bottom: 3em; }

div.epigraph > blockquote, div.epigraph > blockquote > p { font-style: italic; }

div.epigraph > blockquote > footer { font-style: normal; }

div.epigraph > blockquote > footer > cite { font-style: italic; }

/* end chapter epigraphs styles */

blockquote { font-size: 1.4rem; }

blockquote p { width: 50%; }

blockquote footer { width: 50%;
                    font-size: 1.1rem;
                    text-align: right; }

ol, ul { width: 45%;
         -webkit-padding-start: 5%;
         -webkit-padding-end: 5%; }

li { padding: 0.5rem 0; }

figure { padding: 0;
         border: 0;
         font-size: 100%;
         font: inherit;
         vertical-align: baseline;
         max-width: 60%;
         -webkit-margin-start: 0;
         -webkit-margin-end: 0;
         margin: 0 0 3em 0; }

figcaption { float: right;
             clear: right;
             margin-right: -48%;
             margin-top: 0;
             margin-bottom: 0;
             font-size: 1.1rem;
             line-height: 1.6;
             vertical-align: baseline;
             position: relative;
             max-width: 40%; }

figure.fullwidth figcaption { margin-right: 24%; }

/* Links: replicate underline that clears descenders */
/*
a:link, a:visited { color: inherit; }

a:link { text-decoration: none;
         background: -webkit-linear-gradient(#fffff8, #fffff8), -webkit-linear-gradient(#fffff8, #fffff8), -webkit-linear-gradient(#333, #333);
         background: linear-gradient(#fffff8, #fffff8), linear-gradient(#fffff8, #fffff8), linear-gradient(#333, #333);
         -webkit-background-size: 0.05em 1px, 0.05em 1px, 1px 1px;
         -moz-background-size: 0.05em 1px, 0.05em 1px, 1px 1px;
         background-size: 0.05em 1px, 0.05em 1px, 1px 1px;
         background-repeat: no-repeat, no-repeat, repeat-x;
         text-shadow: 0.03em 0 #fffff8, -0.03em 0 #fffff8, 0 0.03em #fffff8, 0 -0.03em #fffff8, 0.06em 0 #fffff8, -0.06em 0 #fffff8, 0.09em 0 #fffff8, -0.09em 0 #fffff8, 0.12em 0 #fffff8, -0.12em 0 #fffff8, 0.15em 0 #fffff8, -0.15em 0 #fffff8;
         background-position: 0% 93%, 100% 93%, 0% 93%; }

@media screen and (-webkit-min-device-pixel-ratio: 0) { a:link { background-position-y: 87%, 87%, 87%; } }

a:link::selection { text-shadow: 0.03em 0 #b4d5fe, -0.03em 0 #b4d5fe, 0 0.03em #b4d5fe, 0 -0.03em #b4d5fe, 0.06em 0 #b4d5fe, -0.06em 0 #b4d5fe, 0.09em 0 #b4d5fe, -0.09em 0 #b4d5fe, 0.12em 0 #b4d5fe, -0.12em 0 #b4d5fe, 0.15em 0 #b4d5fe, -0.15em 0 #b4d5fe;
                    background: #b4d5fe; }

a:link::-moz-selection { text-shadow: 0.03em 0 #b4d5fe, -0.03em 0 #b4d5fe, 0 0.03em #b4d5fe, 0 -0.03em #b4d5fe, 0.06em 0 #b4d5fe, -0.06em 0 #b4d5fe, 0.09em 0 #b4d5fe, -0.09em 0 #b4d5fe, 0.12em 0 #b4d5fe, -0.12em 0 #b4d5fe, 0.15em 0 #b4d5fe, -0.15em 0 #b4d5fe;
                         background: #b4d5fe; }

*/

/* Sidenotes, margin notes, figures, captions */
img { max-width: 100%; }

.sidenote, .marginnote { /*font-family: Montserrat;*/
                         float: right;
                         clear: right;
                         margin-right: -52%;
                         width: 40%;
                         margin-top: 0;
                         margin-bottom: 0;
                         font-size: 1rem;
                         line-height: 1.3;
                         vertical-align: baseline;
                         position: relative; }

.table-caption { float:right;
                 clear:right;
                 margin-right: -60%;
                 width: 50%;
                 margin-top: 0;
                 margin-bottom: 0;
                 font-size: 1.0rem;
                 line-height: 1.6; }

.sidenote-number { counter-increment: sidenote-counter; }

.sidenote-number:after, .sidenote:before { content: counter(sidenote-counter) " ";
                                           color: darkred;
                                            
                                           /*font-family: et-book-roman-old-style;*/
                                           position: relative;
                                           vertical-align: baseline; }

.sidenote-number:after { content: counter(sidenote-counter);
                         font-size: .8rem;
                         top: -0.5rem;
                         left: 0.1rem; }

.sidenote:before { content: counter(sidenote-counter) " ";
                   top: -0.5rem; }

p, hr, footer, table, div.table-wrapper-small, div.supertable-wrapper > p, div.booktabs-wrapper { width: 60%; }
hr {margin-left: 0;}

div.fullwidth, table.fullwidth { width: 100%; }

div.table-wrapper { overflow-x: auto;
                    font-family: "Trebuchet MS", "Gill Sans", "Gill Sans MT", sans-serif; }

@media screen and (max-width: 760px) { p, hr, footer { width: 90%; }
                                       pre.code { width: 87.5%; }
                                       ul { width: 85%; }
                                       figure { max-width: 90%; }
                                       figcaption, figure.fullwidth figcaption { margin-right: 0%;
                                                                                 max-width: none; }
                                       blockquote p, blockquote footer { width: 90%; }}

.sans { font-family: "Gill Sans", "Gill Sans MT", Calibri, sans-serif;
        letter-spacing: .03em; }

/* .code { font-family: Consolas, "Liberation Mono", Menlo, Courier, monospace;
/*         font-size: 1.125rem;
/*         line-height: 1.6; } */

h1 .code, h2 .code, h3 .code { font-size: 0.80em;}

.marginnote .code, .sidenote .code { font-size: 1rem; }

pre.code { width: 52.5%;
           padding-left: 2.5%;
           overflow-x: auto; }

.fullwidth { max-width: 90%;
             clear:both; }

span.newthought { font-variant: small-caps;
                  font-size: 1.2em; }

input.margin-toggle { display: none; }

label.sidenote-number { display: inline; }

label.margin-toggle:not(.sidenote-number) { display: none; }

@media (max-width: 760px) { label.margin-toggle:not(.sidenote-number) { display: inline; }
                            .sidenote, .marginnote { display: none; }
                            .margin-toggle:checked + .sidenote,
                            .margin-toggle:checked + .marginnote { display: block;
                                                                   float: left;
                                                                   left: 1rem;
                                                                   clear: both;
                                                                   width: 95%;
                                                                   margin: 1rem 2.5%;
                                                                   vertical-align: baseline;
                                                                   position: relative; }
                            label { cursor: pointer; }
                            pre.code { width: 90%;
                                       padding: 0; }
                            .table-caption { display: block;
                                             float: right;
                                             clear: both;
                                             width: 98%;
                                             margin-top: 1rem;
                                             margin-bottom: 0.5rem;
                                             margin-left: 1%;
                                             margin-right: 1%;
                                             vertical-align: baseline;
                                             position: relative; }
                            div.table-wrapper, table, table.booktabs { width: 85%; }
                            div.table-wrapper { border-right: 1px solid #efefef; }
                            img { width: 100%; } }
