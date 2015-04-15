(define-module (phone-number)
  #:export (numbers area-code pprint))

(use-modules (ice-9 format))


(define (strip-non-digits str)
  (string-filter char-numeric? str))

(define (trim-leading-one str)
  (if (and (= 11 (string-length str))
           (char=? #\1 (car (string->list str))))
      (substring str 1)
      str))

(define (ensure-valid str)
  (if (= 10 (string-length str))
      str
      "0000000000"))

(define (numbers number-string)
  (ensure-valid
   (trim-leading-one
    (strip-non-digits number-string))))

(define (area-code number-string)
  (substring (numbers number-string) 0 3))

(define (exchange number-string)
  (substring (numbers number-string) 3 6))

(define (subscriber number-string)
  (substring (numbers number-string) 6 10))

;; TODO - guile `format' is bananas:
;; https://www.gnu.org/software/guile/manual/html_node/Formatted-Output.html
(define (pprint number-string)
  (format #f "(~D) ~D-~D"
          (area-code number-string)
          (exchange number-string)
          (subscriber number-string)))
