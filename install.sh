#!/usr/bin/sh

function manage_existing_link {
	local option=''
	
	echo [b] Backup existing and install new
	echo [s] Skip file installation and use existing
	printf "[o] Remove existing and install new \033[s\n"

	while true
	do
		read  -sn1 option
		case $option in
			b)
				return 2
				;;
			s)
				return 0
				;;
			o)
				printf "\033[u\033[1A --> [ \033[32m Return to confirm\033[0m / \033[31mOther to cancel \033[0m ]\033[1B\r\033[K"
				read -sN1 option
				printf "\033[u\033[1A\033[K\033[1B\r\033[K"
				[ "$option" = $'\x0a' ] && return 1
				;;
			*)
				printf "\033[1K\r\033[31mInvalid option \"$option\""
				;;
		esac
	done
}

function backup_dot_file {
	local dest=$1_$(date +%y%m%d%H%M%S)
	if mv $1  $dest
	then
		printf " [backed up] ($dest)"
	else
		>&2 echo "Error backing up. [abort]"
		return 1
	fi
}

function create_link {
	echo " installed $1 -> $2"
	ln -s $1 $2
}

function create_links {
    local target_base=$(realpath dotfiles)
    local target=''
	local skip=''

	local targets_list=($(find $target_base -mindepth 1 -exec realpath --relative-to=$target_base {} \;))
    for target in ${targets_list[@]}
    do
		local path=$HOME/$target
		local b_create=1

		printf "\033[32m$target\033[0m"

		if [[ -n $skip && "$target" =~ ^"$skip" ]]
		then
			printf " already installed ($skip)"
			b_create=0
		elif [ -e $path ]
		then 
			if [[ -L $path && "$(readlink -f $path)" =~ ^"$target_base" ]]
			then
				printf " already installed"
				skip=$target
				b_create=0
			else
				echo " already exists"
				manage_existing_link $path
				b_create=$?
				printf "\r\033[K\033[A\033[K\033[A\033[K\033[A\033[K\033[A\033[K"
				printf "\033[32m$target\033[0m already exists"
			fi
		fi
		
		if [ "$b_create" -eq 2 ] 
		then
			backup_dot_file $target_base/$target
		fi

		if [ ! $? ] || [ "$b_create" -eq 0 ] 
		then
			echo ' [skipped]'
		else
			create_link $target_base/$target $path
			skip=$target
		fi
    done
}

function delete_links {
	local target_base=$(realpath dotfiles)
	local target=''

	local targets_list=($(find $target_base -mindepth 1 -exec realpath --relative-to=$target_base {} \;))
	for target in ${targets_list[@]}
	do
		local path=$HOME/$target
		printf "\033[32m$target\033[0m"
		if [ -L $path ] && [ "$(readlink -f $path)" = "$target_base/$target" ]
		then
			echo " [deleted]"
			rm $path
		else
			echo " not installed [skipped]"
		fi
	done
}

if [ "$1" = "--clean" ]
then
	delete_links
elif [ -z "$1" ]
then
	create_links
else
	echo "Usage: $0 [--clean]"
fi

