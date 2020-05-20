.PHONY: default clean

default: report.pdf

report.pdf: report.tex results.tex references.bib

%.pdf: %.tex
	pdflatex $*
clean:
	rm -f *.aux *.bbl *.blg *.log *.out report.pdf
