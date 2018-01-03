#!/bin/bash
#set -xe
#iplocater.sh

INPUT=$1
DIR=/tmp/test1.txt

function fetch(){
        curl -s https://tools.keycdn.com/geo.json?host={$INPUT} | \
	sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | \
	grep 'isp\|country_name\|city\|ip\|latitude\|longitude' | \
	sed -e 's/"/''/g' | sed -e 's/:/=/g'> $DIR 
cat $DIR
rm $DIR
}

function usage {

    echo -e "Usage: IPLocator [OPTIONS]";
    echo -e "\t-h | --help\tShow the help"
    echo -e "\t-v | --version\tVersion Infomation"
    echo -e "\t-u | --usage \t Usage "
}

function msg {
    
    echo   
    echo -e "\t -iplocator [domain-name] [i.e www.example.com or example.com]"
    echo -e "\t -iplocator [IP]  [i.e 127.0.0.1]"
}

function check {

	#if [[ -n "$1" ]]; then
	
	if [ "$1" != "" ]; then 
	   	echo  // $1 cannot be empty because it does not exist
	else
		fetch
	fi	
}

while true; do

    case $1 in

	-h|--help)     usage; exit;;
	-u|--usage)     msg; exit;;
	-v|--version)  cat "$INSTALL_DIR.version"; exit;;
	*)            check; exit;;
    esac
done

fetch
