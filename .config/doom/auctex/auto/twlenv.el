(TeX-add-style-hook
 "twlenv"
 (lambda ()
   (TeX-run-style-hooks
    "twlbase")
   (LaTeX-add-environments
    '("queslistsect" LaTeX-env-args ["argument"] 0)
    '("queslistenum" LaTeX-env-args ["argument"] 0)
    '("annotecode" LaTeX-env-args ["argument"] 0)
    '("prf" LaTeX-env-args ["argument"] 0)
    '("nprf" LaTeX-env-args ["argument"] 0)
    '("hrproof" LaTeX-env-args ["argument"] 0)))
 :latex)

