#!/bin/bash

# Opciones del menú
options="Apagar
Reiniciar
Suspender
Cerrar sesión"

# Ejecutar rofi
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu")

# Acción basada en la elección
case "$chosen" in
    "Apagar")
        systemctl poweroff
        ;;
    "Reiniciar")
        systemctl reboot
        ;;
    "Suspender")
        systemctl suspend
        ;;
    "Cerrar sesión")
        i3-msg exit
        ;;
esac
