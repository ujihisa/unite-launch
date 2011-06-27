let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
      \ 'name': 'launch',
      \ }

function! s:unite_source.gather_candidates(args, context)
  return map(g:unite_launch_apps, '{
        \ "word": v:key . " " . v:val,
        \ "source": "launch",
        \ "kind": "command",
        \ "action__command": "QuickRun -exec " . string(v:val),
        \ }')
endfunction

function! unite#sources#launch#define()
  if !exists('g:unite_launch_apps')
    call unite#util#print_error('g:unite_launch_apps not defined')
    " NOTE: It just shows a warning; not finishes immediately.
    let g:unite_launch_apps = ['ls', 'make', 'rake', 'echo "this is an example"']
  endif
  let has_quickrun = 1 " FIXME
  return has_quickrun ? s:unite_source : []
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
