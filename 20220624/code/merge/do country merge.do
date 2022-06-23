
clear all

cd "$pathcovir2"

cd merge

capture log close

log using "log country merge.smcl", replace


***************************************************************************
* This is "do country merge.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Merge component studies' estimates for country, graphs
***************************************************************************



/* 

List of component studies:

JOHN A00

DELP A01
IHME A02
IMPE A03
LANL A04 // The LANL COVID-19 Team made its last real-time forecast on September 27th, 2021. [for 20210926]. This is more than two weeks old and will not be used. 
SRIV A05 

*/


clear 

* JOHN

if regexm(c(os),"Mac") == 1 {

	use "$pathcovir2/JOHN/country JOHN.dta", clear 
}
else if regexm(c(os),"Windows") == 1 use "$pathcovir2\JOHN\country JOHN.dta", clear 



* DELP 

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/DELP/country DELP.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\DELP\country DELP.dta"

drop _merge



* IHME

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/IHME/country IHME.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\IHME\country IHME.dta"

drop _merge



/* IMPE

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/IMPE/country IMPE.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\IMPE\country IMPE.dta"

drop _merge
*/


/* LANL

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/LANL/country LANL.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\LANL\country LANL.dta"

drop _merge */


* SRIV

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/SRIV/country SRIV.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\SRIV\country SRIV.dta"

drop _merge 



* 

label var loc_grand_name "Location"







*************************************


* cases or infections to deaths ratio


gen DayCTDMeRaA00S00 =  DayCasMeRaA00 / DayDeaMeRaA00

label var DayCTDMeRaA00S00  "Daily Cases to Deaths S0 JOHN"

gen TotCTDMeRaA00S00 =  TotCasMeRaA00 / TotDeaMeRaA00

label var TotCTDMeRaA00S00  "Total Cases to Deaths S0 JOHN"




gen DayCTDMeRaA01S00 =  DayCasMeRaA01S00 / DayDeaMeRaA01S00

label var DayCTDMeRaA01S00  "Daily Cases to Deaths S0 DELP"

gen TotCTDMeRaA01S00 =  TotCasMeRaA01S00 / TotDeaMeRaA01S00

label var TotCTDMeRaA01S00  "Total Cases to Deaths S0 DELP"  





gen DayITDMeRaA02S01  =  DayINFMeSmA02S01  / DayDeaMeSmA02S01 

label var DayITDMeRaA02S01   "Daily Infections to Deaths S1 IHME"

gen TotITDMeRaA02S01  =  TotINFMeSmA02S01  / TotDeaMeSmA02S01 

label var TotITDMeRaA02S01   "Total Infections to Deaths S1 IHME"




gen DayITDMeRaA02S02 = DayINFMeSmA02S02 / DayDeaMeSmA02S02  

label var DayITDMeRaA02S02 "Daily Infections to Deaths S2 IHME"

gen TotITDMeRaA02S02 = TotINFMeSmA02S02 / TotDeaMeSmA02S02  

label var TotITDMeRaA02S02 "Total Infections to Deaths S2 IHME"






/*
gen DayITDMeRaA03S01  = DayINFMeRaA03S01  / DayDeaMeRaA03S01   

label var DayITDMeRaA03S01  "Daily Infections to Deaths S1 IMPE"

gen TotITDMeRaA03S01  = TotINFMeRaA03S01  / TotDeaMeRaA03S01   

label var TotITDMeRaA03S01  "Total Infections to Deaths S1 IMPE"



gen DayITDMeRaA03S02  = DayINFMeRaA03S02  / DayDeaMeRaA03S02   

label var DayITDMeRaA03S02  "Daily Infections to Deaths S2 IMPE"

gen TotITDMeRaA03S02  = TotINFMeRaA03S02  / TotDeaMeRaA03S02   

label var TotITDMeRaA03S02  "Total Infections to Deaths S2 IMPE"



gen DayITDMeRaA03S03  = DayINFMeRaA03S03  / DayDeaMeRaA03S03   

label var DayITDMeRaA03S03  "Daily Infections to Deaths S3 IMPE"

gen TotITDMeRaA03S03  = TotINFMeRaA03S03  / TotDeaMeRaA03S03   

label var TotITDMeRaA03S03  "Total Infections to Deaths S3 IMPE"
*/



gen DayCTDMeRaA05S00  = DayCasMeRaA05S00  / DayDeaMeRaA05S00   

label var DayCTDMeRaA05S00  "Daily Cases to Deaths S0 SRIV"

gen TotCTDMeRaA05S00  = TotCasMeRaA05S00  / TotDeaMeRaA05S00   

label var TotCTDMeRaA05S00  "Total Cases to Deaths S0 SRIV"






***********************

* daily deaths estimated to reported  

    
gen DayDERMeRaA00S00 = DayDeaMeRaA00 / DayDeaMeRaA00

label var DayDERMeRaA00S00 "Daily Deaths estim to reported JOHN = 1" 


gen DayDERMeRaA01S00 = DayDeaMeRaA01S00 / DayDeaMeRaA00

label var DayDERMeRaA01S00 "Daily Deaths estim to reported Mean DELP S0"




gen DayDERMeRaA02S01 = DayDeaMeSmA02S01 / DayDeaMeRaA00

label var DayDERMeRaA02S01 "Daily Deaths estim to reported Mean not smoothed IHME S1"


gen DayDERMeRaA02S02 = DayDeaMeSmA02S02 / DayDeaMeRaA00

label var DayDERMeRaA02S02 "Daily Deaths estim to reported Mean not smoothed IHME S2"



/*
gen DayDERMeRaA03S01 = DayDeaMeRaA03S01 / DayDeaMeRaA00

label var DayDERMeRaA03S01 "Daily Deaths estim to reported Mean S1 IMPE"


gen DayDERMeRaA03S02 = DayDeaMeRaA03S02 / DayDeaMeRaA00

label var DayDERMeRaA03S02 "Daily Deaths estim to reported Mean S2 IMPE"


gen DayDERMeRaA03S03 = DayDeaMeRaA03S03 / DayDeaMeRaA00

label var DayDERMeRaA03S03 "Daily Deaths estim to reported Mean S3 IMPE"
*/


gen DayDERMeRaA05S00  = DayDeaMeRaA05S00 / DayDeaMeRaA00

label var DayDERMeRaA05S00 "Daily Deaths estim to reported S0 SRIV"







* daily cases or infections estimated to reported  


gen DayCERMeRaA00S00 = DayCasMeRaA00 / DayCasMeRaA00

label var DayCERMeRaA00S00 "Daily Cases estim to reported JOHN = 1" 



gen DayCERMeRaA01S00 = DayCasMeRaA01S00 / DayCasMeRaA00

label var DayCERMeRaA01S00 "Daily Cases estim to reported Mean DELP S0"






gen DayIERMeRaA02S01 = DayINFMeSmA02S01 / DayCasMeRaA00

label var DayIERMeRaA02S01 "Daily Infections estim to reported Mean not smoothed IHME S1"


gen DayIERMeRaA02S02 = DayINFMeSmA02S02 / DayCasMeRaA00

label var DayIERMeRaA02S02 "Daily Infections estim to reported Mean not smoothed IHME S2"


/*
gen DayIERMeRaA03S01 = DayINFMeRaA03S01 / DayCasMeRaA00

label var DayIERMeRaA03S01 "Daily Infections estim to reported Mean S1 IMPE"


gen DayIERMeRaA03S02 = DayINFMeRaA03S02 / DayCasMeRaA00

label var DayIERMeRaA03S02 "Daily Infections estim to reported Mean S2 IMPE"


gen DayIERMeRaA03S03 = DayINFMeRaA03S03 / DayCasMeRaA00

label var DayIERMeRaA03S03 "Daily Infections estim to reported Mean S3 IMPE"
*/

gen DayCERMeRaA05S00  = DayCasMeRaA05S00 / DayCasMeRaA00

label var DayCERMeRaA05S00 "Daily Cases estim to reported S0 SRIV"







* Total deaths estimated to reported  


gen TotDERMeRaA00S00 = TotDeaMeRaA00 / TotDeaMeRaA00

label var TotDERMeRaA00S00 "Total Deaths estim to reported JOHN = 1" 



gen TotDERMeRaA01S00 = TotDeaMeRaA01S00 / TotDeaMeRaA00

label var TotDERMeRaA01S00 "Total Deaths estim to reported Mean DELP S0"



gen TotDERMeRaA02S01 = TotDeaMeSmA02S01 / TotDeaMeRaA00

label var TotDERMeRaA02S01 "Total Deaths estim to reported Mean not smoothed IHME S1"


gen TotDERMeRaA02S02 = TotDeaMeSmA02S02 / TotDeaMeRaA00

label var TotDERMeRaA02S02 "Total Deaths estim to reported Mean not smoothed IHME S2"



/*
gen TotDERMeRaA03S01 = TotDeaMeRaA03S01 / TotDeaMeRaA00

label var TotDERMeRaA03S01 "Total Deaths estim to reported Mean S1 IMPE"


gen TotDERMeRaA03S02 = TotDeaMeRaA03S02 / TotDeaMeRaA00

label var TotDERMeRaA03S02 "Total Deaths estim to reported Mean S2 IMPE"


gen TotDERMeRaA03S03 = TotDeaMeRaA03S03 / TotDeaMeRaA00

label var TotDERMeRaA03S03 "Total Deaths estim to reported Mean S3 IMPE"
*/

gen TotDERMeRaA05S00  = TotDeaMeRaA05S00 / TotDeaMeRaA00

label var TotDERMeRaA05S00 "Total Deaths estim to reported S0 SRIV"







* Total cases or infections estimated to reported  


gen TotCERMeRaA00S00 = TotCasMeRaA00 / TotCasMeRaA00

label var TotCERMeRaA00S00 "Total Cases estim to reported JOHN = 1" 


gen TotCERMeRaA01S00 = TotCasMeRaA01S00 / TotCasMeRaA00

label var TotCERMeRaA01S00 "Total Cases estim to reported Mean DELP S0"



gen TotIERMeRaA02S01 = TotINFMeSmA02S01 / TotCasMeRaA00

label var TotIERMeRaA02S01 "Total Infections estim to reported Mean not smoothed IHME S1"


gen TotIERMeRaA02S02 = TotINFMeSmA02S02 / TotCasMeRaA00

label var TotIERMeRaA02S02 "Total Infections estim to reported Mean not smoothed IHME S2"



/*
gen TotIERMeRaA03S01 = TotINFMeRaA03S01 / TotCasMeRaA00

label var TotIERMeRaA03S01 "Total Infections estim to reported Mean S1 IMPE"


gen TotIERMeRaA03S02 = TotINFMeRaA03S02 / TotCasMeRaA00

label var TotIERMeRaA03S02 "Total Infections estim to reported Mean S2 IMPE"


gen TotIERMeRaA03S03 = TotINFMeRaA03S03 / TotCasMeRaA00

label var TotIERMeRaA03S03 "Total Infections estim to reported Mean S3 IMPE"
*/


gen TotCERMeRaA05S00  = TotCasMeRaA05S00 / TotCasMeRaA00

label var TotCERMeRaA05S00 "Total Cases estim to reported S0 SRIV"








*

di in red "********* Description of vars in final combined file country.dta *********" 


desc, fullnames
 
 
*

sort date

qui compress

save "country.dta", replace

export delimited using "country.csv", replace 


*





***************

* graphs 


grstyle init

grstyle color background white







**********

* gen monthspast vars for #thicknumber of graphs


summ date

gen mergemaxdate = r(max)


gen monthspast01jan2020merge = ((mergemaxdate - td(01jan2020)) / 30)

replace monthspast01jan2020merge = round(monthspast01jan2020merge)

global monthspast01jan2020merge = monthspast01jan2020merge

di $monthspast01jan2020merge



gen monthspast01jan2021merge = ((mergemaxdate - td(01jan2021)) / 30)

replace monthspast01jan2021merge = round(monthspast01jan2021merge)

global monthspast01jan2021merge = monthspast01jan2021merge

di $monthspast01jan2021merge



gen monthspast01jan2022merge = ((mergemaxdate - td(01jan2022)) / 30)

replace monthspast01jan2022merge = round(monthspast01jan2022merge)

global monthspast01jan2022merge = monthspast01jan2022merge

di $monthspast01jan2022merge






* gen monthspast vars for #thicknumber of graphs JOHN

gen monthspast01jan2020JOHN = ((today_numericdailydate - td(01jan2020)) / 30) + 1

replace monthspast01jan2020JOHN = round(monthspast01jan2020)

global monthspast01jan2020JOHN = monthspast01jan2020JOHN

di $monthspast01jan2020JOHN



gen monthspast01jan2021JOHN = ((today_numericdailydate - td(01jan2021)) / 30) + 1

replace monthspast01jan2021JOHN = round(monthspast01jan2021)

