#!/bin/sh
#Ficher : interfaceMenu.sh
#QIUM : veut dire "QUATRE INDICES ET UN MOT"

login="$1"
#Inclusion du fichier Tools/ImInEveryFile, voyez ceci comme dans le langage C avec les "#include<file.h>" 
. Tools/ImInEveryFile 
#Activation des couleurs, Pour les désactivé il suffira de commenter la ligne suivante [#color]
color
verifyFile

#####INCLUSION DE FICHIER CONTENANT LES FONCTIONS DE CE SCRIPT
. Tools/Include/interfaceMenu

echo "|\n|→→ ${grasRose}AFFICHAGE DE L'INTERFACE MENU${null}">>"${_SESSIONLOG}"
                    ############################################################################################################
                    ###################################### MENU DES JOUEUR CONNECTÉS ###########################################
                    ############################################################################################################

Afficher_Le_Menu_()
{
	header

	echo "\n\e[38C${null}${grasJaune}${login} ${null}${gras}"
	echo "\n Faites votre choix \n"
	echo " \t\t ${vert}#${null}${gras}1 -${null} ${bleuCiel}Continuer la dernière partie sauvegardée${null}"
	echo " \t\t ${vert}#${null}${gras}2 -${null} ${bleuCiel}Commencer une nouvelle partie${null}"
	echo " \t\t ${vert}#${null}${gras}3 -${null} ${bleuCiel}Historique Personnel${null}"
	echo " \t\t ${vert}#${null}${gras}4 -${null} ${bleuCiel}Se déconnecter${null}"
	echo " \t\t ${vert}#${null}${gras}5 -${null} ${bleuCiel}Mon Compte${null}"
	echo " \t\t ${vert}#${null}${gras}6 -${null} ${bleuCiel}Quitter le Jeu${null}\n"
   necho "${soulign2}${grasJaune}________________________________________________________________________________${null}\n"

   trap "clear; Detournement_Du_controle_C_le_signal_SIGINT_ ; exit " 2
   necho "${null}${gras}\n Votre choix : ${null}${grasBleu}"	
	read choix
	echo "${null}"

	trap 2

	nbchar=0
	nbchar="$(expr length "$choix")"

	if [ "$nbchar" -eq 0 ]
	then 
		necho " \t\t\t   ${null}${rougeS}_Vous n'avez rien saisie_${null} "
		sleep 1.5
		clear
		Afficher_Le_Menu_
		
	fi
}


choix="0"
sexe="$2"

#####APPEL DES FONCTIONS
clear
Afficher_Le_Menu_
Lecture_du_choix_pris_Par_Le_Joueur_
		