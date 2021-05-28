
clear all

cd "$pathcovir2"

cd GHAN

capture log close 

log using "log Iran GHAN.smcl", replace

***************************************************************************
* This is "do Iran GHAN.do"

* Project: COVID-19 Iran Review No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare GHANbari data for Iran
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

rename outcome DayActMeRaA07S09

label var DayActMeRaA07S09 "Daily Active cases GHAN S9" 

rename daysfrom1960 date2

format date2 %tdDDMonCCYY

codebook date2

drop date day1is20200122 

rename date2 date

drop if DayActMeRaA07S09 == . & date > td(12Dec2021)

order date DayActMeRaA07S09




*******************

* graph 


grstyle init

grstyle color background white
 

twoway /// 
(line DayActMeRaA07S09 date, sort lcolor(blue)) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily Acive cases) title("COVID-19 daily active cases, Iran, GHAN, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
note("(Daily active cases in population with ‘a strong immunity system’)")

graph save "graph COVID-19 daily cases, Iran, GHAN.gph", replace
graph export "graph COVID-19 daily Acive cases, Iran, GHAN.pdf", replace





save "Iran GHAN.dta", replace 




view "log Iran GHAN.smcl"

log close

exit, clear




