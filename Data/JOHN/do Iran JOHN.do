
clear all

cd "$pathcovir2"

cd JOHN

capture log close 

log using "log Iran JOHN.smcl", replace

***************************************************************************
* This is "do Iran JOHN.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time: 2021-02-10

* OBJECTIVE: Get and prepare Johns Hopkins data for Iran, Locate peak dates and values
***************************************************************************



* get Johns Hopkins data for deaths

import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv" ///
, clear varnames(1)

drop lat v4 provincestate

rename countryregion loc_grand_name

keep if loc_grand_name == "Iran"

order loc_grand_name, last

* v5 is 1/22/20    22jan2020

* v33 is 2/19/20   19feb2020 with first two tandem deaths in Qom

gen counter = _n

reshape long v, i(counter) 

drop counter 

codebook _j

replace _j = _j - 4 // compensate for first vars in the original file

gen date = date("22 Jan 2020", "DMY")

replace date = date + _j - 1

format date %td

codebook date

order date 

rename v TotDeaMeRaA00S00V00

label var TotDeaMeRaA00S00V00 "Total Deaths JOHN"

list TotDeaMeRaA00S00V00 if date == td(19feb2020) // Shoule be 2

gen DayDeaMeRaA00S00V00 =  TotDeaMeRaA00S00V00[_n] - TotDeaMeRaA00S00V00[_n-1]

label var DayDeaMeRaA00S00V00 "Daily Deaths JOHN"

replace DayDeaMeRaA00S00V00 = TotDeaMeRaA00S00V00 if _j == 1

replace TotDeaMeRaA00S00V00 = . if date < td(19feb2020)

replace DayDeaMeRaA00S00V00 = . if date < td(19feb2020)

drop _j 

gen DayDeaMeRaA00S00V00_CF2 = DayDeaMeRaA00S00V00 * 2

label var DayDeaMeRaA00S00V00_CF2 "Daily Deaths JOHN correction factor 2"

gen DayDeaMeRaA00S00V00_CF5 = DayDeaMeRaA00S00V00 * 5

label var DayDeaMeRaA00S00V00_CF5 "Daily Deaths JOHN correction factor 5"

gen TotDeaMeRaA00S00V00_CF2 = TotDeaMeRaA00S00V00 * 2

label var TotDeaMeRaA00S00V00_CF2 "Total Deaths JOHN correction factor 2"

gen TotDeaMeRaA00S00V00_CF5 = TotDeaMeRaA00S00V00 * 5

label var TotDeaMeRaA00S00V00_CF5 "Total Deaths JOHN correction factor 5"

order date loc_grand_name TotDeaMeRaA00S00V00 DayDeaMeRaA00S00V00 TotDeaMeRaA00S00V00_CF2 TotDeaMeRaA00S00V00_CF5 DayDeaMeRaA00S00V00_CF2 DayDeaMeRaA00S00V00_CF5					

sort date

save "Iran JOHN deaths.dta", replace




* get Johns Hopkins data for deaths


import delimited using ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv" ///
, clear

drop lat v4 provincestate

rename countryregion loc_grand_name

keep if loc_grand_name == "Iran"

order loc_grand_name, last

gen counter = _n

reshape long v, i(counter) 

drop counter 

codebook _j

replace _j = _j - 4 // compensate for first vars in the original file

gen date = date("22 Jan 2020", "DMY")

replace date = date + _j - 1

format date %td

codebook date

order date 

rename v TotCasMeRaA00S00V00

label var TotCasMeRaA00S00V00 "Total Cases JOHN"

gen DayCasMeRaA00S00V00 =  TotCasMeRaA00S00V00[_n] - TotCasMeRaA00S00V00[_n-1]

label var DayCasMeRaA00S00V00 "Daily Cases JOHN"

replace DayCasMeRaA00S00V00 = TotCasMeRaA00S00V00 if _j == 1

replace TotCasMeRaA00S00V00 = . if date < td(19feb2020)

replace DayCasMeRaA00S00V00 = . if date < td(19feb2020)

