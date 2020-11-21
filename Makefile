PROJECT=thesis
TEX=pdflatex
BIBTEX=bibtex
REFERENCES=bibliography.bib
BUILDTEX=$(TEX) $(PROJECT).tex

all: $(PROJECT).pdf

$(PROJECT).pdf: $(PROJECT).aux $(PROJECT).bbl $(PROJECT).tex */*.tex
	$(BUILDTEX) -draftmode
	$(BUILDTEX) 

$(PROJECT).bbl: $(REFERENCES)
	bibtex $(PROJECT)

$(PROJECT).aux: 
	$(BUILDTEX) -draftmode


clean:
	rm -rf *.aux *.lof *.log *.lot *.toc *.bbl *.blg *pdf */*.aux *.brf *.idx *.loa *.out

