#!/bin/bash

loadkeys ru
setfont cyr-sun16

echo 'Синхронизация системных часов'
timedatectl set-ntp true

echo 'Форматирование дисков'

fdisk -l

cfdisk

read -p 'Set efi patrition: ' uservar
mkfs.fat -F32 $uservar
read -p 'Set Home patrition: ' home
mkfs.ext4  $home
# mkfs.ext4  /dev/sdc3

echo 'Монтирование дисков'
mount /dev/sda2 /mnt
# mkdir /mnt/home
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
# mount /dev/sdc3 /mnt/home

echo 'Выбор зеркал для загрузки.'
rm -rf /etc/pacman.d/mirrorlist
curl "https://archlinux.org/mirrorlist/?country=RU&protocol=http&protocol=https&ip_version=4" -o mirrorlist

tr -d "#" < ~/mirrorlist | grep Server >> /etc/pacman.d/mirrorlist

echo 'Установка основных пакетов'
pacman -Sy archlinux-keyring -y
pacstrap /mnt base base-devel linux linux-firmware dhcpcd netctl -y

echo 'Настройка системы'
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt sh -c "$(curl -fsSL https://raw.githubusercontent.com/barbosso/arch/main/archuefi2.sh)"
