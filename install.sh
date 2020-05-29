#!/usr/bin/env bash
install_oh_my_zsh() {
  echo "Setting up zsh..." \
    && rm -rf ~/.zshrc ~/.oh-my-zsh \
    && ln -s $(pwd)/zsh/zshrc ~/.zshrc \
    && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
    && chsh -s /bin/zsh \
    && git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting \
    && ln -s $(pwd)/zsh/themes/* ~/.oh-my-zsh/custom/themes \
    && rm -rf ~/z.sh \
    && curl -fLo ~/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh
}

install_neovim() {
  echo "Setting up neovim..." \
    && sudo pacman -S neovim \
    && rm -rf ~/.config/nvim $(pwd)/nvim/pack ~/.fzf \
    && ln -s $(pwd)/nvim ~/.config/nvim \
    && git clone https://github.com/kristijanhusak/vim-packager.git ~/.config/nvim/pack/packager/opt/vim-packager \
    && nvim -c 'PackagerInstall'
}

install_tools() {
  echo "Installing ripgrep..." \
    && sudo pacman -S ripgrep ctags nvm \
    && echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc
}


install_diff_so_fancy() {
  echo "Installing diff-so-fancy..." \
    && npm install -g diff-so-fancy \
    && git config --global core.pager "diff-so-fancy | less --tabs=4 -R"
}

install_kitty() {
  echo "Installing kitty..." \
    && rm -rf ~/.local/kitty.app ~/.config/kitty \
    && sudo pacman -S kitty \
    && ln -s $(pwd)/kitty ~/.config/kitty
}

install_i3() {
  rm -rf ~/.i3 \
    && yay -S kbdd-git \
    && sudo pacman -S sysstat yad i3blocks \
    && ln -s $(pwd)/i3 ~/.i3
}

install_pyenv(){
    echo "Installing pyenv..." \
      && curl https://pyenv.run | bash \
      && echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc \
      && echo 'eval "$(pyenv init -)"' >> ~/.zshrc \
      && echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc \
      && source ~/.zshrc \
      && pyenv install miniconda3-latest
}

if [[ -z $1 ]]; then
  echo -n "This will delete all your previous nvim, zsh settings. Proceed? (y/n)? "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    echo "Installing dependencies..." \
      && install_i3 \
      && install_oh_my_zsh \
      && install_tools \
      && install_neovim \
      && install_diff_so_fancy \
      && install_kitty \
      && install_pyenv \
      && echo "Finished installation."
  fi
else
  "install_$1" $1
fi
