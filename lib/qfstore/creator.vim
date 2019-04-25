let s:Creator = {}
let g:QFStoreCreator = s:Creator

function! s:Creator.BufferNamePrefix()
    return 'QFStore_'
endfunction

function! s:Creator.New()
    let newCreator = copy(self)
    return newCreator
endfunction

function! s:Creator.ToggleStoreWindow()
    let creator = s:Creator.New()
    call creator.toggleStoreWindow()
endfunction

function! s:Creator.toggleStoreWindow()
    if g:QFStore.ExistsForTab()
        if !g:QFStore.IsOpen()
            call self._createStoreWindow()
            if !&hidden
                call b:QFStore.render()
            endif
            call b:QFStore.ui.restoreScreenState()
        else
            call g:QFStore.Close()
        endif
    else
        call self.createTabStore()
    endif
endfunction

function! s:Creator.CreateTabStore()
    let creator = s:Creator.New()
    call creator.createTabStore()
endfunction

function! s:Creator.createTabStore()
    if g:QFStore.ExistsForTab()
        call g:QFStore.Close()
        call self._removeStoreBufferForTab()
    endif

    call self._createStoreWindow()
    call self._createQFStore()
endfunction

function! s:Creator._createStoreWindow()
    let l:splitLocation = g:QFStoreWindowPosition ==# 'right'
        \ ? 'botright ' : 'topleft '
    let l:splitSize = g:QFStoreWindowSize

    if !g:QFStore.ExistsForTab()
        let t:QFStoreBufferName = self._nextBufferName()
        silent! execute l:splitLocation . 'vertical ' . l:splitSize . ' new'
        silent! execute 'edit ' . t:QFStoreBufferName
    else
        silent! execute l:splitLocation . 'vertical ' . l:splitSize . ' split'
        silent! execute 'buffer ' . t:QFStoreBufferName
    endif
    call self._setCommonBufferOptions()

    setlocal winfixwidth
endfunction

function! s:Creator._createQFStore()
    let b:QFStore = g:QFStore.New()
    echom exists('b:QFStore')
endfunction

function! s:Creator._nextBufferName()
    let name = s:Creator.BufferNamePrefix() . self._nextBufferNumber()
    return name
endfunction

function! s:Creator._nextBufferNumber()
    if !exists("s:Creator._nextBufNum")
        let s:Creator._nextBufNum = 1
    else
        let s:Creator._nextBufNum += 1
    endif

    return s:Creator._nextBufNum
endfunction

function! s:Creator._removeStoreBufferForTab()
    let buf = bufnr(t:QFStoreBufferName)

    if buf != -1

        if self._isBufferHidden(buf)
            exec "bwipeout " . buf
        endif

    endif

    unlet t:QFStoreBufferName
endfunction

function! s:Creator._isBufferHidden(nr)
    redir => bufs
    silent ls!
    redir END

    return bufs =~ a:nr . '..h'
endfunction

function! s:Creator._setCommonBufferOptions()
    " Options for a non-file/control buffer.
    setlocal bufhidden=hide
    setlocal buftype=nofile
    setlocal noswapfile

    " Options for controlling buffer/window appearance.
    setlocal foldcolumn=0
    setlocal foldmethod=manual
    setlocal nobuflisted
    setlocal nofoldenable
    setlocal nolist
    setlocal nospell
    setlocal nowrap
    setlocal cursorline

    setlocal filetype=qfstore
endfunction
