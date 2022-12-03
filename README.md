[![Github Actions status](https://github.com/devnull-cz/unix-linux-prog-in-c/workflows/Compile%20sanity%20check/badge.svg)](https://github.com/devnull-cz/unix-linux-prog-in-c/actions?query=workflow%3A%22Compile+sanity+check%22)

This project contains source code for the material that is used to lecture
"Unix/Linux Programming in C" (NSWI015) class at the Faculty of Mathematics and
Physics, Charles University in Prague.

To get the PDFs, go to [Releases](https://github.com/devnull-cz/unix-linux-prog-in-c/releases).

The class home page is https://devnull-cz.github.io/unix-linux-prog-in-c/

# Developer notes

It is written in LaTeX.  See the `Makefile` on how to build the PDF document.

## Trigger new release

```
./dev/release.sh v<XYZ>
```
