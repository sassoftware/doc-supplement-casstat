/***************************************************************/
/*          S A S   S A M P L E   L I B R A R Y                */
/*                                                             */
/*    NAME: kclus_ex4.sas                                      */
/*   TITLE: Example 4 for PROC KCLUS                           */
/* PRODUCT: AACAS                                              */
/*  SYSTEM: ALL                                                */
/*    KEYS:                                                    */
/*   PROCS: KCLUS                                              */
/*    DATA:                                                    */
/*                                                             */
/*     REF:                                                    */
/*    MISC:                                                    */
/*                                                             */
/***************************************************************/

data mylib.baseball;
  Set sashelp.baseball;
  Keep CrAtBat CrHits CrRuns CrRbi CrBB Team League Division Position Div;
Run;


proc kclus data=mylib.baseball maxiter=10 maxc=10 distancenom=relativefreq
   outstat(outiter)=mylib.kclusOutstat4 printalldistances
   noc=abc(B=10 minclusters=2 align=none criterion=all)
   kprototypeparams=usergamma(value=10);
   input CrAtBat CrHits CrRuns CrRbi CrBB / level=interval;
   input Team League Division Position Div / level=nominal;
   score out=mylib.kclusOut4 copyvars=
   (CrAtBat CrHits CrRuns CrRbi CrBB Team League Division Position Div);
   ods output FreqNom=FreqNom4;
run;

