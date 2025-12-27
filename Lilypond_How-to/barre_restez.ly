\version "2.19.15"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Syntax: \restez #"text" { notes } - text = any number of box
restezA =
#(define-music-function (barre location str music) (string? ly:music?)
   (let ((elts (extract-named-music music '(NoteEvent EventChord))))
     (if (pair? elts)
         (let ((first-element (first elts))
               (last-element (last elts)))
           (set! (ly:music-property first-element 'articulations)
                 (cons (make-music 'TextSpanEvent 'span-direction -1)
                       (ly:music-property first-element 'articulations)))
           (set! (ly:music-property last-element 'articulations)
                 (cons (make-music 'TextSpanEvent 'span-direction 1)
                       (ly:music-property last-element 'articulations))))))
   #{
       \once \override TextSpanner.font-size = #-2
       \once \override TextSpanner.font-shape = #'upright
       \once \override TextSpanner.staff-padding = #3
       \once \override TextSpanner.style = #'line
       \once \override TextSpanner.to-barline = ##f
       \once \override TextSpanner.bound-details =
            #`((left
                (text . ,#{ \markup { "Restez" } #})
                (Y . 0)
                (padding . 0.25)
                (attach-dir . -2))
               (right
                (text . ,#{ \markup { \draw-line #'( 0 . -.5) } #})
                (Y . 0)
                (padding . 0.25)
                (attach-dir . 2)))
       $music
   #})

#(define (text-spanner-start-stop mus)
    (let ((elts (ly:music-property mus 'elements)))
    (make-music 'SequentialMusic 'elements
       (append
          (list (make-music 'TextSpanEvent 'span-direction -1))
          (reverse (cdr (reverse elts)))
          (list (make-music 'TextSpanEvent 'span-direction 1))
          (list (last elts))))))

restezB =
#(define-music-function (parser location music)( ly:music?)
   (let ((arg (string-append "" "")))
      #{
         \override TextSpanner.bound-details.left.text = "Restez"
         \override TextSpanner.style = #'solid
         \override TextSpanner.font-size = #-3
         \override TextSpanner.bound-details =
            #`((left
                (text . ,#{ \markup { "Restez" } #})
                (Y . 0)
                (padding . 0.25)
                (attach-dir . -2))
               (right
                (text . ,#{ \markup { \draw-line #'( 0 . -.5) } #})
                (Y . 0)
                (padding . 0.25)
                (attach-dir . 2)))

         $(text-spanner-start-stop  music)
      #}
      )
   )

%% Syntaxe: \bbarre #"text" { notes } - text = any number of box
\relative c'{
  \restezA "V" { <f a'>16[  c' d c d8] }
}

\relative c'{
  \restezB  { <f a'>16[  c' d c d8] }
}


