#!/bin/bash

# Effet Matrix avec des lettres coréennes ou japonaises en Bash

# Initialisation du terminal
clear

# Cacher le curseur pour un meilleur effet
tput civis

# Définir les couleurs
green="\033[0;32m"
light_green="\033[1;32m"
default="\033[0m"

# Obtenir la largeur et la hauteur du terminal
width=$(tput cols)
height=$(tput lines)

# Créer un tableau pour stocker les positions de départ des colonnes
declare -A start_columns

# Initialiser la position de départ de chaque colonne à une ligne aléatoire
for ((i=1; i<=width; i++)); do
    start_columns[$i]=$(($RANDOM % height))
done

# Chaîne de caractères contenant des lettres coréennes et japonaises
# Pour les lettres coréennes, utiliser l'intervalle U+AC00 à U+D7A3 (Hangul Syllables)
# Pour les lettres japonaises, utiliser des Hiraganas ou des Kanjis par exemple
# Ici, un mélange simple de quelques caractères coréens et japonais est utilisé
characters="가나다라마바사아자차카타파하ひらがなカタカナ"

# Fonction pour dessiner l'effet Matrix
draw_matrix() {
    for ((i=1; i<=width; i++)); do
        # Décider aléatoirement si un nouveau caractère doit être démarré dans la colonne
        if (( $RANDOM % 2 )); then
            # Déplacer le curseur à la position de départ de la colonne
            tput cup ${start_columns[$i]} $i
            
            # Décider aléatoirement de la couleur du caractère
            if (( $RANDOM % 2 )); then
                echo -en $green
            else
                echo -en $light_green
            fi

            # Afficher un caractère aléatoire
            echo -n ${characters:RANDOM%${#characters}:1}
            
            # Mettre à jour la position de départ pour la colonne
            start_columns[$i]=$(( (start_columns[$i] + 1) % height ))

            # Réinitialiser la couleur
            echo -en $default
        fi
    done
}

# Boucle principale pour dessiner continuellement l'effet Matrix
while true; do
    draw_matrix
    # Contrôler la vitesse de l'effet
    sleep 0.00000000000000000000000001
done

# Réinitialiser le terminal (en cas de sortie du script)
tput cnorm  # Montrer le curseur
clear
