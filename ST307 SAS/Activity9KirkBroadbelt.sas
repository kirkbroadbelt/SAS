*1. Questions to answer in comments: (5 pts)
a. What is paired data? Give a scenario which contains paired data (2 pts)?

Two observations on same experimental unit, like test score before and after adderall.

b. What statement in SAS allows you to analyze paired data (1 pt)?

PAIRED

c. How can we check that the assumption of normality holds for our data (2 pts)?

Check a QQPlot to see if data is normal

2. Create a new folder called "HW9" on the VCL desktop, download the data file into
this folder and use a LIBNAME to set the folder as a library named “HW9”. (2pts);

LIBNAME HW9 "/folders/myfolders/sasuser.v94";

*3. Read in the dataset: Read the Reaction Times data into the HW9 library using
appropriate informats and options, name it as React_Pre. (4 pts);

DATA HW9.React_Pre;
	INFILE "/folders/myfolders/sasuser.v94/reactiontimes.csv";
	INPUT Before After Age : DOLLAR5. Accident $;
	
*4. Manipulate variables: create a new dataset React using the React_Pre dataset in the
HW9 library by following these steps:
a. Copy the Reaction Times dataset. (1 pt)
b. Create a variable called Crash which re-codes Accident as “Yes” and “No”
(“Yes” for 1 and “No” for 0). (2 pts)
c. Drop the Accident variable. (1 pt);

DATA HW9.React;
	SET HW9.React_Pre
	IF Accident = "1" THEN Crash = "Yes";
	ELSE Crash = "No";
	DROP Accident;
RUN;

*5. Two sample t-test:
a. Test for a difference in mean reaction time after drink consumption between
drivers who have been in an accident and those who have not. Assume equality of
variances. (4 pts) In a comment, state the p-value and a conclusion for the test
conducted. (2 pts);

PROC TTEST DATA = HW9.React ALPHA = .1 ORDER = data;
	CLASS Crash;
	VAR After;
RUN;

*P-Value= 0.6177, Fail to reject H0, no statistically significant difference between react time between groups

b. Test to see if the difference in reaction time (after – before) is greater than 0.5
seconds without creating any new variables. (4 pts) In a comment, state the
p-value and a conclusion for the test conducted. (2 pts);

PROC TTEST DATA = HW9.React H0=0.5 SIDE = U;
PAIRED Before*After;
RUN;

*P-value= 0.4970,
Fail to reject H0, the difference in reaction time mean is not statistically significant from 0.5.
