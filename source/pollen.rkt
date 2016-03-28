#lang pollen/mode racket/base
(require pollen/tag)
(require txexpr)
(require pollen/decode)

(provide (all-defined-out))


(define headline (default-tag-function 'h2))
(define items (default-tag-function 'ul))
(define item (default-tag-function 'li 'p))
(define (link url text) `(a ((href ,url)) ,text))

(define code (default-tag-function 
               'pre #:class "code"))

(define margin-toggle-symbol "⊕") ;; if the margin is made too small, 
;;this appears as a button to show margin-notes

(define (figure-in-par img-path . content)
  (let ([label-val 
          (symbol->string (gensym))])
    (txexpr 'figure empty  ;; splicing is only necessary if we lack a nesting tag for the series.
            `((label ((for ,label-val) 
                      (class "margin-toggle"))
                     ,margin-toggle-symbol) ;; symbol displayed for 'expanding' the image
              (input ((id ,label-val) 
                      (type "checkbox") 
                      (class "margin-toggle")))
              (span ((class "marginnote")) ,@content)
              (img ((src ,img-path)))))))

(define (margin-note . content)
  `(@ ,@(marginnote content)))

(define (marginnote content)
  (let ([label-val
          (symbol->string (gensym))])
    `((label ((for ,label-val)
               (class "margin-toggle"))
              ,margin-toggle-symbol)
       (input ((id ,label-val)
               (type "checkbox")
               (class "margin-toggle")))
       (span ((class "marginnote")) ,@content))))

(define (fig2 img-path . content)
  (txexpr 'figure empty 
          (append 
            (marginnote content)
            `((img ((src ,img-path)))))))


(define (sidenote . elements)
  (let ([label-val
          (symbol->string (gensym))])
    `(@ ;; '@ will flatten the list; allowing us to write series of tags in one function.
       (label ((for ,label-val) (class "margin-toggle sidenote-number")))
       (input ((id ,label-val) (type "checkbox") (class "margin-toggle")))
       (span ((class "sidenote")) ,@elements))))

(define (def . content)
  (let ([label-val
          (symbol->string (gensym))])
    `(@
       (label ((for ,label-val) (class "margin-toggle")))
       (input ((id ,label-val) (type "checkbox") (class "margin-toggle")))
       (span ((class "definition")) ,@content))))

(define exclusion-mark-attr '(decode "exclude"))
(define (root . items)
  (decode `(decoded-root ,@items)
          #:txexpr-elements-proc detect-paragraphs
          #:string-proc (compose1 smart-quotes smart-dashes)
          #:exclude-tags '(style script pre)
          #:exclude-attrs (list exclusion-mark-attr)))
