(TeX-add-style-hook
 "245assignments"
 (lambda ()
   (TeX-run-style-hooks
    "amsmath"
    "mleftright"
    "ifthen"
    "verbatim"
    "proof"
    "logicproof"
    "bussproofs"
    "xspace")
   (TeX-add-symbols
    '("sectquestion" ["argument"] 0)
    '("enumquestion" ["argument"] 0)
    '("solblank" ["argument"] 1)
    '("fillblank" ["argument"] 1)
    '("blank" ["argument"] 0)
    '("specofref" ["argument"] 1)
    '("specof" ["argument"] 1)
    '("hrline" ["argument"] 2)
    '("marking" 1)
    '("listnamemath" 1)
    '("listnametext" 1)
    '("abbrpair" 1)
    '("conspair" 1)
    '("sym" 1)
    '("constsym" 1)
    '("funcsym" 1)
    '("listof" 1)
    '("dualnilname" 2)
    '("lisp" 1)
    '("relof" 1)
    '("dualsym" 1)
    '("codesym" 1)
    '("relsym" 1)
    '("revision" 1)
    '("impliedcolor" 1)
    '("backupcolor" 1)
    '("annotecolor" 1)
    '("emphcolor" 1)
    '("univax" 2)
    '("condn" 1)
    '("varn" 1)
    '("fmlan" 1)
    '("usesubprf" 1)
    '("savesubprf" 3)
    '("fboxproof" 1)
    '("boxproof" 1)
    '("raisehalf" 1)
    '("atfirstline" 1)
    '("setcurrenvir" 1)
    '("hrsetline" 1)
    '("replacenextlnno" 1)
    '("hrdefaultlabel" 1)
    '("inferby" 1)
    '("tildeize" 1)
    '("modelfont" 1)
    '("domelmt" 1)
    '("setst" 2)
    '("tuple" 1)
    '("code" 1)
    '("mepunct" 1)
    '("arrayrepl" 3)
    '("iiihstate" 3)
    '("mlhstate" 2)
    '("slhstate" 2)
    '("hoarebegin" 1)
    '("hoaretriple" 3)
    '("hoarestate" 1)
    '("ascode" 1)
    '("multided" 2)
    '("dedrule" 2)
    '("ptm" 1)
    '("eqof" 2)
    '("forallof" 2)
    '("existsof" 2)
    '("dblnegof" 1)
    '("negof" 1)
    '("iffof" 2)
    '("implof" 2)
    '("orof" 2)
    '("andof" 2)
    '("pfm" 1)
    '("envsubsinforby" 3)
    '("undervaluation" 2)
    '("undermodenv" 3)
    '("undermod" 2)
    '("underenv" 2)
    '("axproves" 1)
    '("notprovesin" 1)
    '("provesin" 1)
    '("renewmeta" 2)
    '("renewqfr" 2)
    '("renewlogrel" 2)
    '("renewlogopr" 2)
    '("newqfr" 2)
    '("newmeta" 2)
    '("newlogrel" 2)
    '("newlogopr" 2)
    '("asqfr" 2)
    '("asmeta" 1)
    '("aslogrel" 1)
    '("aslogopr" 1)
    '("notmodelof" 2)
    '("modelof" 2)
    '("subsinbyfor" 3)
    "thispkgname"
    "text"
    "hr"
    "lu"
    "luhilbertproves"
    "lunatdedproves"
    "ccxlv"
    "entailsismodels"
    "entailsisvDash"
    "plainquantifiers"
    "dotquantifiers"
    "cdotquantifiers"
    "parenquantifiers"
    "Neg"
    "bottom"
    "ccxlvgenqfrsym"
    "hsopen"
    "hsclose"
    "nequiv"
    "napprox"
    "nvdash"
    "nvDash"
    "nforall"
    "nexists"
    "questeq"
    "llparenthesis"
    "rrparenthesis"
    "hoaretextfont"
    "hoaremid"
    "hoareend"
    "mathcanonfont"
    "nats"
    "rats"
    "ints"
    "mstop"
    "dom"
    "ran"
    "tilde"
    "eg"
    "ie"
    "hrmaxdepth"
    "fmlai"
    "fmlaii"
    "fmlaiii"
    "fmlaiv"
    "vari"
    "varii"
    "variii"
    "variv"
    "condi"
    "condii"
    "condiii"
    "openaxioms"
    "qfraxioms"
    "defncolor"
    "emcolor"
    "emblue"
    "red"
    "blue"
    "colteal"
    "colblue"
    "matchteal"
    "matchblue"
    "matchthird"
    "matchviolet"
    "showspecformulas"
    "noshowspecformulas"
    "folnamefont"
    "lispnamefont"
    "relax"
    "lispmathfont"
    "setlisp"
    "setfol"
    "cons"
    "cond"
    "lisptrue"
    "lispfalse"
    "first"
    "rest"
    "true"
    "eq"
    "sorted"
    "err"
    "atom"
    "lambdaconst"
    "name"
    "firstrel"
    "restrel"
    "appendrel"
    "conspairs"
    "abbrpairs"
    "annotecodefont"
    "codeindent"
    "enumqrunin"
    "enumqnewline"
    "enumquestions"
    "sectquestions"
    "questiontype"
    "dosolution"
    "nosolutions"
    "showsolutions"
    "solnintrotext"
    "solnfont"
    "solnstrongfont"
    "coursename"
    "termandyear"
    "term"
    "asmtno"
    "datedue"
    "daydue"
    "timedue"
    "locationdue"
    "numprobs"
    "coverinfo"
    "workingpolicy"
    "duedateinfo"
    "tru"
    "fals"
    "entailedby"
    "notentailedby"
    "subsinforby"
    "proptrue"
    "propfalse"
    "substinforby"
    "substinbyfor"
    "sifb"
    "sibf"
    "newlogqfr"
    "renewlogqfr"
    "And"
    "Biimpl"
    "equalof"
    "symbf"
    "symsf"
    "phi"
    "innerpfm"
    "pfm"
    "left"
    "right"
    "mleft"
    "mright"
    "hoare"
    "hstate"
    "mlhoare"
    "code"
    "infer"
    "DisplayProof"
    "fmla"
    "fmlb"
    "fmlc"
    "fmld"
    "vara"
    "varb"
    "varc"
    "vard"
    "conda"
    "condb"
    "condc"
    "spec"
    "currnamefont"
    "sym"
    "consof"
    "pairof"
    "maybesolution"
    "qbreak")
   (LaTeX-add-environments
    "solution"
    "queslist"
    "question"
    '("queslistsect" LaTeX-env-args ["argument"] 0)
    '("queslistenum" LaTeX-env-args ["argument"] 0)
    '("annotecode" LaTeX-env-args ["argument"] 0)
    '("prf" LaTeX-env-args ["argument"] 0)
    '("nprf" LaTeX-env-args ["argument"] 0)
    '("hrproof" LaTeX-env-args ["argument"] 0)
    '("ndruletable" 3)
    "legacies"
    "codemath"
    "hrsubproof"
    "sprf"
    "boxprooftree"
    "lispdef"
    "lispdefstd"
    "exenum"
    "questiononly")
   (LaTeX-add-counters
    "quesnum")
   (LaTeX-add-lengths
    "parenht"
    "parendp"
    "hoareskip"
    "ccxlv"
    "annotesep"
    "codeindentamount"
    "blankheight"
    "blankwidth"))
 :latex)

