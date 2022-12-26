

clear all

cd "$pathcovir2"

cd JOHN

capture log close 

log using "log country JOHN.smcl", replace

***************************************************************************
* This is "do country JOHN.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek 
***************************************************************************






****************************************
****************************************

* get Johns Hopkins data for deaths, all countries

capture shell rm -r "time_series_covid19_deaths_global.csv"

import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv" ///
, clear varnames(1) colrange(1:2)

save "time_series_covid19_deaths_global col 2.dta", replace


capture shell rm -r "time_series_covid19_deaths_global.csv"

import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv" ///
, clear varnames(1) colrange(5)

save "time_series_covid19_deaths_global col 5 on.dta", replace


use "time_series_covid19_deaths_global col 2.dta", clear 

merge 1:1 _n using "time_series_covid19_deaths_global col 5 on.dta"

drop _merge

order provincestate countryregion, last

count

qui destring v*, replace

collapse (sum) v*, by(countryregion) // sum to add subnational estimates to national level and omit subnational estimates

count

replace countryregion = trim(countryregion)

rename countryregion loc_grand_name

label var loc_grand_name loc_grand_name


gen counter = _n

reshape long v, i(counter) 

rename v TotDeaMeRaA00

label var TotDeaMeRaA00 "Total deaths raw A00 JOHN"

bysort loc_grand_name: gen DayDeaMeRaA00 =  TotDeaMeRaA00[_n] - TotDeaMeRaA00[_n-1]

label var DayDeaMeRaA00 "Daily deaths raw A00 JOHN"


* JOHN starts from 22 Jan 2020

gen date = date("22 Jan 2020", "DMY")

bysort loc_grand_name: replace date = date + _j - 1

format date %td

codebook date

drop counter _j

save "all JOHN deaths.dta", replace










****************************************
****************************************

* get Johns Hopkins data for cases, all countries


import delimited using ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv" ///
, clear varnames(1) colrange(1:2)

save "time_series_covid19_confirmed_global col 2.dta", replace


import delimited using ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv" ///
, clear varnames(1) colrange(5)

save "time_series_covid19_confirmed_global col 5 on.dta", replace


use "time_series_covid19_confirmed_global col 2.dta", clear 

merge 1:1 _n using "time_series_covid19_confirmed_global col 5 on.dta"

drop _merge

order provincestate countryregion, last

count

qui destring v*, replace

collapse (sum) v*, by(countryregion) // sum to add subnational estimates to national level and omit subnational estimates

count

replace countryregion = trim(countryregion)

rename countryregion loc_grand_name

label var loc_grand_name loc_grand_name


gen counter = _n

reshape long v, i(counter) 

rename v TotCasMeRaA00

label var TotCasMeRaA00 "Total cases raw A00 JOHN"

bysort loc_grand_name: gen DayCasMeRaA00 =  TotCasMeRaA00[_n] - TotCasMeRaA00[_n-1]

label var DayCasMeRaA00 "Daily cases raw A00 JOHN"


* JOHN starts from 22 Jan 2020

gen date = date("22 Jan 2020", "DMY")

bysort loc_grand_name: replace date = date + _j - 1

format date %td

codebook date

drop counter _j

save "all JOHN cases.dta", replace






****************************************************
* get Johns Hopkins data for deaths, for EMRO countries


use "all JOHN deaths.dta", clear 


keep if ///
loc_grand_name == "Afghanistan" | ///
loc_grand_name == "Bahrain" | ///
loc_grand_name == "Djibouti" | ///
loc_grand_name == "Egypt" | ///
loc_grand_name == "Iran" | ///
loc_grand_name == "Iraq" | ///
loc_grand_name == "Jordan" | ///
loc_grand_name == "Kuwait" | ///
loc_grand_name == "Lebanon" | ///
loc_grand_name == "Libya" | ///
loc_grand_name == "Morocco" | ///
loc_grand_name == "Oman" | ///
loc_grand_name == "Pakistan" | ///
loc_grand_name == "Qatar" | ///
loc_grand_name == "Saudi Arabia" | ///
loc_grand_name == "Somalia" | ///
loc_grand_name == "Sudan" | ///
loc_grand_name == "Syria" | ///
loc_grand_name == "Tunisia" | ///
loc_grand_name == "United Arab Emirates" | ///
loc_grand_name == "West Bank and Gaza" | ///
loc_grand_name == "Yemen" 



