#!/bin/bash

src=virtual
dst=SSI-free

replace() {
    IFS=
    cat "$1" | sed "s/<\!--#include\([^>]*\)>/\n<\!--#include\1>\n/" | \
	while read -r x; do
	    if [[ "$x" =~ \<!--\ *#include\ virtual=\"([^\.]+.[^\.]+)\"\ *--\> ]]; then
		replace "${BASH_REMATCH[1]}";
		echo
	    else
		echo "$x"
	    fi
	done
}

cd $src
while read f; do
  replace "$f" > ../$dst/"$f"
done < <(find . -maxdepth 1 -name '*.shtml')
