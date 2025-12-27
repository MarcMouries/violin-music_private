\include "english.ly"

\header {
  title     = "Silent Night"
  composer  = "Franz Gruber (1787–1863)"
  poet      = "Joseph Mohr"
  country   = "Austria"
  genre = "Christmas"
}

\include "../../common/common-header.ily"
#(set-default-paper-size "letter")
\paper {
    indent = 0.0
}

global= { \time 6/8
          \key bf \major  }


violonUn = \relative f' {
   \clef treble
   f8.  g16  f8   d4. 
   f8.  g16  f8   d4. 
   c'4  c8   a4.  
   bf4  bf8  f4.  
   g4   g8   bf8. a16 g8 
   f8.  g16  f8   d4. 
   g4   g8   bf8. a16  g8 
   f8.  g16  f8   d4.
   c'4  c8   ef8. c16 a8 
   bf4. d 
   bf8. f16  d8 f8. ef16 c8 
   bf2. \bar "|."
}


violonDeux = {
   \clef treble
   d'8.  ef'16 d'8  bf4. 
   d'8.  ef'16 d'8  bf4. 
   ef'4  ef'8  c'4. d'4 
   d'8   d'4.  ef'4 ef'8 
   g'8.  f'16  ef'8 d'8. 
   ef'16 d'8   bf4. ef'4
   ef'8  g'8.  f'16 ef'8 
   d'8.  ef'16 d'8  bf4. 
   ef'4  ef'8  a'8. ef'16
   c'8   d'4.  f'   d'8. 
   f'16  bf8   d'8. c'16 a8 bf2.
  \bar "|."
  }


tenor = {
  { \key bf \major bf4 bf8 f4. bf4 bf8 f4. a4 a8 f4. f4 f8 bf4. bf4 bf8 g8. a16 bf8 bf8. bf16 bf8 f4. bf4 bf8 g8. a16 bf8 bf8. bf16 bf8 f4. a4 a8 c'8. a16 f8 f4. bf bf4 f8 f8. f16 ef8 d2.
  \bar "|."
  }
}
bass = {
  { \key bf \major bf,4 bf,8 bf,4. bf,4 bf,8 bf,4. f4 f8 f4. bf,4 bf,8 bf,4. ef4 ef8 ef8. ef16 ef8 bf,8. bf,16 bf,8 bf,4. ef4 ef8 ef8. ef16 ef8 bf,8. bf,16 bf,8 bf,4. f4 f8 f8. f16 f8 bf,2 ( bf,4 ) f f8 f,8. f,16 f,8 bf,2.
  \bar "|."
  }
}



targetKey = c

  \score {
    \context GrandStaff <<
      \context Staff = upper <<
        \set Staff.printPartCombineTexts = ##f
        \partcombine
        {   #(set-accidental-style 'modern-cautionary) \violonUn }
        { \violonDeux}
      >>  
      \context Staff = lower <<
        \set Staff.printPartCombineTexts = ##f
        \clef bass
        \partcombine	{  #(set-accidental-style 'modern-cautionary) \tenor }
        { \bass }
      >>  
    >>
\midi { \context { \Score tempWholesPerMinute = #(ly:make-moment 50 4 ) } }
\layout {
  between-system-space = 1\mm
  \context {
    \Score
    % defaults
    % (shortest-duration-space . 2.0)
    % (spacing-increment . 1.2)
    % (base-shortest-duration . ,(ly:make-moment 1 8))
    % tighter spacing
    \override SpacingSpanner #'shortest-duration-space = #2.8
    \override SpacingSpanner #'spacing-increment = #0.6
    \override SpacingSpanner #'base-shortest-duration = #(ly:make-moment 1 8)
    %\remove "Bar_number_engraver"
  }
  \context { \Staff 
    \override VerticalAxisGroup #'minimum-Y-extent = #'(-1 . 1)
  }
  }
}


\score {
  \new StaffGroup <<
    \new Staff << \global \violonUn >>
    \new Staff << \global \violonDeux >>
   % \new Staff << \global \viola >>
   % \new Staff << \global \cello >>
  >>
  \layout { }
  \midi { }
}


\score {
	\transpose c \targetKey' \violonUn
}
