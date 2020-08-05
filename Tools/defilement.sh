. Tools/ImInEveryFile

color
retour=0

rainbow()
{
	m=40
	n=47
	for j in `seq ${m} ${n}`;do necho "\e[${j}m";	
		for i in `seq 1 80`;do necho ' ' ;done;
		echo ""; sleep 0.01; necho "${null}"
	done

	m=100
	n=107
	for j in `seq ${m} ${n}`;do necho "\e[${j}m";
		for i in `seq 01 80`;do necho ' ';done;echo; sleep 0.01;necho "${null}"
	done

	m=40
	n=47
	esp="                            "
	esp1="                            "
	line="$esp$esp1                        "
	bgWhite='\e[47m'

	for j in `seq ${n} -1 ${m}`;do necho "\e[${j}m"		
		for i in `seq 01 81`
		do
			if [ "${j}" = "40" ]
			then
				echo "\n$line${null}${blackBg}${gras}"
				necho "${esp}QUATRE "
				necho "${grasVert}INDICES "
				necho "ET "
				necho "${null}${blackBg}${gras}UN "
				echo "MOT${esp1}${soulign1}${grasVert}"
				
				necho "${soulign1}"
				necho "___________________________________________________"
				necho "_____________________________"
				necho "\n${null}${bgWhite}${line}${null}"
				break
			elif [ "${j}" = "41" ]
			then 
				if [ "$i" = 1 ]
				then necho "${soulign1}${bgWhite}${grasVert}\n"
				else necho '_'
				fi
			else 
				if [ "$i" = 1 ]
				then echo 
				else necho ' '
				fi
			fi
		done;sleep 0.01
		necho "${null}"
	done
}

##Printing the welcome message
_blank()
{
	m=01
	n=10
	for j in `seq ${n} -01 ${m}`;do		
		if [ "$j" -eq 1 ];then	necho "${message}";fi
		echo ""; sleep 0.01; necho "${null}"
	done

	n=9
	for j in `seq ${n} -01 ${m}`;do		
		if [ "$j" -eq 1 ]
		then 
			necho "${soulign1}___________________________________________"
			necho "_____________________________________"
		fi
		echo ""; sleep 0.01; necho "${null}"
	done
}

######Configure Salutation
case "$(date +%H)" in
	06|07|08|09|10|11|12)salutation="Bonjour";;
					   *)salutation="Bonsoir";;
esac

login="$1"
if [ "$(expr length $login)" -le 12 ]
then
	message="\t\t\t\t${gras}${salutation}${grasBleu} $login"
else
	message="\t\t\t${gras}   ${salutation}${grasBleu}    $login"
fi

rainbow

_blank

sleep 1.5
		