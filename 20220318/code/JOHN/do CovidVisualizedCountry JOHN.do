
clear all

cd "$pathCovidVisualizedCountry"

cd JOHN

capture log close 

log using "log CovidVisualizedCountry JOHN.smcl", replace

***************************************************************************
* This is "do CovidVisualizedCountry JOHN.do"

* Project: Combine and visualize international periodically updating 
* estimates of COVID-19 at the country level (CovidVisualizedCountry)
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dotcom
* Time (initial): 2021-04-14
***************************************************************************




****************************************

* get Johns Hopkins data for deaths


import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv" ///
, clear varnames(1) colrange(1:2)

save "time_series_covid19_deaths_global col 2.dta", replace


import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv" ///
, clear varnames(1) colrange(5)

save "time_series_covid19_deaths_global col 5 on.dta", replace


use "time_series_covid19_deaths_global col 2.dta", clear 

merge 1:1 _n using "time_series_covid19_deaths_global col 5 on.dta"

drop _merge

replace countryregion = trim(countryregion)

rename countryregion loc_grand_name

label var loc_grand_name loc_grand_name

keep if loc_grand_name == "$country"

qui destring v*, replace

save "time_series_covid19_deaths_global.dta", replace 





* gen national sum

collapse (sum) v*, by(loc_grand_name) 

gen provincestate = " National"

order provincestate

save "time_series_covid19_deaths_global National sum.dta", replace



* append National sum to subNationals

use "time_series_covid19_deaths_global.dta", clear 

gen provincestate_proper = provincestate // non-provincestate_proper is included in National sum

replace provincestate_proper = "" if provincestate == "Diamond Princess" | ///
 provincestate == "Grand Princess" |  provincestate == "Repatriated Travellers"

drop if provincestate_proper == ""

qui append using "time_series_covid19_deaths_global National sum.dta"

order provincestate loc_grand_name, last 

save "time_series_covid19_deaths_global with National sum.dta", replace


* reshape 

order loc_grand_name, last

gen counter = _n

qui reshape long v, i(counter) 

drop counter 

codebook _j


* JOHN starts from 22 Jan 2020

gen date = date("22 Jan 2020", "DMY")

sort loc_grand_name date

bysort loc_grand_name: replace date = date + _j - 1

format date %td

codebook date

order date 

rename v TotDeaMeRaA00S00

label var TotDeaMeRaA00S00 "Total deaths raw A00 JOHN"

destring TotDeaMeRaA00S00, replace

gen DayDeaMeRaA00S00 =  TotDeaMeRaA00S00[_n] - TotDeaMeRaA00S00[_n-1]

label var DayDeaMeRaA00S00 "Daily deaths raw A00 JOHN"

replace DayDeaMeRaA00S00 = TotDeaMeRaA00S00 if _j == 1

drop _j 

order loc_grand_name date provincestate_proper DayDeaMeRaA00S00 TotDeaMeRaA00S00		

sort loc_grand_name provincestate_proper date 


* replace outcomes = . before first date reported


levelsof provincestate, local(levels)

foreach l of local levels {

summ date if provincestate == "`l'" & TotDeaMeRaA00S00 == 0

gen TotDeaMeRaA00S00zerodate = r(max)

replace DayDeaMeRaA00S00 = . if date <= r(max) & provincestate == "`l'"

replace TotDeaMeRaA00S00 = . if date <= r(max) & provincestate == "`l'"

drop TotDeaMeRaA00S00zerodate

}
*

qui compress

save "$country JOHN deaths.dta", replace




****************************************

* get Johns Hopkins data for cases


import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv" ///
, clear varnames(1) colrange(1:2)

save "time_series_covid19_confirmed_global col 2.dta", replace


import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv" ///
, clear varnames(1) colrange(5)

save "time_series_covid19_confirmed_global col 5 on.dta", replace


use "time_series_covid19_confirmed_global col 2.dta", clear 

merge 1:1 _n using "time_series_covid19_confirmed_global col 5 on.dta"

drop _merge

replace countryregion = trim(countryregion)

rename countryregion loc_grand_name

label var loc_grand_name loc_grand_name

