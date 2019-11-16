#!/bin/sh

login="$1"
#Inclusion du fichier Tools/ImInEveryFile, voyez ceci comme dans le langage C avec les "#include<file.h>" 
. Tools/ImInEveryFile 
#Activation des couleurs, Pour les désactivé il suffira de commenter la ligne suivante [#color]
color
verifyFile

								##################################################
							   ######            ENTÊTE DU FENÊTRE       ##########
							    ##################################################

header()
{
	esp="                            "
	esp1="                            "
	line="$esp$esp1                        "
	echo "${blackBg}$line${gras}"
	necho "${esp}QUATRE "
	necho "${grasVert}INDICES "
	necho "ET "
	necho "${null}${blackBg}${gras}UN "
	necho "MOT${esp1}"


	echo "${grasJaune}${soulign2}"
	necho "________________________________________________________________________________"
	necho "${null}${soulign2}${gras}-----------------------------"

	necho "${null}${gras}"
	necho "${bleuPal} NOUVEAU MOT DE PASSE ${null}"
	necho "${gras}${soulign2}"
	necho "-----------------------------" 
	echo "${null}"
}




								##################################################
							   ###### FONCTION DE SAISIE DU MOT DE PASSE ##########
							    ##################################################



HUMAN_WRITES_THE_PASSWORD_()
{    

	#LA VARIABLE 'BS' PREND PREND LE CARACTÈRE GÉNÉRÉ PAR LA TOUCHE "backspace" 
	BS=$(tput kbs) 	

	###ON DÉSACTIVE LE MODE CANONIQUE ET L'ECHO DES INPUTS 
    stty -icanon -echo
    
    #INITIALISATION DE LA VARIABLE QUI VA PRENDRE LE MOT DE PASSE
    pass=

    #####SAISIE DU MOT DE PASSE
    while true
    do  CHAR=$(head -c1)                  ###LECTURE D'UNE SEULE CARACTÈRE

        case "$CHAR" in

        "$BS")  if [ -n "$pass" ]
        		then   ########LORS DE L'APPUIE SUR LA TOUCHE BACKSPACE, LES ACTIONS SUIVANT SONT FAITES
                    pass=${pass%?}        ###ON SUPPRIME LE DERNIER CARACTÈRE PAR SUBSTITUE
                    printf "\b \b"		  ###ON SUPPRIME LE DERNIER ÉTOILE DANS LA SORTIE STANDARD
                fi 
                ;;

           "")  printf "\n"; break ;;     ###ON AFFICHE UN SAUT DE LIGNE LORS DE L'APPUIE SUR "RETURN" "ENTRER"

            *)  printf '*'			      ###AFFICHAGE D'UNE ÉTOILE PAR SAISIE
                pass="${pass}${CHAR}"  	  #AJOUT DE "CHAR" SUR "pass"
               ;;
        esac
    done

    stty "${_OLDSTTY}" >/dev/null 2>&1    ###RESTAURATION DU MODE NORMAL DU TERMINAL
}



