
clear all
 
cd "$pathcovir2"

cd DELP

capture log close 

log using "log Iran DELP.smcl", replace

***************************************************************************
* This is "do Iran DELP.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time: 2021-02-10

* OBJECTIVE: Get and prepare DELPHI data for Iran, Locate peak dates and values
***************************************************************************


* Get DELPHI data for Iran

/* Their latest estimations file “covid_analytics_projections.csv” is located on web page (https://www.covidanalytics.io/projections), 
linked via “Download Most Recent Predictions” located all the way down the page. 
Trying to extract the "web address" of this file (like what is doable for all other studies) leads to the actual data in raw format. 
The file can be downlaoded, and moved to "$pathcovir2/DELP"  */


import delimited using "covid_analytics_projections.csv", clear varnames(1)

rename country loc_grand_name

keep if loc_grand_name == "Iran"


* gen date

rename day date_original

gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date

drop year month day date2


* rename outcome variables

* total vars

rename totaldetecteddeaths   TotDeaMeRaA01S00V03
rename totaldetecteddeathslb TotDeaLoRaA01S00V03
rename totaldetecteddeathsub TotDeaUpRaA01S00V03

label var TotDeaMeRaA01S00V03 "Total Deaths Mean DELP S0 V3"
label var TotDeaMeRaA01S00V03 "Total Deaths Lower DELP S0 V3"
label var TotDeaMeRaA01S00V03 "Total Deaths Upper DELP S0 V3"

rename totaldetected   TotCasMeRaA01S00V03
rename totaldetectedlb TotCasLoRaA01S00V03
rename totaldetectedub TotCasUpRaA01S00V03

label var TotCasMeRaA01S00V03 "Total Cases Mean DELP S0 V3"
label var TotCasMeRaA01S00V03 "Total Cases Lower DELP S0 V3"
label var TotCasMeRaA01S00V03 "Total Cases Upper DELP S0 V3"


* gen daily vars and rename

sort date

gen DayDeaMeRaA01S00V03 =  TotDeaMeRaA01S00V03[_n] - TotDeaMeRaA01S00V03[_n-1]

gen DayDeaLoRaA01S00V03 =  TotDeaLoRaA01S00V03[_n] - TotDeaLoRaA01S00V03[_n-1]

gen DayDeaUpRaA01S00V03 =  TotDeaUpRaA01S00V03[_n] - TotDeaUpRaA01S00V03[_n-1]

gen DayCasMeRaA01S00V03 =  TotCasMeRaA01S00V03[_n] - TotCasMeRaA01S00V03[_n-1]

gen DayCasLoRaA01S00V03 =  TotCasLoRaA01S00V03[_n] - TotCasLoRaA01S00V03[_n-1]

gen DayCasUpRaA01S00V03 =  TotCasUpRaA01S00V03[_n] - TotCasUpRaA01S00V03[_n-1]


label var DayDeaMeRaA01S00V03 "Daily Deaths Mean DELP S0 V3"
label var DayDeaLoRaA01S00V03 "Daily Deaths Lower DELP S0 V3"
label var DayDeaUpRaA01S00V03 "Daily Deaths Upper DELP S0 V3"

label var DayCasMeRaA01S00V03 "Daily Cases Mean DELP S0 V3"
label var DayCasLoRaA01S00V03 "Daily Cases Lower DELP S0 V3"
label var DayCasUpRaA01S00V03 "Daily Cases Upper DELP S0 V3"

label var TotDeaMeRaA01S00V03 "Total Deaths Mean DELP S0 V3"
label var TotDeaLoRaA01S00V03 "Total Deaths Lower DELP S0 V3"
label var TotDeaUpRaA01S00V03 "Total Deaths Upper DELP S0 V3"

label var TotCasMeRaA01S00V03 "Total Cases Mean DELP S0 V3"
label var TotCasLoRaA01S00V03 "Total Cases Lower DELP S0 V3"
label var TotCasUpRaA01S00V03 "Total Cases Upper DELP S0 V3"

 

