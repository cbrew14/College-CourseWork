proc import datafile="\\Client\C$\help.csv"
out=help dbms=csv replace;
delimiter=',';
getnames=yes;
axis1 minor=none;
axis2 minor=none order=(5 to 60 by 13.625);
axis3 minor=none order=(20, 40, 60);
symbol1 i=sm65s v=circle color=black l=1 w=5;
symbol2 i=sm65s v=triangle color=black l=2 w=5;
run;
proc gplot data=help;
where female eq 1 and substance eq 'alcohol';
plot indtot*cesd / vaxis=axis1 haxis=axis3;
plot2 mcs*cesd / vaxis = axis2;
run;
quit;
proc sgpanel data=help;
panelby g1b substance / layout=lattice;
pbspline x=cesd y=mcs;
run; quit; 
ods select censoredsummary survivalplot;
proc lifetest data=help plots=s(test);
time dayslink*linkstatus(0);
strata treat;
run;
ods graphics on;
ods select roccurve;
proc logistic data=help descending plots(only)=roc;
model g1b = cesd;
run;
ods graphics off; 
proc sgscatter data=help;
 where female eq 1;
 matrix cesd mcs pcs i1 / diagonal=(histogram kernel);
run; quit; 
proc sgscatter data=help;
 where female eq 1;
 compare x = (cesd mcs pcs i1)
 y = (cesd mcs pcs i1) / loess;
run; quit;
proc sgscatter data=help;
matrix mcs pcs pss_fr drugrisk cesd indtot i1 sexrisk /
ellipse=(alpha=.25) start=bottomleft
markerattrs=(symbol=circlefilled size=4);
run; quit;
