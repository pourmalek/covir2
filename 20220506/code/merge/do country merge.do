
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


* SRIV not included in graphs due to highly implausibly high estimates. 


/* 

List of component studies:

JOHN A00

DELP A01
IHME A02
IMPE A03
LANL A04 // The LANL COVID-19 Team made its last real-time forecast on September 27th, 2021. [for 20210926]. This is more than two weeks old and will not be used. 
SRIV A05 

WHO	 A06 * 
* Global excess deaths associated with COVID-19 (modelled estimates) 
* Most recent update: 5 May 2022
* Temporal coverage	1 January 2020 - 31 December 2021
* Source web page:
* https://www.who.int/data/sets/global-excess-deaths-associated-with-covid-19-modelled-estimates

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



* IMPE

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/IMPE/country IMPE.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\IMPE\country IMPE.dta"

drop _merge



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




* WHO

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/WHO/country WHO.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\WHO\country WHO.dta"

drop _merge


* 

label var loc_grand_name "Location"







*************************************


* cases or infections to deaths ratio


gen DayCTDMeRaA00S00 =  DayCasMeRaA00S00 / DayDeaMeRaA00S00

label var DayCTDMeRaA00S00  "Daily Cases to Deaths S0 JOHN"

gen TotCTDMeRaA00S00 =  TotCasMeRaA00S00 / TotDeaMeRaA00S00

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




gen DayCTDMeRaA05S00  = DayCasMeRaA05S00  / DayDeaMeRaA05S00   

label var DayCTDMeRaA05S00  "Daily Cases to Deaths S0 SRIV"

gen TotCTDMeRaA05S00  = TotCasMeRaA05S00  / TotDeaMeRaA05S00   

label var TotCTDMeRaA05S00  "Total Cases to Deaths S0 SRIV"






***********************

* daily deaths estimated to reported  

    
gen DayDERMeRaA00S00 = DayDeaMeRaA00S00 / DayDeaMeRaA00S00

label var DayDERMeRaA00S00 "Daily Deaths estim to reported JOHN = 1" 


gen DayDERMeRaA01S00 = DayDeaMeRaA01S00 / DayDeaMeRaA00S00

label var DayDERMeRaA01S00 "Daily Deaths estim to reported Mean DELP S0"




gen DayDERMeRaA02S01 = DayDeaMeSmA02S01 / DayDeaMeRaA00S00

label var DayDERMeRaA02S01 "Daily Deaths estim to reported Mean not smoothed IHME S1"


gen DayDERMeRaA02S02 = DayDeaMeSmA02S02 / DayDeaMeRaA00S00

label var DayDERMeRaA02S02 "Daily Deaths estim to reported Mean not smoothed IHME S2"




gen DayDERMeRaA03S01 = DayDeaMeRaA03S01 / DayDeaMeRaA00S00

label var DayDERMeRaA03S01 "Daily Deaths estim to reported Mean S1 IMPE"


gen DayDERMeRaA03S02 = DayDeaMeRaA03S02 / DayDeaMeRaA00S00

label var DayDERMeRaA03S02 "Daily Deaths estim to reported Mean S2 IMPE"


gen DayDERMeRaA03S03 = DayDeaMeRaA03S03 / DayDeaMeRaA00S00

label var DayDERMeRaA03S03 "Daily Deaths estim to reported Mean S3 IMPE"



gen DayDERMeRaA05S00  = DayDeaMeRaA05S00 / DayDeaMeRaA00S00

label var DayDERMeRaA05S00 "Daily Deaths estim to reported S0 SRIV"







* daily cases or infections estimated to reported  


gen DayCERMeRaA00S00 = DayCasMeRaA00S00 / DayCasMeRaA00S00

label var DayCERMeRaA00S00 "Daily Cases estim to reported JOHN = 1" 



gen DayCERMeRaA01S00 = DayCasMeRaA01S00 / DayCasMeRaA00S00

label var DayCERMeRaA01S00 "Daily Cases estim to reported Mean DELP S0"






gen DayIERMeRaA02S01 = DayINFMeSmA02S01 / DayCasMeRaA00S00

label var DayIERMeRaA02S01 "Daily Infections estim to reported Mean not smoothed IHME S1"


gen DayIERMeRaA02S02 = DayINFMeSmA02S02 / DayCasMeRaA00S00

label var DayIERMeRaA02S02 "Daily Infections estim to reported Mean not smoothed IHME S2"



gen DayIERMeRaA03S01 = DayINFMeRaA03S01 / DayCasMeRaA00S00

label var DayIERMeRaA03S01 "Daily Infections estim to reported Mean S1 IMPE"


gen DayIERMeRaA03S02 = DayINFMeRaA03S02 / DayCasMeRaA00S00

label var DayIERMeRaA03S02 "Daily Infections estim to reported Mean S2 IMPE"


gen DayIERMeRaA03S03 = DayINFMeRaA03S03 / DayCasMeRaA00S00

label var DayIERMeRaA03S03 "Daily Infections estim to reported Mean S3 IMPE"


gen DayCERMeRaA05S00  = DayCasMeRaA05S00 / DayCasMeRaA00S00

label var DayCERMeRaA05S00 "Daily Cases estim to reported S0 SRIV"







* Total deaths estimated to reported  


gen TotDERMeRaA00S00 = TotDeaMeRaA00S00 / TotDeaMeRaA00S00

label var TotDERMeRaA00S00 "Total Deaths estim to reported JOHN = 1" 



gen TotDERMeRaA01S00 = TotDeaMeRaA01S00 / TotDeaMeRaA00S00

label var TotDERMeRaA01S00 "Total Deaths estim to reported Mean DELP S0"



gen TotDERMeRaA02S01 = TotDeaMeSmA02S01 / TotDeaMeRaA00S00

label var TotDERMeRaA02S01 "Total Deaths estim to reported Mean not smoothed IHME S1"


gen TotDERMeRaA02S02 = TotDeaMeSmA02S02 / TotDeaMeRaA00S00

label var TotDERMeRaA02S02 "Total Deaths estim to reported Mean not smoothed IHME S2"




gen TotDERMeRaA03S01 = TotDeaMeRaA03S01 / TotDeaMeRaA00S00

label var TotDERMeRaA03S01 "Total Deaths estim to reported Mean S1 IMPE"


gen TotDERMeRaA03S02 = TotDeaMeRaA03S02 / TotDeaMeRaA00S00

label var TotDERMeRaA03S02 "Total Deaths estim to reported Mean S2 IMPE"


gen TotDERMeRaA03S03 = TotDeaMeRaA03S03 / TotDeaMeRaA00S00

label var TotDERMeRaA03S03 "Total Deaths estim to reported Mean S3 IMPE"


gen TotDERMeRaA05S00  = TotDeaMeRaA05S00 / TotDeaMeRaA00S00

label var TotDERMeRaA05S00 "Total Deaths estim to reported S0 SRIV"







* Total cases or infections estimated to reported  


gen TotCERMeRaA00S00 = TotCasMeRaA00S00 / TotCasMeRaA00S00

label var TotCERMeRaA00S00 "Total Cases estim to reported JOHN = 1" 


gen TotCERMeRaA01S00 = TotCasMeRaA01S00 / TotCasMeRaA00S00

label var TotCERMeRaA01S00 "Total Cases estim to reported Mean DELP S0"



gen TotIERMeRaA02S01 = TotINFMeSmA02S01 / TotCasMeRaA00S00

label var TotIERMeRaA02S01 "Total Infections estim to reported Mean not smoothed IHME S1"


gen TotIERMeRaA02S02 = TotINFMeSmA02S02 / TotCasMeRaA00S00

label var TotIERMeRaA02S02 "Total Infections estim to reported Mean not smoothed IHME S2"




gen TotIERMeRaA03S01 = TotINFMeRaA03S01 / TotCasMeRaA00S00

label var TotIERMeRaA03S01 "Total Infections estim to reported Mean S1 IMPE"


gen TotIERMeRaA03S02 = TotINFMeRaA03S02 / TotCasMeRaA00S00

label var TotIERMeRaA03S02 "Total Infections estim to reported Mean S2 IMPE"


gen TotIERMeRaA03S03 = TotINFMeRaA03S03 / TotCasMeRaA00S00

label var TotIERMeRaA03S03 "Total Infections estim to reported Mean S3 IMPE"



gen TotCERMeRaA05S00  = TotCasMeRaA05S00 / TotCasMeRaA00S00

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
(line DayDeaMeRaA00S00 date, sort lcolor(black) lwidth(medium)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
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
(line DayCasMeRaA00S00 date, sort lcolor(black) lwidth(medium)) /// 1 "JOHN raw"
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
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
(line DayDeaMeRaA00S00 date, sort lcolor(black) lwidth(medium)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
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
(line DayCasMeRaA00S00 date, sort lcolor(black) lwidth(medium)) /// 1 "JOHN raw"
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
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
(line DayDeaMeSmA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN smooth"
(line DayDeaFOREA01S00 date, sort lcolor(red) lpattern(tight_dot) lwidth(vthick)) /// 2 "DELP" Forecast only
(line DayDeaMeSmA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayDeaFOREA02S01 date, sort lcolor(black) lpattern(tight_dot) lwidth(vthick)) /// 4 "IHME" Forecast only
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 5 "IHME"
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lpattern(dash)) /// 6 "IHME" Excess
(line DayDeaFOREA03S02 date, sort lcolor(magenta)) /// 7 "IMPE" Forecast only
(line DayDeaMeSmA03S02 date, sort lcolor(magenta)) /// 8 "IMPE"
(line DayDeaFOREA05S00 date, sort lcolor(green) lpattern(tight_dot) lwidth(vthick)) /// 9 "SRIV" Forecast only
(line DayDeaMeSmA05S00 date, sort lcolor(green)) /// 10 "SRIV"
(line DayDeXMeSmA06S00 date, sort lcolor(gold)) /// 11 "WHO" Excess
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 3 "DELP" 5 "IHME" 6 "IHME excess" 8 "IMPE" 10 "SRIV" 11 "WHO excess") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) 

graph export "graph 11 COVID-19 daily deaths, $country, reference scenarios, all time.pdf", replace



****
* daily deaths, reference scenario, 2021

twoway ///
(line DayDeaMeSmA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN smooth"
(line DayDeaFOREA01S00 date, sort lcolor(red) lpattern(tight_dot) lwidth(vthick)) /// 2 "DELP" Forecast only
(line DayDeaMeSmA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayDeaFOREA02S01 date, sort lcolor(black) lpattern(tight_dot) lwidth(vthick)) /// 4 "IHME" Forecast only
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 5 "IHME"
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lpattern(dash)) /// 6 "IHME" Excess
(line DayDeaFOREA03S02 date, sort lcolor(magenta) lpattern(tight_dot) lwidth(vthick)) /// 7 "IMPE" Forecast only
(line DayDeaMeSmA03S02 date, sort lcolor(magenta)) /// 8 "IMPE"
(line DayDeaFOREA05S00 date, sort lcolor(green) lpattern(tight_dot) lwidth(vthick)) /// 9 "SRIV" Forecast only
(line DayDeaMeSmA05S00 date, sort lcolor(green)) /// 10 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 3 "DELP" 5 "IHME" 6 "IHME excess" 8 "IMPE" 10 "SRIV") size(small) rows(1)) ///
subtitle("2021 on, reference scenarios", size(small)) ///
note("Reference scenario forecasts are marked with |||||||||||| " , size(small))  

graph export "graph 12 COVID-19 daily deaths, $country, reference scenarios.pdf", replace




****
* daily deaths, reference scenario, 2021, CI

twoway ///
(line DayDeaMeSmA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN smooth"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayDeaLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayDeaUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" upper
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line DayDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line DayDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line DayDeaLoSmA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line DayDeaUpSmA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 11 SRIV mean
(line DayDeaLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 12 SRIV lower
(line DayDeaUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 13 SRIV upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid)  ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "SRIV") size(small) row(1)) ///
subtitle("2021 on, reference scenarios with uncertainty", size(small)) ///
note("Uncertainty limits: dashed curves", size(small))

graph export "graph 13 COVID-19 daily deaths, $country, reference scenarios, CI.pdf", replace




****
* daily deaths, reference scenario with uncertainty, IHME, 2021 

twoway ///
(line DayDeaMeSmA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN smooth"
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
(line DayDeaMeSmA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1
(line DayDeaFOREA02S01 date, sort lcolor(black*0.6) lpattern(tight_dot) lwidth(vthick)) /// 2 "IHME" Forecast only
(line DayDeaMeSmA02S01 date, sort lcolor(black) lwidth(medthick)) /// 3 "IHME" 
(line DayDeaMeSmA02S02 date, sort lcolor(blue)) /// 4
(line DayDeaMeSmA02S03 date, sort lcolor(green)) /// 5
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, $country, IHME, all scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 3 "IHME Reference" 4 "IHME Masks" 5 "IHME Third dose") rows(1)) ///
note("Reference scenario forecasts are marked with |||||||||||| " , size(small))

graph export "graph 15 COVID-19 daily deaths, $country, all scenarios, IHME.pdf", replace



****
* daily deaths, reference scenario with uncertainty, IMPE, 2021

twoway ///
(line DayDeaMeSmA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN smooth"
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
(line DayDeaMeSmA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN smooth"
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



***********************

* daily cases or infections (graph numbers start with 21)

twoway ///
(line DayCasMeSmA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN"
(line DayCasFOREA01S00 date, sort lcolor(red) lpattern(tight_dot) lwidth(vthick)) /// 2 "DELP" Forecast only
(line DayCasMeSmA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayINFFOREA02S01 date, sort lcolor(black) lpattern(tight_dot) lwidth(vthick)) /// 4 "IHME" Forecast only
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 5 "IHME"
(line DayINFFOREA03S02 date, sort lcolor(magenta) lpattern(tight_dot) lwidth(vthick)) /// 6 "IMPE" Forecast only
(line DayINFMeSmA03S02 date, sort lcolor(magenta)) /// 7 "IMPE"
(line DayCasFOREA05S00 date, sort lcolor(green) lpattern(tight_dot) lwidth(vthick)) /// 8 "SRIV" Forecast only
(line DayCasMeSmA05S00 date, sort lcolor(green)) /// 9 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid)  ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 3 "DELP cases" 5 "IHME infections" 7 "IMPE infections" 9 "SRIV cases") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) ///
note("Reference scenario forecasts are marked with |||||||||||| " , size(small))

graph export "graph 21 COVID-19 daily cases, $country, reference scenarios, all time.pdf", replace




****
* daily cases or infections, reference scenario, 2021

twoway ///
(line DayCasMeSmA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN"
(line DayCasFOREA01S00 date, sort lcolor(red) lpattern(tight_dot) lwidth(vthick)) /// 2 "DELP" Forecast only
(line DayCasMeSmA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayINFFOREA02S01 date, sort lcolor(black) lpattern(tight_dot) lwidth(vthick)) /// 4 "IHME" Forecast only
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 5 "IHME"
(line DayINFFOREA03S02 date, sort lcolor(magenta) lpattern(tight_dot) lwidth(vthick)) /// 6 "IMPE" Forecast only
(line DayINFMeSmA03S02 date, sort lcolor(magenta)) /// 7 "IMPE"
(line DayCasFOREA05S00 date, sort lcolor(green) lpattern(tight_dot) lwidth(vthick)) /// 8 "SRIV" Forecast only
(line DayCasMeSmA05S00 date, sort lcolor(green)) /// 9 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid)  ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 3 "DELP cases" 5 "IHME infections" 7 "IMPE infections" 9 "SRIV cases") size(small) row(2)) ///
subtitle("2021 on, reference scenarios", size(small)) ///
note("Reference scenario forecasts are marked with |||||||||||| " , size(small))

graph export "graph 22 COVID-19 daily cases, $country, reference scenarios.pdf", replace



****
* daily cases, reference scenario, 2021

twoway ///
(line DayCasMeSmA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN"
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
* daily cases or infections, reference scenarios, 2021, CI

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 JOHN
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" upper
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line DayINFLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line DayINFUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line DayINFMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line DayINFLoSmA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line DayINFUpSmA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 11 SRIV mean
(line DayCasLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 12 SRIV lower
(line DayCasUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 13 SRIV upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 5 "IHME infections" 8 "IMPE infections" ///
11 "SRIV cases") size(small) row(2)) /// 
subtitle("2021 on, reference scenarios with uncertainty", size(small)) ///

graph export "graph 23 COVID-19 daily cases, $country, reference scenarios, CI.pdf", replace



****
* daily cases or infections, full scenarios, with uncertainty, 2021

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 JOHN
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" upper
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 5 IHME reference mean
(line DayINFLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME reference lower
(line DayINFUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME reference upper
(line DayINFMeSmA02S02 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 8 IHME better mean
(line DayINFMeRaA03S02 date, sort lcolor(magenta)) /// 9 IMPE reference mean
(line DayINFLoSmA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE reference lower
(line DayINFUpSmA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 11 IMPE reference upper
(line DayINFMeRaA03S01 date, sort lcolor(magenta) lwidth(thick) lpattern(tight_dot)) /// 12 IMPE better mean
(line DayINFMeRaA03S03 date, sort lcolor(magenta) lwidth(thick) lpattern(tight_dot)) /// 13 IMPE worse mean
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 14 SRIV mean
(line DayCasLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 15 SRIV lower
(line DayCasUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 16 SRIV upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 5 "IHME reference, mean" 6 "IHME ref, uncertainty" 8 "IHME better" ///
9 "IMPE reference, mean " 10 "IMPE ref, uncertainty" 12 "IMPE better and worse" ///
14 "SRIV ref, mean") size(small) row(4)) ///
subtitle("2021 on, full scenarios, with uncertainty; IHME & IMPE: infections", size(small))

graph export "graph 23 COVID-19 daily cases, $country, full scenarios, CI.pdf", replace



****
* daily infections, reference scenario with uncertainty, IHME, 2021

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 JOHN
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
legend(order(1 "Reference" 2 "Masks" 3 "Third dose") size(small) rows(1))

graph export "graph 25 1 COVID-19 daily cases, $country, all scenarios, IHME.pdf", replace



****
* daily infections, reference scenario with uncertainty, IMPE, 2021

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 JOHN
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
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 JOHN
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




****
* daily estimated infections to reported cases IHME, IMPE, all time


gen DayITCMeSmA02S01 =  DayINFMeSmA02S01 / DayCasMeRaA00S00

label var DayITCMeSmA02S01  "Daily Infections IHME to cases JOHN"

gen DayITCMeRaA03S02 =  DayINFMeRaA03S02 / DayCasMeRaA00S00

label var DayITCMeRaA03S02  "Daily Infections IMPE to cases JOHN"


twoway ///
(line DayITCMeSmA02S01 date, sort lcolor(black)) /// 1 "IHME"
(line DayITCMeRaA03S02 date, sort lcolor(magenta)) /// 2 "IMPE"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily estimated infections to reported cases) title("COVID-19 daily estimated infections to reported cases, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME" 2 "IMPE" 3) size(small) row(1)) ///
subtitle("reference scenarios", size(small)) 

graph export "graph 28 C19 daily estimated infections to reported cases, $country, reference scenarios.pdf", replace




****
* daily estimated infections to reported cases IHME, IMPE, 2021


* smooth Infections to cases ratio of IHME and IMPE

tsset date, daily   


foreach var of varlist ///
DayITCMeSmA02S01 DayITCMeRaA03S02 {


tssmooth ma `var'_window = `var', window(3 1 3)

tssmooth ma `var'sm = `var'_window, weights( 1 2 3 <4> 3 2 1) replace

drop `var'_window

}
*

tsset, clear

ssc install labutil2

labvars DayITCMeSmA02S01sm DayITCMeRaA03S02sm ,names

          
qui summ DayITCMeSmA02S01sm if date >= td(01jan2021) , detail

gen DayITCMeSmA02S01sm_median = r(p50)

replace DayITCMeSmA02S01sm_median = round(DayITCMeSmA02S01sm_median)

local DayITCMeSmA02S01sm_median = DayITCMeSmA02S01sm_median


qui summ DayITCMeRaA03S02sm if date >= td(01jan2021) , detail

gen DayITCMeRaA03S02sm_median = r(p50)

replace DayITCMeRaA03S02sm_median = round(DayITCMeRaA03S02sm_median)

local DayITCMeRaA03S02sm_median = DayITCMeRaA03S02sm_median

twoway ///
(line DayITCMeSmA02S01 date, sort lcolor(black*0.2)) /// 1 "IHME"
(line DayITCMeRaA03S02 date, sort lcolor(magenta*0.2)) /// 2 "IMPE"
(line DayITCMeSmA02S01sm date, sort lcolor(black) lwidth(thick)) /// 3 "IHME"
(line DayITCMeRaA03S02sm date, sort lcolor(magenta) lwidth(thick)) /// 4 "IMPE"
(line DayITCMeSmA02S01sm_median date, sort lcolor(black) lwidth(thin) lpattern(dash)) /// 5 "IHME"
(line DayITCMeRaA03S02sm_median date, sort lcolor(magenta) lwidth(thin) lpattern(dash)) /// 6 "IMPE"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily estimated infections to reported cases) title("COVID-19 daily estimated infections to reported cases, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME" 2 "IMPE" 3 "IHME smooth" 4 "IMPE smooth" 5 "IHME smooth meadian" 6 "IMPE smooth meadian") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) ///
note("IHME smooth median 2021 on = `DayITCMeSmA02S01sm_median'; IMPE smooth median 2021 on = `DayITCMeRaA03S02sm_median'")

graph export "graph 29 C19 daily estimated infections to reported cases, $country, reference scenarios 2021.pdf", replace






*****************

* total deaths (graph numbers start with 31)


****
* total deaths, reference scenario, all time

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small)) 

graph export "graph 31a COVID-19 total deaths, $country, reference scenarios, all time.pdf", replace



****
* total deaths, reference scenario, all time, with IHME excess mortality 

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeXMeSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 4 "IHME excess"
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 5 "IMPE"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IHME excess" 5 "IMPE" 6 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small)) 

graph export "graph 31b COVID-19 total deaths, $country, reference scenarios, all time.pdf", replace



****
* total deaths, reference scenario, 2021

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "SRIV") size(small) row(1)) ///
subtitle("2021 on, reference scenarios", size(small)) 

graph export "graph 32a COVID-19 total deaths, $country, reference scenarios.pdf", replace



****
* total deaths, reference scenario, 2021, with IHME excess mortality 

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeXMeSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 4 "IHME excess"
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 5 "IMPE"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IHME excess" 5 "IMPE" 6 "SRIV") size(small) row(1)) ///
subtitle("2021 on, reference scenarios", size(small)) 

graph export "graph 32b COVID-19 total deaths, $country, reference scenarios.pdf", replace



****
* total deaths, reference scenario, CI, 2021

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 JOHN
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 DELP mean
(line TotDeaLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 DELP lower
(line TotDeaUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 DELP upper
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line TotDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line TotDeaLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line TotDeaUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 11 SRIV mean
(line TotDeaLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 12 SRIV lower
(line TotDeaUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 13 SRIV upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves") ///
subtitle("2021 on, reference scenarios with uncertainty", size(small)) 

graph export "graph 33 COVID-19 total deaths, $country, reference scenarios, CI.pdf", replace




*****************

* total cases or infections (graph numbers start with 41)


****
* total cases or infections, reference scenario, all time

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotINFMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotINFMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" ///
5 "SRIV cases") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) 

graph export "graph 41 COVID-19 total cases, $country, reference scenarios, all time.pdf", replace



****
* total cases or infections, reference scenario, 2021

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotINFMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotINFMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" ///
5 "SRIV cases") size(small) row(2)) ///
subtitle("2021 on, reference scenarios", size(small)) 

graph export "graph 42 COVID-19 total cases, $country, reference scenarios.pdf", replace



****
* total cases or infections, reference scenario, CI, 2021

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 JOHN
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP"
(line TotCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP"
(line TotINFMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line TotINFLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotINFUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line TotINFMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line TotINFLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line TotINFUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 8 SRIV mean
(line TotCasLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 9 SRIV lower
(line TotCasUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 10 SRIV upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 5 "IHME infections" 8 "IMPE infections" ///
8 "SRIV cases") size(small) row(2)) ///
subtitle("2021 on, reference scenarios with uncertainty", size(small)) ///
note("Uncertainty limits: dashed curves")

graph export "graph 43 COVID-19 total cases, $country, reference scenarios, CI.pdf", replace



****************

* daily CFR / IFR (graph numbers start with 51)


****
* CFR / IFR all studies, all time, reference scenarios, all time

twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN"
(line DayCfrMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line infection_fatality_A02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayIFRMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCfrMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR or IFR) title("COVID-19 daily CFR or IFR, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN CFR" 2 "DELP CFR" 3 "IHME IFR" 4 "IMPE IFR" 5 "SRIV CFR") size(small) row(2)) ///
subtitle("reference scenarios", size(small) color(white))

graph export "graph 51 COVID-19 daily CFR, $country, reference scenarios, all time.pdf", replace



****
* cfr all studies, reference scenarios, 2021

twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN"
(line DayCfrMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line infection_fatality_A02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayIFRMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCfrMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR or IFR) title("COVID-19 daily CFR or IFR, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN CFR" 2 "DELP CFR" 3 "IHME IFR" 4 "IMPE IFR" 5 "SRIV CFR") size(small) row(2)) ///
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
(line DayHodMeRaA03S01 date, sort lcolor(magenta)) /// 6 IMPE Hosp demand (Daily hospital demand Mean A03 S01 )
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 7 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME Bed need" 4 "IHME ICU need" ///
5 "IHME Admissions" 6 "IMPE Hosp demand" ///
7 "IMPE ICU demand") rows(4) size(small)) ///
subtitle("reference scenarios", size(small) color(white)) 

graph export "graph 71a COVID-19 hospital-related outcomes, all time.pdf", replace

* ICU new of IHME retired




* all hospital-related outcomes, all time

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red) lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayBedMeSmA02S01 date, sort lcolor(black)) /// 3 IHME Bed need (Daily Beds needed Mean IHME S1)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 4 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 5 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayHodMeRaA03S01 date, sort lcolor(magenta)) /// 6 IMPE Hosp demand (Daily hospital demand Mean A03 S01 )
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 7 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
(line DayBEDMeSmA02    date, sort lcolor(black) lpattern(dash)) /// 8
(line DayICUMeSmA02    date, sort lcolor(cyan) lpattern(dash)) /// 9
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME Bed need" 4 "IHME ICU need" ///
5 "IHME Admissions" 6 "IMPE Hosp demand" ///
7 "IMPE ICU demand" 8 "IHME All bed capcity" 9 "IHME ICU bed capacity") rows(4) size(small)) ///
subtitle("reference scenarios", size(small) color(white)) 

graph export "graph 71b COVID-19 hospital-related outcomes, all time.pdf", replace






* daily hospital-related outcomes, DELP, IHME, IMPE, wo IHME Bed need, IMPE Hosp demand

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red) lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 3 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 4 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 5 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
(line DayICUMeSmA02    date, sort lcolor(cyan) lpattern(dash)) /// 6
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME ICU need" ///
4 "IHME Admissions" 5 "IMPE ICU demand" 6 "IHME All bed capcity") rows(3) size(small)) ///
subtitle("2021 on, without IHME Bed need, IMPE Hosp demand, reference scenarios", size(small)) ///
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
(line DayITDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCTDMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections to deaths) title("COVID-19 daily cases or infections, to deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV cases") size(small) row(2)) ///
subtitle("reference scenarios", size(small))

graph export "graph 81 COVID-19 daily cases to deaths, $country, reference scenarios, all time.pdf", replace



****
* Daily cases or infections to deaths (CTD / ITD) all studies, reference scenarios, 2021

twoway ///
(line DayCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(thick)) /// 1 "JOHN"
(line DayCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayITDMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayITDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCTDMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections to deaths) title("COVID-19 daily cases or infections, to deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV cases") size(small) row(2)) ///
subtitle("2021 on, reference scenarios", size(small))

graph export "graph 82 COVID-19 daily cases to deaths, $country, reference scenarios.pdf", replace



****
* Total cases to deaths (CTD / ITD) all studies, all time, reference scenarios, all time

twoway ///
(line TotCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotITDMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotITDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCTDMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections to deaths) title("COVID-19 total cases or infections, to deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV cases") size(small) row(2)) ///
subtitle("reference scenarios", size(small))

graph export "graph 83 COVID-19 total cases to deaths, $country, reference scenarios, all time.pdf", replace



****
* Total cases to deaths (CTD / ITD) all studies, reference scenarios, 2021

twoway ///
(line TotCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotITDMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotITDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCTDMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections to deaths) title("COVID-19 total cases or infections, to deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV cases") size(small) row(2)) ///
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
(line DayDERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths estimated to reported) title("COVID-19 daily deaths, estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

graph export "graph 91 COVID-19 daily deaths estimated to reported, $country, reference scenarios, all time.pdf", replace



****
* daily deaths estimated to reported (DER) all studies, reference scenarios, 2021

twoway ///
(line DayDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths estimated to reported) title("COVID-19 daily deaths, estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

graph export "graph 92 COVID-19 daily deaths estimated to reported, $country, reference scenarios.pdf", replace



* daily cases or infections estimated to reported cases


****
* daily cases or infections estimated to reported cases (CER / IER) all studies, reference scenarios, all time 

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayIERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections estimated to reported) title("COVID-19 daily cases estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(3)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV cases") size(small) row(2)) ///
subtitle("daily cases or infections estimated, to reported cases; reference scenarios", size(small))

graph export "graph 93 COVID-19 daily cases estimated to reported, $country, reference scenarios, all time .pdf", replace



****
* daily cases or infections estimated to reported cases (CER / IER) all studies, 2021-01-01 on, reference scenarios

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayIERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections estimated to reported) title("COVID-19 daily cases estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(3)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV cases") size(small) row(2)) ///
subtitle("daily cases or infections estimated, to reported cases; reference scenarios", size(small))

graph export "graph 94 COVID-19 daily cases estimated to reported, $country, reference scenarios.pdf", replace



****
* total deaths estimated to reported (DER) all studies, reference scenarios, all time

twoway ///
(line TotDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN
(line TotDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths estimated to reported) title("COVID-19 total deaths, estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(5)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

graph export "graph 95 COVID-19 total deaths estimated to reported, $country, reference scenarios, all time.pdf", replace



****
* total deaths estimated to reported (DER) all studies, reference scenarios, 2021

twoway ///
(line TotDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN
(line TotDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths estimated to reported) title("COVID-19 total deaths, estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(5)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

graph export "graph 96 COVID-19 total deaths estimated to reported, $country, reference scenarios.pdf", replace



****
* total cases or infections or infections estimated to reported cases (CER / IER) all studies, reference scenarios, all time

twoway ///
(line TotCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotIERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotIERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections estimated to reported) title("COVID-19 total cases estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(5)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV cases") size(small) row(2)) ///
subtitle("total cases or infections estimated, to reported cases; reference scenarios", size(small))

graph export "graph 97 COVID-19 total cases estimated to reported, $country, reference scenarios.pdf", replace



****
* total cases or infections or infections estimated to reported cases (CER / IER) all studies, reference scenarios, 2021

twoway ///
(line TotCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotIERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotIERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections estimated to reported) title("COVID-19 total cases estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(5)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV cases") size(small) row(2)) ///
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





************

* restore native scheme (of the local machine)

set scheme $nativescheme

di c(scheme)


view "log country merge.smcl"

log close

exit, clear


