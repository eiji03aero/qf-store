let s:QFStore = {}
let g:QFStore = s:QFStore

function! s:QFStore.New()
    let newObj = copy(self)
    let newObj.ui = g:QFStoreUI.New(newObj)
    return newObj
endfunction

function! s:QFStore.Close()
    if !s:QFStore.IsOpen()
        return
    endif

    if winnr("$") != 1
        let l:useWinId = exists('*win_getid') && exists('*win_gotoid')

        if winnr() == s:QFStore.GetWindowNumber()
            call qfstore#exec("wincmd p")
            let l:activeBufOrWin = l:useWinId ? win_getid() : bufnr("")
            call qfstore#exec("wincmd p")
        else
            let l:activeBufOrWin = l:useWinId ? win_getid() : bufnr("")
        endif

        call qfstore#exec(s:QFStore.GetWindowNumber() . " wincmd w")
        close
        if l:useWinId
            call qfstore#exec("call win_gotoid(" . l:activeBufOrWin . ")")
        else
            call qfstore#exec(bufwinnr(l:activeBufOrWin) . " wincmd w")
        endif
    else
        close
    endif
endfunction

function! s:QFStore.render()
    echom 'imma render'
    call self.ui.render()
endfunction

function! s:QFStore.ExistsForTab()
  return exists('t:QFStoreBufferName')
endfunction

function! s:QFStore.GetWindowNumber()
    if exists("t:QFStoreBufferName")
        return bufwinnr(t:QFStoreBufferName)
    endif

    return -1
endfunction

function! s:QFStore.IsOpen()
    return s:QFStore.GetWindowNumber() != -1
endfunction
