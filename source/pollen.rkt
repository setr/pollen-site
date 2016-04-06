#lang pollen/mode racket/base
(require pollen/tag)
(require txexpr)
(require pollen/decode)
(require pollen/unstable/pygments)
(require racket/string)

(provide (all-defined-out))
(provide (all-from-out pollen/unstable/pygments))


(define headline (default-tag-function 'h2))
(define items (default-tag-function 'ul))
(define item (default-tag-function 'li 'p))
(define (link url text) `(a ((href ,url)) ,text))

(define extlink-class "extlink")
(define (extlink url . texts)
  `(a ((href ,url)(class ,extlink-class)) ,@texts)) 




;; Simple Tags
;;; highlight is imported from the pygments module. 
;;; prints code blocks. usage:
;;; highlight['python]{ ... }

;;;; POLC and META are depreciated
;;;; use  when ◊ is needed for printing
;;;; alt + shift + k =>  (on OSX)
;;; META only prints a colored ◊; just for printing ◊ alone.
(define META
         '(span ((class "pollen-meta")) "◊"))
;;; polc colors the entire pollen command. useful for one-offs.
(define (polc . content)
         `(span ((class "pollen-meta")) "◊" ,@content))
;;; func is for displaying in-line'd function names
(define (func . content)
  `(span ((class "function-name")) ,@content))

(define (section . content)
  `(@
     (hr)
     (span ((class "section")) ,@content)))

;;; def is for displaying a defined word (in left-hand margin)
;;; also prints the word in-place.
(define (def . content)
  (let ([label-val
          (symbol->string (gensym))])
    `(@
       (label ((for ,label-val) (class "margin-toggle")))
       (input ((id ,label-val) (type "checkbox") (class "margin-toggle")))
       (span ((class "defined-word")) ,@content)
       (span ((class "definition")) ,@content))))  ;;definition goes into left-margin

;;; filen is for filenames
(define (filen . content)
  `(span ((class "filename")) ,@content))


; TUFTE CSS tags
(define margin-toggle-symbol "⊕") ;; if the margin is made too small, 
;;this appears as a button to show margin-notes


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

;;; this is only left as an example. fig makes use of marginnote for cleaner code.
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

(define (fig img-path . content)
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


; Simple unicode substitutions
(define (my-smart-arrow x)
  (string-replace x "=>" "⇒"))
;; alt + shift + k => 
;; used so I can write pollen code, without misinterpretation by preprocessor
(define (my-diamond-replace x)
  (string-replace x "" "◊"))
;; === + gets erased, so we can use it as a header-seperator while writing
(define (my-seperator-erase x)
  (string-replace x #px"={3,}" ""))

(define (string-replacements)
  (compose1 my-smart-arrow 
            my-diamond-replace
            my-seperator-erase
            smart-quotes
            smart-dashes))

(define exclusion-mark-attr '(decode "exclude"))
(define (root . items)
  (decode `(decoded-root ,@items)
          #:txexpr-elements-proc detect-paragraphs
          #:string-proc (string-replacements) ;(compose1 smart-quotes smart-dashes replace-arrow)
          #:exclude-tags '(style script pre)
          #:exclude-attrs (list exclusion-mark-attr)))
