#!/usr/bin/sh

function create_links {
    local targetBase=$(realpath user)
    local target=''
    
    while read target
    do
	local path=$HOME/$target
    
	if [ ! -e $path ]
	then
	    ln -vs $targetBase/$target $path
        fi
    done < <(find user -mindepth 1 -exec realpath --relative-to=user {} \;)
}

create_links
