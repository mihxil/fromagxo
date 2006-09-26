


fromtex.dvi: fromagxo.tks fromtex.tex titolpag.tex
	latehx

fromagxo2.ps:  fromtex.dvi
	dvips -f fromtex.dvi > fromagxo.ps
	pstops "4:-3L@1(29.2cm,0)+0L@	1(29.2cm,14.85cm),1R@1(-8cm,29.7cm)+-2R@1(-8cm,14.85cm)" fromagxo.ps fromagxo2.ps
