
clear all

cd "$pathcovir2"

cd SOLT

capture log close 

log using "log Iran SOLT.smcl", replace

***************************************************************************
* This is "do Iran SOLT.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare SOLT data for Iran, Locate peak dates and values
***************************************************************************


* Get SOLT estimates 

clear 

import excel using "SOLT dig data.xlsx", clear 


rename D DayActMeRaA06S01V00

label var DayActMeRaA06S01V00 "Daily Active cases SOLT S1"

rename E DayActMeRaA06S02V00

label var DayActMeRaA06S02V00 "Daily Active cases SOLT S2"

keep DayActMeRaA06S01V00 DayActMeRaA06S02V00

drop in 1 

destring DayActMeRaA06S01V00, replace

destring DayActMeRaA06S02V00, replace


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
(line DayActMeRaA06S01V00 date, sort lcolor(red)) ///
(line DayActMeRaA06S02V00 date, sort lcolor(blue)) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily Active cases) title("COVID-19 daily Active cases, Iran, SOLT, 2 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2"))


graph save "graph COVID-19 daily Active cases a, Iran, SOLT.gph", replace
graph export "graph COVID-19 daily Active cases, Iran, SOLT.pdf", replace









*************************************************************************

* Locate peak dates and values


* first peak 

* S1

summ DayActMeRaA06S01V00 if date > td(01apr2020) & date < td(30apr2020) 

gen DayActMeRaA06S01V00P1V = r(max)

summ date if DayActMeRaA06S01V00 == DayActMeRaA06S01V00P1V & date > td(01apr2020) & date < td(30apr2020) 

gen DayActMeRaA06S01V00P1D = r(max)

label var DayActMeRaA06S01V00P1V "DayActMeRaA06S01V00 Peak 1 Value"
label var DayActMeRaA06S01V00P1D "DayActMeRaA06S01V00 Peak 1 Date"

format DayActMeRaA06S01V00P1D %tdDDMonCCYY

tab1 DayActMeRaA06S01V00P1V DayActMeRaA06S01V00P1D


* S2

summ DayActMeRaA06S02V00 if date > td(01apr2020) & date < td(30apr2020) 

gen DayActMeRaA06S02V00P1V = r(max)

summ date if DayActMeRaA06S02V00 == DayActMeRaA06S02V00P1V & date > td(01apr2020) & date < td(30apr2020) 

gen DayActMeRaA06S02V00P1D = r(max)

label var DayActMeRaA06S02V00P1V "DayActMeRaA06S02V00 Peak 1 Value"
label var DayActMeRaA06S02V00P1D "DayActMeRaA06S02V00 Peak 1 Date"

format DayActMeRaA06S02V00P1D %tdDDMonCCYY

tab1 DayActMeRaA06S02V00P1V DayActMeRaA06S02V00P1D


* second peak 

* S1

summ DayActMeRaA06S01V00 if date > td(01jul2020) & date < td(30jul2020)

gen DayActMeRaA06S01V00P2V = r(max)

summ date if DayActMeRaA06S01V00 == DayActMeRaA06S01V00P2V & date > td(01jul2020) & date < td(30jul2020) 

gen DayActMeRaA06S01V00P2D = r(max)

label var DayActMeRaA06S01V00P2V "DayActMeRaA06S01V00 Peak 2 Value"
label var DayActMeRaA06S01V00P2D "DayActMeRaA06S01V00 Peak 2 Date"

format DayActMeRaA06S01V00P2D %tdDDMonCCYY

tab1 DayActMeRaA06S01V00P2V DayActMeRaA06S01V00P2D


* S2

summ DayActMeRaA06S02V00 if date > td(01jul2020) & date < td(30jul2020)

gen DayActMeRaA06S02V00P2V = r(max)

summ date if DayActMeRaA06S02V00 == DayActMeRaA06S02V00P2V & date > td(01jul2020) & date < td(30jul2020) 

