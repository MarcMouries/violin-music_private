\version "2.19.26"



\score { \new Staff { \relative c''' {
   g4 \grace a8 \glissando 
    \override Score.NonMusicalPaperColumn.padding = #2
    b4 a2    
  }}}



slide = #(define-music-function (noteA noteB)( ly:music? ly:music?)
#{
   <>\glissando \grace #noteA
    \override Score.NonMusicalPaperColumn.padding = #2
#noteB
#})

\score { \new Staff { \relative c''' {
   g4 \slide a8 b4 a2
}}}


slide = #(define-music-function (noteA noteB)( ly:music? ly:music?)
#{
   \grace #noteA <> \glissando 
    \override Score.NonMusicalPaperColumn.padding = #2
#noteB
#})

\score { \new Staff { \relative c''' {
   g4 \slide a8 b4 a2
}}}




glissin = #(define-music-function (notea noteb)(ly:pitch? ly:music?)
            #{    \override Score.NonMusicalPaperColumn.padding = #1.5

                \grace $notea 8 \glissando $noteb
            #})

\score { \new Staff { \relative c''' {
   g4 \glissin a b4 a2
}}}