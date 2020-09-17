/*************************************
Program corresponding to video on Linear Regression Analysis in SAS
Justin Post
**************************************/

*Create a library called MyData;
LIBNAME MyData "E:\NCSU classes\ST 307\DataSets";

*Read in cheese data instream;
DATA MyData.cheese;
	INPUT syrup rep $ L a b;
	DATALINES;
26 1 51.89 6.22 17.43
26 2 51.52 6.18 17.09
26 3 52.69 6.09 17.59
26 4 52.06 6.36 17.5
26 5 51.63 6.13 17.19
26 6 52.73 6.12 17.5
42 1 47.21 7.02 16
42 2 48.57 6.42 15.91
42 3 47.57 6.84 16.04
42 4 46.85 6.97 15.85
42 5 48.64 6.30 16.21
42 6 47.49 6.91 15.91
55 1 41.43 7.71 13.74
55 2 42.31 7.59 13.98
55 3 42.31 7.63 14.42
55 4 41.49 7.66 13.58
55 5 42.12 7.56 14.03
55 6 42.65 7.55 14.4
62 1 45.99 6.84 15.68
62 2 46.66 6.66 16.3
62 3 47.35 6.49 15.7
62 4 45.83 6.96 15.61
62 5 46.77 6.66 15.91
62 6 47.88 6.34 15.64
;

*SLR with CI for mean values;
PROC GLM DATA=MyData.cheese PLOTS = ALL;
	MODEL L = syrup/CLM;
RUN;
QUIT;

*SLR with PI for future values;
PROC GLM DATA=MyData.cheese PLOTS = ALL;
	MODEL L = syrup/CLI;
RUN;
QUIT;


*Add a quadratic term to try to help with fit issues;
PROC GLM DATA=MyData.cheese PLOTS=ALL;
	MODEL L = syrup syrup*syrup;
RUN;
QUIT;

*Add cubic term;
PROC GLM DATA=MyData.cheese PLOTS=ALL;
	MODEL L = syrup syrup*syrup syrup*syrup*syrup;
RUN;
QUIT;

*MLR with syurp and a b as predictors of L;
PROC GLM DATA=MyData.cheese PLOTS=ALL;
	MODEL L = syrup a b;
RUN;
QUIT;


*MLR with syurp and a b as predictors of L;
PROC GLM DATA=MyData.cheese PLOTS=ALL;
	MODEL L = syrup a b/CLPARM CLM;
RUN;
QUIT;

*To get confidence/prediction interval for a value of syrup not in the data set;
*Missing Y trick;
DATA temp;
	INPUT syrup rep $ L a b;
	DATALINES;
	49 . . 3 4
;
*Append to previous data set;
PROC DATASETS;
	APPEND BASE=MyData.cheese DATA=temp;
RUN;

*Get confidence interval for a future response at new value;
PROC GLM DATA=MyData.cheese PLOTS=ALL;
	MODEL L = syrup a b/CLM;
RUN;
QUIT;
