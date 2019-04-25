let s:UI = {}
let g:QFStoreUI = s:UI

function! s:UI.New(qfstore)
    let newObj = copy(self)
    let newObj.qfstore = a:qfstore

    return newObj
endfunction

function! s:UI.render()
    echom "rendered!"
endfunction

function! s:UI.restoreScreenState()
    echom "restored!"
endfunction
