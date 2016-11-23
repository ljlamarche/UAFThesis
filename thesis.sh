
#!/bin/bash

gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=470 -dDEVICEHEIGHTPOINTS=350 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/densprofile.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/densprofile.ps

pdflatex LLamarcheThesis.tex
