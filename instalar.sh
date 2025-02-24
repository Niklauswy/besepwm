#!/usr/bin/env bash

#-------------------------------------------------------------#
#                  {_}                                        #
#                  /*\                                        #
#                 /_*_\                                       #
# @Niklauswy     {('o')}                                      #
#             C{{([^*^])}}D                                   #
#                 [ * ]                                       #
#                /  Y  \                                      #
#               _\__|__/_                                     #
#              (___/ \___)                                    #
#-------------------------------------------------------------#

# Limpiar pantalla
clear

# Función auxiliar para loguear errores
log_error() {
    echo "[ERROR] $1"
}

# Función ALACC (no definida originalmente, se define como no-op para evitar fallos)
ALACC() {
    echo "#------------------ ALACC: Función no definida, saltando. ------------------#"
    sleep 1
}

# Función: Actualizar sistema (base Debian)
ACTUALIZAR() {
    echo "#----------------------------- Actualizar sistema -----------------------------#"
    sudo apt update || log_error "apt update falló"
    echo "#-------------------------- Repositorios actualizados -------------------------#"
    sleep 1
    sudo apt upgrade -y || log_error "apt upgrade falló"
    echo "#--------------------------- Programas actualizados ---------------------------#"
    sleep 1
    sudo apt dist-upgrade -y || log_error "dist-upgrade falló"
    sudo apt autoclean || log_error "apt autoclean falló"
    sudo apt autoremove -y || log_error "apt autoremove falló"
    clear
    echo "#----------------------------- Sistema actualizado -----------------------------#"
    sleep 5
}

# Función: Instalar base BSPWM
BSPWM() {
    echo "#---------------------------- Instalar base BSPWM -----------------------------#"
    sudo apt install bspwm sxhkd rofi polybar dunst arandr -y || log_error "Instalación de BSPWM falló"
    clear
    echo "#---------------------------- Base BSPWM instalada ----------------------------#"
    sleep 5
}

# Función: Instalar ksuperkey (para habilitar la tecla Super en rofi)
KSUPERKEY() {
    echo "#----------------------------- Habilitar KSUPERKEY -----------------------------#"
    sudo apt install gcc make libx11-dev libxtst-dev pkg-config -y || log_error "Instalación de dependencias para ksuperkey falló"
    cd /tmp || { log_error "No se pudo cambiar a /tmp"; return; }
    if [ ! -d "ksuperkey" ]; then
        git clone https://github.com/hanschen/ksuperkey.git || log_error "Clonación de ksuperkey falló"
    fi
    cd ksuperkey || { log_error "No se pudo acceder al directorio ksuperkey"; return; }
    make || log_error "Make de ksuperkey falló"
    sudo make install || log_error "Instalación de ksuperkey falló"
    clear
    echo "#---------------------------- KSUPERKEY habilitado ----------------------------#"
    sleep 2
}

# Función: Instalar i3lock-color (para bloquear la pantalla)
I3LOCK() {
    echo "#----------------------------- Habilitar I3LOCK -------------------------------#"
    sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxcb-xtest0-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev -y || log_error "Instalación de dependencias para i3lock-color falló"
    cd /tmp || { log_error "No se pudo cambiar a /tmp"; return; }
    if [ ! -d "i3lock-color" ]; then
        git clone https://github.com/Raymo111/i3lock-color.git || log_error "Clonación de i3lock-color falló"
    fi
    cd i3lock-color || { log_error "No se pudo acceder a i3lock-color"; return; }
    ./install-i3lock-color.sh || log_error "Instalación de i3lock-color falló"
    clear
    echo "#----------------------------- I3LOCK habilitado ------------------------------#"
    sleep 2
}

# Función: Instalar ZSH y configurarlo con oh-my-zsh y plugins
ZSH() {
    echo "#-------------------------------- Habilitar ZSH -------------------------------#"
    sudo apt install zsh zplug -y || log_error "Instalación de ZSH y zplug falló"
    chsh -s "$(which zsh)" || log_error "Cambio de shell falló"
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" || log_error "Instalación de oh-my-zsh falló"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" || log_error "Clonación de powerlevel10k falló"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" || log_error "Clonación de zsh-syntax-highlighting falló"
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" || log_error "Clonación de zsh-autosuggestions falló"
    clear
    echo "#-------------------------------- ZSH habilitado ------------------------------#"
    sleep 2
}

