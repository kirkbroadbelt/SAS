*1. Create a library called Project3, in which you want to put your data sets. (1 pt);

LIBNAME Project3 "/folders/myfolders/sasuser.v94";

*2. In a DATA step, read in the winequality.csv and save it as dataset “winequality” in library
Project3. (2 pt) Create a new variable COLOR, which equals “Red” for the individuals with type
= 1 and “White” for the others. Drop the TYPE variable. (1 pt);

DATA Project3.winequality;
	INFILE "/folders/myfolders/sasuser.v94/winequality.csv" DSD FIRSTOBS= 2;
	INPUT type sugar freeSO2 totalSO2 density pH alcohol quality;
	IF type = 1 THEN COLOR = "Red";
	ELSE COLOR = "White";
	DROP type;
RUN;

*3. Total sulfur dioxide (totalSO2 ) is a measure of both the free sulfur dioxide (freeSO2) and bound
forms sulfur dioxide. Write a PROC step to test whether the mean of totalSO2 is greater than that
of freeSO2 by 85 at significant level 0.05. (Hint: Use PAIRED statement) (3 pt) And answer the
following questions in comments:;

PROC TTEST DATA = Project3.winequality H0 = 85 ALPHA = .05 SIDE= UPPER;
	PAIRED totalSO2*freeSO2;
RUN;

*a. Check the normality assumption and answer in the comments. (1 pt)

Not normal

b. State the p-value and a conclusion for the test conducted. (1 pt)

P value = 0.3486, fail to reject H0

c. State the confidence interval and does it agree with your conclusion in the previous part.
[84.2922, Infty]
(1 pt)

4. Write a PROC step to test whether the quality of red wine is different from that of white wine at
significant level 0.05. (3 pt);

PROC TTEST DATA = Project3.winequality H0 = 0 ALPHA = 0.05;
	CLASS COLOR;
	VAR quality;
RUN;

*a. State the p-value and a conclusion for the test conducted. (1 pt)

P value = less than 0.0001, reject H0

b. Which one is greater, the quality of red wine or that of white wine? How do you conclude
this based on SAS output result? (1 pt)

The quality of white wine is greater, due to a greater mean value

5. Perform a correlation analysis among 4 variables: SUGAR, PH, ALCOHOL and QUALITY.;

PROC CORR DATA = Project3.winequality;
	VAR SUGAR PH ALCOHOL QUALITY;
RUN;
*(1pts) Answer in comments: which variable has the highest correlation with QUALITY? (1pts)

Alcohol

6. Some experts believe that adding more sugars (SUGAR) can improve the subjective quality of
wine (QUALITY). Run a simple linear regression to answer this question. (1pts) Answer in
comments:;

PROC GLM DATA = Project3.winequality PLOTS= ALL;
	MODEL QUALITY = SUGAR;
RUN;
	
*a. Does adding sugars have an effect on the quality and how do you know?(1pts)
If yes, in a positive way or negative? (1pts)

Yes, Negative

b. Write down the fitted linear model. (1pts)

y = 5.855323456 -0.006786460x

7. Your friend wants to build a regression model to predict the quality of wines. Fit a multiple linear
regression model with the QUALITY as the response and the other variables except for COLOR
as the predictors. (2pts) Answer in comments:;

PROC GLM DATA = Project3.winequality PLOTS = ALL;
	MODEL Quality = sugar freeSO2 totalSO2 density pH alcohol;
RUN;

*a. Use the missing Y trick to obtain and report the prediction interval for a bottle of wine
with the following variable values: sugar = 2.5, freeSO2 = 17, totalSO2 = 42, density =
0.998, PH = 3.4, alcohol = 9.6. (2pts);
DATA temp;
	INPUT sugar freeSO2 totalSO2 density PH alcohol quality;
	DATALINES;
	2.5 17 42 .998 3.4 9.6 .
;
PROC DATASETS;
	APPEND BASE = Project3.winequality DATA =temp;
RUN;
PROC GLM DATA = Project3.winequality PLOTS = ALL;
	MODEL Quality = sugar freeSO2 totalSO2 density pH alcohol/CLI;
RUN;
*PI = [3.87822433 ,	6.88438803]

*b. Which variable(s) are not significant? (1pts)
PH is not significant