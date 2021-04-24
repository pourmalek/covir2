
clear all

cd "$pathcovir2"

cd LANL

capture log close 

capture log using "log Iran LANL.smcl", replace

***************************************************************************
* This is "do Iran LANL.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare LANL data for Iran, Locate peak dates and values
***************************************************************************


* Get LANL estimates 

clear 


* download four files for four outcomes
                                                                       
copy https://covid-19.bsvgateway.org/forecast/global/2021-04-14/files/2021-04-14_global_cumulative_daily_cases_website.csv 2021-04-14_global_cumulative_daily_cases_website.csv

copy https://covid-19.bsvgateway.org/forecast/global/2021-04-14/files/2021-04-14_global_cumulative_daily_deaths_website.csv 2021-04-14_global_cumulative_daily_deaths_website.csv

copy https://covid-19.bsvgateway.org/forecast/global/2021-04-14/files/2021-04-14_global_incidence_daily_cases_website.csv 2021-04-14_global_incidence_daily_cases_website.csv

copy https://covid-19.bsvgateway.org/forecast/global/2021-04-14/files/2021-04-14_global_incidence_daily_deaths_website.csv 2021-04-14_global_incidence_daily_deaths_website.csv 




* import csv files



* Total Cases
import delimited using "2021-04-14_global_cumulative_daily_cases_website.csv", clear varnames(1)
save "global_cumulative_daily_cases.dta", replace

* Total Deaths
import delimited using "2021-04-14_global_cumulative_daily_deaths_website.csv", clear varnames(1)
save "global_cumulative_daily_deaths.dta", replace

* Daily Cases
import delimited using "2021-04-14_global_incidence_daily_cases_website.csv", clear varnames(1)
save "global_incidence_daily_cases.dta", replace

* Daily Deaths 
import delimited using "2021-04-14_global_incidence_daily_deaths_website.csv", clear varnames(1)
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





* gen cfr

gen DayCfrMeRaA04S00V02 = 100 * DayDeaMeRaA04S00V02 / DayCasMeRaA04S00V02
gen DayCfrLoRaA04S00V02 = 100 * DayDeaLoRaA04S00V02 / DayCasLoRaA04S00V02
gen DayCfrUpRaA04S00V02 = 100 * DayDeaUpRaA04S00V02 / DayCasUpRaA04S00V02

label var DayCfrMeRaA04S00V02 "Daily CFR Mean LANL S0 V2"
label var DayCfrLoRaA04S00V02 "Daily CFR Lower LANL S0 V2"
label var DayCfrUpRaA04S00V02 "Daily CFR Upper LANL S0 V2"






* gen "Daily cases mean div by daily deaths mean LANL DayCbD" for visulization of temporal relation of deaths and cases peaks 


	summ DayDeaMeRaA04S00V02 
	gen DayDeMMeRaA04S00V02  = r(mean)
	label var DayDeMMeRaA04S00V02  "Daily deaths mean LANL DayDeM"

	summ DayCasMeRaA04S00V02  
	gen DayCaMMeRaA04S00V02  = r(mean)
	label var DayCaMMeRaA04S00V02  "Daily cases mean LANL DayCaM"
                           
	gen DayCbDMeRaA04S00V02  = DayCaMMeRaA04S00V02  / DayDeMMeRaA04S00V02 
	label var DayCbDMeRaA04S00V02  "Daily cases mean div by daily deaths mean LANL DayCbD"
	summ DayCbDMeRaA04S00V02 
                                              
	gen DayDMuMeRaA04S00V02  = DayDeaMeRaA04S00V02  * DayCbDMeRaA04S00V02 
    label var DayDMuMeRaA04S00V02  "Daily deaths scaled (times means of cases by deaths) LANL"
	summ DayDMuMeRaA04S00V02 





***********************

* graphs


grstyle init

grstyle color background white



