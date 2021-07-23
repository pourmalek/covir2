
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
LANL A04
SRIV A05

*/



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



* LANL

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/LANL/country LANL.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\LANL\country LANL.dta"

drop _merge


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


gen DayCTDMeRaA00S00 =  DayCasMeRaA00S00 / DayDeaMeRaA00S00

label var DayCTDMeRaA00S00  "Daily Cases to Deaths S0 JOHN"

gen TotCTDMeRaA00S00 =  TotCasMeRaA00S00 / TotDeaMeRaA00S00

label var TotCTDMeRaA00S00  "Total Cases to Deaths S0 JOHN"




gen DayCTDMeRaA01S00 =  DayCasMeRaA01S00 / DayDeaMeRaA01S00

label var DayCTDMeRaA01S00  "Daily Cases to Deaths S0 DELP"

gen TotCTDMeRaA01S00 =  TotCasMeRaA01S00 / TotDeaMeRaA01S00

label var TotCTDMeRaA01S00  "Total Cases to Deaths S0 DELP"  





gen DayITDMeRaA02S01  =  DayINFMeRaA02S01  / DayDeaMeRaA02S01 

label var DayITDMeRaA02S01   "Daily Infections to Deaths S1 IHME"

gen TotITDMeRaA02S01  =  TotINFMeRaA02S01  / TotDeaMeRaA02S01 

label var TotITDMeRaA02S01   "Total Infections to Deaths S1 IHME"




gen DayITDMeRaA02S02 = DayINFMeRaA02S02 / DayDeaMeRaA02S02  

label var DayITDMeRaA02S02 "Daily Infections to Deaths S2 IHME"

gen TotITDMeRaA02S02 = TotINFMeRaA02S02 / TotDeaMeRaA02S02  

label var TotITDMeRaA02S02 "Total Infections to Deaths S2 IHME"




gen DayITDMeRaA02S03  = DayINFMeRaA02S03  / DayDeaMeRaA02S03   

label var DayITDMeRaA02S03  "Daily Infections to Deaths S3 IHME"

gen TotITDMeRaA02S03  = TotINFMeRaA02S03  / TotDeaMeRaA02S03   

label var TotITDMeRaA02S03  "Total Infections to Deaths S3 IHME"






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





gen DayCTDMeRaA04S00  = DayCasMeRaA04S00  / DayDeaMeRaA04S00   

label var DayCTDMeRaA04S00  "Daily Cases to Deaths S0 LANL"

gen TotCTDMeRaA04S00  = TotCasMeRaA04S00  / TotDeaMeRaA04S00   

label var TotCTDMeRaA04S00  "Total Cases to Deaths S0 LANL"





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




gen DayDERMeRaA02S01 = DayDeaMeRaA02S01 / DayDeaMeRaA00S00

label var DayDERMeRaA02S01 "Daily Deaths estim to reported Mean not smoothed IHME S1"


gen DayDERMeRaA02S02 = DayDeaMeRaA02S02 / DayDeaMeRaA00S00

label var DayDERMeRaA02S02 "Daily Deaths estim to reported Mean not smoothed IHME S2"


gen DayDERMeRaA02S03 = DayDeaMeRaA02S03 / DayDeaMeRaA00S00

label var DayDERMeRaA02S03 "Daily Deaths estim to reported Mean not smoothed IHME S3"



gen DayDERMeRaA03S01 = DayDeaMeRaA03S01 / DayDeaMeRaA00S00

label var DayDERMeRaA03S01 "Daily Deaths estim to reported Mean S1 IMPE"


gen DayDERMeRaA03S02 = DayDeaMeRaA03S02 / DayDeaMeRaA00S00

label var DayDERMeRaA03S02 "Daily Deaths estim to reported Mean S2 IMPE"


gen DayDERMeRaA03S03 = DayDeaMeRaA03S03 / DayDeaMeRaA00S00

label var DayDERMeRaA03S03 "Daily Deaths estim to reported Mean S3 IMPE"



gen DayDERMeRaA04S00 = DayDeaMeRaA04S00 / DayDeaMeRaA00S00

label var DayDERMeRaA04S00 "Daily Deaths estim to reported to Deaths S0 LANL"



gen DayDERMeRaA05S00  = DayDeaMeRaA05S00 / DayDeaMeRaA00S00

label var DayDERMeRaA05S00 "Daily Deaths estim to reported S0 SRIV"







* daily cases or infections estimated to reported  


gen DayCERMeRaA00S00 = DayCasMeRaA00S00 / DayCasMeRaA00S00

label var DayCERMeRaA00S00 "Daily Cases estim to reported JOHN = 1" 



gen DayCERMeRaA01S00 = DayCasMeRaA01S00 / DayCasMeRaA00S00