keep if loc_grand_name == "$country"

qui destring v*, replace

save "time_series_covid19_confirmed_global.dta", replace 



* gen National sum

collapse (sum) v*, by(loc_grand_name) 

gen provincestate = " National"

order provincestate

save "time_series_covid19_confirmed_global national sum.dta", replace



* append national sum to subnationals

use "time_series_covid19_confirmed_global.dta", clear 

gen provincestate_proper = provincestate // non-provincestate_proper is included in national sum // provincestate names for "$country"

replace provincestate_proper = "" if provincestate == "Diamond Princess" | ///
 provincestate == "Grand Princess" |  provincestate == "Repatriated Travellers"

drop if provincestate_proper == ""

qui append using "time_series_covid19_confirmed_global national sum.dta"

order provincestate loc_grand_name, last 

save "time_series_covid19_confirmed_global with national sum.dta", replace


* reshape 

order loc_grand_name, last

gen counter = _n

qui reshape long v, i(counter) 

drop counter 

codebook _j


* JOHN starts from 22 Jan 2020

gen date = date("22 Jan 2020", "DMY")

sort loc_grand_name date

bysort loc_grand_name: replace date = date + _j - 1

format date %td

codebook date

order date 

rename v TotCasMeRaA00S00

label var TotCasMeRaA00S00 "Total cases raw A00 JOHN"

destring TotCasMeRaA00S00, replace

gen DayCasMeRaA00S00 =  TotCasMeRaA00S00[_n] - TotCasMeRaA00S00[_n-1]

label var DayCasMeRaA00S00 "Daily cases raw A00 JOHN"

replace DayCasMeRaA00S00 = TotCasMeRaA00S00 if _j == 1

drop _j 

order loc_grand_name date provincestate_proper DayCasMeRaA00S00 TotCasMeRaA00S00	

sort loc_grand_name provincestate_proper date 


* replace outcomes = . before first date reported


levelsof provincestate, local(levels)

foreach l of local levels {

summ date if provincestate == "`l'" & TotCasMeRaA00S00 == 0

gen TotCasMeRaA00S00zerodate = r(max)

replace DayCasMeRaA00S00 = . if date <= r(max) & provincestate == "`l'"

replace TotCasMeRaA00S00 = . if date <= r(max) & provincestate == "`l'"

drop TotCasMeRaA00S00zerodate

}
*

qui compress

save "$country JOHN cases.dta", replace






****************************************

* merge deaths and cases 

use "$country JOHN deaths.dta", clear 

merge 1:1 date loc_grand_name provincestate using "$country JOHN Cases.dta"

drop _merge



*

* gen cfr

gen DayCfrMeRaA00S00 = 100 * DayDeaMeRaA00S00 / DayCasMeRaA00S00

label var DayCfrMeRaA00S00 "Daily CFR raw JOHN"

*





*************************

* to visualize timing of deaths and cases peaks

summ DayDeaMeRaA00S00 
gen DayDeMMeRaA00S00 = r(mean)
label var DayDeMMeRaA00S00 "Daily deaths raw mean JOHN DayDeM"

summ DayCasMeRaA00S00 
gen DayCaMMeRaA00S00 = r(mean)
label var DayCaMMeRaA00S00 "Daily cases raw mean JOHN DayCaM"

gen DayCbDMeRaA00S00 = DayCaMMeRaA00S00 / DayDeMMeRaA00S00
label var DayCbDMeRaA00S00 "Daily cases mean div by daily deaths mean JOHN DayCbD"
summ DayCbDMeRaA00S00 

gen DayDeaMeRaA00multip = DayDeaMeRaA00S00 * DayCbDMeRaA00S00 
label var DayDeaMeRaA00multip "Daily deaths scaled (times means of cases by deaths) only for visualization JOHN"
summ DayDeaMeRaA00multip




******************

* smooth 

encode provincestate, gen(provincestate_encoded)

tsset provincestate_encoded date, daily   


tssmooth ma DayDeaMeRaA00S00_window = DayDeaMeRaA00S00 if DayDeaMeRaA00S00 >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmA00S00 = DayDeaMeRaA00S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA00S00 "Daily deaths smooth A00 JOHN"

