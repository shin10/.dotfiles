# Dotfiles

```bash
sudo apt update && sudo apt install stow

git clone https://github.com/shin10/.dotfiles.git ~/.dotfiles
for i in .gitconfig .tmux.conf .zshrc; do [ -f ~/$i ] && mv --backup=numbered ~/$i ~/$i.pre-dotfiles; done
cd ~/.dotfiles && stow git tmux zsh

$(
  cd ~/.dotfiles && \
  git remote rm origin && \
  git remote add origin git@github.com:$(git config --get github.user)/.dotfiles.git && \
  git push -u origin main
)

```
