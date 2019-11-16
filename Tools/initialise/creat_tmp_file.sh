#!/bin/sh

login="$1"


#Inclusion du fichier Tools/ImInEveryFile, voyez ceci comme dans le langage C avec les "#include<file.h>" 
. Tools/ImInEveryFile 

#Activation des couleurs, Pour les désactivé il suffira de commenter la ligne suivante [#color]
color
_SAVE="$2"



				##############################################################################################################################
				####  CE FICHIER VA CREER DES FICHIER TEMPORAIRES ET PERMET AU JOUEUR DE SAUVEGARDER UNE PARTIE ANTÉRIEUR NON SAUVEGARDÉ  ####
				##############################################################################################################################


if  test -e "${_TEMP_TIRAGE}"  -a -e "${_TEMP_SAVE}" 
 then

 	####ECRITURE DANS LE "LOG"
	heure="$(date +%T)"
	echo " \___ ${null}${heure} :${grasJaune}${blackBg}DÉMARAGE DE L'UTILITAIRE DE SAUVEGARDE DES DONNÉES${null}">>"${_SESSIONLOG}"

 	clear
	for i in `seq 1 5`; do necho "...";sleep 0.05;done;clear
	necho "\n${italic} Chargement des modules de sauvegarde...";sleep 0.6; 
	for i in `seq 1 40`; do necho ".";sleep 0.04;done;echo
	necho " Récupération des données non sauvegardées...";sleep 0.6
	for i in `seq 1 35`; do necho ".";sleep 0.04;done;echo
	sleep 0.1

	while [ true ]
	do
		clear
		printf "\n${italic} Dans la dernière session après un arrêt brusque de l'ordinateur,"
		  necho " ou un plantage du jeu "; sleep 0.5
		printf "vous n'avez pas pu sauvegarder les données de cette "
		  echo "session!!!\n\n" ; sleep 1.1

		 necho "${jauneS} Voulez-vous maintenant reprendre ces données"
		 necho " et les sauvegarder ?${null}${gras} [${grasBleu}O${null}${gras}/"
		 necho "${grasRouge}N${null}${gras}] ${jauneS}:${null}${vert} "
		 read unsaved_part

		case "$unsaved_part" in

			#OUI
			o|O|OUI|Oui|oui|y|Y|Yes|YES ) necho "${null} Récupération des données."
			 for i in `seq 1 5`; do necho ".";sleep 0.04;done;echo

			#On crée un des nouveaux fichiers temporaires pour l'historique et les points, Score et Niveau de $login 
			#On récupère les données actuelle du joueur
			_NEW_LINE="$(egrep -w ^${login} ${_TEMP_SAVE})"
			_OLD_LINE="$(egrep -w ^${login} ${_SAVE})"

			#Sauvegarde des données %% REMPLACEMENT DES ANCIENS DONNÉES PAR LES NOUVELLES DONNÉES %% 
			sed -i "s/${_OLD_LINE}/${_NEW_LINE}/" "${_SAVE}" 2>/dev/null

			   cat "${_TIRAGES}" >"${_TEMP_TIRAGE}"
			  echo "\n \t\t\t${null}${vert}   Sauvegarde réussi ( ^_^ )${null}";	sleep 1.2; 
			 necho "${null} Ouverture du jeu.";for i in `seq 1 5`; do necho ".";sleep 0.04;done;echo""
			echo " / \n |→→ ${grasVert}Données sauvegardées ( ^_^ )${null}\n |°° Le Jeu réprend">>"${_SESSIONLOG}"
			break;;

			#NON
			n|N|No|no|Non|NO|NON) echo "\n \t\t\t${null}${rougeS} Partie non sauvegardées${null}";sleep 1.01
								  echo " / \n |→→ ${grasRouge}Données Non sauvegardées ( ^_^ )${null}\n |°° Le Jeu réprend">>"${_SESSIONLOG}"
					break;;
	       
	     *) echo "\t\t${null}${italic} S'il vous plait veuillez répondre par ${grasBleu}oui ${null} ou${grasRouge} non${null}"
								  sleep 2.1
								;;
		esac
	done

else
	#On crée un des nouveaux fichiers temporaires pour l'historique et les points, Score et Niveau de $login 
	cat "${_SAVE}" >"${_TEMP_SAVE}"
	cat "${_TIRAGES}" >"${_TEMP_TIRAGE}"
fi

		