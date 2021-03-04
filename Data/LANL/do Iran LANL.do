
clear all

cd "$pathcovir2"

cd LANL

capture log close 

log using "log Iran LANL.smcl", replace

***************************************************************************
* This is "do Iran LANL.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time: 2021-02-10

* OBJECTIVE: Get and prepare LANL data for Iran, Locate peak dates and values
***************************************************************************


* Get LANL estimates 

clear 


* download four files for four outcomes

copy https://covid-19.bsvgateway.org/forecast/global/2021-02-24/files/2021-02-24_global_cumulative_daily_cases_website.csv 2021-02-24_global_cumulative_daily_cases_website.csv

copy https://covid-19.bsvgateway.org/forecast/global/2021-02-24/files/2021-02-24_global_cumulative_daily_deaths_website.csv 2021-02-24_global_cumulative_daily_deaths_website.csv

copy https://covid-19.bsvgateway.org/forecast/global/2021-02-24/files/2021-02-24_global_incidence_daily_cases_website.csv 2021-02-24_global_incidence_daily_cases_website.csv

copy https://covid-19.bsvgateway.org/forecast/global/2021-02-24/files/2021-02-24_global_incidence_daily_deaths_website.csv 2021-02-24_global_incidence_daily_deaths_website.csv 






* import csv files



* Total Cases
import delimited using "2021-02-24_global_cumulative_daily_cases_website.csv", clear varnames(1)
save "global_cumulative_daily_cases.dta", replace

* Total Deaths
import delimited using "2021-02-24_global_cumulative_daily_deaths_website.csv", clear varnames(1)
save "global_cumulative_daily_deaths.dta", replace

* Daily Cases
import delimited using "2021-02-24_global_incidence_daily_cases_website.csv", clear varnames(1)
save "global_incidence_daily_cases.dta", replace

* Daily Deaths 
import delimited using "2021-02-24_global_incidence_daily_deaths_website.csv", clear varnames(1)
save "global_incidence_daily_deaths.dta", replace
	




*******************


* Total Cases

use "global_cumulative_daily_cases.dta", clear 

keep date q50 q025 q975 truth_confirmed obs name 

keep if strpos(name, "Iran")



* gen date

rename date date_original

gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date

drop year month day date2


* rename estimate vars

rename q50  TotCasMeRaA04S00V02
rename q025 TotCasLoRaA04S00V02
rename q975 TotCasUpRaA04S00V02

label var TotCasMeRaA04S00V02 "Total Cases Mean LANL S0 V2"
label var TotCasLoRaA04S00V02 "Total Cases Lower LANL S0 V2"
label var TotCasUpRaA04S00V02 "Total Cases Upper LANL S0 V2"

save "Iran LANL Total Cases.dta", replace







*******************

* Total Deaths

use "global_cumulative_daily_deaths.dta", clear 

keep date q50 q025 q975 truth_deaths obs name 

keep if strpos(name, "Iran")



* gen date

rename date date_original

gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date

drop year month day date2


* rename estimate vars

rename q50  TotDeaMeRaA04S00V02
rename q025 TotDeaLoRaA04S00V02
rename q975 TotDeaUpRaA04S00V02

label var TotDeaMeRaA04S00V02 "Total deaths Mean LANL S0 V2"
label var TotDeaLoRaA04S00V02 "Total deaths Lower LANL S0 V2"
label var TotDeaUpRaA04S00V02 "Total deaths Upper LANL S0 V2"


save "Iran LANL Total Deaths.dta", replace




*******************

* Daily Cases

use "global_incidence_daily_cases.dta", clear 

keep date q50 q025 q975 truth_confirmed obs name 

keep if strpos(name, "Iran")



* gen date

rename date date_original

gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date

drop year month day date2


* rename estimate vars

rename q50  DayCasMeRaA04S00V02
rename q025 DayCasLoRaA04S00V02
rename q975 DayCasUpRaA04S00V02

