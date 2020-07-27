#!/bin/sh

# Loading data info.sh
source info.sh

keyboardinfo_()
{
	clear
	echo "${reset}${bold}${red}*${reset}"
	echo "${reset}${bold}${red}* Do it manually${reset}"
	echo "${reset}${bold}${red}*${reset}"
	echo " "
	echo "${reset}${bold}${red}Export the language${reset}"
	echo "${reset}${bold}${white}Using the command${reset}"
	echo "${reset}${bold}${white}Example: export LANG=pt_BR.UTF-8${reset}"
	echo " "
	echo "${reset}${bold}${red}Set standard keyboard${reset}"
	echo "${reset}${bold}${white}Using the command${reset}"
	echo "${reset}${bold}${white}Example: localectl set-x11-keymap br abnt2${reset}"
	echo " "
	echo "${reset}${bold}${red}If useradd -m is not creating the files for home${reset}"
	echo "${reset}${bold}${white}Using the command${reset}"
	echo "${reset}${bold}${white}xdg-user-dirs-update${reset}"
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
			keyboardinfo_;;
	esac
}

gextr_()
{
	clear
	echo "${reset}${bold}${red}Gnome extra${reset}"
	echo " "
	echo "${reset}${bold}${white}< 1 > To install${reset}"
	echo "${reset}${bold}${white}< 2 > Don't install${reset}"
	echo " "
	echo "${reset}${bold}${red}Option:${reset}"
	read Op
	case $Op in
		1)
			pacman gnome-extra --noconfirm;;
		2)
			clear;;
		*)
			gextr_;;
	esac
}

gnome_()
{
	clear
	echo "${reset}${bold}${red}*${reset}"
	echo "${reset}${bold}${red}* Graphical interface installation${reset}"
	echo "${reset}${bold}${red}* By default: Gnome${reset}"
	echo "${reset}${bold}${red}*${reset}"
	echo " "
	echo "${reset}${bold}${white}< 1 > Install gnome${reset}"
	echo "${reset}${bold}${white}< 2 > Install another one manually${reset}"
	echo " "
	echo "${reset}${bold}${red}Option:${reset}"
	read Op
	case $Op in
		1)
			gextr_
			pacman -S xorg-xinit xorg-server xorg-drivers --noconfirm
			pacman -S gnome-shell nautilus gnome-terminal gnome-tweak-tool gnome-control-center gdm --noconfirm
			systemctl enable gdm
			keyboardinfo_;;
		2)
			keyboardinfo_;;
		*)
			gnome_;;
	esac
}

drivers_()
{
	clear
	echo "${reset}${bold}${red}Graphics drivers${reset}"
	echo " "
	echo "${reset}${bold}${white}< 1 > Show vga${reset}"
	echo "${reset}${bold}${white}< 2 > Amd${reset}"
	echo "${reset}${bold}${white}< 3 > Intel${reset}"
	echo "${reset}${bold}${white}< 4 > Nvidia${reset}"
	echo "${reset}${bold}${white}< 5 > Don't install${reset}"
	echo " "
	echo "${reset}${bold}${red}Option:${reset}"
	read Op
	case $Op in
		1)
			clear
			lspci -k | grep -A 2 -i "VGA" | less
			drivers_;;
		2)
			pacman -S xf86-video-amdgpu --noconfirm
			gnome_;;
		3)
			pacman -S xf86-video-intel --noconfirm
			gnome_;;
		4)
			pacman -S xf86-video-nouveau --noconfirm
			gnome_;;
		5)
			gnome_;;
		*)
			drivers_;;
	esac
}

drivers_
