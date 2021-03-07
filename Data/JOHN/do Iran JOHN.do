
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

rename v TotDeaA00JOHN

label var TotDeaA00JOHN "Total Deaths JOHN"

list TotDeaA00JOHN if date == td(19feb2020) // Shoule be 2

gen DayDeaA00JOHN =  TotDeaA00JOHN[_n] - TotDeaA00JOHN[_n-1]

label var DayDeaA00JOHN "Daily Deaths JOHN"

replace DayDeaA00JOHN = TotDeaA00JOHN if _j == 1

replace TotDeaA00JOHN = . if date < td(19feb2020)

replace DayDeaA00JOHN = . if date < td(19feb2020)

drop _j 

gen DayDeaA00JOHN_CF2 = DayDeaA00JOHN * 2

label var DayDeaA00JOHN_CF2 "Daily Deaths JOHN correction factor 2"

gen DayDeaA00JOHN_CF5 = DayDeaA00JOHN * 5

label var DayDeaA00JOHN_CF5 "Daily Deaths JOHN correction factor 5"

gen TotDeaA00JOHN_CF2 = TotDeaA00JOHN * 2

label var TotDeaA00JOHN_CF2 "Total Deaths JOHN correction factor 2"

gen TotDeaA00JOHN_CF5 = TotDeaA00JOHN * 5

label var TotDeaA00JOHN_CF5 "Total Deaths JOHN correction factor 5"

order date loc_grand_name TotDeaA00JOHN DayDeaA00JOHN TotDeaA00JOHN_CF2 TotDeaA00JOHN_CF5 DayDeaA00JOHN_CF2 DayDeaA00JOHN_CF5					

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

rename v TotCasA00JOHN

label var TotCasA00JOHN "Total Cases JOHN"

gen DayCasA00JOHN =  TotCasA00JOHN[_n] - TotCasA00JOHN[_n-1]

label var DayCasA00JOHN "Daily Cases JOHN"

replace DayCasA00JOHN = TotCasA00JOHN if _j == 1

replace TotCasA00JOHN = . if date < td(19feb2020)

replace DayCasA00JOHN = . if date < td(19feb2020)

drop _j 

order date loc_grand_name TotCasA00JOHN DayCasA00JOHN

sort date

compress

save "Iran JOHN Cases.dta", replace


* merge deaths and cases 

use "Iran JOHN deaths.dta", clear 

merge 1:1 date using "Iran JOHN Cases.dta"

drop _merge

save "Iran JOHN.dta", replace




* graphs

ssc install grstyle, replace

grstyle init

grstyle color background white


* daily deaths

twoway ///
(line DayDeaA00JOHN date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) 

graph save "graph COVID-19 daily deaths, Iran, Johns Hopkins 1.gph", replace
// // graph export "graph COVID-19 daily deaths, Iran, Johns Hopkins 1.pdf", replace



* daily deaths and daily deaths with correction factors

twoway ///
(line DayDeaA00JOHN date, sort lcolor(black)) ///
(rarea DayDeaA00JOHN_CF2 DayDeaA00JOHN_CF5 date, sort color(black*0.2)) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Johns Hopkins" 2 "CF 2-5"))


graph save "graph COVID-19 daily deaths, Iran, Johns Hopkins 2.gph", replace
// // graph export "graph COVID-19 daily deaths, Iran, Johns Hopkins 2.pdf", replace



* daily cases 

twoway ///
(line DayCasA00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) 


graph save "graph COVID-19 daily cases, Iran, Johns Hopkins.gph", replace
// // graph export "graph COVID-19 daily cases, Iran, Johns Hopkins.pdf", replace





*************************************

* Locate peak dates and values - deaths 


* first peak 

summ DayDeaA00JOHN if date > td(01mar2020) & date < td(30apr2020) // 158

list date if DayDeaA00JOHN > 157.99 & date > td(01mar2020) & date < td(30apr2020) // 04apr2020

* second peak

summ DayDeaA00JOHN if date > td(01jul2020) & date < td(30jul2020) // 235

list date if DayDeaA00JOHN > 234.99 & date > td(01jul2020) & date < td(30jul2020) // 28jul2020

* third peak

summ DayDeaA00JOHN if date > td(01nov2020) & date < td(30nov2020) //  486

list date if DayDeaA00JOHN > 485.99 & date > td(01nov2020) & date < td(30nov2020) // 16nov2020

* plateu after third peak

list DayDeaA00JOHN if date == td(01jan2021) // start of plateu = 114 	

* start increase after plateu was about 21-02-01

summ DayDeaA00JOHN if date == td(01feb2021) // 79



* Locate peak dates and values - cases 


* first peak 

summ DayCasA00JOHN if date > td(01mar2020) & date < td(30apr2020) // 3186 

list date if DayCasA00JOHN == 3186 & date > td(01mar2020) & date < td(30apr2020) // 30mar2020

* second peak 

summ DayCasA00JOHN if date > td(01may2020) & date < td(30jun2020) // 3574 

list date if DayCasA00JOHN == 3574 & date > td(01may2020) & date < td(30jun2020) // 04jun2020

* third peak 

summ DayCasA00JOHN if date > td(01nov2020) & date < td(30dec2020) // 14051 

list date if DayCasA00JOHN == 14051 & date > td(01nov2020) & date < td(30dec2020) // 27nov2020

* plateu after third peak

summ DayCasA00JOHN if date > td(01dec2020) & date < td(30dec2020) // min = 5502

list date if DayCasA00JOHN == 5502 & date > td(01dec2020) & date < td(30dec2020) // min = 27dec2020

* start increase after plateu was about 21-02-01

summ DayCasA00JOHN if date == td(01feb2021) // 6597


view "log Iran JOHN.smcl"

log close

exit, clear




