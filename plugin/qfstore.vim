if exists("g:loaded_qfstore")
    finish
endif
let g:loaded_qfstore = 1

let s:old_cpo = &cpo
set cpo&vim

let g:QFStore_windowPosition = 'right'
let g:QFStore_windowSize = 50

call qfstore#loadClassFiles()

augroup QFStore
    exec "autocmd BufEnter ". g:QFStoreCreator.BufferNamePrefix() ."* stopinsert"
augroup END

function! QFStoreToggleStore()
    call g:QFStoreCreator.ToggleStoreWindow()
endfunction


nnoremap <Leader>qt :call QFStoreToggleStore()<CR>

let &cpo = s:old_cpo
unlet s:old_cpo
