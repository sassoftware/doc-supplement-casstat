/****************************************************************/
/*          S A S   S A M P L E   L I B R A R Y                 */
/*                                                              */
/*    NAME: logex2                                              */
/*   TITLE: Example 2 for PROC LOGSELECT                        */
/*    DESC: Modeling Binomial Data                              */
/* PRODUCT: VIYA Statistics                                     */
/*  SYSTEM: ALL                                                 */
/*    KEYS: Logistic regression analysis,                       */
/*          Binomial response data                              */
/*   PROCS: LOGSELECT                                           */
/*    DATA: Cox and Snell (1989, pp 10-11)                      */
/*    MISC:                                                     */
/*                                                              */
/****************************************************************/

/*****************************************************************
Example 2: Modeling Binomial Data
*****************************************************************/

/*
The data, taken from Cox and Snell (1989, pp 10-11), consists of
the number, r, of ingots not ready for rolling, out of n tested,
for a number of combinations of heating time and soaking time.
PROC LOGSELECT is invoked using events/trials syntax to fit the
binary logit model to the grouped data.
*/

title 'Example 2: Modeling Binomial Data';

data Ingots;
   input Heat Soak r n @@;
   Obsnum= _n_;
   datalines;
7 1.0 0 10  14 1.0 0 31  27 1.0 1 56  51 1.0 3 13
7 1.7 0 17  14 1.7 0 43  27 1.7 4 44  51 1.7 0  1
7 2.2 0  7  14 2.2 2 33  27 2.2 0 21  51 2.2 0  1
7 2.8 0 12  14 2.8 0 31  27 2.8 1 22  51 4.0 0  1
7 4.0 0  9  14 4.0 0 19  27 4.0 1 16
;
data mylib.Ingots;
   set Ingots;
run;

proc logselect data=mylib.Ingots association ctable(out=mylib.Roc nocounts tpf fpf);
   model r/n = Heat Soak Heat*Soak;
   output out=mylib.Out xbeta predicted=Pred copyvars=(Heat Soak);
run;

proc print data=mylib.Out;
   where Heat=14 & Soak=1.7;
run;

ods graphics on;
proc sgplot data=mylib.Roc aspect=1 noautolegend;
   title 'ROC Curve';
   xaxis values=(0 to 1 by 0.25) grid offsetmin=.05 offsetmax=.05;
   yaxis values=(0 to 1 by 0.25) grid offsetmin=.05 offsetmax=.05;
   lineparm x=0 y=0 slope=1 / lineattrs=(color=ligr);
   series x=FPF y=TPF;
   inset 'Area under the curve=0.7706' / position=bottomright;
run;

data mylib.Ingots2;
   set Ingots;
   a = n - r;
run;

proc logselect data=mylib.Ingots2 association ctable(out=mylib.Roc nocounts tpf fpf);
   model r a = Heat Soak Heat*Soak;
   output out=mylib.Out xbeta predicted=Pred copyvars=(Heat Soak);
run;

data mylib.Ingots_binary;
   set Ingots;
   do i=1 to n;
     if i <= r then y=1; else y = 0;
     output;
   end;
run;

proc logselect data=mylib.Ingots_binary;
   model y(event='1') = Heat Soak Heat*Soak;
run;

