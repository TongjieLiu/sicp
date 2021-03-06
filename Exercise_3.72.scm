; An exercise solution for the SICP, 2nd edition
;
; Copyright (C) 2021 Tongjie Liu <tongjieandliu@gmail.com>.
;
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>.

(define (sum-of-two-squares pair)
    (let ((i (car pair))
          (j (cadr pair)))
        (+ (square i)
           (square j))))


(define s (weighted-pairs integers
                          integers
                          sum-of-two-squares))


(define (ramanujan-number index) ; index starts from 1
    (define (skip stream value)
        (if (= (sum-of-two-squares (stream-car stream))
               value)
            (skip (stream-cdr stream) value)
            stream))

    (define (iter stream index value)
        (if (and (= (sum-of-two-squares (stream-car stream))
                    value)
                 (= (sum-of-two-squares (stream-car (stream-cdr stream)))
                    value))
            (if (= index 1)
                value
                (iter (skip (stream-cdr (stream-cdr stream))
                            value)
                      (- index 1)
                      value))
            (iter (stream-cdr stream)
                  index
                  (sum-of-two-squares (stream-car stream)))))

    (iter (stream-cdr s)
          index
          (sum-of-two-squares (stream-car s))))
