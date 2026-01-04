\version "2.24.4"



#(define-public (mm-rounded-box-stencil stencil thickness padding blot)
   "Add a rounded box around @var{stencil}, producing a new stencil."

   (let* (
           (xext (interval-widen (ly:stencil-extent stencil 0) padding))
          (yext (interval-widen (ly:stencil-extent stencil 1) padding))
          (min-ext (min (-(cdr xext) (car xext)) (-(cdr yext) (car yext))))
          (ideal-blot (min blot (/ min-ext 2)))
          (ideal-thickness (min thickness (/ min-ext 2)))
          (outer (ly:round-filled-box
                  (interval-widen xext ideal-thickness)
                  (interval-widen yext ideal-thickness)
                  ideal-blot))
          
          ;(inner (ly:stencil-in-color (ly:round-filled-box xext yext (- ideal-blot ideal-thickness))     "yellow"))
          ; (inner (make-transparent-box-stencil xext yext) )         
          (inner (ly:stencil-outline empty-stencil (make-filled-box-stencil xext yext)))
          ;(inner empty-stencil)
          )
     
     (ly:stencil-add outer inner stencil)))

#(define-markup-command (mm-rounded-box layout props  arg) (string?)
   #:properties ((thickness 1)
                 (corner-radius 1)
                 (font-size 0)
                 (box-padding 0.5))
   (let ((th (* (ly:output-def-lookup layout 'line-thickness)
                thickness))
         (pad (* (magstep font-size) box-padding))
         (m (interpret-markup layout props arg)))
     (mm-rounded-box-stencil m th pad corner-radius)))





\header {
  title = ""
}

global = {
  \time 4/4
  \key c \major
  \tempo 4=100
}

chordNames = \chordmode {
  \global
  c1

}

melody = \relative c'' {
  \global
  c4^\markup { \mm-rounded-box { Overtura }}
  c,8. c16 c4 r
}


\score {
  <<
    \new ChordNames \chordNames
    \new Staff { \melody }
    %    \addlyrics { \words }
  >>
  \layout { }
  \midi { }
}
