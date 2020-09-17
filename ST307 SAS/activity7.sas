*1. Questions to answer in comments: (5 pts)
a. Can we use WHERE statements to subset records when reading raw data?

No

b. What is the purpose of WHERE statements?

WHERE statements selects observations from SAS data sets only.

c. True or false: IF statements can be used to subset observations or create new
variables.

True

d. Write down an alternative symbol for “AND” in a logical statement.

&

e. Is there any difference between using the DROP statements and DROP options in
a DATA step?

No, either can be used.

2. Create a new folder called "HW7" on the VCL desktop, download the data file into
this folder and use a LIBNAME to set the folder as a library named “HW7”. (2pts);
LIBNAME HW7 "/folders/myfolders/sasuser.v94";
RUN;

*3. Read in the dataset: read the dataset into this library (1 pts). Name the dataset as
Beer_Pre and the variables as Month, Sales, HighTemp and LowTemp. Make sure
you use appropriate informats and options (open the data file to check) (3 pts) and
also complete the following two tasks while reading in this dataset:
a. Create a new variable DiffTemp which is the difference between the HighTemp
and the LowTemp. (1 pt)
b. Drop the variable LowTemp (1 pt).;

DATA HW7.Beer_Pre;
	INFILE "/folders/myfolders/sasuser.v94/beer.txt" FIRSTOBS=2 DSD;
	INPUT Month : DDMMYY10. Sales : 7.3 HighTemp : 3.1 LowTemp : 3.1;
	DiffTemp = HighTemp - LowTemp;
	DROP LowTemp;
RUN;


*4. Manipulate variables: create a dataset Beer using the Beer_Pre dataset and save it in
the HW7 library. (1 pt)
a. And a new variable Sales_new by rounding the Sales variable to 0 decimal place
(e.g., 130.20 to 130). (1 pt) [Hint: search SAS help for this ROUND function]
b. And a new variable Performance: if Sales_new > 220, Performance = “High” if
Sales_new < 180, Performance = “Low” otherwise, Performance = “Medium”.
(3 pts);

DATA HW7.Beer;
	SET HW7.Beer_Pre;
	Sales_new = ROUND(Sales,1);
	IF (Sales_new > 220) THEN Performance = "High";
		ELSE IF (Sales_new < 180) THEN Performance = "Low";
		Else Performance = "Medium";
RUN;

*5. Analyze the dataset Beer with conditions:
a. Report the mean and standard deviation of Sales between 2009-01 and 2009-12.
(3 pts) [Hint: this page gives examples on how to compare Dates in WHERE
statements]
b. You would like to see records with “High” Performance and DiffTemp > 5. Print
out only those records. (2 pts). Answer in comments: how many observations do
you print? (1 pt);

PROC MEANS DATA = HW7.Beer;
	WHERE Month>='01jan2009'd and Month<='01dec2009'd;
	VAR Sales;
RUN;

PROC PRINT DATA = HW7.Beer;
	WHERE Performance = "High" and DiffTemp > 5;
RUN;

*13 observations

