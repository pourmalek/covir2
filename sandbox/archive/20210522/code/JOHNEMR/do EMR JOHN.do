

clear all

cd "$pathcovir2"

cd JOHNEMR

capture log close 

log using "log EMR JOHN.smcl", replace

***************************************************************************
* This is "do EMR JOHN.do"

* Project: COVID-19 Iran Review No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare Johns Hopkins data for EMR, compare timing of deaths and cases peaks
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

qui destring *, replace



* gen global sum

save "global JOHN deaths wo sum.dta", replace

drop loc_grand_name

qui destring *, replace
 
collapse (sum) *

gen loc_grand_name = "global"
  
save "global JOHN deaths sum.dta", replace

*


use "global JOHN deaths wo sum.dta", clear



keep if ///
loc_grand_name == "Algeria" | ///
loc_grand_name == "Bahrain" | ///
loc_grand_name == "Djibouti" | ///
loc_grand_name == "Egypt" | ///
loc_grand_name == "Iran" | ///
loc_grand_name == "Iraq" | ///
loc_grand_name == "Israel" | ///
loc_grand_name == "Jordan" | ///
loc_grand_name == "Kuwait" | ///
loc_grand_name == "Lebanon" | ///
loc_grand_name == "Libya" | ///
loc_grand_name == "Oman" | ///
loc_grand_name == "Palestine" | ///
loc_grand_name == "Qatar" | ///
loc_grand_name == "Saudi Arabia" | ///
loc_grand_name == "Syria" | ///
loc_grand_name == "Tunisia" | ///
loc_grand_name == "United Arab Emirates" | ///
loc_grand_name == "Yemen" 


* gen EMR sum

save "EMR JOHN deaths wo sum.dta", replace

drop loc_grand_name

qui destring *, replace
 
collapse (sum) *

gen loc_grand_name = "EMR"
  
save "EMR JOHN deaths sum.dta", replace


* 

use "EMR JOHN deaths wo sum.dta", clear 

qui append using "EMR JOHN deaths sum.dta"

qui append using "global JOHN deaths sum.dta"


*


order loc_grand_name, last

gen counter = _n

reshape long v, i(loc_grand_name) 

drop counter 

codebook _j

gen date = date("22 Jan 2020", "DMY")

replace date = date + _j - 1

format date %td

codebook date

order date 

rename v TotDeaMeRaA00S00

label var TotDeaMeRaA00S00 "Total Deaths JOHN"

destring TotDeaMeRaA00S00, replace

list loc_grand_name TotDeaMeRaA00S00 if date == td(19feb2020) // Iran should be 2

gen DayDeaMeRaA00S00 =  TotDeaMeRaA00S00[_n] - TotDeaMeRaA00S00[_n-1]

label var DayDeaMeRaA00S00 "Daily Deaths JOHN"

replace DayDeaMeRaA00S00 = TotDeaMeRaA00S00 if _j == 1

drop _j _merge


order date loc_grand_name DayDeaMeRaA00S00 TotDeaMeRaA00S00 
					

sort loc_grand_name date

save "EMR JOHN deaths.dta", replace




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

qui destring *, replace



* gen global sum

save "global JOHN cases wo sum.dta", replace

drop loc_grand_name

qui destring *, replace
 
collapse (sum) *

gen loc_grand_name = "global"
  
save "global JOHN cases sum.dta", replace

*


use "global JOHN cases wo sum.dta", clear




keep if ///
loc_grand_name == "Algeria" | ///
loc_grand_name == "Bahrain" | ///
loc_grand_name == "Djibouti" | ///
loc_grand_name == "Egypt" | ///
loc_grand_name == "Iran" | ///
loc_grand_name == "Iraq" | ///
loc_grand_name == "Israel" | ///
loc_grand_name == "Jordan" | ///
loc_grand_name == "Kuwait" | ///
loc_grand_name == "Lebanon" | ///
loc_grand_name == "Libya" | ///
loc_grand_name == "Oman" | ///
loc_grand_name == "Palestine" | ///
loc_grand_name == "Qatar" | ///
loc_grand_name == "Saudi Arabia" | ///
loc_grand_name == "Syria" | ///
loc_grand_name == "Tunisia" | ///
loc_grand_name == "United Arab Emirates" | ///
loc_grand_name == "Yemen" 



* gen EMR sum

save "EMR JOHN cases wo sum.dta", replace

drop loc_grand_name

qui destring *, replace
 
collapse (sum) *

