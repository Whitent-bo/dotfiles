#!/bin/bash
# Script de reloj ASCII Moderno con paleta Nord - Versión Estable
# Nord Colors
NORD_FROST_LIGHT="#81A1C1"
NORD_FROST_DARK="#5E81AC"
NORD_SNOW_STORM="#D8DEE9"

# Ocultar el cursor de forma robusta
tput civis
trap "tput cnorm; exit" SIGINT SIGTERM

# Función para dibujar números ASCII
draw_digit() {
    local digit=$1
    case $digit in
        0) echo -e "┏━━━┓\n┃┃ ┃┃\n┃┃ ┃┃\n┃┃ ┃┃\n┗━━━┛";;
        1) echo -e "  ┏┓ \n  ┃┃ \n  ┃┃ \n  ┃┃ \n  ┗┛ ";;
        2) echo -e "┏━━━┓\n    ┃\n┏━━━┛\n┃    \n┗━━━┛";;
        3) echo -e "┏━━━┓\n    ┃\n┣━━━┫\n    ┃\n┗━━━┛";;
        4) echo -e "┃ ┏┓ \n┃ ┃┃ \n┗━┫┃ \n  ┃┃ \n  ┗┛ ";;
        5) echo -e "┏━━━┓\n┃    \n┗━━━┓\n    ┃\n┗━━━┛";;
        6) echo -e "┏━━━┓\n┃    \n┣━━━┓\n┃ ┃ ┃\n┗━━━┛";;
        7) echo -e "┏━━━┓\n    ┃\n   ┏┛\n  ┃  \n  ┗┛ ";;
        8) echo -e "┏━━━┓\n┃ ┃ ┃\n┣━━━┫\n┃ ┃ ┃\n┗━━━┛";;
        9) echo -e "┏━━━┓\n┃ ┃ ┃\n┗━━━┫\n    ┃\n┗━━━┛";;
        ":") echo -e "     \n  ●  \n     \n  ●  \n     ";;
    esac
}

QUOTE="\"Lego La Nada a Nadie.\""
LAST_TIME=""

# Esperar un momento para que la terminal se ponga en pantalla completa y obtenga dimensiones correctas
sleep 0.5
clear

while true; do
    CURRENT_TIME=$(date +%H:%M)
    cols=$(tput cols)
    lines=$(tput lines)
    
    # Solo redibujar si el tiempo ha cambiado o si es la primera vez
    if [ "$CURRENT_TIME" != "$LAST_TIME" ]; then
        clear
        
        # Altura total: 5 (reloj) + 2 (espacio) + 1 (frase) = 8 líneas
        start_y=$(( (lines / 2) - 4 ))
        
        # 1. Dibujar SOMBRA
        echo -ne "\e[38;2;94;129;172m"
        for i in {0..4}; do
            line_str=""
            for (( j=0; j<${#CURRENT_TIME}; j++ )); do
                char="${CURRENT_TIME:$j:1}"
                digit_art=$(draw_digit "$char")
                line=$(echo "$digit_art" | sed -n "$((i+1))p")
                line_str="$line_str$line  "
            done
            total_width=${#line_str}
            x=$(( (cols - total_width) / 2 ))
            tput cup $((start_y + i + 1)) $((x + 1))
            echo -ne "$line_str"
        done

        # 2. Dibujar RELOJ PRINCIPAL
        echo -ne "\e[38;2;129;161;193m"
        for i in {0..4}; do
            line_str=""
            for (( j=0; j<${#CURRENT_TIME}; j++ )); do
                char="${CURRENT_TIME:$j:1}"
                digit_art=$(draw_digit "$char")
                line=$(echo "$digit_art" | sed -n "$((i+1))p")
                line_str="$line_str$line  "
            done
            total_width=${#line_str}
            x=$(( (cols - total_width) / 2 ))
            tput cup $((start_y + i)) $x
            echo -ne "$line_str"
        done
        
        # 3. Dibujar FRASE DEL DÍA
        echo -ne "\e[38;2;216;222;233m" # Nord Snow Storm
        quote_x=$(( (cols - ${#QUOTE}) / 2 ))
        tput cup $((start_y + 7)) $quote_x
        echo -ne "$QUOTE"
        
        echo -ne "\e[0m"
        LAST_TIME=$CURRENT_TIME
    fi
    
    # Comprobar cada segundo, pero solo redibujar cuando cambie el minuto (o la hora)
    sleep 1
done
