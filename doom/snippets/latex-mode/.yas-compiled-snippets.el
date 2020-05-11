;;; Compiled snippets and support files for `latex-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'latex-mode
                     '(("newlec" "\\clearpage\n\\subsection{`(format-time-string \"%B %d, %Y\")`}\n" "newlecturesub" nil nil nil "/Users/waigni/.config/doom/snippets/latex-mode/newlecturesub" nil nil)
                       ("newlecmain" "\\input{lectures/`(format-time-string \"%Y-%m-%d\")`.tex}\n" "newlecturemain" nil nil nil "/Users/waigni/.config/doom/snippets/latex-mode/newlecturemain" nil nil)
                       ("lec" "\\documentclass[lecture]{twl}\n\n\\title{[${1:$$(upcase yas-text)}] ${2:Course Name}}\n\\author{${4:twl}}\n\n\\begin{document}\n\\maketitle\n\n\\makeatletter\n\\RenewDocumentCommand{\\@title}{}{$1}\n\\makeatother\n\n\\begin{description}\n\\item[Professor] ${6:$$(capitalize yas-text)}${7:\n}\n\\end{description}\n\n\\tableofcontents\n\n$0\n\n\\clearpage\n\\printindex\n\\clearpage\n\\theoremlisttype{opt}\n\\listtheorems{theorem}\n\\end{document}\n" "lecture" nil nil nil "/Users/waigni/.config/doom/snippets/latex-mode/lecture" nil nil)))


;;; Do not edit! File generated at Mon May 11 06:26:32 2020
