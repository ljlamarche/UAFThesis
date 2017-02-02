
#!/bin/bash

gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=530 -dDEVICEHEIGHTPOINTS=410 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/densprofile.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/densprofile.ps
gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=270 -dDEVICEHEIGHTPOINTS=520 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/SuperDARNmap.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/SuperDARNmap.ps
gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=510 -dDEVICEHEIGHTPOINTS=510 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/ISRmap.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/ISRmap.ps

inkscape -f /Users/ljlamarche/Desktop/UAFThesis/Figures/ste.svg -D -A /Users/ljlamarche/Desktop/UAFThesis/Figures/ste.pdf
inkscape -f /Users/ljlamarche/Desktop/UAFThesis/Figures/irregularity.svg -D -A /Users/ljlamarche/Desktop/UAFThesis/Figures/irregularity.pdf
inkscape -f /Users/ljlamarche/Desktop/UAFThesis/Figures/magnetosphere.svg -D -A /Users/ljlamarche/Desktop/UAFThesis/Figures/magnetosphere.pdf
inkscape -f /Users/ljlamarche/Desktop/UAFThesis/Figures/patch_formation.svg -D -A /Users/ljlamarche/Desktop/UAFThesis/Figures/patch_formation.pdf
inkscape -f /Users/ljlamarche/Desktop/UAFThesis/Figures/ste.svg -D -A /Users/ljlamarche/Desktop/UAFThesis/Figures/ste.pdf
inkscape -f /Users/ljlamarche/Desktop/UAFThesis/Figures/conclusion.svg -D -A /Users/ljlamarche/Desktop/UAFThesis/Figures/conclusion.pdf

pdflatex LLamarcheThesis.tex

bibtex LLamarcheThesis
bibtex introduction
bibtex paper1
bibtex paper2
bibtex paper3
bibtex conclusion

pdflatex LLamarcheThesis.tex

pdflatex LLamarcheThesis.tex

rm *.aux
rm *.bbl
rm *.blg
rm *.out
rm *.log
rm *.lof
rm *.lot
rm *.toc