label var DayCasMeRaA04S00V02 "Daily cases Mean LANL S0 V2"
label var DayCasLoRaA04S00V02 "Daily cases Lower LANL S0 V2"
label var DayCasUpRaA04S00V02 "Daily cases Upper LANL S0 V2"


save "Iran LANL Daily Cases.dta", replace



*******************






* Daily Deaths

use "global_incidence_daily_deaths.dta", clear 

keep date q50 q025 q975 truth_deaths obs name 

keep if strpos(name, "Iran")



* gen date

rename date date_original

gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date

drop year month day date2


* rename estimate vars

rename q50  DayDeaMeRaA04S00V02
rename q025 DayDeaLoRaA04S00V02
rename q975 DayDeaUpRaA04S00V02

label var DayDeaMeRaA04S00V02 "Daily deaths Mean LANL S0 V2"
label var DayDeaLoRaA04S00V02 "Daily deaths Lower LANL S0 V2"
label var DayDeaUpRaA04S00V02 "Daily deaths Upper LANL S0 V2"


save "Iran LANL Daily Deaths.dta", replace



******************

* merge four estimates files


use "Iran LANL Total Cases.dta", clear 

merge 1:1 date using "Iran LANL Total Deaths.dta"

drop _merge

merge 1:1 date using "Iran LANL Daily Cases.dta"

drop _merge

merge 1:1 date using "Iran LANL Daily Deaths.dta"

drop _merge

drop date_original obs truth_confirmed truth_deaths

order ///
TotDeaLoRaA04S00V02 TotDeaMeRaA04S00V02 TotDeaUpRaA04S00V02 ///
DayDeaLoRaA04S00V02 DayDeaMeRaA04S00V02 DayDeaUpRaA04S00V02 ///
TotCasLoRaA04S00V02 TotCasMeRaA04S00V02 TotCasUpRaA04S00V02 ///
DayCasLoRaA04S00V02 DayCasMeRaA04S00V02 DayCasUpRaA04S00V02

order date name

rename name loc_grand_name

sort date

compress

save "Iran LANL.dta", replace



***********************

* graphs


grstyle init

grstyle color background white



* daily deaths 	   
	   
twoway (rarea DayDeaLoRaA04S00V0 DayDeaUpRaA04S00V0 date, sort color(green*.2)) ///
(line DayDeaMeRaA04S00V0 date, sort lcolor(green)) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, LANL, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
   
  	   
graph save "graph COVID-19 daily deaths, Iran, LANL.gph", replace
graph export "graph COVID-19 daily deaths, Iran, LANL.pdf", replace



* daily cases


twoway (rarea DayCasLoRaA04S00V0 DayCasUpRaA04S00V0 date, sort color(green*.2)) ///
(line DayCasMeRaA04S00V0 date, sort lcolor(green)) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, LANL, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
   
  	   
graph save "graph COVID-19 daily cases, Iran, LANL.gph", replace
graph export "graph COVID-19 daily cases, Iran, LANL.pdf", replace




*************************************

* Locate peak dates and values - deaths 


* first peak

summ DayDeaMeRaA04S00V0 if date > td(01mar2020) & date < td(01may2020) // 158

list date if DayDeaMeRaA04S00V0 > 157 & date > td(01mar2020) & date < td(01may2020) //  04Apr2020

list DayDeaMeRaA04S00V0 if date == td(04Apr2020) // 158 
list DayDeaLoRaA04S00V0 if date == td(04Apr2020) // 158 
list DayDeaUpRaA04S00V0 if date == td(04Apr2020) // 158

* second peak 

summ DayDeaMeRaA04S00V0 if date > td(01jul2020) & date < td(30jul2020) // 235

list date if DayDeaMeRaA04S00V0 > 234 & date > td(01jul2020) & date < td(30jul2020) // 28Jul2020 

