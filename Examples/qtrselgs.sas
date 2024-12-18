/****************************************************************/
/*          S A S   S A M P L E   L I B R A R Y                 */
/*                                                              */
/*    NAME: qtrselgs                                            */
/*   TITLE: Getting Started Example for PROC QTRSELECT          */
/*    DESC: Statistics and Salaries of Major League             */
/*             Baseball (MLB) Players in 1986                   */
/*     REF: Collier Books, 1987, The 1987 Baseball Encyclopedia */
/*          Update, Macmillan Publishing Company, New York.     */
/*                                                              */
/* PRODUCT: VIYA Statistics                                     */
/*  SYSTEM: ALL                                                 */
/*    KEYS: Model Selection for Quantile Regression             */
/*   PROCS: QTRSELECT                                           */
/*                                                              */
/****************************************************************/

proc contents varnum data=sashelp.baseball;
   ods select position;
run;

data mylib.baseball;
   set sashelp.baseball;
run;

proc qtrselect data=mylib.baseball;
   class league division;
   model Salary = nAtBat nHits nHome nRuns nRBI nBB
                  yrMajor crAtBat crHits crHome crRuns crRbi
                  crBB league division nOuts nAssts nError;
run;

proc qtrselect data=mylib.baseball;
   class league division;
   model Salary = nAtBat nHits nHome nRuns nRBI nBB
                  yrMajor crAtBat crHits crHome crRuns crRbi
                  crBB league division nOuts nAssts nError
         / clb;
   selection method=forward(select=sl sle=0.1);
run;

proc qtrselect data=mylib.baseball alpha=0.1;
   class league division;
   model Salary = nAtBat nHits nHome nRuns nRBI nBB
                  yrMajor crAtBat crHits crHome crRuns crRbi
                  crBB league division nOuts nAssts nError
         / quantile=0.1 0.9 stb clb;
   selection method=backward(select=sl sls=0.1);
run;

proc qtrselect data=mylib.baseball alpha=0.1;
   class league division;
   model Salary = nAtBat nHits nHome nRuns nRBI nBB
                  yrMajor crAtBat crHits crHome crRuns crRbi
                  crBB league division nOuts nAssts nError
         / quantile=0.9 clb;
   selection method=backward(select=sl sls=0.1);
   output out=mylib.BaseballOverpaid copyvar=(Name Salary) r=Overpaid
          p=PredictedSalary lclm uclm;
run;

data BaseballOverpaid;
   set mylib.BaseballOverpaid;
run;

proc sort data=BaseballOverpaid;
   by descending Overpaid;
run;

proc print data=BaseballOverpaid(obs=10);
   var Name Salary Overpaid PredictedSalary lclm uclm;
run;


