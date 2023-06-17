#!/bin/bash

# install ansible
sudo apt install ansible -y

ansible-playbook main.yml -i inventory.ini --ask-become-pass

# install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version

sudo mv squashfs-root /
sudo ln -sf /squashfs-root/AppRun /usr/bin/nvim

# install nvim
if [ -d $HOME'/.config/nvim' ]; then
  mv ~/.config/nvim ~/.config/nvim.backup
  rm -rf ~/.local/share/nvim

  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
else
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
fi

# install font
mkdir ~/.local/share/fonts/
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip
unzip Hack.zip
rm Hack.zip
fc-cache -fv

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k 
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
rm $HOME/.zshrc
wget -O $HOME/.zshrc https://github.com/0xSixty6/setup-env/blob/main/oh-my-zsh/.zshrc
exec zsh

vim