******************

* smooth 

encode loc_grand_name, gen(loc_grand_name_encoded)

tsset loc_grand_name_encoded date, daily   


tssmooth ma DayDeaMeRaA00_window = DayDeaMeRaA00 if DayDeaMeRaA00 >= 0, window(3 1 3) 

tssmooth ma DayDeaMeSmA00 = DayDeaMeRaA00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA00 "Daily deaths smooth A00 JOHN"

drop DayDeaMeRaA00_window loc_grand_name_encoded


tsset, clear



sort date

save "JOHN deaths EMRO countries.dta", replace







****************************************************
* get Johns Hopkins data for cases, for EMRO countries


use "all JOHN cases.dta", clear 


keep if ///
loc_grand_name == "Afghanistan" | ///
loc_grand_name == "Bahrain" | ///
loc_grand_name == "Djibouti" | ///
loc_grand_name == "Egypt" | ///
loc_grand_name == "Iran" | ///
loc_grand_name == "Iraq" | ///
loc_grand_name == "Jordan" | ///
loc_grand_name == "Kuwait" | ///
loc_grand_name == "Lebanon" | ///
loc_grand_name == "Libya" | ///
loc_grand_name == "Morocco" | ///
loc_grand_name == "Oman" | ///
loc_grand_name == "Pakistan" | ///
loc_grand_name == "Qatar" | ///
loc_grand_name == "Saudi Arabia" | ///
loc_grand_name == "Somalia" | ///
loc_grand_name == "Sudan" | ///
loc_grand_name == "Syria" | ///
loc_grand_name == "Tunisia" | ///
loc_grand_name == "United Arab Emirates" | ///
loc_grand_name == "West Bank and Gaza" | ///
loc_grand_name == "Yemen" 



******************

* smooth 

encode loc_grand_name, gen(loc_grand_name_encoded)

tsset loc_grand_name_encoded date, daily   


tssmooth ma DayCasMeRaA00_window = DayCasMeRaA00 if DayCasMeRaA00 >= 0, window(3 1 3) 

tssmooth ma DayCasMeSmA00 = DayCasMeRaA00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasMeSmA00 "Daily cases smooth A00 JOHN"

drop DayCasMeRaA00_window loc_grand_name_encoded


tsset, clear


sort date

save "JOHN cases EMRO countries.dta", replace






****************************************************
* get Johns Hopkins data for deaths, for EMRO region


use "JOHN deaths EMRO countries.dta", clear 

drop loc_grand_name
 
collapse (sum) TotDeaMeRaA00 DayDeaMeRaA00, by(date)

gen loc_grand_name = "EMRO"

replace DayDeaMeRaA00 = TotDeaMeRaA00 in 1

sort date

save "JOHN deaths EMRO region.dta", replace







****************************************************
* get Johns Hopkins data for cases, for EMRO region


use "JOHN cases EMRO countries.dta", clear 

drop loc_grand_name
 
collapse (sum) TotCasMeRaA00 DayCasMeRaA00, by(date)

gen loc_grand_name = "EMRO"

replace DayCasMeRaA00 = TotCasMeRaA00 in 1

sort date

save "JOHN cases EMRO region.dta", replace






****************************************************
* append Johns Hopkins data for deaths for EMRO region, to EMRO countries


use "JOHN deaths EMRO countries.dta", clear 

append using "JOHN deaths EMRO region.dta"



qui compress

save "JOHN deaths EMRO region and countries.dta", replace






****************************************************
* append Johns Hopkins data for cases for EMRO region, to EMRO countries


use "JOHN cases EMRO countries.dta", clear 

append using "JOHN cases EMRO region.dta"

qui compress

save "JOHN cases EMRO region and countries.dta", replace





****************************************************
* merge JOHN cases and deaths for EMRO region and countries


