(define (partial-sums stream)
	(define (helper prev s)
		(if (null? s) nil
			(let ((new_prev (+ prev (car s))))
				(cons-stream new_prev (helper new_prev (force (cdr s)))))))
  (helper 0 stream)
)