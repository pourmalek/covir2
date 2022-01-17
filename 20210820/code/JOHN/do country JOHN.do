

clear all

cd "$pathcovir2"

cd JOHN

capture log close 

log using "log country JOHN.smcl", replace

***************************************************************************
* This is "do country JOHN.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare Johns Hopkins data for country
***************************************************************************



* get Johns Hopkins data for deaths


import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv" ///
, clear varnames(1) colrange(2:2)

save "time_series_covid19_deaths_global col 2.dta", replace


import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv" ///
, clear varnames(1) colrange(5)


save "time_series_covid19_deaths_global col 5 on.dta", replace


use "time_series_covid19_deaths_global col 2.dta", clear 

merge 1:1 _n using "time_series_covid19_deaths_global col 5 on.dta"


rename countryregion loc_grand_name

label var loc_grand_name "location grand name"

keep if regexm(loc_grand_name,"$country") == 1

order loc_grand_name, last

gen counter = _n

reshape long v, i(counter) 

drop counter 

codebook _j

// replace _j = _j - 4 // compensate for first vars in the original file

gen date = date("22 Jan 2020", "DMY")

replace date = date + _j - 1

format date %td

codebook date

order date 

rename v TotDeaMeRaA00S00

label var TotDeaMeRaA00S00 "Total Deaths JOHN"

destring TotDeaMeRaA00S00, replace

list TotDeaMeRaA00S00 if date == td(19feb2020) // Shoule be 2

gen DayDeaMeRaA00S00 =  TotDeaMeRaA00S00[_n] - TotDeaMeRaA00S00[_n-1]

label var DayDeaMeRaA00S00 "Daily Deaths JOHN"

replace DayDeaMeRaA00S00 = TotDeaMeRaA00S00 if _j == 1

replace TotDeaMeRaA00S00 = . if date < td(19feb2020)

replace DayDeaMeRaA00S00 = . if date < td(19feb2020)

drop _j _merge



gen DayDeaMeRaA00S00_CF2 = DayDeaMeRaA00S00 * 2

label var DayDeaMeRaA00S00_CF2 "Daily Deaths JOHN correction factor 2"

gen DayDeaMeRaA00S00_CF5 = DayDeaMeRaA00S00 * 5

label var DayDeaMeRaA00S00_CF5 "Daily Deaths JOHN correction factor 5"

gen TotDeaMeRaA00S00_CF2 = TotDeaMeRaA00S00 * 2

label var TotDeaMeRaA00S00_CF2 "Total Deaths JOHN correction factor 2"

gen TotDeaMeRaA00S00_CF5 = TotDeaMeRaA00S00 * 5

label var TotDeaMeRaA00S00_CF5 "Total Deaths JOHN correction factor 5"



order date loc_grand_name DayDeaMeRaA00S00 TotDeaMeRaA00S00 DayDeaMeRaA00S00_CF2 DayDeaMeRaA00S00_CF5 TotDeaMeRaA00S00_CF2 TotDeaMeRaA00S00_CF5
					

sort date

save "country JOHN deaths.dta", replace









* get Johns Hopkins data for cases


import delimited using ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv" ///
, clear varnames(1) colrange(2:2)

save "time_series_covid19_confirmed_global col 2.dta", replace


import delimited using ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv" ///
, clear varnames(1) colrange(5)

save "time_series_covid19_confirmed_global col 5 on.dta", replace


use "time_series_covid19_confirmed_global col 2.dta", clear 

merge 1:1 _n using "time_series_covid19_confirmed_global col 5 on.dta"


rename countryregion loc_grand_name

keep if regexm(loc_grand_name,"$country") == 1

order loc_grand_name, last

gen counter = _n

reshape long v, i(counter) 

drop counter 

codebook _j

gen date = date("22 Jan 2020", "DMY")

replace date = date + _j - 1

format date %td

codebook date

order date 

rename v TotCasMeRaA00S00

label var TotCasMeRaA00S00 "Total Cases JOHN"

destring TotCasMeRaA00S00, replace

gen DayCasMeRaA00S00 =  TotCasMeRaA00S00[_n] - TotCasMeRaA00S00[_n-1]

label var DayCasMeRaA00S00 "Daily Cases JOHN"

replace DayCasMeRaA00S00 = TotCasMeRaA00S00 if _j == 1

replace TotCasMeRaA00S00 = . if date < td(19feb2020)

replace DayCasMeRaA00S00 = . if date < td(19feb2020)

drop _j _merge


gen DayCasMeRaA00S00_CF2 = DayCasMeRaA00S00 * 2

label var DayCasMeRaA00S00_CF2 "Daily Cases JOHN correction factor 2"

gen DayCasMeRaA00S00_CF5 = DayCasMeRaA00S00 * 5

label var DayCasMeRaA00S00_CF5 "Daily Cases JOHN correction factor 5"

gen TotCasMeRaA00S00_CF2 = TotCasMeRaA00S00 * 2

