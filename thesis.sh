
#!/bin/bash

gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=530 -dDEVICEHEIGHTPOINTS=410 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/densprofile.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/densprofile.ps
gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=270 -dDEVICEHEIGHTPOINTS=520 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/SuperDARNmap.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/SuperDARNmap.ps
gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=510 -dDEVICEHEIGHTPOINTS=510 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/ISRmap.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/ISRmap.ps

# gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=600 -dDEVICEHEIGHTPOINTS=850 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/month_density_occurance2010.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/month_density_occurance2010.eps
# gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=600 -dDEVICEHEIGHTPOINTS=850 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/year_month_analysis_line.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/year_month_analysis_line.eps
# gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=600 -dDEVICEHEIGHTPOINTS=850 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/year_month_analysis_color.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/year_month_analysis_color.eps
# gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=550 -dDEVICEHEIGHTPOINTS=510 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/scatter_E2010.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/scatter_E2010.eps
# gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=590 -dDEVICEHEIGHTPOINTS=750 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/IMF_vs_occ_MLT_avg.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/IMF_vs_occ_MLT_avg_cell.eps
# gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=500 -dDEVICEHEIGHTPOINTS=800 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/occ_vs_IMF_avg.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/occ_vs_IMF_avg_cell.eps
# gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=580 -dDEVICEHEIGHTPOINTS=450 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/Fig_RISR.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/Fig_RISR.eps
# gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=600 -dDEVICEHEIGHTPOINTS=850 -sOutputFile=/Users/ljlamarche/Desktop/UAFThesis/Figures/month_ut_combined2010.pdf /Users/ljlamarche/Desktop/UAFThesis/Figures/month_ut_combined2010.eps

pdflatex LLamarcheThesis.tex

bibtex LLamarcheThesis
bibtex introduction
bibtex paper1
bibtex paper2
bibtex conclusion

pdflatex LLamarcheThesis.tex

pdflatex LLamarcheThesis.tex

rm *.aux
rm *.bbl
rm *.blg
rm *.out
rm *.log
