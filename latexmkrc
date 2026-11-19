# latexmk settings: upLaTeX + upBibTeX + dvipdfmx.
# Overleaf reads this file, so the template compiles with upLaTeX
# whichever compiler is chosen in Overleaf's menu.
$latex = 'uplatex %O %S';
$bibtex = 'upbibtex %O %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';
$pdf_mode = 3;

# Overleaf's default compiler (pdfLaTeX) runs "latexmk -pdf", and the other
# choices run "-lualatex" or "-xelatex"; each of these overrides $pdf_mode.
# Run upLaTeX there too; latexmk then adds the dvipdfmx step by itself.
$pdflatex = 'uplatex %O %S';
$lualatex = 'uplatex %O %S';
$xelatex = 'uplatex %O %S';
