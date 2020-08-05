#!/bin/sh

login="$1"
. Tools/ImInEveryFile 

color
verifyFile

. Tools/Include/Account

 jour="$(date +%A)"
 date="$(date +%x)"

LECTURE_DU_CHOIX_()
{
    necho "${null}${gras}\n Votre choix : ${null}${grasJaune}"
    trap " clear ; detournerSIGINT ; exit 0 " 2
    read choix
    echo "${null}"
    nbchar=0
    nbchar="$(expr length "$choix")"

    if [ "$nbchar" -eq 0 ]
    then 
        echo " \t\t\t\t${null}${rose}_Vous n'avez rien saisie_${null} "
        sleep 1.5
        clear
        MENU_DES_JOUEURS_CONNECTES_
        LECTURE_DU_CHOIX_
    fi
    trap 2
}

CHOIX_SELECTIONNEE_()
{
    case "$choix" in
        1) echo "\t\t\t ${grasBleu} Changer le mot de passe${null}"
           sleep 0.5
           necho " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 1">>"${_SESSIONLOG}"
           echo  " : ${bleu}CHANGER LE MOT DE PASSE${null}">>"${_SESSIONLOG}"

           clear 
           Tools/initialise/NewPassword.sh "${login}"
           exit 0;;
        2) echo "\t\t\t ${grasBleu} Modifier le nom d'utilisateur${null}"
           sleep 0.5
           necho " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 2">>"${_SESSIONLOG}"
        echo " : ${bleu}MODIFIER LE NOM D'UTILISATEUR${null}">>"${_SESSIONLOG}"

           clear 
           Tools/UserTool/modify_UserName_And_Email.sh "${login}" "--name"
           exit 0;;

        3) echo "\t\t\t ${grasBleu} Changer l'adresse E-mail${null}"
           sleep 0.5
           necho " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 3 :">>"${_SESSIONLOG}"
           echo " ${bleu}MODIFIER L'ADRESSE E-MAIL${null}">>"${_SESSIONLOG}"

           clear
           Tools/UserTool/modify_UserName_And_Email.sh "${login}"
           exit 0;;

        4) echo "\t\t\t ${grasBleu} Supprimer mon compte${null}"
           sleep 0.5
           clear
           necho " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 4 :">>"${_SESSIONLOG}"
           echo " ${bleu}SUPPRIMER MON COMPTE${null}">>"${_SESSIONLOG}"

           Tools/UserTool/DELLUSER.sh "${login}"
           clear
           MENU_DES_JOUEURS_CONNECTES_
           exit 0;;

        5) echo "\t\t\t ${grasBleu} Retourner dans le Menu précedent${null}"
           sleep 0.5
           clear
           necho " |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO 5 :">>"${_SESSIONLOG}"
           necho " ${bleu}RETOUR VERS L'INTERFACE MENU">>"${_SESSIONLOG}"
           echo  "${null}\n /\n/">>"${_SESSIONLOG}";;

         *) necho " \t\t\t\t${rougeS}_Choix incorect_${null}"
            sleep 0.7
            necho " |\n |→→ ${whiteBgGrasNoir}CHOIX NUMÉRO * ">>"${_SESSIONLOG}"
            echo ": ${rose}CHOIX INCORRECT${null}">>"${_SESSIONLOG}"

            clear
            MENU_DES_JOUEURS_CONNECTES_
            exit 0;;
    esac
}

clear
if   [ "$2" = '--hist' ]
then
    HISTORIQUE_PERSONNEL_
    ReadKey

elif [ "$2" = '--myAcnt' ]
then
    necho "\ \n \ \n |→→ ${grasJaune}AFFICHAGE">>"${_SESSIONLOG}"
    echo  " DE L'INTERFACE MON COMPTE${null}\n |">>"${_SESSIONLOG}"
    MENU_DES_JOUEURS_CONNECTES_
fi