global monthspast01jan2021JOHN = monthspast01jan2021JOHN

di $monthspast01jan2021JOHN



gen monthspast01jan2022JOHN = ((today_numericdailydate - td(01jan2022)) / 30) + 1

replace monthspast01jan2022JOHN = round(monthspast01jan2022JOHN)

global monthspast01jan2022JOHN = monthspast01jan2022JOHN

di $monthspast01jan2022JOHN



* end date of graphs JOHN

gen nextmonthspast01jan2020JOHN = monthspast01jan2020JOHN 

gen nextmonthdayspast01jan2020JOHN = nextmonthspast01jan2020JOHN * 30

gen nextmonthdatespast01jan2020JOHN = td(01jan2020) + nextmonthdayspast01jan2020JOHN

local nextmonthdatespast01jan2020JOHN = nextmonthdatespast01jan2020JOHN



gen nextmonthspast01jan2022JOHN = monthspast01jan2022JOHN 

gen nextmonthdayspast01jan2022JOHN = nextmonthspast01jan2022JOHN * 30

gen nextmonthdatespast01jan2022JOHN = td(01jan2022) + nextmonthdayspast01jan2022JOHN

local nextmonthdatespast01jan2022JOHN = nextmonthdatespast01jan2022JOHN







****************************

* daily deaths, JOHN, 2020 on

twoway ///
(line DayDeaMeRaA00 date, sort lcolor(black) lwidth(medium)) /// 1 "JOHN raw"
(line DayDeaMeSmA00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
if date >= td(01jan2020) & date <= `nextmonthdatespast01jan2020JOHN' ///
, xtitle(Date) xlabel(#$monthspast01jan2020JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, $country, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Raw deaths" 2 "Smooth deaths") size(small) row(1)) 

graph export "graph 1 COVID-19 daily deaths, $country, Johns Hopkins.pdf", replace



****************************

* daily cases, JOHN, 2020 on

twoway ///
(line DayCasMeRaA00 date, sort lcolor(black) lwidth(medium)) /// 1 "JOHN raw"
(line DayCasMeSmA00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
if date >= td(01jan2020) & date <= `nextmonthdatespast01jan2020JOHN' ///
, xtitle(Date) xlabel(#$monthspast01jan2020JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported cases) title("COVID-19 daily reported cases, $country, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Raw cases" 2 "Smooth cases") size(small) row(1)) ///


graph export "graph 2 COVID-19 daily cases, $country, Johns Hopkins.pdf", replace






****************************

* daily deaths, JOHN, 2022 on

twoway ///
(line DayDeaMeRaA00 date, sort lcolor(black) lwidth(medium)) /// 1 "JOHN raw"
(line DayDeaMeSmA00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
if date >= td(01jan2022) & date <= `nextmonthdatespast01jan2022JOHN' ///
, xtitle(Date) xlabel(#$monthspast01jan2022JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, $country, Johns Hopkins, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Raw deaths" 2 "Smooth deaths") size(small) row(1)) 

graph export "graph 3 COVID-19 daily deaths, $country, Johns Hopkins, 2022 on.pdf", replace



****************************

* daily cases, JOHN, 2022 on

twoway ///
(line DayCasMeRaA00 date, sort lcolor(black) lwidth(medium)) /// 1 "JOHN raw"
(line DayCasMeSmA00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
if date >= td(01jan2022) & date <= `nextmonthdatespast01jan2022JOHN' ///
, xtitle(Date) xlabel(#$monthspast01jan2022JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported cases) title("COVID-19 daily reported cases, $country, Johns Hopkins, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Raw cases" 2 "Smooth cases") size(small) row(1)) 

graph export "graph 4 COVID-19 daily cases, $country, Johns Hopkins, 2022 on.pdf", replace







******************



* daily deaths (graph numbers start with 11)


****
* daily deaths, reference scenario, all time

twoway ///
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN smooth"
(line DayDeaFOREA01S00 date, sort lcolor(red) lpattern(tight_dot) lwidth(vthick)) /// 2 "DELP" Forecast only
(line DayDeaMeSmA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayDeaFOREA02S01 date, sort lcolor(black) lpattern(tight_dot) lwidth(vthick)) /// 4 "IHME" Forecast only
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 5 "IHME"
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lpattern(dash)) /// 6 "IHME" Excess
(line DayDeaFOREA05S00 date, sort lcolor(green) lpattern(tight_dot) lwidth(vthick)) /// 7 "SRIV" Forecast only
(line DayDeaMeSmA05S00 date, sort lcolor(green)) /// 8 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 3 "DELP" 5 "IHME" 6 "IHME excess" 8 "SRIV") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) 

graph export "graph 11 COVID-19 daily deaths, $country, reference scenarios, all time.pdf", replace



****
* daily deaths, reference scenario, 2021

twoway ///
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN smooth"
(line DayDeaFOREA01S00 date, sort lcolor(red) lpattern(tight_dot) lwidth(vthick)) /// 2 "DELP" Forecast only
(line DayDeaMeSmA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayDeaFOREA02S01 date, sort lcolor(black) lpattern(tight_dot) lwidth(vthick)) /// 4 "IHME" Forecast only
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 5 "IHME"
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lpattern(dash)) /// 6 "IHME" Excess
(line DayDeaFOREA05S00 date, sort lcolor(green) lpattern(tight_dot) lwidth(vthick)) /// 7 "SRIV" Forecast only
(line DayDeaMeSmA05S00 date, sort lcolor(green)) /// 8 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 3 "DELP" 5 "IHME" 6 "IHME excess" 8 "SRIV") size(small) rows(1)) ///
subtitle("2021 on, reference scenarios", size(small)) ///
note("Reference scenario forecasts are marked with |||||||||||| " , size(small))  

graph export "graph 12 COVID-19 daily deaths, $country, reference scenarios.pdf", replace




****
* daily deaths, reference scenario, 2021, CI

twoway ///
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN smooth"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayDeaLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayDeaUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" upper
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line DayDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line DayDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 8 SRIV mean
(line DayDeaLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 9 SRIV lower
(line DayDeaUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 10 SRIV upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid)  ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "SRIV") size(small) row(1)) ///
subtitle("2021 on, reference scenarios with uncertainty", size(small)) ///
note("Uncertainty limits: dashed curves", size(small))

graph export "graph 13 COVID-19 daily deaths, $country, reference scenarios, CI.pdf", replace




****
* daily deaths, reference scenario with uncertainty, IHME, 2021 

twoway ///
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN smooth"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 2 IHME reference mean
(line DayDeaLoSmA02S01 date, sort lcolor(green) lpattern(dash)) /// 3 IHME reference lower
(line DayDeaUpSmA02S01 date, sort lcolor(red) lpattern(dash)) /// 4 IHME reference upper
(line DayDeXLoSmA02S01 date, sort lcolor(green) lpattern(dash_dot)) /// 5 "IHME excess lower"
(line DayDeXUpSmA02S01 date, sort lcolor(red) lpattern(dash_dot)) /// 6 "IHME excess upper"
(line DayDeXMeSmA02S01 date, sort lcolor(black) lpattern(dash_dot) lwidth(medthick)) /// 7 "IHME excess mean"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME reference scenario, mean" ///
3 "IHME reference scenario, lower" 4 "IHME reference scenario, upper" 5 "IHME excess lower" ///
6 "IHME excess upper" 7 "IHME excess mean") size(small) row(4)) ///
subtitle("2021 on, reference scenario with uncertainty", size(small)) ///
note("Uncertainty limits: dashed (– – –) curves", size(small)) 

graph export "graph 14 COVID-19 daily deaths, $country, reference scenario with uncertainty, IHME.pdf", replace



****
* daily deaths, all scenarios, IHME, 2021

twoway ///
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// 1
(line DayDeaFOREA02S01 date, sort lcolor(black*0.6) lpattern(tight_dot) lwidth(vthick)) /// 2 "IHME" Forecast only
(line DayDeaMeSmA02S01 date, sort lcolor(black) lwidth(medthick)) /// 3 "IHME" 
(line DayDeaMeSmA02S02 date, sort lcolor(blue)) /// 4
(line DayDeaMeSmA02S03 date, sort lcolor(green)) /// 5
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, $country, IHME, all scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 3 "IHME Reference" 4 "IHME Masks" 5 "IHME Antivirals") size(small) rows(1)) ///
note("Reference scenario forecasts are marked with |||||||||||| " , size(small))

graph export "graph 15 COVID-19 daily deaths, $country, all scenarios, IHME.pdf", replace


/*
****
* daily deaths, reference scenario with uncertainty, IMPE, 2021

twoway ///
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN smooth"
(line DayDeaFOREA03S02 date, sort lcolor(black*0.6) lpattern(tight_dot) lwidth(vthick)) /// 2 "IMPE" Forecast only
(line DayDeaMeSmA03S02 date, sort lcolor(black)) /// 3 IMPE reference mean
(line DayDeaLoSmA03S02 date, sort lcolor(green) lpattern(dash)) /// 4 IMPE reference lower
(line DayDeaUpSmA03S02 date, sort lcolor(red) lpattern(dash)) /// 5 IMPE reference upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN smooth" 3 "IMPE reference scenario, mean" ///
4 "IMPE reference scenario, lower" 5 "IMPE reference scenario, upper") size(small) row(3)) ///
subtitle("2021 on, reference scenario with uncertainty", size(small)) ///
note("Reference scenario forecasts are marked with |||||||||||| " , size(small))

graph export "graph 16 COVID-19 daily deaths, $country, reference scenario with uncertainty, IMPE.pdf", replace



****
* daily deaths, 3 scenarios, IMPE, 2021

twoway ///
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN smooth"
(line DayDeaMeSmA03S02 date, sort lcolor(black)) /// 2 IMPE reference mean
(line DayDeaMeSmA03S01 date, sort lcolor(green) lwidth(thick) lpattern(tight_dot)) /// 3 IMPE better mean
(line DayDeaMeSmA03S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 4 IMPE worse mean
(line DayDeaUpSmA03S03 date, sort lcolor(red) lpattern(dash)) /// 5 IMPE worse upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IMPE reference scenario, mean" 3 "IMPE better scenario, mean" ///
4 "IMPE worse scenario, mean" 5 "IMPE worse scenario, upper uncertainty limit") size(small) row(3)) ///
subtitle("2021 on, 3 scenarios", size(small)) ///
note("Better and worse scenarios: tight dot (|||||) curves; Uncertainty limits: dashed (– – –) curves.")

graph export "graph 17 COVID-19 daily deaths, $country, 3 scenarios, IMPE.pdf", replace
*/



****
* daily deaths, reference scenario, 2022 on

