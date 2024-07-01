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