label var DayCERMeRaA01S00 "Daily Cases estim to reported Mean DELP S0"






gen DayIERMeRaA02S01 = DayINFMeRaA02S01 / DayCasMeRaA00S00

label var DayIERMeRaA02S01 "Daily Infections estim to reported Mean not smoothed IHME S1"


gen DayIERMeRaA02S02 = DayINFMeRaA02S02 / DayCasMeRaA00S00

label var DayIERMeRaA02S02 "Daily Infections estim to reported Mean not smoothed IHME S2"


gen DayIERMeRaA02S03 = DayINFMeRaA02S03 / DayCasMeRaA00S00

label var DayIERMeRaA02S03 "Daily Infections estim to reported Mean not smoothed IHME S3"



gen DayIERMeRaA03S01 = DayINFMeRaA03S01 / DayCasMeRaA00S00

label var DayIERMeRaA03S01 "Daily Infections estim to reported Mean S1 IMPE"


gen DayIERMeRaA03S02 = DayINFMeRaA03S02 / DayCasMeRaA00S00

label var DayIERMeRaA03S02 "Daily Infections estim to reported Mean S2 IMPE"


gen DayIERMeRaA03S03 = DayINFMeRaA03S03 / DayCasMeRaA00S00

label var DayIERMeRaA03S03 "Daily Infections estim to reported Mean S3 IMPE"



gen DayCERMeRaA04S00 = DayCasMeRaA04S00 / DayCasMeRaA00S00

label var DayCERMeRaA04S00 "Daily Cases estim to reported to Cases S0 LANL"



gen DayCERMeRaA05S00  = DayCasMeRaA05S00 / DayCasMeRaA00S00

label var DayCERMeRaA05S00 "Daily Cases estim to reported S0 SRIV"







* Total deaths estimated to reported  


gen TotDERMeRaA00S00 = TotDeaMeRaA00S00 / TotDeaMeRaA00S00

label var TotDERMeRaA00S00 "Total Deaths estim to reported JOHN = 1" 



gen TotDERMeRaA01S00 = TotDeaMeRaA01S00 / TotDeaMeRaA00S00

label var TotDERMeRaA01S00 "Total Deaths estim to reported Mean DELP S0"



gen TotDERMeRaA02S01 = TotDeaMeRaA02S01 / TotDeaMeRaA00S00

label var TotDERMeRaA02S01 "Total Deaths estim to reported Mean not smoothed IHME S1"


gen TotDERMeRaA02S02 = TotDeaMeRaA02S02 / TotDeaMeRaA00S00

label var TotDERMeRaA02S02 "Total Deaths estim to reported Mean not smoothed IHME S2"


gen TotDERMeRaA02S03 = TotDeaMeRaA02S03 / TotDeaMeRaA00S00

label var TotDERMeRaA02S03 "Total Deaths estim to reported Mean not smoothed IHME S3"



gen TotDERMeRaA03S01 = TotDeaMeRaA03S01 / TotDeaMeRaA00S00

label var TotDERMeRaA03S01 "Total Deaths estim to reported Mean S1 IMPE"


gen TotDERMeRaA03S02 = TotDeaMeRaA03S02 / TotDeaMeRaA00S00

label var TotDERMeRaA03S02 "Total Deaths estim to reported Mean S2 IMPE"


gen TotDERMeRaA03S03 = TotDeaMeRaA03S03 / TotDeaMeRaA00S00

label var TotDERMeRaA03S03 "Total Deaths estim to reported Mean S3 IMPE"



gen TotDERMeRaA04S00 = TotDeaMeRaA04S00 / TotDeaMeRaA00S00

label var TotDERMeRaA04S00 "Total Deaths estim to reported to Deaths S0 LANL"



gen TotDERMeRaA05S00  = TotDeaMeRaA05S00 / TotDeaMeRaA00S00

label var TotDERMeRaA05S00 "Total Deaths estim to reported S0 SRIV"







* Total cases or infections estimated to reported  


gen TotCERMeRaA00S00 = TotCasMeRaA00S00 / TotCasMeRaA00S00

label var TotCERMeRaA00S00 "Total Cases estim to reported JOHN = 1" 


gen TotCERMeRaA01S00 = TotCasMeRaA01S00 / TotCasMeRaA00S00

label var TotCERMeRaA01S00 "Total Cases estim to reported Mean DELP S0"



gen TotIERMeRaA02S01 = TotINFMeRaA02S01 / TotCasMeRaA00S00

label var TotIERMeRaA02S01 "Total Infections estim to reported Mean not smoothed IHME S1"


gen TotIERMeRaA02S02 = TotINFMeRaA02S02 / TotCasMeRaA00S00

