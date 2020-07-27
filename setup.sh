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

keyboard_()
{
	# Keyboard
	clear
	echo "${reset}${bold}${red}Define the keyboard layout${reset}"
	echo " "
	echo "${reset}${bold}${white}< 1 > Show keyboard${reset}"
	echo "${reset}${bold}${white}< 2 > Define keyboard${reset}"
	echo "${reset}${bold}${white}< 3 > Manual mode${reset}"
	echo " "
	echo "${reset}${bold}${red}Option:${reset}"
	read Op
	case $Op in
		1)
			ls /usr/share/kbd/keymaps/**/*.map.gz | less
			keyboard_;;
		2)
			clear
			echo "${reset}${bold}${red}Define keyboard${reset}"
			echo " "
			echo "${reset}${bold}${white}Example: br-abnt2${reset}"
			echo " "
			echo "${reset}${bold}${white}loadkeys:${reset}"
			read keyboard
			loadkeys $keyboard
			partitionDisks_;;
		3)
			configManual_
			partitionDisks_;;
		*)
			keyboard_;;
	esac
}

information_()
{
	# Information
	clear
	echo "${reset}${red}*${reset}"
	echo "${reset}${red}*${reset}${bold}${white} Information${reset}"
	echo "${reset}${red}*${reset}"
	echo " "
	echo "${reset}${red}*${reset}${bold}${white} Automatic${reset}"
	echo "${reset}${bold}${white}Must have 4 partitions${reset}"
	echo "${reset}${bold}${white}boot, home, /, swap${reset}"
	echo "${reset}${bold}${white}boot, home, / are of type ext4 by default${reset}"
	echo ""
	echo "${reset}${red}*${reset}${bold}${white} Manual${reset}"
	echo "${reset}${bold}${white}you must create partitions and mounts manually${reset}"
	echo ""
	echo "${reset}${bold}${red}Press any key to exit${reset}"
	read Op
}

fmPartitions_()
{
	# Format and mount partitions
	cfe_()
	{
		# Some config
		clear
		fdisk -l
		echo " "
		echo "${reset}${bold}${white}/dev/sd${reset}"
	}

	cfe_
	echo "${reset}${bold}${white}/boot${reset}"
	echo " "
	echo "${reset}${bold}${white}Type it:${reset}"
	read boot
	echo " "
	echo "${reset}${bold}${white}Type Default: ext4${reset}"
	echo "${reset}${bold}${white}Type it:${reset}"
	read typeboot

	cfe_
	echo "${reset}${bold}${white}/home${reset}"
	echo " "
	echo "${reset}${bold}${white}Type it:${reset}"
	read home
	echo " "
	echo "${reset}${bold}${white}Type Default: ext4${reset}"
	echo "${reset}${bold}${white}Type it:${reset}"
	read typehome
	
	cfe_
	echo "${reset}${bold}${white}/${reset}"
	echo " "
	echo "${reset}${bold}${white}Type it:${reset}"
	read local
	echo " "
	echo "${reset}${bold}${white}Type Default: ext4${reset}"
	echo "${reset}${bold}${white}Type it:${reset}"
	read typelocal

	cfe_
	echo "${reset}${bold}${white}Swap${reset}"
	echo " "
	echo "${reset}${bold}${white}Type it:${reset}"
	read swap

	clear
	echo "${reset}${bold}${red}Partitioning${reset}"
	echo " "
	echo "${reset}${bold}${white}Boot: $boot${}"
	echo "${reset}${bold}${white}Home: $home${}"
	echo "${reset}${bold}${white}/   : $local${}"
	echo "${reset}${bold}${white}Swap: $swap${}"
	echo " "
	echo "${reset}${bold}${white}Type ${reset}${bold}${red}1${reset}${bold}${white} to continue${reset}"
	echo "${reset}${bold}${white}Type any key to go back${reset}"
	read Op
	case $Op in
		1)
			mkswap $swap
			swapon $swap

			mkfs.$typeboot $boot
			mkfs.$typehome $home	
			mkfs.$typelocal $local

			mount $local /mnt
			mkdir /mnt/boot
			mkdir /mnt/home
			mount $boot /mnt/boot
			mount $home /mnt/home;;
		*)
			partitionDisks_;;
	esac
}

