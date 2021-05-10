
clear all

cd "$pathcovir2"

cd merge

capture log close

log using "log Iran merge.smcl", replace


***************************************************************************
* This is "do Iran merge.do"

* Project: COVID-19 Iran Review No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Merge component studies' estimates for Iran, grphas
***************************************************************************


/* studies:
JOHN
DELP // this uptake was created retrospectively and dated or previous updates of DELP are not existent.
IHME
IMPE
LANL
SRIV
SOLT
GHAN
*/




* JOHN

if regexm(c(os),"Mac") == 1 {

	use "$pathcovir2/JOHN/Iran JOHN.dta", clear 
}
else if regexm(c(os),"Windows") == 1 use "$pathcovir2\JOHN\Iran JOHN.dta", clear 



/* DELP // this uptake was created retrospectively and dated or previous updates of DELP are not existent.

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/DELP/Iran DELP.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\DELP\Iran DELP.dta"

drop _merge */



* IHME

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/IHME/Iran IHME.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\IHME\Iran IHME.dta"

drop _merge



* IMPE

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/IMPE/Iran IMPE.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\IMPE\Iran IMPE.dta"

drop _merge



* LANL

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/LANL/Iran LANL.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\LANL\Iran LANL.dta"

drop _merge


* SRIV



if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/SRIV/Iran SRIV.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\SRIV\Iran SRIV.dta"

drop _merge



* SOLT



if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/SOLT/Iran SOLT"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\SOLT\Iran SOLT"

drop _merge 



* GHAN

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/GHAN/Iran GHAN"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\GHAN\Iran GHAN"

drop _merge 







* 

label var loc_grand_name "Location"







*************************************


* Cases to deaths ratio


gen DayCTDMeRaA00S00V00 =  DayCasMeRaA00S00V00 / DayDeaMeRaA00S00V00

label var DayCTDMeRaA00S00V00  "Daily Cases to Deaths S0 JOHN"

gen TotCTDMeRaA00S00V00 =  TotCasMeRaA00S00V00 / TotDeaMeRaA00S00V00

label var TotCTDMeRaA00S00V00  "Total Cases to Deaths S0 JOHN"



/*
gen DayCTDMeRaA01S00V03 =  DayCasMeRaA01S00V03 / DayDeaMeRaA01S00V03

label var DayCTDMeRaA01S00V03  "Daily Cases to Deaths S0 DELP"

gen TotCTDMeRaA01S00V03 =  TotCasMeRaA01S00V03 / TotDeaMeRaA01S00V03

label var TotCTDMeRaA01S00V03  "Total Cases to Deaths S0 DELP"  
*/



gen DayCTDMeRaA02S01V03  =  DayCasMeRaA02S01V03  / DayDeaMeRaA02S01V03 

label var DayCTDMeRaA02S01V03   "Daily Cases to Deaths S1 IHME"

gen TotCTDMeRaA02S01V03  =  TotCasMeRaA02S01V03  / TotDeaMeRaA02S01V03 

label var TotCTDMeRaA02S01V03   "Total Cases to Deaths S1 IHME"




gen DayCTDMeRaA02S02V03 = DayCasMeRaA02S02V03 / DayDeaMeRaA02S02V03  

label var DayCTDMeRaA02S02V03 "Daily Cases to Deaths S2 IHME"

gen TotCTDMeRaA02S02V03 = TotCasMeRaA02S02V03 / TotDeaMeRaA02S02V03  

label var TotCTDMeRaA02S02V03 "Total Cases to Deaths S2 IHME"




gen DayCTDMeRaA02S03V03  = DayCasMeRaA02S03V03  / DayDeaMeRaA02S03V03   

label var DayCTDMeRaA02S03V03  "Daily Cases to Deaths S3 IHME"

gen TotCTDMeRaA02S03V03  = TotCasMeRaA02S03V03  / TotDeaMeRaA02S03V03   

label var TotCTDMeRaA02S03V03  "Total Cases to Deaths S3 IHME"






gen DayCTDMeRaA03S01V07  = DayCasMeRaA03S01V07  / DayDeaMeRaA03S01V07   

label var DayCTDMeRaA03S01V07  "Daily Cases to Deaths S1 IMPE"

gen TotCTDMeRaA03S01V07  = TotCasMeRaA03S01V07  / TotDeaMeRaA03S01V07   

label var TotCTDMeRaA03S01V07  "Total Cases to Deaths S1 IMPE"



gen DayCTDMeRaA03S02V07  = DayCasMeRaA03S02V07  / DayDeaMeRaA03S02V07   

label var DayCTDMeRaA03S02V07  "Daily Cases to Deaths S2 IMPE"

gen TotCTDMeRaA03S02V07  = TotCasMeRaA03S02V07  / TotDeaMeRaA03S02V07   

label var TotCTDMeRaA03S02V07  "Total Cases to Deaths S2 IMPE"



gen DayCTDMeRaA03S03V07  = DayCasMeRaA03S03V07  / DayDeaMeRaA03S03V07   

label var DayCTDMeRaA03S03V07  "Daily Cases to Deaths S3 IMPE"

gen TotCTDMeRaA03S03V07  = TotCasMeRaA03S03V07  / TotDeaMeRaA03S03V07   

label var TotCTDMeRaA03S03V07  "Total Cases to Deaths S3 IMPE"





gen DayCTDMeRaA04S00V02  = DayCasMeRaA04S00V02  / DayDeaMeRaA04S00V02   

label var DayCTDMeRaA04S00V02  "Daily Cases to Deaths S0 LANL"

gen TotCTDMeRaA04S00V02  = TotCasMeRaA04S00V02  / TotDeaMeRaA04S00V02   

label var TotCTDMeRaA04S00V02  "Total Cases to Deaths S0 LANL"






gen DayCTDMeRaA05S00V02  = DayCasMeRaA05S00V02  / DayDeaMeRaA05S00V02   

label var DayCTDMeRaA05S00V02  "Daily Cases to Deaths S0 SRIV"

gen TotCTDMeRaA05S00V02  = TotCasMeRaA05S00V02  / TotDeaMeRaA05S00V02   

label var TotCTDMeRaA05S00V02  "Total Cases to Deaths S0 SRIV"




***********************

* daily deaths estimated to reported  

    
gen DayDERMeRaA00S00V00 = DayDeaMeRaA00S00V00 / DayDeaMeRaA00S00V00

label var DayDERMeRaA00S00V00 "Daily Deaths estim to reported JOHN = 1" 

/*
gen DayDERMeRaA01S00V03 = DayDeaMeRaA01S00V03 / DayDeaMeRaA00S00V00

label var DayDERMeRaA01S00V03 "Daily Deaths estim to reported Mean DELP S0 V3"

line DayDeaMeRaA01S00V03  DayDeaMeRaA00S00V00 date

* DELPHI, no overlap of DayDeaMeRaA01S00V03 and DayDeaMeRaA00S00V00
*/


gen DayDERMeRaA02S01V03 = DayDeaMeRaA02S01V03 / DayDeaMeRaA00S00V00

label var DayDERMeRaA02S01V03 "Daily Deaths estim to reported Mean not smoothed IHME S1"


gen DayDERMeRaA02S02V03 = DayDeaMeRaA02S02V03 / DayDeaMeRaA00S00V00

