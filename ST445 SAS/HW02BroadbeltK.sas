*
Programmed by: Kirk Broadbelt
Programmed on: 8/30/2020
Programmed to: Create solution for ST 445 (001) HW2 

Modified by: Kirk Broadbelt
Modified on: 9/7/2020
Modified to: Add in comments
;

*Set filerefs and librefs using only relative paths;
x "cd L:\st445\data";
libname InputDS ".";
filename RawData ".";

x "cd S:\SAS_HW_FILES";
libname HW2 ".";
filename HW2 ".";

*Set output destinations and settings;
ods noproctitle;
ods listing close;
ods pdf file = "HW2 Broadbelt Baseball Report.pdf" style = Journal;
ods rtf file = "HW2 Broadbelt Baseball Report.rtf" style = Sapphire;
options fmtsearch = (InputDS) nodate;

*Read in data and apply labels to the variables;
data HW2.Baseball;
  infile RawData("Baseball.dat") firstobs = 14 dlm = '2C09'x dsd;
  attrib FName    label = "First Name"                       length = $9          
         LName    label = "Last Name"                        length = $11         
         Team     label = "Team at the end of 1986"          length = $13         
         nAtBat   label = "# of At Bats in 1986"
         nHits    label = "# of Hits in 1986"
         nHome    label = "# of Home Runs in 1986"
         nRuns    label = "# of Runs in 1986"
         nRBI     label = "# of RBIs in 1986"
         nBB      label = "# of Walks in 1986"
         YrMajor  label = "# of Years in the Major Leagues"
         CrAtBat  label = "# of At Bats in Career"
         CrHits   label = "# of Hits in Career"
         CrHome   label = "# of Home Runs in Career"
         CrRuns   label = "# of Runs in Career"
         CrRbi    label = "# of RBIs in Career"
         CrBB     label = "# of Walks in Career"
         League   label = "League at the end of 1986"        length = $8
         Division label = "Division at the end of 1986"      length = $4
         Position label = "Position(s) Played"               length = $2
         nOuts    label = "# of Put Outs in 1986"
         nAssts   label = "# of Assists in 1986"
         nError   label = "# of Errors in 1986"
         Salary   label = "Salary (Thousands of Dollars)"    format = dollar10.3
  ;
  input LName $ FName $ Team $ nAtBat 49-53 nHits 54-57 nHome 58-61 nRuns 62-65 nRBI 66-69 nBB 70-73 YrMajor 74-77 CrAtBat 78-82 CrHits 83-86
        CrHome 87-90 CrRuns 91-94 CrRbi 95-98 CrBB 99-102 League $ Division $ Position $ nOuts 133-136 nAssts 137-140 nError 141-144 
        Salary 145-152
  ;
run;

*Output to rtf (only) descriptor information;
ods pdf exclude all;
title "Variable-Level Metadata (Descriptor) Information";
ods select Position;
proc contents data = HW2.Baseball varnum;
run;
title;

*Output of format details;
title "Salary Format Details";
proc format fmtlib library = InputDS;
  select Salary;
run;
title;

*Sending output to pdf again, five number summaries;
ods pdf exclude none;
title "Five Number Summaries of Selected Batting Statistics";
title2 h = 10pt "Grouped by League (1986), Division (1986), and Salary Category (1987)";
proc means data = HW2.Baseball min p25 p50 p75 max nolabels maxdec = 2 missing;
  where lowcase(Division) in ("east" "west");
  class League Division Salary;
  var nHits nHome nRuns nRBI nBB;
  format Salary Salary.;
run;
title;

*Frequency summaries;
title "Breakdown of Players by Position and Position by Salary";
proc freq data = HW2.Baseball;
  table Position 
        Position*Salary / missing;
  format Salary Salary.;
run;
title;

*Sort data set as needed for later report elements;
proc sort data = HW2.Baseball out = Baseball;
  by League Division Team descending Salary; 
run;

*Print grouped records to match provided report;
title "Listing of Selected 1986 Players";
footnote j = left h = 8pt "Included: Players with Salaries of at least $1,000,000 or who played for the Chicago Cubs";
proc print data = Baseball label;
  where  ((lowcase(League) = "national") and (lowcase(Team) = "chicago")) or (Salary >= 1000);
  id LName FName Position;
  var League Division Team Salary nHits nHome nRuns nRBI nBB;
  sum Salary nHits nHome nRuns nRBI nBB;
  format Salary dollar11.3
         nHits  comma5.
         nRuns  comma5.
         nRBI   comma5.
         nBB    comma5.
  ;
run;
footnote;

*Close PDF and open LISTING destinations;
ods pdf close;
ods rtf close;
ods listing;

quit;
