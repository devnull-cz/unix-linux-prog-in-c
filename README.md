[![Build Status](https://travis-ci.org/devnull-cz/unix-linux-prog-in-c.svg?branch=master)](https://travis-ci.org/devnull-cz/unix-linux-prog-in-c)

This project contains source code for the material that is used to lecture
"Unix/Linux Programming in C" (NSWI015) class at the Faculty of Mathematics and
Physics, Charles University in Prague.

It is written in LaTeX.  See the `Makefile` on how to build the PDF document.

The class home page is https://devnull-cz.github.io/unix-linux-prog-in-c/

# Developer notes

## Trigger new release

```
# get the latest tag
$ git tag | sed 's/^v//' | sort -n | tail -1
# create new tag
$ git tag v<XYZ>
# push it to the repo
$ git push origin v<XYZ>
```
