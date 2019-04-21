let s:Creator = {}
let g:QFStoreCreator = s:Creator

function! s:Creator.New()
    let newCreator = copy(self)
    return newCreator
endfunction

function! s:Creator.ToggleStoreWindow()
    let creator = s:Creator.New()
    call creator.toggleStoreWindow()
endfunction

function! s:Creator.BufferNamePrefix()
    return 'QFStore_'
endfunction

function! s:Creator.toggleStoreWindow()
    call self._createStoreWindow()
    return
    if g:QFStore.ExistsForTab()
        if !g:QFStore.IsOpen()
            call self._createStoreWindow()
            if !&hidden
                call b:NERDTree.render()
            endif
            call b:NERDTree.ui.restoreScreenState()
        else
            call g:NERDTree.Close()
        endif
    else
        call self.createTabTree(a:dir)
    endif
endfunction

function! s:Creator._createStoreWindow()
    let l:splitLocation = g:QFStore_windowPosition ==# 'right'
        \ ? 'botright ' : 'topleft '
    let l:splitSize = g:QFStore_windowSize

    let t:QFStore_bufferName = self._nextBufferName()
    silent! execute l:splitLocation . 'vertical ' . l:splitSize . ' new'
    silent! execute 'edit ' . t:NERDTreeBufName

    call self._setCommonBufferOptions()

    setlocal winfixwidth
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
