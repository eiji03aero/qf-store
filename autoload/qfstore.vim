if exists("g:loaded_qfstore_autoload")
    finish
endif
let g:loaded_qfstore_autoload = 1

function! qfstore#exec(cmd)
    let old_ei = &ei
    set ei=BufEnter,BufLeave,VimEnter
    exec a:cmd
    let &ei = old_ei
endfunction

function! qfstore#loadClassFiles()
    runtime lib/qfstore/key_map.vim
    runtime lib/qfstore/creator.vim
    runtime lib/qfstore/ui.vim
    runtime lib/qfstore/qfstore.vim
endfunction
