(TeX-add-style-hook
 "twl"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("attachfile2" "dvips")))
   (TeX-run-style-hooks
    "amsmath"
    "amssymb"
    "amsfonts"
    "ulem"
    "needspace"
    "setspace"
    "etoolbox"
    "array"
    "xfrac"
    "geometry"
    "xcolor"
    "siunitx"
    "framed"
    "mdframed"
    "ntheorem"
    "attachfile2"
    "asymptote"
    "titling"
    "scrlayer-scrpage")
   (TeX-add-symbols
    '("norm" 1)
    '("abs" 1)
    '("ceil" 1)
    '("floor" 1)
    '("overbar" 1)
    '("mdfthm" 1)
    "ii"
    "dg"
    "st"
    "nd"
    "Tau"
    "CC"
    "RR"
    "QQ"
    "ZZ"
    "NN"
    "FF"
    "arcsec"
    "lcm"
    "liff"
    "lthen"
    "ot"
    "surjto"
    "injto"
    "dom"
    "img"
    "Dom"
    "Img"
    "vspan"
    "rk"
    "nul"
    "rank")
   (LaTeX-add-mdframed-mdfdefinestyles
    "mdbluebox"
    "mdrecbox")
   (LaTeX-add-ntheorem-newtheorems
    "theorem"
    "note"
    "recall"
    "remark"
    "notation"
    "exercise"
    "axiom"
    "lemma"
    "proposition"
    "corollary"
    "definition"
    "example"
    "conjecture"
    "proof"
    "solution"
    "subproof")
   (LaTeX-add-ntheorem-newtheoremstyles
    "bplain"
    "nonumberbplain"
    "mybreak"
    "nonumbermybreak"))
 :latex)