gen DayActMeRaA06S02V00P2D = r(max)

label var DayActMeRaA06S02V00P2V "DayActMeRaA06S02V00 Peak 2 Value"
label var DayActMeRaA06S02V00P2D "DayActMeRaA06S02V00 Peak 2 Date"

format DayActMeRaA06S02V00P2D %tdDDMonCCYY

tab1 DayActMeRaA06S02V00P2V DayActMeRaA06S02V00P2D


* third peak 

* S1 

summ DayActMeRaA06S01V00 if date > td(01nov2020) & date < td(30nov2020)

gen DayActMeRaA06S01V00P3V = r(max)

summ date if DayActMeRaA06S01V00 == DayActMeRaA06S01V00P3V & date > td(01nov2020) & date < td(30nov2020)

gen DayActMeRaA06S01V00P3D = r(max)

label var DayActMeRaA06S01V00P3V "DayActMeRaA06S01V00 Peak 3 Value"
label var DayActMeRaA06S01V00P3D "DayActMeRaA06S01V00 Peak 3 Date"

format DayActMeRaA06S01V00P3D %tdDDMonCCYY

tab1 DayActMeRaA06S01V00P3V DayActMeRaA06S01V00P3D


* S2

summ DayActMeRaA06S02V00 if date > td(01nov2020) & date < td(30nov2020)

gen DayActMeRaA06S02V00P3V = r(max)

summ date if DayActMeRaA06S02V00 == DayActMeRaA06S02V00P3V & date > td(01nov2020) & date < td(30nov2020)

gen DayActMeRaA06S02V00P3D = r(max)

label var DayActMeRaA06S02V00P3V "DayActMeRaA06S02V00 Peak 3 Value"
label var DayActMeRaA06S02V00P3D "DayActMeRaA06S02V00 Peak 3 Date"

format DayActMeRaA06S02V00P3D %tdDDMonCCYY

tab1 DayActMeRaA06S02V00P3V DayActMeRaA06S02V00P3D
 

* fourth peak 

* S1 

summ DayActMeRaA06S01V00 if date > td(01jun2021) & date < td(30jul2021)

gen DayActMeRaA06S01V00P4V = r(max)

summ date if DayActMeRaA06S01V00 == DayActMeRaA06S01V00P4V & date > td(01jun2021) & date < td(30jul2021)

gen DayActMeRaA06S01V00P4D = r(max)

label var DayActMeRaA06S01V00P4V "DayActMeRaA06S02V00 Peak 4 Value"
label var DayActMeRaA06S01V00P4D "DayActMeRaA06S02V00 Peak 4 Date"

format DayActMeRaA06S01V00P4D %tdDDMonCCYY

tab1 DayActMeRaA06S01V00P4V DayActMeRaA06S01V00P4D


* S2

label var DayActMeRaA06S01V00P4V "DayActMeRaA06S01V00 Peak 4V alue"
label var DayActMeRaA06S01V00P4D "DayActMeRaA06S01V00 Peak 4 Date"

summ DayActMeRaA06S02V00 if date > td(01may2021) & date < td(30may2021)

gen DayActMeRaA06S02V00P4V = r(max)

summ date if DayActMeRaA06S02V00 == DayActMeRaA06S02V00P4V & date > td(01may2021) & date < td(30may2021)

gen DayActMeRaA06S02V00P4D = r(max)

label var DayActMeRaA06S02V00P4V "DayActMeRaA06S02V00 Peak 4 Value"
label var DayActMeRaA06S02V00P4D "DayActMeRaA06S02V00 Peak 4 Date"

format DayActMeRaA06S02V00P4D %tdDDMonCCYY

tab1 DayActMeRaA06S02V00P4V DayActMeRaA06S02V00P4D



sort date

compress

save "Iran SOLT.dta", replace 



 
 

view "log Iran SOLT.smcl"

log close

exit, clear




