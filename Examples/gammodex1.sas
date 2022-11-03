/****************************************************************/
/*          S A S   S A M P L E   L I B R A R Y                 */
/*                                                              */
/*    NAME: gammodex1                                            */
/*   TITLE: Example 1 for PROC GAMMOD                            */
/*    DESC: LIDAR (light detection and ranging) data set        */
/*     REF: Semiparametric Regression (Ruppert et al)           */
/* PRODUCT: STAT                                                */
/*  SYSTEM: ALL                                                 */
/*    KEYS:                                                     */
/*   PROCS: GAMMOD                                               */
/*                                                              */
/****************************************************************/

title 'Scatter Plot Smoothing';
data mycas.Lidar;
   input Range LogRatio @@;
   datalines;
390  -0.05035573    391  -0.06009706    393  -0.04190091    394   -0.0509847
396  -0.05991345    397  -0.02842392    399  -0.05958421    400  -0.03988881
402  -0.02939582    403  -0.03949445    405  -0.04764749    406     -0.06038
408  -0.03123034    409  -0.03816584    411  -0.07562269    412  -0.05001751
414   -0.0457295    415  -0.07766966    417  -0.02460641    418  -0.07133184
420  -0.01320746    421  -0.03162615    423  -0.03247478    424  -0.08840797
426  -0.07024166    427  -0.02877263    429  -0.03696702    430   -0.1015625
432  -0.06831373    433  -0.03175751    435  -0.05336819    436  -0.05726381
438  -0.02295515    439  -0.01479166    441  -0.02531884    442  -0.09538944
444  -0.08126108    445  -0.06473801    447  -0.04940004    448  -0.02453983
450 -0.004223316    451  -0.04692908    453   -0.0726426    454  -0.06375497
456  -0.04867571    457  -0.07902194    459  -0.05508392    460  -0.03600915
462  -0.00819836    463  -0.02991638    465  -0.05904417    466  -0.04349076
468   -0.1083667    469  -0.07164495    471   -0.1080431    472  -0.01144756
474  -0.09066497    475  -0.07438849    477  -0.08880716    478   -0.0724013
480  -0.03941208    481  -0.08413698    483  -0.04477778    484   -0.1486651
486  -0.08027266    487  -0.05482479    489  -0.01202489    490    0.0193486
492  -0.08389427    493  -0.04157477    495  -0.06109121    496  -0.06044325
498  -0.08220186    499  -0.07530349    501  -0.04480991    502  0.008222156
504  -0.06758809    505  -0.03249946    507  -0.02198146    508  -0.04232621
510  -0.07785213    511  -0.07806195    513   0.02690717    514  -0.09226096
516  -0.09159045    517 -0.004001756    519  -0.01818933    520  -0.02527617
522  -0.05842499    523  -0.05257305    525  -0.02606248    526   -0.1180877
528   -0.0526311    529  -0.04135148    531 -0.009199134    532  -0.08336644
534  -0.01253334    535  -0.06290332    537  -0.06018018    538   -0.1035686
540   -0.1261166    541  -0.03887012    543  -0.05654984    544  -0.07444842
546 -0.003788664    547  -0.09203971    549  -0.05517356    550   -0.1004337
552    -0.169438    553  -0.06414184    555   -0.1867348    556  -0.09086006
558  -0.05918714    559   -0.0810351    561   -0.1034776    562  -0.06567394
564   -0.1821245    565   -0.0857127    567   -0.1216041    568   -0.1342692
570   -0.1933908    571   -0.1178639    573    -0.287109    574   -0.2739447
576   -0.1867194    577   -0.1891953    579   -0.2948625    580   -0.3711984
582   -0.2326753    583   -0.2719736    585   -0.2750204    586   -0.3105271
588   -0.3991572    589   -0.4256722    591   -0.5190272    592   -0.4245844
594   -0.3982711    595   -0.3463767    597   -0.4404651    598   -0.4169474
600   -0.3663678    601   -0.4121902    603   -0.5258849    604   -0.4581079
606   -0.4604081    607   -0.5218792    609   -0.5664269    610   -0.7089956
612   -0.6505402    613   -0.5719829    615   -0.4014736    616   -0.5251362
618   -0.5635558    619   -0.5900392    621   -0.4241413    622   -0.4893619
624   -0.5423047    625   -0.6555049    627    -0.509341    628   -0.4830832
630   -0.6007552    631   -0.6836965    633   -0.5153322    634   -0.4857863
636   -0.6638135    637   -0.7692632    639   -0.4796891    640   -0.7720272
642   -0.5406614    643   -0.5651009    645   -0.4565217    646   -0.4199023
648   -0.5397169    649   -0.9238232    651    -0.640224    652   -0.8252677
654   -0.5966183    655   -0.5465871    657   -0.4236746    658   -0.7076495
660   -0.4554013    661   -0.6759382    663   -0.6588688    664   -0.7198635
666   -0.5682055    667   -0.6394204    669   -0.7310237    670   -0.6116481
672   -0.6172596    673   -0.7559637    675   -0.7663848    676   -0.7123093
678   -0.7086443    679   -0.5377112    681     -0.72429    682   -0.6214564
684   -0.6324121    685   -0.9495535    687   -0.6757631    688   -0.5887097
690   -0.9114353    691   -0.4326794    693   -0.8590017    694   -0.7987653
696   -0.6931472    697    -0.886574    699   -0.7968261    700   -0.5025268
702   -0.4716702    703   -0.7801088    705   -0.6668431    706   -0.5783479
708   -0.7874522    709   -0.6156956    711   -0.8967602    712   -0.7077379
714    -0.672567    715   -0.6218413    717   -0.8657611    718    -0.557754
720   -0.8026684
;

proc sgplot data=mycas.Lidar;
   scatter  x=Range y=LogRatio;
   loess    x=Range y=LogRatio / nomarkers;
   pbspline x=Range y=LogRatio / nomarkers;
run;

proc gammod data=mycas.Lidar seed=12345;
   model LogRatio = spline(Range/details);
   output out=mycas.LidarOut pred=p;
run;

proc gammod data=mycas.Lidar seed=12345;
   model LogRatio = spline(Range/maxdf=20);
   output out=mycas.LidarOut2 pred=p2;
run;

proc gammod data=mycas.Lidar seed=12345;
   model LogRatio = spline(Range/m=3);
   output out=mycas.LidarOut3 pred=p3;
run;

data LidarPred;
   merge mycas.Lidar mycas.LidarOut mycas.LidarOut2 mycas.LidarOut3;
run;
proc sort data=LidarPred; by Range;run;
proc sgplot data=LidarPred;
   scatter x=Range y=LogRatio / markerattrs=GraphData1(size=7);
   series  x=Range y=p        / lineattrs  =GraphData2(thickness=2)
                                legendlabel="Spline 1";
   series  x=Range y=p2       / lineattrs  =GraphData3(thickness=2)
                                legendlabel="Spline 2";
   series  x=Range y=p3       / lineattrs  =GraphData4(thickness=2)
                                legendlabel="Spline 3";
run;

