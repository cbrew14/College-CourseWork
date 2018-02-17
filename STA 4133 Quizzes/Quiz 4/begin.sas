/*data sasdata.help; 
infile '\\Client\C$\help.csv' delimiter=',';
run;*/
proc import datafile='\\Client\C$\help.csv'
out=sasdata.help dbms=csv replace;
delimiter=",";
getnames=yes;
run;

axis1 minor=none;
axis2 minor=none order=(5 to 60 by 13.625);
axis3 minor=none order=(20, 40, 60);
symbol1 i=sm65s v=circle color=black l=1 w=5;
symbol2 i=sm65s v=triangle color=black l=2 w=5;
proc gplot data=sasdata.help;
where female eq 1 and substance eq 'alcohol';
plot indtot*cesd / vaxis=axis1 haxis=axis3;
plot2 mcs*cesd / vaxis = axis2;
run;
quit;
