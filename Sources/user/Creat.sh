#!/bin/sh
#Fichier ; Creat.sh
#Création d'un nouveau compte
#QIUM : veut dire "QUATRE INDICES ET UN MOT"
#Dans ce Script les fonctions sont tous récursives


arg1="$1" #Réception d'un argument qui est un username

#Inclusion du fichier Tools/ImInEveryFile, voyez ceci comme dans le langage C avec les "#include<file.h>" 
. Tools/ImInEveryFile
#Activation des couleurs, Pour les désactivé il suffira de commenter la ligne suivante [#color]
color
verifyFile

#####INCLUSION DE FICHIER CONTENANT LES FONCTIONS DE CE SCRIPT
. Tools/Include/Creat 




            #################################################################################################################################
            ####################################################DESCRIPTION DU JOUEUR########################################################
            #################################################################################################################################


                                    ######Fonction qui lit la description du joeur (F. PRINCIPAL)########
DESCRIPTION_DU_JOUEUR_()
{
	clear
	DESCR_ANNEE_

	clear
	DESCR_E_MAIL_

	clear
	Sexe_H_F_

	clear
	header

	blankSpace='                                                                                '
	blankSpace1='                             '
	blankSpace2='                               '
	blankSpace3='                                                                 '
   necho "${blackBg}"
	echo "$blankSpace$blankSpace"
	echo "${grasBleu}${blankSpace1}INSCRIPTION RÉUSSIE${blankSpace2}${blackBg} "
   necho "$blankSpace"
   necho "\n${italic}${bleuPal}Les informations que nous avons"
	echo " réceuilli vont Servir à reinitialiser votre mot "
	echo "de passe si vous l'oubliez, et serviront aussi à changer le Mot de passe si vous"
	echo "en avez besoin.$blankSpace$blankSpace$blankSpace3"

	echo "${null}"
   necho "\t  ${redBg}         ${gras}Nom d'utilisateur  :${grasJaune}"
	echo "  $login                       ${null}";sleep 0.5

   necho "\t    ${blackBg}       ${gras}Mot de Passe${null}${gras}${blackBg}    "
	echo "   :${grasJaune}  *******                         ${null} ";sleep 0.5

   necho "\t${redBg}          ${gras}Année de naissance :${grasJaune}"
	echo "  $annee                            ${null}";sleep 0.5

    necho "\t   ${blackBg}     ${gras}Email${null}${gras}${blackBg}     "
    echo "       :${grasJaune}  $email        ${null}";sleep 0.5

	necho "\t  ${redBg}          ${gras}Sexe${null}${gras}${redBg}        "
	echo "           :${grasJaune}  $sexe                               ${null}";sleep 0.5



	_OldSttySetting="$(stty -g)";	stty -echo; stty raw; 
	          necho "\n\n\t\t\t${grasBleu}Appuyez sur une touche pour continuer...${null} "
	         touche="$(head -c1)"
	           stty "$_OldSttySetting"
	           echo ""


	#Hachage du mot de passe saisie
	pass="$(Tools/cryptMe "$(echo "$pass")"  |tr [:@^] [.1$])"

    _TIRAGES=".Datas/.historique/historique_${login}/tirage.dat"
 _SESSIONLOG=".Datas/.historique/historique_${login}/session.log"

	_UID="$(tail -1 '.Datas/.GENERAL/.UID')"	
	_DUID=".Datas/.GENERAL/.UID"	
	_UID="$(expr ${_UID} + 127)"
	
	echo "${_UID} ${login}" >>".Datas/.GENERAL/.PUID"    #IDENTIFICATEUR DE CHAQUE JOUEUR
	echo "${_UID}" >>".Datas/.GENERAL/.UID"				#SAUVEGARDE DU UID

  	   echo "${login}:${pass}:${sexe}|${annee}|${email}" >>"${_PLAYER}"
	sort -o "${_PLAYER}" "${_PLAYER}" >/dev/null 2>&1
	
	   echo "${login}:10:1:1"  >>"${_SAVE}1"      			#Le joueur débute avec une score de 10 points,niveau 1, tirage N°1
	sort -o "${_SAVE}1" "${_SAVE}1" >/dev/null 2>&1			#On tri le fichier pour une recherche plus rapide
	
	#Création des répertoire et fichier personnel du joueur
	   mkdir -p ".Datas/.historique/historique_${login}"

	       jour="$(date +%A|tr a-z A-Z)"
	      heure="$(date +%T)"
	dateComplet="$(date +%x)"

	#Fichier qui prend la date et le jour de chaque nouvelle connexion
	echo "${vert}\\ \n|__________________${grasJaune}INSCRIPTION FAIT LE $jour $dateComplet à $heure${null}">"${_SESSIONLOG}"
	
	touch "${_TIRAGES}"  #Fichier qui garde les identifiants des tirages déjà joué du joueur

	##UNE PETITE ANIMATION AVANT L'OUVERTURE DU SESSION
	Tools/defilement.sh "$login"
	Sources/interfaceMenu.sh "$login" "$genre"
	exit 0
	
}

###LES FICHIERS


                      ###############################################################################################################
                      #########################################DÉBUT DE L'ALGORITHME PRINCIPAL#######################################
                      ###############################################################################################################



clear
retour="0"
#Si le script reçoit un argument ( qui sera un login)
#Alors cet argument sera insérer dans la variable "login"
if [ -n "$arg1" ]
then
	login="$arg1"
	LECTURE_DU_MOT_DE_PASSE_
	exit 0
fi

clear
LECTURE_DU_LOGIN_

retour="0"
clear
LECTURE_DU_MOT_DE_PASSE_

#EOF
