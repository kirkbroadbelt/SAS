*Task 1: Reading Data into SAS:
Write code corresponding to each step below, that is, do not change the code for step 1 to
do step 2 (you can copy and paste it so you don’t have to retype it, but leave the answer
to each step in your program). Remember to follow the formatting directions and answer
questions in comments below your code.
1. In your code, use a LIBNAME statement to create a new library called HW10 to
save your data. (1 pt);

LIBNAME HW10 "/folders/myfolders/sasuser.v94";

*2. Read the diamonds file into your HW10 library, and name it DIAMOND. Make
sure all data is read in with correct informats and options (Hint: look at the data in
diamond.txt in notepad to see which variables need informats). (5 pts);

DATA HW10.DIAMOND;
	INFILE "/folders/myfolders/sasuser.v94/diamonds.txt" DSD FIRSTOBS= 2;
	INPUT Carat depthP table price :DOLLAR6. length width depth clarity $ color $ cut : $9.;
RUN;

*Task 2: Performing Linear Regressions:
3. Use PROC CORR and in a comment, report a 95% confidence interval for the
correlation between length and price (Hint: use the FISHER option in PROC
CORR). (3 pts);

PROC CORR DATA = HW10.DIAMOND FISHER;
	VAR length price;
RUN;

* [0.845912, 0.927418] 95% CI for length price

*4. Using an appropriate PROC step, fit a linear regression using price and width.
Consider carefully which should be the response and which should be the
predictor. (2 pts)
a. use an option to produce diagnostic plots for the residuals (2 pts)
b. use options that will include confidence limits for the slope and intercept
(2 pts);

PROC GLM DATA = HW10.DIAMOND PLOTS= ALL;
	MODEL price = width/CLPARM;
RUN;


*5. Based on the result you got from Q4, in comments, answer the following
questions:
a. Report the slope (1 pt)

3399.56916	

b. Report the intercept (1 pt)

-15330.42449

c. What can you conclude from your study? (Hint: look at the p-value for the
slope.) What problems, if any, might you have with the conclusion
(remember correlation vs causation)? (3 pts)

Correlation != Causation
We cannot suggest causation, and want to keep it in an observational setting, so a decent conclusion would be:

If we randomly select two diamonds with the width differing by one, we would expect the price of the diamond
to differ by about $3399
