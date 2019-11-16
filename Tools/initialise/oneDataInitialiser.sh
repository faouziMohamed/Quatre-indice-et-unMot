#!/bin/sh

#FICHIER : Tools/initialise/oneDataInitialiser.sh

login="$1"
DIFFICULTE="$2"

#Inclusion du fichier Tools/ImInEveryFile, voyez ceci comme dans le langage C avec les "#include<file.h>" 
. Tools/ImInEveryFile 
color
verifyFile

##INITIATION DES FICHIERS
case "$DIFFICULTE" in
	   FACILE)_SAVE=".Datas/.SAVE/Sauvegardes1"
				 ID="tr"
			;;
	    MOYEN)_SAVE=".Datas/.SAVE/Sauvegardes2"
				 ID="Tr"
			;;
	DIFFICILE)_SAVE=".Datas/.SAVE/Sauvegardes3"
				 ID="TR"
			;;
	CHALLENGE)_SAVE=".Datas/.SAVE/Sauvegardes4"
				 ID="TtRr"
			;;
esac


INITIALISER_UNE_CATEGORIE_()
{
	###On initialise les données du joueur avant de lancer le jeu
	#La date et heure courante
	 jour="$(date +%A)"
	 date="$(date +%x)"
	heure="$(date +%X)"
	Temps="$(echo "${jour} ${date} à ${heure}")"

	#Initialisation des données des parties de $login démiteur le caractère '#'
	sed -i "s#\(^${login}\):\(.\+\)#\1:10:1:1#" "${_SAVE}" 2>/dev/null

	#ÉCRITURE DANS LE "LOG"
	echo "\__|\n\n\n ____${gras}→→→${grasJaune} $DIFFICULTE INITIALISÉ le ${Temps} ${null}←←←\n/" >>${_SESSIONLOG}

	echo "\n\n\n\n\n\n\n\n${soulign2}"
	for i in `seq 1 80`;do sleep 0.01;necho "-";done
	echo "\n\n\t\t\t${vert} NOUVELLE PARTIE POUR $(echo "$login" |tr a-z A-Z) ${null}${soulign2}\n"
	for i in `seq 1 80`;do sleep 0.01;necho "-";done ;	echo "${null}"
	
	sleep 1
	sed -i "/$ID/d" "${_TIRAGES}" 		  2>'/dev/null'
	rm "${_TEMP_TIRAGE}" "${_TEMP_SAVE}"  2>'/dev/null'
}


clear
INITIALISER_UNE_CATEGORIE_
		