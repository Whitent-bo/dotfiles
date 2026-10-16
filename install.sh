#!/usr/bin/env bash

# ==============================================================================
# Script de Instalación, Configuración y Sincronización de Dotfiles
# Entorno: Debian (i3wm + Bash + Herramientas de terminal)
# ==============================================================================

set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INSTALL_PACKAGES=false

# Procesar argumentos
for arg in "$@"; do
    case $arg in
        -p|--install-packages)
            INSTALL_PACKAGES=true
            shift
            ;;
        -h|--help)
            echo "Uso: ./install.sh [opciones]"
            echo ""
            echo "Opciones:"
            echo "  -p, --install-packages   Instala los programas indispensables con apt antes de enlazar."
            echo "  -h, --help               Muestra esta ayuda."
            exit 0
            ;;
    esac
done

echo "=========================================================="
echo " 🚀 Instalando y enlazando Dotfiles desde: $DOTFILES_DIR"
echo "=========================================================="

# 1. Instalación opcional de paquetes indispensables (apt)
if [ "$INSTALL_PACKAGES" = true ]; then
    if [ -f "$DOTFILES_DIR/packages-apt.txt" ]; then
        echo ""
        echo "📦 Instalando paquetes indispensables mediante apt..."
        # Filtrar comentarios y líneas vacías
        PACKAGES=$(grep -v '^#' "$DOTFILES_DIR/packages-apt.txt" | grep -v '^$' | tr '\n' ' ')
        
        if command -v sudo >/dev/null 2>&1; then
            sudo apt update && sudo apt install -y $PACKAGES
        else
            apt update && apt install -y $PACKAGES
        fi
        echo "✓ Paquetes indispensables instalados correctamente."
    else
        echo "⚠️ No se encontró packages-apt.txt en $DOTFILES_DIR"
    fi
fi

# 2. Asegurar directorios base
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"

# 3. Enlazar archivos de configuración de Bash
echo ""
echo "🐚 Enlazando configuración de Bash..."
for bash_file in .bashrc .bash-preexec.sh; do
    if [ -f "$DOTFILES_DIR/bash/$bash_file" ]; then
        if [ -f "$HOME/$bash_file" ] && [ ! -L "$HOME/$bash_file" ]; then
            echo "   Respaldando $HOME/$bash_file -> $HOME/${bash_file}.bak"
            mv "$HOME/$bash_file" "$HOME/${bash_file}.bak"
        fi
        ln -sf "$DOTFILES_DIR/bash/$bash_file" "$HOME/$bash_file"
        echo "   ✓ Enlazado $HOME/$bash_file -> $DOTFILES_DIR/bash/$bash_file"
    fi
done

# 4. Enlazar carpetas en ~/.config
echo ""
echo "⚙️  Enlazando directorios de configuración en ~/.config..."
CONFIG_DIRS=(i3 picom polybar rofi kitty nitrogen fastfetch btop ranger atuin)

for config_name in "${CONFIG_DIRS[@]}"; do
    src_dir="$DOTFILES_DIR/config/$config_name"
    dest_dir="$HOME/.config/$config_name"

    if [ -d "$src_dir" ]; then
        if [ -d "$dest_dir" ] && [ ! -L "$dest_dir" ]; then
            echo "   Respaldando directorio existente ~/.config/${config_name} en ~/.config/${config_name}.bak"
            mv "$dest_dir" "${dest_dir}.bak"
        fi
        rm -rf "$dest_dir"
        ln -snf "$src_dir" "$dest_dir"
        echo "   ✓ Enlazado ~/.config/$config_name -> $src_dir"
    fi
done

# 5. Enlazar scripts ejecutables a ~/.local/bin
echo ""
echo "🛠️  Enlazando scripts ejecutables a ~/.local/bin..."
if [ -d "$DOTFILES_DIR/scripts" ]; then
    for script in "$DOTFILES_DIR/scripts"/*; do
        if [ -f "$script" ]; then
            script_name=$(basename "$script")
            chmod +x "$script"
            ln -sf "$script" "$HOME/.local/bin/$script_name"
            echo "   ✓ Enlazado ~/.local/bin/$script_name -> $script"
        fi
    done
fi

# 6. Enlazar .Xresources
if [ -f "$DOTFILES_DIR/Xresources" ]; then
    echo ""
    echo "🎨 Enlazando Xresources..."
    if [ -f "$HOME/.Xresources" ] && [ ! -L "$HOME/.Xresources" ]; then
        mv "$HOME/.Xresources" "$HOME/.Xresources.bak"
    fi
    ln -sf "$DOTFILES_DIR/Xresources" "$HOME/.Xresources"
    echo "   ✓ Enlazado ~/.Xresources -> $DOTFILES_DIR/Xresources"
    if command -v xrdb >/dev/null 2>&1; then
        xrdb -merge "$HOME/.Xresources" 2>/dev/null || true
    fi
fi

# 7. Recargar i3wm si está activo
if command -v i3-msg >/dev/null 2>&1 && i3-msg -t get_version >/dev/null 2>&1; then
    i3-msg reload >/dev/null 2>&1 || true
    echo ""
    echo "🔄 Configuración de i3 recargada."
fi

echo ""
echo "=========================================================="
echo " ✨ ¡Dotfiles y entorno configurados con éxito!           "
echo "=========================================================="