# Función: Instalar aplicaciones complementarias (base Debian)
APPS() {
    echo "#------------------------ Instalar apps complementarias -----------------------#"
    sudo apt install xsel neofetch cmatrix flameshot gnome-terminal ranger xbacklight gpick light cava nautilus htop feh dmenu nm-tray xfconf xsettingsd xfce4-power-manager zenity git ttf-mscorefonts-installer bat -y || log_error "Instalación de apps complementarias falló"
    sudo systemctl disable mpd || log_error "No se pudo deshabilitar mpd"
    # Instalar JetBrains Mono Font
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)" || log_error "Instalación de JetBrains Mono falló"
    # Instalar vim-plug para NVIM
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' || log_error "Instalación de vim-plug falló"
    # Instalar LSD
    cargo install --git https://github.com/lsd-rs/lsd.git --branch master || log_error "Instalación de lsd falló"
    # Instalar FZF (si no existe)
    if [ ! -d "$HOME/.fzf" ]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf" || log_error "Clonación de fzf falló"
        "$HOME/.fzf/install" || log_error "Instalación de fzf falló"
    fi
    # Instalar Node (nvm)
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash || log_error "Instalación de nvm falló"
    # Cargar nvm para la sesión actual
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install 20 || log_error "Instalación de Node 20 falló"
    # Instalar GH CLI
    if ! type -p curl >/dev/null; then
        sudo apt update && sudo apt install curl -y || log_error "Instalación de curl falló"
    fi
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg 2>/dev/null || log_error "Descarga del keyring falló"
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg || log_error "chmod keyring falló"
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update || log_error "apt update para GH CLI falló"
    sudo apt install gh -y || log_error "Instalación de GH CLI falló"
    sleep 2
}

# Función: Instalar aplicaciones complementarias para XFCE (base Debian)
APPS_XFCE() {
    echo "#------------------ Instalar apps para XFCE ------------------#"
    sudo apt install xfce4-appfinder xfce4-terminal xfce4-panel -y || log_error "Instalación de apps XFCE falló"
    sleep 2
}

# Función: Copiar personalizaciones (configs, fonts, iconos, temas, etc.)
PERSONA() {
    echo "#--------- Copiar personalizaciones (iconos, temas, fonts, fondos, etc) ---------#"
    cd /tmp/bspwm || { log_error "Directorio /tmp/bspwm no encontrado"; return; }
    sudo cp -r fonts/* /usr/share/fonts || log_error "Error copiando fonts"
    sudo cp -r icons/* /usr/share/icons || log_error "Error copiando icons"
    sudo cp -r themes/* /usr/share/themes || log_error "Error copiando themes"
    sudo cp -r backgrounds/* /usr/share/backgrounds || log_error "Error copiando backgrounds"
    cp -rf home/.config/* "$HOME/.config" || log_error "Error copiando configuraciones"
    cp -rf home/.Xresources.d "$HOME" || log_error "Error copiando .Xresources.d"
    cp -rf home/.Xresources "$HOME" || log_error "Error copiando .Xresources"
    cp -rf home/.gtkrc-2.0 "$HOME" || log_error "Error copiando .gtkrc-2.0"
    cp -rf home/.xsettingsd "$HOME" || log_error "Error copiando .xsettingsd"
    cp -rf home/.dmrc "$HOME" || log_error "Error copiando .dmrc"
    cp -rf home/.fehbg "$HOME" || log_error "Error copiando .fehbg"
    cp -rf home/.zshrc "$HOME" || log_error "Error copiando .zshrc"
    cp -rf home/.p10k.zsh "$HOME" || log_error "Error copiando .p10k.zsh"
    clear
    echo "#--------------------- Personalizaciones copiadas ---------------------#"
    sleep 3
    clear
    NOTF_SUCESS
}

# Función: Instalar Picom (Compositor)
PICOM() {
    echo "#------------------------------ Habilitar PICOM ------------------------------#"
    sudo apt install gcc meson ninja-build python3 cmake libepoxy-dev pkg-config libpcre3 libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev -y || log_error "Instalación de dependencias para PICOM falló"
    sudo apt install libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev libxext-dev meson ninja-build uthash-dev || log_error "Instalación de dependencias adicionales para PICOM falló"
    cd "$HOME/.config" || { log_error "No se pudo acceder a $HOME/.config"; return; }
    if [ ! -d "picom" ]; then
        git clone https://github.com/FT-Labs/picom || log_error "Clonación de picom falló"
    fi
    cd picom || { log_error "No se pudo acceder a picom"; return; }
    meson setup --buildtype=release build || log_error "Meson setup falló"
    ninja -C build || log_error "Compilación de picom falló"
    ninja -C build install || log_error "Instalación de picom falló"
    cp /tmp/bspwm/home/.config/bspwm/picom.conf . || log_error "Copiar picom.conf falló"
    clear
    echo "#------------------------------ PICOM habilitado ------------------------------#"
    sleep 2
}

# Función: Notificar operación exitosa
NOTF_SUCESS() {
    zenity --info --width 300 --text "Instalación exitosa. Se recomienda reiniciar el sistema."
}

# Función: Notificar fallo (para sistemas no soportados)
NOTF_FALLA() {
    clear
    echo "#---------------------------- Sistema no soportado ----------------------------#"
    echo "#-------- Este script fue diseñado para correr en las siguientes distros: -------#"
    echo "#------------------ Debian Bullseye o Bookworm (XFCE y GNOME) ------------------#"
}

#--------------------------------- Inicio del Script ---------------------------------#

clear
echo "#------------------ Este asistente instalará bspwm en su máquina ------------------#"

# Ejecutar funciones en secuencia
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
