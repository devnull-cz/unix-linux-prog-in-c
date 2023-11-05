#!/bin/bash

if grep '\\label{.*}' *.tex >/tmp/label-err.out; then
	echo "Some of the *.tex files contain the \\label command."
	echo "This is unwanted as this leads to invalid links in PDFs."
	echo "Use \\hlabel instead."
	echo ""
	cat /tmp/label-err.out
	exit 1
fi
