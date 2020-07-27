#!/bin/sh

# Loading data info.sh
source info.sh

configManual_()
{
	# Manual mode
	clear
	echo "${reset}${bold}${red}*${reset}"
	echo "${reset}${bold}${red}* Manual mode${reset}"
	echo "${reset}${bold}${red}*${reset}"
	echo " "
	echo "${reset}${bold}${white}Open tty and do it manually${reset}"
	echo " "
	echo "${reset}${bold}${red}Press any key to exit${reset}"
	read PressKey
}

locale_()
{
	# Locale config
	clear
	echo "${reset}${bold}${red}Locale${reset}"
	echo " "	
	echo "${reset}${bold}${white}< 1 > Show locale${reset}"
	echo "${reset}${bold}${white}< 2 > Define locale.gen${reset}"
	echo "${reset}${bold}${white}< 3 > Define locale.conf${reset}"
	echo "${reset}${bold}${white}< 4 > Generate locale${reset}"
	echo " "
	echo "${reset}${bold}${red}Option:${reset}"
	read Op
	case $Op in		
		1)
			clear
			cat /etc/locale.gen | less
			locale_;;
		2)
			clear
			echo "${reset}${bold}${red}locale.gen${reset}"
			echo " "
			echo "${reset}${bold}${white}Example: pt_BR.UTF-8 UTF-8${reset}"
			echo " "
			echo "${reset}${bold}${white}Type it:${reset}"
			read llang
			echo "$llang" > /etc/locale.gen
			locale_;;
		3)
			clear
			echo "${reset}${bold}${red}locale.conf${reset}"
			echo " "
			echo "${reset}${bold}${white}Example: LANG=pt_BR.UTF-8${reset}"
			echo " "
			echo "${reset}${bold}${white}Type it:${reset}"
			read lang
			echo "$lang" > /etc/locale.conf
			locale_;;
		4)
			locale-gen
			zoneinfo_;;
		*)
			locale_;;
	esac
}

zoneinfo_()
{
	# Zoneinfo config
	zoner_()
	{
		clear
		echo " "
		echo "${reset}${bold}${white}< 1 > Show city${reset}"
		echo "${reset}${bold}${white}< 2 > Define city${reset}"
		echo " "
		echo "${reset}${bold}${red}Option:${reset}"
		read Op
		case $Op in
			1)
				clear
				ls /usr/share/zoneinfo/$zregion | less
				zoner_;;
			2)
				clear
				echo "${reset}${bold}${red}City${reset}"
				echo " "
				echo "${reset}${bold}${white}Example: Sao_Paulo${reset}"
				echo " "
				echo "${reset}${bold}${white}Type it:${reset}"
				read zcity
				ln -sf /usr/share/zoneinfo/$zregion/$zcity /etc/localtime
				timedatectl set-ntp true
				hwclock --systohc
				clear
				echo "${reset}${bold}${white}Example:${reset}${bold}${red} Sorry${reset}"
				echo " "
				echo "${reset}${bold}${white}Hostname:${reset}"
				read hostname
				echo "$hostname" > /etc/hostname
				echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\tlocalhost\t$hostname" > /etc/hosts
				mkinitcpio -P
				grub_;;
			*)
				zoner_;;
		esac
	}
	clear
	echo " "
	echo "${reset}${bold}${white}< 1 > Show region${reset}"
	echo "${reset}${bold}${white}< 2 > Define region${reset}"
	echo " "
	echo "${reset}${bold}${red}Option:${reset}"
	read Op
	case $Op in
		1)
			clear
			ls /usr/share/zoneinfo/ | less
			zoneinfo_;;
		2)
			clear
			echo "${reset}${bold}${red}Region${reset}"
			echo " "
			echo "${reset}${bold}${white}Example: America${reset}"
			echo " "
			echo "${reset}${bold}${white}Type it:${reset}"
			read zregion
			zoner_;;
		*)
			zoneinfo_;;
	esac
}

grub_()
{	
	clear
	echo " "
	echo "${reset}${bold}${white}< 1 > Manual mode${reset}"
	echo "${reset}${bold}${white}< 2 > Grub${reset}"
	echo " "
	echo "${reset}${bold}${red}Option:${reset}"
	read Op
	pacman -Syu --noconfirm
	case $Op in
		1)
			configManual_
			configDefault_;;
		2)
			pacman -S grub --noconfirm
			grub-install /dev/sda
			grub-mkconfig -o /boot/grub/grub.cfg
			configDefault_;;
		*)
			grub_;;
	esac
}
userinfo_()
{
	clear
	echo "${reset}${bold}${red}*${reset}"
	echo "${reset}${bold}${red}* Do it manually${reset}"
	echo "${reset}${bold}${red}*${reset}"
	echo " "
	echo "${reset}${bold}${red}Create a password for root${reset}"
	echo "${reset}${bold}${white}Using the command${reset}"
	echo "${reset}${bold}${white}passwd${reset}"
	echo " "
	echo "${reset}${bold}${red}If you want to create a user${reset}"
	echo "${reset}${bold}${white}Using the command${reset}"
	echo "${reset}${bold}${white}Example: useradd -m sorry${reset}"
	echo "${reset}${bold}${white}Example: passwd sorry${reset}"
	echo " "
	echo "${reset}${bold}${red}restart your computer${reset}"
	echo " "
	echo " "
	echo "${reset}${bold}${white}< 1 > Finish the installation${reset}"
	echo " "
	echo "${reset}${bold}${red}Option:${reset}"
	read Op
	case $Op in
		1)
			clear;;
		*)
			userinfo_;;
	esac
}

configDefault_()
{
	pacman -S nano --noconfirm
	pacman -S sudo --noconfirm
	pacman -S xdg-user-dirs --noconfirm
	pacman -S xf86-input-synaptics xf86-input-libinput wireless_tools wpa_supplicant acpi acpid --noconfirm
	pacman -S networkmanager network-manager-applet net-tools dialog --noconfirm
	pacman -S alsa-lib alsa-utils --noconfirm
	pacman -S ttf-{bitstream-vera,liberation,freefont,dejavu} freetype2 --noconfirm
	systemctl enable NetworkManager
	systemctl enable dhcpcd
	userinfo_
}

locale_