* daily deaths 	   

	   
twoway (rarea DayDeaLoRaA04S00V02 DayDeaUpRaA04S00V02 date, sort color(green*.2)) ///
(line DayDeaMeRaA04S00V02 date, sort lcolor(green)) ///
, xtitle(Date) xlabel(#18, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, LANL, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
   
  	   
graph save "graph 1 COVID-19 daily deaths, Iran, LANL.gph", replace
graph export "graph 1 COVID-19 daily deaths, Iran, LANL.pdf", replace



* daily cases


twoway (rarea DayCasLoRaA04S00V02 DayCasUpRaA04S00V02 date, sort color(green*.2)) ///
(line DayCasMeRaA04S00V02 date, sort lcolor(green)) ///
, xtitle(Date) xlabel(#18, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, LANL, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
   
  	   
graph save "graph 2 COVID-19 daily cases, Iran, LANL.gph", replace
graph export "graph 2 COVID-19 daily cases, Iran, LANL.pdf", replace




* total deaths 	   
	   
twoway (rarea TotDeaLoRaA04S00V02 TotDeaUpRaA04S00V02 date, sort color(green*.2)) ///
(line TotDeaMeRaA04S00V02 date, sort lcolor(green)) ///
, xtitle(Date) xlabel(#18, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, LANL, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
   
  	   
graph save "graph 3 COVID-19 total deaths, Iran, LANL.gph", replace
graph export "graph 3 COVID-19 total deaths, Iran, LANL.pdf", replace





* total cases 	   
	   
twoway (rarea TotCasLoRaA04S00V02 TotCasUpRaA04S00V02 date, sort color(green*.2)) ///
(line TotCasMeRaA04S00V02 date, sort lcolor(green)) ///
, xtitle(Date) xlabel(#18, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, LANL, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
   
  	   
graph save "graph 4 COVID-19 total cases, Iran, LANL.gph", replace
graph export "graph 4 COVID-19 total cases, Iran, LANL.pdf", replace




* daily cfr


twoway (rarea DayCfrLoRaA04S00V02 DayCfrUpRaA04S00V02 date, sort color(green*.2)) ///
(line DayCfrMeRaA04S00V02 date, sort lcolor(green)) ///
, xtitle(Date) xlabel(#18, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, LANL, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
   
  	   
graph save "graph 5 COVID-19 daily CFR, Iran, LANL.gph", replace
graph export "graph 5 COVID-19 daily CFR, Iran, LANL.pdf", replace



* daily cfr, 01dec2020 on

twoway (rarea DayCfrLoRaA04S00V02 DayCfrUpRaA04S00V02 date, sort color(green*.2)) ///
(line DayCfrMeRaA04S00V02 date, sort lcolor(green)) ///
if date > td(01dec2020) ///
, xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, LANL, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	///
subtitle("after 2020-12-01", size(small))
   
  	   
graph save "graph 6 COVID-19 daily CFR, Iran, LANL, 01dec2020 on.gph", replace
graph export "graph 6 COVID-19 daily CFR, Iran, LANL, 01dec2020 on.pdf", replace






* DayCas DayDea Dea_multip

twoway ///
(line DayCasMeRaA04S00V02  date, sort lcolor(blue)) ///
(line DayDeaMeRaA04S00V02  date, sort lcolor(red)) ///
(line DayDMuMeRaA04S00V02  date, sort lpattern(dot) lcolor(red)) ///
, xtitle(Date) xlabel(#18, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases and deaths) title("COVID-19 daily cases and deaths, Iran, LANL", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) yscale(titlegap(4)) legend(region(lcolor(none)))  ///
legend(order(1 "Daily cases" 2 "Daily deaths" 3 "Daily deaths scaled for visualization") size(small)) ///
subtitle("Daily deaths, scaled = times (means of cases divided by deaths) for visualization only", size(small)) ///
note("Current scenario, mean estimate")

qui graph save "graph 7 COVID-19 daily deaths and cases Iran, LANL.gph", replace
qui graph export "graph 7 COVID-19 daily deaths and cases Iran, LANL.pdf", replace

***


sort date

qui compress

save "Iran LANL.dta", replace



view "log Iran LANL.smcl"

log close

exit, clear




