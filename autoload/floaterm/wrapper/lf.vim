function! floaterm#wrapper#lf#(cmd, jobopts, config) abort
  let w:lf_last_dir = tempname()
  let w:lf_vim_cb = tempname()
  let env = {
    \'LF_LAST_DIR': w:lf_last_dir,
    \'LF_VIM_CB': w:lf_vim_cb,
  \}
  let job_env = get(a:jobopts, 'env', {})
  call extend(job_env, env)
  let a:jobopts['env'] = job_env

  let a:jobopts.on_exit = funcref('s:lf_callback', [w:lf_last_dir, w:lf_vim_cb])
  return [v:false, get(g:, 'lf_cmd', 'lf')]
endfunction

function! s:lf_callback(last_dir, vim_cb, ...) abort
  if filereadable(a:last_dir)
    let l:content = readfile(a:last_dir, '', 1)
    if (!empty(l:content))
      let l:dir = l:content[0]
      if l:dir != getcwd()
        execute get(g:, 'lf_vim_cd', 'lcd') l:dir
        pwd
      endif
    end
  endif

  if filereadable(a:vim_cb)
    execute 'source' fnameescape(a:vim_cb)
  endif
endfunction

