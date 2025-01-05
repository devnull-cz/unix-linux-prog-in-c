#!/bin/bash
#
# Verify the \example{} are all valid links to the source repository.
#
# Assumes the source repository is checked about to the '../unix-linux-prog-in-c-src' directory
# and also that the TeX documents were already processed by m4.
#
# Lastly, it assumes that the \example{} does not span multiple lines.
#

for m4file in *.m4.tex; do
	echo "### $m4file"
	cat "$m4file" | grep -o '\\example{[[:alnum:]\/\._\-]\+}' | \
	    sort -u | sed -e 's/^\\example{//' -e 's/}$//' | while read example; do
		if [[ ! -f ../unix-linux-prog-in-c-src/$example ]]; then
			echo "example $example is bad link"
			exit 1
		fi
	done
done
