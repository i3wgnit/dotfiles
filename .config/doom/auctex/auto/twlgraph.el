(TeX-add-style-hook
 "twlgraph"
 (lambda ()
   (TeX-run-style-hooks
    "twlbase")
   (TeX-add-symbols
    "asydir")
   (LaTeX-add-environments
    '("queslistsect" LaTeX-env-args ["argument"] 0)
    '("queslistenum" LaTeX-env-args ["argument"] 0)
    '("annotecode" LaTeX-env-args ["argument"] 0)
    '("prf" LaTeX-env-args ["argument"] 0)
    '("nprf" LaTeX-env-args ["argument"] 0)
    '("hrproof" LaTeX-env-args ["argument"] 0)))
 :latex)

