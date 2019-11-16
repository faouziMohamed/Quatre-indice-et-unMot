#!/bin/sh

login="$1"
#Inclusion du fichier Tools/ImInEveryFile, voyez ceci comme dans le "langage C" avec les directives "#include<file.h>" 
. Tools/ImInEveryFile 


#Activation des couleurs, Pour les désactivé il suffira de commenter la ligne suivante [#color]
color
#On vérifie si tous les fichier nécessaires n'existent pas et on les créent
verifyFile


. Tools/Include/Account


#La date et heure courante
 jour="$(date +%A)"
 date="$(date +%x)"




LECTURE_DU_CHOIX_()
{
	necho "${null}${gras}\n Votre choix : ${null}${grasJaune}"

	trap " clear ; detournerSIGINT ; exit 0 " 2

	read choix

	
	echo "${null}"

	nbchar=0
	nbchar="$(expr length "$choix")"

	if [ "$nbchar" -eq 0 ]
	then 
		echo " \t\t\t\t${null}${rose}_Vous n'avez rien saisie_${null} "
		sleep 1.5
		clear
		MENU_DES_JOUEURS_CONNECTES_
		LECTURE_DU_CHOIX_
		
	fi
	trap 2
}

CHOIX_SELECTIONNEE_()
{
	case "$choix" in

		1) echo "\t\t\t ${grasBleu} Changer le mot de passe${null}"
			sleep 0.5
		    echo " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 1 : ${bleu}CHANGER LE MOT DE PASSE${null}">>"${_SESSIONLOG}"

			clear 
			Tools/initialise/NewPassword.sh "${login}"
			exit 0;
		;;
		2) echo "\t\t\t ${grasBleu} Modifier le nom d'utilisateur${null}"
			sleep 0.5
		    echo " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 2 : ${bleu}MODIFIER LE NOM D'UTILISATEUR${null}">>"${_SESSIONLOG}"

			clear 
			Tools/UserTool/modify_UserName_And_Email.sh "${login}" "--name"
			exit 0
		;;
		3) echo "\t\t\t ${grasBleu} Changer l'adresse E-mail${null}"
			sleep 0.5
		    echo " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 3 : ${bleu}MODIFIER L'ADRESSE E-MAIL${null}">>"${_SESSIONLOG}"

			clear
			Tools/UserTool/modify_UserName_And_Email.sh "${login}"
			exit 0
		;;
		4) echo "\t\t\t ${grasBleu} Supprimer mon compte${null}"
			sleep 0.5
			clear
		    echo " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 4 : ${bleu}SUPPRIMER MON COMPTE${null}">>"${_SESSIONLOG}"

			Tools/UserTool/DELLUSER.sh "${login}"
			clear
			MENU_DES_JOUEURS_CONNECTES_
			exit 0
		;;

		5) echo "\t\t\t ${grasBleu} Retourner dans le Menu précedent${null}"
			sleep 0.5
			clear
			echo " |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 5 : ${bleu}RETOUR VERS L'INTERFACE MENU${null}\n /\n/">>"${_SESSIONLOG}"
		;;

	 	*)  necho " \t\t\t\t${rougeS}_Choix incorect_${null}"
			sleep 0.7
		    echo " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO * : ${rose}CHOIX INCORRECT${null}">>"${_SESSIONLOG}"

			clear
			MENU_DES_JOUEURS_CONNECTES_
			exit 0
		;;

	esac

}




									################ALGORITHME PRINCIPAL###############################
clear

if   [ "$2" = '--hist' ]
then
	 HISTORIQUE_PERSONNEL_
	 ReadKey

elif [ "$2" = '--myAcnt' ]
then
	echo "\ \n \ \n |→→ ${grasJaune}AFFICHAGE DE L'INTERFACE MON COMPTE${null}\n |">>"${_SESSIONLOG}"
	MENU_DES_JOUEURS_CONNECTES_

fi
