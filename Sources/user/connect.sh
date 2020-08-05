#!/bin/sh
#fichier : connect.sh
#L'utilisateur se connect
#QIUM : veut dire "QUATRE INDICES ET UN MOT"
#Dans ce Script les fonctions sont tous récursives

. Tools/ImInEveryFile 
color
verifyFile

. Tools/Include/connect
echo "${null}"

######################################
####DÉBUT DE L'ALGORITHME PRINCIPAL###
######################################

clear
arg1="$1"
retour=0

if [ -n "$arg1" ]
then login="$arg1"
	#ECRITURE DANS LE "LOG"
	_SESSIONLOG=".Datas/.historique/historique_${login}/session.log"
     Time="$(date +'Le %A %x à %T')"

   	echo "|\n|${soulign1}→→${null} ${bleuCiel} PROCESSUS DE CONNEXION LANCÉ${null} ${Time}" >>${_GSTORY}

	i=0
	LECTURE_DU_MOT_MOT_DE_PASSE_
	exit 0
fi

_SESSIONLOG=".Datas/.historique/historique_${login}/session.log"

Time="$(date +'Le %A %x à %T')"

echo "|\n|${soulign1}→→${null} ${bleuCiel}PROCESSUS DE CONNEXION LANCÉ${null} ${Time}" >>${_GSTORY}
LECTURE_DU_USERNAME_
retour=0
i=0
LECTURE_DU_MOT_MOT_DE_PASSE_
