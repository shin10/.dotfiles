# Dotfiles

# WSL migration

```bash
wsl.exe --version
wsl.exe --update


wsl.exe --list -o


export DISTRO=ubuntu-22.04
export USER=$(whoami)


wsl.exe --install $DISTRO --no-launch

( cat <<- EOM

  useradd -m -s /bin/bash $USER &&
  passwd shin10 &&
  usermod -a -G sudo $USER

  echo '[user]\ndefault=$USER' | sudo tee -a /etc/wsl.conf

  tar -xzvf /home/$USER/ssh.tgz /home/$USER/
  rm /home/$USER/ssh.tgz 

EOM
) | wsl.exe -d $DISTRO --user root --cd "/root" -- sh


cd ~ && sudo tar -czvf /mnt/c/tmp/ssh.tgz ./.ssh/
wsl.exe -d $DISTRO --user root --cd "/home/$USER" -- sh -c "mv /mnt/c/tmp/ssh.tgz ssh.tgz && tar -xzvf ssh.tgz; rm ssh.tgz || rm /mnt/c/tmp/ssh.tgz"


# $DISTRO.exe config --default-user $USER
#($(echo $DISTRO | sed -r 's/[.-]//g').exe) config --default-user $USER




cd ~ && sudo tar -czvf /mnt/c/tmp/workspaceWSL.tgz --wildcards --exclude="**/node_modules/*" ./workspaceWSL/
wsl.exe -d $DISTRO --cd "/home/$USER" -- sh -c "mv /mnt/c/tmp/workspaceWSL.tgz workspaceWSL.tgz && tar -xzvf workspaceWSL.tgz; rm workspaceWSL.tgz || rm /mnt/c/tmp/workspaceWSL.tgz"



cd ~ && sudo tar -czvf /mnt/c/tmp/workspaceWSL2.tgz --wildcards --exclude="**/node_modules/*" ./workspaceWSL2/
wsl.exe -d $DISTRO --cd "/home/$USER" -- sh -c "mv /mnt/c/tmp/workspaceWSL2.tgz workspaceWSL2.tgz && tar -xzvf workspaceWSL2.tgz; rm workspaceWSL2.tgz || rm /mnt/c/tmp/workspaceWSL2.tgz"




wsl.exe --set-default $DISTRO

```




```bash
sudo locale-gen de_DE.UTF-8

sudo apt update && sudo apt upgrade -y && sudo apt install -y stow ansible zsh && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# zsh plugins
sudo apt install -y autojump

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

sudo apt update
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt install -y eza
git clone https://github.com/shin10/zsh-aliases-eza.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-aliases-eza


git clone https://github.com/so-fancy/diff-so-fancy.git ~/.diff-so-fancy

git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

sudo apt install -y fzf
plugin 'fzf-tab'


git clone https://github.com/shin10/.dotfiles.git ~/.dotfiles
for i in .gitconfig .tmux.conf .zshrc; do [ -f ~/$i ] && mv --backup=numbered ~/$i ~/$i.pre-dotfiles; done
cd ~/.dotfiles && stow git nano tmux zsh

$(
  cd ~/.dotfiles && \
  git remote rm origin && \
  git remote add origin git@github.com:$(git config --get github.user)/.dotfiles.git && \
  git push -u origin main
)

```
