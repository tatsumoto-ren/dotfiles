" Auto Fcitx
" https://wiki.archlinux.org/title/Fcitx#Vim
let g:input_toggle = 1
function! FcitxDisable()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! FcitxEnable()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set ttimeoutlen=150
"Exit insert mode
autocmd InsertLeave * call FcitxDisable()
"Enter insert mode
autocmd InsertEnter * call FcitxEnable()
