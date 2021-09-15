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
(setq doom-font (font-spec :family "Iosevka" :size 21)
      doom-variable-pitch-font doom-font
      doom-big-font (font-spec :family "Iosevka" :size 36))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")

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
      diary-file (concat org-directory "diary")
      enable-local-variables t
      evil-ex-substitute-global t
      evil-split-window-below t
      evil-vsplit-window-right t
      sentence-end-double-space t
      whitespace-style '(empty face indentation tabs trailing))

;; :lang cc
(setq-hook! '(c-mode-hook c++-mode-hook)
  indent-tabs-mode nil)

(after! minimap
  (add-to-list 'minimap-major-modes #'text-mode)
  (setq minimap-window-location 'left))

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
       :desc "Section" "s" #'LaTeX-section
       :desc "View" "v" #'TeX-view))

;; :lang latex
(after! latex
  ;; Declutter
  (setq TeX-style-private (concat doom-private-dir "auctex/style")
        TeX-auto-private (concat doom-cache-dir "auctex/auto"))
  (add-to-list 'TeX-style-path TeX-style-private)

  ;; LaTeX-mode hooks
  (add-hook! LaTeX-mode
             #'LaTeX-math-mode
             #'hack-local-variables) ; hack to enable local variables in latex-mode
  (when (featurep! :lang latex +cdlatex)
    (add-hook! LaTeX-mode #'cdlatex-mode))

  ;; Customization
  (add-to-list 'LaTeX-indent-environment-list '("AmSalign" LaTeX-indent-tabular))
  (add-to-list 'LaTeX-indent-environment-list '("AmSalign*" LaTeX-indent-tabular))
  (add-to-list 'LaTeX-indent-environment-list '("algorithmic"))
  (add-to-list 'LaTeX-indent-environment-list '("asy"))
  (add-to-list 'LaTeX-indent-environment-list '("asydef"))
  (add-to-list 'LaTeX-indent-environment-list '("circuitikz"))
  (add-to-list 'LaTeX-indent-environment-list '("dot2tex"))
  (add-to-list 'LaTeX-indent-environment-list '("quantikz" LaTeX-indent-tabular))

  (setq!
   LaTeX-paragraph-commands
   '("documentclass" "usepackage" "title" "author" "date" "vspace" "hspace" "centering"
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
       t))

  (defun twl+latex//fill-sentence (orig-fun from to &rest args)
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
              :around #'twl+latex//fill-sentence))

(map! :when (featurep! :lang latex +cdlatex)
      :after cdlatex
      :map LaTeX-mode-map
      "TAB" #'cdlatex-tab)

(after! cdlatex
  (setq
   cdlatex-math-symbol-alist
   '((?0 ("\\emptyset" "\\varnothing"))
     (?{ ("\\subset" "\\subseteq" "\\vartriangleleft"))
     (?} ("\\supset" "\\supseteq" "\\vartriangleright"))
     (?\\ ("\\setminus" "\\symdiff"))
     (?F ("\\Phi")))))
