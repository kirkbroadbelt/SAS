*
Programmed by: Kirk Broadbelt
Programmed on: 9/15/2020
Programmed to: Create solution for ST 445 (001) HW3

Modified by: Kirk Broadbelt
Modified on: 9/16/2020
Modified to: Add in comments
;
*Set up paths;
x "cd L:\st445\";
libname Results "Results";
filename RawData "Data\BookData\Data\Clinical Trial Case Study";

*More path setup;
x "cd S:\SAS_HW_FILES";
libname HW3 ".";
filename HW3 ".";

*Selecting destinations for output;
ods listing close;
ods pdf file = "HW3 Broadbelt Clinical Report.pdf";
ods rtf file = "HW3 Broadbelt Clinical Report.rtf" style = sapphire;
ods powerpoint file = "HW 3 Broadbelt Clinical Report.pptx" style = powerpointdark;
options nodate;

*Read in raw data of first site;
data HW3.Site1;
  infile RawData("Site 1, Baselilne Visit.txt") dlm='09'x dsd;
  attrib Subj        label = "Subject Number"                     
         sfReas      label = "Screen Failure Reason"               length = $50
         sfStatus    label = "Screen Failure Status (0 = Failed)"  length = $1
         BioSex      label = "Biological Sex"                      length = $1
         VisitDate   label = "Visit Date"                          length = $9
         failDate    label = "Failure Notification Date"           length = $9
         sbp         label = "Systolic Blood Pressure"
         dbp         label = "Diastolic Blood Pressure"
         bpUnits     label = "Units (BP)"                          length = $5
         pulse       label = "Pulse"
         pulseUnits  label = "Units (Pulse)"                       length = $9
         position    label = "Position"                            length = $9
         temp        label = "Temperature"      format = 5.1
         tempUnits   label = "Units (Temp)"                        length = $1
         weight      label = "Weight"     
         weightUnits label = "Units (Weight)"                      length = $2
         pain        label = "Pain Score"
     
  ;
  input Subj              
        sfReas      $   
        sfStatus    $
        BioSex      $
        VisitDate   $
        failDate    $
        sbp
        dbp
        bpUnits     $
        pulse 
        pulseUnits  $
        position    $
        temp
        tempUnits   $
        weight
        weightUnits $
        pain
  ;
run;

*Read in raw data of second site;
data HW3.Site2;
  infile RawData ("Site 2, Baseline Visit.csv") dlm = "," dsd;
  attrib Subj        label = "Subject Number"                     
         sfReas      label = "Screen Failure Reason"               length = $50
         sfStatus    label = "Screen Failure Status (0 = Failed)"  length = $1
         BioSex      label = "Biological Sex"                      length = $1
         VisitDate   label = "Visit Date"                          length = $10
         failDate    label = "Failure Notification Date"           length = $10
         sbp         label = "Systolic Blood Pressure"
         dbp         label = "Diastolic Blood Pressure"
         bpUnits     label = "Units (BP)"                          length = $5
         pulse       label = "Pulse"
         pulseUnits  label = "Units (Pulse)"                       length = $9
         position    label = "Position"                            length = $9
         temp        label = "Temperature"      format = 3.1
         tempUnits   label = "Units (Temp)"                        length = $1
         weight      label = "Weight"     
         weightUnits label = "Units (Weight)"                      length = $2
         pain        label = "Pain Score"
  ;
  input Subj              
        sfReas      $   
        sfStatus    $
        BioSex      $
        VisitDate   $
        failDate    $
        sbp
        dbp
        bpUnits     $
        pulse 
        pulseUnits  $
        position    $
        temp
        tempUnits   $
        weight
        weightUnits $
        pain
  ;
run;

*Read in raw data of third site;
data HW3.Site3;
  infile RawData ("Site 3, Baseline Visit.dat");
  attrib Subj        label = "Subject Number"                     
         sfReas      label = "Screen Failure Reason"               
         sfStatus    label = "Screen Failure Status (0 = Failed)"  
         BioSex      label = "Biological Sex"                      
         VisitDate   label = "Visit Date"                          
         failDate    label = "Failure Notification Date"           
         sbp         label = "Systolic Blood Pressure"
         dbp         label = "Diastolic Blood Pressure"
         bpUnits     label = "Units (BP)"                          
         pulse       label = "Pulse"
         pulseUnits  label = "Units (Pulse)"                       
         position    label = "Position"                            
         temp        label = "Temperature"      format = 3.1
         tempUnits   label = "Units (Temp)"                       
         weight      label = "Weight"     
         weightUnits label = "Units (Weight)"                      
         pain        label = "Pain Score"
  ;
  input @1     Subj              
        @8     sfReas      $50.   
        @59    sfStatus    $1.
        @62    BioSex      $1.
        @63    VisitDate   $10.
        @73    failDate    $10.
        @83    sbp         3.
        @86    dbp         3.
        @89    bpUnits     $5.
        @95    pulse       3.
        @98    pulseUnits  $9.
        @108   position    $9.
        @121   temp        3.
        @124   tempUnits   $1.
        @125   weight      3.
        @128   weightUnits $2.
        @132   pain        1.
  ;