use "JOHN deaths EMRO region and countries.dta", clear 

merge m:m date loc_grand_name using "JOHN cases EMRO region and countries.dta"

drop _merge

replace loc_grand_name = "Palestine" if loc_grand_name == "West Bank and Gaza"









* gen vars by location 

/*
Afghanistan	   	AFG
Bahrain	   		BHR
Djibouti	   	DJI
Egypt	   		EGY
EMRO	   		EMR <-
Iran	   		IRN
Iraq	   		IRQ
Jordan	   		JOR
Kuwait	   		KWT
Lebanon	   		LBN
Libya	   		LBY
Morocco	   		MAR
Oman	   		OMN
Pakistan	   	PAK
Palestine	   	PSE
Qatar	   		QAT
Saudi Arabia	SAU
Somalia	   		SOM
Sudan	   		SDN
Syria	   		SYR
Tunisia	   		TUN
United Arab Emirates	   	ARE
Yemen	   		YEM
*/

foreach var of varlist TotDeaMeRaA00 DayDeaMeRaA00 DayDeaMeSmA00 TotCasMeRaA00 DayCasMeRaA00 DayCasMeSmA00  {


	qui gen `var'AFG = `var' 
	qui replace `var'AFG = . if loc_grand_name != "Afghanistan"
	
	qui gen `var'BHR = `var'
	qui replace `var'BHR = . if loc_grand_name != "Bahrain"
	
	qui gen `var'DJI = `var'
	qui replace `var'DJI = . if loc_grand_name != "Djibouti"
	
	qui gen `var'EGY = `var'
	qui replace `var'EGY = . if loc_grand_name != "Egypt"
	
	qui gen `var'EMR = `var'
	qui replace `var'EMR = . if loc_grand_name != "EMRO"
	
	qui gen `var'IRN = `var'
	qui replace `var'IRN = . if loc_grand_name != "Iran"
	
	qui gen `var'IRQ = `var'
	qui replace `var'IRQ = . if loc_grand_name != "Iraq"
	
	qui gen `var'JOR = `var'
	qui replace `var'JOR = . if loc_grand_name != "Jordan"
	
	qui gen `var'KWT = `var'
	qui replace `var'KWT = . if loc_grand_name != "Kuwait"
	
	qui gen `var'LBN = `var'
	qui replace `var'LBN = . if loc_grand_name != "Lebanon"
	
	qui gen `var'LBY = `var'
	qui replace `var'LBY = . if loc_grand_name != "Libya"
	
	qui gen `var'MAR = `var'
	qui replace `var'MAR = . if loc_grand_name != "Morocco"
	
	qui gen `var'OMN = `var'
	qui replace `var'OMN = . if loc_grand_name != "Oman"
	
	qui gen `var'PAK = `var'
	qui replace `var'PAK = . if loc_grand_name != "Pakistan"
	
	qui gen `var'PSE = `var'
	qui replace `var'PSE = . if loc_grand_name != "Palestine"
	
	qui gen `var'QAT = `var'
	qui replace `var'QAT = . if loc_grand_name != "Qatar"
	
	qui gen `var'SAU = `var'
	qui replace `var'SAU = . if loc_grand_name != "Saudi Arabia"
	
	qui gen `var'SOM = `var'
	qui replace `var'SOM = . if loc_grand_name != "Somalia"
	
	qui gen `var'SDN = `var'
	qui replace `var'SDN = . if loc_grand_name != "Sudan"
	
	qui gen `var'SYR = `var'
	qui replace `var'SYR = . if loc_grand_name != "Syria"
	
	qui gen `var'TUN = `var'
	qui replace `var'TUN = . if loc_grand_name != "Tunisia"
	
	qui gen `var'ARE = `var'
	qui replace `var'ARE = . if loc_grand_name != "United Arab Emirates"
	
	qui gen `var'YEM = `var'
	qui replace `var'YEM = . if loc_grand_name != "Yemen"
	

	
	label var `var'AFG "`var' Afghanistan"
	label var `var'BHR "`var' Bahrain"
	label var `var'DJI "`var' Djibouti"
	label var `var'EGY "`var' Egypt"
	label var `var'EMR "`var' EMRO"
	label var `var'IRN "`var' Iran"
	label var `var'IRQ "`var' Iraq"
	label var `var'JOR "`var' Jordan"
	label var `var'KWT "`var' Kuwait"
	label var `var'LBN "`var' Lebanon"
	label var `var'LBY "`var' Libya"
	label var `var'MAR "`var' Morocco"
	label var `var'OMN "`var' Oman"
	label var `var'PAK "`var' Pakistan"
	label var `var'PSE "`var' Palestine"
	label var `var'QAT "`var' Qatar"
	label var `var'SAU "`var' Saudi Arabia"
	label var `var'SOM "`var' Somalia"
	label var `var'SDN "`var' Sudan"
	label var `var'SYR "`var' Syria"
	label var `var'TUN "`var' Tunisia"
	label var `var'ARE "`var' United Arab Emirates"
	label var `var'YEM "`var' Yemen"

                
}
*





