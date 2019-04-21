let s:QFStore = {}
let g:QFStore = s:QFStore

function! s:QFStore.ExistsForTab()
  return exists('t:QFStore_bufferName')
endfunction

function! s:QFStore.GetWindowNumber()
    if exists("t:QFStore_bufferName")
        return bufwinnr(t:QFStore_bufferName)
    endif

    return -1
endfunction

function! s:QFStore.IsOpen()
    return s:QFStore.getWindowNumber() != -1
endfunction