drop _j 

order date loc_grand_name TotCasMeRaA00S00V00 DayCasMeRaA00S00V00

sort date

compress

save "Iran JOHN Cases.dta", replace


* merge deaths and cases 

use "Iran JOHN deaths.dta", clear 

merge 1:1 date using "Iran JOHN Cases.dta"

drop _merge






* graphs

ssc install grstyle, replace

grstyle init

grstyle color background white


* daily deaths

twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) 

graph save "graph COVID-19 daily deaths, Iran, Johns Hopkins 1.gph", replace
// // graph export "graph COVID-19 daily deaths, Iran, Johns Hopkins 1.pdf", replace



* daily deaths and daily deaths with correction factors

twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(black)) ///
(rarea DayDeaMeRaA00S00V00_CF2 DayDeaMeRaA00S00V00_CF5 date, sort color(black*0.2)) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Johns Hopkins" 2 "CF 2-5"))


graph save "graph COVID-19 daily deaths, Iran, Johns Hopkins 2.gph", replace
// // graph export "graph COVID-19 daily deaths, Iran, Johns Hopkins 2.pdf", replace



* daily cases 

twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) 


graph save "graph COVID-19 daily cases, Iran, Johns Hopkins.gph", replace
// // graph export "graph COVID-19 daily cases, Iran, Johns Hopkins.pdf", replace





*************************************

* Locate peak dates and values - deaths 


* first peak 

summ DayDeaMeRaA00S00V00 if date > td(01mar2020) & date < td(30apr2020) 

gen DayDeaMeRaA00S00V00P1V = r(max)

summ date if DayDeaMeRaA00S00V00 == DayDeaMeRaA00S00V00P1V & date > td(01mar2020) & date < td(30apr2020) 

gen DayDeaMeRaA00S00V00P1D = r(max)

label var DayDeaMeRaA00S00V00P1V "DayDeaMeRaA00S00V00 Peak 1 Value"
label var DayDeaMeRaA00S00V00P1D "DayDeaMeRaA00S00V00 Peak 1 Date"


* second peak

summ DayDeaMeRaA00S00V00 if date > td(01jul2020) & date < td(30jul2020) 

gen DayDeaMeRaA00S00V00P2V = r(max)

summ date if DayDeaMeRaA00S00V00 == DayDeaMeRaA00S00V00P2V & date > td(01jul2020) & date < td(30jul2020) 

gen DayDeaMeRaA00S00V00P2D = r(max)

label var DayDeaMeRaA00S00V00P2V "DayDeaMeRaA00S00V00 Peak 2 Value"
label var DayDeaMeRaA00S00V00P2D "DayDeaMeRaA00S00V00 Peak 2 Date"

* third peak

summ DayDeaMeRaA00S00V00 if date > td(01nov2020) & date < td(30nov2020) 

gen DayDeaMeRaA00S00V00P3V = r(max)

summ date if DayDeaMeRaA00S00V00 == DayDeaMeRaA00S00V00P3V & date > td(01nov2020) & date < td(30nov2020) 

gen DayDeaMeRaA00S00V00P3D = r(max)

label var DayDeaMeRaA00S00V00P3V "DayDeaMeRaA00S00V00 Peak 3 Value"
label var DayDeaMeRaA00S00V00P3D "DayDeaMeRaA00S00V00 Peak 3 ate"


* plateau after third peak (P5)

gen DayDeaMeRaA00S00V00P5D = td(01jan2021)

label var DayDeaMeRaA00S00V00P5D "DayDeaMeRaA00S00V00 Peak 5 is start of plateau after P3 on 01jan2021 Date"

summ DayDeaMeRaA00S00V00 if date == DayDeaMeRaA00S00V00P5D

gen DayDeaMeRaA00S00V00P5V = r(max) 

label var DayDeaMeRaA00S00V00P5V "DayDeaMeRaA00S00V00 Peak 5 is start of plateau after P3 on 01jan2021 Value"


* start increase after plateau was about 21-02-01 (P6)

