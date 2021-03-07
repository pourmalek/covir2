
clear all

cd "$pathcovir2"

cd Soltani

capture log close 

log using "log Iran Soltani.smcl", replace

***************************************************************************
* This is "do Iran Soltani.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time: 2021-02-10

* OBJECTIVE: Get and prepare Soltani data for Iran, Locate peak dates and values
***************************************************************************


* Get Soltani estimates 

clear 

import excel using "Soltani dig data.xlsx", clear 


rename D DayCasActSOLTS1

label var DayCasActSOLTS1 "Daily Cases Active Soltani S1"

rename E DayCasActSOLTS2

label var DayCasActSOLTS2 "Daily Cases Active Soltani S2"

keep DayCasActSOLTS1 DayCasActSOLTS2

drop in 1 

destring DayCasActSOLTS1, replace

destring DayCasActSOLTS2, replace


di td(15feb2020) // 21960

gen date2 = .

replace date2 = 21960 in 1

replace date2 = date2[_n-1] + 1 in 2/610

gen date = date2
format date %tdDDMonCCYY
codebook date 

gen loc_grand_name = "Iran"

sort date

compress

save "Iran Soltani.dta", replace 



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
(line DayCasActSOLTS1 date, sort lcolor(red)) ///
(line DayCasActSOLTS2 date, sort lcolor(blue)) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily active cases) title("COVID-19 daily active cases, Iran, Soltani, 2 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2"))


graph save "graph COVID-19 daily active cases a, Iran, Soltani.gph", replace
// graph export "graph COVID-19 daily active cases, Iran, Soltani.pdf", replace









*************************************************************************

* Locate peak dates and values


* first peak 

summ DayCasActSOLTS1 if date > td(01apr2020) & date < td(30apr2020) // 32909

list date if DayCasActSOLTS1 > 32908.9 & date > td(01apr2020) & date < td(30apr2020) // 08Apr2020

summ DayCasActSOLTS2 if date > td(01apr2020) & date < td(30apr2020) // 32909

list date if DayCasActSOLTS2 > 32908.9 & date > td(01apr2020) & date < td(30apr2020) // 08Apr2020


* second peak 

summ DayCasActSOLTS1 if date > td(01jul2020) & date < td(30jul2020) // 33245

list date if DayCasActSOLTS1 > 33244.9 & date > td(01jul2020) & date < td(30jul2020) // 05Jul2020

summ DayCasActSOLTS2 if date > td(01jul2020) & date < td(30jul2020) // 33245

list date if DayCasActSOLTS2 > 33244.9 & date > td(01jul2020) & date < td(30jul2020) // 05Jul2020


* third peak 

summ DayCasActSOLTS1 if date > td(01nov2020) & date < td(30nov2020) // 226749

list date if DayCasActSOLTS1 > 226748 & date > td(01nov2020) & date < td(30nov2020) // 11Nov2020

summ DayCasActSOLTS2 if date > td(01nov2020) & date < td(30nov2020) // 118353

list date if DayCasActSOLTS2 > 118352 & date > td(01nov2020) & date < td(30nov2020) // 22Nov2020
 

* fourth peak 

summ DayCasActSOLTS1 if date > td(01jun2021) & date < td(30jul2021) // 105011

list date if DayCasActSOLTS1 > 105010 & date > td(01jun2021) & date < td(30jul2021) // 08Jul2021

summ DayCasActSOLTS2 if date > td(01may2021) & date < td(30may2021) // 272240

list date if DayCasActSOLTS2 > 272239 & date > td(01may2021) & date < td(30may2021) // 16May2021 
 
 

view "log Iran Soltani.smcl"

log close

exit, clear




