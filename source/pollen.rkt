#lang pollen/mode racket/base
(require racket/list)
(require pollen/tag)
(require txexpr)
(require pollen/decode)
(require pollen/unstable/pygments)
(require racket/string)

(provide (all-defined-out))
(provide (all-from-out pollen/unstable/pygments))
(provide add-between)


(define headline (default-tag-function 'h2))
(define items (default-tag-function 'ul))
(define item (default-tag-function 'li 'p))
(define (link url text) `(a ((href ,url)) ,text))

(define extlink-class "extlink")
(define (extlink url . text)
  `(a ((href ,url)(class ,extlink-class)) ,@text)) 

(define (inlink url . text) ;; tag is handled properly by python
  `(a ((href ,url) (class "inlink")) ,@text))




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

(define (blockquote author . elements)
  (txexpr 'blockquote empty
          `((p ,@elements)
            (footer ,author))))


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
  ;; compose will apply functions in backwards order
  (compose1 
            ;; this is just for simple in-text math unicode
            ;; proper math would utilize mathjax.
            (λ (x) (string-replace x "+" "＋"))
            ;; replace / with ÷ if it's preceded/followed with numbers or parenthesis
            ;; otherwise its probably part of a normal string like/or http://
            (λ (x) (string-replace x #px"(?<=[\\d()] ?)/(?= ?[\\d()])" "÷"))
            (λ (x) (string-replace x "<" "＜"))
            (λ (x) (string-replace x ">" "＞"))
            (λ (x) (string-replace x "=" "＝"))
            (λ (x) (string-replace x "~" "～"))
            (λ (x) (string-replace x "+-" "±"))
            (λ (x) (string-replace x "==" "≡"))
            (λ (x) (string-replace x "/=" "≠"))
            (λ (x) (string-replace x "<=" "≤"))
            (λ (x) (string-replace x ">=" "≥"))
            ;; these are applied first
            my-smart-arrow 
            my-diamond-replace
            my-seperator-erase
            smart-quotes
            smart-dashes))

(define exclusion-mark-attr '(decode "exclude"))

(define (root . items)
  (decode 
    (decode `(decoded-root ,@items)  ;; this decode skips code blocks
            #:txexpr-elements-proc detect-paragraphs
            #:string-proc (string-replacements) 
            #:exclude-tags '(style script pre)
            #:exclude-attrs (list exclusion-mark-attr))
    ;; If we start writing haskell, arrow-replacement will be a problem.
    #:string-proc (compose1 my-smart-arrow my-diamond-replace))) ;;this one excludes nothing


; CODE STOLEN FROM MSTILL.IO
(define (category->link category)
  `(a [[href ,(string-append "tags/" category ".html")]]
      ,category))

(define (cat-string->list string)
  (map (λ (tag)
          (apply string-append tag))
       (map (λ (tag)
               (add-between tag " "))
            (map string-split (map string-trim (string-split string ","))))))

(define (format-cats cats)
  (add-between (map category->link (cat-string->list cats)) ", "))
