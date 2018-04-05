
function! neomake#makers#ft#erlang#EnabledMakers() abort
    return ['rebar3_erlc']
endfunction

function! neomake#makers#ft#erlang#erlc() abort
    return {
        \ 'exe': 'erlc',
        \ 'errorformat':
            \ '%W%f:%l: Warning: %m,' .
            \ '%E%f:%l: %m'
        \ }
endfunction

function! neomake#makers#ft#erlang#history_erlc() abort
    return {
        \ 'exe': 'erlc',
        \ 'args': ['-I',  './_build/default/lib/cqerl/include',
        \          '-pa', './_build/default/lib/cqerl/ebin',
        \          '-I',  './_build/default/lib/fast_xml/include',
        \          '-pa', './_build/default/lib/fast_xml/ebin',
        \          '-pa', './_build/default/lib/exml/ebin',
        \          '-pa', './_build/default/lib/exml/include',
        \          '-pa', './_build/test/lib/escalus/ebin',
        \          '-pa', './_build/test/lib/escalus/include',
        \          '-I',  './_build/default/lib/snatch/include',
        \          '-pa', './_build/default/lib/snatch/ebin',
        \          '-I',  './deps.local/xmpp/include',
        \          '-pa', './deps.local/xmpp/ebin',
        \          '-o',  './_build/neomake'],
        \ 'errorformat':
        \     '%W%f:%l: Warning: %m,' .
        \     '%E%f:%l: %m'
        \ }
endfunction

function! neomake#makers#ft#erlang#rebar3_erlc() abort
    return {
        \ 'exe': 'erlc',
        \ 'args': function("neomake#makers#ft#erlang#rebar3_glob_paths"),
        \ 'errorformat':
            \ '%W%f:%l: Warning: %m,' .
            \ '%E%f:%l: %m'
        \ }
endfunction

function! neomake#makers#ft#erlang#rebar3_glob_paths() abort
    if match(expand('%'), "SUITE.erl$") > -1
        let l:profile = "test"
    else
        let l:profile = "default"
    endif
    let l:ebins = glob("_build/" . l:profile . "/lib/*/ebin", "", 1)
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
