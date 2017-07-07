function! UpdatePDF()
    silent! execute "silent! Start! latexmk -f -silent %"
endfunction

function! StartLatexmk()
    " if exists("b:latexmkStarted")
    "     echo "latexmk is already running"
    " else
    "     let b:latexmkStarted = 1
        silent! execute 'silent! Start! termite -e "latexmk -f -silent -pvc '.expand('%:p').'"'
        echo "latexmk is now running"
    " endif
endfunction

function! StartZathura()
    silent! Start! 'zathura '.expand('%:r').'.pdf'
endfunction

nnoremap <silent> <buffer> <localLeader>o :call StartLatexmk()<cr>
nnoremap <silent> <buffer> <localLeader>p :silent! execute "silent! !zathura ".expand('%:r').'.pdf &' \| redraw!<cr>

" autocmd TextChanged *.tex call UpdatePDF()
" autocmd TextChangedI *.tex call UpdatePDF()
" autocmd BufWritePost * call UpdatePDF()