label var TotIERMeRaA02S02 "Total Infections estim to reported Mean not smoothed IHME S2"


gen TotIERMeRaA02S03 = TotINFMeRaA02S03 / TotCasMeRaA00S00

label var TotIERMeRaA02S03 "Total Infections estim to reported Mean not smoothed IHME S3"



gen TotIERMeRaA03S01 = TotINFMeRaA03S01 / TotCasMeRaA00S00

label var TotIERMeRaA03S01 "Total Infections estim to reported Mean S1 IMPE"


gen TotIERMeRaA03S02 = TotINFMeRaA03S02 / TotCasMeRaA00S00

label var TotIERMeRaA03S02 "Total Infections estim to reported Mean S2 IMPE"


gen TotIERMeRaA03S03 = TotINFMeRaA03S03 / TotCasMeRaA00S00

label var TotIERMeRaA03S03 "Total Infections estim to reported Mean S3 IMPE"



gen TotCERMeRaA04S00 = TotCasMeRaA04S00 / TotCasMeRaA00S00

label var TotCERMeRaA04S00 "Total Cases estim to reported to Cases S0 LANL"



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



******************



* daily deaths (graph numbers start with 11)


****
* daily deaths, reference scenario, all time


* adjust x axis ticks and avoid globals
forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
*
forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN smooth"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDeaMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01dec2019) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 11 COVID-19 daily deaths, $country, reference scenarios, all time.gph", replace
graph export "graph 11 COVID-19 daily deaths, $country, reference scenarios, all time.pdf", replace



****
* daily deaths, reference scenario, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN smooth"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDeaMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("after 2021-01-01, reference scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 12 COVID-19 daily deaths, $country, reference scenarios.gph", replace
graph export "graph 12 COVID-19 daily deaths, $country, reference scenarios.pdf", replace