gen loc_grand_name = "EMR"
  
save "EMR JOHN cases sum.dta", replace


* 

use "EMR JOHN cases wo sum.dta", clear 

qui append using "EMR JOHN cases sum.dta"

qui append using "global JOHN cases sum.dta"


*



order loc_grand_name, last

gen counter = _n

reshape long v, i(loc_grand_name) 

drop counter 

codebook _j

gen date = date("22 Jan 2020", "DMY")

replace date = date + _j - 1

format date %td

codebook date

order date 

rename v TotCasMeRaA00S00

label var TotCasMeRaA00S00 "Total Cases JOHN"

gen DayCasMeRaA00S00 =  TotCasMeRaA00S00[_n] - TotCasMeRaA00S00[_n-1]

label var DayCasMeRaA00S00 "Daily Cases JOHN"

replace DayCasMeRaA00S00 = TotCasMeRaA00S00 if _j == 1

drop _j _merge


order date loc_grand_name DayCasMeRaA00S00 TotCasMeRaA00S00 

sort loc_grand_name date

compress

save "EMR JOHN Cases.dta", replace


* merge deaths and cases 

use "EMR JOHN deaths.dta", clear 

merge 1:1 loc_grand_name date using "EMR JOHN Cases.dta"

drop _merge





replace loc_grand_name = "Saudi_Arabia" if loc_grand_name == "Saudi Arabia"
replace loc_grand_name = "UAE" if loc_grand_name == "United Arab Emirates"

replace loc_grand_name = "1_Global" if loc_grand_name == "global"
replace loc_grand_name = "2_EMR" if loc_grand_name == "EMR"




* gen "Daily cases mean div by daily deaths mean JOHN DayCbD" for visulization of temporal relation of deaths and cases peaks 


levelsof loc_grand_name, local(levels)

foreach l of local levels {

	di "`l'"
    
	di "DayDeaMeRaA00S00"
	summ DayDeaMeRaA00S00 if loc_grand_name == "`l'"
	gen DayDeMMeRaA00S00_`l' = r(mean)
	label var DayDeMMeRaA00S00_`l' "Daily deaths mean JOHN DayDeM"
	di "                            "

	di "DayCasMeRaA00S00"
	summ DayCasMeRaA00S00 if loc_grand_name == "`l'"
	gen DayCaMMeRaA00S00_`l' = r(mean)
	label var DayCaMMeRaA00S00_`l' "Daily cases mean JOHN DayCaM"
	di "                            "

	di "DayCbDMeRaA00S00_(location)"
	gen DayCbDMeRaA00S00_`l' = DayCaMMeRaA00S00_`l' / DayDeMMeRaA00S00_`l'
	label var DayCbDMeRaA00S00_`l' "Daily cases mean div by daily deaths mean JOHN DayCbD"
	summ DayCbDMeRaA00S00_`l' if loc_grand_name == "`l'"
	di "                            "

	di "DayDea_multip_(location)"
	gen DayDea_multip_`l' = DayDeaMeRaA00S00 * DayCbDMeRaA00S00_`l' if loc_grand_name == "`l'"
    label var DayDea_multip_`l' "Daily deaths scaled (times means of cases by deaths) only for visualization JOHN"
	summ DayDea_multip_`l' if loc_grand_name == "`l'"
	di "                            "
	
	di "divider---------------------"
	di "                            "

}
*


* gen CFR

gen DayCfrMeRaA00S00 = 100 * DayDeaMeRaA00S00 / DayCasMeRaA00S00

label var DayCfrMeRaA00S00 "Daily CFR JOHN"

di in red "negative CFR values:"

list date loc_grand_name DayDeaMeRaA00S00 DayCasMeRaA00S00 DayCfrMeRaA00S00 if DayCfrMeRaA00S00 < 0


* describe CFR

levelsof loc_grand_name, local(levels)

foreach l of local levels {

	di "`l'"

	tabstat DayCfrMeRaA00S00 if loc_grand_name == "`l'" & DayCfrMeRaA00S00 >= 0, stat(p25 p50 p75 iqr mean min max) varwidth(32)

	di "divider---------------------"
	di "                            "

}
*



* gen Cases to deaths ratio (CTD)

gen DayCTDMeRaA00S00 =  DayCasMeRaA00S00 / DayDeaMeRaA00S00
label var DayCTDMeRaA00S00  "Daily Cases to Deaths S0 JOHN"
	
