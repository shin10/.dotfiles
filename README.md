# Dotfiles

```bash
git clone git@github.com:shin10/.dotfiles.git ~/.dotfiles
for i in .gitconfig .zshrc; do [ -f ~/$i ] && mv --backup=numbered ~/$i ~/$i.pre-dotfiles; done
cd ~/.dotfiles && stow git zsh
```