keep ///
loc_grand_name date ///
TotDeaMeRaA01S00V03 TotDeaLoRaA01S00V03 TotDeaUpRaA01S00V03 ///
DayDeaMeRaA01S00V03 DayDeaLoRaA01S00V03 DayDeaUpRaA01S00V03 ///
TotCasMeRaA01S00V03 TotCasLoRaA01S00V03 TotCasUpRaA01S00V03 ///
DayCasMeRaA01S00V03 DayCasLoRaA01S00V03 DayCasUpRaA01S00V03


order ///
loc_grand_name date ///
TotDeaMeRaA01S00V03 TotDeaLoRaA01S00V03 TotDeaUpRaA01S00V03 ///
DayDeaMeRaA01S00V03 DayDeaLoRaA01S00V03 DayDeaUpRaA01S00V03 ///
TotCasMeRaA01S00V03 TotCasLoRaA01S00V03 TotCasUpRaA01S00V03 ///
DayCasMeRaA01S00V03 DayCasLoRaA01S00V03 DayCasUpRaA01S00V03


sort date

compress

save "Iran DELP.dta", replace



* graphs


grstyle init

grstyle color background white


* daily deaths 	   

codebook date
	   
twoway (rarea DayDeaLoRaA01S00V03 DayDeaUpRaA01S00V03 date, sort color(green*.2)) ///
(line DayDeaMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran", legend(off) ///	   
xtitle(Date) xlabel(#3, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
   
  	   
graph save "graph COVID-19 daily deaths, Iran, DELP.gph", replace
graph export "graph COVID-19 daily deaths, Iran, DELP.pdf", replace


* daily cases 


twoway (rarea DayCasLoRaA01S00V03 DayCasUpRaA01S00V03 date, sort color(green*.2)) ///
(line DayCasMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran", legend(off) ///	   
xtitle(Date) xlabel(#3, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
	   

graph save "graph COVID-19 daily cases, Iran, DELP.gph", replace
graph export "graph COVID-19 daily cases, Iran, DELP.pdf", replace



*************************************

* Locate peak dates and values - deaths 


* one peak 

summ DayDeaMeRaA01S00V03 

list date if DayDeaMeRaA01S00V03 > 4963.99 & DayDeaMeRaA01S00V03 != . 

list DayDeaLoRaA01S00V03 if date == td(30Mar2021) 
list DayDeaUpRaA01S00V03 if date == td(30Mar2021) 

* lowest point in start, codebook date // 23feb2021,15apr2021 / nonmissing on 02Mar2021


list DayDeaMeRaA01S00V03 if date == td(02Mar2021) 
list DayDeaLoRaA01S00V03 if date == td(02Mar2021) 
list DayDeaUpRaA01S00V03 if date == td(02Mar2021) 


* lowest point at the end

list DayDeaMeRaA01S00V03 if date == td(15apr2021) 
list DayDeaLoRaA01S00V03 if date == td(15apr2021) 
list DayDeaUpRaA01S00V03 if date == td(15apr2021) 




* Locate peak dates and values - cases 

summ DayCasMeRaA01S00V03 

list date if DayCasMeRaA01S00V03 > 544960.99 & DayCasMeRaA01S00V03 != . 

list DayCasLoRaA01S00V03 if date == td(28Mar2021) 
list DayCasUpRaA01S00V03 if date == td(28Mar2021) 

* lowest point in start, codebook date // 23feb2021,15apr2021 / nonmissing on 02Mar2021

list DayCasMeRaA01S00V03 if date == td(02Mar2021) 
list DayCasLoRaA01S00V03 if date == td(02Mar2021) 
list DayCasUpRaA01S00V03 if date == td(02Mar2021) 


* lowest point at the end, codebook date // 10feb2021,15apr2021

list DayCasMeRaA01S00V03 if date == td(15apr2021)
list DayCasLoRaA01S00V03 if date == td(15apr2021) 
list DayCasUpRaA01S00V03 if date == td(15apr2021) 




view "log Iran DELP.smcl"

log close

exit, clear




