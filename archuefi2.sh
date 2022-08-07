#!/bin/bash
read -p "Введите имя компьютера: " hostname
read -p "Введите имя пользователя: " username

echo 'Прописываем имя компьютера'
echo $hostname > /etc/hostname
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

echo 'Добавляем русскую локаль системы'
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen 

echo 'Обновим текущую локаль системы'
locale-gen

echo 'Указываем язык системы'
echo 'LANG="en_US.UTF-8"' > /etc/locale.conf

echo 'Вписываем KEYMAP=ru FONT=ter-v16n'
echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=ter-v16n' >> /etc/vconsole.conf

echo 'Создадим загрузочный RAM диск'
mkinitcpio -p linux

echo 'Устанавливаем загрузчик'
pacman -Syy
pacman -S grub efibootmgr amd-ucode --noconfirm 
grub-install /dev/sda

echo 'Обновляем grub.cfg'
grub-mkconfig -o /boot/grub/grub.cfg

# echo 'Ставим программу для Wi-fi'
# pacman -S dialog wpa_supplicant --noconfirm 
pacman -S nano zsh terminus-font wget

echo 'Добавляем пользователя'
useradd -m -g users -G wheel -s /bin/zsh $username

echo 'Создаем root пароль'
passwd

echo 'Устанавливаем пароль пользователя'
passwd $username

echo 'Устанавливаем SUDO'
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

echo 'Раскомментируем репозиторий multilib Для работы 32-битных приложений в 64-битной системе.'
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
pacman -Syy

echo 'Ставим иксы и драйвера'

# pacman -S wayland sway foot waybar wofi qt5-wayland glfw-wayland gdm git
# systemctl enable gdm

sudo pacman -S xorg-server xorg-xinit i3-gaps rofi polybar picom feh terminator networkmanager network-manager-applet git
curl https://raw.githubusercontent.com/barbosso/arch/main/archuefi3.sh -o /home/$username/archuefi3.sh

echo 'Установка завершена! Перезагрузите систему.'
exit
