
clear all

cd "$pathcovir2"

cd GHAN

capture log close 

log using "log Iran GHAN.smcl", replace

***************************************************************************
* This is "do Iran GHAN.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare GHANbari data for Iran, Locate peak dates and values
***************************************************************************




/* Note on outcomes and scenarios: 

Ghanbari has two subtypes of Daily Cases, “Density of the infected population with a strong immunity system”, 
and “Density of the infected population with a weak immunity system or with a historical medical illness as diabetic, blood pressure, heart issue, and others.” 
Each subtype is presented with 18 different values (aka model subtypes) based on different values of three parameters in their model. 
We selected the median scenario for the first subtype for digitalization. It is model the model subtype number 9 out of 18 subtypes (named S09 here), with the following details. 

Model subtype parameter: γ1 = 0.09, where γ1 is recovery rate in population subtype 1
Time point: Second peak	
Estimate type: Mean
Peak value mentioned: 897,264	
Peak date Solar: 1399 11 30	
Peak date Gregorian: 2021 02 18	
Source: Fig 4a, green curve

*/


***************************************

* Get GHAN estimates 

import excel using "GHAN dig data.xlsx", clear firstrow 

keep date day1is20200122 outcome daysfrom1960

rename outcome DayActMeRaA07S09V00

label var DayActMeRaA07S09V00 "Daily Active cases GHAN S9" 

rename daysfrom1960 date2

format date2 %tdDDMonCCYY

codebook date2

drop date day1is20200122 

rename date2 date

drop if DayActMeRaA07S09V00 == . & date > td(12Dec2021)

order date DayActMeRaA07S09V00




*******************

* graph 


grstyle init

grstyle color background white
 

twoway /// 
(line DayActMeRaA07S09V00 date, sort lcolor(blue)) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily Acive cases) title("COVID-19 daily active cases, Iran, GHAN, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
note("(Daily active cases in population with ‘a strong immunity system’)")


graph save "graph COVID-19 daily cases, Iran, GHAN.gph", replace
graph export "graph COVID-19 daily Acive cases, Iran, GHAN.pdf", replace


*************************************************************************

* Locate peak dates and values


* Article text: peak 2, 

gen DayActMeRaA07S09V00P2V = 897264

label var DayActMeRaA07S09V00P2V "DayActMeRaA07S09V00 Peak 2 Value"

gen DayActMeRaA07S09V00P2D = td(18feb2021)

label var DayActMeRaA07S09V00P2D "DayActMeRaA07S09V00 Peak 2 Date"

format DayActMeRaA07S09V00P2D %tdDDMonCCYY

tab1 DayActMeRaA07S09V00P2V DayActMeRaA07S09V00P2D


save "Iran GHAN.dta", replace 



********************

* tab the peaks


use "Iran GHAN.dta", clear 


keep *D *V

collapse *

foreach v in  * {
rename (`v') S`v'
}
*
 

foreach v in  * {
rename (`v') `v'j
}
*

gen i = _n

reshape long S, i(i) j(j, string)

drop i
rename j varnames
rename S varvalues 

gen varnames_new = substr(varnames,1,22) 
drop varnames
rename varnames_new varnames 

order varnames varvalues

* gen peakname peakvalue for outcomes
* gen peakdate datevalue for dates

gen type = substr(varnames,22,1) 

gen peakname  = varnames
gen peakvalue = varvalues

replace peakname  = "" if type == "D"
replace peakvalue = .  if type == "D"

replace peakvalue = round(peakvalue)

gen peakdate  = varnames
gen datevalue = varvalues

replace peakdate  = "" if type == "V"
replace datevalue = .  if type == "V"

format datevalue %tdDDMonCCYY

drop varvalues

replace type = "Peak date" if type == "D"
replace type = "Outcome value" if type == "V"


save "Iran GHAN peaks.dta", replace

export delimited using "Iran GHAN.csv", replace 





 
 

view "log Iran GHAN.smcl"

log close

exit, clear




