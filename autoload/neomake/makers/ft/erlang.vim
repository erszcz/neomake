
function! neomake#makers#ft#erlang#EnabledMakers() abort
    return ['history_erlc']
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
