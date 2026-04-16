#!/bin/bash

# Fonction pour afficher le menu
show_menu() {
    echo "------------------------------------------"
    echo "   MENU DE GESTION TOMCAT 9 - SRV-WEB     "
    echo "------------------------------------------"
    echo "1) Demarrer le serveur Tomcat"
    echo "2) Arreter le serveur Tomcat"
    echo "3) Relancer le serveur (Restart)"
    echo "4) Voir le statut du serveur"
    echo "5) Quitter"
    echo "------------------------------------------"
}

while true; do
    show_menu
    read -p "Entrez votre choix [1-5] : " choice
    case $choice in
        1)
            echo "Demarrage en cours..."
            sudo systemctl start tomcat9
            ;;
        2)
            echo "Arret en cours..."
            sudo systemctl stop tomcat9
            ;;
        3)
            echo "Relance en cours..."
            sudo systemctl restart tomcat9
            ;;
        4)
            sudo systemctl status tomcat9 | grep "Active:"
            ;;
        5)
            echo "Au revoir !"
            exit 0
            ;;
        *)
            echo "Choix invalide, recommencez."
            ;;
    esac
    echo ""
done
