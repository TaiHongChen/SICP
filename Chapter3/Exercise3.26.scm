
;Exercise 3.25: Generalizing one- and two-dimensional tables, show how to implement a table in which values are stored under an arbitrary number of keys and different values may be stored under different numbers of keys. The lookup and insert! procedures should take as input a list of keys used to access the table.
(define (make-table)
  (let ((local-table (list '*table*)))
    (define (make_leave key value)
      (cons key value))
    (define (make_tree leave)
      (cons leave (cons '() '())))
    (define (get_leave tree)
      (car tree))
    (define (get_key tree)
      (car (get_leave tree)))
    (define (get_value tree)
      (cdr (get_leave tree)))
    (define (get_left_branch tree)
      (cadr tree))
    (define (get_right_branch tree)
      (cddr tree))
    (define (connect_left_branch tree left_tree)
      (set-car! (cdr tree) left_tree))
    (define (connect_right_branch tree right_tree)
      (set-cdr! (cdr tree) right_tree))
    (define (lookup match_key)
      (define (iter tree)
        (if (null? tree)
            false
            (let ((key (get_key tree))
                  (value (get_value tree)))
                (if (= match_key key)
                    value
                    (if (< match_key key)
                      (iter (get_left_branch tree))
            (iter (get_right_branch tree)))))))
      (iter (cdr local-table)))
    (define (insert! match_key value)
      (let ((new_tree (make_tree (make_leave match_key value))))
        (define (iter tree)
          (if (null? tree)
              (set-cdr! local-table new_tree)
              (let ((key (get_key tree))
                    (left_tree (get_left_branch tree))
                    (right_tree (get_right_branch tree)))
                (if (= match_key key)
                    (set-cdr! (get_leave tree) value)
                    (if (< match_key key)
                        (if (null? left_tree)
                            (connect_left_branch tree new_tree)
                            (iter left_tree))
                        (if (null? right_tree)
                            (connect_right_branch tree new_tree)
                            (iter right_tree)))))))
        (iter (cdr local-table)))
      'ok local-table)

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation: 
                          TABLE" m))))
    dispatch))
(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))
(display (put 21 0))(newline )
(display (put 32 3))(newline )
(display (put 12 453))(newline )
(display (put 11 453))(newline )
(display (put 13 453))(newline )
(display (put 25 113))(newline )
(display (put 33 343))(newline )
(display (put 54 543))(newline )

(get 54)
(get 33)
(get 123)


; Welcome to DrRacket, version 6.7 [3m].
; Language: SICP (PLaneT 1.18); memory limit: 128 MB.
; (*table* (21 . 0) ())
; (*table* (21 . 0) () (32 . 3) ())
; (*table* (21 . 0) ((12 . 453) ()) (32 . 3) ())
; (*table* (21 . 0) ((12 . 453) ((11 . 453) ())) (32 . 3) ())
; (*table* (21 . 0) ((12 . 453) ((11 . 453) ()) (13 . 453) ()) (32 . 3) ())
; (*table* (21 . 0) ((12 . 453) ((11 . 453) ()) (13 . 453) ()) (32 . 3) ((25 . 113) ()))
; (*table* (21 . 0) ((12 . 453) ((11 . 453) ()) (13 . 453) ()) (32 . 3) ((25 . 113) ()) (33 . 343) ())
; (*table* (21 . 0) ((12 . 453) ((11 . 453) ()) (13 . 453) ()) (32 . 3) ((25 . 113) ()) (33 . 343) () (54 . 543) ())
; 543
; 343
; #f
; > 