label var TotCasMeRaA00S00_CF2 "Total Cases JOHN correction factor 2"

gen TotCasMeRaA00S00_CF5 = TotCasMeRaA00S00 * 5

label var TotCasMeRaA00S00_CF5 "Total Cases JOHN correction factor 5"


order date loc_grand_name DayCasMeRaA00S00 TotCasMeRaA00S00 DayCasMeRaA00S00_CF2 DayCasMeRaA00S00_CF5 TotCasMeRaA00S00_CF2 TotCasMeRaA00S00_CF5

sort date

compress

save "country JOHN Cases.dta", replace








* get Johns Hopkins data for recovered

import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv" ///
, clear varnames(1) colrange(2:2)

save "time_series_covid19_recovered_global col 2.dta", replace


import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv" ///
, clear varnames(1) colrange(5)

save "time_series_covid19_recovered_global col 5 on.dta", replace


use "time_series_covid19_recovered_global col 2.dta", clear 

merge 1:1 _n using "time_series_covid19_recovered_global col 5 on.dta"


rename countryregion loc_grand_name

keep if regexm(loc_grand_name,"$country") == 1

order loc_grand_name, last


gen counter = _n

reshape long v, i(counter) 

drop counter 

codebook _j


gen date = date("22 Jan 2020", "DMY")

replace date = date + _j - 1

format date %td

codebook date

order date 

rename v TotRecMeRaA00S00

label var TotRecMeRaA00S00 "Total RECovered JOHN"

destring TotRecMeRaA00S00, replace

list TotRecMeRaA00S00 if date == td(19feb2020) // Shoule be 2

gen DayRecMeRaA00S00 =  TotRecMeRaA00S00[_n] - TotRecMeRaA00S00[_n-1]

label var DayRecMeRaA00S00 "Daily RECovered JOHN"

replace DayRecMeRaA00S00 = TotRecMeRaA00S00 if _j == 1

replace TotRecMeRaA00S00 = . if date < td(19feb2020)

replace DayRecMeRaA00S00 = . if date < td(19feb2020)

drop _j _merge
					

sort date

save "country JOHN recovered.dta", replace







* merge deaths and cases and recovered

use "country JOHN deaths.dta", clear 

merge 1:1 date using "country JOHN Cases.dta"

drop _merge

merge 1:1 date using "country JOHN recovered.dta"

drop _merge

*

* gen cfr

gen DayCfrMeRaA00S00 = 100 * DayDeaMeRaA00S00 / DayCasMeRaA00S00

label var DayCfrMeRaA00S00 "Daily CFR JOHN"

*


****** add obs 01 Jan 2020 to 21 Jan 2020 for better graphing


expand 22 in 1

sort date

rename date date_original 

gen date = .

replace date = td(01Jan2020) in 1

replace date = date[_n-1] + 1 in 2/l

format date %tdDDMonCCYY

codebook date

drop date_original

order date


* gen prevalent case

* Daily prevalent cases = Total Cases - (Total Deaths + Total recovered)

gen DayActMeRaA00S00 = TotCasMeRaA00S00 - TotDeaMeRaA00S00 - TotRecMeRaA00S00

label var DayActMeRaA00S00 "Daily Active JOHN"



* smooth 

tsset date, daily   


tssmooth ma DayDeaMeRaA00S00_window = DayDeaMeRaA00S00 if DayDeaMeRaA00S00 >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmA00S00 = DayDeaMeRaA00S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA00S00 "Daily deaths smooth A00 JOHN"

drop DayDeaMeRaA00S00_window


tssmooth ma DayCasMeRaA00S00_window = DayCasMeRaA00S00 if DayCasMeRaA00S00 >= 0, window(3 1 3)

tssmooth ma DayCasMeSmA00S00 = DayCasMeRaA00S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasMeSmA00S00 "Daily cases smooth A00 JOHN"

drop DayCasMeRaA00S00_window

tsset, clear



**************

* graphs

ssc install grstyle, replace

grstyle init

grstyle color background white




* daily deaths


* adjust x axis ticks from Jan 2020 to this month and avoid globals
forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
local wanted : di %tdNN daily("$S_DATE", "DMY")
forval i = 1(1)`wanted' {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*



twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(black) lwidth(medium)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "raw" 2 "smooth") size(small) row(1)) 

graph save "graph 1 COVID-19 daily deaths, $country, Johns Hopkins.gph", replace
graph export "graph 1 COVID-19 daily deaths, $country, Johns Hopkins.pdf", replace



* daily cases 


forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
local wanted : di %tdNN daily("$S_DATE", "DMY")
forval i = 1(1)`wanted' {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*


twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(black) lwidth(medium)) /// 1 "JOHN raw"
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "raw" 2 "smooth") size(small) row(1)) 

graph save "graph 2 COVID-19 daily cases, $country, Johns Hopkins.gph", replace
graph export "graph 2 COVID-19 daily cases, $country, Johns Hopkins.pdf", replace




