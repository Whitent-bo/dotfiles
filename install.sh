#!/usr/bin/env bash

# Script de instalación y sincronización de Dotfiles (i3 setup)
set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "=== Instalando / Enlazando Dotfiles desde $DOTFILES_DIR ==="

# Crear directorios necesarios
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"

# Enlazar carpetas de configuración en ~/.config
for config_dir in i3 picom polybar rofi kitty nitrogen; do
    if [ -d "$DOTFILES_DIR/config/$config_dir" ]; then
        if [ -d "$HOME/.config/$config_dir" ] && [ ! -L "$HOME/.config/$config_dir" ]; then
            echo "Respaldando configuración existente en ~/.config/${config_dir}.bak"
            mv "$HOME/.config/$config_dir" "$HOME/.config/${config_dir}.bak"
        fi
        rm -rf "$HOME/.config/$config_dir"
        ln -snf "$DOTFILES_DIR/config/$config_dir" "$HOME/.config/$config_dir"
        echo "✓ Enlazado ~/.config/$config_dir -> $DOTFILES_DIR/config/$config_dir"
    fi
done

# Enlazar scripts ejecutables en ~/.local/bin
if [ -d "$DOTFILES_DIR/scripts" ]; then
    for script in "$DOTFILES_DIR/scripts"/*; do
        if [ -f "$script" ]; then
            script_name=$(basename "$script")
            chmod +x "$script"
            ln -sf "$script" "$HOME/.local/bin/$script_name"
            echo "✓ Enlazado ~/.local/bin/$script_name -> $script"
        fi
    done
fi

# Enlazar .Xresources
if [ -f "$DOTFILES_DIR/Xresources" ]; then
    ln -sf "$DOTFILES_DIR/Xresources" "$HOME/.Xresources"
    echo "✓ Enlazado ~/.Xresources -> $DOTFILES_DIR/Xresources"
    if command -v xrdb >/dev/null 2>&1; then
        xrdb -merge "$HOME/.Xresources" 2>/dev/null || true
    fi
fi

# Recargar i3 si está en ejecución
if command -v i3-msg >/dev/null 2>&1 && i3-msg -t get_version >/dev/null 2>&1; then
    i3-msg reload >/dev/null
    echo "✓ Configuración de i3 recargada."
fi

echo "=========================================="
echo " ¡Dotfiles instalados/restaurados con éxito! "
echo "=========================================="