label var DayDERMeRaA02S02V03 "Daily Deaths estim to reported Mean not smoothed IHME S2"


gen DayDERMeRaA02S03V03 = DayDeaMeRaA02S03V03 / DayDeaMeRaA00S00V00

label var DayDERMeRaA02S03V03 "Daily Deaths estim to reported Mean not smoothed IHME S3"



gen DayDERMeRaA03S01V07 = DayDeaMeRaA03S01V07 / DayDeaMeRaA00S00V00

label var DayDERMeRaA03S01V07 "Daily Deaths estim to reported Mean S1 IMPE"


gen DayDERMeRaA03S02V07 = DayDeaMeRaA03S02V07 / DayDeaMeRaA00S00V00

label var DayDERMeRaA03S02V07 "Daily Deaths estim to reported Mean S2 IMPE"


gen DayDERMeRaA03S03V07 = DayDeaMeRaA03S03V07 / DayDeaMeRaA00S00V00

label var DayDERMeRaA03S03V07 "Daily Deaths estim to reported Mean S3 IMPE"



gen DayDERMeRaA04S00V02 = DayDeaMeRaA04S00V02 / DayDeaMeRaA00S00V00

label var DayDERMeRaA04S00V02 "Daily Deaths estim to reported to Deaths S0 LANL"



gen DayDERMeRaA05S00V02  = DayDeaMeRaA05S00V02 / DayDeaMeRaA00S00V00

label var DayDERMeRaA05S00V02 "Daily Deaths estim to reported S0 SRIV"






* daily cases estimated to reported  


gen DayCERMeRaA00S00V00 = DayCasMeRaA00S00V00 / DayCasMeRaA00S00V00

label var DayCERMeRaA00S00V00 "Daily Cases estim to reported JOHN = 1" 


/*
gen DayCERMeRaA01S00V03 = DayCasMeRaA01S00V03 / DayCasMeRaA00S00V00

label var DayCERMeRaA01S00V03 "Daily Cases estim to reported Mean DELP S0 V3"
*/


gen DayCERMeRaA02S01V03 = DayCasMeRaA02S01V03 / DayCasMeRaA00S00V00

label var DayCERMeRaA02S01V03 "Daily Cases estim to reported Mean not smoothed IHME S1"


gen DayCERMeRaA02S02V03 = DayCasMeRaA02S02V03 / DayCasMeRaA00S00V00

label var DayCERMeRaA02S02V03 "Daily Cases estim to reported Mean not smoothed IHME S2"


gen DayCERMeRaA02S03V03 = DayCasMeRaA02S03V03 / DayCasMeRaA00S00V00

label var DayCERMeRaA02S03V03 "Daily Cases estim to reported Mean not smoothed IHME S3"



gen DayCERMeRaA03S01V07 = DayCasMeRaA03S01V07 / DayCasMeRaA00S00V00

label var DayCERMeRaA03S01V07 "Daily Cases estim to reported Mean S1 IMPE"


gen DayCERMeRaA03S02V07 = DayCasMeRaA03S02V07 / DayCasMeRaA00S00V00

label var DayCERMeRaA03S02V07 "Daily Cases estim to reported Mean S2 IMPE"


gen DayCERMeRaA03S03V07 = DayCasMeRaA03S03V07 / DayCasMeRaA00S00V00

label var DayCERMeRaA03S03V07 "Daily Cases estim to reported Mean S3 IMPE"



gen DayCERMeRaA04S00V02 = DayCasMeRaA04S00V02 / DayCasMeRaA00S00V00

label var DayCERMeRaA04S00V02 "Daily Cases estim to reported to Cases S0 LANL"



gen DayCERMeRaA05S00V02  = DayCasMeRaA05S00V02 / DayCasMeRaA00S00V00

label var DayCERMeRaA05S00V02 "Daily Cases estim to reported S0 SRIV"






* Total deaths estimated to reported  


gen TotDERMeRaA00S00V00 = TotDeaMeRaA00S00V00 / TotDeaMeRaA00S00V00

label var TotDERMeRaA00S00V00 "Total Deaths estim to reported JOHN = 1" 


/*
gen TotDERMeRaA01S00V03 = TotDeaMeRaA01S00V03 / TotDeaMeRaA00S00V00

label var TotDERMeRaA01S00V03 "Total Deaths estim to reported Mean DELP S0 V3"
*/


gen TotDERMeRaA02S01V03 = TotDeaMeRaA02S01V03 / TotDeaMeRaA00S00V00

label var TotDERMeRaA02S01V03 "Total Deaths estim to reported Mean not smoothed IHME S1"


gen TotDERMeRaA02S02V03 = TotDeaMeRaA02S02V03 / TotDeaMeRaA00S00V00

label var TotDERMeRaA02S02V03 "Total Deaths estim to reported Mean not smoothed IHME S2"


gen TotDERMeRaA02S03V03 = TotDeaMeRaA02S03V03 / TotDeaMeRaA00S00V00

label var TotDERMeRaA02S03V03 "Total Deaths estim to reported Mean not smoothed IHME S3"



gen TotDERMeRaA03S01V07 = TotDeaMeRaA03S01V07 / TotDeaMeRaA00S00V00

label var TotDERMeRaA03S01V07 "Total Deaths estim to reported Mean S1 IMPE"


gen TotDERMeRaA03S02V07 = TotDeaMeRaA03S02V07 / TotDeaMeRaA00S00V00

label var TotDERMeRaA03S02V07 "Total Deaths estim to reported Mean S2 IMPE"


gen TotDERMeRaA03S03V07 = TotDeaMeRaA03S03V07 / TotDeaMeRaA00S00V00

label var TotDERMeRaA03S03V07 "Total Deaths estim to reported Mean S3 IMPE"



gen TotDERMeRaA04S00V02 = TotDeaMeRaA04S00V02 / TotDeaMeRaA00S00V00

label var TotDERMeRaA04S00V02 "Total Deaths estim to reported to Deaths S0 LANL"



gen TotDERMeRaA05S00V02  = TotDeaMeRaA05S00V02 / TotDeaMeRaA00S00V00

label var TotDERMeRaA05S00V02 "Total Deaths estim to reported S0 SRIV"






* Total cases estimated to reported  


gen TotCERMeRaA00S00V00 = TotCasMeRaA00S00V00 / TotCasMeRaA00S00V00

label var TotCERMeRaA00S00V00 "Total Cases estim to reported JOHN = 1" 

/*
gen TotCERMeRaA01S00V03 = TotCasMeRaA01S00V03 / TotCasMeRaA00S00V00

label var TotCERMeRaA01S00V03 "Total Cases estim to reported Mean DELP S0 V3"
*/


gen TotCERMeRaA02S01V03 = TotCasMeRaA02S01V03 / TotCasMeRaA00S00V00

label var TotCERMeRaA02S01V03 "Total Cases estim to reported Mean not smoothed IHME S1"


gen TotCERMeRaA02S02V03 = TotCasMeRaA02S02V03 / TotCasMeRaA00S00V00

label var TotCERMeRaA02S02V03 "Total Cases estim to reported Mean not smoothed IHME S2"


gen TotCERMeRaA02S03V03 = TotCasMeRaA02S03V03 / TotCasMeRaA00S00V00

