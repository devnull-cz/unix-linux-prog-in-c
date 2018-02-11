#
# Unix programming in C
#
# (c) Martin Beran, Jan Pechanec, Vladimir Kotal
#
# - "make slides" creates lecture slides
# - "make notes" creates slides with notes in the A4 format
#
# For correct links and PDF bookmarks it is necessary to run make twice.
#
# Do not edit m4 files, those are automatically created during the document
# generation.
#

LATEX=		pdflatex
M4=		m4

SLIDE=		unix-linux-prog-in-c_slides-only.tex
NOTE=		unix-linux-prog-in-c.tex

SLIDE_PDF=	$(SLIDE:tex=pdf)
NOTE_PDF=	$(NOTE:tex=pdf)
SLIDE_NEW=	$(SLIDE_PDF:pdf=pdf.new)
NOTE_NEW=	$(NOTE_PDF:pdf=pdf.new)

TEX=		common.tex \
		intro.tex \
		file-api.tex \
		user-access.tex \
		proc.tex \
		signals.tex \
		synchro.tex \
		network.tex \
		threads.tex \
		files.tex \
		other.tex \
		sys-v-semaphores.tex \
		history.tex \
		appendix.tex

SLIDES=		$(TEX) ${SLIDE}
NOTES=		$(TEX) ${NOTE}

all:		slides notes

slides:		$(SLIDES)
		@for i in ${SLIDES}; do \
			new=`echo $$i | sed -e 's/.tex/.m4.tex/g'`; \
			$(M4) $$i > $$new; \
		done
		$(LATEX) $(SLIDE:tex=m4.tex)
		mv $(SLIDE:tex=m4.pdf) $(SLIDE_PDF)

notes:		$(NOTES)
		@for i in $(NOTE) ${NOTES}; do \
			new=`echo $$i | sed -e 's/.tex/.m4.tex/g'`; \
			$(M4) $$i > $$new; \
		done
		$(LATEX) $(NOTE:tex=m4.tex)
		mv $(NOTE:tex=m4.pdf) $(NOTE_PDF)

clean:
		-rm -f *.log *.aux *.m4.tex *.pdf *.m4.tmp *.out

# Once translation is finished, make this return 1 on non-empty output.
spellcheck:
		@for file in ${SLIDES}; do \
			echo "### Checking $$file"; \
			$(M4) $$file | \
			    sed '/\begin{verbatim}/,/\end{verbatim}/d' | \
			    sed '/\begin{alltt}/,/\end{alltt}/d' | \
			    sed 's/pdfbookmark\[[0-9]\]{\([^{}]*\)}{.*}/pdfbookmark{\1}/' | \
			    sed 's/\\\-//g' | \
			    sed 's/\\texttt{[^{]*}//g' | \
			    sed 's/\\emprg{.*}//g' | \
			    aspell -t --personal=./unix_dict.txt list; \
		done
