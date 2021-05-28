
clear all

cd "$pathcovir2"

cd SOLT

capture log close 

log using "log Iran SOLT.smcl", replace

***************************************************************************
* This is "do Iran SOLT.do"

* Project: COVID-19 Iran Review No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare SOLT data for Iran
***************************************************************************


* Get SOLT estimates 

clear 

import excel using "SOLT dig data.xlsx", clear 


rename D DayActMeRaA06S01

label var DayActMeRaA06S01 "Daily Active cases SOLT S1"

rename E DayActMeRaA06S02

label var DayActMeRaA06S02 "Daily Active cases SOLT S2"

keep DayActMeRaA06S01 DayActMeRaA06S02

drop in 1 

destring DayActMeRaA06S01, replace

destring DayActMeRaA06S02, replace


di td(15feb2020) // 21960

gen date2 = .

replace date2 = 21960 in 1

replace date2 = date2[_n-1] + 1 in 2/l

gen date = date2
format date %tdDDMonCCYY
codebook date 

drop date2

gen loc_grand_name = "Iran"

sort date

compress

save "Iran SOLT.dta", replace 



*********

/*
* Scenarios

S1 = Reopening scenario 1 = Percentage of population "free from quarantine" upon reopening 
at lowest point between second and third peaks (about 2020-09-01) is 35% and at lowest point between third and fourth peaks (about 2021-03-01 )is 20%. 


S2 = Reopening scenario 2 = Percentage of population "free from quarantine" upon reopening 
at lowest point between second and third peaks (about 2020-09-01) is 32% and at lowest point between third and fourth peaks (about 2021-03-01 )is 22%. 

*/



*************************************************************************

* graphs


grstyle init

grstyle color background white

twoway /// 
(line DayActMeRaA06S01 date, sort lcolor(red)) ///
(line DayActMeRaA06S02 date, sort lcolor(blue)) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily Active cases) title("COVID-19 daily Active cases, Iran, SOLT, 2 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2"))

graph save "graph COVID-19 daily Active cases a, Iran, SOLT.gph", replace
graph export "graph COVID-19 daily Active cases, Iran, SOLT.pdf", replace








sort date loc_grand_name

qui compress

save "Iran SOLT.dta", replace 



 
 

view "log Iran SOLT.smcl"

log close

exit, clear