run;

*Closing output to ppt";
ods powerpoint exclude all;

proc sort data = HW3.Site1 out = HW3.Site1Sorted;
  by descending sfStatus sfReas descending VisitDate descending failDate Subj;
run;

proc sort data = HW3.Site2 out = HW3.Site2Sorted;
  by descending sfStatus sfReas descending VisitDate descending failDate Subj;
run;

proc sort data = HW3.Site3 out = HW3.Site3Sorted;
  by descending sfStatus sfReas descending VisitDate descending failDate Subj;
run;

*Closing output to pdf/rtf;
ods pdf exclude all;
ods rtf exclude all;


*Electronically comparing, can look at results.hw3dugginsposition1 to manually compare metadata,
proc print data = Results.hw3dugginsposition
run

ods select Position SortedBy
proc contents data = HW3.Site1Sorted varnum
(add in semicolons to run);

proc compare base = Results.hw3dugginssite1 compare = HW3.Site1Sorted out = work.comp
             outbase outcompare outdiff outnoequal
             method = absolute criterion = 1E-10;
run;

proc compare base = Results.hw3dugginssite1 compare = HW3.Site1Sorted out = work.comp
             outbase outcompare outdiff outnoequal
             method = absolute criterion = 1E-10;
run;

proc compare base = Results.hw3dugginssite1 compare = HW3.Site1Sorted out = work.comp
             outbase outcompare outdiff outnoequal
             method = absolute criterion = 1E-10;
run;

*Enabling pdf rtf output;
ods pdf exclude none;
ods rtf exclude none;
ods noproctitle;

*Displaying variable and sort info for site 1;
ods select Position Sortedby;
title "Variable-level Attributes and Sort Information: Site 1";
proc contents data = HW3.Site1Sorted varnum;
run;
title;

*Displaying variable and sort info for site 2;
ods select Position Sortedby;
title "Variable-level Attributes and Sort Information: Site 2";
proc contents data = HW3.Site2Sorted varnum;
run;
title;

*Displaying variable and sort info for site 3;
ods select Position Sortedby;
title "Variable-level Attributes and Sort Information: Site 3";
proc contents data = HW3.Site3Sorted varnum;
run;
title;

*Disabling pdf/rtf output;
ods pdf exclude all;
ods rtf exclude all;

proc format fmtlib library = HW3;
  value Systol   (fuzz = 0) low -< 130 = "Acceptable"
                            130 - high = "High";

  value Diastol  (fuzz = 0) low -<  80 = "Acceptable"
                            80  - high = "High";
run;

*Enabling pdf/rtf/pptx output;
ods pdf exclude none;
ods rtf exclude none;
ods powerpoint exclude none;

*Displaying certain summary statistics for site 1;
title "Selected Summary Statistics on Baseline Measurements";
title2 "for Patients from Site 1";
footnote j = left h = 8pt "Statistic and SAS keyword: Sample size (n), Mean (mean), Standard Deviation (stddev), Median (median), IQR (qrange)";
proc means data = HW3.Site1Sorted nonobs n mean stddev median qrange maxdec=1;
  class pain;
  var weight temp pulse dbp sbp;
run;
title;
footnote;

*Allowing formats to be used;
options fmtsearch = (HW3);

*Displaying frequency analysis tables for site 2;
ods pdf columns = 2;
title "Frequency Analysis of Baseline Positions and Pain Measurements by Blood Pressure Status";
title2 "for Patients from Site 2";
footnote j = left "Hypertension (high blood pressure) begins when systolic reaches 130 or diastolic reaches 80";
proc freq data = HW3.Site2Sorted;
  table Position;
  table pain*dbp*sbp / nocol norow;
  format sbp Systol. dbp Diastol.;
run;
title;
footnote;

*Disabling output to pptx;
ods powerpoint exclude all;

*Displaying data of selected listing of patients for site 3;
ods pdf columns = 1;
title "Selected Listing of Patients with a Screen Failure and Hypertension";
title2 "for patients from Site 3";
footnote j = left "Hypertension (high blood pressure) begins when systolic reaches 130 or diastolic reaches 80";
footnote2 j = left "Only patients with a screen failure are included.";
proc print data = HW3.Site3Sorted label;
  where (sfStatus eq "0") & (dbp >= 80);
  id Subj pain;
  var VisitDate sfStatus sfReas failDate BioSex sbp dbp bpUnits weight weightUnits;
run;
title;
footnote;

*Closing destinations, enabling listing and date;
ods pdf close;
ods rtf close;
ods powerpoint close;
ods listing;
options date;
quit;
