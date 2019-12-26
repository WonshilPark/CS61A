
; Tail recursion

(define (replicate x n)
  (define (helper x n lst)
    (if (= n 0) lst 
      (helper  x (- n 1) (append lst `(,x))))) (helper x n nil)
  )

(define (accumulate combiner start n term)
  (if (= n 0) start
    (combiner (term n) (accumulate combiner start (- n 1 ) term)))
)

(define (accumulate-tail combiner start n term)
  (define (helper lst n)
    (if (= n 0) lst
      (helper (combiner lst (term n)) (- n 1)))) (helper start n)
)

; Streams

(define (map-stream f s)
    (if (null? s)
    	nil
    	(cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define multiples-of-three
  (cons-stream 3 (map-stream (lambda (x) (+ x 3)) multiples-of-three))
)

(define (cadr-stream lst) 
  (car (cdr-stream lst)))

(define (nondecreastream s)
  (if (null? s) nil
    (begin 
      (define (sort_s s x)
        (if (null? x) s (sort_s (cdr-stream s) (cdr x))))

      (define (lst s) 
        (cond
          ((null? s) nil)
          ((null? (cdr-stream s)) (cons (car s) nil))
          ((not (< (cadr-stream s) (car s))) (cons (car s) (lst (cdr-stream s))))
          (else (cons (car s) nil))))

      (define n (lst s))
      (define s (sort_s s n))
      (cons-stream n (nondecreastream s)))))


(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))