
#!/bin/bash

gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=530 -dDEVICEHEIGHTPOINTS=410 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/densprofile.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/densprofile.ps

gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=270 -dDEVICEHEIGHTPOINTS=520 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/SuperDARNmap.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/SuperDARNmap.ps

gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=510 -dDEVICEHEIGHTPOINTS=510 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/ISRmap.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/ISRmap.ps


pdflatex LLamarcheThesis.tex

bibtex LLamarcheThesis

bibtex introduction

bibtex conclusion

pdflatex LLamarcheThesis.tex

pdflatex LLamarcheThesis.tex

rm *.aux
rm *.bbl
rm *.blg
rm *.out
rm *.log
