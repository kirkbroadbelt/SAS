*1. Questions to answer in comments: (5 pts)
a. Describe one kind of hypothesis test you can perform on one sample using PROC
TTEST. (2 pts)

You can do a one sided t test for mean with PROC TTEST

b. What option in the TABLES statement under PROC FREQ lets you perform a
hypothesis test on proportions? (1 pt)

BINOMIAL 

c. A 95% confidence interval of the growth rate of NC State tuition over the last 10
years is [0.03, 0.07]. Give an interpretation of this interval. (2 pts)

I am 95% confident that the true mean growth rate of NC State tuition over the last 10 years will lie
within the interval [0.03, 0.07]

2. Create a new folder called "HW8" on the VCL desktop, download the data file into
this folder and use a LIBNAME to set the folder as a library named “HW8”. (1 pts);

LIBNAME HW8 "/folders/myfolders/sasuser.v94";

*3. Read the dataset into this library (1 pts). Name the dataset as HOMES_PRE and the
variables as ID, BATHROOM, BEDROOM, FIREPLACE, LOTSIZESQFT,
LANDUSE, and TAXAMT. Make sure you use appropriate informats and options
(open the data file to check) (3 pts).;

DATA HW8.HOMES_PRE;
	INFILE "/folders/myfolders/sasuser.v94/homes.csv" FIRSTOBS=2 DSD;
	INPUT ID BATHROOM : 3.1 BEDROOM FIREPLACE LOTSIZESQFT : COMMA6. LANDUSE TAXAMT : DOLLAR10.2;
RUN;

*4. Create a new dataset that is a copy of HOMES_PRE, name it as HOMES and save it
in the library HW8. (1 pt) In the new dataset:
a. Create a new variable called RESIDENT, which is “yes” if the land use code
(LANDUSE) is between 1110 and 1119, inclusive, and “no” otherwise. (These
land use codes encode residential buildings.) (2 pts)
b. Delete the observations with missing LOTSIZESQFT (1 pt). (Hint: search the
MISSING function in SAS help website);

DATA HW8.HOMES;
	SET HW8.HOMES_PRE;
	IF LANDUSE >= 1110 AND LANDUSE <= 1119 THEN RESIDENT = "yes";
		ELSE RESIDENT = "no";
	IF MISSING(LOTSIZESQFT) THEN DELETE;
RUN;

*5. Use a PROC STEP to Test whether the proportion of residential properties (Hint: use
the RESIDENT variable, level is “yes”) in this dataset is equal to 0.8. Use a
significance level of 0.01. (3 pts);

PROC FREQ DATA = HW8.HOMES;
	TABLES RESIDENT/BINOMIAL(LEVEL = "yes" P = 0.8) ALPHA = 0.01;
RUN;
*a. In a comment, interpret the test in context. (2 pts)

Because our P value > alpha, we fail to reject our null hypothesis, that the true proportion of
residential properties is 0.8

b. In a comment, write the 99% confidence interval of the proportion of residential
properties. (1 pt)

I am 99% confident that the true proportion of residential properties lies within the
interval [0.7115, 0.8385]

c. In a comment, explain how the result of 5.b matches the result of 5.a. (1 pt)

The result of 5.a matches 5.b because the true mean that we are testing is .8 and .8 is within our interval

6. Use a PROC STEP to Test whether the average lot size of properties is greater than
10000 square. (2 pts);

PROC TTEST DATA = HW8.HOMES H0 = 10000 SIDE = U;
	VAR LOTSIZESQFT;
RUN;
*a. In a comment state the p-value and interpret the results. (1 pt)

The p-value is 0.994, so we fail to reject the null hypothesis that the average lot size of 
properties is 10000 sqft

b. In a comments answer, do the lot sizes look normally distributed? Which plot did
you use to determine this? (1 pt)

Looking at QQplot, lot sizes are not normally distributed, it is very right skewed




