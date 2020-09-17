*1. Create a new folder called "Project1" on the VCL desktop, download the data file
into this folder and use a LIBNAME to set the folder as a library named
“Project1”. (2pts);
LIBNAME Project1 "/folders/myfolders/sasuser.v94";
RUN;

*2. Read the data file without INFORMATS but with the correct OPTIONS on the INFILE statement (2 pts), then answer the following questions:;
DATA Project1.AusWeather;
	INFILE "/folders/myfolders/sasuser.v94/AusWeather.csv" FIRSTOBS=2 DSD;
	INPUT Date Location $ MinTemp MaxTemp Rainfall WindGustDir $ WindGustSpeed Humidity Pressure RainToday $;
RUN;

*a) Use the Explorer pane to preview the dataset. Which variables were not read
in correctly? (2 pts) (Hint: It may help to open the raw data set and compare.)

Date, Location, and Humidity were read in incorrectly

b) Use INFORMATS to correct the misspecified variables. (4 pts) Note: You’ll
need to use INFORMATS for three variables (not including $).;
DATA Project1.AusWeather;
	INFILE "/folders/myfolders/sasuser.v94/AusWeather.csv" FIRSTOBS=2 DSD;
	INPUT Date : YYMMDD10. Location : $16. MinTemp MaxTemp Rainfall WindGustDir $ WindGustSpeed Humidity : PERCENT3. Pressure RainToday $;
RUN;

*
c) In a comment: What is the purpose of an informat? (1 pt)

An INFORMAT helps us read in data that is in a different format

3. Use the following code to sort the AusWeather data and save it in a new dataset.
(1 pt).;

PROC SORT DATA=Project1.AusWeather OUT=sortedAusWeather;
	BY RainToday;
RUN;

*a) Which library is the new dataset stored in? (1 pt) (Hint: You may want to
look at the OUT = option.)

The new sorted data set is in the work library

b) What is the difference between a temporary and permanent library? (1 pt)

A temporary libary is lost when SAS closes, a permanent library is useable in future SAS sessions and is not lost when SAS closes.

4. Use one PROC step to answer the following questions:;
PROC UNIVARIATE DATA= sortedAusWeather CIBASIC (alpha= .01);
	VAR Humidity;
	BY RainToday;
RUN;
*c) What are the Humidity means for rainy days and days without rain? Only
include output for the humidity variable. (2 pts)

Humidity with rain mean = .66105646
Humidity without rain mean = .46956749

*d) Report in a comment the 99% confidence intervals for the mean Humidity
for these two categories. (2 pts) (Hint: the default confidence level is 95%.
You’ll need an option to change that.)

Humidity with rain 99% CI = (.65695, .66516)
Humidity without rain 99% CI = (.46715, .47199)

5. Use the unsorted dataset AusWeather and create two contingency tables that allow
you to answer the following questions (one table for each):;
PROC FREQ DATA= Project1.AusWeather;
	TABLES Location*RainToday / NOCOL;
	TABLES WindGustDir / NOCOL;
RUN;

*a) Which city has the highest rain probability? (3 pts)

Walpole

b) Which wind direction occurred most frequently? (3 pts)

West

c) What is the purpose of creating contingency tables? (1 pt)

Contingency tables allow us to look at the frequency of different categorical variables
 
6. Use only one PROC step to plot a vertical boxplot of Pressure for different groups
of RainToday. (Tips: Need an option here). (2 pts) And answer the following
question:;
PROC SGPLOT DATA= Project1.AusWeather;
	VBOX Pressure / CATEGORY= RainToday;
RUN;

*a) Based on the boxplot, which group has higher pressure on average? What did
you use from your plot to determine this? (2 pts)

The no RainToday group has higher pressure	

7. Make a correlation matrix of MinTemp, MaxTemp, Rainfall, WindGustSpeed,
Humidity and Pressure. Which variable has the strongest correlation with Rainfall
(other than Rainfall itself) ? (3 pts);

PROC CORR DATA= Project1.AusWeather;
	VAR MinTemp MaxTemp Rainfall WindGustSpeed Humidity Pressure;
RUN; 

*rainfall and humidity have the strongest correlation;
