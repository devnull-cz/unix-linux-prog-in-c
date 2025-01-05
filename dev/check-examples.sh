#!/bin/bash
#
# Verify the \example{} are all valid links to the source repository.
#
# Assumes the source repository is checked about to the '../unix-linux-prog-in-c-src' directory
# and also that the TeX documents were already processed by m4.
#
# Lastly, it assumes that the \example{} does not span multiple lines.
#

SRC_DIR="../unix-linux-prog-in-c-src"

if [[ ! -d $SRC_DIR ]]; then
	echo "directory $SRC_DIR does not exist"
	exit 1
fi

ret=0
for m4file in *.m4.tex; do
	echo "### $m4file"
	oldIFS=$IFS
	cat "$m4file" | grep -o '\\example{[[:alnum:]\/\._\-]\+}' |
	    sort -u | sed -e 's/^\\example{//' -e 's/}$//' | while IFS='\n' read example; do
		if [[ ! -f $SRC_DIR/$example ]]; then
			echo "example $example is bad link"
			exit 1
		fi
	done
	if (( $? != 0 )); then
		ret=1
	fi
	IFS=$oldIFS
done
exit $ret
