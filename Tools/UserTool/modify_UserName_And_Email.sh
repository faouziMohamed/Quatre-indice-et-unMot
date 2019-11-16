#!/bin/sh

login="$1"
NewLogin=
#Inclusion du fichier Tools/ImInEveryFile, voyez ceci comme dans le langage C avec les "#include<file.h>" 
. Tools/ImInEveryFile
#Activation des couleurs, Pour les désactiver il suffira de commenter la ligne suivante "#color" 
color
verifyFile

#####INCLUSION DE FICHIER CONTENANT LES FIONCTIONS DE CE SCRIPT
. Tools/Include/modify_UserName_And_Email



               ##########################################################################################################################
               ############################################PARTIE DE CONTRÔLE DU LOGIN###################################################
               ##########################################################################################################################




					  ##################################################################################
                      ##################Création du nom d'utilisateur (F. PRINCIPAL)####################
                      ##################################################################################
USER_NAME_()
{
	nbchar=0
	nbWord=0
	
	headerUsername

	if   [ "$1" = '_exist' ]
	then
		 necho "\n\t\t   ${rougeS}_Le nom d'utilisateur ${bleu}"
		  echo "\"$testLog\"${null}${rougeS} existe déjà_${null}"
		
		 necho "\t\t\t\t   ${italic}${vert}Créez-en un autre ${null}"
		 sleep 1

	elif [ "$1" = '_Mamnou3' ]
	then
		 necho "\n\t\t  ${gras}_Les caractères suivants '${bleu}-${null}${gras}'"
		 necho " '${bleu}:${null}${gras}' ${grasRouge}sont interdits${null}_"
		 sleep 1

	elif [ "$1" = '_short' ]
	then
		 necho "\n\t ${gras}_Le Nom d'utilisateur ${grasRouge}"
		 necho "ne doit pas avoir moins de 4 caractères_${null}\n"
		 sleep 1

    elif [ "$1" = '_long' ]
    then
		 necho "\n\t ${gras}_Le Nom d'utilisateur ${grasRouge}"
		 necho "ne doit pas avoir plus de 14 caractères_${null}\n"
		 sleep 1		

	elif [ "$1" = '_space'  ]
	then
		 necho "\n\t    ${gras}_Le nom d'utlisateur ${grasRouge}"
		 necho "ne doit pas contenir des espaces !!_${null}\n"
		 sleep 1
	fi

	RETOURNER_MENU_PRECEDENT_
	if  [ "$retour" -eq 0 ]
	then
	    ####ECRITURE DANS LA LE "LOG"
	    heure="$(date +%T)"
	    ###ECRITURE DANS LE "LOG"
	    echo "  |\n  \__${heure} : ${bleu}MODIFICATION DU NOM D'UTILISATEUR${null}" >>"${_SESSIONLOG}"
	fi

	#############################################################################
	###############L'utilisateur va saisir le nom d'utilisateur #################
	necho "\n${gras}${blackBg} ${soulign1}Nom d'utilisateur:${null}${grasJaune}  "
	read NewLogin
	echo "${null}"
	retour=1

	#Nombre de caractère et Nombre de Mots
	nbchar="$(expr length "$NewLogin")"
	nbWord="$(echo "$NewLogin"| wc -w)"

	#Vérificaton si le NewLogin ne contient pas caractère interdits et autres
	VERIFIER_LES_ERREURS_DU_USER_NAME_

	##Recherche du NewLogin dans de le fichier .Datas/Joueurs
	testLog="$(egrep -w ^"$NewLogin" '.Datas/Joueurs'|cut -f1 -d:)"

	#Vérification si le NewLogin n'existe pas déjà
	if   test "$NewLogin" = "$testLog"
	then
		clear
		necho "   |\n   |→→ ${heure}: ${rose}LOGIN EXISTANT${null}" >>"${_SESSIONLOG}"
		USER_NAME_ '_exist'
		return 0
	fi

	heure="$(date +%T)"
	###ECRITURE DANS LE "LOG"
	echo "   |\n   |→→ ${heure} : ${vert}LOGIN CORRECT${null}" >>"${_SESSIONLOG}"
	echo "  /\n /\n_|__${heure} : ${jauneS}CHANGEMENT ENREGISTRÉE ${vert}✔${null}\n|" >>"${_SESSIONLOG}"
	
	USER_NAME_CHANGED_THEN_UPDATE_FILES_


	echo "\n\n\n\t\t\t${jauneS}      CHANGEMENT ENREGISTRÉE ${vert}✔${null}"
	echo "   ${jauneS}      LES MODIFICATIONS SERONT PRISES EN COMPTE LORS DU PROCHAIN CONNEXION${null}"
   necho "\n\t\t\t${gras}Appuyez sur une ${null}${jauneS}touche${null}${gras} pour "
	echo "continuer...${null}    "


	necho "${grasRouge}${soulign2}\n\n\n\n________________________________"
	necho "________________________________________________${null}"

	 stty raw; touche=$(head -c 1); stty "$_OLDSTTY"

	sleep 0.1

	clear
	headerUsername
	necho "\n\n\n\n\n\n\n\n\t\t\t\t"
	echo "${italic}RECONNEXION....${null}"
	sleep 0.6

	Sources/interfaceMenu.sh "${NewLogin}"
	
	exit 0

}






						##############################################################		
						############ FONCTION POUR CHANGER L'ADRESSE E-MAIL ##########
						##############################################################



