*
Programmed by: Kirk Broadbelt
Programmed on: 8/24/2020
Programmed to: Create solution for ST 445 (001) HW 1

Modified by: Kirk Broadbelt
Modified on: 8/26/2020
Modified to: Final tweaks, changes, and comments
;

*Create a library that points to the provided data sets and name this library InputDS;
x "cd L:\st555\data";
libname InputDS ".";

*Create a library named HW1 that points to the location where you will store any data sets you create.;
x "cd S:\SAS_HW_FILES";
libname HW1 ".";

*Open PDF destination and set any destination-specific options;
ods pdf file = "HW1 Broadbelt Shoes Report.pdf" style = festival;

*Closes output to listing window;
ods listing close;

*ods formatting options;
ods noproctitle; 
options nodate number;

*Output of Descriptor Information Before Sorting;
title "Descriptor Information Before Sorting";
proc contents data = InputDS.Shoes varnum;
  ods select Attributes Position;
run;

*Sorting by region, subsidiary, descending product;
proc sort data = InputDS.Shoes out = work.Shoes;
  by Region Subsidiary descending Product;
run;

*Output of Descriptor Information After Sorting;
title "Descriptor Information After Sorting";
proc contents data = work.Shoes varnum;
  ods select Attributes Position SortedBy;
run;

*Output of Date, Sales, Inventory, Number of stores, and returns 
in each combination of sales region, locale, and product description
then summed totals of Sales, Inventory, and Returns
;
title "Listing of Amounts";
title2 h = 8pt "Including Region and Subsidiary within Region Totals";
proc print data = work.Shoes noobs label ;
  by Region Subsidiary descending Product;
  id Region Subsidiary Product;
  var Date Sales Inventory Returns Stores;
  sum Sales Inventory Returns;  
  pageby region;
  attrib  Region     label = "Sales Region"                    
          Subsidiary label = "Locale within Region"
          Product    label = "Product Description"          
          Date       label = "Reporting Date"                 format = YYMMDD10.
          Sales      label = "Reseller's Sales"               format = DOLLAR12.
          Inventory  label = "Reseller's Inventory"           format = DOLLAR12.
          Returns    label = "Reseller's Returns"             format = DOLLAR12.
          Stores     label = "Number of Stores in Subsidiary";
run;

*GPP title clear;
title;
title2;

*Creating Tiers format for the Returns variable, creating 
conditional statements for each tier.
;
proc format;
  value Tiers (fuzz = 0)
    0    <- 600  = "Tier 1"
    600  <- 1400 = "Tier 2"
    1400 <- 3500 = "Tier 3"
    3500 <- high = "Tier 4"
  ;
run;

*Output of N, minimum, LQ, median, UQ, and maximum categorized by Region, Product, and Returns;
title "Selected Numerical Summaries of Shoe Sales";
title2 h = 8pt "by Type, Region, and Returns Classification";
footnote j = left "Excluding Slipper and Sandal";
footnote2 j = left "Tier 1=Up to $600, Tier 2=Up to $1400, Tier 3=Up to $3500, Tier 4=Over $3500";
proc means data = work.Shoes nonobs n min q1 median q3 max maxdec=1;
  class Region Product Returns; 
  var Stores Sales Inventory;
  where lowcase(Product) not in ("sandal" "slipper");
  attrib Region     label = "Sales Region"                    
         Subsidiary label = "Locale within Region"
         Product    label = "Product Description"
         Returns    label = "Reseller's Returns" format = Tiers.
         Inventory  label = "Reseller's Inventory"         
         Sales      label = "Reseller's Sales"             
         Stores     label = "Number of Stores in Subsidiary";
run;

*GPP title clear;
title;
title2;

*Output of frequency of: stores in each region,
                         product in each region,
                         returns in each region.
;
title "Frequency of Stores by Region and Region by Product";
title2 "and Region by Returns Classification";
proc freq data = work.Shoes;
  table Region 
        Region*Product;
*for some reason when I tried to do the following:
  table Region
        Region*Product
        Region*Returns /nocol
  the second table (Region*Prodcut) would not have the col pct included on it,
  when I seperate it into two table statements, it includes the col pct, like on
  duggins pdf. It may be redundant to have the two table statements,
  but I am unsure of how to fix this at the current time,
  I'm assuming it's some problem with the syntax.
  ;
  table Region*Returns /nocol;
  weight Stores;
  where lowcase(Product) not in ("sandal" "slipper");
  attrib Region     label = "Sales Region"
         Product    label = "Product Description"
         Returns    label = "Reseller's Returns" format = Tiers.
  ;
run;

*GPP title and footnote clear;
title;
title2;
footnote;
footnote2;

*Close the PDF, re-open the LISTING, restore default proc titles;
ods pdf close;
ods listing;
ods proctitle;

*GPP-mandated QUIT statement;
quit;
