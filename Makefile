
.PHONY: all
all: fromagxo-libreto.ps fromagxo.ps.gz fromagxo.html unu_dosiero/index.html fromagxo-a4.ps fromagxo-a4.ps.gz fromagxo.pdf


fromagxotex.tks: fromagxo.tks
	cat fromagxo.tks | konwert utf8-tex > fromagxotex.tks

fromagxox.tks: fromagxo.tks
	cat fromagxo.tks | konwert utf8-antauxcxap > fromagxox.tks

fromtex.dvi: fromagxotex.tks fromtex.tex titolpag.tex preamble.tex
	latex fromtex.tex

fromtex-a4.dvi: fromagxotex.tks fromtex.tex titolpag.tex preamble.tex
	latex fromtex-a4.tex

fromagxo-a5.ps: fromtex.dvi
	dvips -f fromtex.dvi > fromagxo-a5.ps

fromagxo-a5-signature.ps: fromagxo-a5.ps
	psbook -s20 fromagxo-a5.ps fromagxo-a5-signature.ps

fromagxo-libreto.ps:  fromagxo-a5-signature.ps
	psnup -l -pa4 -2 -s1 fromagxo-a5-signature.ps > fromagxo.ps
#	pstops -pa3 '8:-7(0,0)+0(0,21cm)+-5(14.85cm,0)+2(14.85cm,21cm),1(0,0)+-6(0,21cm)+3(14.85cm,0)+-4(14.85cm,21cm)' fromagxo_.ps fromagxo.ps
#	pstops "4:-3L@1(29.2cm,0)+0L@1(29.2cm,14.85cm),1R@1(0cm,29.7cm)+-2R@1(0cm,14.85cm)" fromagxo_.ps fromagxo.ps

fromagxo-a4.ps:  fromtex-a4.dvi
	dvips -f fromtex-a4.dvi > fromagxo-a4.ps

fromagxo-a4.ps.gz: fromagxo-a4.ps
	gzip -c fromagxo-a4.ps  > fromagxo-a4.ps.gz

fromagxo.ps.gz: fromagxo.ps
	gzip -c fromagxo.ps > fromagxo.ps.gz

fromagxo.pdf:  fromagxotex.tks fromtex-a4.tex titolpag.tex
	pdflatex fromtex-a4.tex
	mv fromtex-a4.pdf fromagxo.pdf

fromagxo.html:  fromtex.tex fromagxox.tks traduku fromagxo.tex Makefile
	latex2html -split 4 -no_subdir -address '<a href="mailto:michiel.meeuwissen+from@gmail.com">Michiel Meeuwissen &lt;michiel.meeuwissen@gmail.com&gt;</a>' fromagxo.tex
	cp fromagxostyle.css fromagxo.css
	./traduku.cxiun

unu_dosiero/index.html: fromagxox.tks fromagxo.tex
	mkdir -p unu_dosiero
	latex2html -split 0 -dir unu_dosiero -address '<a href="mailto:michiel.meeuwissen@gmail.com">Michiel Meeuwissen</a>' fromagxo.tex
	cp fromagxostyle.css unu_dosiero/fromagxo.css

.PHONY: clean
clean:
	rm -fr *.dvi *.ps fromtks.fun fromagxotex.tks *.aux node*.html *.log fromagxo_.ps WARNINGS fromagxo.html fromagxo.css *.pl images.tex index.html fromagxox.tks *.gz unu_dosiero *.pdf