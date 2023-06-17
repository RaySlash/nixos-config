#!/bin/bash

nix_home="/etc/nixos"
homemgr_home="/home/$USER/.config/home-manager"

copy() {
	sudo cp $nix_home/* nixos/
	cp $homemgr_home/* home-manager/
}

install() {
	sudo cp nixos/* $nix_home/
	cp home-manager/* $homemgr_home/
	sudo nixos-rebuild switch --upgrade
	home-manager switch
}

help() {
	printf "Pass an argument to use the script\n
ARGS			DESCRIPTION\n
-c			Copy all current host configs to this repo.\n
-i			Install all configs in the repo to the host.\n
-h			Print this message.\n"	
}

if [[ "$1" == "-c" ]]; then
	copy
elif [[ "$1" == "-i" ]]; then
	install
elif [[ "$1" == "-h" ]]; then
	help
else
	printf "[X] Run bash fetch.sh -h to view arguments"
fi
