;;;;;;;;;;;;;;;
;; Questions ;;
;;;;;;;;;;;;;;;

; Scheme

(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cddr s))
)

(define (sign x)
  (cond ((zero? x) 0) ((< x 0) (- 1)) (else 1))
)

(define (square x) (* x x))

(define (pow b n)
  ('YOUR-CODE-HERE)
)

(define (unique s)
  'YOUR-CODE-HERE
)