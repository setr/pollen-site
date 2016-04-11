#lang pollen
/* Coloring for pygments
 * Acts on <pre> blocks
 * Pollen-Called with ◊highlight{ ... code ... } 
*/
pre{
    font-size: .89em;
    line-height: 1.5;
    font-family: 'Source Code Pro', monospace;}

.linenodiv {
    line-height: 1.9;}

.c,   /* comment               */  
.cm, /* comment.multiline     */ 
.cp, /* comment.preproccessor */ 
.c1, /* comment.single        */ 
.cs /* comment.special       */ 
{ color:grey; } 

.k,    /* Keyword              */
.kc,  /* Keyword.Constant */
.kn,  /* Keyword.Namespace */
.kp,  /* Keyword.Pseudo */
.kr,  /* Keyword.Reserved */
.kt   /* Keyword.Type */
{ font-weight: bold; } 

.kd  /* Keyword.Declaration */
{ color: midnightblue;
  font-weight: bold;}
/* .nd { color: #5c35cc; font-weight: bold }  Name.Decorator */
/* .ni { color: #ce5c00 }  Name.Entity */
/* .ne { color: #cc0000; font-weight: bold }  Name.Exception */
/* .nl { color: #f57900 }  Name.Label */
/* .nn { color: #000000 }  Name.Namespace */
/* .nx { color: #000000 }  Name.Other */
/* .py { color: #000000 }  Name.Property */

.nt, /* Name.tag      */
.nf, /* Name.Function */
.nb, /* Name.Builtin */
.nc, /* Name.Class */
.no  /* Name.Constant */
{ font-weight:bold; }
 
.nv,  /* Name.Variable */
{}

.na /* Name.Attribute */
{color: midnightblue}

.ss  /* Literal.String.Symbol */
{ color: #4e9a06 }

.s,  /* Literal.String */
.s2  /* Literal.String.Double */
{ color: darkcyan }

.mf,  /* Literal.Number.Float */
.mh,  /* Literal.Number.Hex */
.mi,  /* Literal.Number.Integer */
.mo   /* Literal.Number.Oct */
{ color: crimson}