gen TotCTDMeRaA00S00 =  TotCasMeRaA00S00 / TotDeaMeRaA00S00
label var TotCTDMeRaA00S00  "Total Cases to Deaths S0 JOHN"




* describe Cases to deaths ratio (CTD)

levelsof loc_grand_name, local(levels)

foreach l of local levels {

	di "`l'"

	tabstat DayCTDMeRaA00S00 if loc_grand_name == "`l'", stat(p25 p50 p75 iqr mean min max) varwidth(32)
	
	tabstat TotCTDMeRaA00S00 if loc_grand_name == "`l'", stat(p25 p50 p75 iqr mean min max) varwidth(32)
	

	di "divider---------------------"
	di "                            "

}
*








* smooth 

encode loc_grand_name, gen(loc_grand_name_numeric)

tsset loc_grand_name_numeric date, daily   


tssmooth ma DayDeaMeRaA00S00_window = DayDeaMeRaA00S00 if DayDeaMeRaA00S00 >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmA00S00 = DayDeaMeRaA00S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA00S00 "Daily deaths mean smooth JOHN"

drop DayDeaMeRaA00S00_window


tssmooth ma DayCasMeRaA00S00_window = DayCasMeRaA00S00 if DayCasMeRaA00S00 >= 0, window(3 1 3)

tssmooth ma DayCasMeSmA00S00 = DayCasMeRaA00S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasMeSmA00S00 "Daily cases mean smooth JOHN"

drop DayCasMeRaA00S00_window


tssmooth ma DayCfrMeRaA00S00_window = DayCfrMeRaA00S00 if DayCfrMeRaA00S00 >= 0, window(3 1 3)

tssmooth ma DayCfrMeSmA00S00 = DayCfrMeRaA00S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCfrMeSmA00S00 "Daily CFR mean smooth JOHN"

drop DayCfrMeRaA00S00_window


tssmooth ma DayCTDMeRaA00S00_window = DayCTDMeRaA00S00 if DayCTDMeRaA00S00 >= 0, window(3 1 3)

tssmooth ma DayCTDMeSmA00S00 = DayCTDMeRaA00S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCTDMeSmA00S00 "Daily CTD mean smooth JOHN"

drop DayCTDMeRaA00S00_window



tssmooth ma TotCTDMeRaA00S00_window = TotCTDMeRaA00S00 if TotCTDMeRaA00S00 >= 0, window(3 1 3)

tssmooth ma TotCTDMeSmA00S00 = TotCTDMeRaA00S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var TotCTDMeSmA00S00 "Total CTD mean smooth JOHN"

drop TotCTDMeRaA00S00_window




levelsof loc_grand_name, local(levels)

foreach l of local levels {

	tssmooth ma DayDea_multip_`l'_w = DayDea_multip_`l' if (DayDea_multip_`l' >= 0) & (loc_grand_name == "`l'"), window(3 1 3)

	tssmooth ma DayDea_multip_`l'_sm = DayDea_multip_`l'_w if (loc_grand_name == "`l'"), weights( 1 2 3 <4> 3 2 1) replace

	label var DayDea_multip_`l'_w "Daily deaths scaled smooth only for visualization JOHN"

	drop DayDea_multip_`l'_w 
}
* 


* 

tsset, clear



sort date loc_grand_name

qui compress



save "EMR JOHN.dta", replace







**************

* graphs

ssc install grstyle, replace

grstyle init

grstyle color background white







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




levelsof loc_grand_name, local(levels)

foreach l of local levels {



** DayCas DayDea DayDea_multip


* DayCas DayDea DayDea_multip, all raw

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(blue)) ///
(line DayDeaMeRaA00S00 date, sort lcolor(red)) ///
(line DayDea_multip_`l' date, sort lpattern(dot) lcolor(red)) ///
if date > td(01jan2020) & loc_grand_name == "`l'" ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases and deaths) title("COVID-19 daily cases and deaths, `l', Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) yscale(titlegap(4)) legend(region(lcolor(none)))  ///
legend(order(1 "Daily cases" 2 "Daily deaths" 3 "Daily deaths scaled for visualization") size(small)) ///
subtitle("Daily deaths, scaled = times (means of cases divided by deaths) for visualization only", size(small))

qui graph save "graph 1 COVID-19 daily deaths and cases `l' Johns Hopkins.gph", replace
qui graph export "graph 1 COVID-19 daily deaths and cases `l' Johns Hopkins.pdf", replace





* DayCas DayDea DayDea_multip, all smooth