gen DayDeaMeRaA00S00V00P56 = td(01feb2021)

label var DayDeaMeRaA00S00V00P56 "DayDeaMeRaA00S00V00 Peak 6 is start of increase after P3 on 01feb2021 Date"

summ DayDeaMeRaA00S00V00 if date == DayDeaMeRaA00S00V00P56

gen DayDeaMeRaA00S00V00P6V = r(max) 

label var DayDeaMeRaA00S00V00P6V "DayDeaMeRaA00S00V00 Peak 6 is start of increase after P3 on 01feb2021 Value"


**********************************************

* Locate peak dates and values - cases 


* first peak 

summ DayCasMeRaA00S00V00 if date > td(01mar2020) & date < td(30apr2020) 

gen DayCasMeRaA00S00V00P1V = r(max)

summ date if DayCasMeRaA00S00V00 == DayCasMeRaA00S00V00P1V & date > td(01mar2020) & date < td(30apr2020) 

gen DayCasMeRaA00S00V00P1D = r(max)

label var DayCasMeRaA00S00V00P1V "DayCasMeRaA00S00V00 Peak 1 Value"
label var DayCasMeRaA00S00V00P1D "DayCasMeRaA00S00V00 Peak 1 Date"


* second peak 

summ DayCasMeRaA00S00V00 if date > td(01may2020) & date < td(30jun2020) 

gen DayCasMeRaA00S00V00P2V = r(max)
 
summ date if DayCasMeRaA00S00V00 == DayCasMeRaA00S00V00P2V & date > td(01may2020) & date < td(30jun2020) 

gen DayCasMeRaA00S00V00P2D = r(max)

label var DayCasMeRaA00S00V00P2V "DayCasMeRaA00S00V00 Peak 2 Value"
label var DayCasMeRaA00S00V00P2D "DayCasMeRaA00S00V00 Peak 2 Date"


* third peak 

summ DayCasMeRaA00S00V00 if date > td(01nov2020) & date < td(30dec2020) 

gen DayCasMeRaA00S00V00P3V = r(max)

summ date if DayCasMeRaA00S00V00 == DayCasMeRaA00S00V00P3V & date > td(01nov2020) & date < td(30dec2020) 

gen DayCasMeRaA00S00V00P3D = r(max)

label var DayCasMeRaA00S00V00P3V "DayCasMeRaA00S00V00 Peak 3 Value"
label var DayCasMeRaA00S00V00P3D "DayCasMeRaA00S00V00 Peak 3 Date"


* plateau after third peak (P5)

gen DayCasMeRaA00S00V00P5D = td(01jan2021)

label var DayCasMeRaA00S00V00P5D "DayCasMeRaA00S00V00 Peak 5 is start of plateau after P3 on 01jan2021 Date"

summ DayCasMeRaA00S00V00 if date == DayCasMeRaA00S00V00P5D

gen DayCasMeRaA00S00V00P5V = r(max) 

label var DayCasMeRaA00S00V00P5V "DayCasMeRaA00S00V00 Peak 5 is start of plateau after P3 on 01jan2021 Value"


* start increase after plateau was about 21-02-01 (P6)

gen DayCasMeRaA00S00V00P56 = td(01feb2021)

label var DayCasMeRaA00S00V00P56 "DayCasMeRaA00S00V00 Peak 6 is start of increase after P3 on 01feb2021 Date"

summ DayCasMeRaA00S00V00 if date == DayCasMeRaA00S00V00P56

gen DayCasMeRaA00S00V00P6V = r(max) 

label var DayCasMeRaA00S00V00P6V "DayCasMeRaA00S00V00 Peak 6 is start of increase after P3 on 01feb2021 Value"


compress

sort date


save "Iran JOHN.dta", replace





********************

* tab the peaks


use "Iran JOHN.dta", clear 


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


save "Iran JOHN peaks.dta", replace

export delimited using "Iran JOHN peaks.csv", replace 






view "log Iran JOHN.smcl"

log close

exit, clear




