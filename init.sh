#!/bin/bash

confirm ()
{
	read -r -p "${1:-Are you sure? [y/N]} " response
	case $response in 
		[yY][eE][sS]|[yY])
			true
			;;
		*)
			false
			;;
	esac
}

progressfilt ()
{
	local flag=false c count cr=$'\r' nl=$'\n'
	while IFS='' read -d '' -rn 1 c
	do
		if $flag
		then
			printf '%s' "$c"
		else
			if [[ $c != $cr && $c != $nl ]]
			then
				count=0
			else
				((count++))
				if ((count > 1))
				then
					flag=true
				fi
			fi
		fi
	done
}

endMessage () 
{
	echo "Done. Nothing was ${1:-installed}."
}

command -v wget >/dev/null 2>&1 || { echo >&2 "Sorry, Wget needs to be installed. Please install it and try again. Aborting."; exit 1; }

echo "============ ADMINER INSTALLATION ============"
if confirm "Do you want to install Adminer ? [y/N]"; then
	mkdir ./www/adminer
	echo "=> Downloading Adminer..."
	wget --progress=bar:force http://www.adminer.org/latest.php 2>&1 -O ./www/adminer/index.php | progressfilt && echo "=> Adminer installed."
	echo
	if confirm "Do you want to add a pretty theme with it ? [y/N]"; then
		echo "=> Downloading Adminer pretty design..."
		wget --progress=bar:force https://raw.githubusercontent.com/vrana/adminer/master/designs/pappu687/adminer.css 2>&1 -O ./www/adminer/adminer.css | progressfilt && echo "=> Theme installed."
	else
		endMessage "added"
	fi
	echo
	echo Adminer is installed.
else
	endMessage
fi