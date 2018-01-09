set iskeyword+=:
set ts=2
set sw=2
set sts=2
set listchars+=space:␣
set noexpandtab

function! UpdatePDF()
    silent! execute "silent! Start! latexmk -f -silent %"
endfunction

function! StartLatexmk()
    " if exists("b:latexmkStarted")
    "     echo "latexmk is already running"
    " else
    "     let b:latexmkStarted = 1
        silent! Start! urxvt -e latexmk -f -silent -pvc %
        echo "latexmk is now running"
    " endif
endfunction

function! StartZathura()
    silent! Start! 'zathura '.expand('%:r').'.pdf'
endfunction

nnoremap <silent> <buffer> <localLeader>o :call StartLatexmk()<cr>
nnoremap <silent> <buffer> <localLeader>p :silent! execute "silent! !zathura ".expand('%:r').'.pdf &' \| redraw!<cr>

imap <c-\> <Plug>IMAP_JumpForward
nmap <c-\> <Plug>IMAP_JumpForward
vmap <c-\> <Plug>IMAP_JumpForward
nmap <localleader>l :redraw!<cr>

" imap <localleader>i <Plug>Tex_InsertItemOnThisLine
" nmap <localleader>i <Plug>Tex_InsertItemOnThisLine
" vmap <localleader>i <Plug>Tex_InsertItemOnThisLine

" imap <localleader>t \text{<++>}<++><Esc>T\<Plug>IMAP_JumpForward

" autocmd TextChanged *.tex call UpdatePDF()
" autocmd TextChangedI *.tex call UpdatePDF()
" autocmd BufWritePost * call UpdatePDF()

