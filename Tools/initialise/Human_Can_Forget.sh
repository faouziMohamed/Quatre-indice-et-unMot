#!/bin/sh
#QIUM : veut dire "QUATRE INDICES ET UN MOT"

login="$1"
#Inclusion du fichier Tools/ImInEveryFile, voyez ceci comme dans le langage C avec les "#include<file.h>" 
. Tools/ImInEveryFile 

#On vérifie si tous les fichier nécessaires n'existent pas et on les créent
verifyFile

#Ajouts des couleurs
color

#####INCLUSION DE FICHIER CONTENANT LES FIONCTIONS DE CE SCRIPT
. Tools/Include/Human_Can_Forget 


 jour="$(date +%A)"
 date="$(date +%x)"
heure="$(date +%T)"
temps="${jour} ${date} à ${heure}"

#ECRITURE DANS LE "LOG"
echo "|\n|→ ${temps} :${grasRouge}TENTATIVE DE CHANGEMENT DU MOT DE PASSE ${null}" >>"${_SESSIONLOG}"


#SAUVEGARDE DE L'ÉTAT ACTUEL DU TERMINAL
_OLDSTTY="$(stty -g)"


FORGOTTEN_PASSWORD_
THEN_HUMAN_CREATE_A_NEW_PASSWORD_
		