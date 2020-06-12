;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ting Wei Liu"
      user-mail-address "i3wgnit@gmail.com")

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
(setq doom-font (font-spec :family "Iosevka" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
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

(setq doom-leader-key ","
      doom-localleader-key "\\"
      doom-leader-alt-key "M-,"
      doom-localleader-alt-key "M-\\")

(setq whitespace-style '(empty face indentation tabs trailing))

(map! :map doom-leader-toggle-map
      "F" 'toggle-frame-maximized)

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(setq sentence-end-double-space t)

(after! latex
  (add-hook 'LaTeX-mode-hook #'LaTeX-math-mode)

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
              :around #'twl+latex//fill-sentence)
  (add-to-list 'LaTeX-indent-environment-list '("algorithmic"))
  (add-to-list 'LaTeX-indent-environment-list '("asy"))
  (add-to-list 'LaTeX-indent-environment-list '("asydef")))
