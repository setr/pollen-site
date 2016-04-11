#lang pollen
◊define-meta[tags]{notes, sebastian, nig}
◊define-meta[title]{Tufte CSS Notes}

◊section{Sectioning}
==========
html
body
h1
h2
h3

p class="subtitle"
class="numeral"
class="danger"

article
section


◊section{Paragraphs}
==========
p, ol, ul
p
div class="epigraph" 
    ◊ul{blockquote
        ◊ul{p
            footer
            cite
        }}

blockquote p
blockquote footer

◊section{Images}
======
figure
figcaption
figure class="fullwidth"


◊section{Notes}
=====
class="sidenote"
class="marginnote"

class="table-caption"
class="sidenote-number"





◊section{Usage}
=========

Code
◊highlight['html]{
<pre class="code"> content </pre>
}

Sidenote
◊highlight['html]{
<!-- for-value needs to match input's id value -->
<label for="sn-demo" class="margin-toggle sidenote-number"></label>     
<input type="checkbox" id="sn-demo" class="margin-toggle" />
<span class="sidenote">
 content
</span>
}

Margin-note (no numbering)
◊highlight['html]{
<!-- &#8853; => ⊕, this becomes the toggle symbol for small screens -->
<label for="mn-demo" class="margin-toggle">&#8853;</label>              
<input type="checkbox" id="mn-demo" class="margin-toggle" />
<span class="marginnote">
  stuff
</span>
}

Figure
◊highlight['html]{
<figure>
 <label for="mn-exports-imports" class="margin-toggle">&#8853;</label> 
 <!--  margin'd subtitle for the image -->
 <input type="checkbox" id="mn-exports-imports" class="margin-toggle"/>  
 <span class="marginnote"> content </span>
 <!--  pulls in the actual image -->
 <img src="img/napoleans-march.jpg" />                                   
</figure>
}

Full-width Figure
◊highlight['html]{
<figure class="fullwidth">
 <img src="img" />
</figure>
}

Blockquote
◊highlight['html]{
<blockquote cite="url">
  <p> quote </p>
  <footer>
   <a href="url">
    source
   </a>
  </footer>
</blockquote>
}

Epigraph (quote at start of section)
◊highlight['html]{
<div class="epigraph">
 <blockquote>
  <!--  the quote -->
  <p>For a successful technology, reality must take precedence 
  over public relations, for Nature cannot be fooled.</p> 
  <footer>
  <!--  author  -->
   Richard P. Feynman,                                           
  <!--  source -->
   <cite>“What Do You Care What Other People Think?”</cite>      
  </footer>                       
 </blockquote>
</div>
}


◊section{GLOBAL Structure}
============
document should be structured like this

◊highlight['html]{
<body>
 <article>
  <h1> TITLE </h1>
  <p class="subtitle"> subtitle </p>
  <section>
   <p> content </p>
   <p> content </p>
   <p> content </p>
  </section>

  <section>
   <h2> L2 TITLE </h2>
   <p> content </p>
   <p> content </p>
   <p> content </p>
  </section>
   
  <section>
   <h2> L2 TITLE </h2>
   <h3> L3 TITLE </h3>
   <p> content </p>
   <p> content </p>
   <blockquote><p> quote </p><footer> Author <cite> source </cite></footer></blockquote>
  </section>
 </article>
</body>
}