* total deaths

forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
local wanted : di %tdNN daily("$S_DATE", "DMY")
forval i = 1(1)`wanted' {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*


twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) 

graph save "graph 3 COVID-19 total deaths, $country, Johns Hopkins.gph", replace
graph export "graph 3 COVID-19 total deaths, $country, Johns Hopkins.pdf", replace




* total cases 

forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
local wanted : di %tdNN daily("$S_DATE", "DMY")
forval i = 1(1)`wanted' {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*


twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, $country, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) 

graph save "graph 4 COVID-19 total cases, $country, Johns Hopkins.gph", replace
graph export "graph 4 COVID-19 total cases, $country, Johns Hopkins.pdf", replace





* daily cfr 


forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
local wanted : di %tdNN daily("$S_DATE", "DMY")
forval i = 1(1)`wanted' {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*



twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, $country, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) 

graph save "graph 5 COVID-19 daily CFR, $country, Johns Hopkins.gph", replace
graph export "graph 5 COVID-19 daily CFR, $country, Johns Hopkins.pdf", replace





* daily cfr 2021


forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
local wanted : di %tdNN daily("$S_DATE", "DMY")
forval i = 1(1)`wanted' {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*



twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(black)) ///
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, $country, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
subtitle("after 2021-01-01", size(small))

graph save "graph 6 COVID-19 daily CFR, $country, Johns Hopkins, 2021.gph", replace
graph export "graph 6 COVID-19 daily CFR, $country, Johns Hopkins, 2021.pdf", replace





* visualize timing of deaths and cases peaks

summ DayDeaMeRaA00S00 
gen DayDeMMeRaA00S00 = r(mean)
label var DayDeMMeRaA00S00 "Daily deaths mean JOHN DayDeM"

summ DayCasMeRaA00S00 
gen DayCaMMeRaA00S00 = r(mean)
label var DayCaMMeRaA00S00 "Daily cases mean JOHN DayCaM"

gen DayCbDMeRaA00S00 = DayCaMMeRaA00S00 / DayDeMMeRaA00S00
label var DayCbDMeRaA00S00 "Daily cases mean div by daily deaths mean JOHN DayCbD"
summ DayCbDMeRaA00S00

gen DayDeaMeRaA00multip = DayDeaMeRaA00S00 * DayCbDMeRaA00S00 
label var DayDeaMeRaA00multip "Daily deaths scaled (times means of cases by deaths) only for visualization JOHN"
summ DayDeaMeRaA00multip



twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(blue)) ///
(line DayDeaMeRaA00S00 date, sort lcolor(red)) ///
(line DayDeaMeRaA00multip date, sort lpattern(tight_dot) lcolor(red)) ///
if date > td(01jan2020)  /// & date < td(28feb2021) & loc_grand_name == "$country"
, xtitle(Date) xlabel(#14, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases and deaths) title("COVID-19 daily cases and deaths, $country, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none)))  ///
legend(order(1 "Daily cases" 2 "Daily deaths" 3 "Daily deaths scaled for visualization only")) ///
note("Daily deaths scaled (times means of cases by deaths) only for visualization JOHN") ///
subtitle("comparison of timing of peaks", size(small))

graph save "graph 7 COVID-19 daily deaths and cases timing, $country, Johns Hopkins.gph", replace
graph export "graph 7 COVID-19 daily deaths and cases timing, $country, Johns Hopkins.pdf", replace





* daily recovered


* adjust x axis ticks from Jan 2020 to this month and avoid globals
forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
local wanted : di %tdNN daily("$S_DATE", "DMY")
forval i = 1(1)`wanted' {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*



twoway ///
(line DayRecMeRaA00S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily recovered) title("COVID-19 daily recovered, $country, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) 

graph save "graph 8 COVID-19 daily recovered, $country, Johns Hopkins.gph", replace
graph export "graph 8 COVID-19 daily recovered, $country, Johns Hopkins.pdf", replace




* daily active


* adjust x axis ticks from Jan 2020 to this month and avoid globals
forval i = 1(1)12 {
	local date2020 = mdy(`i', 1, 2020)
	local dates2020 `dates2020' `date2020'
}
local wanted : di %tdNN daily("$S_DATE", "DMY")
forval i = 1(1)`wanted' {
	local date2021 = mdy(`i', 1, 2021)
	local dates2021 `dates2021' `date2021'
}
*



twoway ///
(line DayActMeRaA00S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily active) title("COVID-19 daily active cases, $country, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) 

graph save "graph 9 COVID-19 daily active, $country, Johns Hopkins.gph", replace
graph export "graph 9 COVID-19 daily active, $country, Johns Hopkins.pdf", replace


***


qui compress

sort date loc_grand_name


save "country JOHN.dta", replace



view "log country JOHN.smcl"

log close

exit, clear




