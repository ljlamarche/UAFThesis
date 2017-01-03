
#!/bin/bash

gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=530 -dDEVICEHEIGHTPOINTS=410 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/densprofile.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/densprofile.ps

gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=270 -dDEVICEHEIGHTPOINTS=520 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/superdarnmap.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/SuperDARNmap.ps



pdflatex LLamarcheThesis.tex

bibtex LLamarcheThesis

bibtex introduction

pdflatex LLamarcheThesis.tex

pdflatex LLamarcheThesis.tex

rm *.aux
