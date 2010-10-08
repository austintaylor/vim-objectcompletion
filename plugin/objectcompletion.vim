" File: objectcompletion.vim
" Author: Austin Taylor
" Version: 0.1
" License: Distributable under the same terms as Vim itself (see :help license)
" Description: Insert mode completion for {}, (), and ""

inoremap <C-X>0 <ESC>:set completefunc=ParenComplete<CR>a<C-X><C-U>
inoremap <C-X>9 <ESC>:set completefunc=ParenComplete<CR>a<C-X><C-U>
inoremap <C-X>[ <ESC>:set completefunc=BraceComplete<CR>a<C-X><C-U>
inoremap <C-X>' <ESC>:set completefunc=StringComplete<CR>a<C-X><C-U>

function! BraceComplete(findstart, base)
  return s:pair_complete('{', '{[^}]\+}', a:findstart, a:base)
endfunction

function! ParenComplete(findstart, base)
  return s:pair_complete('(', '([^)]\+)', a:findstart, a:base)
endfunction

function! StringComplete(findstart, base)
  return s:pair_complete("'\\|\"", "\"\\%([^\"]\\+\\|\\\\\"\\)\\+\"\\|'\\%([^']\\+\\|\\\\'\\)\\+'\\|\"\"\\|''", a:findstart, a:base)
endfunction

function! s:pair_complete(startpattern, matchpattern, findstart, base)
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start] !~ a:startpattern
      let start -= 1
    endwhile
    return start
  else
    let contents = join(getline(0, 1000000), "\n")
    let match = match(contents, a:matchpattern)
    let results = []
    while match > -1
      let string = matchstr(contents, a:matchpattern, match)
      if string =~ '^' . a:base
        call complete_add(string)
      endif
      call add(results, string)
      if complete_check()
        break
      endif
      let match = match(contents, a:matchpattern, match + strlen(string) + 1)
    endwhile
    return []
  endif
endfunction

