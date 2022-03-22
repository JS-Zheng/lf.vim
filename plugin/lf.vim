if (exists('g:loaded_lf_vim'))
  finish
endif

let g:loaded_lf_vim = 1

command! -nargs=* -complete=customlist,floaterm#cmdline#complete -bang -range
  \ LF call floaterm#run('new', <bang>0, [visualmode(), <range>, <line1>, <line2>],
  \ ' --width=' . string(get(g:, 'lf_width', get(g:, 'floaterm_width', 0.7))) .
  \ ' --height=' . string(get(g:, 'lf_height', get(g:, 'floaterm_height', 0.7))) .
  \ ' ' . <q-args> .
  \ ' lf')