twoway ///
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN smooth"
(line DayDeaFOREA01S00 date, sort lcolor(red) lpattern(tight_dot) lwidth(vthick)) /// 2 "DELP" Forecast only
(line DayDeaMeSmA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayDeaFOREA02S01 date, sort lcolor(black) lpattern(tight_dot) lwidth(vthick)) /// 4 "IHME" Forecast only
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 5 "IHME"
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lpattern(dash)) /// 6 "IHME"
(line DayDeaFOREA05S00 date, sort lcolor(green) lpattern(tight_dot) lwidth(vthick)) /// 7 "SRIV" Forecast only
(line DayDeaMeSmA05S00 date, sort lcolor(green)) /// 8 "SRIV"
if date >= td(01jan2022) ///
, xtitle(Date) xlabel(#$monthspast01jan2022merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 3 "DELP" 5 "IHME" 6 "IHME excess" 8 "SRIV") size(small) rows(1)) ///
subtitle("reference scenarios, 2022 on", size(small)) ///
note("Reference scenario forecasts are marked with |||||||||||| " , size(small))  

graph export "graph 18 COVID-19 daily deaths, $country, reference scenarios, 2022 on.pdf", replace



***********************

* daily cases or infections (graph numbers start with 21)

twoway ///
(line DayCasMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN"
(line DayCasFOREA01S00 date, sort lcolor(red) lpattern(tight_dot) lwidth(vthick)) /// 2 "DELP" Forecast only
(line DayCasMeSmA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayINFFOREA02S01 date, sort lcolor(black) lpattern(tight_dot) lwidth(vthick)) /// 4 "IHME" Forecast only
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 5 "IHME"
(line DayCasFOREA05S00 date, sort lcolor(green) lpattern(tight_dot) lwidth(vthick)) /// 6 "SRIV" Forecast only
(line DayCasMeSmA05S00 date, sort lcolor(green)) /// 7 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid)  ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 3 "DELP cases" 5 "IHME infections" 7 "SRIV cases") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) ///
note("Reference scenario forecasts are marked with |||||||||||| " , size(small))

graph export "graph 21 COVID-19 daily cases, $country, reference scenarios, all time.pdf", replace




****
* daily cases or infections, reference scenario, 2021

twoway ///
(line DayCasMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN"
(line DayCasFOREA01S00 date, sort lcolor(red) lpattern(tight_dot) lwidth(vthick)) /// 2 "DELP" Forecast only
(line DayCasMeSmA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayINFFOREA02S01 date, sort lcolor(black) lpattern(tight_dot) lwidth(vthick)) /// 4 "IHME" Forecast only
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 5 "IHME"
(line DayCasFOREA05S00 date, sort lcolor(green) lpattern(tight_dot) lwidth(vthick)) /// 6 "SRIV" Forecast only
(line DayCasMeSmA05S00 date, sort lcolor(green)) /// 7 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid)  ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 3 "DELP cases" 5 "IHME infections" 7 "SRIV cases") size(small) row(2)) ///
subtitle("2021 on, reference scenarios", size(small)) ///
note("Reference scenario forecasts are marked with |||||||||||| " , size(small))

graph export "graph 22 COVID-19 daily cases, $country, reference scenarios.pdf", replace



****
* daily cases, reference scenario, 2021

twoway ///
(line DayCasMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN"
(line DayCasFOREA01S00 date, sort lcolor(red) lpattern(tight_dot) lwidth(vthick)) /// 2 "DELP" Forecast only
(line DayCasMeSmA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayCasFOREA05S00 date, sort lcolor(green) lpattern(tight_dot) lwidth(vthick)) /// 4 "SRIV" Forecast only
(line DayCasMeSmA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 3 "DELP cases" 5 "SRIV cases") size(small) row(1)) ///
subtitle("2021 on, reference scenarios", size(small)) 

graph export "graph 22b COVID-19 daily cases, $country, reference scenarios.pdf", replace






****
* daily cases, reference scenario, 2022

twoway ///
(line DayCasMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN"
(line DayCasFOREA01S00 date, sort lcolor(red) lpattern(tight_dot) lwidth(vthick)) /// 2 "DELP" Forecast only
(line DayCasMeSmA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayCasFOREA05S00 date, sort lcolor(green) lpattern(tight_dot) lwidth(vthick)) /// 4 "SRIV" Forecast only
(line DayCasMeSmA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2022) ///
, xtitle(Date) xlabel(#$monthspast01jan2022merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 3 "DELP cases" 5 "SRIV cases") size(small) row(1)) ///
subtitle("2022 on, reference scenarios", size(small)) 

graph export "graph 22b2 COVID-19 daily cases, $country, reference scenarios.pdf", replace






****
* daily cases or infections, reference scenarios, 2021, CI

twoway ///
(line DayCasMeRaA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 JOHN
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" upper
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line DayINFLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line DayINFUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 8 SRIV mean
(line DayCasLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 9 SRIV lower
(line DayCasUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 10 SRIV upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 5 "IHME infections" ///
8 "SRIV cases") size(small) row(2)) /// 
subtitle("2021 on, reference scenarios with uncertainty", size(small)) ///

graph export "graph 23 COVID-19 daily cases, $country, reference scenarios, CI.pdf", replace



****
* daily cases or infections, full scenarios, with uncertainty, 2021

twoway ///
(line DayCasMeRaA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 JOHN
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" upper
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 5 IHME reference mean
(line DayINFLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME reference lower
(line DayINFUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME reference upper
(line DayINFMeSmA02S02 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 8 IHME better mean
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 9 SRIV mean
(line DayCasLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 10 SRIV lower
(line DayCasUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 11 SRIV upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 5 "IHME reference, mean" 6 "IHME ref, uncertainty" 8 "IHME better" ///
9 "SRIV ref, mean") size(small) row(4)) ///
subtitle("2021 on, full scenarios, with uncertainty; IHME: infections", size(small))

graph export "graph 23 COVID-19 daily cases, $country, full scenarios, CI.pdf", replace



****
* daily infections, reference scenario with uncertainty, IHME, 2021

twoway ///
(line DayCasMeRaA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 JOHN
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 2 IHME reference mean
(line DayINFLoSmA02S01 date, sort lcolor(green) lpattern(dash)) /// 3 IHME reference lower
(line DayINFUpSmA02S01 date, sort lcolor(red) lpattern(dash)) /// 4 IHME reference upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases JOHN, and infections IHME, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "IHME reference, mean" 3 "IHME reference, lower" 4 "IHME reference, upper") size(small) row(2)) ///
subtitle("2021 on, IHME infections reference scenario with uncertainty", size(small)) ///
note("Uncertainty limits: dashed (– – –) curves", size(small))

graph export "graph 24 COVID-19 daily cases, $country, reference scenario with uncertainty, IHME.pdf", replace




****
* daily infections, all scenarios, IHME, 2021

twoway ///
(line DayINFMeSmA02S01 date, sort lcolor(black) lwidth(medthick)) ///
(line DayINFMeSmA02S02 date, sort lcolor(blue)) ///
(line DayINFMeSmA02S03 date, sort lcolor(green)) /// 
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections) title("COVID-19 daily infections, $country, IHME, all scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Reference" 2 "Masks" 3 "Antivirals") size(small) rows(1))

graph export "graph 25 1 COVID-19 daily cases, $country, all scenarios, IHME.pdf", replace


/*
****
* daily infections, reference scenario with uncertainty, IMPE, 2021

twoway ///
(line DayCasMeRaA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 JOHN
(line DayINFMeRaA03S02 date, sort lcolor(black)) /// 2 IMPE reference mean
(line DayINFLoSmA03S02 date, sort lcolor(green) lpattern(dash)) /// 3 IMPE reference lower
(line DayINFUpSmA03S02 date, sort lcolor(red) lpattern(dash)) /// 4 IMPE reference upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases JOHN, and infections IMPE, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "IMPE reference, mean" 3 "IMPE reference, lower" 4 "IMPE reference, upper") size(small) row(2)) ///
subtitle("2021 on, IMPE infections reference scenario with uncertainty", size(small))  ///
note("Uncertainty limits: dashed (– – –) curves", size(small))

graph export "graph 26 COVID-19 daily cases, $country, reference scenario with uncertainty, IMPE.pdf", replace



****
* daily infections, 2 scenarios, IMPE 

twoway ///
(line DayCasMeRaA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 JOHN
(line DayINFMeRaA03S02 date, sort lcolor(black)) /// 2 IMPE reference mean
(line DayINFMeRaA03S01 date, sort lcolor(green) lwidth(thick) lpattern(tight_dot)) /// 3 IMPE better mean
(line DayINFMeRaA03S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 4 IMPE worse mean
(line DayINFUpSmA03S03 date, sort lcolor(red) lpattern(dash)) /// 5 IMPE worse upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily JOHN, and infections IMPE, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "IMPE reference, mean" 3 "IMPE better, mean" 4 "IMPE worse, mean" ///
5 "IMPE worse scenario, upper uncertainty limit") size(small) row(3)) ///
subtitle("2021 on, 2 scenarios", size(small)) ///
note("Better and worse scenarios: tight dot (|||||) curves; Uncertainty limits: dashed (– – –) curves", size(small))

graph export "graph 27 COVID-19 daily cases, $country, 2 scenarios, IMPE.pdf", replace
*/



****
* daily estimated infections to reported cases IHME, all time


gen DayITCMeSmA02S01 =  DayINFMeSmA02S01 / DayCasMeRaA00

label var DayITCMeSmA02S01  "Daily Infections IHME to cases JOHN"

/*
gen DayITCMeRaA03S02 =  DayINFMeRaA03S02 / DayCasMeRaA00

label var DayITCMeRaA03S02  "Daily Infections IMPE to cases JOHN"
*/

twoway ///
(line DayITCMeSmA02S01 date, sort lcolor(black)) /// 1 "IHME"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily estimated infections to reported cases) title("COVID-19 daily estimated infections to reported cases, $country, IHME", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("reference scenarios", size(small)) 

graph export "graph 28 C19 daily estimated infections to reported cases, $country, reference scenarios.pdf", replace




****
* daily estimated infections to reported cases IHME, 2021


* smooth Infections to cases ratio of IHME and IMPE

tsset date, daily   


foreach var of varlist ///
DayITCMeSmA02S01 {

// DayITCMeRaA03S02

tssmooth ma `var'_window = `var', window(3 1 3)

tssmooth ma `var'sm = `var'_window, weights( 1 2 3 <4> 3 2 1) replace

drop `var'_window

}
*

tsset, clear

ssc install labutil2

// labvars DayITCMeSmA02S01sm DayITCMeRaA03S02sm ,names

          
qui summ DayITCMeSmA02S01sm if date >= td(01jan2021) , detail

gen DayITCMeSmA02S01sm_median = r(p50)

replace DayITCMeSmA02S01sm_median = round(DayITCMeSmA02S01sm_median)

local DayITCMeSmA02S01sm_median = DayITCMeSmA02S01sm_median

/*
qui summ DayITCMeRaA03S02sm if date >= td(01jan2021) , detail

gen DayITCMeRaA03S02sm_median = r(p50)

replace DayITCMeRaA03S02sm_median = round(DayITCMeRaA03S02sm_median)

local DayITCMeRaA03S02sm_median = DayITCMeRaA03S02sm_median
*/

twoway ///
(line DayITCMeSmA02S01 date, sort lcolor(black*0.2)) /// 1 "IHME"
(line DayITCMeSmA02S01sm date, sort lcolor(black) lwidth(thick)) /// 2 "IHME"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily estimated infections to reported cases) title("COVID-19 daily estimated infections to reported cases, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME" 2 "IHME smooth") size(small) row(1)) ///
subtitle("reference scenarios", size(small)) ///
note("IHME smooth median 2021 on = `DayITCMeSmA02S01sm_median'")

graph export "graph 29 C19 daily estimated infections to reported cases, $country, reference scenarios 2021.pdf", replace






*****************

* total deaths (graph numbers start with 31)


****
* total deaths, reference scenario, all time

twoway ///
(line TotDeaMeRaA00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small)) 

graph export "graph 31a COVID-19 total deaths, $country, reference scenarios, all time.pdf", replace



****
* total deaths, reference scenario, all time, with IHME excess mortality 

twoway ///
(line TotDeaMeRaA00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeXMeSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 4 "IHME excess"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IHME excess" 5 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small)) 

graph export "graph 31b COVID-19 total deaths, $country, reference scenarios, all time.pdf", replace



****
* total deaths, reference scenario, 2021

twoway ///
(line TotDeaMeRaA00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "SRIV") size(small) row(1)) ///
subtitle("2021 on, reference scenarios", size(small)) 

graph export "graph 32a COVID-19 total deaths, $country, reference scenarios.pdf", replace



****
* total deaths, reference scenario, 2021, with IHME excess mortality 

twoway ///
(line TotDeaMeRaA00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeXMeSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 4 "IHME excess"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IHME excess" 5 "SRIV") size(small) row(1)) ///
subtitle("2021 on, reference scenarios", size(small)) 

graph export "graph 32b COVID-19 total deaths, $country, reference scenarios.pdf", replace



****
* total deaths, reference scenario, CI, 2021

twoway ///
(line TotDeaMeRaA00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 JOHN
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 DELP mean
(line TotDeaLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 DELP lower
(line TotDeaUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 DELP upper
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line TotDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 8 SRIV mean
(line TotDeaLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 9 SRIV lower
(line TotDeaUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 10 SRIV upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves") ///
subtitle("2021 on, reference scenarios with uncertainty", size(small)) 

graph export "graph 33 COVID-19 total deaths, $country, reference scenarios, CI.pdf", replace




*****************

* total cases or infections (graph numbers start with 41)


****
* total cases or infections, reference scenario, all time

twoway ///
(line TotCasMeRaA00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotINFMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" ///
4 "SRIV cases") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) 

graph export "graph 41 COVID-19 total cases, $country, reference scenarios, all time.pdf", replace



****
* total cases or infections, reference scenario, 2021

twoway ///
(line TotCasMeRaA00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotINFMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" ///
4 "SRIV cases") size(small) row(1)) ///
subtitle("2021 on, reference scenarios", size(small)) 

graph export "graph 42 COVID-19 total cases, $country, reference scenarios.pdf", replace



****
* total cases or infections, reference scenario, CI, 2021

twoway ///
(line TotCasMeRaA00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 JOHN
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP"
(line TotCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP"
(line TotINFMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line TotINFLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotINFUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 8 SRIV mean
(line TotCasLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 9 SRIV lower
(line TotCasUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 10 SRIV upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 5 "IHME infections" ///
8 "SRIV cases") size(small) row(2)) ///
subtitle("2021 on, reference scenarios with uncertainty", size(small)) ///
note("Uncertainty limits: dashed curves")

graph export "graph 43 COVID-19 total cases, $country, reference scenarios, CI.pdf", replace



****************

* daily CFR / IFR (graph numbers start with 51)


****
* CFR / IFR all studies, all time, reference scenarios, all time

twoway ///
(line DayCfrMeRaA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN"
(line DayCfrMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line infection_fatality_A02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCfrMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR or IFR) title("COVID-19 daily CFR or IFR, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN CFR" 2 "DELP CFR" 3 "IHME IFR" 4 "SRIV CFR") size(small) row(2)) ///
subtitle("reference scenarios", size(small) color(white))

graph export "graph 51 COVID-19 daily CFR, $country, reference scenarios, all time.pdf", replace



****
* cfr all studies, reference scenarios, 2021

twoway ///
(line DayCfrMeRaA00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN"
(line DayCfrMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line infection_fatality_A02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCfrMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR or IFR) title("COVID-19 daily CFR or IFR, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN CFR" 2 "DELP CFR" 3 "IHME IFR" 4 "SRIV CFR") size(small) row(2)) ///
subtitle("2021 on, reference scenarios", size(small))

graph export "graph 52 COVID-19 daily CFR, $country, reference scenarios.pdf", replace





************************

* other outcomes (graph numbers start with 71)


* all hospital-related outcomes, all time

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red) lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayBedMeSmA02S01 date, sort lcolor(black)) /// 3 IHME Bed need (Daily Beds needed Mean IHME S1)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 4 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 5 IHME Admissions (Daily hospital admissions Mean IHME S1)
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME Bed need" 4 "IHME ICU need" ///
5 "IHME Admissions") rows(3) size(small)) ///
subtitle("reference scenarios", size(small) color(white)) 

graph export "graph 71a COVID-19 hospital-related outcomes, all time.pdf", replace






* all hospital-related outcomes, all time

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red) lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayBedMeSmA02S01 date, sort lcolor(black)) /// 3 IHME Bed need (Daily Beds needed Mean IHME S1)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 4 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 5 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayBEDMeSmA02    date, sort lcolor(black) lpattern(dash)) /// 6
(line DayICUMeSmA02    date, sort lcolor(cyan) lpattern(dash)) /// 7
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME Bed need" 4 "IHME ICU need" ///
5 "IHME Admissions" 6 "IHME All bed capcity" 7 "IHME ICU bed capacity") rows(3) size(small)) ///
subtitle("reference scenarios", size(small) color(white)) 

graph export "graph 71b COVID-19 hospital-related outcomes, all time.pdf", replace






* daily hospital-related outcomes, DELP, IHME, wo IHME Bed need

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red) lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 3 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 4 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayICUMeSmA02    date, sort lcolor(cyan) lpattern(dash)) /// 6
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME ICU need" ///
4 "IHME Admissions" 5 "IHME All bed capcity") rows(3) size(small)) ///
subtitle("2021 on, without IHME Bed need, reference scenarios", size(small)) ///
note("Uncertainty limits: dashed curves")

graph export "graph 72 COVID-19 hospital-related outcomes, wo extremes, 2021.pdf", replace



*******************************

* daily cases to deaths (CTD) 


****
* Daily cases or infections to deaths (CTD / ITD) all studies, reference scenarios, all time

twoway ///
(line DayCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayITDMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCTDMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections to deaths) title("COVID-19 daily cases or infections, to deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "SRIV cases") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

graph export "graph 81 COVID-19 daily cases to deaths, $country, reference scenarios, all time.pdf", replace



****
* Daily cases or infections to deaths (CTD / ITD) all studies, reference scenarios, 2021

twoway ///
(line DayCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN"
(line DayCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayITDMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCTDMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections to deaths) title("COVID-19 daily cases or infections, to deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "SRIV cases") size(small) row(1)) ///
subtitle("2021 on, reference scenarios", size(small))

graph export "graph 82 COVID-19 daily cases to deaths, $country, reference scenarios.pdf", replace



****
* Total cases to deaths (CTD / ITD) all studies, all time, reference scenarios, all time

twoway ///
(line TotCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotITDMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotCTDMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections to deaths) title("COVID-19 total cases or infections, to deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "SRIV cases") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

graph export "graph 83 COVID-19 total cases to deaths, $country, reference scenarios, all time.pdf", replace



****
* Total cases to deaths (CTD / ITD) all studies, reference scenarios, 2021

twoway ///
(line TotCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotITDMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotCTDMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections to deaths) title("COVID-19 total cases or infections, to deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "SRIV cases") size(small) row(1)) ///
subtitle("2021 on, reference scenarios", size(small))

graph export "graph 84 COVID-19 total cases to deaths, $country, reference scenarios.pdf", replace




*******************************

*  estimated to reported (graph numbers start with 91)


* daily deaths estimated to reported  


****
* daily deaths estimated to reported (DER) all studies, reference scenarios, all time

twoway ///
(line DayDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDERMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths estimated to reported) title("COVID-19 daily deaths, estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

graph export "graph 91 COVID-19 daily deaths estimated to reported, $country, reference scenarios, all time.pdf", replace



****
* daily deaths estimated to reported (DER) all studies, reference scenarios, 2021

twoway ///
(line DayDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDERMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths estimated to reported) title("COVID-19 daily deaths, estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

graph export "graph 92 COVID-19 daily deaths estimated to reported, $country, reference scenarios.pdf", replace



* daily cases or infections estimated to reported cases


****
* daily cases or infections estimated to reported cases (CER / IER) all studies, reference scenarios, all time 

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCERMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections estimated to reported) title("COVID-19 daily cases estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(3)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "SRIV cases") size(small) row(1)) ///
subtitle("daily cases or infections estimated, to reported cases; reference scenarios", size(small))

graph export "graph 93 COVID-19 daily cases estimated to reported, $country, reference scenarios, all time .pdf", replace



****
* daily cases or infections estimated to reported cases (CER / IER) all studies, 2021-01-01 on, reference scenarios

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCERMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections estimated to reported) title("COVID-19 daily cases estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(3)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "SRIV cases") size(small) row(1)) ///
subtitle("daily cases or infections estimated, to reported cases; reference scenarios", size(small))

graph export "graph 94 COVID-19 daily cases estimated to reported, $country, reference scenarios.pdf", replace



****
* total deaths estimated to reported (DER) all studies, reference scenarios, all time

twoway ///
(line TotDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN
(line TotDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDERMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths estimated to reported) title("COVID-19 total deaths, estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(5)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

graph export "graph 95 COVID-19 total deaths estimated to reported, $country, reference scenarios, all time.pdf", replace



****
* total deaths estimated to reported (DER) all studies, reference scenarios, 2021

twoway ///
(line TotDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN
(line TotDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDERMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths estimated to reported) title("COVID-19 total deaths, estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(5)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

graph export "graph 96 COVID-19 total deaths estimated to reported, $country, reference scenarios.pdf", replace



****
* total cases or infections or infections estimated to reported cases (CER / IER) all studies, reference scenarios, all time

twoway ///
(line TotCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotIERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotCERMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections estimated to reported) title("COVID-19 total cases estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(5)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "SRIV cases") size(small) row(1)) ///
subtitle("total cases or infections estimated, to reported cases; reference scenarios", size(small))

graph export "graph 97 COVID-19 total cases estimated to reported, $country, reference scenarios.pdf", replace



****
* total cases or infections or infections estimated to reported cases (CER / IER) all studies, reference scenarios, 2021

twoway ///
(line TotCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotIERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotCERMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections estimated to reported) title("COVID-19 total cases estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(5)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "SRIV cases") size(small) row(2)) ///
subtitle("total cases or infections estimated, to reported cases; reference scenarios", size(small))

graph export "graph 98 COVID-19 total cases estimated to reported, $country, reference scenarios.pdf", replace






*****************

* IHME graphs



* R effective, 01jun2021 on

twoway ///
(line reff_mean_A02S02 date, sort lcolor(green) lwidth(thick)) ///
(line reff_mean_A02S01 date, sort lcolor(black) lwidth(thick)) ///
(line reff_lower_A02S01 date, sort lcolor(black*.5) lpattern(dash)) ///
(line reff_upper_A02S01 date, sort lcolor(black*.5) lpattern(dash)) ///
if date >= td(01jun2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(R effective) title("COVID-19 R effective, $country, IHME, 2 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Better" 2 "Reference") rows(1)) ///
note(Uncertainty limits: dashed curves)

graph export "graph 101 COVID-19 R effective, $country, 2 scenarios 01jun2021 on.pdf", replace




* daily Infection outcomes ratios, 2 scenarios 
  
twoway ///
(line infection_detection_A02S01 date, sort lcolor(green)) ///
(line infection_hospitalization_A02S01 date, sort lcolor(black)) ///
(line infection_fatality_A02S01 date, sort lcolor(red)) ///
(line infection_detection_A02S02 date, sort lcolor(green) lpattern(dash)) ///
(line infection_hospitalization_A02S02 date, sort lcolor(black) lpattern(dash)) ///
(line infection_fatality_A02S02 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infection outcome ratios) title("COVID-19 daily infection outcome ratios, $country, IHME, 2 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Infection detection ratio" 2 "Infection hospitalization ratio" 3 "Infection fatality ratio") rows(2)) ///
note("Better scenario: dashed curves")

graph export "graph 102 COVID-19 daily Infection outcomes ratios, $country 2 scenarios, IHME.pdf", replace




* daily % change in mobility, CI

twoway ///
(line mobility_mean_A02S02 date, sort lcolor(green) lwidth(vthick) lpattern(tight_dot)) ///
(line mobility_mean_A02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily % change in mobility from baseline) title("COVID-19 daily % change in mobility, $country, IHME, 2 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Better" 2 "Reference") rows(1)) 

graph export "graph 103 COVID-19 daily mobility, $country, 2 scenarios IHME.pdf", replace




* daily mask use Percent of population reporting always wearing a mask when leaving home

twoway ///
(line mask_use_mean_A02S02 date, sort lcolor(green) lwidth(vthick) lpattern(tight_dot)) ///
(line mask_use_mean_A02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily mask use) title("COVID-19 daily mask use, $country, IHME, 2 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Better" 2 "Reference") rows(1)) ///
subtitle(Percent of population reporting always wearing a mask when leaving home, size(small))

graph export "graph 104 COVID-19 daily mask_use, $country, 2 scenarios IHME.pdf", replace



* cumulative vaccinated percent

twoway ///
(line cumulative_all_vaccin_pct date, sort lcolor(black)) ///
(line cumul_all_effect_vacci_pct date, sort lcolor(blue)) ///
(line cumul_all_fully_vacci_pct date, sort lcolor(green) lwidth(thick)) ///
if date >= td(01dec2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(% Cumulative vaccinated percent) title("COVID-19 cumulative vaccinated percent, $country, IHME, 2 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Vaccinated" 2 "Effectively vaccinated" 3 "Fully vaccinated") rows(1)) ///
note("Vaccinated: Initially vaccinated (one dose of two doses)" ///
"Effectively vaccinated: one and two dose with efficacy" ///
"Fully vaccinated: one of one and two of two doses", size(small))

graph export "graph 105 COVID-19 cumulative vaccinated percent, $country IHME.pdf", replace





* daily vaccinated percent

twoway ///
(line daily_all_vaccin_pct date, sort lcolor(black)) ///
(line daily_all_effect_vacci_pct date, sort lcolor(blue)) ///
(line daily_all_fully_vacci_pct date, sort lcolor(green) lwidth(thick)) ///
if date >= td(01dec2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(% Daily vaccinated percent) title("COVID-19 daily vaccinated percent, $country, IHME, 2 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Vaccinated" 2 "Effectively vaccinated" 3 "Fully vaccinated") rows(1)) ///
note("Vaccinated: Initially vaccinated (one dose of two doses)" ///
"Effectively vaccinated: one and two dose with efficacy" ///
"Fully vaccinated: one of one and two of two doses", size(small))

graph export "graph 106 COVID-19 daily vaccinated percent, $country.pdf", replace




* daily vaccinated number

twoway ///
(line daily_all_vaccinated date, sort lcolor(black)) ///
(line daily_all_effectively_vacci date, sort lcolor(blue)) ///
(line daily_all_fully_vaccinated date, sort lcolor(green) lwidth(thick)) ///
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily vaccinated number) title("COVID-19 daily vaccinated number, $country, IHME, 2 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Vaccinated" 2 "Effectively vaccinated" 3 "Fully vaccinated") rows(1)) ///
note("Vaccinated: Initially vaccinated (one dose of two doses)" ///
"Effectively vaccinated: one and two dose with efficacy" ///
"Fully vaccinated: one of one and two of two doses", size(small))

graph export "graph 107 COVID-19 daily vaccinated number, $country.pdf", replace



*



******************************************************

*** EMRO


* EMRO JOHN

cd .. // code

cd JOHN

use "JOHN deaths and cases EMRO region and countries.dta", clear

cd ..

cd merge

save "JOHN deaths and cases EMRO region and countries.dta", replace






****************************

* daily deaths, JOHN, 2022 on, EMRO countries

twoway ///
(line DayDeaMeSmA00AFG date, sort lcolor(brown) lwidth(medium) lpattern(solid)) /// 1 Afghanistan
(line DayDeaMeSmA00BHR date, sort lcolor(brown) lwidth(medium) lpattern(dash)) /// 2 Bahrain
(line DayDeaMeSmA00DJI date, sort lcolor(brown) lwidth(medium) lpattern(dot)) /// 3 Djibouti 
(line DayDeaMeSmA00EGY date, sort lcolor(blue) lwidth(medium) lpattern(solid)) /// 4 Egypt
(line DayDeaMeSmA00IRQ date, sort lcolor(blue) lwidth(medium) lpattern(dash)) /// 5 Iraq
(line DayDeaMeSmA00JOR date, sort lcolor(blue) lwidth(medium) lpattern(dot)) /// 6 Jordan
(line DayDeaMeSmA00KWT date, sort lcolor(green) lwidth(medium) lpattern(solid)) /// 7 Kuwait
(line DayDeaMeSmA00LBN date, sort lcolor(green) lwidth(medium) lpattern(dash)) /// 8 Lebanon
(line DayDeaMeSmA00LBY date, sort lcolor(green) lwidth(medium) lpattern(dot)) /// 9 Libya
(line DayDeaMeSmA00MAR date, sort lcolor(gold) lwidth(medium) lpattern(solid)) /// 10 Morocco
(line DayDeaMeSmA00OMN date, sort lcolor(gold) lwidth(medium) lpattern(dash)) /// 11 Oman
(line DayDeaMeSmA00PAK date, sort lcolor(gold) lwidth(medium) lpattern(dot)) /// 12 Pakistan
(line DayDeaMeSmA00PSE date, sort lcolor(magenta) lwidth(medium) lpattern(solid)) /// 13 Palestine
(line DayDeaMeSmA00QAT date, sort lcolor(magenta) lwidth(medium) lpattern(dash)) /// 14 Qatar
(line DayDeaMeSmA00SAU date, sort lcolor(magenta) lwidth(medium) lpattern(dot)) /// 15 Saudi Arabia
(line DayDeaMeSmA00SOM date, sort lcolor(orange) lwidth(medium) lpattern(solid)) /// 16 Somalia
(line DayDeaMeSmA00SDN date, sort lcolor(orange) lwidth(medium) lpattern(dash)) /// 17 Sudan
(line DayDeaMeSmA00SYR date, sort lcolor(orange) lwidth(medium) lpattern(dot)) /// 18 Syria
(line DayDeaMeSmA00TUN date, sort lcolor(purple) lwidth(medium) lpattern(solid)) /// 19 Tunisia
(line DayDeaMeSmA00ARE date, sort lcolor(purple) lwidth(medium) lpattern(dash)) /// 20 United Arab Emirates
(line DayDeaMeSmA00YEM date, sort lcolor(purple) lwidth(medium) lpattern(dot)) /// 21 Yemen
(line DayDeaMeSmA00EMR date, sort lcolor(black) lwidth(medthick) lpattern(solid)) /// 22 EMRO
(line DayDeaMeSmA00IRN date, sort lcolor(cyan) lwidth(thick) lpattern(solid)) /// 23 Iran
if date >= td(01jan2022) & date <= `nextmonthdatespast01jan2022JOHN' ///
, xtitle(Date) xlabel(#$monthspast01jan2022JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, EMRO countries, Johns Hopkins, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(23 "Iran" 22 "EMR" 1 "AFG" 2 "BHR" 3 "DJI" 4 "EGY" 5 "IRQ" 6 "JOR" 7 "KWT" ///
8 "LBN" 9 "LBY" 10 "MAR" 11 "OMN" 12 "PAK" 13 "PSE" 14 "QAT" 15 "SAU" 16 "SOM" 17 "SDN" ///
18 "SYR" 19 "TUN" 20 "ARE" 21 "YEM") size(small) row(3)) ///
subtitle("Smoothed", size(small))

graph export "graph 1001 COVID-19 daily deaths, EMRO countries, Johns Hopkins, 2022 on.pdf", replace






****************************

* daily deaths, JOHN, 2022 on, EMRO countries, Without extremes

* Without extremes: EMR, Iran, Sudan, and Oman.

twoway ///
(line DayDeaMeSmA00AFG date, sort lcolor(brown) lwidth(medium) lpattern(solid)) /// 1 Afghanistan
(line DayDeaMeSmA00BHR date, sort lcolor(brown) lwidth(medium) lpattern(dash)) /// 2 Bahrain
(line DayDeaMeSmA00DJI date, sort lcolor(brown) lwidth(medium) lpattern(dot)) /// 3 Djibouti 
(line DayDeaMeSmA00EGY date, sort lcolor(blue) lwidth(medium) lpattern(solid)) /// 4 Egypt
(line DayDeaMeSmA00IRQ date, sort lcolor(blue) lwidth(medium) lpattern(dash)) /// 5 Iraq
(line DayDeaMeSmA00JOR date, sort lcolor(blue) lwidth(medium) lpattern(dot)) /// 6 Jordan
(line DayDeaMeSmA00KWT date, sort lcolor(green) lwidth(medium) lpattern(solid)) /// 7 Kuwait
(line DayDeaMeSmA00LBN date, sort lcolor(green) lwidth(medium) lpattern(dash)) /// 8 Lebanon
(line DayDeaMeSmA00LBY date, sort lcolor(green) lwidth(medium) lpattern(dot)) /// 9 Libya
(line DayDeaMeSmA00MAR date, sort lcolor(gold) lwidth(medium) lpattern(solid)) /// 10 Morocco
(line DayDeaMeSmA00PAK date, sort lcolor(gold) lwidth(medium) lpattern(dot)) /// 11 Pakistan
(line DayDeaMeSmA00PSE date, sort lcolor(magenta) lwidth(medium) lpattern(solid)) /// 12 Palestine
(line DayDeaMeSmA00QAT date, sort lcolor(magenta) lwidth(medium) lpattern(dash)) /// 13 Qatar
(line DayDeaMeSmA00SAU date, sort lcolor(magenta) lwidth(medium) lpattern(dot)) /// 14 Saudi Arabia
(line DayDeaMeSmA00SOM date, sort lcolor(orange) lwidth(medium) lpattern(solid)) /// 15 Somalia
(line DayDeaMeSmA00SYR date, sort lcolor(orange) lwidth(medium) lpattern(dot)) /// 16 Syria
(line DayDeaMeSmA00TUN date, sort lcolor(purple) lwidth(medium) lpattern(solid)) /// 17 Tunisia
(line DayDeaMeSmA00ARE date, sort lcolor(purple) lwidth(medium) lpattern(dash)) /// 18 United Arab Emirates
(line DayDeaMeSmA00YEM date, sort lcolor(purple) lwidth(medium) lpattern(dot)) /// 19 Yemen
if date >= td(01jan2022) & date <= `nextmonthdatespast01jan2022JOHN' ///
, xtitle(Date) xlabel(#$monthspast01jan2022JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, EMRO countries, Johns Hopkins, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "AFG" 2 "BHR" 3 "DJI" 4 "EGY" 5 "IRQ" 6 "JOR" 7 "KWT" ///
8 "LBN" 9 "LBY" 10 "MAR" 11 "PAK" 12 "PSE" 13 "QAT" 14 "SAU" 15 "SOM" ///
16 "SYR" 17 "TUN" 18 "ARE" 19 "YEM") size(small) row(3)) ///
subtitle("Without extremes: EMR, Iran, Sudan, and Oman. Smoothed", size(small))

graph export "graph 1001 b COVID-19 daily deaths, EMRO countries, Johns Hopkins, 2022 on.pdf", replace






****************************

* daily deaths, JOHN, 2022 on, EMRO countries, June 2022

twoway ///
(line DayDeaMeSmA00AFG date, sort lcolor(brown) lwidth(medium) lpattern(solid)) /// 1 Afghanistan
(line DayDeaMeSmA00BHR date, sort lcolor(brown) lwidth(medium) lpattern(dash)) /// 2 Bahrain
(line DayDeaMeSmA00DJI date, sort lcolor(brown) lwidth(medium) lpattern(dot)) /// 3 Djibouti 
(line DayDeaMeSmA00EGY date, sort lcolor(blue) lwidth(medium) lpattern(solid)) /// 4 Egypt
(line DayDeaMeSmA00IRQ date, sort lcolor(blue) lwidth(medium) lpattern(dash)) /// 5 Iraq
(line DayDeaMeSmA00JOR date, sort lcolor(blue) lwidth(medium) lpattern(dot)) /// 6 Jordan
(line DayDeaMeSmA00KWT date, sort lcolor(green) lwidth(medium) lpattern(solid)) /// 7 Kuwait
(line DayDeaMeSmA00LBN date, sort lcolor(green) lwidth(medium) lpattern(dash)) /// 8 Lebanon
(line DayDeaMeSmA00LBY date, sort lcolor(green) lwidth(medium) lpattern(dot)) /// 9 Libya
(line DayDeaMeSmA00MAR date, sort lcolor(gold) lwidth(medium) lpattern(solid)) /// 10 Morocco
(line DayDeaMeSmA00OMN date, sort lcolor(gold) lwidth(medium) lpattern(dash)) /// 11 Oman
(line DayDeaMeSmA00PAK date, sort lcolor(gold) lwidth(medium) lpattern(dot)) /// 12 Pakistan
(line DayDeaMeSmA00PSE date, sort lcolor(magenta) lwidth(medium) lpattern(solid)) /// 13 Palestine
(line DayDeaMeSmA00QAT date, sort lcolor(magenta) lwidth(medium) lpattern(dash)) /// 14 Qatar
(line DayDeaMeSmA00SAU date, sort lcolor(magenta) lwidth(medium) lpattern(dot)) /// 15 Saudi Arabia
(line DayDeaMeSmA00SOM date, sort lcolor(orange) lwidth(medium) lpattern(solid)) /// 16 Somalia
(line DayDeaMeSmA00SDN date, sort lcolor(orange) lwidth(medium) lpattern(dash)) /// 17 Sudan
(line DayDeaMeSmA00SYR date, sort lcolor(orange) lwidth(medium) lpattern(dot)) /// 18 Syria
(line DayDeaMeSmA00TUN date, sort lcolor(purple) lwidth(medium) lpattern(solid)) /// 19 Tunisia
(line DayDeaMeSmA00ARE date, sort lcolor(purple) lwidth(medium) lpattern(dash)) /// 20 United Arab Emirates
(line DayDeaMeSmA00YEM date, sort lcolor(purple) lwidth(medium) lpattern(dot)) /// 21 Yemen
(line DayDeaMeSmA00EMR date, sort lcolor(black) lwidth(medthick) lpattern(solid)) /// 22 EMRO
(line DayDeaMeSmA00IRN date, sort lcolor(cyan) lwidth(thick) lpattern(solid)) /// 23 Iran
if date >= td(01jun2022) & date <= td(01jul2022) ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, EMRO countries, Johns Hopkins, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(23 "Iran" 22 "EMR" 1 "AFG" 2 "BHR" 3 "DJI" 4 "EGY" 5 "IRQ" 6 "JOR" 7 "KWT" ///
8 "LBN" 9 "LBY" 10 "MAR" 11 "OMN" 12 "PAK" 13 "PSE" 14 "QAT" 15 "SAU" 16 "SOM" 17 "SDN" ///
18 "SYR" 19 "TUN" 20 "ARE" 21 "YEM") size(small) row(3)) ///
subtitle("June 2022. Smoothed", size(small))

graph export "graph 1001 c COVID-19 daily deaths, EMRO countries, Johns Hopkins, 2022 on.pdf", replace








****************************

* daily deaths, JOHN, 2022 on, EMRO countries, June 2022

* Without extremes: EMR, Oman.

twoway ///
(line DayDeaMeSmA00AFG date, sort lcolor(brown) lwidth(medium) lpattern(solid)) /// 1 Afghanistan
(line DayDeaMeSmA00BHR date, sort lcolor(brown) lwidth(medium) lpattern(dash)) /// 2 Bahrain
(line DayDeaMeSmA00DJI date, sort lcolor(brown) lwidth(medium) lpattern(dot)) /// 3 Djibouti 
(line DayDeaMeSmA00EGY date, sort lcolor(blue) lwidth(medium) lpattern(solid)) /// 4 Egypt
(line DayDeaMeSmA00IRQ date, sort lcolor(blue) lwidth(medium) lpattern(dash)) /// 5 Iraq
(line DayDeaMeSmA00JOR date, sort lcolor(blue) lwidth(medium) lpattern(dot)) /// 6 Jordan
(line DayDeaMeSmA00KWT date, sort lcolor(green) lwidth(medium) lpattern(solid)) /// 7 Kuwait
(line DayDeaMeSmA00LBN date, sort lcolor(green) lwidth(medium) lpattern(dash)) /// 8 Lebanon
(line DayDeaMeSmA00LBY date, sort lcolor(green) lwidth(medium) lpattern(dot)) /// 9 Libya
(line DayDeaMeSmA00MAR date, sort lcolor(gold) lwidth(medium) lpattern(solid)) /// 10 Morocco
(line DayDeaMeSmA00PAK date, sort lcolor(gold) lwidth(medium) lpattern(dot)) /// 11 Pakistan
(line DayDeaMeSmA00PSE date, sort lcolor(magenta) lwidth(medium) lpattern(solid)) /// 12 Palestine
(line DayDeaMeSmA00QAT date, sort lcolor(magenta) lwidth(medium) lpattern(dash)) /// 13 Qatar
(line DayDeaMeSmA00SAU date, sort lcolor(magenta) lwidth(medium) lpattern(dot)) /// 14 Saudi Arabia
(line DayDeaMeSmA00SOM date, sort lcolor(orange) lwidth(medium) lpattern(solid)) /// 15 Somalia
(line DayDeaMeSmA00SDN date, sort lcolor(orange) lwidth(medium) lpattern(dash)) /// 16 Sudan
(line DayDeaMeSmA00SYR date, sort lcolor(orange) lwidth(medium) lpattern(dot)) /// 17 Syria
(line DayDeaMeSmA00TUN date, sort lcolor(purple) lwidth(medium) lpattern(solid)) /// 18 Tunisia
(line DayDeaMeSmA00ARE date, sort lcolor(purple) lwidth(medium) lpattern(dash)) /// 19 United Arab Emirates
(line DayDeaMeSmA00YEM date, sort lcolor(purple) lwidth(medium) lpattern(dot)) /// 10 Yemen
(line DayDeaMeSmA00IRN date, sort lcolor(cyan) lwidth(thick) lpattern(solid)) /// 21 Iran
if date >= td(01jun2022) & date <= td(01jul2022) ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, EMRO countries, Johns Hopkins, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(21 "Iran" 1 "AFG" 2 "BHR" 3 "DJI" 4 "EGY" 5 "IRQ" 6 "JOR" 7 "KWT" ///
8 "LBN" 9 "LBY" 10 "MAR" 11 "PAK" 12 "PSE" 13 "QAT" 14 "SAU" 15 "SOM" 16 "SDN" ///
17 "SYR" 18 "TUN" 19 "ARE" 10 "YEM") size(small) row(3)) ///
subtitle("Without extremes: EMR, Oman. June 2022. Smoothed", size(small))

graph export "graph 1001 d COVID-19 daily deaths, EMRO countries, Johns Hopkins, 2022 on.pdf", replace







****************************

* daily cases, JOHN, 2022 on, EMRO countries

twoway ///
(line DayCasMeSmA00AFG date, sort lcolor(brown) lwidth(medium) lpattern(solid)) /// 1 Afghanistan
(line DayCasMeSmA00BHR date, sort lcolor(brown) lwidth(medium) lpattern(dash)) /// 2 Bahrain
(line DayCasMeSmA00DJI date, sort lcolor(brown) lwidth(medium) lpattern(dot)) /// 3 Djibouti 
(line DayCasMeSmA00EGY date, sort lcolor(blue) lwidth(medium) lpattern(solid)) /// 4 Egypt
(line DayCasMeSmA00IRQ date, sort lcolor(blue) lwidth(medium) lpattern(dash)) /// 5 Iraq
(line DayCasMeSmA00JOR date, sort lcolor(blue) lwidth(medium) lpattern(dot)) /// 6 Jordan
(line DayCasMeSmA00KWT date, sort lcolor(green) lwidth(medium) lpattern(solid)) /// 7 Kuwait
(line DayCasMeSmA00LBN date, sort lcolor(green) lwidth(medium) lpattern(dash)) /// 8 Lebanon
(line DayCasMeSmA00LBY date, sort lcolor(green) lwidth(medium) lpattern(dot)) /// 9 Libya
(line DayCasMeSmA00MAR date, sort lcolor(gold) lwidth(medium) lpattern(solid)) /// 10 Morocco
(line DayCasMeSmA00OMN date, sort lcolor(gold) lwidth(medium) lpattern(dash)) /// 11 Oman
(line DayCasMeSmA00PAK date, sort lcolor(gold) lwidth(medium) lpattern(dot)) /// 12 Pakistan
(line DayCasMeSmA00PSE date, sort lcolor(magenta) lwidth(medium) lpattern(solid)) /// 13 Palestine
(line DayCasMeSmA00QAT date, sort lcolor(magenta) lwidth(medium) lpattern(dash)) /// 14 Qatar
(line DayCasMeSmA00SAU date, sort lcolor(magenta) lwidth(medium) lpattern(dot)) /// 15 Saudi Arabia
(line DayCasMeSmA00SOM date, sort lcolor(orange) lwidth(medium) lpattern(solid)) /// 16 Somalia
(line DayCasMeSmA00SDN date, sort lcolor(orange) lwidth(medium) lpattern(dash)) /// 17 Sudan
(line DayCasMeSmA00SYR date, sort lcolor(orange) lwidth(medium) lpattern(dot)) /// 18 Syria
(line DayCasMeSmA00TUN date, sort lcolor(purple) lwidth(medium) lpattern(solid)) /// 19 Tunisia
(line DayCasMeSmA00ARE date, sort lcolor(purple) lwidth(medium) lpattern(dash)) /// 20 United Arab Emirates
(line DayCasMeSmA00YEM date, sort lcolor(purple) lwidth(medium) lpattern(dot)) /// 21 Yemen
(line DayCasMeSmA00EMR date, sort lcolor(black) lwidth(medthick)  lpattern(solid)) /// 22 EMRO
(line DayCasMeSmA00IRN date, sort lcolor(cyan) lwidth(thick)  lpattern(solid)) /// 23 Iran
if date >= td(01jan2022) & date <= `nextmonthdatespast01jan2022JOHN' ///
, xtitle(Date) xlabel(#$monthspast01jan2022JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported cases) title("COVID-19 daily reported cases, EMRO countries, Johns Hopkins, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(23 "Iran" 22 "EMR" 1 "AFG" 2 "BHR" 3 "DJI" 4 "EGY" 5 "IRQ" 6 "JOR" 7 "KWT" ///
8 "LBN" 9 "LBY" 10 "MAR" 11 "OMN" 12 "PAK" 13 "PSE" 14 "QAT" 15 "SAU" 16 "SOM" 17 "SDN" ///
18 "SYR" 19 "TUN" 20 "ARE" 21 "YEM") size(small) row(3)) ///
subtitle("Smoothed", size(small))

graph export "graph 1010 COVID-19 daily cases, EMRO countries, Johns Hopkins, 2022 on.pdf", replace






****************************

* daily cases, JOHN, 2022 on, EMRO countries, Without extremes

twoway ///
(line DayCasMeSmA00AFG date, sort lcolor(brown) lwidth(medium) lpattern(solid)) /// 1 Afghanistan
(line DayCasMeSmA00BHR date, sort lcolor(brown) lwidth(medium) lpattern(dash)) /// 2 Bahrain
(line DayCasMeSmA00DJI date, sort lcolor(brown) lwidth(medium) lpattern(dot)) /// 3 Djibouti 
(line DayCasMeSmA00EGY date, sort lcolor(blue) lwidth(medium) lpattern(solid)) /// 4 Egypt
(line DayCasMeSmA00IRQ date, sort lcolor(blue) lwidth(medium) lpattern(dash)) /// 5 Iraq
(line DayCasMeSmA00KWT date, sort lcolor(green) lwidth(medium) lpattern(solid)) /// 6 Kuwait
(line DayCasMeSmA00LBN date, sort lcolor(green) lwidth(medium) lpattern(dash)) /// 7 Lebanon
(line DayCasMeSmA00LBY date, sort lcolor(green) lwidth(medium) lpattern(dot)) /// 8 Libya
(line DayCasMeSmA00MAR date, sort lcolor(gold) lwidth(medium) lpattern(solid)) /// 9 Morocco
(line DayCasMeSmA00OMN date, sort lcolor(gold) lwidth(medium) lpattern(dash)) /// 10 Oman
(line DayCasMeSmA00PAK date, sort lcolor(gold) lwidth(medium) lpattern(dot)) /// 11 Pakistan
(line DayCasMeSmA00PSE date, sort lcolor(magenta) lwidth(medium) lpattern(solid)) /// 12 Palestine
(line DayCasMeSmA00QAT date, sort lcolor(magenta) lwidth(medium) lpattern(dash)) /// 13 Qatar
(line DayCasMeSmA00SAU date, sort lcolor(magenta) lwidth(medium) lpattern(dot)) /// 14 Saudi Arabia
(line DayCasMeSmA00SOM date, sort lcolor(orange) lwidth(medium) lpattern(solid)) /// 15 Somalia
(line DayCasMeSmA00SDN date, sort lcolor(orange) lwidth(medium) lpattern(dash)) /// 16 Sudan
(line DayCasMeSmA00SYR date, sort lcolor(orange) lwidth(medium) lpattern(dot)) /// 17 Syria
(line DayCasMeSmA00TUN date, sort lcolor(purple) lwidth(medium) lpattern(solid)) /// 18 Tunisia
(line DayCasMeSmA00ARE date, sort lcolor(purple) lwidth(medium) lpattern(dash)) /// 19 United Arab Emirates
(line DayCasMeSmA00YEM date, sort lcolor(purple) lwidth(medium) lpattern(dot)) /// 20 Yemen
if date >= td(01jan2022) & date <= `nextmonthdatespast01jan2022JOHN' ///
, xtitle(Date) xlabel(#$monthspast01jan2022JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported cases) title("COVID-19 daily reported cases, EMRO countries, Johns Hopkins, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "AFG" 2 "BHR" 3 "DJI" 4 "EGY" 5 "IRQ" 6 "KWT" ///
7 "LBN" 8 "LBY" 9 "MAR" 10 "OMN" 11 "PAK" 12 "PSE" 13 "QAT" 14 "SAU" 15 "SOM" 16 "SDN" ///
17 "SYR" 18 "TUN" 19 "ARE" 20 "YEM") size(small) row(3)) ///
subtitle("Without extremes: EMR, Iran, and Jordan. Smoothed", size(small))

graph export "graph 1010 b COVID-19 daily cases, EMRO countries, Johns Hopkins, 2022 on.pdf", replace






****************************

* daily cases, JOHN, 2022 on, EMRO countries, June 2022

twoway ///
(line DayCasMeSmA00AFG date, sort lcolor(brown) lwidth(medium) lpattern(solid)) /// 1 Afghanistan
(line DayCasMeSmA00BHR date, sort lcolor(brown) lwidth(medium) lpattern(dash)) /// 2 Bahrain
(line DayCasMeSmA00DJI date, sort lcolor(brown) lwidth(medium) lpattern(dot)) /// 3 Djibouti 
(line DayCasMeSmA00EGY date, sort lcolor(blue) lwidth(medium) lpattern(solid)) /// 4 Egypt
(line DayCasMeSmA00IRQ date, sort lcolor(blue) lwidth(medium) lpattern(dash)) /// 5 Iraq
(line DayCasMeSmA00JOR date, sort lcolor(blue) lwidth(medium) lpattern(dot)) /// 6 Jordan
(line DayCasMeSmA00KWT date, sort lcolor(green) lwidth(medium) lpattern(solid)) /// 7 Kuwait
(line DayCasMeSmA00LBN date, sort lcolor(green) lwidth(medium) lpattern(dash)) /// 8 Lebanon
(line DayCasMeSmA00LBY date, sort lcolor(green) lwidth(medium) lpattern(dot)) /// 9 Libya
(line DayCasMeSmA00MAR date, sort lcolor(gold) lwidth(medium) lpattern(solid)) /// 10 Morocco
(line DayCasMeSmA00OMN date, sort lcolor(gold) lwidth(medium) lpattern(dash)) /// 11 Oman
(line DayCasMeSmA00PAK date, sort lcolor(gold) lwidth(medium) lpattern(dot)) /// 12 Pakistan
(line DayCasMeSmA00PSE date, sort lcolor(magenta) lwidth(medium) lpattern(solid)) /// 13 Palestine
(line DayCasMeSmA00QAT date, sort lcolor(magenta) lwidth(medium) lpattern(dash)) /// 14 Qatar
(line DayCasMeSmA00SAU date, sort lcolor(magenta) lwidth(medium) lpattern(dot)) /// 15 Saudi Arabia
(line DayCasMeSmA00SOM date, sort lcolor(orange) lwidth(medium) lpattern(solid)) /// 16 Somalia
(line DayCasMeSmA00SDN date, sort lcolor(orange) lwidth(medium) lpattern(dash)) /// 17 Sudan
(line DayCasMeSmA00SYR date, sort lcolor(orange) lwidth(medium) lpattern(dot)) /// 18 Syria
(line DayCasMeSmA00TUN date, sort lcolor(purple) lwidth(medium) lpattern(solid)) /// 19 Tunisia
(line DayCasMeSmA00ARE date, sort lcolor(purple) lwidth(medium) lpattern(dash)) /// 20 United Arab Emirates
(line DayCasMeSmA00YEM date, sort lcolor(purple) lwidth(medium) lpattern(dot)) /// 21 Yemen
(line DayCasMeSmA00IRN date, sort lcolor(cyan) lwidth(thick)  lpattern(solid)) /// 22 Iran
if date >= td(01jun2022) & date <= td(01jul2022) ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported cases) title("COVID-19 daily reported cases, EMRO countries, Johns Hopkins, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(22 "Iran" 1 "AFG" 2 "BHR" 3 "DJI" 4 "EGY" 5 "IRQ" 6 "JOR" 7 "KWT" ///
8 "LBN" 9 "LBY" 10 "MAR" 11 "OMN" 12 "PAK" 13 "PSE" 14 "QAT" 15 "SAU" 16 "SOM" 17 "SDN" ///
18 "SYR" 19 "TUN" 20 "ARE" 21 "YEM") size(small) row(3)) ///
subtitle("Without EMR. June 2022. Smoothed", size(small))

graph export "graph 1010 c COVID-19 daily cases, EMRO countries, Johns Hopkins, 2022 on.pdf", replace





* EMRO IHME

cd .. // code

cd IHME

use "IHME EMRO reference scenario 2022", clear

cd ..

cd merge

save "IHME EMRO reference scenario 2022.dta", replace






****************************

* daily deaths, IHME, 2022 on, EMRO countries

twoway ///
(line DayDeaMeSmA02S01AFG date, sort lcolor(brown) lwidth(medium) lpattern(solid)) /// 1 Afghanistan
(line DayDeaMeSmA02S01BHR date, sort lcolor(brown) lwidth(medium) lpattern(dash)) /// 2 Bahrain
(line DayDeaMeSmA02S01DJI date, sort lcolor(brown) lwidth(medium) lpattern(dot)) /// 3 Djibouti 
(line DayDeaMeSmA02S01EGY date, sort lcolor(blue) lwidth(medium) lpattern(solid)) /// 4 Egypt
(line DayDeaMeSmA02S01IRQ date, sort lcolor(blue) lwidth(medium) lpattern(dash)) /// 5 Iraq
(line DayDeaMeSmA02S01JOR date, sort lcolor(blue) lwidth(medium) lpattern(dot)) /// 6 Jordan
(line DayDeaMeSmA02S01KWT date, sort lcolor(green) lwidth(medium) lpattern(solid)) /// 7 Kuwait
(line DayDeaMeSmA02S01LBN date, sort lcolor(green) lwidth(medium) lpattern(dash)) /// 8 Lebanon
(line DayDeaMeSmA02S01LBY date, sort lcolor(green) lwidth(medium) lpattern(dot)) /// 9 Libya
(line DayDeaMeSmA02S01MAR date, sort lcolor(gold) lwidth(medium) lpattern(solid)) /// 10 Morocco
(line DayDeaMeSmA02S01OMN date, sort lcolor(gold) lwidth(medium) lpattern(dash)) /// 11 Oman
(line DayDeaMeSmA02S01PAK date, sort lcolor(gold) lwidth(medium) lpattern(dot)) /// 12 Pakistan
(line DayDeaMeSmA02S01PSE date, sort lcolor(magenta) lwidth(medium) lpattern(solid)) /// 13 Palestine
(line DayDeaMeSmA02S01QAT date, sort lcolor(magenta) lwidth(medium) lpattern(dash)) /// 14 Qatar
(line DayDeaMeSmA02S01SAU date, sort lcolor(magenta) lwidth(medium) lpattern(dot)) /// 15 Saudi Arabia
(line DayDeaMeSmA02S01SOM date, sort lcolor(orange) lwidth(medium) lpattern(solid)) /// 16 Somalia
(line DayDeaMeSmA02S01SDN date, sort lcolor(orange) lwidth(medium) lpattern(dash)) /// 17 Sudan
(line DayDeaMeSmA02S01SYR date, sort lcolor(orange) lwidth(medium) lpattern(dot)) /// 18 Syria
(line DayDeaMeSmA02S01TUN date, sort lcolor(purple) lwidth(medium) lpattern(solid)) /// 19 Tunisia
(line DayDeaMeSmA02S01ARE date, sort lcolor(purple) lwidth(medium) lpattern(dash)) /// 20 United Arab Emirates
(line DayDeaMeSmA02S01YEM date, sort lcolor(purple) lwidth(medium) lpattern(dot)) /// 21 Yemen
(line DayDeaMeSmA02S01EMR date, sort lcolor(black) lwidth(medthick) lpattern(solid)) /// 22 EMRO
(line DayDeaMeSmA02S01IRN date, sort lcolor(cyan) lwidth(thick) lpattern(solid)) /// 23 Iran
if date >= td(01jan2022) & date <= td(01oct2022) ///
, xtitle(Date) xlabel(#10, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, EMRO countries, IHME, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(23 "Iran" 22 "EMR" 1 "AFG" 2 "BHR" 3 "DJI" 4 "EGY" 5 "IRQ" 6 "JOR" 7 "KWT" ///
8 "LBN" 9 "LBY" 10 "MAR" 11 "OMN" 12 "PAK" 13 "PSE" 14 "QAT" 15 "SAU" 16 "SOM" 17 "SDN" ///
18 "SYR" 19 "TUN" 20 "ARE" 21 "YEM") size(small) row(3)) ///
subtitle("Smoothed", size(small))

graph export "graph 1101 COVID-19 daily deaths, EMRO countries, IHME, 2022 on.pdf", replace






****************************

* daily deaths, IHME, 2022 on, EMRO countries, Forecast only = June on

twoway ///
(line DayDeaFOREA02S01AFG date, sort lcolor(brown) lwidth(medium) lpattern(solid)) /// 1 Afghanistan
(line DayDeaFOREA02S01BHR date, sort lcolor(brown) lwidth(medium) lpattern(dash)) /// 2 Bahrain
(line DayDeaFOREA02S01DJI date, sort lcolor(brown) lwidth(medium) lpattern(dot)) /// 3 Djibouti 
(line DayDeaFOREA02S01EGY date, sort lcolor(blue) lwidth(medium) lpattern(solid)) /// 4 Egypt
(line DayDeaFOREA02S01IRQ date, sort lcolor(blue) lwidth(medium) lpattern(dash)) /// 5 Iraq
(line DayDeaFOREA02S01JOR date, sort lcolor(blue) lwidth(medium) lpattern(dot)) /// 6 Jordan
(line DayDeaFOREA02S01KWT date, sort lcolor(green) lwidth(medium) lpattern(solid)) /// 7 Kuwait
(line DayDeaFOREA02S01LBN date, sort lcolor(green) lwidth(medium) lpattern(dash)) /// 8 Lebanon
(line DayDeaFOREA02S01LBY date, sort lcolor(green) lwidth(medium) lpattern(dot)) /// 9 Libya
(line DayDeaFOREA02S01MAR date, sort lcolor(gold) lwidth(medium) lpattern(solid)) /// 10 Morocco
(line DayDeaFOREA02S01OMN date, sort lcolor(gold) lwidth(medium) lpattern(dash)) /// 11 Oman
(line DayDeaFOREA02S01PAK date, sort lcolor(gold) lwidth(medium) lpattern(dot)) /// 12 Pakistan
(line DayDeaFOREA02S01PSE date, sort lcolor(magenta) lwidth(medium) lpattern(solid)) /// 13 Palestine
(line DayDeaFOREA02S01QAT date, sort lcolor(magenta) lwidth(medium) lpattern(dash)) /// 14 Qatar
(line DayDeaFOREA02S01SAU date, sort lcolor(magenta) lwidth(medium) lpattern(dot)) /// 15 Saudi Arabia
(line DayDeaFOREA02S01SOM date, sort lcolor(orange) lwidth(medium) lpattern(solid)) /// 16 Somalia
(line DayDeaFOREA02S01SDN date, sort lcolor(orange) lwidth(medium) lpattern(dash)) /// 17 Sudan
(line DayDeaFOREA02S01SYR date, sort lcolor(orange) lwidth(medium) lpattern(dot)) /// 18 Syria
(line DayDeaFOREA02S01TUN date, sort lcolor(purple) lwidth(medium) lpattern(solid)) /// 19 Tunisia
(line DayDeaFOREA02S01ARE date, sort lcolor(purple) lwidth(medium) lpattern(dash)) /// 20 United Arab Emirates
(line DayDeaFOREA02S01YEM date, sort lcolor(purple) lwidth(medium) lpattern(dot)) /// 21 Yemen
(line DayDeaFOREA02S01EMR date, sort lcolor(black) lwidth(medthick) lpattern(solid)) /// 22 EMRO
(line DayDeaFOREA02S01IRN date, sort lcolor(cyan) lwidth(thick) lpattern(solid)) /// 23 Iran
if date >= td(01jun2022) & date <= td(01oct2022) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, EMRO countries, IHME, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(23 "Iran" 22 "EMR" 1 "AFG" 2 "BHR" 3 "DJI" 4 "EGY" 5 "IRQ" 6 "JOR" 7 "KWT" ///
8 "LBN" 9 "LBY" 10 "MAR" 11 "OMN" 12 "PAK" 13 "PSE" 14 "QAT" 15 "SAU" 16 "SOM" 17 "SDN" ///
18 "SYR" 19 "TUN" 20 "ARE" 21 "YEM") size(small) row(3)) ///
subtitle("Forecast only. Smoothed", size(small))

graph export "graph 1101 b COVID-19 daily deaths, EMRO countries, IHME, 2022 on.pdf", replace






****************************

* daily infections, IHME, 2022 on, EMRO countries

twoway ///
(line DayINFMeSmA02S01AFG date, sort lcolor(brown) lwidth(medium) lpattern(solid)) /// 1 Afghanistan
(line DayINFMeSmA02S01BHR date, sort lcolor(brown) lwidth(medium) lpattern(dash)) /// 2 Bahrain
(line DayINFMeSmA02S01DJI date, sort lcolor(brown) lwidth(medium) lpattern(dot)) /// 3 Djibouti 
(line DayINFMeSmA02S01EGY date, sort lcolor(blue) lwidth(medium) lpattern(solid)) /// 4 Egypt
(line DayINFMeSmA02S01IRQ date, sort lcolor(blue) lwidth(medium) lpattern(dash)) /// 5 Iraq
(line DayINFMeSmA02S01JOR date, sort lcolor(blue) lwidth(medium) lpattern(dot)) /// 6 Jordan
(line DayINFMeSmA02S01KWT date, sort lcolor(green) lwidth(medium) lpattern(solid)) /// 7 Kuwait
(line DayINFMeSmA02S01LBN date, sort lcolor(green) lwidth(medium) lpattern(dash)) /// 8 Lebanon
(line DayINFMeSmA02S01LBY date, sort lcolor(green) lwidth(medium) lpattern(dot)) /// 9 Libya
(line DayINFMeSmA02S01MAR date, sort lcolor(gold) lwidth(medium) lpattern(solid)) /// 10 Morocco
(line DayINFMeSmA02S01OMN date, sort lcolor(gold) lwidth(medium) lpattern(dash)) /// 11 Oman
(line DayINFMeSmA02S01PAK date, sort lcolor(gold) lwidth(medium) lpattern(dot)) /// 12 Pakistan
(line DayINFMeSmA02S01PSE date, sort lcolor(magenta) lwidth(medium) lpattern(solid)) /// 13 Palestine
(line DayINFMeSmA02S01QAT date, sort lcolor(magenta) lwidth(medium) lpattern(dash)) /// 14 Qatar
(line DayINFMeSmA02S01SAU date, sort lcolor(magenta) lwidth(medium) lpattern(dot)) /// 15 Saudi Arabia
(line DayINFMeSmA02S01SOM date, sort lcolor(orange) lwidth(medium) lpattern(solid)) /// 16 Somalia
(line DayINFMeSmA02S01SDN date, sort lcolor(orange) lwidth(medium) lpattern(dash)) /// 17 Sudan
(line DayINFMeSmA02S01SYR date, sort lcolor(orange) lwidth(medium) lpattern(dot)) /// 18 Syria
(line DayINFMeSmA02S01TUN date, sort lcolor(purple) lwidth(medium) lpattern(solid)) /// 19 Tunisia
(line DayINFMeSmA02S01ARE date, sort lcolor(purple) lwidth(medium) lpattern(dash)) /// 20 United Arab Emirates
(line DayINFMeSmA02S01YEM date, sort lcolor(purple) lwidth(medium) lpattern(dot)) /// 21 Yemen
(line DayINFMeSmA02S01EMR date, sort lcolor(black) lwidth(medthick) lpattern(solid)) /// 22 EMRO
(line DayINFMeSmA02S01IRN date, sort lcolor(cyan) lwidth(thick) lpattern(solid)) /// 23 Iran
if date >= td(01jan2022) & date <= td(01oct2022) ///
, xtitle(Date) xlabel(#10, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported infections) title("COVID-19 daily reported infections, EMRO countries, IHME, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(23 "Iran" 22 "EMR" 1 "AFG" 2 "BHR" 3 "DJI" 4 "EGY" 5 "IRQ" 6 "JOR" 7 "KWT" ///
8 "LBN" 9 "LBY" 10 "MAR" 11 "OMN" 12 "PAK" 13 "PSE" 14 "QAT" 15 "SAU" 16 "SOM" 17 "SDN" ///
18 "SYR" 19 "TUN" 20 "ARE" 21 "YEM") size(small) row(3)) ///
subtitle("Smoothed", size(small))

graph export "graph 1111 COVID-19 daily infections, EMRO countries, IHME, 2022 on.pdf", replace






****************************

* daily infections, IHME, 2022 on, EMRO countries, Forecast only = June on

twoway ///
(line DayINFFOREA02S01AFG date, sort lcolor(brown) lwidth(medium) lpattern(solid)) /// 1 Afghanistan
(line DayINFFOREA02S01BHR date, sort lcolor(brown) lwidth(medium) lpattern(dash)) /// 2 Bahrain
(line DayINFFOREA02S01DJI date, sort lcolor(brown) lwidth(medium) lpattern(dot)) /// 3 Djibouti 
(line DayINFFOREA02S01EGY date, sort lcolor(blue) lwidth(medium) lpattern(solid)) /// 4 Egypt
(line DayINFFOREA02S01IRQ date, sort lcolor(blue) lwidth(medium) lpattern(dash)) /// 5 Iraq
(line DayINFFOREA02S01JOR date, sort lcolor(blue) lwidth(medium) lpattern(dot)) /// 6 Jordan
(line DayINFFOREA02S01KWT date, sort lcolor(green) lwidth(medium) lpattern(solid)) /// 7 Kuwait
(line DayINFFOREA02S01LBN date, sort lcolor(green) lwidth(medium) lpattern(dash)) /// 8 Lebanon
(line DayINFFOREA02S01LBY date, sort lcolor(green) lwidth(medium) lpattern(dot)) /// 9 Libya
(line DayINFFOREA02S01MAR date, sort lcolor(gold) lwidth(medium) lpattern(solid)) /// 10 Morocco
(line DayINFFOREA02S01OMN date, sort lcolor(gold) lwidth(medium) lpattern(dash)) /// 11 Oman
(line DayINFFOREA02S01PAK date, sort lcolor(gold) lwidth(medium) lpattern(dot)) /// 12 Pakistan
(line DayINFFOREA02S01PSE date, sort lcolor(magenta) lwidth(medium) lpattern(solid)) /// 13 Palestine
(line DayINFFOREA02S01QAT date, sort lcolor(magenta) lwidth(medium) lpattern(dash)) /// 14 Qatar
(line DayINFFOREA02S01SAU date, sort lcolor(magenta) lwidth(medium) lpattern(dot)) /// 15 Saudi Arabia
(line DayINFFOREA02S01SOM date, sort lcolor(orange) lwidth(medium) lpattern(solid)) /// 16 Somalia
(line DayINFFOREA02S01SDN date, sort lcolor(orange) lwidth(medium) lpattern(dash)) /// 17 Sudan
(line DayINFFOREA02S01SYR date, sort lcolor(orange) lwidth(medium) lpattern(dot)) /// 18 Syria
(line DayINFFOREA02S01TUN date, sort lcolor(purple) lwidth(medium) lpattern(solid)) /// 19 Tunisia
(line DayINFFOREA02S01ARE date, sort lcolor(purple) lwidth(medium) lpattern(dash)) /// 20 United Arab Emirates
(line DayINFFOREA02S01YEM date, sort lcolor(purple) lwidth(medium) lpattern(dot)) /// 21 Yemen
(line DayINFFOREA02S01EMR date, sort lcolor(black) lwidth(medthick) lpattern(solid)) /// 22 EMRO
(line DayINFFOREA02S01IRN date, sort lcolor(cyan) lwidth(thick) lpattern(solid)) /// 23 Iran
if date >= td(01jun2022) & date <= td(01oct2022) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported infections) title("COVID-19 daily reported infections, EMRO countries, IHME, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(23 "Iran" 22 "EMR" 1 "AFG" 2 "BHR" 3 "DJI" 4 "EGY" 5 "IRQ" 6 "JOR" 7 "KWT" ///
8 "LBN" 9 "LBY" 10 "MAR" 11 "OMN" 12 "PAK" 13 "PSE" 14 "QAT" 15 "SAU" 16 "SOM" 17 "SDN" ///
18 "SYR" 19 "TUN" 20 "ARE" 21 "YEM") size(small) row(3)) ///
subtitle("Forecast only. Smoothed", size(small))

graph export "graph 1111 b COVID-19 daily infections, EMRO countries, IHME, 2022 on.pdf", replace








****************************

* daily infections, IHME, 2022 on, EMRO countries, Forecast only = 03jun2022 on

* Without extremes: EMR total and Morocco.

twoway ///
(line DayINFFOREA02S01AFG date, sort lcolor(brown) lwidth(medium) lpattern(solid)) /// 1 Afghanistan
(line DayINFFOREA02S01BHR date, sort lcolor(brown) lwidth(medium) lpattern(dash)) /// 2 Bahrain
(line DayINFFOREA02S01DJI date, sort lcolor(brown) lwidth(medium) lpattern(dot)) /// 3 Djibouti 
(line DayINFFOREA02S01EGY date, sort lcolor(blue) lwidth(medium) lpattern(solid)) /// 4 Egypt
(line DayINFFOREA02S01IRQ date, sort lcolor(blue) lwidth(medium) lpattern(dash)) /// 5 Iraq
(line DayINFFOREA02S01JOR date, sort lcolor(blue) lwidth(medium) lpattern(dot)) /// 6 Jordan
(line DayINFFOREA02S01KWT date, sort lcolor(green) lwidth(medium) lpattern(solid)) /// 7 Kuwait
(line DayINFFOREA02S01LBN date, sort lcolor(green) lwidth(medium) lpattern(dash)) /// 8 Lebanon
(line DayINFFOREA02S01LBY date, sort lcolor(green) lwidth(medium) lpattern(dot)) /// 9 Libya
(line DayINFFOREA02S01OMN date, sort lcolor(gold) lwidth(medium) lpattern(dash)) /// 10 Oman
(line DayINFFOREA02S01PAK date, sort lcolor(gold) lwidth(medium) lpattern(dot)) /// 11 Pakistan
(line DayINFFOREA02S01PSE date, sort lcolor(magenta) lwidth(medium) lpattern(solid)) /// 12 Palestine
(line DayINFFOREA02S01QAT date, sort lcolor(magenta) lwidth(medium) lpattern(dash)) /// 13 Qatar
(line DayINFFOREA02S01SAU date, sort lcolor(magenta) lwidth(medium) lpattern(dot)) /// 14 Saudi Arabia
(line DayINFFOREA02S01SOM date, sort lcolor(orange) lwidth(medium) lpattern(solid)) /// 15 Somalia
(line DayINFFOREA02S01SDN date, sort lcolor(orange) lwidth(medium) lpattern(dash)) /// 16 Sudan
(line DayINFFOREA02S01SYR date, sort lcolor(orange) lwidth(medium) lpattern(dot)) /// 17 Syria
(line DayINFFOREA02S01TUN date, sort lcolor(purple) lwidth(medium) lpattern(solid)) /// 18 Tunisia
(line DayINFFOREA02S01ARE date, sort lcolor(purple) lwidth(medium) lpattern(dash)) /// 19 United Arab Emirates
(line DayINFFOREA02S01YEM date, sort lcolor(purple) lwidth(medium) lpattern(dot)) /// 20 Yemen
(line DayINFFOREA02S01IRN date, sort lcolor(cyan) lwidth(thick) lpattern(solid)) /// 21 Iran
if date >= td(03jun2022) & date <= td(01oct2022) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported infections) title("COVID-19 daily reported infections, EMRO countries, IHME, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(21 "Iran" 1 "AFG" 2 "BHR" 3 "DJI" 4 "EGY" 5 "IRQ" 6 "JOR" 7 "KWT" ///
8 "LBN" 9 "LBY" 10 "OMN" 11 "PAK" 12 "PSE" 13 "QAT" 14 "SAU" 15 "SOM" 16 "SDN" ///
17 "SYR" 18 "TUN" 19 "ARE" 20 "YEM") size(small) row(3)) ///
subtitle("Without extremes: EMR total and Morocco. Forecast only. Smoothed", size(small))

