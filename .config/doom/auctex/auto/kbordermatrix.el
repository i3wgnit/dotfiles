(TeX-add-style-hook
 "kbordermatrix"
 (lambda ()
   (TeX-add-symbols
    '("kbordermatrix" 1)
    "kbldelim"
    "kbrdelim"
    "kbrowstyle"
    "kbcolstyle"
    "cr")
   (LaTeX-add-environments
    '("queslistsect" LaTeX-env-args ["argument"] 0)
    '("queslistenum" LaTeX-env-args ["argument"] 0)
    '("annotecode" LaTeX-env-args ["argument"] 0)
    '("prf" LaTeX-env-args ["argument"] 0)
    '("nprf" LaTeX-env-args ["argument"] 0)
    '("hrproof" LaTeX-env-args ["argument"] 0))
   (LaTeX-add-lengths
    "kbcolsep"
    "kbrowsep"
    "br"
    "k"))
 :latex)

