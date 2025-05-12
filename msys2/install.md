```bash
pacman -S git ruby

pacman -S mingw-w64-ucrt-x86_64-fzf
pacman -S mingw-w64-ucrt-x86_64-neovim

pacman -S --needed base-devel msys2-devel 
pacman -S ucrt64/mingw-w64-ucrt-x86_64-tk 
pacman -S ucrt64/mingw-w64-ucrt-x86_64-neovim
pacman -S ucrt64/mingw-w64-ucrt-x86_64-fzf 
pacman -S mingw-w64-ucrt-x86_64-gitui
pacman -S ucrt64/mingw-w64-ucrt-x86_64-jq

gem install ruby-oci8 
gem install ruby-plsql

pacman -S ucrt64/mingw-w64-ucrt-x86_64-iconv 
pacman -S ucrt64/mingw-w64-ucrt-x86_64-libxml2 
pacman -S zlib-devel 
pacman -S libiconv-devel


gem install nokogiri 
gem install rubyXL
gem install terminal-table
```



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

## zsh по умолчанию
`msys2_shell.cmd -ucrt64 -shell zsh`

## mintty
поменять тему  
в `/etc/minttyrc` или в `~/.minttyrc`
```
ForegroundColour = 230, 230, 230
BackgroundColour =  10,  10,  10
CursorColour     = 255, 165,  96
IMECursorColour  = 128, 224, 160
Black            = 70, 124, 124
BoldBlack        =  79,  79,  79
Red              = 255, 182, 176
BoldRed          = 255, 108,  96
Green            = 190, 255, 152
# BoldGreen        = 168, 255,  96
BoldGreen        = 128, 215,  96
Yellow           = 255, 255, 204
BoldYellow       = 255, 255, 182
Blue             = 181, 220, 255
BoldBlue         = 150, 203, 254
Magenta          = 255, 156, 254
BoldMagenta      = 255, 115, 253
Cyan             = 223, 223, 254
BoldCyan         = 198, 197, 254
White            = 255, 255, 255
BoldWhite        = 238, 238, 238
```
