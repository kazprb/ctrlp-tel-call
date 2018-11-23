if exists('g:loaded_ctrlp_tel_call') && g:loaded_ctrlp_tel_call
  finish
endif
let g:loaded_ctrlp_tel_call = 1

let s:tel_call_var = {
  \ 'init':   'ctrlp#tel_call#init()',
  \ 'accept': 'ctrlp#tel_call#accept',
  \ 'lname':  'tel-call',
  \ 'sname':  'tel-call',
  \ 'type':   'line',
  \ 'enter':  'ctrlp#tel_call#enter()',
  \ 'exit':   'ctrlp#tel_call#exit()',
  \ 'sort':   0,
  \ }

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:tel_call_var)
else
  let g:ctrlp_ext_vars = [s:tel_call_var]
endif

function! ctrlp#tel_call#init()
  return s:log
endfunc

function! ctrlp#tel_call#accept(mode, str)
  call ctrlp#exit()

  let hash = substitute(a:str, "^name.*number:", "", "")
  echo system('termux-telephony-call '.hash)

endfunction

" Do something before enterting ctrlp
function! ctrlp#tel_call#enter()

  let s:log = split(system('termux-contact-list | jq -r ''.[] | to_entries | map("\(.key):\(.value)") | join("\t")'''), "\n")

endfunction

" Do something after exiting ctrlp
function! ctrlp#tel_call#exit()
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#tel_call#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