USERMAIL_()
{

	HEADER_USERMAIL_

	if   [ "$1" = '_0char' ]
	then
		 necho "\n \t\t\t ${null} ${rose}_Vous n'avez rien saisie_${null}\n "
		 sleep 1.5

	elif [ "$1" = '_inc' ]
	then
		 echo "\n \t\t\t  ${rose}_Adresse E-mail Incorrect_${null} "

	fi

		RETOURNER_MENU_PRECEDENT_
	if  [ "$retour" -eq 0 ]
	then
	    ####ECRITURE DANS LA LE "LOG"
	    heure="$(date +%T)"
	    ###ECRITURE DANS LE "LOG"
	    echo "  |\n  \__${heure} : ${bleu}MODIFICATION DE L'ADRESSE EMAIL${null}" >>"${_SESSIONLOG}"
	fi
	retour=1

	_OLD_EMAIL="$(egrep -w ^"$login" '.Datas/Joueurs'|cut -f3 -d:|cut -f3 -d'|')"
	echo "\n ${soulign1}${gras}Nom d'utilisateur  :${null}${grasJaune}  $login ${null}"
    echo " ${soulign1}${gras}Email${null}${gras}              :${grasJaune}  ${_OLD_EMAIL} ${null}"

    necho "\n${blackBg} ${gras}${soulign1}Entrez le nouvel Adresse E-mail :"
    necho "${null}${grasRouge}${italic}  "
	read email

	echo "${null}"
	nbchar=$(expr length "$email")

	if   [ "$nbchar" -eq 0 ]
	then 
		 clear		
		 
		 USERMAIL_ '_0char' ; exit 0 #Appel de la fonction 'USERMAIL_'

	elif [ "$email" = "-m" ]
	then return 0

		 #Vérification si "$email" est un adresse email valide
		 #valide : s'Il y'a une chaine avant et après le '@'
		 #valide : s'il y'a le '.' après une chaine qui est après le '@'
		 #valide : s'il n'y a pas d'espaces dans l'email
	elif ((echo "$email"|egrep ".+@"             ) >/dev/null 2>&1 )&&\
		 ((echo "$email"|egrep "@.+\..+"         ) >/dev/null 2>&1 )&&\
		 ((test "$(echo "$email"|wc -w )" -eq 1  ) >/dev/null 2>&1 )
	then

		echo "\n\t\t\tNouvel Adresse E-mail Correct ${vert}✔${null}"
		#ECRITURE DANS LE LOG
		necho "  |\n  \__${heure} : ${gras}EMAIL → Tentative N° ${i} :${null}" >>"${_SESSIONLOG}"
		echo  "${vert}Adresse E-mail Correct ${vert}✔${null}" >>"${_SESSIONLOG}"

		#ON TRANSFORME TOUS LES MAJUSCULES EN MINISCULES 
		email="$(echo "$email"|tr A-ZÀÉÈÛÔÇÎÏ a-zàéèûôçîï)" >/dev/null 2>&1

		EMAIL_CHANGED_THEN_UPDATE_USER_S_DATAS_

		echo "\t\t\t${jauneS}      CHANGEMENT ENREGISTRÉE ${vert}✔${null}"

		###ECRITURE DANS LE "LOG"
		heure="$(date +%T)"
		echo "   /\n  /\n_|__${heure} : ${jauneS}CHANGEMENT ENREGISTRÉE ${vert}✔${null}\n|" >>"${_SESSIONLOG}"

	   necho "\n\t\t\t${gras}Appuyez sur une ${null}${jauneS}touche${null}${gras} pour "
		echo "continuer...${null}    "

		necho "${grasJaune}${soulign2}\n________________________________"
		necho "________________________________________________${null}"

		 stty raw; touche=$(head -c 1); stty "$_OLDSTTY"

		sleep 0.1
				

	else
		clear 

		#ECRITURE DANS LE LOG
		necho "  |\n  \__${heure} : ${gras}EMAIL → Tentative N° ${i} :${null}" >>"${_SESSIONLOG}"
		echo  "${rougeS}Adresse E-mail incorrect${null}" >>"${_SESSIONLOG}"

		i="$(expr $i + 1)"
		USERMAIL_ '_inc' #Appel de la fonction 'USERMAIL_'
		exit 0 
	fi
}


clear
retour=0
i=1
if   [ "$2" = "--name" ]
then 
	echo " \ \n  \ \n  |→→ ${jauneS}${italic}OUVERTURE DE L'UTILITAIRE DE MODIFICATION DU NOM D'UTLISATEUR${null}">>"${_SESSIONLOG}"
	USER_NAME_
else 
	echo " \ \n  \ \n  |→→ ${jauneS}${italic}OUVERTURE DE L'UTILITAIRE DE MODIFICATION DE L'EMAIL${null}">>"${_SESSIONLOG}"
	USERMAIL_
fi

		