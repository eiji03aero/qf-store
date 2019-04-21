if exists("g:loaded_qfstore_autoload")
    finish
endif
let g:loaded_qfstore_autoload = 1

function! qfstore#loadClassFiles()
    runtime lib/qfstore/creator.vim
    runtime lib/qfstore/key_map.vim
    runtime lib/qfstore/qfstore.vim
endfunction