* smooth daily deaths and daily cases for the EMR region

encode loc_grand_name, gen(loc_grand_name_encoded)

tsset loc_grand_name_encoded date, daily   


tssmooth ma DayDeaMeRaA00EMR_window = DayDeaMeRaA00EMR if DayDeaMeRaA00EMR >= 0, window(3 1 3) 

tssmooth ma DayDeaMeSmA00EMR = DayDeaMeRaA00EMR_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA00EMR "Daily deaths smooth A00 JOHN EMRO"


tssmooth ma DayCasMeRaA00EMR_window = DayCasMeRaA00EMR if DayCasMeRaA00EMR >= 0, window(3 1 3) 

tssmooth ma DayCasMeSmA00EMR = DayCasMeRaA00EMR_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasMeSmA00EMR "Daily cases smooth A00 JOHN EMRO"

drop DayDeaMeRaA00EMR_window DayCasMeRaA00EMR_window DayCasMeRaA00EMR loc_grand_name_encoded


tsset, clear




qui compress

save "JOHN deaths and cases EMRO region and countries.dta", replace











****************************************************
* get Johns Hopkins data for deaths, for $country


use "all JOHN deaths.dta", clear 

keep if regexm(loc_grand_name,"$country") == 1


replace TotDeaMeRaA00 = . if date < td(19feb2020)

replace DayDeaMeRaA00 = . if date < td(19feb2020)





gen DayDeaMeRaA00_CF2 = DayDeaMeRaA00 * 2

label var DayDeaMeRaA00_CF2 "Daily Deaths JOHN correction factor 2"

gen DayDeaMeRaA00_CF5 = DayDeaMeRaA00 * 5

label var DayDeaMeRaA00_CF5 "Daily Deaths JOHN correction factor 5"

gen TotDeaMeRaA00_CF2 = TotDeaMeRaA00 * 2

label var TotDeaMeRaA00_CF2 "Total Deaths JOHN correction factor 2"

gen TotDeaMeRaA00_CF5 = TotDeaMeRaA00 * 5

label var TotDeaMeRaA00_CF5 "Total Deaths JOHN correction factor 5"



order date loc_grand_name DayDeaMeRaA00 TotDeaMeRaA00 DayDeaMeRaA00_CF2 DayDeaMeRaA00_CF5 TotDeaMeRaA00_CF2 TotDeaMeRaA00_CF5
					

sort date

save "country JOHN deaths.dta", replace








****************************************************
* get Johns Hopkins data for cases, for $country


use "all JOHN cases.dta", clear 

keep if regexm(loc_grand_name,"$country") == 1




replace TotCasMeRaA00 = . if date < td(19feb2020)

replace DayCasMeRaA00 = . if date < td(19feb2020)



gen DayCasMeRaA00_CF2 = DayCasMeRaA00 * 2

label var DayCasMeRaA00_CF2 "Daily Cases JOHN correction factor 2"

gen DayCasMeRaA00_CF5 = DayCasMeRaA00 * 5

label var DayCasMeRaA00_CF5 "Daily Cases JOHN correction factor 5"

