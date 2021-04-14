;;; Compiled snippets and support files for `latex-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'latex-mode
                     '(("prp" "\\begin{proposition}\n`%`$0\n\\end{proposition}" "proposition" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/proposition" nil nil)
                       ("nb" "\\begin{note}\n`%`$0\n\\end{note}" "note" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/note" nil nil)
                       ("newlec" "%% -*- TeX-master: \"../main\"; TeX-engine: xetex -*-\n\n\\\\${1:sub}section{${2:`(format-time-string \"%B %d, %Y\")`}}\n$0" "newlecturesub" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/newlecturesub" nil nil)
                       ("newlecmain" "\\include{lectures/${1:`(format-time-string \"%Y-%m-%d\")`}.tex}\n$0" "newlecturemain" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/newlecturemain" nil nil)
                       ("lec" "%% -*- TeX-engine: xetex -*-\n\n\\documentclass[lecture]{twl}\n\n\\title{[${1:$$(upcase yas-text)}] ${2:Course Name}}\n\\author{${4:Ting Wei Liu}}\n\n\\begin{document}\n\\maketitle\n\n\\makeatletter\n\\RenewDocumentCommand{\\@title}{}{$1}\n\\makeatother\n\n\\begin{description}\n\\item[Professor] ${6:$$(capitalize yas-text)}${7:\n}\n\\end{description}\n\n\\tableofcontents\n\n$0\n\n\\PrintIndex{}\n\\PrintTheorems{}\n\\end{document}\n" "lecture" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/lecture" nil nil)
                       ("eg" "\\begin{example}\n`%`$0\n\\end{example}" "example" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/example" nil nil)
                       ("asg" "%% -*- TeX-engine: xetex -*-\n\n\\documentclass[assignment]{twl}\n\n\\title{[${1:$$(upcase yas-text)}] ${2:Assignment} \\texttt{\\#}${3:Number}}\n\\author{${4:Ting Wei Liu}}\n\\date{${5:`(format-time-string \"%B %d, %Y\")`}}\n\n\\begin{document}\n\\maketitle\n\n\\tableofcontents\n\\clearpage\n\n\\problem{}\n\n$0\n\\end{document}" "assignment" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/assignment" nil nil)))


;;; Do not edit! File generated at Wed Apr 14 14:34:36 2021
