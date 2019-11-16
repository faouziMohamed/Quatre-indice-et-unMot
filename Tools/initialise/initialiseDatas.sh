#!/bin/sh
#Ficher : Tools/initialise/initialiseDatas.sh
#QIUM : veut dire "QUATRE INDICES ET UN MOT"

##LE NOM D'UTILISATEUR
login="$1"
genre="$2"
#Inclusion du fichier Tools/ImInEveryFile, voyez ceci comme dans le langage C avec les "#include<file.h>" 
. Tools/ImInEveryFile 
color
verifyFile

INITIALISER_TOUS_LES_CATÉGORIESS_()
{
	###On initialise les données du joueur avant de lancer le jeu
	#La date et heure courante
	 jour="$(date +%A)"
	 date="$(date +%x)"
	heure="$(date +%X)"
	Temps="$(echo "${jour} ${date} à ${heure}")"

	#Initialisation des données des parties de $login démiteur le caractère '#'
	sed -i "s#\(^${login}\):\(.\+\)#\1:10:1:1#" "${_SAVE}"1 2>/dev/null
	sed -i "s#\(^${login}\):\(.\+\)#\1:10:1:1#" "${_SAVE}"2 2>/dev/null
	sed -i "s#\(^${login}\):\(.\+\)#\1:10:1:1#" "${_SAVE}"3 2>/dev/null
	sed -i "s#\(^${login}\):\(.\+\)#\1:10:1:1#" "${_SAVE}"4 2>/dev/null

	#ÉCRITURE DANS LE "LOG"
	echo "\__|\n\n\n ____${gras}→→→${grasJaune} HISTORIQUE INITIALISÉ ${Temps} ${null}←←←\n/" >>${_SESSIONLOG}

	echo "\n\n\n\n\n\n\n\n${soulign2}"
	for i in `seq 1 80`;do sleep 0.01;necho "-";done
	echo "\n\n\t\t\t${vert} NOUVELLE PARTIE POUR $(echo "$login" |tr a-z A-Z) ${null}${soulign2}\n"
	for i in `seq 1 80`;do sleep 0.01;necho "-";done ;	echo "${null}"
	
	sleep 1
	rm "${_TEMP_TIRAGE}" "${_TEMP_SAVE}" "${_TIRAGES}" 2>'/dev/null'
}


clear
INITIALISER_TOUS_LES_CATÉGORIESS_
		