gen TotCasMeRaA00_CF2 = TotCasMeRaA00 * 2

label var TotCasMeRaA00_CF2 "Total Cases JOHN correction factor 2"

gen TotCasMeRaA00_CF5 = TotCasMeRaA00 * 5

label var TotCasMeRaA00_CF5 "Total Cases JOHN correction factor 5"


order date loc_grand_name DayCasMeRaA00 TotCasMeRaA00 DayCasMeRaA00_CF2 DayCasMeRaA00_CF5 TotCasMeRaA00_CF2 TotCasMeRaA00_CF5

sort date

compress

save "country JOHN Cases.dta", replace







****************************************************
* merge deaths and cases, for $country

use "country JOHN deaths.dta", clear 

merge 1:1 date using "country JOHN Cases.dta"

drop _merge


*

* gen cfr

gen DayCfrMeRaA00 = 100 * DayDeaMeRaA00 / DayCasMeRaA00

label var DayCfrMeRaA00 "Daily CFR JOHN"

*




* smooth 

tsset date, daily   


tssmooth ma DayDeaMeRaA00_window = DayDeaMeRaA00 if DayDeaMeRaA00 >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmA00 = DayDeaMeRaA00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA00 "Daily deaths smooth A00 JOHN"

drop DayDeaMeRaA00_window


tssmooth ma DayCasMeRaA00_window = DayCasMeRaA00 if DayCasMeRaA00 >= 0, window(3 1 3)

tssmooth ma DayCasMeSmA00 = DayCasMeRaA00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasMeSmA00 "Daily cases smooth A00 JOHN"

drop DayCasMeRaA00_window

tsset, clear




* gen monthspast vars for #thicknumber of graphs



gen today_date_string = "`c(current_date)'"

gen year = substr(today_date_string,8,4) 
gen month = substr(today_date_string,4,3) 
gen day = substr(today_date_string,1,2) 
egen date2 = concat(day month year)

gen today_numericdailydate  = date(date2, "DMY", 2050)
format today_numericdailydate  %tdDDMonCCYY

drop year month day date2 today_date_string

codebook today_numericdailydate 

gen monthspast01jan2020 = ((today_numericdailydate - td(01jan2020)) / 30) + 1

replace monthspast01jan2020 = round(monthspast01jan2020)

global monthspast01jan2020 = monthspast01jan2020

di $monthspast01jan2020



gen monthspast01jan2021 = ((today_numericdailydate - td(01jan2021)) / 30) + 1

replace monthspast01jan2021 = round(monthspast01jan2021)

global monthspast01jan2021 = monthspast01jan2021

di $monthspast01jan2021



gen monthspast01jan2022 = ((today_numericdailydate - td(01jan2022)) / 30) + 1

replace monthspast01jan2022 = round(monthspast01jan2022)

global monthspast01jan2022 = monthspast01jan2022

di $monthspast01jan2022








qui compress

sort date loc_grand_name


save "country JOHN.dta", replace







**************

* graphs

ssc install grstyle, replace

grstyle init

grstyle color background white







* daily deaths, JOHN, $country

twoway ///
(line DayDeaMeRaA00 date, sort lcolor(black) lwidth(medium)) /// 1 "JOHN raw"
(line DayDeaMeSmA00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
, xtitle(Date) xlabel(#$monthspast01jan2020, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, $country, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Raw deaths" 2 "Smooth deaths") size(small) row(1)) 

graph export "graph 1 COVID-19 daily deaths, $country, Johns Hopkins.pdf", replace




* daily cases, JOHN, $country

twoway ///
(line DayCasMeRaA00 date, sort lcolor(black) lwidth(medium)) /// 1 "JOHN raw"
(line DayCasMeSmA00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
, xtitle(Date) xlabel(#$monthspast01jan2020, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported cases) title("COVID-19 daily reported cases, $country, Johns Hopkins", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Raw cases" 2 "Smooth cases") size(small) row(1)) 

graph export "graph 2 COVID-19 daily cases, $country, Johns Hopkins.pdf", replace










view "log country JOHN.smcl"

log close

exit, clear




