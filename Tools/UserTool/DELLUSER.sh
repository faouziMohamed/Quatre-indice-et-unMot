#!/bin/sh

login="$1"
#Inclusion du fichier Tools/ImInEveryFile, voyez ceci comme dans le langage C avec les "#include<file.h>" 
. Tools/ImInEveryFile 

#On vérifie si tous les fichier nécessaires n'existent pas et on les créent
verifyFile

#Ajouts des couleurs
color

#SAUVEGARDE DE L'ÉTAT ACTUEL DU TERMINAL
_OLDSTTY="$(stty -g)"

#####INCLUSION DE FICHIER CONTENANT LES FONCTIONS DE CE SCRIPT
. Tools/Include/Account



							##################################################################
							################# SUPPRESSION D'UN JOUEUR ########################
							################################################################## 

##### ENTÊTE DU PARIE DE SUPPRESSION D'UN JOUEUR #####
 headDELETE()
{
	#date="$(date |cut -f1 -d,)"
	esp="                            "
	esp1="                            "
	line="$esp$esp1                        "

	necho "${blackBg}$line${gras}\n"
	necho "${esp}QUATRE "
	necho "${rougeS}INDICES "
	necho "ET "
	necho "${null}${blackBg}${gras}UN "
	necho "MOT${esp1}"

	#NOM PARTIE COURANTE
	necho ""
	necho "${grasJaune}${soulign2}\n________________________________"
	necho "________________________________________________"
	necho "${null}${soulign2}${gras}\n\n----------------------------"

	necho "${null}${gras}"
	necho "${rougeS} SUPPRESSION DE JOUEUR ${null}"
	necho "${gras}${soulign2}"
	necho "-----------------------------" 
	necho "${null}\n\n\n"
}



####### MESSAGE (PROMPT ) DE CONFIRMATION SI LE JOUEUR VEUT VRAIMENT SUPPRIMER SON COMPTE #####
SUPPRESSION_DU_COMPTE_()
{
	clear
	headDELETE

	echo "${null}${gras} Vous avez choisis de Supprimer votre compte :\n"
	echo "${null}     Cet action implique${null}  ${rose}l'éffacement  complet de votre progression ainsi que"
   necho " l'historique complet de tous vos données${null}."
	echo " ${null}Le processus de suppression du compte"
	echo " est irreversible!!${null}\n"
  necho "\n\t\t\t${gras}Appuyez sur une ${null}${jauneS}touche${null}${gras} pour "
	echo "continuer...${null}    "

	necho "${grasJaune}${soulign2}\n________________________________"
	necho "________________________________________________${null}"

	config=$(stty -g); stty raw; touche=$(head -c 1); stty $config

	sleep 0.1
	choix=''

	while [ "$choix" != "-m"        ]&&\
		  [ "$choix" != "--liberty" ]
	do
	  	clear
	  	headDELETE

 		echo "\n\n\n\n\t   ${vert}(°-°)${null} Pour Retourner dans le meunu précedent tapez ${grasJaune}-m${null}"
 		echo "\n\t\t${rougeS}('¬')${null} Pour éffacer complètement votre compte tapez ${grasRouge}--liberty${null} "
	   necho "\n\t\t\t${gras} Votre choix${null} [ ${grasJaune}"
	   necho "-m${null}${gras} | ${grasRouge}--liberty${null} ${gras}]? : ${grasBleu}  "
	    read choix

	    echo "${null}"
	done

	if [ "$choix" = "-m" ]
	then exit 0
	fi

	clear
  	headDELETE

	necho "\n\n${gras}${blackBg} ${soulign1}Entrez votre mot de passe pour confirmer :${null}${grasJaune} "
	HUMAN_WRITES_THE_PASSWORD_

	#Récupération du Mot de passe de $login #Ce mot de^passe est "Hashé" par mon algorithme de hash
	testPass="$(egrep -w ^"$login" ${_PLAYER}|cut -f2 -d:)"  2>/dev/null

	#Hachage du mot de passe saisie
	pass="$(Tools/cryptMe "$(echo "$pass")"  |tr [:@^] [.1$])"

	i=0
 	while [ "$pass" != "$testPass" ]
 	do
 	 	clear
	  	headDELETE

	  	echo "\n \t\t\t  ${rose}_Mot de passe Incorrect_${null} "
		sleep 1.1

 	 	## i Compteur de tentatives d'essaies
 	 	i=$(expr $i + 1)
 	 	
 	 	if   [ "$(expr $i % 3)" -eq 0 ]
 	 	then clear
 	 		 echo " Tentative de suppression du compte échoué..."; sleep 1.6
 	 		 echo " Redirection vers le menu précedent...";sleep 1.4;
 	 		 exit 0
 	 	fi
 	 	
 	 	necho "\n\n${gras}${blackBg} ${soulign1}Entrez votre mot de passe pour confirmer :${null}${grasJaune} "
		HUMAN_WRITES_THE_PASSWORD_

		#Récupération du Mot de passe de $login #Ce mot de^passe est "Hashé" par mon algorithme de hash
		testPass="$(egrep -w ^"$login" ${_PLAYER}|cut -f2 -d:)"  2>/dev/null

		#Hachage du mot de passe saisie
		pass="$(Tools/cryptMe "$(echo "$pass")"  |tr [:@^] [.1$])"
 	done
}

##################### FOREGROUND DU SUPPRESSION ##############
Suppression()
{
	clear
	headDELETE

	if [ -n  "$2" ]
	then
		necho "\n\n\n\n\n\n\n 		   Suppression${null} ${rose}"
		 echo "$1${null} ${grasRouge}$2${null}\n\n"


		necho "${gras}${soulign2}\n\n\n\n\n---------------------------"
		necho "-----------------------------------------------------${null}"

		sleep 1.6
	else
		necho "\n\n\n\n\n 		   Suppression${null} ${rose}"
		 echo "$1${null} ${grasRouge}$2${null}\n"
		 		
		necho "\t    ${gras}Appuyez sur une ${null}${jauneS}touche${null}${gras} pour "
		 echo "Aller dans ${grasJaune}le menu Principal${null}    "

		necho "${gras}${soulign2}\n\n\n\n\n\n\n---------------------------"
		 echo "${gras}${soulign2}-----------------------------------------------------${null}"
		ReadKeySuppr

	fi
}

############# ALGORITHME DE SUPPRESSION D'UN JOUEUR (BACKGROUND DU SUPPRESSION) #######

delete()
{
	login="$1"
	clear
	#Effacement de l'historique de $login
	Suppression "de l'Historique" $login...
	rm "${_HISTORIQUE}" 


	#Effacement des élements de registre de partie de $login
	Suppression "des Données de Sauvegarde" $login...
	chmod +rwx  "${_SAVE}"*
	sed -i "/^${login}/d" "${_SAVE}"*

	#Effacement de $login dans Datas/joueurs
	Suppression " des Coordonnées de connexion" $login...
	chmod +rwx  "${_PLAYER}"
	sed -i "/^${login}/d" "${_PLAYER}"

	Suppression "${vert}du Compte de  \"${login}\" réussie ✔"

	sleep 1
	./QIUM.sh
	exit 0
} 2>'/dev/null'



SUPPRESSION_DU_COMPTE_

delete "$login" 
		