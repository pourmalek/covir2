

clear all

cd "$pathcovir2"

cd JOHNEMR

capture log close 

log using "log EMR JOHN.smcl", replace

***************************************************************************
* This is "do EMR JOHN.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare Johns Hopkins data for EMR, compare timing of deaths and cases peaks
***************************************************************************



* get Johns Hopkins data for deaths

import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv" ///
, clear varnames(1)

di in red "no problem about message long invalid varname"

di "as far as first date of reports in Johns Hopkins data does not change"

di "in the latter case a code part below would need ammending"

drop lat v4 provincestate

rename countryregion loc_grand_name

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
 
collapse (sum) *

gen loc_grand_name = "EMR"
  
save "EMR JOHN deaths sum.dta", replace


* 

use "EMR JOHN deaths wo sum.dta", clear 

append using "EMR JOHN deaths sum.dta"

*


order loc_grand_name, last

* Check: v5 is 1/22/20    22jan2020

* Check: v33 is 2/19/20   19feb2020 with first two tandem deaths in Qom, Iran

gen counter = _n

reshape long v, i(loc_grand_name) 

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

drop _j 



order date loc_grand_name DayDeaMeRaA00S00V00 TotDeaMeRaA00S00V00 
					

sort loc_grand_name date

save "EMR JOHN deaths.dta", replace



* get Johns Hopkins data for cases


import delimited using ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv" ///
, clear

drop lat v4 provincestate

rename countryregion loc_grand_name

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
 
collapse (sum) *

gen loc_grand_name = "EMR"
  
save "EMR JOHN cases sum.dta", replace


* 

use "EMR JOHN cases wo sum.dta", clear 

append using "EMR JOHN cases sum.dta"

*



order loc_grand_name, last

gen counter = _n

reshape long v, i(loc_grand_name) 

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

drop _j 


order date loc_grand_name DayCasMeRaA00S00V00 TotCasMeRaA00S00V00 

sort loc_grand_name date

compress

save "EMR JOHN Cases.dta", replace


* merge deaths and cases 

use "EMR JOHN deaths.dta", clear 

merge 1:1 loc_grand_name date using "EMR JOHN Cases.dta"

drop _merge




* gen "Daily cases mean div by daily deaths mean JOHN DayCbD" for visulization of temporal relation of deaths and cases peaks 


replace loc_grand_name = "Saudi" if loc_grand_name == "Saudi Arabia"
replace loc_grand_name = "UAE" if loc_grand_name == "United Arab Emirates"



levelsof loc_grand_name, local(levels)

foreach l of local levels {

	di "`l'"
    
	summ DayDeaMeRaA00S00V00 if loc_grand_name == "`l'"

	gen DayDeMMeRaA00S00V00_`l' = r(mean)

	label var DayDeMMeRaA00S00V00_`l' "Daily deaths mean JOHN DayDeM"


	summ DayCasMeRaA00S00V00 if loc_grand_name == "`l'"

	gen DayCaMMeRaA00S00V00_`l' = r(mean)

	label var DayCaMMeRaA00S00V00_`l' "Daily cases mean JOHN DayCaM"

	
	gen DayCbDMeRaA00S00V00_`l' = DayCaMMeRaA00S00V00_`l' / DayDeMMeRaA00S00V00_`l'

	label var DayCbDMeRaA00S00V00_`l' "Daily cases mean div by daily deaths mean JOHN DayCbD"
	
	
	gen DayDea_multip_`l' = DayDeaMeRaA00S00V00 * DayCbDMeRaA00S00V00_`l' if loc_grand_name == "`l'"

    label var DayDea_multip_`l' "Daily deaths scaled (times means of cases by deaths) only for visualization JOHN "
	
    summ DayCbDMeRaA00S00V00_`l'  DayCaMMeRaA00S00V00_`l'  DayDeMMeRaA00S00V00_`l' DayDea_multip_`l' 
	
	
	di "divider---------------------"
}
*


gen DayCfrMeRaA00S00V00 = 100 * DayDeaMeRaA00S00V00 / DayCasMeRaA00S00V00

label var DayCfrMeRaA00S00V00 "Daily CFR JOHN"

di in red "negative CFR values:"

list date loc_grand_name DayDeaMeRaA00S00V00 DayCasMeRaA00S00V00 DayCfrMeRaA00S00V00 if DayCfrMeRaA00S00V00 < 0



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

twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(blue)) ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(red)) ///
(line DayDea_multip_`l' date, sort lpattern(dot) lcolor(red)) ///
if date > td(01jan2020) & loc_grand_name == "`l'" ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases and deaths) title("COVID-19 daily cases and deaths, `l', Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) yscale(titlegap(4)) legend(region(lcolor(none)))  ///
legend(order(1 "Daily cases" 2 "Daily deaths" 3 "Daily deaths scaled for visualization") size(small)) ///
subtitle("Daily deaths, scaled = times (means of cases divided by deaths) for visualization only", size(small))

graph save "graph 1 COVID-19 daily deaths and cases `l' Johns Hopkins.gph", replace
graph export "graph 1 COVID-19 daily deaths and cases `l' Johns Hopkins.pdf", replace




twoway ///
(line DayCfrMeRaA00S00V00 date, sort lcolor(black)) ///
if date > td(01jan2020) & loc_grand_name == "`l'" ///
, xtitle(Date) xlabel(`dates2020' `dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, `l', Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) 


graph save "graph 2 COVID-19 daily CFR, `l', Johns Hopkins.gph", replace
graph export "graph 2 COVID-19 daily CFR, `l', Johns Hopkins.pdf", replace


}
*






view "log EMR JOHN.smcl"

log close

exit, clear




