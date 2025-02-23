 #!/usr/bin/env bash
# Desenvolvido pelo William Santos
# contato: thespation@gmail.com ou https://github.com/thespation
# Traducido y modificado por: Alejandro Fermín https://github.com/lostalejandro

clear
##--------------------------------Funciones utilizadas en el script--------------------------------##
#--Identificar Distribución--#
declare -f VERIF_DISTRIB
function VERIF_DISTRIB()
{	
			ACTUALIZAR
			BSPWM
			KSUPERKEY
			I3LOCK
			ALACC
			ZSH
			PICOM
			APPS
			APPS_XFCE
			PERSONA
			sleep 2s
            echo "La instalacion inciara en 2 diassssss:)"
}

#--Función: Actualizar sistema (base Debian)--#
declare -f ACTUALIZAR
function ACTUALIZAR(){
			echo "#-----------------------------Actualizar sistema-------------------------------#"
				sudo apt update &&
			echo "#--------------------------Repositorios actualizados---------------------------#"
			sleep 1s
				sudo apt upgrade -y &&
			echo "#---------------------------Programas actualizados-----------------------------#"
			sleep 1s

			sudo apt dist-upgrade -y && sudo apt autoclean && sudo apt autoremove -y &&
				clear &&
			echo "#-----------------------------Sistema actualizado------------------------------#"
				sleep 5s
		}

			
#--Función: Instalar base BSPWM--#
declare -f BSPWM
function BSPWM()
	{
			echo "#----------------------------Instalando base BSPWM-----------------------------#"
				sudo apt install bspwm sxhkd rofi polybar dunst arandr -y &&
				clear &&
			echo "#----------------------------Base BSPWM instalada------------------------------#"
				sleep 5s
	}


#--Función: Base Debian - Instalar ksuperkey (hacer posible llamar a rofi con la tecla super)--#
declare -f KSUPERKEY
function KSUPERKEY()
	{
			echo "#-----------------------------Habilitar KSUPERKEY------------------------------#"
			sudo apt install gcc make libx11-dev libxtst-dev pkg-config -y &&
			cd /tmp && git clone https://github.com/hanschen/ksuperkey.git
			cd ksuperkey
			make
			sudo make install &&
			clear &&
			echo "#----------------------------KSUPERKEY habilitado------------------------------#"
				sleep 2s
	}
	
#--Función: Base Debian - Instalar i3lock-color (hacer posible bloquear pantalla)--#
declare -f I3LOCK
function I3LOCK()
	{
			echo "#-----------------------------Habilitar I3LOCK---------------------------------#"
			sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxcb-xtest0-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev -y &&
			cd /tmp && git clone https://github.com/Raymo111/i3lock-color.git
			cd i3lock-color
			./install-i3lock-color.sh &&
			clear &&
			echo "#-----------------------------I3LOCK habilitado--------------------------------#"
				sleep 2s
	}




#--Función: Base Debian - Instalar ZSH (Terminal)--#
declare -f ZSH
function ZSH()
	{
			echo "#--------------------------------Habilitar ZSH---------------------------------#"
			sudo apt install zsh zplug -y &&
			chsh -s $(which zsh) &&
			sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" &&
			git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k &&
			git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &&
			git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &&
			
			clear &&
			echo "#--------------------------------ZSH habilitado--------------------------------#"
				sleep 2s
	}
	



#--Función: Instalar aplicaciones complementarias (base Debian)--#
declare -f APPS
function APPS()
	{
			echo "#------------------------Instalar apps complementarias-------------------------#"
			sudo apt install xsel neofetch cmatrix flameshot gnome-terminal ranger xbacklight gpick light cava nautilus htop feh dmenu nm-tray xfconf xsettingsd xfce4-power-manager zenity git ttf-mscorefonts-installer bat -y &&
			sudo systemctl disable mpd &&
   			#Jetbrains Font
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)" &&
			#Plug NVIM
            sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' &&
     		#LSD
            cargo install --git https://github.com/lsd-rs/lsd.git --branch master &&
			#FZF
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install &&
			#Node
			curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash &&
			nvm install 20
			#Nvim
			cd /tmp/bspwm
			tar xzf nvim.tar.gz
			mv nvim-linux nvim
			sudo mv nvim /opt/
            #GH CLI
            type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
            curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
            && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
            && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
            && sudo apt update \
            && sudo apt install gh -y
			
			sleep 2s
	}

	
#--Función: Usar personalizaciones para: fonts, configs, iconos, temas, polybar, dunst y rofi--#
declare -f PERSONA
function PERSONA()
	{
			echo "#---------Copiar personalizaciones (iconos, temas, fonts, fondos, etc)---------#"
				cd /tmp/bspwm &&
				sudo cp -r /tmp/bspwm/fonts/* /usr/share/fonts
				sudo cp -r /tmp/bspwm/icons/* /usr/share/icons
				sudo cp -r /tmp/bspwm/themes/* /usr/share/themes
				sudo cp -r /tmp/bspwm/backgrounds/* /usr/share/backgrounds
				cp -rf /tmp/bspwm/home/.config/* ~/.config
				cp -rf /tmp/bspwm/home/.Xresources.d $HOME
				cp -rf /tmp/bspwm/home/.Xresources $HOME
				cp -rf /tmp/bspwm/home/.gtkrc-2.0 $HOME
				cp -rf /tmp/bspwm/home/.xsettingsd $HOME
				cp -rf /tmp/bspwm/home/.dmrc $HOME
				cp -rf /tmp/bspwm/home/.fehbg $HOME
				cp -rf /tmp/bspwm/home/.zshrc $HOME
		  	    cp -rf /tmp/bspwm/home/.p10k.zsh $HOME
				
				
			clear &&
			echo "#---------------------Personalizaciones principales copiadas-------------------#"
				sleep 3s
			clear
			NOTF_SUCESS
	}

#--Función: Base Debian - Instalar Picom (Compositor)--#
declare -f PICOM
function PICOM()
	{
			echo "#------------------------------Habilitar PICOM---------------------------------#"
			sudo apt install gcc meson ninja-build python3 cmake libepoxy-dev pkg-config libpcre3 libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev -y &&
			sudo apt install libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev libxext-dev meson ninja-build uthash-dev &&
			cd $HOME/.config/
			git clone https://github.com/FT-Labs/picom 
			cd picom
			meson setup --buildtype=release build
			ninja -C build
			ninja -C build install
			cp /tmp/bspwm/home/.config/bspwm/picom.conf .
			clear &&
			echo "#------------------------------PICOM habilitado--------------------------------#"
				sleep 2s
	}

	
#--Función: Notificar operacion exitosa--#
declare -f NOTF_SUCESS
function NOTF_SUCESS()
	{
		zenity --info --width 300 --text "Instalación exitosa. Para que todo funcione correctamente, es recomendable que reinicie su sistema."
	}
	
#--Función: Notificar Fallo--#
declare -f NOTF_FALLA
function NOTF_FALLA()
	{
		clear
			echo "#----------------------------Sistema no soportado------------------------------#"
			echo "#--------Este script fue diseñado para correr en las siguientes distros:-------#"		
			echo "#------------------Debian Bullseye o Bookworm (XFCE y GNOME)-------------------#"
	}
		
##--------------------------------Funciones utilizadas en el script--------------------------------##
	clear
			echo "#------------------Este asistente instalará bspwm en su máquina----------------#"
	VERIF_DISTRIB

