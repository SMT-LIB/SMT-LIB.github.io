#!/bin/bash

src=virtual
dst=SSI-free

replace() {
    IFS=
    (cat "$1" ; echo ) | sed ':a;/^[ \n]*$/{$d;N;ba}' \
	| sed "s/<\!--#include\([^>]*\)>/\n<\!--#include\1>\n/" | \
	while read -r x; do
	    if [[ "$x" =~ \<!--\ *#include\ virtual=\"([^\.]+.[^\.]+)\"\ *--\> ]]; then
		replace "${BASH_REMATCH[1]}";
		echo
	    else
		echo "$x"
	    fi
	done
}

cd virtual
for FILE in `find . -maxdepth 1 -name '*.shtml'`; do
    replace "$FILE" > ../"$FILE"
done
cd -


# version3
# why 2 times
