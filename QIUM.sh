#!/bin/sh
#Fichier : QIUM.sh
#Fichier principal contenant le "MENU PRINCIPAL" du PROGRAMME
##Le PROCESSUS PÈRE du programme 
#QIUM : veut dire "QUATRE INDICES ET UN MOT"

. Tools/ImInEveryFile

color
verifyFile

cd "$(dirname "$0")"

. Tools/Include/QIUM

main()
{
	if [ -z "$1" ]
	then
		_I1=0.001
		_I2=0.01
		_I3=0.1
	else
		_I1=0
		_I2=0
		_I3=0
	fi
	choix="0"

	while [ "$choix" != 1 -a "$choix" != 2 -a "$choix" != 3 -a \
			"$choix" != 4 -a "$choix" != 5  ] 
	do
	 	clear
	 	if  [ -z "$1" ]
	 	then date="$(date +'%A %x %X')"
	 		 necho "|→→${bgBleuCiel}${gras}${noir} $date : " >>${_GSTORY}
	 		 echo "AFFICHAGE DU MENU PRINCIPAL ${null}" >>${_GSTORY}
	 	fi
		menu
		readChoix
		if [ "$choix" != 1 -a "$choix" != 2 -a "$choix" != 3 -a \
			 "$choix" != 4 -a "$choix" != 5 ]
		then
			necho " \t\t\t\t${rougeS}_Choix incorect_${null}"
			sleep 0.7
		fi
	done

	case "$choix" in
		1)  echo "\t\t\t ${grasBleu} Se connecter${null}"
			necho "|\n| ${whiteBgGrasNoir}CHOIX NUMÉRO 1 " >>"${_GSTORY}"
			echo ":${bleu} SE CONNECTER${null}">>"${_GSTORY}"
			sleep 0.5
			clear
			Sources/user/connect.sh
			exit 0;
		;;
		2)  echo "\t\t\t ${grasBleu} Créer un Compte${null}"
			necho "|\n| ${whiteBgGrasNoir}CHOIX NUMÉRO 2 ">>"${_GSTORY}"
			echo ":${bleu} CRÉER UN COMPTE${null}">>"${_GSTORY}"
			sleep 0.5
			clear
			Sources/user/Creat.sh
			exit 0
		;;
		3)  echo "\t\t\t ${grasBleu} Session invité${null}"
			echo "|\n| ${whiteBgGrasNoir}CHOIX NUMÉRO 3 :">>"${_GSTORY}"
			echo "${bleu} SESSION INVITÉ${null}">>"${_GSTORY}"
			sleep 0.5
			echo "\n\t\t${grasJaune}Cette fonctionnalité n'a "
			echo "pas encore été implémenté!!!${null} "
			sleep 2

			main 0
			#Sources/guest/invite.sh
			exit 0;
		 ;;
		4)  echo "\t\t\t ${grasBleu} Changer de thème${null}"
			necho "|\n| ${whiteBgGrasNoir}CHOIX NUMÉRO 4">>"${_GSTORY}"
			echo  " :${bleu} CHANGER DE THÈME${null}">>"${_GSTORY}"
			sleep 0.5
			necho "\n\t\t${grasJaune}Cette fonctionnalité n'a pas "
			echo  "encore été implémenté!!!${null} "
			sleep 2

			main 0
			exit 0
		 ;;
		5)  echo "\t\t\t ${grasRose} Quitter le Jeu${null}"
			necho "|\n| ${whiteBgGrasNoir}CHOIX NUMÉRO 5 :">>"${_GSTORY}"
			echo  "${bleu} QUITTER LE JEU${null}">>"${_GSTORY}"
			sleep 0.5
			clear
			trap_signals
			exit 0
		 ;;
	esac
}

clear
main
