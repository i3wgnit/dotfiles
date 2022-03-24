;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ting Wei Liu"
      user-mail-address "i3wgnit@pm.me")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Iosevka" :size 18)
      doom-variable-pitch-font doom-font
      doom-big-font (font-spec :family "Iosevka" :size 36))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/sync/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
;;

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

(setq doom-leader-alt-key "C-SPC"
      doom-localleader-alt-key "C-,"
      doom-localleader-key ",")

(setq ispell-dictionary "en")

(map! :m [tab] nil
      :n "Q" #'evil-fill-and-move
      (:when IS-MAC
       :map doom-leader-toggle-map
       "F" #'toggle-frame-maximized))

(setq-default fill-column 120
              indent-tabs-mode nil)

(setq company-idle-delay nil
      diary-file (concat org-directory "diary.gpg")
      enable-local-variables t
      sentence-end-double-space t
      whitespace-style '(empty face indentation tabs trailing))

(setq evil-escape-key-sequence nil
      evil-ex-substitute-global t
      evil-split-window-below t
      evil-vsplit-window-right t)

;; :ui minimap
(after! minimap
  (add-to-list 'minimap-major-modes #'text-mode)
  (setq minimap-window-location 'left))

;; :tools lsp
(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil
        lsp-enable-suggest-server-download nil))
(after! lsp-ui
  (setq lsp-ui-sideline-enable nil
        lsp-ui-doc-enable nil))

;; :lang cc
(setq-hook! '(c-mode-hook c++-mode-hook)
  indent-tabs-mode nil)

;; :lang latex
(map! :when (featurep! :lang latex)
      :after latex
      :map LaTeX-mode-map
      :desc "Fill buffer" "M-Q" #'LaTeX-fill-buffer
      :desc "Fill paragraph" :n "M-q" #'LaTeX-fill-paragraph
      :desc "Fill region" :v "M-q" #'LaTeX-fill-region
      (:localleader
       :desc "Crossref" "&" #'reftex-view-crossref
       :desc "Compile" "c" #'TeX-command-master
       :desc "Compile all" "a" #'TeX-command-run-all
       :desc "Environment" "e" #'LaTeX-environment
       :desc "Font" "f" #'TeX-font
       :desc "Macro" "m" #'TeX-insert-macro
       :desc "Section" "s" #'LaTeX-section))

(after! latex
  ;; Declutter
  (setq TeX-style-private (concat doom-private-dir "auctex/style")
        TeX-auto-private (concat doom-cache-dir "auctex/auto"))
  (add-to-list 'TeX-style-path TeX-style-private)

  ;; LaTeX-mode hooks
  (add-hook! LaTeX-mode
             #'LaTeX-math-mode
             #'hack-local-variables)    ; hack to enable local variables in latex-mode

  ;; Customization
  (add-to-list 'LaTeX-indent-environment-list '("empheq" LaTeX-indent-tabular))
  (add-to-list 'LaTeX-indent-environment-list '("algorithmic"))
  (add-to-list 'LaTeX-indent-environment-list '("asy"))
  (add-to-list 'LaTeX-indent-environment-list '("asydef"))
  (add-to-list 'LaTeX-indent-environment-list '("circuitikz"))
  (add-to-list 'LaTeX-indent-environment-list '("dottotex"))
  (add-to-list 'LaTeX-indent-environment-list '("quantikz" LaTeX-indent-tabular))

  (defun +latex//fill-sentence (orig-fun from to &rest args)
    "Start each sentence on a new line."
    (let ((to-marker (set-marker (make-marker) to))
          tmp-end)
      (save-excursion
        (while (< from (marker-position to-marker))
          (forward-sentence)
          (when (looking-at " ") (backward-char))
          (setq to (min (point) (marker-position to-marker)))
          (apply orig-fun from to args)
          (setq from (point))
          (save-excursion
            (back-to-indentation)
            (setq tmp-end (point)))
          (unless (or (bolp)
                      (eolp)
                      (texmathp)
                      (<= from tmp-end)
                      (looking-at ". *$"))
            (LaTeX-newline))))))
  (advice-add #'LaTeX-fill-region-as-paragraph
              :around #'+latex//fill-sentence))
(when (featurep! :lang latex)
  (setq
   LaTeX-paragraph-commands
   '("documentclass" "usepackage" "title" "author" "date" "vspace" "hspace" "centering"
     "includegraphics"
     "problem" "subproblem" "subsubproblem"
     "PrintTheorems" "PrintIndex" "PrintAcronyms")
   reftex-label-alist
   '(("axiom"       ?a "ax:"  "~\\thref{%s}" t ("axiom")       nil)
     ("conjecture"  ?j "cnj:" "~\\thref{%s}" t ("conjecture")  nil)
     ("corollary"   ?c "clr:" "~\\thref{%s}" t ("corollary")   nil)
     ("example"     ?g "eg:"  "~\\thref{%s}" t ("example")     nil)
     ("exercise"    ?x "ex:"  "~\\thref{%s}" t ("exercise")    nil)
     ("lemma"       ?l "lmm:" "~\\thref{%s}" t ("lemma")       nil)
     ("proposition" ?p "prp:" "~\\thref{%s}" t ("proposition") nil)
     ("remark"      ?r "rmk:" "~\\thref{%s}" t ("remark")      nil)
     ("theorem"     ?t "thm:" "~\\thref{%s}" t ("theorem")     nil))
   reftex-insert-label-flags
   '("s" "f")
   reftex-derive-label-parameters
   '(10 50 t 1 "-"
        ("the" "on" "in" "off" "a" "for" "by" "of" "and" "is" "to")
        t)))

(map! :when (featurep! :lang latex +cdlatex)
      :after cdlatex
      :map LaTeX-mode-map
      "TAB" #'cdlatex-tab)
(after! cdlatex
  (setq
   cdlatex-command-alist-default nil
   cdlatex-math-modify-alist
   '((?B "\\mathbb"   nil t nil nil)
     (?f "\\mathfrak" nil t nil nil))
   cdlatex-math-symbol-alist
   '((?*  ("\\times"    "\\otimes"))
     (?+  ("\\cup"      "\\oplus"))
     (?.  ("\\cdot"     "\\cdots"    "\\ldots"))
     (?0  ("\\emptyset" "\\varnothing"))
     (?F  ("\\Phi"))
     (?\\ ("\\setminus" "\\symdiff"))
     (?{  ("\\subset"   "\\subseteq" "\\vartriangleleft"))
     (?}  ("\\supset"   "\\supseteq" "\\vartriangleright")))))

(after! latex
  (add-hook! LaTeX-mode #'laas-mode)
  (add-hook! LaTeX-mode :append (cdlatex-mode -1)))
(setq laas-accent-snippets nil)
(after! laas
  (setq laas-enable-auto-space nil)

  (setq +laas--accent-snippets
        '(("'-" . "overline")           ; bar
          ("'." . "dot")
          ("':" . "ddot")
          ("'>" . "overrightarrow")     ; vec
          ("'^" . "widehat")            ; hat
          ("'_" . "ul")                 ; underline
          ("'{" . "overbrace")
          ("'}" . "underbrace")
          ("'~" . "widetilde")          ; tilde
          ("'/" . "grave")
          ("'\\" . "acute")
          ("'v" . "check")
          ("'u" . "breve")

          ("'b" . ("mathbf" . "textbf"))
          ("'c" . "mathcal")
          ("'e" . ("mathem" . "emph"))
          ("'f" . "mathfrak")
          ("'i" . ("mathit" . "textit"))
          ("'r" . ("mathrm" . "textrm"))
          ("'s" . ("mathsf" . "textsf"))
          ("'y" . ("mathtt" . "texttt"))

          ("bar" . "overline")
          ("hat" . "widehat")
          ("vec" . "overrightarrow")

          ;; physics package
          ("vb" . "vb")
          ("ket" . "ket")
          ("bra" . "bra")))

  (aas-set-snippets 'laas-mode
    :cond #'laas-mathp
    ;; Shorthands
    "acos" "\\arccos"
    "acot" "\\arccot"
    "acot" "\\arccot"
    "acsc" "\\arccsc"
    "asec" "\\arcsec"
    "asin" "\\arcsin"
    "atan" "\\arctan"

    "..." "\\cdots"
    ",,," "\\ldots"

    ";*" "\\times"              ";;*" "\\otimes"
    ";+" "\\cup"                ";;+" "\\oplus"
    ";0" "\\emptyset"           ";;0" "\\varnothing"
    ";F" "\\Phi"
    ";\\" "\\setminus"          ";;\\" "\\symdiff"
    ";{" "\\subset"             ";;{" "\\subseteq"              ";;;{" "\\vartriangleleft"
    ";}" "\\supset"             ";;}" "\\supseteq"              ";;;}" "\\vartriangleright"
    ";;;~" "\\cong"

    ;; Disable
    "!=" "!="
    "!>" "!>"
    "**" "**"
    "+-" "+-"
    "-+" "-+"
    "->" "->"
    "=>" "=>"
    "=<" "=<"
    "AA" "AA"
    "EE" "EE"
    "iff" "iff"
    "inn" "inn"
    "notin" "notin"
    "xx" "xx"
    "|->" "|->"
    "|=" "|="
    "||" "||"
    "~=" "~="
    "CC" "CC"
    "FF" "FF"
    "HH" "HH"
    "NN" "NN"
    "PP" "PP"
    "QQ" "QQ"
    "RR" "RR"
    "ZZ" "ZZ")

  (defun +laas//object-on-left-cond ()
    (or (<= ?a (char-before) ?z)
        (<= ?A (char-before) ?Z)
        (<= ?0 (char-before) ?9)
        (memq (char-before) '(?\) ?\] ?}))))

  (apply #'aas-set-snippets 'laas-mode
         (cl-loop
          for (key . exp) in +laas--accent-snippets
          collect :cond
          if (consp exp)
          collect #'laas-latex-accent-cond
          and collect :expansion-desc
          and collect (concat "Wrap in \\" (car exp) "{} or \\" (cdr exp) "{}")
          else
          collect #'laas-mathp
          and collect :expansion-desc
          and collect (concat "Wrap in \\" exp "{}")

          collect key

          if (consp exp)
          collect (let ((expm (car exp))
                        (expl (cdr exp)))
                    (lambda () (interactive)
                      (let ((expp (if (laas-mathp) expm expl)))
                        (if (+laas//object-on-left-cond)
                            (laas-wrap-previous-object expp)
                          (yas-expand-snippet (concat "\\" expp "{$0}"))
                          (laas--shut-up-smartparens)))))
          else
          collect (let ((expp exp))
                    (lambda () (interactive)
                      (if (laas-object-on-left-condition)
                          (laas-wrap-previous-object expp)
                        (yas-expand-snippet (concat "\\" expp "{$0}"))
                        (laas--shut-up-smartparens)))))))