****
* daily deaths, reference scenario, 2021, CI

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN smooth"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayDeaLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayDeaUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" upper
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line DayDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line DayDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line DayDeaLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line DayDeaUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line DayDeaMeRaA04S00 date, sort lcolor(gold)) /// 11 LANL mean
(line DayDeaLoRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL lower
(line DayDeaUpRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL upper
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 14 "SRIV" mean
(line DayDeaMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" lower
(line DayDeaMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid)  ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "LANL" 14 "SRIV") size(small) row(1)) ///
subtitle("after 2021-01-01, reference scenarios with uncertainty", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Uncertainty limits: dashed curves" ///
"- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 13 COVID-19 daily deaths, $country, reference scenarios, CI.gph", replace
graph export "graph 13 COVID-19 daily deaths, $country, reference scenarios, CI.pdf", replace




****
* daily deaths, reference scenario with uncertainty, IHME, 2021 

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(medthick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA02S01 date, sort lcolor(black)) /// 3 IHME reference mean
(line DayDeaLoRaA02S01 date, sort lcolor(green) lpattern(dash)) /// 4 IHME reference lower
(line DayDeaUpRaA02S01 date, sort lcolor(red) lpattern(dash)) /// 5 IHME reference upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IHME reference scenario, mean" ///
4 "IHME reference scenario, lower" 5 "IHME reference scenario, upper") size(small) row(3)) ///
subtitle("after 2021-01-01, reference scenario with uncertainty", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Uncertainty limits: dashed (– – –) curves" ///
"- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 14 COVID-19 daily deaths, $country, reference scenario with uncertainty, IHME.gph", replace
graph export "graph 14 COVID-19 daily deaths, $country, reference scenario with uncertainty, IHME.pdf", replace



****
* daily deaths, 3 scenarios, IHME, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(medthick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA02S01 date, sort lcolor(black)) /// 3 IHME reference mean
(line DayDeaMeRaA02S02 date, sort lcolor(green) lwidth(thick) lpattern(tight_dot)) /// 4 IHME better mean
(line DayDeaMeRaA02S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 5 IHME worse mean
(line DayDeaUpRaA02S03 date, sort lcolor(red) lpattern(dash)) /// 6 IHME worse upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IHME reference scenario, mean" 4 "IHME better scenario, mean" ///
5 "IHME worse scenario, mean" 6 "IHME worse scenario, upper uncertainty limit") size(small) row(3)) ///
subtitle("after 2021-01-01, 3 scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Better and worse scenarios: tight dot (|||||) curves; Uncertainty limits: dashed (– – –) curves." ///
"- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small)) 

graph save "graph 15 COVID-19 daily deaths, $country, 3 scenarios, IHME.gph", replace
graph export "graph 15 COVID-19 daily deaths, $country, 3 scenarios, IHME.pdf", replace



****
* daily deaths, reference scenario with uncertainty, IMPE, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA03S02 date, sort lcolor(black)) /// 3 IMPE reference mean
(line DayDeaLoRaA03S02 date, sort lcolor(green) lpattern(dash)) /// 4 IMPE reference lower
(line DayDeaUpRaA03S02 date, sort lcolor(red) lpattern(dash)) /// 5 IMPE reference upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IMPE reference scenario, mean" ///
4 "IMPE reference scenario, lower" 5 "IMPE sreference scenario, upper") size(small) row(3)) ///
subtitle("after 2021-01-01, reference scenario with uncertainty", size(small)) xline(22424, lcolor(red) lwidth(thick))  ///
note("- Uncertainty limits: dashed (– – –) curves." ///
"- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 16 COVID-19 daily deaths, $country, reference scenario with uncertainty, IMPE.gph", replace
graph export "graph 16 COVID-19 daily deaths, $country, reference scenario with uncertainty, IMPE.pdf", replace



****
* daily deaths, 3 scenarios, IMPE, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA03S02 date, sort lcolor(black)) /// 3 IMPE reference mean
(line DayDeaMeRaA03S01 date, sort lcolor(green) lwidth(thick) lpattern(tight_dot)) /// 4 IMPE better mean
(line DayDeaMeRaA03S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 5 IMPE worse mean
(line DayDeaUpRaA03S03 date, sort lcolor(red) lpattern(dash)) /// 6 IMPE worse upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IMPE reference scenario, mean" 4 "IMPE better scenario, mean" ///
5 "IMPE worse scenario, mean" 6 "IMPE worse scenario, upper uncertainty limit") size(small) row(3)) ///
subtitle("after 2021-01-01, 3 scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick))  ///
note("- Better and worse scenarios: tight dot (|||||) curves; Uncertainty limits: dashed (– – –) curves." ///
"- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small)) 

graph save "graph 17 COVID-19 daily deaths, $country, 3 scenarios, IMPE.gph", replace
graph export "graph 17 COVID-19 daily deaths, $country, 3 scenarios, IMPE.pdf", replace



***********************

* daily cases or infections (graph numbers start with 21)


* daily cases or infections, reference scenario, all time

forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
*
forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayINFMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayINFMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCasMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01dec2019) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid)  ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" ///
5 "LANL cases" 6 "SRIV cases") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick))  ///
note("- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small)) 

graph save "graph 21 COVID-19 daily cases, $country, reference scenarios, all time.gph", replace
graph export "graph 21 COVID-19 daily cases, $country, reference scenarios, all time.pdf", replace



****
* daily cases or infections, reference scenario, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayINFMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayINFMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCasMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" ///
5 "LANL cases" 6 "SRIV cases") size(small) row(2)) ///
subtitle("after 2021-01-01, reference scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick))  ///
note("- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small)) 

graph save "graph 22 COVID-19 daily cases, $country, reference scenarios.gph", replace
graph export "graph 22 COVID-19 daily cases, $country, reference scenarios.pdf", replace


****
* daily cases or infections, reference scenarios, 2021, CI

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 JOHN
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" upper
(line DayINFMeRaA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line DayINFLoRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line DayINFUpRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line DayINFMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line DayINFLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line DayINFUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line DayCasMeRaA04S00 date, sort lcolor(gold)) /// 11 LANL mean
(line DayCasLoRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL lower
(line DayCasUpRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL upper
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 14 "SRIV" mean
(line DayCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" lower
(line DayCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 5 "IHME infections" 8 "IMPE infections" ///
11 "LANL cases" 14 "SRIV cases") size(small) row(2)) /// 
subtitle("after 2021-01-01, reference scenarios with uncertainty", size(small)) xline(22424, lcolor(red) lwidth(thick))  ///
note("- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small)) 

graph save "graph 23 COVID-19 daily cases, $country, reference scenarios, CI.gph", replace
graph export "graph 23 COVID-19 daily cases, $country, reference scenarios, CI.pdf", replace



****
* daily cases or infections, full scenarios, with uncertainty, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 JOHN
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" upper
(line DayINFMeRaA02S01 date, sort lcolor(black)) /// 5 IHME reference mean
(line DayINFLoRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME reference lower
(line DayINFUpRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME reference upper
(line DayINFMeRaA02S02 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 8 IHME better mean
(line DayINFMeRaA02S03 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 9 IHME worse mean
(line DayINFMeRaA03S02 date, sort lcolor(magenta)) /// 10 IMPE reference mean
(line DayINFLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 11 IMPE reference lower
(line DayINFUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 12 IMPE reference upper
(line DayINFMeRaA03S01 date, sort lcolor(magenta) lwidth(thick) lpattern(tight_dot)) /// 13 IMPE better mean
(line DayINFMeRaA03S03 date, sort lcolor(magenta) lwidth(thick) lpattern(tight_dot)) /// 14 IMPE worse mean
(line DayCasMeRaA04S00 date, sort lcolor(gold)) /// 15 LANL mean
(line DayCasLoRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 16 LANL lower
(line DayCasUpRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 17 LANL upper
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 18 "SRIV" mean
(line DayCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 19 "SRIV" lower
(line DayCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 20 "SRIV" upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 5 "IHME reference, mean" 6 "IHME ref, uncertainty" 8 "IHME better and worse" ///
10 "IMPE reference, mean " 11 "IMPE ref, uncertainty" 13 "IMPE better and worse" ///
15 "LANL cases" 18 "SRIV cases") size(small) row(4)) ///
subtitle("after 2021-01-01, full scenarios, with uncertainty; IHME & IMPE: infections", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Uncertainty limits: dashed (– – –) curves; Better and worse scenarios: tight dot (|||||) curves." ///
"- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small)) 

graph save "graph 23 COVID-19 daily cases, $country, full scenarios, CI.gph", replace
graph export "graph 23 COVID-19 daily cases, $country, full scenarios, CI.pdf", replace



****
* daily cases or infections, reference scenario with uncertainty, IHME, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 1 JOHN
(line DayINFMeRaA02S01 date, sort lcolor(black)) /// 2 IHME reference mean
(line DayINFLoRaA02S01 date, sort lcolor(green) lpattern(dash)) /// 3 IHME reference lower
(line DayINFUpRaA02S01 date, sort lcolor(red) lpattern(dash)) /// 4 IHME reference upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases JOHN, and infections IHME, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "IHME reference, mean" 3 "IHME reference, lower" 4 "IHME reference, upper") size(small) row(2)) ///
subtitle("after 2021-01-01, IHME infections reference scenario with uncertainty", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Uncertainty limits: dashed (– – –) curves." ///
"- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 24 COVID-19 daily cases, $country, reference scenario with uncertainty, IHME.gph", replace
graph export "graph 24 COVID-19 daily cases, $country, reference scenario with uncertainty, IHME.pdf", replace



****
* daily cases or infections, 3 scenarios, IHME, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 1 JOHN
(line DayINFMeRaA02S01 date, sort lcolor(black)) /// 2 IHME reference mean
(line DayINFMeRaA02S02 date, sort lcolor(green) lwidth(thick) lpattern(tight_dot)) /// 3 IHME better mean
(line DayINFMeRaA02S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 4 IHME worse mean
(line DayINFUpRaA02S03 date, sort lcolor(red) lpattern(dash)) /// 5 IHME worse upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily JOHN, and infections IHME, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "IHME reference, mean" 3 "IHME better, mean" 4 "IHME worse, mean" ///
5 "IHME worse scenario, upper uncertainty limit") size(small) row(3)) ///
subtitle("after 2021-01-01, IHME infections 3 scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Better and worse scenarios: tight dot (|||||) curves; Uncertainty limits: dashed (– – –) curves." ///
"- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 25 COVID-19 daily cases, $country, 3 scenarios, IHME.gph", replace
graph export "graph 25 COVID-19 daily cases, $country, 3 scenarios, IHME.pdf", replace



****
* daily cases or infections, reference scenario with uncertainty, IMPE, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 1 JOHN
(line DayINFMeRaA03S02 date, sort lcolor(black)) /// 2 IMPE reference mean
(line DayINFLoRaA03S02 date, sort lcolor(green) lpattern(dash)) /// 3 IMPE reference lower
(line DayINFUpRaA03S02 date, sort lcolor(red) lpattern(dash)) /// 4 IMPE reference upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases JOHN, and infections IMPE, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "IMPE reference, mean" 3 "IMPE reference, lower" 4 "IMPE reference, upper") size(small) row(2)) ///
subtitle("after 2021-01-01, IMPE infections reference scenario with uncertainty", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Uncertainty limits: dashed (– – –) curves." ///
"- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 26 COVID-19 daily cases, $country, reference scenario with uncertainty, IMPE.gph", replace
graph export "graph 26 COVID-19 daily cases, $country, reference scenario with uncertainty, IMPE.pdf", replace



****
* daily cases or infections, 3 scenarios, IMPE 

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 1 JOHN
(line DayINFMeRaA03S02 date, sort lcolor(black)) /// 2 IMPE reference mean
(line DayINFMeRaA03S01 date, sort lcolor(green) lwidth(thick) lpattern(tight_dot)) /// 3 IMPE better mean
(line DayINFMeRaA03S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 4 IMPE worse mean
(line DayINFUpRaA03S03 date, sort lcolor(red) lpattern(dash)) /// 5 IMPE worse upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily JOHN, and infections IMPE, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "IMPE reference, mean" 3 "IMPE better, mean" 4 "IMPE worse, mean" ///
5 "IMPE worse scenario, upper uncertainty limit") size(small) row(3)) ///
subtitle("after 2021-01-01, 3 scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Better and worse scenarios: tight dot (|||||) curves; Uncertainty limits: dashed (– – –) curves." ///
"- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 27 COVID-19 daily cases, $country, 3 scenarios, IMPE.gph", replace
graph export "graph 27 COVID-19 daily cases, $country, 3 scenarios, IMPE.pdf", replace



*****************

* total deaths (graph numbers start with 31)


****
* total deaths, reference scenario, all time

forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
*
forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDeaMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01dec2019) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 31 COVID-19 total deaths, $country, reference scenarios, all time.gph", replace
graph export "graph 31 COVID-19 total deaths, $country, reference scenarios, all time.pdf", replace



****
* total deaths, reference scenario, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDeaMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("after 2021-01-01, reference scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 32 COVID-19 total deaths, $country, reference scenarios.gph", replace
graph export "graph 32 COVID-19 total deaths, $country, reference scenarios.pdf", replace



****
* total deaths, reference scenario, CI, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 JOHN
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 DELP mean
(line TotDeaLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 DELP lower
(line TotDeaUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 DELP upper
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line TotDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line TotDeaLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line TotDeaUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line TotDeaMeRaA04S00 date, sort lcolor(gold)) /// 11 LANL mean
(line TotDeaLoRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL lower
(line TotDeaUpRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL upper
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 14 "SRIV" mean
(line TotDeaLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" lower
(line TotDeaUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "LANL" 14 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves") ///
subtitle("after 2021-01-01, reference scenarios with uncertainty", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 33 COVID-19 total deaths, $country, reference scenarios, CI.gph", replace
graph export "graph 33 COVID-19 total deaths, $country, reference scenarios, CI.pdf", replace




*****************

* total cases or infections (graph numbers start with 41)


****
* total cases or infections, reference scenario, all time

forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
*
forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotINFMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotINFMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCasMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01dec2019) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" ///
5 "LANL cases" 6 "SRIV cases") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 41 COVID-19 total cases, $country, reference scenarios, all time.gph", replace
graph export "graph 41 COVID-19 total cases, $country, reference scenarios, all time.pdf", replace



****
* total cases or infections, reference scenario, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotINFMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotINFMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCasMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" ///
5 "LANL cases" 6 "SRIV cases") size(small) row(2)) ///
subtitle("after 2021-01-01, reference scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 42 COVID-19 total cases, $country, reference scenarios.gph", replace
graph export "graph 42 COVID-19 total cases, $country, reference scenarios.pdf", replace



****
* total cases or infections, reference scenario, CI, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 JOHN
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP"
(line TotCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP"
(line TotINFMeRaA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line TotINFLoRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotINFUpRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line TotINFMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line TotINFLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line TotINFUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line TotCasMeRaA04S00 date, sort lcolor(gold)) /// 11 LANL mean
(line TotCasLoRaA04S00 date, sort lcolor(gold)  lpattern(dash)) /// 12 LANL lower
(line TotCasUpRaA04S00 date, sort lcolor(gold)  lpattern(dash)) /// 13 LANL upper
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 14 "SRIV" mean
(line TotCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" lower
(line TotCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" upper
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" ///
5 "LANL cases" 6 "SRIV cases") size(small) row(2)) ///
subtitle("after 2021-01-01, reference scenarios with uncertainty", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Uncertainty limits: dashed curves." ///
"- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 43 COVID-19 total cases, $country, reference scenarios, CI.gph", replace
graph export "graph 43 COVID-19 total cases, $country, reference scenarios, CI.pdf", replace



****************

* daily CFR / IFR (graph numbers start with 51)


****
* CFR / IFR all studies, all time, reference scenarios, all time

forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
*
forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 1 "JOHN"
(line DayCfrMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIFRMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayIFRMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCfrMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCfrMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01dec2019) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR or IFR) title("COVID-19 daily CFR or IFR, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN CFR" 2 "DELP CFR" 3 "IHME IFR" 4 "IMPE IFR" 5 "LANL CFR" 6 "SRIV CFR") size(small) row(2)) ///
subtitle("reference scenarios", size(small) color(white))

graph save "graph 51 COVID-19 daily CFR, $country, reference scenarios, all time.gph", replace
graph export "graph 51 COVID-19 daily CFR, $country, reference scenarios, all time.pdf", replace



****
* cfr all studies, reference scenarios, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 1 "JOHN"
(line DayCfrMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIFRMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayIFRMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCfrMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCfrMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR or IFR) title("COVID-19 daily CFR or IFR, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN CFR" 2 "DELP CFR" 3 "IHME IFR" 4 "IMPE IFR" 5 "LANL CFR" 6 "SRIV CFR") size(small) row(2)) ///
subtitle("after 2021-01-01, reference scenarios", size(small))

graph save "graph 52 COVID-19 daily CFR, $country, reference scenarios.gph", replace
graph export "graph 52 COVID-19 daily CFR, $country, reference scenarios.pdf", replace





************************

* other outcomes (graph numbers start with 71)


* base codes with IHME and IMPE, all hospital-related outcomes, all time

forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
*
forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red) lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayBedMeSmA02S01 date, sort lcolor(black)) /// 3 IHME Bed need (Daily Beds needed Mean IHME S1)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 4 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 5 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayIcnMeSmA02S01 date, sort lcolor(blue)) /// 6 IHME ICU new (Daily new people going to ICU Mean IHME S1)
(line DayHodMeRaA03S01 date, sort lcolor(magenta)) /// 7 IMPE Hosp demand (Daily hospital demand Mean A03 S01 )
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 8 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
if date >= td(01dec2019) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME Bed need" 4 "IHME ICU need" ///
5 "IHME Admissions" 6 "IHME ICU new" 7 "IMPE Hosp demand" ///
8 "IMPE ICU demand") rows(4) size(small)) ///
subtitle("reference scenarios", size(small) color(white)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 71 COVID-19 hospital-related outcomes, all time.gph", replace
graph export "graph 71 COVID-19 hospital-related outcomes, all time.pdf", replace



****
* daily hospital-related outcomes, DELP, IHME, IMPE, wo IHME Bed need, IMPE Hosp demand

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red) lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 3 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 4 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayIcnMeSmA02S01 date, sort lcolor(blue)) /// 5 IHME ICU new (Daily new people going to ICU Mean IHME S1)
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 6 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
(line DayCfrMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME ICU need" ///
4 "IHME Admissions" 5 "IHME ICU new" 6 "IMPE ICU demand") rows(3) size(small)) ///
subtitle("after 2021-01-01, without IHME Bed need, IMPE Hosp demand, reference scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Uncertainty limits: dashed curves." ///
"- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 72 COVID-19 hospital-related outcomes, wo extremes, 2021.gph", replace
graph export "graph 72 COVID-19 hospital-related outcomes, wo extremes, 2021.pdf", replace




*******************************

* daily cases to deaths (CTD) 


****
* Daily cases or infections to deaths (CTD / ITD) all studies, reference scenarios, all time


forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
*
forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayCTDMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line DayCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayITDMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayITDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCTDMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCTDMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01dec2019) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections to deaths) title("COVID-19 daily cases or infections, to deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "LANL cases" 6 "SRIV cases") size(small) row(2)) ///
subtitle("reference scenarios", size(small))

graph save "graph 81 COVID-19 daily cases to deaths, $country, reference scenarios, all time.gph", replace
graph export "graph 81 COVID-19 daily cases to deaths, $country, reference scenarios, all time.pdf", replace



****
* Daily cases or infections to deaths (CTD / ITD) all studies, reference scenarios, 2021


forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayCTDMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 1 "JOHN"
(line DayCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayITDMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayITDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCTDMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCTDMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections to deaths) title("COVID-19 daily cases or infections, to deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "LANL cases" 6 "SRIV cases") size(small) row(2)) ///
subtitle("after 2021-01-01, reference scenarios", size(small))

graph save "graph 82 COVID-19 daily cases to deaths, $country, reference scenarios.gph", replace
graph export "graph 82 COVID-19 daily cases to deaths, $country, reference scenarios.pdf", replace



****
* Total cases to deaths (CTD / ITD) all studies, all time, reference scenarios, all time

forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
*
forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line TotCTDMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line TotCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotITDMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotITDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCTDMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCTDMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01dec2019) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections to deaths) title("COVID-19 total cases or infections, to deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "LANL cases" 6 "SRIV cases") size(small) row(2)) ///
subtitle("reference scenarios", size(small))

graph save "graph 83 COVID-19 total cases to deaths, $country, reference scenarios, all time.gph", replace
graph export "graph 83 COVID-19 total cases to deaths, $country, reference scenarios, all time.pdf", replace



****
* Total cases to deaths (CTD / ITD) all studies, reference scenarios, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line TotCTDMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line TotCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotITDMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotITDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCTDMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCTDMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections to deaths) title("COVID-19 total cases or infections, to deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "LANL cases" 6 "SRIV cases") size(small) row(2)) ///
subtitle("after 2021-01-01, reference scenarios", size(small))

graph save "graph 84 COVID-19 total cases to deaths, $country, reference scenarios.gph", replace
graph export "graph 84 COVID-19 total cases to deaths, $country, reference scenarios.pdf", replace




*******************************

*  estimated to reported (graph numbers start with 91)


* daily deaths estimated to reported  


****
* daily deaths estimated to reported (DER) all studies, reference scenarios, all time

forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
*
forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayDERMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line DayDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01dec2019) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths estimated to reported) title("COVID-19 daily deaths, estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

graph save "graph 91 COVID-19 daily deaths estimated to reported, $country, reference scenarios, all time.gph", replace
graph export "graph 91 COVID-19 daily deaths estimated to reported, $country, reference scenarios, all time.pdf", replace



****
* daily deaths estimated to reported (DER) all studies, reference scenarios, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayDERMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line DayDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths estimated to reported) title("COVID-19 daily deaths, estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

graph save "graph 92 COVID-19 daily deaths estimated to reported, $country, reference scenarios.gph", replace
graph export "graph 92 COVID-19 daily deaths estimated to reported, $country, reference scenarios.pdf", replace



* daily cases or infections estimated to reported cases


****
* daily cases or infections estimated to reported cases (CER / IER) all studies, reference scenarios, all time 

forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
*
forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayIERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01dec2019) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections estimated to reported) title("COVID-19 daily cases estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(3)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "LANL cases" 6 "SRIV cases") size(small) row(2)) ///
subtitle("daily cases or infections estimated, to reported cases; reference scenarios", size(small))

graph save "graph 93 COVID-19 daily cases estimated to reported, $country, reference scenarios, all time .gph", replace
graph export "graph 93 COVID-19 daily cases estimated to reported, $country, reference scenarios, all time .pdf", replace



****
* daily cases or infections estimated to reported cases (CER / IER) all studies, 2021-01-01 on, reference scenarios

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayIERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections estimated to reported) title("COVID-19 daily cases estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(3)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "LANL cases" 6 "SRIV cases") size(small) row(2)) ///
subtitle("daily cases or infections estimated, to reported cases; reference scenarios", size(small))

graph save "graph 94 COVID-19 daily cases estimated to reported, $country, reference scenarios.gph", replace
graph export "graph 94 COVID-19 daily cases estimated to reported, $country, reference scenarios.pdf", replace



****
* total deaths estimated to reported (DER) all studies, reference scenarios, all time

forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
*
forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line TotDERMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN
(line TotDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotDERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01dec2019) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths estimated to reported) title("COVID-19 total deaths, estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(5)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

graph save "graph 95 COVID-19 total deaths estimated to reported, $country, reference scenarios, all time.gph", replace
graph export "graph 95 COVID-19 total deaths estimated to reported, $country, reference scenarios, all time.pdf", replace



****
* total deaths estimated to reported (DER) all studies, reference scenarios, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line TotDERMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN
(line TotDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotDERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths estimated to reported) title("COVID-19 total deaths, estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(5)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

graph save "graph 96 COVID-19 total deaths estimated to reported, $country, reference scenarios.gph", replace
graph export "graph 96 COVID-19 total deaths estimated to reported, $country, reference scenarios.pdf", replace



****
* total cases or infections or infections estimated to reported cases (CER / IER) all studies, reference scenarios, all time

forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
*
forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line TotCERMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line TotCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotIERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotIERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01dec2019) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections estimated to reported) title("COVID-19 total cases estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(5)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "LANL cases" 6 "SRIV cases") size(small) row(2)) ///
subtitle("total cases or infections estimated, to reported cases; reference scenarios", size(small))

graph save "graph 97 COVID-19 total cases estimated to reported, $country, reference scenarios.gph", replace
graph export "graph 97 COVID-19 total cases estimated to reported, $country, reference scenarios.pdf", replace



****
* total cases or infections or infections estimated to reported cases (CER / IER) all studies, reference scenarios, 2021

forval i = 1(1)12 {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*

twoway ///
(line TotCERMeRaA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line TotCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotIERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotIERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections estimated to reported) title("COVID-19 total cases estimated to reported, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2) titlegap(5)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "LANL cases" 6 "SRIV cases") size(small) row(2)) ///
subtitle("total cases or infections estimated, to reported cases; reference scenarios", size(small))

graph save "graph 98 COVID-19 total cases estimated to reported, $country, reference scenarios.gph", replace
graph export "graph 98 COVID-19 total cases estimated to reported, $country, reference scenarios.pdf", replace

***









************

* restore native scheme (of the local machine)

set scheme $nativescheme

di c(scheme)


view "log country merge.smcl"

log close

exit, clear



