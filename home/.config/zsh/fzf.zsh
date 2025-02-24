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



#--------------FZF CONFIG----------------

export FZF_DEFAULT_COMMAND='find . -type f'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Colores personalizados
export FZF_DEFAULT_OPTS="
  --color=fg:#d0d0d0,hl:#ffaf00
  --color=fg+:#ffffff,hl+:#ffaf00
  --color=info:#87afff,prompt:#ff5f00,pointer:#ff5f00
  --color=marker:#ff5f00,spinner:#87afff,header:#87afff
"

# Habilitar vista previa para archivos
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --preview 'batcat --style=numbers --color=always {} | head -100'"

# Atajos de teclado personalizados
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind 'ctrl-a:select-all+accept' --bind 'ctrl-d:deselect-all+accept'"

# Función para cambiar de directorio con fzf y listar contenido
fzf_cd() {
    local dir
    dir=$(find . -type d | fzf --preview 'find {} -maxdepth 1 -type d | head -10') && cd "$dir"
    ls
}
zle -N fzf_cd
bindkey '^q' fzf_cd

# Función para abrir carpetas con diferentes aplicaciones
fzf_open_with() {
    local dir app
    dir=$(find . -type d | fzf --preview 'find {} -maxdepth 1 -type d | head -10') || return
    app=$(echo -e "WebStorm\nVS Code\nCLion\nNvim" | rofi -dmenu -theme ~/.config/bspwm/rofi/themes/launcher.rasi -p ) || return

    case "$app" in
        "WebStorm")
            nohup webstorm "$dir" > /dev/null 2>&1 &
            disown
            ;;
        "VS Code")
            nohup code-insiders "$dir" > /dev/null 2>&1 &
            disown
            ;;
        "CLion")
            nohup clion "$dir" > /dev/null 2>&1 &
            disown
            ;;
        "Nvim")
            nohup nvim "$dir" > /dev/null 2>&1 &
            disown
            ;;
        *)
            echo "Aplicación no reconocida: $app"
            ;;
    esac

    # Cerrar la terminal original
    exit
}

zle -N fzf_open_with
bindkey '^g' fzf_open_with

fzf_file() {
    local file app
    file=$(find . -type f | fzf) || return
    app=$(echo -e "Vim\nNano\nVS Code" | rofi -dmenu -theme ~/.config/bspwm/rofi/themes/launcher.rasi -p "Select app:") || return

    case "$app" in
        "Vim")
            nvim "$file" < /dev/tty
            ;;
        "Nano")
            nano "$file"
            ;;
        "VS Code")
            code-insiders "$file"
            ;;
        *)
            echo "Application not recognized: $app"
            ;;
    esac
}
zle -N fzf_file
bindkey '^w' fzf_file

# Función para copiar archivos
fzf_cp() {
    local file
    file=$(find . -type f | fzf)
    if [[ -n $file ]]; then
        clipcopy "$file" < /dev/tty
    fi
}
zle -N fzf_cp
bindkey '^a' fzf_cp

# Función para mostrar el historial de comandos
fzf_history() {
    local cmd
    cmd=$(history | fzf --tac --preview 'echo {}' --preview-window=up:3:wrap) && eval "$cmd"
}
zle -N fzf_history
bindkey '^r' fzf_history

