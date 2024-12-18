/****************************************************************/
/*          S A S   S A M P L E   L I B R A R Y                 */
/*                                                              */
/*    NAME: logex4                                              */
/*   TITLE: Example 4 for PROC LOGSELECT                        */
/*    DESC: Ordinal Logistic Regression                         */
/* PRODUCT: VIYA Statistics                                     */
/*  SYSTEM: ALL                                                 */
/*    KEYS: logistic regression analysis,                       */
/*          polytomous response data                            */
/*   PROCS: LOGSELECT                                           */
/*    DATA: McCullagh and Nelder (1989, p.175)                  */
/*    MISC:                                                     */
/*                                                              */
/****************************************************************/

/*****************************************************************
Example 4: Ordinal Logistic Regression
*****************************************************************/

/*
The data, taken from McCullagh and Nelder (1989, p.175), were derived from an
experiment concerned with the effect of four cheese additives on taste.  The
nine response categories range from strong dislike (1) to excellent taste
(9).  Let y be the response variable.  The variable Additive specifies the
cheese additive (1, 2, 3, or 4).  The data after the DATALINES statement are
arranged like a 2-way table of additive by rating; i.e., the rows are the
four additives and the columns are the nine levels of the rating scale.
*/

title 'Example 4: Ordinal Logistic Regression';

data mylib.Cheese;
   do Additive = 1 to 4;
      do y = 1 to 9;
         input freq @@;
         output;
      end;
   end;
   label y='Taste Rating';
   datalines;
0  0  1  7  8  8 19  8  1
6  9 12 11  7  6  1  0  0
1  1  6  8 23  7  5  1  0
0  0  0  1  3  7 14 16 11
;

proc logselect data=mylib.Cheese;
   freq freq;
   class Additive(ref='4') / param=ref;
   model y=Additive;
run;

data mylib.Cheese;
   do Additive = 1 to 4;
      input y1-y9;
      output;
   end;
   datalines;
0  0  1  7  8  8 19  8  1
6  9 12 11  7  6  1  0  0
1  1  6  8 23  7  5  1  0
0  0  0  1  3  7 14 16 11
;

proc logselect data=mylib.Cheese;
   class Additive(ref='4') / param=ref;
   model y1-y9=Additive;
run;