twoway ///
(line DayCasMeSmA00S00 date, sort lcolor(blue)) ///
(line DayDeaMeSmA00S00 date, sort lcolor(red)) ///
(line DayDea_multip_`l'_sm date, sort lpattern(dot) lcolor(red)) ///
if date > td(01jan2020) & loc_grand_name == "`l'" ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases and deaths smoothed) title("COVID-19 daily cases and deaths smoothed, `l', Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) yscale(titlegap(4)) legend(region(lcolor(none)))  ///
legend(order(1 "Daily cases smoothed" 2 "Daily deaths smoothed" 3 "Daily deaths scaled for visualization, smoothed") size(small)) ///
subtitle("Daily deaths, scaled = times (means of cases divided by deaths) for visualization only, smoothed", size(small))

qui graph save "graph 2 COVID-19 daily deaths and cases smoothed `l' Johns Hopkins.gph", replace
qui graph export "graph 2 COVID-19 daily deaths and cases smoothed `l' Johns Hopkins.pdf", replace





** DayDea

* DayDea, raw and smooth 


twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(gray)) ///
(line DayDeaMeSmA00S00 date, sort lwidth(thick) lcolor(red)) ///
if date > td(01jan2020) & loc_grand_name == "`l'" ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, `l', Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) yscale(titlegap(4)) legend(region(lcolor(none)))  ///
legend(order(1 "Raw" 2 "Smoothed") size(small)) 

qui graph save "graph 3 COVID-19 daily deaths `l' Johns Hopkins.gph", replace
qui graph export "graph 3 COVID-19 daily deaths `l' Johns Hopkins.pdf", replace



** Day CFR

* Day CFR raw

twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(black)) ///
if date > td(01jan2020) & loc_grand_name == "`l'" ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, `l', Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) 

qui graph save "graph 4 COVID-19 daily CFR, `l', Johns Hopkins.gph", replace
qui graph export "graph 4 COVID-19 daily CFR, `l', Johns Hopkins.pdf", replace



* Day CFR smoothed

twoway ///
(line DayCfrMeSmA00S00 date, sort lcolor(black)) ///
if date > td(01jan2020) & loc_grand_name == "`l'" ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR smoothed) title("COVID-19 daily CFR, smoothed, `l', Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) 

qui graph save "graph 5 COVID-19 daily CFR, smoothed `l', Johns Hopkins.gph", replace
qui graph export "graph 5 COVID-19 daily CFR, smoothed `l', Johns Hopkins.pdf", replace




* Day CFR raw and smoothed

twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(gray)) ///
(line DayCfrMeSmA00S00 date, sort lwidth(thick) lcolor(red)) ///
if date > td(01jan2020) & loc_grand_name == "`l'" ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, `l', Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Raw" 2 "Smoothed") size(small)) ///

qui graph save "graph 6 COVID-19 daily CFR, raw and smoothed, `l', Johns Hopkins.gph", replace
qui graph export "graph 6 COVID-19 daily CFR, raw and smoothed, `l', Johns Hopkins.pdf", replace




** Cases to deaths ratio (CTD)


* Day CTD raw and smoothed

twoway ///
(line DayCTDMeRaA00S00 date, sort lcolor(gray)) ///
(line DayCTDMeSmA00S00 date, sort lwidth(thick) lcolor(red)) ///
if date > td(01jan2020) & loc_grand_name == "`l'" ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily Cases to deaths ratio) title("COVID-19 daily cases to deaths ratio, `l', Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Raw" 2 "Smoothed") size(small)) ///

qui graph save "graph 7 COVID-19 daily CTD, raw and smoothed, `l', Johns Hopkins.gph", replace
qui graph export "graph 7 COVID-19 daily CTD, raw and smoothed, `l', Johns Hopkins.pdf", replace




* Tot CTD raw and smoothed

twoway ///
(line TotCTDMeRaA00S00 date, sort lcolor(gray)) ///
(line TotCTDMeSmA00S00 date, sort lwidth(thick) lcolor(red)) ///
if date > td(01jan2020) & loc_grand_name == "`l'" ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total Cases to deaths ratio) title("COVID-19 total cases to deaths ratio, `l', Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Raw" 2 "Smoothed") size(small)) ///

qui graph save "graph 8 COVID-19 total CTD, raw and smoothed, `l', Johns Hopkins.gph", replace
qui graph export "graph 8 COVID-19 total CTD, raw and smoothed, `l', Johns Hopkins.pdf", replace



}
*








view "log EMR JOHN.smcl"

log close

exit, clear