list DayDeaMeRaA04S00V0 if date == td(28Jul2020) // 235 
list DayDeaLoRaA04S00V0 if date == td(28Jul2020) // 235 
list DayDeaUpRaA04S00V0 if date == td(28Jul2020) // 235

* third peak 

summ DayDeaMeRaA04S00V0 if date > td(01nov2020) & date < td(30nov2020) // 486

list date if DayDeaMeRaA04S00V0 > 485 & date > td(01nov2020) & date < td(30nov2020) // 16Nov2020 

list DayDeaLoRaA04S00V0 if date == td(16Nov2020) // 486 
list DayDeaUpRaA04S00V0 if date == td(16Nov2020) // 486

* fourth peak 

summ DayDeaMeRaA04S00V0 if date > td(01feb2021) & date < td(30apr2021) // 91

list date if DayDeaMeRaA04S00V0 > 90.999 & date > td(01feb2021) & date < td(30apr2021) & DayDeaMeRaA04S00V0 != . // 23Feb2021 02Mar2021

list date DayDeaMeRaA04S00V0 if date == td(23Feb2021)

list date DayDeaMeRaA04S00V0 if date == td(02Mar2021)

list date DayDeaMeRaA04S00V0 if date >= td(23Feb2021) & date <= td(02Mar2021)


list DayDeaLoRaA04S00V0 if date == td(23Feb2021) // 91
list DayDeaUpRaA04S00V0 if date == td(23Feb2021) // 91

list DayDeaLoRaA04S00V0 if date == td(02Mar2021) // 73 
list DayDeaUpRaA04S00V0 if date == td(02Mar2021) // 107



* end date avialable 

list DayDeaMeRaA04S00V0 if date == td(13Apr2021) // 67
list DayDeaLoRaA04S00V0 if date == td(13Apr2021) // 30
list DayDeaUpRaA04S00V0 if date == td(13Apr2021) // 148



****************
  
* Locate peak dates and values - cases 


* first peak

summ DayCasMeRaA04S00V0 if date > td(01mar2020) & date < td(01may2020) // 3186

list date if DayCasMeRaA04S00V0 > 3185 & date >  td(01mar2020) & date < td(01may2020) // 30Mar2020

list DayCasLoRaA04S00V0 if date == td(30Mar2020) // 3186
list DayCasUpRaA04S00V0 if date == td(30Mar2020) // 3186


* second peak

summ DayCasMeRaA04S00V0 if date > td(01jul2020) & date < td(30jul2020) //2691

list date if DayCasMeRaA04S00V0 > 2690 & date > td(01jul2020) & date < td(30jul2020) // 08Jul2020 

list DayCasLoRaA04S00V0 if date == td(08Jul2020) // 2691
list DayCasUpRaA04S00V0 if date == td(08Jul2020) // 2691


* third peak

summ DayCasMeRaA04S00V0 if date > td(01nov2020) & date < td(30jan2021) // 14051

list date if DayCasMeRaA04S00V0 > 14050 & date > td(01nov2020) & date < td(30jan2021) // 27Nov2020 

list DayCasLoRaA04S00V0 if date == td(27Nov2020) // 14051 
list DayCasUpRaA04S00V0 if date == td(27Nov2020) // 14051


* fourth peak 

summ DayCasMeRaA04S00V0 if date > td(01jan2021) & date < td(30apr2021) // 8547.5 = 8548

list date if DayCasMeRaA04S00V0 > 8547 & date > td(01jan2021) & date < td(09Mar2021) // 

list DayCasLoRaA04S00V0 if date == td(09Mar2021) // 7277 
list DayCasUpRaA04S00V0 if date == td(09Mar2021) // 10360

* end date avialable 

list DayCasMeRaA04S00V0 if date == td(13Apr2021) // 6513 
list DayCasLoRaA04S00V0 if date == td(13Apr2021) // 3457 
list DayCasUpRaA04S00V0 if date == td(13Apr2021) // 18867






view "log Iran LANL.smcl"

log close

exit, clear




