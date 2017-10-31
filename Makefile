#
# Programovani v UNIXu
#
# (c) Martin Beran, Jan Pechanec, Vladimir Kotal
#
# - "make slides" vytvori slajdy pro prednasku
# - "make notes" vytvori poznamkove materialy ve velikosti A4
# - "make mynotes" vytvori poznamkove materialy vcetne poznamek pro
#    prednasejiciho
#
# Pro spravne vytvoreni odkazu na stranky a PDF bookmarku je nutne spustit
# make dvakrat.
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
		uvod.tex \
		soubory.tex \
		procesy.tex \
		signaly.tex \
		synchronizace.tex \
		site.tex \
		vlakna.tex \
		changelog.tex

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
		-rm -f *.log *.aux *.m4.tex *.pdf *.m4.tmp
