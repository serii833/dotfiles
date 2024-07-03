pacman -S git ruby fzf nvim 
pacman -S --needed base-devel msys2-devel 
pacman -S ucrt64/mingw-w64-ucrt-x86_64-tk 
pacman -S ucrt64/mingw-w64-ucrt-x86_64-neovim
pacman -S ucrt64/mingw-w64-ucrt-x86_64-fzf 
pacman -S mingw-w64-ucrt-x86_64-gitui

gem install ruby-oci8 
gem install ruby-plsql

pacman -S ucrt64/mingw-w64-ucrt-x86_64-iconv 
pacman -S ucrt64/mingw-w64-ucrt-x86_64-libxml2 
pacman -S zlib-devel 
pacman -S libiconv-devel

gem install nokogiri 
gem install rubyXL


## nvim alacrity remove extra new lines when pasting
.zshrc
```bash
export TMPDIR="/tmp"
```

create file pbpaste and make it executable
```bash
#!/bin/bash
#powershell.exe Get-Clipboard | sed 's/\r$//' | sed -z '$ s/\n$//
powershell.exe Get-Clipboard | sed 's/\r$//'
exit 0
```


```lua
vim.keymap.set("n", "<leader>p", ":r!pbpaste<CR>'.kJ")
vim.keymap.set("i", "<leader>p", ":r!pbpaste<CR>'.kJ")
vim.cmd("set shell=bash")
vim.cmd("set shellcmdflag=-c")
vim.cmd("set noshelltemp")
vim.cmd("let  $TMP='/tmp'")
```
