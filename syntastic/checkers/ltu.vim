
if exists("g:loaded_syntastic_python_ltu_checker")
    finish
endif
let g:loaded_syntastic_python_ltu_checker = 1
let g:syntastic_python_ltu_exec = '/usr/local/bin/ltu-style-check'

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_python_ltu_GetLocList() dict
    let makeprg = self.makeprgBuild({})

    let errorformat = '%f:%l:%c: %m'

    let env = syntastic#util#isRunningWindows() ? {} : { 'TERM': 'dumb' }

    let loclist = SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'env': env,
        \ 'subtype': 'Style' })

    for e in loclist
        let e['type'] = e['text'] =~? '^W' ? 'W' : 'E'
    endfor

    return loclist
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'python',
    \ 'name': 'ltu'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sts=4 sw=4:
