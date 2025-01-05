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

TEX_FILES=	common.tex \
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

SLIDES=		$(TEX_FILES) $(SLIDE)
NOTES=		$(TEX_FILES) $(NOTE)

all:		slides notes spellcheck

slides:		$(SLIDES)
		@for i in ${SLIDES}; do \
			new=`echo $$i | sed -e 's/.tex/.m4.tex/g'`; \
			$(M4) -D NOSPELLCHECK $$i > $$new; \
		done
		$(LATEX) $(SLIDE:tex=m4.tex)
		mv $(SLIDE:tex=m4.pdf) $(SLIDE_PDF)

notes:		$(NOTES)
		@for i in ${NOTES}; do \
			new=`echo $$i | sed -e 's/.tex/.m4.tex/g'`; \
			$(M4) -D NOSPELLCHECK $$i > $$new; \
		done
		$(LATEX) $(NOTE:tex=m4.tex)
		mv $(NOTE:tex=m4.pdf) $(NOTE_PDF)

clean:
		-rm -f *.log *.aux *.m4.tex *.pdf *.m4.tmp *.out

spellcheck:
		@rm -f /tmp/aspell.out
		@echo "test" | sed -E -f spellfilter.sed >/dev/null; \
		if [ $$? -ne 0 ]; then echo "sed failed"; exit 1; fi
		@for file in ${SLIDES}; do \
			echo "### Checking $$file"; \
			$(M4) $$file | sed -E -f spellfilter.sed | \
			    aspell -t --personal=./unix_dict.txt list | \
			    tee -a /tmp/aspell.out; \
			if [ $$? -ne 0 ]; then exit 1; fi; \
		done
		@if [ -s /tmp/aspell.out ]; then exit 1; fi
