/****************************************************************/
/*          S A S   S A M P L E   L I B R A R Y                 */
/*                                                              */
/*    NAME: mbcex2                                              */
/*   TITLE: Example for PROC MBC                                */
/* PRODUCT: AACAS                                               */
/*  SYSTEM: ALL                                                 */
/*    KEYS: model-based clustering, starting values             */
/*   PROCS: MBC                                                 */
/*    DATA:                                                     */
/*                                                              */
/*     REF: PROC MBC, Example 2                                 */
/*    MISC:                                                     */
/****************************************************************/

data mycas.fish (drop=HtPct WidthPct);
   input Species Weight Length1 Length2 Length3 HtPct WidthPct @@;

   *** transform variables;
   if Weight <= 0 or Weight =. then delete;
   Weight3=Weight**(1/3);
   Height=HtPct*Length3/(Weight3*100);
   Width=WidthPct*Length3/(Weight3*100);
   Length1=Length1/Weight3;
   Length2=Length2/Weight3;
   Length3=Length3/Weight3;
   logLengthRatio=log(Length3/Length1);

   datalines;
1  242.0 23.2 25.4 30.0 38.4 13.4 1  290.0 24.0 26.3 31.2 40.0 13.8
1  340.0 23.9 26.5 31.1 39.8 15.1 1  363.0 26.3 29.0 33.5 38.0 13.3
1  430.0 26.5 29.0 34.0 36.6 15.1 1  450.0 26.8 29.7 34.7 39.2 14.2
1  500.0 26.8 29.7 34.5 41.1 15.3 1  390.0 27.6 30.0 35.0 36.2 13.4
1  450.0 27.6 30.0 35.1 39.9 13.8 1  500.0 28.5 30.7 36.2 39.3 13.7
1  475.0 28.4 31.0 36.2 39.4 14.1 1  500.0 28.7 31.0 36.2 39.7 13.3
1  500.0 29.1 31.5 36.4 37.8 12.0 1     .  29.5 32.0 37.3 37.3 13.6
1  600.0 29.4 32.0 37.2 40.2 13.9 1  600.0 29.4 32.0 37.2 41.5 15.0
1  700.0 30.4 33.0 38.3 38.8 13.8 1  700.0 30.4 33.0 38.5 38.8 13.5
1  610.0 30.9 33.5 38.6 40.5 13.3 1  650.0 31.0 33.5 38.7 37.4 14.8
1  575.0 31.3 34.0 39.5 38.3 14.1 1  685.0 31.4 34.0 39.2 40.8 13.7
1  620.0 31.5 34.5 39.7 39.1 13.3 1  680.0 31.8 35.0 40.6 38.1 15.1
1  700.0 31.9 35.0 40.5 40.1 13.8 1  725.0 31.8 35.0 40.9 40.0 14.8
1  720.0 32.0 35.0 40.6 40.3 15.0 1  714.0 32.7 36.0 41.5 39.8 14.1
1  850.0 32.8 36.0 41.6 40.6 14.9 1 1000.0 33.5 37.0 42.6 44.5 15.5
1  920.0 35.0 38.5 44.1 40.9 14.3 1  955.0 35.0 38.5 44.0 41.1 14.3
1  925.0 36.2 39.5 45.3 41.4 14.9 1  975.0 37.4 41.0 45.9 40.6 14.7
1  950.0 38.0 41.0 46.5 37.9 13.7
2   40.0 12.9 14.1 16.2 25.6 14.0 2   69.0 16.5 18.2 20.3 26.1 13.9
2   78.0 17.5 18.8 21.2 26.3 13.7 2   87.0 18.2 19.8 22.2 25.3 14.3
2  120.0 18.6 20.0 22.2 28.0 16.1 2    0.0 19.0 20.5 22.8 28.4 14.7
2  110.0 19.1 20.8 23.1 26.7 14.7 2  120.0 19.4 21.0 23.7 25.8 13.9
2  150.0 20.4 22.0 24.7 23.5 15.2 2  145.0 20.5 22.0 24.3 27.3 14.6
2  160.0 20.5 22.5 25.3 27.8 15.1 2  140.0 21.0 22.5 25.0 26.2 13.3
2  160.0 21.1 22.5 25.0 25.6 15.2 2  169.0 22.0 24.0 27.2 27.7 14.1
2  161.0 22.0 23.4 26.7 25.9 13.6 2  200.0 22.1 23.5 26.8 27.6 15.4
2  180.0 23.6 25.2 27.9 25.4 14.0 2  290.0 24.0 26.0 29.2 30.4 15.4
2  272.0 25.0 27.0 30.6 28.0 15.6 2  390.0 29.5 31.7 35.0 27.1 15.3
3  270.0 23.6 26.0 28.7 29.2 14.8 3  270.0 24.1 26.5 29.3 27.8 14.5
3  306.0 25.6 28.0 30.8 28.5 15.2 3  540.0 28.5 31.0 34.0 31.6 19.3
3  800.0 33.7 36.4 39.6 29.7 16.6 3 1000.0 37.3 40.0 43.5 28.4 15.0
4   55.0 13.5 14.7 16.5 41.5 14.1 4   60.0 14.3 15.5 17.4 37.8 13.3
4   90.0 16.3 17.7 19.8 37.4 13.5 4  120.0 17.5 19.0 21.3 39.4 13.7
4  150.0 18.4 20.0 22.4 39.7 14.7 4  140.0 19.0 20.7 23.2 36.8 14.2
4  170.0 19.0 20.7 23.2 40.5 14.7 4  145.0 19.8 21.5 24.1 40.4 13.1
4  200.0 21.2 23.0 25.8 40.1 14.2 4  273.0 23.0 25.0 28.0 39.6 14.8
4  300.0 24.0 26.0 29.0 39.2 14.6
5    5.9  7.5  8.4  8.8 24.0 16.0 5   32.0 12.5 13.7 14.7 24.0 13.6
5   40.0 13.8 15.0 16.0 23.9 15.2 5   51.5 15.0 16.2 17.2 26.7 15.3
5   70.0 15.7 17.4 18.5 24.8 15.9 5  100.0 16.2 18.0 19.2 27.2 17.3
5   78.0 16.8 18.7 19.4 26.8 16.1 5   80.0 17.2 19.0 20.2 27.9 15.1
5   85.0 17.8 19.6 20.8 24.7 14.6 5   85.0 18.2 20.0 21.0 24.2 13.2
5  110.0 19.0 21.0 22.5 25.3 15.8 5  115.0 19.0 21.0 22.5 26.3 14.7
5  125.0 19.0 21.0 22.5 25.3 16.3 5  130.0 19.3 21.3 22.8 28.0 15.5
5  120.0 20.0 22.0 23.5 26.0 14.5 5  120.0 20.0 22.0 23.5 24.0 15.0
5  130.0 20.0 22.0 23.5 26.0 15.0 5  135.0 20.0 22.0 23.5 25.0 15.0
5  110.0 20.0 22.0 23.5 23.5 17.0 5  130.0 20.5 22.5 24.0 24.4 15.1
5  150.0 20.5 22.5 24.0 28.3 15.1 5  145.0 20.7 22.7 24.2 24.6 15.0
5  150.0 21.0 23.0 24.5 21.3 14.8 5  170.0 21.5 23.5 25.0 25.1 14.9
5  225.0 22.0 24.0 25.5 28.6 14.6 5  145.0 22.0 24.0 25.5 25.0 15.0
5  188.0 22.6 24.6 26.2 25.7 15.9 5  180.0 23.0 25.0 26.5 24.3 13.9
5  197.0 23.5 25.6 27.0 24.3 15.7 5  218.0 25.0 26.5 28.0 25.6 14.8
5  300.0 25.2 27.3 28.7 29.0 17.9 5  260.0 25.4 27.5 28.9 24.8 15.0
5  265.0 25.4 27.5 28.9 24.4 15.0 5  250.0 25.4 27.5 28.9 25.2 15.8
5  250.0 25.9 28.0 29.4 26.6 14.3 5  300.0 26.9 28.7 30.1 25.2 15.4
5  320.0 27.8 30.0 31.6 24.1 15.1 5  514.0 30.5 32.8 34.0 29.5 17.7
5  556.0 32.0 34.5 36.5 28.1 17.5 5  840.0 32.5 35.0 37.3 30.8 20.9
5  685.0 34.0 36.5 39.0 27.9 17.6 5  700.0 34.0 36.0 38.3 27.7 17.6
5  700.0 34.5 37.0 39.4 27.5 15.9 5  690.0 34.6 37.0 39.3 26.9 16.2
5  900.0 36.5 39.0 41.4 26.9 18.1 5  650.0 36.5 39.0 41.4 26.9 14.5
5  820.0 36.6 39.0 41.3 30.1 17.8 5  850.0 36.9 40.0 42.3 28.2 16.8
5  900.0 37.0 40.0 42.5 27.6 17.0 5 1015.0 37.0 40.0 42.4 29.2 17.6
5  820.0 37.1 40.0 42.5 26.2 15.6 5 1100.0 39.0 42.0 44.6 28.7 15.4
5 1000.0 39.8 43.0 45.2 26.4 16.1 5 1100.0 40.1 43.0 45.5 27.5 16.3
5 1000.0 40.2 43.5 46.0 27.4 17.7 5 1000.0 41.1 44.0 46.6 26.8 16.3
6  200.0 30.0 32.3 34.8 16.0  9.7 6  300.0 31.7 34.0 37.8 15.1 11.0
6  300.0 32.7 35.0 38.8 15.3 11.3 6  300.0 34.8 37.3 39.8 15.8 10.1
6  430.0 35.5 38.0 40.5 18.0 11.3 6  345.0 36.0 38.5 41.0 15.6  9.7
6  456.0 40.0 42.5 45.5 16.0  9.5 6  510.0 40.0 42.5 45.5 15.0  9.8
6  540.0 40.1 43.0 45.8 17.0 11.2 6  500.0 42.0 45.0 48.0 14.5 10.2
6  567.0 43.2 46.0 48.7 16.0 10.0 6  770.0 44.8 48.0 51.2 15.0 10.5
6  950.0 48.3 51.7 55.1 16.2 11.2 6 1250.0 52.0 56.0 59.7 17.9 11.7
6 1600.0 56.0 60.0 64.0 15.0  9.6 6 1550.0 56.0 60.0 64.0 15.0  9.6
6 1650.0 59.0 63.4 68.0 15.9 11.0
7    6.7  9.3  9.8 10.8 16.1  9.7 7    7.5 10.0 10.5 11.6 17.0 10.0
7    7.0 10.1 10.6 11.6 14.9  9.9 7    9.7 10.4 11.0 12.0 18.3 11.5
7    9.8 10.7 11.2 12.4 16.8 10.3 7    8.7 10.8 11.3 12.6 15.7 10.2
7   10.0 11.3 11.8 13.1 16.9  9.8 7    9.9 11.3 11.8 13.1 16.9  8.9
7    9.8 11.4 12.0 13.2 16.7  8.7 7   12.2 11.5 12.2 13.4 15.6 10.4
7   13.4 11.7 12.4 13.5 18.0  9.4 7   12.2 12.1 13.0 13.8 16.5  9.1
7   19.7 13.2 14.3 15.2 18.9 13.6 7   19.9 13.8 15.0 16.2 18.1 11.6
;

proc mbc data=mycas.fish seed=9982346 covstruct=(eee eei eev eii evi evv vii vvi vvv)
  nclusters=3;
  var height width weight3;
run;

proc mbc data=mycas.fish seed=9982346 init=kmeans
         covstruct=(eee eei eev eii evi evv vii vvi vvv)
  nclusters=3;
  var height width weight3;
run;

proc sgplot data=mycas.fish;
  scatter x=height y=width / group=species;
run; quit;

data mycas.fishlbl;
   set mycas.fish;
  if      (species in (6,7)) then do; z1=1; z2=0; z3=0; end;
  else if (species in (1,4)) then do; z1=0; z2=1; z3=0; end;
  else                            do; z1=0; z2=0; z3=1; end;
;

proc mbc data=mycas.fishlbl
         covstruct=(eee eei eev eii evi evv vii vvi vvv)
  nclusters=3;
  var height width weight3;
  init z1 z2 z3;
run;

