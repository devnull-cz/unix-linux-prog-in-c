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

SLIDE=		unix-programming-in-c_slides-only.tex
NOTE=		unix-programming-in-c.tex

SLIDE_PDF=	$(SLIDE:tex=pdf)
NOTE_PDF=	$(NOTE:tex=pdf)
SLIDE_NEW=	$(SLIDE_PDF:pdf=pdf.new)
NOTE_NEW=	$(NOTE_PDF:pdf=pdf.new)

TEX=		unix-programming-in-c.common.tex \
		intro.tex \
		file-api.tex \
		user-access.tex \
		proc.tex \
		signals.tex \
		synchro.tex \
		network.tex \
		threads.tex \
		files.tex \
		history.tex

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
