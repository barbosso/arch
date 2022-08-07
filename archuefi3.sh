#!/bin/bash

echo "exec i3" > .xinitrc
chmod +x .xinitrc
curl https://raw.githubusercontent.com/barbosso/arch/main/.zprofile -o .zprofile
git clone https://github.com/barbosso/doti3poly.git
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
cp -r doti3poly/.config .config
cp doti3poly/.zshrc .zshrc