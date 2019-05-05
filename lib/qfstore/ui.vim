let s:UI = {}
let g:QFStoreUI = s:UI

function! s:UI.New(qfstore)
    let newObj = copy(self)
    let newObj.qfstore = a:qfstore

    return newObj
endfunction

function! s:UI.render()
    setlocal noreadonly modifiable

    silent 1,$delete _

    call self._writeLine('QFStore')
    call self._appendLine('')
    call self._renderHelp()

    call self._appendLine(getcwd())

    setlocal readonly nomodifiable
endfunction

function! s:UI.restoreScreenState()
    echom 'remains to be imp'
endfunction

function! s:UI._renderHelp() abort
    call self._appendLine("Help: ")
    call self._appendLine("g: Go rock yourself")
    call self._appendLine("k: Dean, check this out")
endfunction

function! s:UI._writeLine(text) abort
    call setline(line('.'), a:text)
endfunction

function! s:UI._appendLine(text) abort
    call cursor(line('.')+1, col('.'))
    call setline(line('.')+1, a:text)
endfunction
