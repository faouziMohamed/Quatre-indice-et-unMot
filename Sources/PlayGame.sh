#!/bin/sh
#FICHIER : PlayGame.sh

login="$1"
DIFFICULTE="$2"


##Inclusion du fichier : Tools/ImInEveryFile
. Tools/ImInEveryFile
color
##INITIATION DES FICHIERS
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

RECUPERATION_DES_DONNEES_DE_VERIFICATION_POUR_CHALLENGE_()
{
	nbrFacile="$(ls Niveaux/FACILE/|wc -l)"
	nbrMoyen="$(ls Niveaux/MOYEN/|wc -l)"
	nbrDifficile="$(ls Niveaux/DIFFICILE/|wc -l)"
	nivCourant1="$(egrep -w ^faouzi .Datas/.SAVE/Sauvegardes1|cut -d: -f3)"
	nivCourant2="$(egrep -w ^faouzi .Datas/.SAVE/Sauvegardes2|cut -d: -f3)"
	nivCourant3="$(egrep -w ^faouzi .Datas/.SAVE/Sauvegardes3|cut -d: -f3)"
}
MESSAGE_(){ echo " ";}

RECUPERATION_DES_DONNEES_DE_VERIFICATION_POUR_CHALLENGE_
clear


if [ "$DIFFICULTE" = "CHALLENGE" -a ! "$nivCourant1" -eq "$nbrFacile"  ]
then
	if [ ! "$nivCourant2" -ge 2 -o "$nivCourant3" -ge 2 ]
	then 	_SAVE=".Datas/.SAVE/Sauvegardes4"
			_LEVEL="Niveaux/CHALLENGE/niveau"
	fi
fi

##INCLUSION DU FICHIER CONTENANT LES FONCTIONS DU SCRIPT
. Tools/Include/PlayGame

#trap "clear ; detournerSIGINT ; exit " 2

###RECUPÉRATION DES DONNÉES
RECUPERATION_DES_DONNEES_DU_JOUEURS_



#########Ajout d'une nouvelle Ligne dans le fichier "log" du joueur
echo "|\n|Partie débuté le ${bleuPal}${Temps}${null}\n\ \n \\">>"${_SESSIONLOG}"

###VÉRIFICATIONS DES FICHIERS TEMPORAIRES DE LA DERNIÈRE SESSION
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
    echo " |\n |→ ${heure} : ${bleuPal}Niveau:${niveau};Score:${score};Tirage N°:${numTirage} ${null}">>"${_SESSIONLOG}"
	
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

	############## ON MET À JOUR LES DONNÉES DU JOUEUR $login #################
	#####Récupération de la ligne de donées de $login dans le fichier "Sauvegardes"
	change="$(egrep -w ^${login} "${_TEMP_SAVE}")"
	niveau="$x"
	#####Mis à jour des données de $login 
	sed -i "s/$change/$login:$score:$niveau:$numTirage/" "${_TEMP_SAVE}"

	config="$(stty -g)" ; stty raw
	necho "\n \t\t\t${grasVert}Appuyez sur une touche pour continuer...${null}"
	touche=$(head -c1);stty "$config"
	clear
	if [ "$numTirage" -gt "$nbTotTir" ]
	then  VERIFICATION_ET_PASSAGE_DU_NIVEAU_SUIVANT_SI_NIVEAU_TERMINE_ 
	fi

done

#trap 2

##EOF
		