drop DayDeaMeRaA00S00_window


tssmooth ma DayCasMeRaA00S00_window = DayCasMeRaA00S00 if DayCasMeRaA00S00 >= 0, window(3 1 3)

tssmooth ma DayCasMeSmA00S00 = DayCasMeRaA00S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasMeSmA00S00 "Daily cases smooth A00 JOHN"

drop DayCasMeRaA00S00_window


tssmooth ma DayCfrMeRaA00S00_window = DayCfrMeRaA00S00 if DayCfrMeRaA00S00 >= 0, window(3 1 3)

tssmooth ma DayCfrMeSmA00S00 = DayCfrMeRaA00S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCfrMeSmA00S00 "Daily CFR smooth A00 JOHN"

drop DayCfrMeRaA00S00_window



tssmooth ma DayDeaMeRaA00multip_window = DayDeaMeRaA00multip if DayDeaMeRaA00multip >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmA00multip = DayDeaMeRaA00multip_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA00multip "Daily deaths scaled smooth A00 JOHN"

drop DayDeaMeRaA00multip_window



drop provincestate_encoded

tsset, clear


*

* gen vars by provincestate 

foreach var of varlist DayDeaMeRaA00S00 TotDeaMeRaA00S00 DayCasMeRaA00S00 TotCasMeRaA00S00 ///
DayCfrMeRaA00S00 DayDeMMeRaA00S00 DayCaMMeRaA00S00 DayCbDMeRaA00S00 DayDeaMeRaA00multip ///
DayDeaMeSmA00S00 DayCasMeSmA00S00 DayCfrMeSmA00S00 DayDeaMeSmA00multip {

*

qui gen `var'XAB = `var' 
qui replace `var'XAB = . if provincestate != "Alberta"

qui gen `var'XBC = `var'
qui replace `var'XBC = . if provincestate != "British Columbia"

qui gen `var'XMB = `var'
qui replace `var'XMB = . if provincestate != "Manitoba"

qui gen `var'XXX = `var'
qui replace `var'XXX = . if provincestate != " National"

qui gen `var'XNB = `var'
qui replace `var'XNB = . if provincestate != "New Brunswick"

qui gen `var'XNL = `var'
qui replace `var'XNL = . if provincestate != "Newfoundland and Labrador"

qui gen `var'XNT = `var'
qui replace `var'XNT = . if provincestate != "Northwest Territories"

qui gen `var'XNS = `var'
qui replace `var'XNS = . if provincestate != "Nova Scotia"

qui gen `var'XNU = `var'
qui replace `var'XNU = . if provincestate != "Nunavut"

qui gen `var'XON = `var'
qui replace `var'XON = . if provincestate != "Ontario"

qui gen `var'XPE = `var'
qui replace `var'XPE = . if provincestate != "Prince Edward Island"

qui gen `var'XQC = `var'
qui replace `var'XQC = . if provincestate != "Quebec"

qui gen `var'XSK = `var'
qui replace `var'XSK = . if provincestate != "Saskatchewan"

qui gen `var'XYT = `var'
qui replace `var'XYT = . if provincestate != "Yukon"

label var `var'XAB "`var' Alberta"
label var `var'XBC "`var' British Columbia"
label var `var'XMB "`var' Manitoba"
label var `var'XXX "`var' National"
label var `var'XNB "`var' New Brunswick"
label var `var'XNL "`var' Newfoundland and Labrador"
label var `var'XNT "`var' Northwest Territories"
label var `var'XNS "`var' Nova Scotia"
label var `var'XNU "`var' Nunavut"
label var `var'XON "`var' Ontario"
label var `var'XPE "`var' Prince Edward Island"
label var `var'XQC "`var' Quebec"
label var `var'XSK "`var' Saskatchewan"
label var `var'XYT "`var' Yukon"


                
}
*




sort loc_grand_name provincestate date

order loc_grand_name provincestate date

qui compress

save "CovidVisualizedCountry JOHN.dta", replace





view "log CovidVisualizedCountry JOHN.smcl"

log close

exit, clear




