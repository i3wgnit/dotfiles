function! UpdatePDF()
    silent! execute "silent! Start! latexmk -f -silent %"
endfunction

function! StartLatexmk()
    " if exists("b:latexmkStarted")
    "     echo "latexmk is already running"
    " else
    "     let b:latexmkStarted = 1
        silent! execute 'silent! Start! urxvt -e latexmk -f -silent -pvc '.expand('%:p')
        echo "latexmk is now running"
    " endif
endfunction

function! StartZathura()
    silent! Start! 'zathura '.expand('%:r').'.pdf'
endfunction

nnoremap <silent> <buffer> <localLeader>o :call StartLatexmk()<cr>
nnoremap <silent> <buffer> <localLeader>p :silent! execute "silent! !zathura ".expand('%:r').'.pdf &' \| redraw!<cr>

imap <localleader>q <Plug>IMAP_JumpForward
nmap <localleader>q <Plug>IMAP_JumpForward
vmap <localleader>q <Plug>IMAP_JumpForward

imap <localleader>i <Plug>Tex_InsertItemOnThisLine
nmap <localleader>i <Plug>Tex_InsertItemOnThisLine
vmap <localleader>i <Plug>Tex_InsertItemOnThisLine

imap <localleader>t \text{<++>}<++><Esc>T\<Plug>IMAP_JumpForward

" autocmd TextChanged *.tex call UpdatePDF()
" autocmd TextChangedI *.tex call UpdatePDF()
" autocmd BufWritePost * call UpdatePDF()

