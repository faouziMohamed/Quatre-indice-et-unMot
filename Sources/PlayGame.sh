#!/bin/sh
#FICHIER : PlayGame.sh

login="$1"
DIFFICULTE="$2"

. Tools/ImInEveryFile
color

##Getting save file for the right level
case "$DIFFICULTE" in
	   FACILE)_SAVE=".Datas/.SAVE/Sauvegardes1"
			  _LEVEL="Niveaux/FACILE/niveau"
			  ;;
	    MOYEN)_SAVE=".Datas/.SAVE/Sauvegardes2"
			  _LEVEL="Niveaux/MOYEN/niveau"
			;;
	DIFFICILE)_SAVE=".Datas/.SAVE/Sauvegardes3"
			 _LEVEL="Niveaux/DIFFICILE/niveau"
			;;
esac
nameInSave="$(grep ^"$login" ${_SAVE})"
if 	 [ ! "$nameInSave" ]
then echo "$login:10:1:1">>${_SAVE}
	 sort -o "${_SAVE}" "${_SAVE}"
fi

RECOVER_DATA_FOR_CHALENGE_LEVEL()
{
	nbrFacile="$(ls Niveaux/FACILE/|wc -l)"
	nbrMoyen="$(ls Niveaux/MOYEN/|wc -l)"
	nbrDifficile="$(ls Niveaux/DIFFICILE/|wc -l)"
	nivCourant1="$(egrep -w ^faouzi .Datas/.SAVE/Sauvegardes1|cut -d: -f3)"
	nivCourant2="$(egrep -w ^faouzi .Datas/.SAVE/Sauvegardes2|cut -d: -f3)"
	nivCourant3="$(egrep -w ^faouzi .Datas/.SAVE/Sauvegardes3|cut -d: -f3)"
}
MESSAGE_(){ echo " ";}

RECOVER_DATA_FOR_CHALENGE_LEVEL
clear

if [ "$DIFFICULTE" = "CHALLENGE" -a ! "$nivCourant1" -eq "$nbrFacile"  ]
then
	if [ ! "$nivCourant2" -ge 2 -o "$nivCourant3" -ge 2 ]
	then 	_SAVE=".Datas/.SAVE/Sauvegardes4"
			_LEVEL="Niveaux/CHALLENGE/niveau"
	fi
fi

# Including file containg fonction for this script
. Tools/Include/PlayGame

RECOVER_PLAYERS_DATA

#########Addinf new line in log file for this current player
echo "|\n|Partie débuté le ${bleuPal}${Temps}${null}\n\ \n \\">>"${_SESSIONLOG}"

### Check of temps files for the last session
Tools/initialise/creat_tmp_file.sh "$login" "${_SAVE}"

#ON VÉRIFIE SI LE JOUEUR N'A PAS FINI TOUS LES NIVEAUX
if [ "$numTirage" -gt "$nbTotTir" ]
then  VERIFICATION_ET_PASSAGE_DU_NIVEAU_SUIVANT_SI_NIVEAU_TERMINE_
fi

### BOUCLE PRINCIPAL SE BASANT SUR LE NOMBRE DE TIRAGE DE CHAQUE NIVEAU
while [ "$numTirage" -le "$nbTotTir" ]
do
 	SELECTION_DU_TIRAGE_ALEATOIREMENT__ET__RECUPERATION_DES_INDICES_

 	#Ajout de la séléction dans le "log" du joueur
    necho " |\n |→ ${heure} : ${bleuPal}Niveau:${niveau} ">>"${_SESSIONLOG}"
	echo  ";Score:${score};Tirage N°:${numTirage} ${null}">>"${_SESSIONLOG}"
	
	nbchar=0
	while [ "$motLu" != "$LA_REPONSE" ]
     do
     	clear
     	ENTETE_
		INTERFACE_GRAPHIQUE_

		necho "\t ${gras}${soulign}Quel est le mot ? :  ${grasVert}"
		read motLu ; echo "${null}"
		nbchar="$(expr length "$motLu")"

		VERIFICATION_DU_MOT_SAISIE_
	done

	############## Update player data $login #################
	change="$(egrep -w ^${login} "${_TEMP_SAVE}")"
	niveau="$x"
	sed -i "s/$change/$login:$score:$niveau:$numTirage/" "${_TEMP_SAVE}"
	
	config="$(stty -g)" ; stty raw
	necho "\n \t\t\t${grasVert}Appuyez sur une touche pour continuer...${null}"
	touche=$(head -c1);stty "$config"

	clear
	if [ "$numTirage" -gt "$nbTotTir" ]
	then  VERIFICATION_ET_PASSAGE_DU_NIVEAU_SUIVANT_SI_NIVEAU_TERMINE_ 
	fi
done