####### MESSAGE (PROMPT ) DE CONFIRMATION_ SI LE JOUEUR VEUT VRAIMENT CHANGER SON MOT DE PASSE #####
CONFIRMATION_()
{
	clear
	header

	necho "\n\n${gras}${blackBg} ${soulign1}Entrez l'ancien mot de passe pour confirmer :${null}${grasJaune} "
	HUMAN_WRITES_THE_PASSWORD_
	heure="$(date +%T)"
	echo "   |\n   |${soulign1}→${null}→ ${heure}: ${rose}TENTATIVE NUMÉRO 1 ${null}" >>"${_SESSIONLOG}"

	#Récupération du Mot de passe de $login #Ce mot de^passe est "Hashé" par mon algorithme de hash
	testPass="$(egrep -w ^"$login" ${_PLAYER}|cut -f2 -d:)"  2>/dev/null

	#Hachage du mot de passe saisie
	pass="$(Tools/cryptMe "$(echo "$pass")"  |tr [:@^] [.1$])"

	i=0   |\n   |${soulign1}→${null}
 	while [ "$pass" != "$testPass" ]
 	do
 		heure="$(date +%T)"
		echo "    | \n   ${soulign1} ${null}|→→ ${heure} : ${rougeS}MOT DE PASSE INCORRECT${null}\n   |" >>"${_SESSIONLOG}"
 	 	clear
	  	header
	  	echo "\n\t\t\t    ${rose}_Mot de passe Incorrect_${null} "
	  	necho "\n${gras}\t     Si vous voulez retourner dans le ${grasBleu}"
		 echo "_MENU COMPTE_${null} tapez ${grasJaune}-m${null}"
		sleep 1.1

 	 	## i Compteur de tentatives d'essaies
 	 	i=$(expr $i + 1)
 	 	
 	 	if   [ "$(expr $i % 3)" -eq 0 ]
 	 	then clear
 	 		 heure="$(date +%T)"
 			 echo "   |\n   |→${grasRouge}${italic} Tentative de changement du mot de passe échoué${null}\n  /\n  |\n  |\n /" >>"${_SESSIONLOG}"

 	 		 echo " Tentative de changement du mot de passe échoué..."; sleep 1.6
 	 		 echo " Redirection vers le menu précedent...";sleep 1.4;
 	 		 exit 0
 	 	fi
 	 	
 	 	necho "\n\n${gras}${blackBg} ${soulign1}Entrez votre mot de passe pour confirmer :${null}${grasJaune} "
		HUMAN_WRITES_THE_PASSWORD_

		#Récupération du Mot de passe de $login #Ce mot de^passe est "Hashé" par mon algorithme de hash
		testPass="$(egrep -w ^"$login" ${_PLAYER}|cut -f2 -d:)"  2>/dev/null
		
		if [ "$pass" = "-m" ]
		then
				necho "   |\n   |→→ ${heure}: ${bleu}RETOUR VERS L'INTERFACE " >>"${_SESSIONLOG}"
				printf "MENU(Fin de Modification" >>"${_SESSIONLOG}"
				echo " du mot de passe)${null}\n  /\n  |\n  |\n /" >>"${_SESSIONLOG}"
				exit 0
		fi
		#Hachage du mot de passe saisie
		pass="$(Tools/cryptMe "$(echo "$pass")"  |tr [:@^] [.1$])"
		echo "   |\n   |${soulign1}→${null}→ ${heure}: ${rose}TENTATIVE NUMÉRO "$(expr $i + 1)" ${null}" >>"${_SESSIONLOG}"
 	done
}






			   ###############################################################################################################
               ######################              CRÉATION DU NOUVEAU MOT DE PASSE               ############################
               ###############################################################################################################




################ VERIFICATION DE CE QUI EST SAISIE PAR L'UTILISATEUR   ###########
VERIFY_HUMAN_PASSWORD_IF_ITs_LEGAL_()
{
	
	if [ "$nbchar" -eq 0  ]
	then clear
		 THEN_HUMAN_CREATE_A_NEW_PASSWORD_ '_0char'
		 exit 0

	elif [ "$_My_New_Password" = "-m" ] 
	then exit 0

	elif [ "$nbchar" -lt 4 ]
	then clear
		 THEN_HUMAN_CREATE_A_NEW_PASSWORD_ '_short'
		 exit 0

	fi

	if [ "$_My_New_Password" = "$login" ]
	then clear		
		 THEN_HUMAN_CREATE_A_NEW_PASSWORD_ '_diff'
		 exit 0

	fi
}

