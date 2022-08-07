#!/bin/bash

echo "exec i3" > .xinitrc
chmod +x .xinitrc
curl https://raw.githubusercontent.com/barbosso/arch/main/.zprofile -o .zprofile
git clone https://github.com/barbosso/doti3poly.git
cp -r doti3poly/.config .config
cp doti3poly/.zshrc .zshrc