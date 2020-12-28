(TeX-add-style-hook
 "declpkg"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("l3doc" "full")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("listings" "final")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (TeX-run-style-hooks
    "latex2e"
    "l3docstrip"
    "l3doc"
    "l3doc10"
    "listings"
    "expl3")
   (TeX-add-symbols
    "nameofplainTeX")
   (LaTeX-add-environments
    '("queslistsect" LaTeX-env-args ["argument"] 0)
    '("queslistenum" LaTeX-env-args ["argument"] 0)
    '("annotecode" LaTeX-env-args ["argument"] 0)
    '("prf" LaTeX-env-args ["argument"] 0)
    '("nprf" LaTeX-env-args ["argument"] 0)
    '("hrproof" LaTeX-env-args ["argument"] 0)))
 :latex)

