#!/bin/sh
clear
login="$1"
. Tools/ImInEveryFile
color
OBJECTIF="$2"

ENTETE_()
{
	esp="                            "
	esp1="                            "
	line="$esp$esp1                        "
	clear
	echo "${blackBg}$line${gras}"
	necho "${blackBg}$line${gras}\n${esp}QUATRE "
	necho "${grasRose}INDICES "
	necho "ET "
	necho "${null}${blackBg}${gras}UN "
	necho "MOT${esp1}\n"
	necho "$line"

	#NOM PARTIE COURANTE
	ligne="________________________________________________________________________________"
	necho ""
	necho "${vert}${soulign2}${blackBg}${bleuPal}\n${ligne}"
	necho "${null}${soulign2}${gras}\n----------------------------------"

	necho "${null}"
	necho "${grasJaune} DIFFICULTÉ ${null}"
	necho "${gras}${soulign2}"
	necho "----------------------------------" 
	echo "${null}\n"
}

DERNIERE_LIGNE_()
{
	taille=$(expr length $(date +%A ))

	if [ "${taille}" -eq 8 ]
	then
		necho "____________________________________"
		echo "__________$(date +"%A %x %T")______\n"

	elif [ "${taille}" -eq 5 ]
	then
			necho "____________________________________"
		echo "__________$(date +"%A %x %T")_________\n"

	else 
		necho "____________________________________"
		echo "__________$(date +"%A %x %T")________"

	fi
}

MENU_()
{
	ENTETE_
	trap "" 2 #Détéction du signal SIGINT pendant le chargement du MENU_ PRINCIPAL
	
	echo "${italic}   Séléction de la difficulté\n${null}"
	#Option du MENU_
	echo "\t\t\t${bleuCiel}${gras}#${null}${gras}1 - ${gras}FACILE${null}"
	echo "\t\t\t${bleuCiel}${gras}#${null}${gras}2 - ${gras}MOYEN${null}"
	echo "\t\t\t${bleuCiel}${gras}#${null}${gras}3 - ${gras}DIFFICILE${null}" 
	echo "\t\t\t${bleuCiel}${gras}#${null}${gras}4 - ${gras}CHALLENGE${null}"
	echo "\t\t     ${jauneS}${gras}← ← ${null}${gras}5 -${null} ${rougeS}Retourner dans le MENU_ précedent${null}\n"

	echo "${bleuPal}${soulign2}${ligne}${null}"
	
	DERNIERE_LIGNE_	

	trap 2 #On arrête la  détéction du signal SIGINT
	LECTURE_DU_CHOIX_
	if [ "$OBJECTIF" = "--continuer" ]
	then CHOIX_SELECTIONNEE_CONTINUER_
	else CHOIX_SELECTIONNEE_NOUVELLE_
	fi
}

LECTURE_DU_CHOIX_()
{
	necho "${null}${gras}\n Votre choix : ${null}${grasJaune}"

	#trap " clear ; detournerSIGINT ; exit 0 " 2

	read choix

	
	echo "${null}"

	nbchar=0
	nbchar="$(expr length "$choix")"

	if [ "$nbchar" -eq 0 ]
	then 
		echo " \t\t\t\t${null}${rose}_Vous n'avez rien saisie_${null} "
		sleep 1.5
		clear
		MENU_
		LECTURE_DU_CHOIX_
	fi
	#trap 2
}

CHOIX_SELECTIONNEE_CONTINUER_()
{
	case "$choix" in

		1) echo "\t\t\t ${grasBleu} FACILE${null}"
			sleep 0.5
		    echo " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 1 : ${bleu}DIFFICULTÉ = FACILE${null}">>"${_SESSIONLOG}"

			clear
			Sources/PlayGame.sh "${login}" FACILE
			exit 0;
		;;
		2) echo "\t\t\t ${grasBleu} MOYEN${null}"
			sleep 0.5
		    echo " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 2 : ${bleu}DIFFICULTÉ = MOYEN${null}">>"${_SESSIONLOG}"

			clear
			Sources/PlayGame.sh "${login}" MOYEN
			exit 0
		;;
		3) echo "\t\t\t ${grasBleu} DIFFICILE${null}"
			sleep 0.5
		    echo " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 3 : ${bleu}DIFFICULTÉ = DIFFICILE${null}">>"${_SESSIONLOG}"

			clear
			Sources/PlayGame.sh "${login}" DIFFICILE
			exit 0
		;;
		4) echo "\t\t\t ${grasBleu} CHALLENGE${null}"
			sleep 0.5
			clear
		    echo " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 4 : ${bleu}DIFFICULTÉ = CHALLENGE${null}">>"${_SESSIONLOG}"

			clear
			Sources/PlayGame.sh "${login}" CHALLENGE
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
			MENU_
			exit 0
		;;

	esac

}


CHOIX_SELECTIONNEE_NOUVELLE_()
{
	case "$choix" in

		1) echo "\t\t\t ${grasBleu} FACILE${null}"
			sleep 0.5
		    echo " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 1 : ${bleu}DIFFICULTÉ = FACILE${null}">>"${_SESSIONLOG}"

			clear
			Tools/initialise/oneDataInitialiser.sh "$login" FACILE
			Sources/PlayGame.sh "${login}" FACILE
			exit 0;
		;;
		2) echo "\t\t\t ${grasBleu} MOYEN${null}"
			sleep 0.5
		    echo " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 2 : ${bleu}DIFFICULTÉ = MOYEN${null}">>"${_SESSIONLOG}"

			clear
			Tools/initialise/oneDataInitialiser.sh "$login" MOYEN
			Sources/PlayGame.sh "${login}" MOYEN
			exit 0
		;;
		3) echo "\t\t\t ${grasBleu} DIFFICILE${null}"
			sleep 0.5
		    echo " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 3 : ${bleu}DIFFICULTÉ = DIFFICILE${null}">>"${_SESSIONLOG}"

			clear
			Tools/initialise/oneDataInitialiser.sh "$login" DIFFICILE
			Sources/PlayGame.sh "${login}" DIFFICILE
			exit 0
		;;
		4) echo "\t\t\t ${grasBleu} CHALLENGE${null}"
			sleep 0.5
			clear
		    echo " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 4 : ${bleu}DIFFICULTÉ = CHALLENGE${null}">>"${_SESSIONLOG}"

			clear
			Tools/initialise/oneDataInitialiser.sh "$login" CHALLENGE
			Sources/PlayGame.sh "${login}" CHALLENGE
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
			MENU_
			exit 0
		;;

	esac

}

MENU_
		