#fonction pour resaisir le mot de passe 
CONFIRM_HUMAN_PASSWORD_()
{
	heure="$(date +%T)"
	clear
	header

	if 	 [ -z "$1" ]
	then
		###ECRITURE DANS LE "LOG"
	 	echo "   |\n   |→→ ${heure} : ${bleu}${italic}CONFIRMATION DU NOUVEAU MOT DE PASSE${null}" >>"${_SESSIONLOG}"
			     		  
	elif [ "$1" = '_new' ]
	then
		necho "\n \t\t\t ${rougeS}_Mot de Passe Incorrect_${null}"
		sleep 1
		necho "\n \t  Des difficultés? tapez ${grasJaune}--new"
		 echo "${null} pour créer un nouveau mot de passe"
		sleep 0.5

	elif [  "$1" = '_0char' ]
	then
		necho "\n \t\t\t  ${rose}_Vous n'avez rien saisie_${null}\n "
		sleep 1.5
	fi

	necho "\n\n ${null}${soulign1}${gras}Mot de Passe:${null}${grasJaune}  ********${null} "

	necho "\n\n${gras}${blackBg} ${soulign1}Confirmer le Mot de Passe:${null}${grasJaune} "
	
	#SAISIE DU MOT DE PASSE#
	HUMAN_WRITES_THE_PASSWORD_
	_Confirm_My_New_Password="${pass}"
	echo "${null}"
	#FIN DE LA SAISIE#

	nbchar="$(expr length "$_Confirm_My_New_Password")"

	if [ "$nbchar" -eq 0 ]
	then
		clear
		CONFIRM_HUMAN_PASSWORD_ '_0char' ; exit 0

	elif [ "$_Confirm_My_New_Password" = "--new"  ]
	then
		clear
		retour=0

		###ECRITURE DANS LE "LOG"
		heure="$(date +%T)"
		printf "  |\n  |__${heure} : ${rose}NOUVEAU MOT DE PASSE OUBLIÉ, CREATION D'UN NOUVEAU${null}\n" >>"${_SESSIONLOG}"
		THEN_HUMAN_CREATE_A_NEW_PASSWORD_ ; exit 0
		
	elif [ "$_Confirm_My_New_Password" != "$_My_New_Password" ]
	then
		clear
		CONFIRM_HUMAN_PASSWORD_ '_new' ;exit 0

	elif [ "$_Confirm_My_New_Password" = "$_My_New_Password"  ]
	then
		necho "\n \t\t\t Mot de passe Confirmé ${vert}✔${null}\n"
		sleep 1.5

		#Hachage du mot de passe saisie
		_My_New_Password="$(Tools/cryptMe "$(echo "$_My_New_Password")"  |tr [:@^] [.1$])"

		######MIS-À-JOUR DES COORDONNÉES DE CONNEXION DE $login le délimiteur est '#'
		sed -i "s#\(^${login}\):\(.\+\):\(.\+\)#\1:${_My_New_Password}:\3#" "${_PLAYER}" #>/dev/null 2>&1
	             	                                   sort -o "${_PLAYER}" "${_PLAYER}" #>/dev/null 2>&1
	
		heure="$(date +%T)"
		###ECRITURE DANS LE "LOG"
		printf "  /\n /\n_|__${heure} : ${jauneS}CHANGEMENT ENREGISTRÉE ${vert}✔${null}\n|" >>"${_SESSIONLOG}"

		  necho "\n\t\t\t${gras}Appuyez sur une ${null}${jauneS}touche${null}${gras} pour "
	echo "continuer...${null}    "


	necho "${grasJaune}${soulign2}\n________________________________"
	necho "________________________________________________${null}"

	 stty raw; touche=$(head -c 1); stty sane

	sleep 0.1
	fi
}






						  ########################################################################################
						 ####################### FONCTION PRINCIPAL DU FICHIER  ###################################
						  ########################################################################################




THEN_HUMAN_CREATE_A_NEW_PASSWORD_()
{
	heure="$(date +%T)"
	clear
	
	header
	if   [ -z "$1" ]
	then
		###ECRITURE DANS LE "LOG"
		printf "   |\n   |→→ ${heure} : ${bleu}CRÉATION DU NOUVEAU MOT DE PASSE\n${null}" >>"${_SESSIONLOG}"

	elif [  "$1" = '_0char' ]
	then
		necho "\n \t\t\t  ${rose}_Vous n'avez rien saisie_${null}\n "
		printf "   |\n   |→→ ${heure} : ${rose}RIEN N'A ÉTÉ SAISIE\n${null}" >>"${_SESSIONLOG}"
		sleep 1.5
		
	elif [ "$1" = '_short' ]
	then
		necho "\n \t\t\t  ${rose}_Mot de Passe trop courte_${null} \n"
		sleep 1.5

	elif [ "$1" = '_diff' ]
	then
		echo "\n\t     ${rougeS}_Le Mot de passe doit être différent du nom d'Utilisateur_${null}"
		sleep 1.5
	fi

	necho "\n\n${blackBg}${soulign1}${gras} Entrez le nouveau Mot de Passe :${null}${grasRouge}  "

	#APPEL DE LA FONCTION QUI LIT LE MOT DE PASSE
	HUMAN_WRITES_THE_PASSWORD_ ;	_My_New_Password="${pass}"

	#Nombre de carractères du mot de passe
	nbchar="$(expr length "$_My_New_Password")"
	
	#VÉRIFICATION DU MOT DE PASSE SAISIE
	VERIFY_HUMAN_PASSWORD_IF_ITs_LEGAL_

	#CONFIRMATION_ DU MOT DE PASSE
	CONFIRM_HUMAN_PASSWORD_
}

 
			   ###############################################################################################################
               ######################            FIN DE LA DÉCLARATION DES FONCTIONS             #############################
               ###############################################################################################################


necho " \ \n  \ \n   |→→ ${jauneS}${italic}OUVERTURE DE L'UTILITAIRE DE" >>"${_SESSIONLOG}"
 echo " CHANGEMENT DE MOT DE PASSE${null}" >>"${_SESSIONLOG}"
CONFIRMATION_
echo "   |\n   |→→ ${heure} : ${vert}MOT DE PASSE CORRECTE${null}" >>"${_SESSIONLOG}"
THEN_HUMAN_CREATE_A_NEW_PASSWORD_
		