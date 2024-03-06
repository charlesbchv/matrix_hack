#!/bin/bash

clear
# Cache le curseur
tput civis

# Définition des couleurs
green="\033[0;32m"
light_green="\033[1;32m"
default="\033[0m"

# Largeur et hauteur du terminal
width=$(tput cols)
height=$(tput lines)

# Stocke les positions de départ
declare -A start_columns

# Initialise la position de départ de chaque colonne en mode aléa
for ((i=1; i<=width; i++)); do
    start_columns[$i]=$(($RANDOM % height))
done

# Chaîne de caractères contenant des lettres coréennes et japonaises
# Mélange simple de quelques caractères coréens et japonais
characters="가나다라마바사아자차카타파하ひらがなカタカナ"

# Méthode pr draw effet Matrix
draw_matrix() {
    for ((i=1; i<=width; i++)); do
        # Random si un nouveau caractère dans la colonne
        if (( $RANDOM % 2 )); then
            # Déplace le curseur à la position de départ de la colonne
            tput cup ${start_columns[$i]} $i
            
            # Random couleur du caractère
            if (( $RANDOM % 2 )); then
                echo -en $green
            else
                echo -en $light_green
            fi

            # Affiche un caractère aléatoire
            echo -n ${characters:RANDOM%${#characters}:1}
            
            # Maj la position de départ pour la colonne
            start_columns[$i]=$(( (start_columns[$i] + 1) % height ))

            # Réinitialise la couleur
            echo -en $default
        fi
    done
}

# Boucle l'effet Matrix
while true; do
    draw_matrix
    # Vitesse = accéleromètre de l'effet
    sleep 0.00000000000000000000000001
done

# Réinitialiser le terminal (en cas de sortie du script)
tput cnorm  # Montrer le curseur
clear
