;;; Compiled snippets and support files for `latex-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'latex-mode
                     '(("sol" "\\begin{solution}\n`%`$0\n\\end{solution}" "solution" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/solution" nil nil)
                       ("prp" "\\begin{proposition}\n`%`$0\n\\end{proposition}" "proposition" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/proposition" nil nil)
                       ("prf" "\\begin{proof}\n`%`$0\n\\end{proof}" "proof" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/proof" nil nil)
                       ("nb" "\\begin{note}\n`%`$0\n\\end{note}" "note" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/note" nil nil)
                       ("newlec" "%% -*- TeX-master: \"../main.tex\" ; TeX-engine: xetex -*-\n\\documentclass[../main.tex]{subfiles}\n\n\\begin{document}\n$0\n\\end{document}" "newlecturesub" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/newlecturesub" nil nil)
                       ("newlecmain" "\\subfileinclude{lectures/${1:`(format-time-string \"%Y-%m-%d\")`}}\n$0" "newlecturemain" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/newlecturemain" nil nil)
                       ("lec" "%% -*- TeX-engine: xetex -*-\n\n\\documentclass[lecture]{twl}\n\n\\title{${1:$$(upcase yas-text)}}\n\\author{${4:Ting Wei Liu}}\n\n\\input{preamble}\n\\usepackage{subfiles}\n\n\\begin{document}\n\\makeatletter\n\\let\\@shorttitle\\@title\n\\RenewDocumentCommand{\\@title}{}{\\@shorttitle{}: ${2:Course Name}}\n\\makeatother\n\n\\maketitle\n\n\\makeatletter\n\\let\\@title\\@shorttitle\n\\makeatother\n\n\\begin{description}\n\\item[Professor] ${6:$$(capitalize yas-text)}${7:\n}\n\\end{description}\n\n\\tableofcontents\n\n$0\n\n\\PrintIndex{}\n\\PrintTheorems{}\n\\end{document}\n" "lecture" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/lecture" nil nil)
                       ("eg" "\\begin{example}\n`%`$0\n\\end{example}" "example" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/example" nil nil)
                       ("eq" "\\begin{empheq}{${1:align*}}\n`%`$0\n\\end{empheq}" "empheq" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/empheq" nil nil)
                       ("asg" "%% -*- TeX-engine: xetex -*-\n\n\\documentclass[assignment]{twl}\n\n\\title{${1:$$(upcase yas-text)}: ${2:Assignment} \\texttt{\\#}${3:Number}}\n\\author{${4:twl}}\n\\date{${5:`(format-time-string \"%B %d, %Y\")`}}\n\n\\input{../../preamble}\n\n\\begin{document}\n\\maketitle\n\n\\tableofcontents\n\\clearpage\n\n\\problem{}\n\n$0\n\\end{document}" "assignment" nil nil nil "/home/waigni/.config/doom/snippets/latex-mode/assignment" nil nil)))


;;; Do not edit! File generated at Thu Mar 24 16:25:15 2022
