
.PHONY: all
all: fromagxo.ps fromagxo.ps.gz fromagxo.html unu_dosiero/index.html fromagxo-a4.ps fromagxo-a4.ps.gz fromagxo.pdf


fromagxotex.tks: fromagxo.tks
	cat fromagxo.tks | konwert utf8-tex > fromagxotex.tks	

fromagxox.tks: fromagxo.tks
	cat fromagxo.tks | konwert utf8-xmetodo > fromagxox.tks	

fromtex.dvi: fromagxotex.tks fromtex.tex titolpag.tex preamble.tex
	latex fromtex.tex

fromtex-a4.dvi: fromagxotex.tks fromtex.tex titolpag.tex preamble.tex
	latex fromtex-a4.tex


fromagxo.ps:  fromtex.dvi
	dvips -f fromtex.dvi > fromagxo_.ps
	pstops "4:-3L@1(29.2cm,0)+0L@1(29.2cm,14.85cm),1R@1(-8cm,29.7cm)+-2R@1(-8cm,14.85cm)" fromagxo_.ps fromagxo.ps

fromagxo-a4.ps:  fromtex-a4.dvi
	dvips -f fromtex-a4.dvi > fromagxo-a4.ps

fromagxo-a4.ps.gz: fromagxo-a4.ps
	gzip -f fromagxo-a4.ps

fromagxo.ps.gz: fromagxo.ps
	gzip -f fromagxo.ps

fromagxo.pdf:  fromagxotex.tks fromtex-a4.tex titolpag.tex
	pdflatex fromtex-a4.tex
	mv fromtex-a4.pdf fromagxo.pdf

fromagxo.html:  fromagxo.tex fromagxox.tks	
	latex2html -split 4 -no_subdir -address '<a href="mailto:mihxil@gmail.com">Michiel Meeuwissen &lt;mihxil@gmail.com&gt;</a>' fromagxo.tex
	cp fromagxostyle.css fromagxo.css
	traduku.cxiun

unu_dosiero/index.html: fromagxox.tks fromagxo.tex
	mkdir -p unu_dosiero
	latex2html -split 0 -dir unu_dosiero -address '<a href="mailto:mihxil@gmail.com">Michiel Meeuwissen</a>' fromagxo.tex
	cp fromagxostyle.css unu_dosiero/fromagxo.css	

.PHONY: clean
clean:
	rm -fr *.dvi *.ps fromtks.fun fromagxotex.tks *.aux node*.html *.log fromagxo_.ps WARNINGS fromagxo.html fromagxo.css *.pl images.tex index.html fromagxox.tks *.gz unu_dosiero *.pdf