#!/bin/sh
#fichier : connect.sh
#L'utilisateur se connect
#QIUM : veut dire "QUATRE INDICES ET UN MOT"
#Dans ce Script les fonctions sont tous récursives

#Inclusion du fichier Tools/ImInEveryFile, voyez ceci comme dans le langage C avec les "#include<file.h>" 
. Tools/ImInEveryFile 
#Activation des couleurs, Pour les désactivé il suffira de commenter la ligne suivante [#color]
color
verifyFile

#####INCLUSION DE FICHIER CONTENANT LES FONCTIONS DE CE SCRIPT
. Tools/Include/connect
echo "${null}"



                      ###############################################################################################################
                      #########################################DÉBUT DE L'ALGORITHME PRINCIPAL#######################################
                      ###############################################################################################################


clear
arg1="$1"
retour=0

#Si le script reçoit un argument ( qui sera un login)
#Alors cet argument sera insérer dans la variable "login"
if [ -n "$arg1" ]
then login="$arg1"

	#ECRITURE DANS LE "LOG"
	_SESSIONLOG=".Datas/.historique/historique_${login}/session.log"
     Temps="$(date +'Le %A %x à %T')"

   	echo "|\n|${soulign1}→→${null} ${bleuCiel} PROCESSUS DE CONNEXION LANCÉ${null} ${Temps}" >>${_GSTORY}

	i=0
	LECTURE_DU_MOT_MOT_DE_PASSE_
	exit 0
fi

_SESSIONLOG=".Datas/.historique/historique_${login}/session.log"

   Temps="$(date +'Le %A %x à %T')"

echo "|\n|${soulign1}→→${null} ${bleuCiel}PROCESSUS DE CONNEXION LANCÉ${null} ${Temps}" >>${_GSTORY}
LECTURE_DU_USERNAME_
retour=0
i=0
LECTURE_DU_MOT_MOT_DE_PASSE_
