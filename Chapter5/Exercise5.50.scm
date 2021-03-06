(load "/Users/soulomoon/git/SICP/Chapter4/Exercise4.16.scm")
;(load "/Users/soulomoon/git/SICP/Chapter5/Exercise5.49.scm")
(load "/Users/soulomoon/git/SICP/Chapter5/Exercise5.49.scm")

; fisrst I have to expand the syntax of compile to enable tranformation of let
; here I load on 4.16

; then we have to use the define map inside the interpreter about to be compile

;then I have to recursively unwrap primitives procedure
(define (let? exp)
  (tagged-list? exp 'let))

(define (compile exp target linkage)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp) (compile-quoted exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage))
        ;adding syntax supports
        ((let? exp)
         (compile (let->combination exp) target linkage))

        ((assignment? exp)
         (compile-assignment exp target linkage))
        ((definition? exp)
         (compile-definition exp target linkage))
        ((if? exp) (compile-if exp target linkage))
        ((lambda? exp) (compile-lambda exp target linkage))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage))
        ((cond? exp) (compile (cond->if exp) target linkage))
        ((application? exp)
         (compile-application exp target linkage))
        (else
         (error "Unknown expression type -- COMPILE" exp))))


;(set! eceval-operations
;(append
;eceval-operations
;(list
;  (list 'compiled-procedure? compiled-procedure?)
;  (list 'ev-print ev-print)
;  (list 'eq? eq?)
;  (list 'null? null?)
;  (list 'car car)
;  (list 'cdr cdr))))

(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
	;;above from book -- here are some more
  (list 'display display)
	(list '+ +)
  (list 'apply apply)
  (list 'list list)
  (list 'list list)
	(list '- -)
	(list '* *)
	(list '= =)
	(list '/ /)
	(list '> >)
	(list '< <)
        (list 'read read)
        (list 'set-car! set-car!)
        (list 'set-cdr! set-cdr!)
        (list 'symbol? symbol?)
        (list '<= <=)
        (list '= =)
        (list '> >)
        (list '>= >=)
        (list 'abs abs)
        (list 'acos acos)
        (list 'append append)
        (list 'asin asin)
        (list 'assoc assoc)
        (list 'assq assq)
        (list 'assv assv)
        (list 'atan atan)
        (list 'boolean? boolean?)
        (list 'caaaar caaaar)
        (list 'caaadr caaadr)
        (list 'caaar caaar)
        (list 'caadar caadar)
        (list 'caaddr caaddr)
        (list 'caadr caadr)
        (list 'caar caar)
        (list 'cadaar cadaar)
        (list 'cadadr cadadr)
        (list 'cadar cadar)
        (list 'caddar caddar)
        (list 'cadddr cadddr)
        (list 'caddr caddr)
        (list 'cadr cadr)
        (list 'car car)
        (list 'cdaaar cdaaar)
        (list 'cdaadr cdaadr)
        (list 'cdaar cdaar)
        (list 'cdadar cdadar)
        (list 'cdaddr cdaddr)
        (list 'cdadr cdadr)
        (list 'cdar cdar)
        (list 'cddaar cddaar)
        (list 'cddadr cddadr)
        (list 'cddar cddar)
        (list 'cdddar cdddar)
        (list 'cddddr cddddr)
        (list 'cdddr cdddr)
        (list 'cddr cddr)
        (list 'cdr cdr)
        (list 'ceiling ceiling)
        (list 'char->integer char->integer)
        (list 'char-alphabetic? char-alphabetic?)
        (list 'char-ci<=? char-ci<=?)
        (list 'char-ci=? char-ci=?)
        (list 'char-ci>=? char-ci>=?)
        (list 'char-ci>? char-ci>?)
        (list 'char-downcase char-downcase)
        (list 'char-lower-case? char-lower-case?)
        (list 'char-numeric? char-numeric?)
        (list 'char-upcase char-upcase)
        (list 'char-upper-case? char-upper-case?)
        (list 'char-whitespace? char-whitespace?)
        (list 'char<=? char<=?)
        (list 'char=? char=?)
        (list 'char>=? char>=?)
        (list 'char>? char>?)
        (list 'char? char?)
        (list 'complex? complex?)
        (list 'cons cons)
        (list 'cos cos)
        (list 'display display)
        (list 'eq? eq?)
        (list 'equal? equal?)
        (list 'eqv? eqv?)
        (list 'eval eval)
        (list 'even? even?)
        (list 'exact? exact?)
        (list 'exp exp)
        (list 'expt expt)
        (list 'floor floor)
        (list 'for-each for-each)
        (list 'force force)
        (list 'gcd gcd)
        (list 'inexact? inexact?)
        (list 'integer->char integer->char)
        (list 'integer? integer?)
        (list 'lcm lcm)
        (list 'length length)
        (list 'list list)
        (list 'list->string list->string)
        (list 'list->vector list->vector)
        (list 'list-ref list-ref)
        (list 'list-tail list-tail)
        (list 'list? list?)
        (list 'log log)
        (list 'make-string make-string)
        (list 'make-vector make-vector)
        ;(list 'map map)
        (list 'max max)
        (list 'member member)
        (list 'memq memq)
        (list 'memv memv)
        (list 'min min)
        (list 'modulo modulo)
        (list 'negative? negative?)
        (list 'newline newline)
        (list 'not not)
        (list 'null? null?)
        (list 'number->string number->string)
        (list 'number? number?)
        (list 'odd? odd?)
        (list 'pair? pair?)
        (list 'positive? positive?)
        (list 'quotient quotient)
        (list 'rational? rational?)
        (list 'real? real?)
        (list 'remainder remainder)
        (list 'reverse reverse)
        (list 'round round)
        (list 'sin sin)
        (list 'sqrt sqrt)
        (list 'string string)
        (list 'string->list string->list)
        (list 'string->number string->number)
        (list 'string->symbol string->symbol)
        (list 'string-append string-append)
        (list 'string-ci<=? string-ci<=?)
        (list 'string-ci=? string-ci=?)
        (list 'string-ci>=? string-ci>=?)
        (list 'string-ci>? string-ci>?)
        (list 'string-copy string-copy)
        (list 'string-fill! string-fill!)
        (list 'string-length string-length)
        (list 'string-ref string-ref)
        (list 'string-set! string-set!)
        (list 'string<=? string<=?)
        (list 'string string)
        (list 'string=? string=?)
        (list 'string>=? string>=?)
        (list 'string>? string>?)
        (list 'string? string?)
        (list 'substring substring)
        (list 'symbol->string symbol->string)
        (list 'tan tan)
        (list 'truncate truncate)
        (list 'vector vector)
        (list 'vector->list vector->list)
        (list 'vector-fill! vector-fill!)
        (list 'vector-length vector-length)
        (list 'vector-ref vector-ref)
        (list 'vector-set! vector-set!)
        (list 'vector? vector?)
        (list 'write write)
        (list 'write-char write-char)
        (list 'zero? zero?)

  (list 'compile-and-run compile-and-run)
        ))
(read-compile-execute-print
'(
(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (a)
(map (lambda (x) (car x))
     '((1 2) (1 2))))
(a)
))


;(error "stop")
(read-compile-execute-print
'(

(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))
;;;;METACIRCULAR EVALUATOR FROM CHAPTER 4 (SECTIONS 4.1.1-4.1.4) of
;;;; STRUCTURE AND INTERPRETATION OF COMPUTER PROGRAMS

;;;;Matches code in ch4.scm

;;;;This file can be loaded into Scheme as a whole.
;;;;Then you can initialize and start the evaluator by evaluating
;;;; the two commented-out lines at the end of the file (setting up the
;;;; global environment and starting the driver loop).

;;;;**WARNING: Don't load this file twice (or you'll lose the primitives
;;;;  interface, due to renamings of apply).

;;;from section 4.1.4 -- must precede def of metacircular apply
(define apply-in-underlying-scheme apply)

;;;SECTION 4.1.1

(define (eval exp env)
  (display "eval goin: ")(display exp) (newline )
  (cond ((self-evaluating? exp) exp)
        ((variable? exp)
          (display "lookup-variable-value: ")
          (display exp)
          (newline )
          (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (display "apply problem")(newline )
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))

(define (apply procedure arguments)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure)
         (eval-sequence
           (procedure-body procedure)
           (extend-environment
             (procedure-parameters procedure)
             arguments
             (procedure-environment procedure))))
        (else
         (error
          "Unknown procedure type -- APPLY" procedure))))


(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))

(define (eval-if exp env)
  (if (true? (eval (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))

(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        (else (eval (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))

(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
                       (eval (assignment-value exp) env)
                       env)
  'ok)

(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
                    (eval (definition-value exp) env)
                    env)
  'ok)

;;;SECTION 4.1.2

(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))

(define (quoted? exp)
  (tagged-list? exp 'quote))

(define (text-of-quotation exp) (cadr exp))

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

(define (variable? exp) (display "symbol?: ")(display exp)(newline ) (symbol? exp))

(define (assignment? exp)
  (tagged-list? exp 'set!))

(define (assignment-variable exp) (cadr exp))

(define (assignment-value exp) (caddr exp))


(define (definition? exp)
  (tagged-list? exp 'define))

(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))

(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)
                   (cddr exp))))

(define (lambda? exp) (tagged-list? exp 'lambda))

(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))


(define (if? exp) (tagged-list? exp 'if))

(define (if-predicate exp) (cadr exp))

(define (if-consequent exp) (caddr exp))

(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))


(define (begin? exp) (tagged-list? exp 'begin))

(define (begin-actions exp) (cdr exp))

(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))

(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))

(define (make-begin seq) (cons 'begin seq))


(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))


(define (cond? exp) (tagged-list? exp 'cond))

(define (cond-clauses exp) (cdr exp))

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause) (car clause))

(define (cond-actions clause) (cdr clause))

(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false                          ; no else clause
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF"
                       clauses))
            (make-if (cond-predicate first)
                     (sequence->exp (cond-actions first))
                     (expand-clauses rest))))))

;;;SECTION 4.1.3

(define (true? x)
  (not (eq? x false)))

(define (false? x)
  (eq? x false))


(define (make-procedure parameters body env)
  (list 'procedure parameters body env))

(define (compound-procedure? p)
  (tagged-list? p 'procedure))


(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))


(define (enclosing-environment env) (cdr env))

(define (first-frame env) (car env))

(define the-empty-environment '())

(define (make-frame variables values)
  (cons variables values))

(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))

(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))

;;;SECTION 4.1.4

(define (setup-environment)
  (let ((initial-env
         (extend-environment (primitive-procedure-names)
                             (primitive-procedure-objects)
                             the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

;[do later] (define the-global-environment (setup-environment))

(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))

(define (primitive-implementation proc) (cadr proc))

(define primitive-procedures
  (list (list '* *)
        (list '+ +)
        (list '- -)
        (list '/ /)
        (list '< <)
        (list '<= <=)
        (list '= =)
        (list '> >)
        (list '>= >=)
        (list 'abs abs)
        (list 'acos acos)
        (list 'append append)
        (list 'asin asin)
        (list 'assoc assoc)
        (list 'assq assq)
        (list 'assv assv)
        (list 'atan atan)
        (list 'boolean? boolean?)
        (list 'caaaar caaaar)
        (list 'caaadr caaadr)
        (list 'caaar caaar)
        (list 'caadar caadar)
        (list 'caaddr caaddr)
        (list 'caadr caadr)
        (list 'caar caar)
        (list 'cadaar cadaar)
        (list 'cadadr cadadr)
        (list 'cadar cadar)
        (list 'caddar caddar)
        (list 'cadddr cadddr)
        (list 'caddr caddr)
        (list 'cadr cadr)
        (list 'car car)
        (list 'cdaaar cdaaar)
        (list 'cdaadr cdaadr)
        (list 'cdaar cdaar)
        (list 'cdadar cdadar)
        (list 'cdaddr cdaddr)
        (list 'cdadr cdadr)
        (list 'cdar cdar)
        (list 'cddaar cddaar)
        (list 'cddadr cddadr)
        (list 'cddar cddar)
        (list 'cdddar cdddar)
        (list 'cddddr cddddr)
        (list 'cdddr cdddr)
        (list 'cddr cddr)
        (list 'cdr cdr)
        (list 'ceiling ceiling)
        (list 'char->integer char->integer)
        (list 'char-alphabetic? char-alphabetic?)
        (list 'char-ci<=? char-ci<=?)
        (list 'char-ci=? char-ci=?)
        (list 'char-ci>=? char-ci>=?)
        (list 'char-ci>? char-ci>?)
        (list 'char-downcase char-downcase)
        (list 'char-lower-case? char-lower-case?)
        (list 'char-numeric? char-numeric?)
        (list 'char-upcase char-upcase)
        (list 'char-upper-case? char-upper-case?)
        (list 'char-whitespace? char-whitespace?)
        (list 'char<=? char<=?)
        (list 'char=? char=?)
        (list 'char>=? char>=?)
        (list 'char>? char>?)
        (list 'char? char?)
        (list 'complex? complex?)
        (list 'cons cons)
        (list 'cos cos)
        (list 'display display)
        (list 'eq? eq?)
        (list 'equal? equal?)
        (list 'eqv? eqv?)
        (list 'eval eval)
        (list 'even? even?)
        (list 'exact? exact?)
        (list 'exp exp)
        (list 'expt expt)
        (list 'floor floor)
        (list 'for-each for-each)
        (list 'force force)
        (list 'gcd gcd)
        (list 'inexact? inexact?)
        (list 'integer->char integer->char)
        (list 'integer? integer?)
        (list 'lcm lcm)
        (list 'length length)
        (list 'list list)
        (list 'list->string list->string)
        (list 'list->vector list->vector)
        (list 'list-ref list-ref)
        (list 'list-tail list-tail)
        (list 'list? list?)
        (list 'log log)
        (list 'make-string make-string)
        (list 'make-vector make-vector)
        (list 'map map)
        (list 'max max)
        (list 'member member)
        (list 'memq memq)
        (list 'memv memv)
        (list 'min min)
        (list 'modulo modulo)
        (list 'negative? negative?)
        (list 'newline newline)
        (list 'not not)
        (list 'null? null?)
        (list 'number->string number->string)
        (list 'number? number?)
        (list 'odd? odd?)
        (list 'pair? pair?)
        (list 'positive? positive?)
        (list 'quotient quotient)
        (list 'rational? rational?)
        (list 'real? real?)
        (list 'remainder remainder)
        (list 'reverse reverse)
        (list 'round round)
        (list 'sin sin)
        (list 'sqrt sqrt)
        (list 'string string)
        (list 'string->list string->list)
        (list 'string->number string->number)
        (list 'string->symbol string->symbol)
        (list 'string-append string-append)
        (list 'string-ci<=? string-ci<=?)
        (list 'string-ci=? string-ci=?)
        (list 'string-ci>=? string-ci>=?)
        (list 'string-ci>? string-ci>?)
        (list 'string-copy string-copy)
        (list 'string-fill! string-fill!)
        (list 'string-length string-length)
        (list 'string-ref string-ref)
        (list 'string-set! string-set!)
        (list 'string<=? string<=?)
        (list 'string string)
        (list 'string=? string=?)
        (list 'string>=? string>=?)
        (list 'string>? string>?)
        (list 'string? string?)
        (list 'substring substring)
        (list 'symbol->string symbol->string)
        (list 'tan tan)
        (list 'truncate truncate)
        (list 'vector vector)
        (list 'vector->list vector->list)
        (list 'vector-fill! vector-fill!)
        (list 'vector-length vector-length)
        (list 'vector-ref vector-ref)
        (list 'vector-set! vector-set!)
        (list 'vector? vector?)
        (list 'write write)
        (list 'write-char write-char)
        (list 'zero? zero?)
        ))
(define (primitive-procedure-names)
  (map car
       primitive-procedures))

(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc)))
       primitive-procedures))

;[moved to start of file] (define apply-in-underlying-scheme apply)
;recursive find the primitive-implementation
(define (apply-primitive-procedure proc args)
  (if (primitive-procedure? (primitive-implementation proc))
      (apply-primitive-procedure (primitive-implementation proc) args)
      (apply-in-underlying-scheme
        (primitive-implementation proc) args)))



(define input-prompt ";;; M-Eval input:")
(define output-prompt ";;; M-Eval value:")

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (eval input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))

(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))

(define (announce-output string)
  (newline) (display string) (newline))

(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>))
      (display object)))

;;;Following are commented out so as not to be evaluated when
;;; the file is loaded.
(define the-global-environment (setup-environment))
;(primitive-procedure-names)
;(define initial-env
;       (extend-environment (primitive-procedure-names)
;                           (primitive-procedure-objects)
;                           the-empty-environment))
;
;  (define-variable! 'true true initial-env)
;  (define-variable! 'false false initial-env)
;
;(define the-global-environment initial-env)
;(display setup-environment)
(driver-loop)
))
'METACIRCULAR-EVALUATOR-LOADED
