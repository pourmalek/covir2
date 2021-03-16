
clear all

cd "$pathcovir2"

cd SOLT

capture log close 

log using "log Iran SOLT.smcl", replace

***************************************************************************
* This is "do Iran SOLT.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time: 2021-02-10

* OBJECTIVE: Get and prepare SOLT data for Iran, Locate peak dates and values
***************************************************************************


* Get SOLT estimates 

clear 

import excel using "SOLT dig data.xlsx", clear 


rename D DayCasAcRaA06S01V00

label var DayCasAcRaA06S01V00 "Daily Cases Active SOLT S1"

rename E DayCasAcRaA06S02V00

label var DayCasAcRaA06S02V00 "Daily Cases Active SOLT S2"

keep DayCasAcRaA06S01V00 DayCasAcRaA06S02V00

drop in 1 

destring DayCasAcRaA06S01V00, replace

destring DayCasAcRaA06S02V00, replace


di td(15feb2020) // 21960

gen date2 = .

replace date2 = 21960 in 1

replace date2 = date2[_n-1] + 1 in 2/610

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
(line DayCasAcRaA06S01V00 date, sort lcolor(red)) ///
(line DayCasAcRaA06S02V00 date, sort lcolor(blue)) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily Acive cases) title("COVID-19 daily Acive cases, Iran, SOLT, 2 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2"))


graph save "graph COVID-19 daily Acive cases a, Iran, SOLT.gph", replace
// graph export "graph COVID-19 daily Acive cases, Iran, SOLT.pdf", replace









*************************************************************************

* Locate peak dates and values


* first peak 

* S1

summ DayCasAcRaA06S01V00 if date > td(01apr2020) & date < td(30apr2020) 

gen DayCasAcRaA06S01V00P1V = r(max)

summ date if DayCasAcRaA06S01V00 == DayCasAcRaA06S01V00P1V & date > td(01apr2020) & date < td(30apr2020) 

gen DayCasAcRaA06S01V00P1D = r(max)

label var DayCasAcRaA06S01V00P1V "DayCasAcRaA06S01V00 Peak 1 Value"
label var DayCasAcRaA06S01V00P1D "DayCasAcRaA06S01V00 Peak 1 Date"

* S2

summ DayCasAcRaA06S02V00 if date > td(01apr2020) & date < td(30apr2020) 

gen DayCasAcRaA06S02V00P1V = r(max)

summ date if DayCasAcRaA06S02V00 == DayCasAcRaA06S02V00P1V & date > td(01apr2020) & date < td(30apr2020) 

gen DayCasAcRaA06S02V00P1D = r(max)

label var DayCasAcRaA06S02V00P1V "DayCasAcRaA06S02V00 Peak 1 Value"
label var DayCasAcRaA06S02V00P1D "DayCasAcRaA06S02V00 Peak 1 Date"



* second peak 

* S1

summ DayCasAcRaA06S01V00 if date > td(01jul2020) & date < td(30jul2020)

gen DayCasAcRaA06S01V00P2V = r(max)

summ date if DayCasAcRaA06S01V00 == DayCasAcRaA06S01V00P2V & date > td(01jul2020) & date < td(30jul2020) 

gen DayCasAcRaA06S01V00P2D = r(max)

label var DayCasAcRaA06S01V00P2V "DayCasAcRaA06S01V00 Peak 2 Value"
label var DayCasAcRaA06S01V00P2D "DayCasAcRaA06S01V00 Peak 2 Date"

* S2

summ DayCasAcRaA06S02V00 if date > td(01jul2020) & date < td(30jul2020)

gen DayCasAcRaA06S02V00P2V = r(max)

summ date if DayCasAcRaA06S02V00 == DayCasAcRaA06S02V00P2V & date > td(01jul2020) & date < td(30jul2020) 

gen DayCasAcRaA06S02V00P2D = r(max)

label var DayCasAcRaA06S02V00P2V "DayCasAcRaA06S02V00 Peak 2 Value"
label var DayCasAcRaA06S02V00P2D "DayCasAcRaA06S02V00 Peak 2 Date"


* third peak 

* S1 

summ DayCasAcRaA06S01V00 if date > td(01nov2020) & date < td(30nov2020)

gen DayCasAcRaA06S01V00P3V = r(max)

summ date if DayCasAcRaA06S01V00 == DayCasAcRaA06S01V00P3V & date > td(01nov2020) & date < td(30nov2020)

gen DayCasAcRaA06S01V00P3D = r(max)

label var DayCasAcRaA06S01V00P3V "DayCasAcRaA06S01V00 Peak 3 Value"
label var DayCasAcRaA06S01V00P3D "DayCasAcRaA06S01V00 Peak 3 Date"

* S2

summ DayCasAcRaA06S02V00 if date > td(01nov2020) & date < td(30nov2020)

gen DayCasAcRaA06S02V00P3V = r(max)

summ date if DayCasAcRaA06S02V00 == DayCasAcRaA06S02V00P3V & date > td(01nov2020) & date < td(30nov2020)

gen DayCasAcRaA06S02V00P3D = r(max)

label var DayCasAcRaA06S02V00P3V "DayCasAcRaA06S02V00 Peak 3 Value"
label var DayCasAcRaA06S02V00P3D "DayCasAcRaA06S02V00 Peak 3 Date"
 

* fourth peak 

* S1 

summ DayCasAcRaA06S01V00 if date > td(01jun2021) & date < td(30jul2021)

gen DayCasAcRaA06S01V00P4V = r(max)

summ date if DayCasAcRaA06S01V00 == DayCasAcRaA06S01V00P4V & date > td(01jun2021) & date < td(30jul2021)

gen DayCasAcRaA06S01V00P4D = r(max)

* S2

label var DayCasAcRaA06S01V00P4V "DayCasAcRaA06S01V00 Peak 4V alue"
label var DayCasAcRaA06S01V00P4D "DayCasAcRaA06S01V00 Peak 4 Date"

summ DayCasAcRaA06S02V00 if date > td(01may2021) & date < td(30may2021)

gen DayCasAcRaA06S02V00P4V = r(max)

summ date if DayCasAcRaA06S02V00 == DayCasAcRaA06S02V00P4V & date > td(01may2021) & date < td(30may2021)

gen DayCasAcRaA06S02V00P4D = r(max)

label var DayCasAcRaA06S02V00P4V "DayCasAcRaA06S02V00 Peak 4 Value"
label var DayCasAcRaA06S02V00P4D "DayCasAcRaA06S02V00 Peak 4 Date"

sort date

compress

save "Iran SOLT.dta", replace 




********************

* tab the peaks


use "Iran SOLT.dta", clear 


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


save "Iran SOLT peaks.dta", replace

export delimited using "Iran SOLT.csv", replace 





 
 

view "log Iran SOLT.smcl"

log close

exit, clear




