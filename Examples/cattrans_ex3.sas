/****************************************************************/
/*          S A S   S A M P L E   L I B R A R Y                 */
/*                                                              */
/*    NAME: cattrans_ex3                                        */
/*   TITLE: Example 3 Regression Tree Binning                   */
/* PRODUCT: CASSTAT                                             */
/*  SYSTEM: ALL                                                 */
/*    KEYS:                                                     */
/*   PROCS: CATTRANSFORM                                        */
/*    DATA:                                                     */
/*                                                              */
/*     REF:                                                     */
/*    MISC:                                                     */
/****************************************************************/

data mylib.regdata;
    call streaminit(12345);
    do myid=1 to 1000;
        y=round(rand('normal',50,10),.1);
        c1=rand('table',.35,.25,.2,.1,.04,.03,.02,.01);
        c2=rand('table',.01,.02,.03,.04,.1,.2,.25,.35);
        output;
    end;
run;

proc cattransform data=mylib.regdata evaluationstats;
    input c1 c2;
    target y / level=interval;
    method tree;
    output out=mylib.score;
    savestate rstore=mylib.regmodel;
run;