label var TotCERMeRaA02S03V03 "Total Cases estim to reported Mean not smoothed IHME S3"



gen TotCERMeRaA03S01V07 = TotCasMeRaA03S01V07 / TotCasMeRaA00S00V00

label var TotCERMeRaA03S01V07 "Total Cases estim to reported Mean S1 IMPE"


gen TotCERMeRaA03S02V07 = TotCasMeRaA03S02V07 / TotCasMeRaA00S00V00

label var TotCERMeRaA03S02V07 "Total Cases estim to reported Mean S2 IMPE"


gen TotCERMeRaA03S03V07 = TotCasMeRaA03S03V07 / TotCasMeRaA00S00V00

label var TotCERMeRaA03S03V07 "Total Cases estim to reported Mean S3 IMPE"



gen TotCERMeRaA04S00V02 = TotCasMeRaA04S00V02 / TotCasMeRaA00S00V00

label var TotCERMeRaA04S00V02 "Total Cases estim to reported to Cases S0 LANL"



gen TotCERMeRaA05S00V02  = TotCasMeRaA05S00V02 / TotCasMeRaA00S00V00

label var TotCERMeRaA05S00V02 "Total Cases estim to reported S0 SRIV"




*

di in red "********* Description of vars in final combined file Iran.dta *********" 


desc, fullnames
 
 
*

sort date

qui compress

save "Iran.dta", replace

export delimited using "Iran.csv", replace 


*





***************

* graphs 


grstyle init

grstyle color background white



******************

** order of graphs: 

** (A) outcomes, (B) correction factors, (C) time coverage, (D) confidence intervals



** (A) outcomes: 

* daily deaths, daily cases, total deaths, total cases, daily CFR, daily active cases, 
* daily hospital-related outcomes, 
* daily cases to deaths, total cases to deaths,
* daily deaths estimated to reported, daily cases estimated to reported, total deaths estimated to reported, total cases estimated to reported



** (B) correction factors 2 and 5 (for deaths and cases) 

* with correction factors 2 and 5, without correction factors 2 and 5



** (C) time coverage

* all time, 2020-12-01 on



** (D) confidence intervals 

* without confidence intervals, with confidence intervals, not show extremes 




*****************

* daily deaths (graph numbers start with 11)


* daily deaths, median or reference scenario

twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeSmA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01feb2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(21935 21965 21994 22025 22056 22087 22118 22149 22180 ///
22210 22240 22270 22300 22330 22360 22391 22422 22453 22484 22515, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white)) ///
ttext(0 21jan2020  "Bah" 0 20feb2020  "Esf" 0 20mar2020  "Far" 0 20apr2020  "Ord" 0 21may2020  "Kho" ///
0 21jun2020  "Tir" 0 22jul2020  "Mor" 0 22aug2020  "Sha" 0 22sep2020  "Meh" ///
0 22oct2020  "Aba" 0 21nov2020  "Aza" 0 21dec2020  "Dey" 0 20jan2021  "Bah" ///
0 19feb2021  "Esf" 0 21mar2021  "Far" 0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir" 0 23jul2021  "Mor" 0 23Aug2021  "Sha", size(small) color(black) placement(south))

graph save "graph 11a COVID-19 daily deaths, Iran, reference scenarios.gph", replace
graph export "graph 11a COVID-19 daily deaths, Iran, reference scenarios.pdf", replace





* daily deaths, median or reference scenario, w CF

twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(thick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line DayDeaMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line DayDeaMeSmA02S01V03 date, sort lcolor(black)) /// 4 "IHME"
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 "IMPE"
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 6 "LANL"
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 7 "SRIV"
if date <= td(24Aug2021) ///
, xtitle(Date) xlabel(#20, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "IHME" 5 "IMPE" 6 "LANL" 7 "SRIV") size(small) row(1)) ///
subtitle("with correction factors 2 and 5", size(small))

graph save "graph 11b COVID-19 daily deaths, Iran, reference scenarios, w CF.gph", replace
graph export "graph 11b COVID-19 daily deaths, Iran, reference scenarios, w CF.pdf", replace




* daily deaths, median or reference scenario, 2020-12-01 on

twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeSmA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(20dec2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(22270 22300 22330 22360 22391 22422 22453 22484 22515, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("after 2020-12-01", size(small)) ///
ttext(0 21dec2020  "Dey" 0 20jan2021  "Bah" ///
0 19feb2021  "Esf" 0 21mar2021  "Far" 0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir" 0 23jul2021  "Mor"  0 23Aug2021  "Sha", size(small) color(black))

graph save "graph 12a COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on.gph", replace
graph export "graph 12a COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on.pdf", replace




* daily deaths, median or reference scenario, 2020-12-01 on, w CF

twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line DayDeaMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line DayDeaMeSmA02S01V03 date, sort lcolor(black)) /// 4 "IHME"
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 "IMPE"
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 6 "LANL"
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 7 "SRIV"
if date >= td(30nov2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#9, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "IHME" 5 "IMPE" 6 "LANL" 7 "SRIV") size(small) row(1)) ///
subtitle("after 2020-12-01, with correction factors 2 and 5", size(small))

graph save "graph 12b COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on, w CF.gph", replace
graph export "graph 12b COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on, w CF.pdf", replace




* daily deaths, median or reference scenario, 2020-12-01 on, CI

twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayDeaMeSmA02S02V03 date, sort lcolor(black)) /// 2 IHME mean
(line DayDeaLoSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 3 IHME lower
(line DayDeaUpSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 4 IHME upper
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 IMPE mean
(line DayDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 6 IMPE lower
(line DayDeaUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 7 IMPE upper
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 8 LANL mean
(line DayDeaLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 9 LANL lower
(line DayDeaUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 10 LANL upper
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 11 "SRIV" mean
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 12 "SRIV" lower
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 13 "SRIV" upper
if date >= td(30nov2020) & date <= td(23Aug2021)  ///
, xtitle(Date) xlabel(#9, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 5 "IMPE" 8 "LANL" 11 "SRIV") size(small) row(1)) ///
subtitle("after 2020-12-01, with uncertainty", size(small)) ///
note("Uncertainty limits: dashed curves") 

graph save "graph 13a COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on, CI.gph", replace
graph export "graph 13a COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on, CI.pdf", replace




* daily deaths, median or reference scenario, 2020-12-01 on, CI, w CF

twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayDeaMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line DayDeaMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line DayDeaMeSmA02S02V03 date, sort lcolor(black)) /// 4 IHME mean
(line DayDeaLoSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 5 IHME lower
(line DayDeaUpSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 6 IHME upper
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 7 IMPE mean
(line DayDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 8 IMPE lower
(line DayDeaUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE upper
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 10 LANL mean
(line DayDeaLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 11 LANL lower
(line DayDeaUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL upper
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 13 "SRIV" mean
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 14 "SRIV" lower
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" upper
if date >= td(30nov2020) & date <= td(23Aug2021)  ///
, xtitle(Date) xlabel(#9, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "IHME" 7 "IMPE" 10 "LANL" 13 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves") ///
subtitle("after 2020-12-01, with correction factors 2 and 5, with uncertainty", size(small))

graph save "graph 13b COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on, CI, w CF.gph", replace
graph export "graph 13b COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on, CI, w CF.pdf", replace




***********************

* Daily cases (graph numbers start with 21)


* daily cases, median or reference scenario

twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01feb2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(21935 21965 21994 22025 22056 22087 22118 22149 ///
22180 22210 22240 22270 22300 22330 22360 22391 22422 22453 22484 22515, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white)) ///
ttext(0 21jan2020  "Bah" 0 20feb2020  "Esf" 0 20mar2020  "Far" 0 20apr2020  "Ord" 0 21may2020  "Kho" ///
0 21jun2020  "Tir" 0 22jul2020  "Mor" 0 22aug2020  "Sha" 0 22sep2020  "Meh" ///
0 22oct2020  "Aba" 0 21nov2020  "Aza" 0 21dec2020  "Dey" 0 20jan2021  "Bah" ///
0 19feb2021  "Esf" 0 21mar2021  "Far" 0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir" 0 23jul2021  "Mor" 0 23Aug2021  "Sha", size(small) color(black) placement(south))

graph save "graph 21a COVID-19 daily cases, Iran, reference scenarios.gph", replace
graph export "graph 21a COVID-19 daily cases, Iran, reference scenarios.pdf", replace




* daily cases, median or reference scenario, w CF

twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line DayCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) /// 4 "IHME"
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 "IMPE"
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 6 "LANL"
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 7 "SRIV"
if date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "IHME" 5 "IMPE" 6 "LANL" 7 "SRIV" ) size(small) row(1)) ///
subtitle("with correction factors 2 and 5", size(small))

graph save "graph 21b COVID-19 daily cases, Iran, reference scenarios, w CF.gph", replace
graph export "graph 21b COVID-19 daily cases, Iran, reference scenarios, w CF.pdf", replace




* daily cases, median or reference scenario, 2020-12-01 on

twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01dec2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(22270 22300 22330 22360 22391 22422 22453 22484 22515, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV" ) size(small) row(1)) ///
subtitle("after 2020-12-01", size(small)) ///
ttext(0 21dec2020  "Dey" 0 20jan2021  "Bah" ///
0 19feb2021  "Esf" 0 21mar2021  "Far" 0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir" 0 23jul2021  "Mor" 0 23Aug2021  "Sha", size(small) color(black))

graph save "graph 22a COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on.gph", replace
graph export "graph 22a COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on.pdf", replace




* daily cases, median or reference scenario, 2020-12-01 on, w CF

twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line DayCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) /// 4 "IHME"
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 "IMPE"
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 6 "LANL"
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 7 "SRIV"
if date <= td(23Aug2021) & date >= td(30nov2020) ///
, xtitle(Date) xlabel(#8, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "IHME" 5 "IMPE" 6 "LANL" 7 "SRIV" ) size(small) row(1)) ///
subtitle("after 2020-12-01, with correction factors 2 and 5", size(small))

graph save "graph 22b COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on, w CF.gph", replace
graph export "graph 22b COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on, w CF.pdf", replace




* daily cases, median or reference scenario, 2020-12-01 on, CI

twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) /// 2 IHME mean
(line DayCasLoRaA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 3 IHME lower
(line DayCasUpRaA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 4 IHME upper
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 IMPE mean
(line DayCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 6 IMPE lower
(line DayCasUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 7 IMPE upper
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 8 LANL mean
(line DayCasLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 9 LANL lower
(line DayCasUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 10 LANL upper
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 11 "SRIV" mean
(line DayCasLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 12 "SRIV" lower
(line DayCasUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 13 "SRIV" upper
if date <= td(23Aug2021) & date >= td(30nov2020) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 5 "IMPE" 8 "LANL" 11 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves") ///
subtitle("after 2020-12-01, with uncertainty", size(small))

graph save "graph 23a COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on, CI.gph", replace
graph export "graph 23a COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on, CI.pdf", replace




* daily cases, median or reference scenario, 2020-12-01 on, CI, w CF

twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line DayCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) /// 4 IHME mean
(line DayCasLoRaA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 5 IHME lower
(line DayCasUpRaA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 6 IHME upper
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 7 IMPE mean
(line DayCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 8 IMPE lower
(line DayCasUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE upper
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 10 LANL mean
(line DayCasLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 11 LANL lower
(line DayCasUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL upper
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 13 "SRIV" mean
(line DayCasLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 14 "SRIV" lower
(line DayCasUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" upper
if date <= td(23Aug2021) & date >= td(30nov2020) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "IHME" 7 "IMPE" 10 "LANL" 13 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves") ///
subtitle("after 2020-12-01, with correction factors 2 and 5, with uncertainty", size(small))

graph save "graph 23b COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on, CI., w CF.gph", replace
graph export "graph 23b COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on, CI, w CF.pdf", replace




*****************

* total deaths (graph numbers start with 31)


* total deaths, median or reference scenario

twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotDeaMeSmA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 4 "LANL"
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(31dec2019) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 31a COVID-19 total deaths, Iran, reference scenarios.gph", replace
graph export "graph 31a COVID-19 total deaths, Iran, reference scenarios.pdf", replace




* total deaths, median or reference scenariom, w CF

twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotDeaMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line TotDeaMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line TotDeaMeSmA02S01V03 date, sort lcolor(black)) /// 4 "IHME"
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 "IMPE"
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 6 "LANL"
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 7 "SRIV"
if date >= td(31dec2019) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "IHME" 5 "IMPE" 6 "LANL" 7 "SRIV") size(small) row(1)) ///
subtitle("with correction factors 2 and 5", size(small))

graph save "graph 31b COVID-19 total deaths, Iran, reference scenarios, w CF.gph", replace
graph export "graph 31b COVID-19 total deaths, Iran, reference scenarios, w CF.pdf", replace




* total deaths, median or reference scenario, 2020-12-01 on

twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotDeaMeSmA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 4 "LANL"
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(30nov2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#9, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("after 2020-12-01", size(small))

graph save "graph 32a COVID-19 total deaths, Iran, reference scenarios, 2020-12-01 on.gph", replace
graph export "graph 32a COVID-19 total deaths, Iran, reference scenarios, 2020-12-01 on.pdf", replace




* total deaths, median or reference scenario, 2020-12-01 on, w CF

twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line TotCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line TotDeaMeSmA02S01V03 date, sort lcolor(black)) /// 4 "IHME"
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 "IMPE"
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 6 "LANL"
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 7 "SRIV"
if date >= td(30nov2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#9, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "IHME" 5 "IMPE" 6 "LANL" 7 "SRIV") size(small) row(1)) ///
subtitle("after 2020-12-01, with correction factors 2 and 5", size(small))

graph save "graph 32b COVID-19 total deaths, Iran, reference scenarios, 2020-12-01 on, w CF.gph", replace
graph export "graph 32b COVID-19 total deaths, Iran, reference scenarios, 2020-12-01 on, w CF.pdf", replace




* total deaths, median or reference scenario, 2020-12-01 on, CI

twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotDeaMeSmA02S02V03 date, sort lcolor(black)) /// 2 IHME mean
(line TotDeaLoSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 3 IHME lower
(line TotDeaUpSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 4 IHME upper
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 IMPE mean
(line TotDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 6 IMPE lower
(line TotDeaUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 7 IMPE upper
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 8 LANL mean
(line TotDeaLoRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 9 LANL lower
(line TotDeaUpRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 10 LANL upper
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 11 "SRIV" mean
(line TotDeaLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 12 "SRIV" lower
(line TotDeaUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 13 "SRIV" upper
if date >= td(30nov2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#9, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 5 "IMPE" 8 "LANL" 11 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves") ///
subtitle("after 2020-12-01, with uncertainty", size(small))

graph save "graph 34a COVID-19 total deaths, Iran, reference scenarios, 2020-12-01 on, CI.gph", replace
graph export "graph 34a COVID-19 total deaths, Iran, reference scenarios, 2020-12-01 on, CI.pdf", replace




* total deaths, median or reference scenario, 2020-12-01 on, CI, w CF

twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotDeaMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line TotDeaMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line TotDeaMeSmA02S02V03 date, sort lcolor(black)) /// 4 IHME mean
(line TotDeaLoSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 5 IHME lower
(line TotDeaUpSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 6 IHME upper
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 7 IMPE mean
(line TotDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 8 IMPE lower
(line TotDeaUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE upper
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 10 LANL mean
(line TotDeaLoRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 11 LANL lower
(line TotDeaUpRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL upper
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 13 "SRIV" mean
(line TotDeaLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 14 "SRIV" lower
(line TotDeaUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" upper
if date >= td(30nov2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#9, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "IHME" 7 "IMPE" 10 "LANL" 13 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves") ///
subtitle("after 2020-12-01, with correction factors 2 and 5, with uncertainty", size(small))

graph save "graph 34b COVID-19 total deaths, Iran, reference scenarios, 2020-12-01 on, CI, w CF.gph", replace
graph export "graph 34b COVID-19 total deaths, Iran, reference scenarios, 2020-12-01 on, CI, w CF.pdf", replace




*****************

* total cases (graph numbers start with 41)


* total cases, median or reference scenario

twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 4 "LANL"
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(31dec2019) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 41a COVID-19 total cases, Iran, reference scenarios.gph", replace
graph export "graph 41a COVID-19 total cases, Iran, reference scenarios.pdf", replace




* total cases, median or reference scenario, w CF

twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line TotCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 4 "IHME"
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 "IMPE"
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 6 "LANL"
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 7 "SRIV"
if date >= td(31dec2019) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "IHME" 5 "IMPE" 6 "LANL" 7 "SRIV") size(small) row(1)) ///
subtitle("with correction factors 2 and 5", size(small))

graph save "graph 41b COVID-19 total cases, Iran, reference scenarios, w CF.gph", replace
graph export "graph 41b COVID-19 total cases, Iran, reference scenarios, w CF.pdf", replace




* total cases, median or reference scenario, 2020-12-01 on

twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 4 "LANL"
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(30nov2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#9, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("after 2020-12-01", size(small))

graph save "graph 42a COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on.gph", replace
graph export "graph 42a COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on.pdf", replace




* total cases, median or reference scenario, 2020-12-01 on, w CF

twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line TotCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 4 "IHME"
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 "IMPE"
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 6 "LANL"
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 7 "SRIV"
if date >= td(30nov2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#9, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "IHME" 5 "IMPE" 6 "LANL" 7 "SRIV") size(small) row(1)) ///
subtitle("after 2020-12-01, with correction factors 2 and 5", size(small))

graph save "graph 42b COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on, w CF.gph", replace
graph export "graph 42b COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on, w CF.pdf", replace




* total cases, median or reference scenario, 2020-12-01 on, CI

twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 2 IHME mean
(line TotCasLoRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 3 IHME lower
(line TotCasUpRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 4 IHME upper
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 IMPE mean
(line TotCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 6 IMPE lower
(line TotCasUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 7 IMPE upper
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 8 LANL mean
(line TotCasLoRaA04S00V0 date, sort lcolor(gold)  lpattern(dash)) /// 9 LANL lower
(line TotCasUpRaA04S00V0 date, sort lcolor(gold)  lpattern(dash)) /// 10 LANL upper
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 11 "SRIV" mean
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 12 "SRIV" lower
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 13 "SRIV" upper
if date >= td(30nov2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#9, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 5 "IMPE" 8 "LANL" 11 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves") ///
subtitle("after 2020-12-01, with uncertainty", size(small))

graph save "graph 43a COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on, CI.gph", replace
graph export "graph 43a COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on, CI.pdf", replace




* total cases, median or reference scenario, 2020-12-01 on, CI, w CF

twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line TotCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 4 IHME mean
(line TotCasLoRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 5 IHME lower
(line TotCasUpRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 6 IHME upper
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 7 IMPE mean
(line TotCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 8 IMPE lower
(line TotCasUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE upper
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 10 LANL mean
(line TotCasLoRaA04S00V0 date, sort lcolor(gold)  lpattern(dash)) /// 11 LANL lower
(line TotCasUpRaA04S00V0 date, sort lcolor(gold)  lpattern(dash)) /// 12 LANL upper
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 13 "SRIV" mean
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 14 "SRIV" lower
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" upper
if date >= td(30nov2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#9, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "IHME" 7 "IMPE" 10 "LANL" 13 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves")  ///
subtitle("after 2020-12-01, with correction factors 2 and 5, with uncertainty", size(small))

graph save "graph 43b COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on, CI, w CF.gph", replace
graph export "graph 43b COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on, CI, w CF.pdf", replace




* total cases, median or reference scenario, 2020-12-01 on, CI, wo IMPE upper

* IMPE upper not shown (higher than others).

twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 2 IHME mean
(line TotCasLoRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 3 IHME lower
(line TotCasUpRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 4 IHME upper
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 IMPE mean
(line TotCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 6 IMPE lower
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 7 LANL mean
(line TotCasLoRaA04S00V0 date, sort lcolor(gold)  lpattern(dash)) /// 8 LANL lower
(line TotCasUpRaA04S00V0 date, sort lcolor(gold)  lpattern(dash)) /// 9 LANL upper
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 10 "SRIV" mean
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 11 "SRIV" lower
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 12 "SRIV" upper
if date >= td(30nov2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#9, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 5 "IMPE" 7 "LANL" 10 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves. IMPE upper not shown.") ///
subtitle("after 2020-12-01, with uncertainty", size(small))

graph save "graph 44a COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on, CI, wo IMPE upper.gph", replace
graph export "graph 44a COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on, CI, wo IMPE upper.pdf", replace




* total cases, median or reference scenario, 2020-12-01 on, CI, wo IMPE upper, w CF

* IMPE upper not shown (higher than others).

twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line TotCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 4 IHME mean
(line TotCasLoRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 5 IHME lower
(line TotCasUpRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 6 IHME upper
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 7 IMPE mean
(line TotCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 8 IMPE lower
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 9 LANL mean
(line TotCasLoRaA04S00V0 date, sort lcolor(gold)  lpattern(dash)) /// 10 LANL lower
(line TotCasUpRaA04S00V0 date, sort lcolor(gold)  lpattern(dash)) /// 11 LANL upper
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 12 "SRIV" mean
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 13 "SRIV" lower
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 14s "SRIV" upper
if date >= td(30nov2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#9, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "IHME" 7 "IMPE" 9 "LANL" 12 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves. IMPE upper not shown.")  ///
subtitle("after 2020-12-01, with correction factors 2 and 5, with uncertainty", size(small))

graph save "graph 44b COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on, CI, wo IMPE upper, w CF.gph", replace
graph export "graph 44b COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on, CI, wo IMPE upper, w CF.pdf", replace




*****************

* daily cfr (graph numbers start with 51)


* cfr all studies, all time, reference scenarios

twoway ///
(line DayCfrMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCfrMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line DayCfrMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayCfrMeRaA04S00V0 date, sort lcolor(gold)) /// 4 "LANL"
(line DayCfrMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(31dec2019) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 51 COVID-19 daily CFR, Iran, reference scenarios.gph", replace
graph export "graph 51 COVID-19 daily CFR, Iran, reference scenarios.pdf", replace




* cfr all studies, 01mar2020 on, reference scenarios

twoway ///
(line DayCfrMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCfrMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line DayCfrMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayCfrMeRaA04S00V0 date, sort lcolor(gold)) /// 4 "LANL"
(line DayCfrMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01mar2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("after 2020-03-01", size(small))

graph save "graph 52 COVID-19 daily CFR, Iran, reference scenarios, 2020-03-01 on.gph", replace
graph export "graph 52 COVID-19 daily CFR, Iran, reference scenarios, 2020-03-01 on.pdf", replace




* graph 53 placeholder (omitted in updates)




* cfr wo JOHN LANL SRIV, 01mar2020 on, reference scenarios

twoway ///
(line DayCfrMeRaA02S01V03 date, sort lcolor(black)) /// 1 "IHME"
(line DayCfrMeRaA03S02V07 date, sort lcolor(magenta)) /// 2 "IMPE"
(line DayCfrMeRaA05S00V02 date, sort lcolor(green)) /// 3 "SRIV"
if date >= td(01mar2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME" 2 "IMPE" 3 "SRIV") size(small) row(1)) ///
subtitle("after 2020-03-01, without JOHN, LANL", size(small)) 

graph save "graph 54 COVID-19 daily CFR, Iran, reference scenarios, 2020-03-01 on, wo JOHN LANL.gph", replace
graph export "graph 54 COVID-19 daily CFR, Iran, reference scenarios, 2020-03-01 on,wo JOHN LANL.pdf", replace




* cfr wo JOHN LANL, 01mar2020 on, reference scenarios, with CIs

twoway ///
(line DayCfrMeRaA02S01V03 date, sort lcolor(black)) /// 1 "IHME" mean
(line DayCfrLoRaA02S01V03 date, sort lcolor(black*.2) lpattern(dash)) /// 2 "IHME" lower
(line DayCfrUpRaA02S01V03 date, sort lcolor(black*.2) lpattern(dash)) /// 3 "IHME" upper
(line DayCfrMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE" mean
(line DayCfrLoRaA03S02V07 date, sort lcolor(magenta*.2) lpattern(dash)) /// 5 "IMPE" lower
(line DayCfrUpRaA03S02V07 date, sort lcolor(magenta*.2) lpattern(dash)) /// 6 "IMPE" upper
(line DayCfrMeRaA05S00V02 date, sort lcolor(green)) /// 7 "SRIV" mean
(line DayCfrMeRaA05S00V02 date, sort lcolor(green*.2) lpattern(dash)) /// 8 "SRIV" lower
(line DayCfrMeRaA05S00V02 date, sort lcolor(green*.2) lpattern(dash)) /// 9 "SRIV" upper
if date >= td(01mar2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME" 4 "IMPE" 7 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed light curves.") ///
subtitle("after 2020-03-01, without JOHN, LANL, with uncertainty", size(small))

graph save "graph 55 COVID-19 daily CFR, Iran, reference scenarios, 2020-03-01 on, wo JOHN LANL, with CIs.gph", replace
graph export "graph 55 COVID-19 daily CFR, Iran, reference scenarios, 2020-03-01 on,wo JOHN LANL, with CIs.pdf", replace




*****************

* daily active cases (graph numbers start with 61)


* daily active cases, w GHAN

twoway ///
(line DayActMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN" 
(line DayActMeRaA07S09V00 date, sort lcolor(black)) /// 2 "GHAN" 
(line DayActMeRaA06S01V00 date, sort lcolor(red) lpattern(dash)) /// 3 "SOLT S1"
(line DayActMeRaA06S02V00 date, sort lcolor(blue) lpattern(dash)) /// 4 "SOLT S2"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily active cases) title("COVID-19 daily active cases, Iran", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "GHAN" 3 "SOLT S1" 4 "SOLT S2") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 61 COVID-19 daily active cases w GHAN.gph", replace
graph export "graph 61 COVID-19 daily active cases w GHAN.pdf", replace




* daily active cases, wo GHAN

twoway ///
(line DayActMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN" 
(line DayActMeRaA06S01V00 date, sort lcolor(red) lpattern(dash)) /// 2 "SOLT S1"
(line DayActMeRaA06S02V00 date, sort lcolor(blue) lpattern(dash)) /// 3 "SOLT S2"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily active cases) title("COVID-19 daily active cases, Iran", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "SOLT S1" 3 "SOLT S2") size(small) row(1)) ///
subtitle("without GHAN", size(small))

graph save "graph 62 COVID-19 daily active cases wo GHAN.gph", replace
graph export "graph 62 COVID-19 daily active cases wo GHAN.pdf", replace




* daily active cases, wo GHAN, Hijri

twoway ///
(line DayActMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN" 
(line DayActMeRaA06S01V00 date, sort lcolor(red) lpattern(dash)) /// 2 "SOLT S1"
(line DayActMeRaA06S02V00 date, sort lcolor(blue) lpattern(dash)) /// 3 "SOLT S2"
if date >= td(20feb2020) & date <= td(23oct2021) ///
, xtitle(Date) xlabel(21965 21994 22025 22056 22087 22118 22149 22180 22210 22240 22270 22300 22330 22360 22391 22422 22453 22484 22515 22546 22576 ///
, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily active cases) title("COVID-19 daily active cases, Iran", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "SOLT S1" 3 "SOLT S2") size(small) row(1)) ///
subtitle("without GHAN", size(small)) ///
ttext(0 20feb2020  "Esf" 0 20mar2020  "Far" 0 20apr2020  "Ord" 0 21may2020  "Kho" 0 21jun2020  "Tir" 0 22jul2020  "Mor" ///
0 22aug2020  "Sha" 0 22sep2020  "Meh" 0 22oct2020  "Aba" 0 21nov2020  "Aza" 0 21dec2020  "Dey" 0 20jan2021  "Bah" ///
0 19feb2021  "Esf" 0 21mar2021  "Far" 0 21apr2021  "Ord" 0 22may2021  "Kho" 0 22jun2021  "Tir" 0 23jul2021  "Mor" ///
0 23aug2021  "Sha" 0 23sep2021  "Meh" 0 23oct2021  "Aba" , size(small) color(black) placement(south))

graph save "graph 62.1 COVID-19 daily active cases wo GHAN Hijri.gph", replace
graph export "graph 62.1 COVID-19 daily active cases wo GHAN Hijri.pdf", replace




* daily active cases, wo GHAN, 2020-12-01 on

twoway ///
(line DayActMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN" 
(line DayActMeRaA06S01V00 date, sort lcolor(red) lpattern(dash)) /// 2 "SOLT S1"
(line DayActMeRaA06S02V00 date, sort lcolor(blue) lpattern(dash)) /// 3 "SOLT S2"
if date >= td(30nov2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily active cases) title("COVID-19 daily active cases, Iran", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "SOLT S1" 3 "SOLT S2") size(small) row(1)) ///
subtitle("after 2020-12-01, without GHAN, ", size(small))

graph save "graph 63 COVID-19 daily active cases wo GHAN 2020-12-01 on.gph", replace
graph export "graph 63 COVID-19 daily active cases wo GHAN 2020-12-01 on.pdf", replace




************************

* other outcomes (graph numbers start with 71)


* base codes with IHME

* daily hospital-related outcomes, IHME, IMPE

twoway ///
(line DayBedMeSmA02S01V03 date, sort lcolor(black)) /// 1 IHME Bed need (Daily Beds needed Mean IHME S1)
(line DayIcuMeSmA02S01V03 date, sort lcolor(green)) /// 2 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayVenMeSmA02S01V03 date, sort lcolor(red)) /// 3 IHME Vent need (Daily invasive Ventilation needed Mean IHME S1)
(line DayAdmMeSmA02S01V03 date, sort lcolor(yellow)) /// 4 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayIcnMeSmA02S01V03 date, sort lcolor(blue)) /// 5 IHME ICU new (Daily new people going to ICU Mean IHME S1)
(line DayHodMeRaA03S01V07 date, sort lcolor(magenta)) /// 6 IMPE Hosp demand (Daily hospital demand Mean A03 S01 V07)
(line DayHoiMeRaA03S01V07 date, sort lcolor(magenta) lpattern(dash)) /// 7 IMPE Hosp incidence (Daily hospital incidence Mean A03 S01 V07)
(line DayIcdMeRaA03S01V07 date, sort lcolor(magenta) lpattern(dash_dot)) /// 8 IMPE ICU demand (Daily ICU demand Mean A03 S01 V07)
(line DayIciMeRaA03S01V07 date, sort lcolor(magenta) lpattern(longdash_shortdash)) /// 9 IMPE ICU incidence (Daily ICU incidence Mean A03 S01 V07)
if date >= td(30dec2019) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, median scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME Bed need" 2 "IHME ICU need" 3 "IHME Vent need" ///
4 "IHME Admissions" 5 "IHME ICU new" 6 "IMPE Hosp demand" ///
7 "IMPE Hosp incidence" 8 "IMPE ICU demand" 9 "IMPE ICU incidence") rows(4) size(small)) ///
subtitle("  .", size(small) color(white))

graph save "graph 71 COVID-19 hospital-related outcomes.gph", replace
graph export "graph 71 COVID-19 hospital-related outcomes.pdf", replace




* daily hospital-related outcomes, IHME, IMPE, wo extremes (IHME Bed need, IMPE Hosp demand)

twoway ///
(line DayIcuMeSmA02S01V03 date, sort lcolor(green)) /// 1 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayVenMeSmA02S01V03 date, sort lcolor(red)) /// 2 IHME Vent need (Daily invasive Ventilation needed Mean IHME S1)
(line DayAdmMeSmA02S01V03 date, sort lcolor(yellow)) /// 3 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayIcnMeSmA02S01V03 date, sort lcolor(blue)) /// 4 IHME ICU new (Daily new people going to ICU Mean IHME S1)
(line DayHoiMeRaA03S01V07 date, sort lcolor(magenta) lpattern(dash)) /// 5 IMPE Hosp incidence (Daily hospital incidence Mean A03 S01 V07)
(line DayIcdMeRaA03S01V07 date, sort lcolor(magenta) lpattern(dash_dot)) /// 6 IMPE ICU demand (Daily ICU demand Mean A03 S01 V07)
(line DayIciMeRaA03S01V07 date, sort lcolor(magenta) lpattern(longdash_shortdash)) /// 7 IMPE ICU incidence (Daily ICU incidence Mean A03 S01 V07)
if date >= td(30dec2019) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, median scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME ICU need" 2 "IHME Vent need" ///
3 "IHME Admissions" 4 "IHME ICU new" 5 "IMPE Hosp incidence" 6 "IMPE ICU demand" 7 "IMPE ICU incidence") rows(3) size(small)) ///
subtitle("without extremes (IHME Bed need, IMPE Hosp demand)", size(small))

graph save "graph 72 COVID-19 hospital-related outcomes, wo extremes.gph", replace
graph export "graph 72 COVID-19 hospital-related outcomes, wo extremes.pdf", replace




* daily hospital-related outcomes, IHME, IMPE, wo extremes (IHME Bed need, IMPE Hosp demand), 2020-12-01 on 

twoway ///
(line DayIcuMeSmA02S01V03 date, sort lcolor(green)) /// 1 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayVenMeSmA02S01V03 date, sort lcolor(red)) /// 2 IHME Vent need (Daily invasive Ventilation needed Mean IHME S1)
(line DayAdmMeSmA02S01V03 date, sort lcolor(yellow)) /// 3 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayIcnMeSmA02S01V03 date, sort lcolor(blue)) /// 4 IHME ICU new (Daily new people going to ICU Mean IHME S1)
(line DayHoiMeRaA03S01V07 date, sort lcolor(magenta) lpattern(dash)) /// 5 IMPE Hosp incidence (Daily hospital incidence Mean A03 S01 V07)
(line DayIcdMeRaA03S01V07 date, sort lcolor(magenta) lpattern(dash_dot)) /// 6 IMPE ICU demand (Daily ICU demand Mean A03 S01 V07)
(line DayIciMeRaA03S01V07 date, sort lcolor(magenta) lpattern(longdash_shortdash)) /// 7 IMPE ICU incidence (Daily ICU incidence Mean A03 S01 V07)
if date >= td(30nov2020) & date <= td(23Aug2021) ///
, xtitle(Date) xlabel(#8, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, median scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME ICU need" 2 "IHME Vent need" ///
3 "IHME Admissions" 4 "IHME ICU new" 5 "IMPE Hosp incidence" 6 "IMPE ICU demand" 7 "IMPE ICU incidence") rows(3) size(small)) ///
subtitle("after 2020-12-01, without extremes (IHME Bed need, IMPE Hosp demand)", size(small))

graph save "graph 73 COVID-19 hospital-related outcomes, wo extremes, 2020-12-01 on.gph", replace
graph export "graph 73 COVID-19 hospital-related outcomes, wo extremes, 2020-12-01 on.pdf", replace




*******************************

* daily cases to deaths (CTD) 


* Daily cases to deaths (CTD) all studies, all time, reference scenarios

twoway ///
(line DayCTDMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCTDMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line DayCTDMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayCTDMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayCTDMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(31dec2019) & date <= td(02aug2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases to deaths) title("COVID-19 daily cases to deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 81 COVID-19 daily cases to deaths, Iran, reference scenarios.gph", replace
graph export "graph 81 COVID-19 daily cases to deaths, Iran, reference scenarios.pdf", replace




* Daily cases to deaths (CTD) all studies, 2020-04-01 on, reference scenarios

twoway ///
(line DayCTDMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCTDMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line DayCTDMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayCTDMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayCTDMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(30mar2020) & date <= td(02aug2021) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases to deaths) title("COVID-19 daily cases to deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("after 2020-04-01", size(small))

graph save "graph 82 COVID-19 daily cases to deaths, Iran, reference scenarios, 2020-04-01 on.gph", replace
graph export "graph 82 COVID-19 daily cases to deaths, Iran, reference scenarios, 2020-04-01 on.pdf", replace




* Daily cases to deaths (CTD) all studies, 2020-04-01 on, 3 scenarios

twoway ///
(line DayCTDMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCTDMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME" S1
(line DayCTDMeRaA02S02V03 date, sort lcolor(black*.2) lpattern(dash)) /// 3 "IHME" S2
(line DayCTDMeRaA02S03V03 date, sort lcolor(black*.2) lpattern(dash)) /// 4 "IHME" S3
(line DayCTDMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 "IMPE" S2
(line DayCTDMeRaA03S01V07 date, sort lcolor(magenta*.2) lpattern(dash)) /// 6 "IMPE" S1
(line DayCTDMeRaA03S03V07 date, sort lcolor(magenta*.2) lpattern(dash)) /// 7 "IMPE" S3
(line DayCTDMeRaA04S00V02 date, sort lcolor(gold)) /// 8 "LANL"
(line DayCTDMeRaA05S00V02 date, sort lcolor(green)) /// 9 "SRIV"
if date >= td(30mar2020) & date <= td(02aug2021) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases to deaths) title("COVID-19 daily cases to deaths, Iran, 3 scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 5 "IMPE" 8 "LANL" 9 "SRIV") size(small) row(1)) ///
note("Current scenarios: solid curves. Best and worst scenarios: dashed curves") ///
subtitle("after 2020-04-01, 3 scenarios", size(small))

graph save "graph 83 COVID-19 daily cases to deaths, Iran, 3 scenarios, 2020-04-01 on.gph", replace
graph export "graph 83 COVID-19 daily cases to deaths, Iran, 3 scenarios, 2020-04-01 on.pdf", replace




* Total cases to deaths (CTD) all studies, all time, reference scenarios

twoway ///
(line TotCTDMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCTDMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line TotCTDMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line TotCTDMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line TotCTDMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(31dec2019) & date <= td(02aug2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases to deaths) title("COVID-19 total cases to deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 84 COVID-19 total cases to deaths, Iran, reference scenarios.gph", replace
graph export "graph 84 COVID-19 total cases to deaths, Iran, reference scenarios.pdf", replace




* Total cases to deaths (CTD) all studies, 2020-04-01 on, reference scenarios

twoway ///
(line TotCTDMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCTDMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line TotCTDMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line TotCTDMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line TotCTDMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(30mar2020) & date <= td(02aug2021) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases to deaths) title("COVID-19 total cases to deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("after 2020-04-01", size(small))

graph save "graph 85 COVID-19 total cases to deaths, Iran, reference scenarios, 2020-04-01 on.gph", replace
graph export "graph 85 COVID-19 total cases to deaths, Iran, reference scenarios, 2020-04-01 on.pdf", replace




*******************************

*  estimated to reported (graph numbers start with 91)


* daily deaths estimated to reported  


* daily deaths estimated to reported (DER) all studies, all time, reference scenarios

twoway ///
(line DayDERMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDERMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line DayDERMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayDERMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayDERMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#25, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths estimated to reported) title("COVID-19 daily deaths estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("(without DELPHI)", size(small))

graph save "graph 91 COVID-19 daily deaths estimated to reported, Iran, reference scenarios.gph", replace
graph export "graph 91 COVID-19 daily deaths estimated to reported, Iran, reference scenarios.pdf", replace




* daily cases estimated to reported  


* daily cases estimated to reported (CER) all studies, all time, reference scenarios

twoway ///
(line DayCERMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCERMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line DayCERMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayCERMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayCERMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#25, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases estimated to reported) title("COVID-19 daily cases estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("(without DELPHI)", size(small))

graph save "graph 93 COVID-19 daily cases estimated to reported, Iran, reference scenarios.gph", replace
graph export "graph 93 COVID-19 daily cases estimated to reported, Iran, reference scenarios.pdf", replace




* daily cases estimated to reported (CER) all studies, 2021-01-01 on, reference scenarios

twoway ///
(line DayCERMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCERMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line DayCERMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayCERMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayCERMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases estimated to reported) title("COVID-19 daily cases estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("after 2021-01-01, without DELPHI", size(small))

graph save "graph 93 COVID-19 daily cases estimated to reported, Iran, reference scenarios, 2021-01-01 on.gph", replace
graph export "graph 93 COVID-19 daily cases estimated to reported, Iran, reference scenarios, 2021-01-01 on.pdf", replace




* total deaths estimated to reported (DER) all studies, all time, reference scenarios

twoway ///
(line TotDERMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotDERMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line TotDERMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line TotDERMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line TotDERMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#25, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths estimated to reported) title("COVID-19 total deaths estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("(without DELPHI)", size(small))

graph save "graph 95 COVID-19 total deaths estimated to reported, Iran, reference scenarios.gph", replace
graph export "graph 95 COVID-19 total deaths estimated to reported, Iran, reference scenarios.pdf", replace




* total deaths estimated to reported (DER) all studies, 2021-01-01 on, reference scenarios

twoway ///
(line TotDERMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotDERMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line TotDERMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line TotDERMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line TotDERMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths estimated to reported) title("COVID-19 total deaths estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("after 2021-01-01, without DELPHI", size(small))

graph save "graph 96 COVID-19 total deaths estimated to reported, Iran, reference scenarios, 2021-01-01 on.gph", replace
graph export "graph 96 COVID-19 total deaths estimated to reported, Iran, reference scenarios, 2021-01-01 on.pdf", replace




* total cases estimated to reported (CER) all studies, all time, reference scenarios

twoway ///
(line TotCERMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCERMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line TotCERMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line TotCERMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line TotCERMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#25, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases estimated to reported) title("COVID-19 total cases estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("(without DELPHI)", size(small))

graph save "graph 97 COVID-19 total cases estimated to reported, Iran, reference scenarios.gph", replace
graph export "graph 97 COVID-19 total cases estimated to reported, Iran, reference scenarios.pdf", replace




* total cases estimated to reported (CER) all studies, 2021-01-01 on, reference scenarios

twoway ///
(line TotCERMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCERMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line TotCERMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line TotCERMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line TotCERMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases estimated to reported) title("COVID-19 total cases estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("after 2021-01-01, without DELPHI", size(small))

graph save "graph 98 COVID-19 total cases estimated to reported, Iran, reference scenarios, 2021-01-01 on.gph", replace
graph export "graph 98 COVID-19 total cases estimated to reported, Iran, reference scenarios, 2021-01-01 on.pdf", replace

***









************

* restore native scheme (of the local machine)

set scheme $nativescheme

di c(scheme)


view "log Iran merge.smcl"

log close

exit, clear




