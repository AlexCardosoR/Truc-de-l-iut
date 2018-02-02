#!/bin/sh



send(){
	printf = "$1\r\n"
}

renvoyer_url(){
	local url="$1"
	local fichier="/home/etud/alcardosor/Desktop/2A/Service\ Réseau/TP3$url"
	local taille=$(cat $fichier | wc -b)
	send 'HTTP\1.1 200 OK'
	send "Content-Length: $taille"
	send "Content-Type: $(file -L -b --mime-type $fichier)" 
	send ''
	
	if [ !-e "$fichier" ]; then
		printf " $fichier n'existe pas \r"
	else
		send $url
	fi
}



read methode arg version
case $methode in 
		GET) printf "error 404 not found"
		;;
		*) renvoyer_url arg version
		;; 
esac