graph export "graph 1111 c COVID-19 daily infections, EMRO countries, IHME, 2022 on.pdf", replace









****************************

* daily infections, IHME, 2022 on, EMRO countries, Forecast only = 03jun2022 on

* Without extremes: EMR total, Morocco, Pakistan, Sudan, Afghanistan, United Arab Emirates.

twoway ///
(line DayINFFOREA02S01BHR date, sort lcolor(brown) lwidth(medium) lpattern(dash)) /// 1 Bahrain
(line DayINFFOREA02S01DJI date, sort lcolor(brown) lwidth(medium) lpattern(dot)) /// 2 Djibouti 
(line DayINFFOREA02S01EGY date, sort lcolor(blue) lwidth(medium) lpattern(solid)) /// 3 Egypt
(line DayINFFOREA02S01IRQ date, sort lcolor(blue) lwidth(medium) lpattern(dash)) /// 4 Iraq
(line DayINFFOREA02S01JOR date, sort lcolor(blue) lwidth(medium) lpattern(dot)) /// 5 Jordan
(line DayINFFOREA02S01KWT date, sort lcolor(green) lwidth(medium) lpattern(solid)) /// 6 Kuwait
(line DayINFFOREA02S01LBN date, sort lcolor(green) lwidth(medium) lpattern(dash)) /// 7 Lebanon
(line DayINFFOREA02S01LBY date, sort lcolor(green) lwidth(medium) lpattern(dot)) /// 8 Libya
(line DayINFFOREA02S01OMN date, sort lcolor(gold) lwidth(medium) lpattern(dash)) /// 9 Oman
(line DayINFFOREA02S01PSE date, sort lcolor(magenta) lwidth(medium) lpattern(solid)) /// 10 Palestine
(line DayINFFOREA02S01QAT date, sort lcolor(magenta) lwidth(medium) lpattern(dash)) /// 11 Qatar
(line DayINFFOREA02S01SAU date, sort lcolor(magenta) lwidth(medium) lpattern(dot)) /// 12 Saudi Arabia
(line DayINFFOREA02S01SOM date, sort lcolor(orange) lwidth(medium) lpattern(solid)) /// 13 Somalia
(line DayINFFOREA02S01SYR date, sort lcolor(orange) lwidth(medium) lpattern(dot)) /// 14 Syria
(line DayINFFOREA02S01TUN date, sort lcolor(purple) lwidth(medium) lpattern(solid)) /// 15 Tunisia
(line DayINFFOREA02S01YEM date, sort lcolor(purple) lwidth(medium) lpattern(dot)) /// 16 Yemen
(line DayINFFOREA02S01IRN date, sort lcolor(cyan) lwidth(thick) lpattern(solid)) /// 17 Iran
if date >= td(03jun2022) & date <= td(01oct2022) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported infections) title("COVID-19 daily reported infections, EMRO countries, IHME, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(17 "Iran" 1 "BHR" 2 "DJI" 3 "EGY" 4 "IRQ" 5 "JOR" 6 "KWT" ///
7 "LBN" 8 "LBY" 9 "OMN" 10 "PSE" 11 "QAT" 12 "SAU" 13 "SOM" ///
14 "SYR" 15 "TUN" 16 "YEM") size(small) row(3)) ///
subtitle("Without extremes: EMR total, MAR, PAK, SDN, AFG, ARE. Forecast only. Smoothed", size(small))

graph export "graph 1111 d COVID-19 daily infections, EMRO countries, IHME, 2022 on.pdf", replace












************

* restore native scheme (of the local machine)

set scheme $nativescheme

di c(scheme)


view "log country merge.smcl"

log close

exit, clear


