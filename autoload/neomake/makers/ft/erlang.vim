
function! neomake#makers#ft#erlang#EnabledMakers() abort
    return ['rebar3_erlc']
endfunction

function! neomake#makers#ft#erlang#erlc() abort
    return {
        \ 'errorformat':
            \ '%W%f:%l: Warning: %m,' .
            \ '%E%f:%l: %m'
        \ }
endfunction

if !exists("g:rebar3_command")
    let g:rebar3_command = "rebar3"
endif

function! neomake#makers#ft#erlang#rebar3_erlc() abort
    return {
        \ 'exe': 'erlc',
        \ 'args': function("neomake#makers#ft#erlang#rebar3_paths"),
        \ 'errorformat':
            \ '%W%f:%l: Warning: %m,' .
            \ '%E%f:%l: %m'
        \ }
endfunction

function! neomake#makers#ft#erlang#rebar3_paths() abort
    if match(expand('%'), "SUITE.erl$") > -1
        let l:maybe_profile = "as test"
    else
        let l:maybe_profile = ""
    endif
    let l:ebins = split(system(g:rebar3_command . " " . l:maybe_profile . " path"), " ")
    let l:args = []
    for ebin in ebins
        call add(l:args, '-pa')
        call add(l:args, ebin)
        call add(l:args, '-I')
        call add(l:args, substitute(ebin, "ebin$", "include", ""))
    endfor
    call add(l:args, '-o')
    call add(l:args, '_build/neomake')
    return l:args
endfunction
