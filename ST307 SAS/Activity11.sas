*Task 1:
Conceptual questions
After the header in your program, answer the following questions in comments.
1) Named three assumptions of the linear regression model. (3 pts)

Errors independent, normally distribution, constant variance

2) Which plot can we use to check constant variance? (1 pt)

Residuals plot 

3) What is the difference between a confidence interval and a prediction interval? (2
pts)

Confidence interval for a true mean of a population, prediction interval is for an individual
Task 2:
Write code corresponding to each step below, that is, do not change the code for step 1 to
do step 2 (you can copy and paste it so you don’t have to retype it, but leave the answer
to each step in your program). Remember to follow the formatting directions and answer
questions in comments below your code.
1. In your code, use a LIBNAME statement to create a new library called HW11 to
save your data. (1 pt);

LIBNAME HW11 "/folders/myfolders/sasuser.v94";

*2. Read the admission.csv file into your HW11 library, and name it ADMISSION.
Make sure all data is read in with correct informats and options (Hint: look at the
data in admission.csv in notepad to see which variables need informats). (2 pts);

DATA HW11.ADMISSION;
	INFILE "/folders/myfolders/sasuser.v94/admission.csv" DSD FIRSTOBS= 2;
	INPUT GRE SOP LOR CGPA ADMIT;
RUN;

*3. Use a PROC step to fit a multiple linear regression model for ADMIT with GRE,
SOP, LOR and GRE*GRE (2 pts), produce the diagnostic plots (1 pt) and get
95% confidence intervals for slope parameters. (1 pt);

PROC GLM DATA= HW11.ADMISSION PLOTS=ALL; 
	MODEL ADMIT = GRE SOP LOR GRE*GRE/CLPARM CLM;
RUN;
QUIT;
*Answer the following questions in a comment:
1) Do the residuals look normally distributed? Are there any patterns? Please
specify the plots which you make your conclusions based on. (2 pts)

The residuals look normally distriuted based off of the residuals vs quantile plot.
Some deviance in the tails, but can be considered normal enough.

2) Report the estimated slope for GRE*GRE and interpret the p-value for a
t-test of the slope coefficient for GRE*GRE against being 0. (Hint:
α=0.05) (2 pts)

Slope = 0.00014432	
P value = 0.0816

4. Suppose there is one student, whose GRE score is 300, SOP is 4.5, LOR is 3.5
and CGPA is 7.5. Use the model you just built to predict the chance of admission
for the student, and get a 95% prediction interval. Hint: you may do it in three
SAS steps:
1) Make a temporary data set. ADMIT will be missing for this observation (2
pts);
DATA temp;
	INPUT GRE SOP LOR CGPA ADMIT;
	DATALINES;
	300 4.5 3.5 7.5 .
;

*2) Append the temporary data set to the dataset ADMISSION (2 pts);

PROC DATASETS;
	APPEND BASE = HW11.ADMISSION DATA =temp;
RUN;

*3) Fit the linear model once again with proper options (3 pts);

PROC GLM DATA= HW11.ADMISSION PLOTS=ALL; 
	MODEL ADMIT = GRE SOP LOR GRE*GRE/CLI;
RUN;
QUIT;
*4) In a comment, report the predicted ADMIT and the 95% prediction
interval (2 pts)

Predicted ADMIT = 0.64041694	
95% PI = [0.44632693 , 0.83450695]

