#!/bin/bash

echo "------ install ansible -------------"
# install ansible
sudo apt install ansible -y

ansible-playbook main.yml -i inventory.ini --ask-become-pass

echo "--------- install neovim --------------"
# install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version

sudo mv squashfs-root /
sudo ln -sf /squashfs-root/AppRun /usr/bin/nvim

echo "------ install nvim ----------"
# install nvim
if [ -d $HOME'/.config/nvim' ]; then
  mv ~/.config/nvim ~/.config/nvim.backup
  rm -rf ~/.local/share/nvim

  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
else
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
fi

echo "------ Install font ------------"
# install font
mkdir $HOME/.local/share/fonts/Hack.zip
wget -o $HOME/.local/share/fonts/ https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip
unzip Hack.zip
rm Hack.zip
fc-cache -fv

echo "--------- Install zsh shell"
# install zsh
sudo apt-get install zsh -y
#change shell
chsh -s /usr/bin/zsh

echo "--------- oh-my-zsh ----------"
# install oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k 
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
wget -O $HOME/.zshrc https://raw.githubusercontent.com/0xSixty6/setup-env/main/oh-my-zsh/.zshrc
rm $HOME/.zshrc
mv $HOME/.zshrc.1 $HOME/.zshrc
exec zsh

vim