partitionDisks_()
{
	# Partition Disks
	clear
	# Default sd
	sd=/dev/sda

	echo "${reset}${bold}${red}Disk partitions${reset}"
	echo " "
	echo "${reset}${bold}${white}< 1 > Information${reset}"
	echo "${reset}${bold}${white}< 2 > fdisk -l${reset}"
	echo "${reset}${bold}${white}< 3 > cfdisk${reset}"
	echo "${reset}${bold}${white}< 4 > Format and mount partitions${reset}"
	echo "${reset}${bold}${white}< 5 > Manual mode${reset}"
	echo "${reset}${bold}${white}< 6 > Come back${reset}"
	echo " "
	echo "${reset}${bold}${red}Option:${reset}"	
	read Op
	case $Op in
		1)
			information_
			partitionDisks_;;
		2)
			clear
			fdisk -l | less
			partitionDisks_;;
		3)
			clear
			echo "${reset}${bold}${red}Inform which /dev/sd${reset}"
			echo " "
			echo "${reset}${bold}${white}Example: sda ​​sdb sdc${reset}"
			echo " "
			echo "${reset}${bold}${white}If you leave it blank${reset}"
			echo "${reset}${bold}${white}default: /dev/sda${reset}"
			echo " "
			echo "${reset}${bold}${white}Type it:${reset}"
			read sd
			cfdisk $sd
			partitionDisks_;;
		4)
			fmPartitions_
			pacgen_;;
			
		5)
			configManual_
			pacgen_;;
		6)
			keyboard_;;
		*)
			partitionDisks_;;
	esac
}

chroot_()
{
	# Info
	clear
	echo "${reset}${bold}${red}*${reset}"
	echo "${reset}${bold}${red}* Do it manually${reset}"
	echo "${reset}${bold}${red}*${reset}"
	echo " "
	echo "${reset}${bold}${red}Moving the installation folder${reset}"
	echo "${reset}${bold}${white}Move the ArchLinux folder to /mnt${reset}"
	echo " "
	echo "${reset}${bold}${red}Change the root to a new system${reset}"
	echo "${reset}${bold}${white}Using the command${reset}"
	echo "${reset}${bold}${white}arch-chroot /mnt${reset}"
	echo " "
	echo "${reset}${bold}${red}Calling setup 2${reset}"
	echo "${reset}${bold}${white}Using the command${reset}"
	echo "${reset}${bold}${white}source setup2.sh${reset}"
	echo " "
	echo " "
	echo "${reset}${bold}${red}< 1 > Finish the installation${reset}"
	echo "${reset}${bold}${white}< 2 > Come back${reset}"
	echo " "
	echo "${reset}${bold}${red}Option:${reset}"
	read Op
	case $Op in
		1)
			clear;;
		2)
			pacgen_;;
		*)
			chroot_;;
	esac
}

pacgen_()
{
	# Pacstrap and Genfstab
	clear
	echo " "
	echo "${reset}${bold}${white}< 1 > pacstrap and genfstab${reset}"
	echo "${reset}${bold}${white}< 2 > Manual mode${reset}"
	echo "${reset}${bold}${white}< 3 > Come back${reset}"
	echo " "
	echo "${reset}${bold}${red}Option:${reset}"
	read Op
	case $Op in
		1)
			clear
			pacstrap /mnt base linux linux-firmware
			genfstab -U /mnt >> /mnt/etc/fstab
			echo "KEYMAP=$keyboard" > /mnt/etc/vconsole.conf 
			chroot_;;
		2)
			configManual_
			chroot_;;
		3)
			partitionDisks_;;
		*)
			pacgen_;;
	esac
}

keyboard_
