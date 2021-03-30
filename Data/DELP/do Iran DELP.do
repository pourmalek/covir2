
clear all
 
cd "$pathcovir2"

cd DELP

capture log close 

log using "log Iran DELP.smcl", replace

***************************************************************************
* This is "do Iran DELP.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

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


* 

* other outcomes

* active activehospitalized activeventilated cumulativehospitalized

/*
***********************
* rename convention

active					Act

activehospitalized		Hos

activeventilated 		Ven

cumulativehospitalized 	Hos

*/


rename active DayActMeRaA01S00V03

rename activehospitalized DayHosMeRaA01S00V03

rename activeventilated DayVenMeRaA01S00V03

rename cumulativehospitalized TotHosMeRaA01S00V03

label var DayActMeRaA01S00V03 "Daily Cases Active Mean DELP S0 V3"

label var DayHosMeRaA01S00V03 "Daily Cases Active Hospitalized Mean DELP S0 V3"

label var DayVenMeRaA01S00V03 "Daily Cases Active Ventilated Mean DELP S0 V3"

label var TotHosMeRaA01S00V03 "Total Cases Active Mean DELP S0 V3"

 

keep ///
loc_grand_name date ///
TotDeaMeRaA01S00V03 TotDeaLoRaA01S00V03 TotDeaUpRaA01S00V03 ///
DayDeaMeRaA01S00V03 DayDeaLoRaA01S00V03 DayDeaUpRaA01S00V03 ///
TotCasMeRaA01S00V03 TotCasLoRaA01S00V03 TotCasUpRaA01S00V03 ///
DayCasMeRaA01S00V03 DayCasLoRaA01S00V03 DayCasUpRaA01S00V03 ///
DayActMeRaA01S00V03 DayHosMeRaA01S00V03 DayVenMeRaA01S00V03 TotHosMeRaA01S00V03


order ///
loc_grand_name date ///
TotDeaMeRaA01S00V03 TotDeaLoRaA01S00V03 TotDeaUpRaA01S00V03 ///
DayDeaMeRaA01S00V03 DayDeaLoRaA01S00V03 DayDeaUpRaA01S00V03 ///
TotCasMeRaA01S00V03 TotCasLoRaA01S00V03 TotCasUpRaA01S00V03 ///
DayCasMeRaA01S00V03 DayCasLoRaA01S00V03 DayCasUpRaA01S00V03 ///
DayActMeRaA01S00V03 DayHosMeRaA01S00V03 DayVenMeRaA01S00V03 TotHosMeRaA01S00V03



* gen cfr

gen DayCfrMeRaA01S00V03 = 100 * DayDeaMeRaA01S00V03 / DayCasMeRaA01S00V03
gen DayCfrLoRaA01S00V03 = 100 * DayDeaLoRaA01S00V03 / DayCasLoRaA01S00V03
gen DayCfrUpRaA01S00V03 = 100 * DayDeaUpRaA01S00V03 / DayCasUpRaA01S00V03

label var DayCfrMeRaA01S00V03 "Daily CFR Mean DELP S0 V3"
label var DayCfrLoRaA01S00V03 "Daily CFR Lower DELP S0 V3"
label var DayCfrUpRaA01S00V03 "Daily CFR Upper DELP S0 V3"





* graphs


grstyle init

grstyle color background white




codebook date if DayDeaMeRaA01S00V03 != .




* daily deaths wo CI


twoway  ///
(line DayDeaMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != ., legend(off) ///	   
xtitle(Date) xlabel(22354 "21-03-15" 22371 "21-04-01" 22385 "21-04-15" 22401 "21-05-01" 22415 "21-05-15", format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
   
  	   
graph save "graph 1 COVID-19 daily deaths, Iran, DELP wo CI.gph", replace
graph export "graph 1 COVID-19 daily deaths, Iran, DELP wo CI.pdf", replace


* daily deaths with CI


twoway (rarea DayDeaLoRaA01S00V03 DayDeaUpRaA01S00V03 date, sort color(green*.2)) ///
(line DayDeaMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != ., legend(off) ///	   
xtitle(Date) xlabel(22354 "21-03-15" 22371 "21-04-01" 22385 "21-04-15" 22401 "21-05-01" 22415 "21-05-15", format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
subtitle("with confidence limits", size(small))	
  
  	   
graph save "graph 2 COVID-19 daily deaths, Iran, DELP with CI.gph", replace
graph export "graph 2 COVID-19 daily deaths, Iran, DELP with CI.pdf", replace



* total deaths wo CI 


twoway  ///
(line TotDeaMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != ., legend(off) ///	   
xtitle(Date) xlabel(22354 "21-03-15" 22371 "21-04-01" 22385 "21-04-15" 22401 "21-05-01" 22415 "21-05-15", format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)

graph save "graph 3 COVID-19 total deaths, Iran, DELP wo CI.gph", replace
graph export "graph 3 COVID-19 total deaths, Iran, DELP wo CI.pdf", replace




* total deaths with CI 


twoway (rarea TotDeaLoRaA01S00V03 TotDeaUpRaA01S00V03 date, sort color(green*.2)) ///
(line TotDeaMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != ., legend(off) ///	   
xtitle(Date) xlabel(22354 "21-03-15" 22371 "21-04-01" 22385 "21-04-15" 22401 "21-05-01" 22415 "21-05-15", format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
subtitle("with confidence limits", size(small))	
	
   
  	   
graph save "graph 4 COVID-19 total deaths, Iran, DELP with CI.gph", replace
graph export "graph 4 COVID-19 total deaths, Iran, DELP with CI.pdf", replace



* daily cases wo CI

twoway ///
(line DayCasMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != ., legend(off) ///	   
xtitle(Date) xlabel(22354 "21-03-15" 22371 "21-04-01" 22385 "21-04-15" 22401 "21-05-01" 22415 "21-05-15", format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
	   

graph save "graph 5 COVID-19 daily cases, Iran, DELP wo CI.gph", replace
graph export "graph 5 COVID-19 daily cases, Iran, DELP wo CI.pdf", replace



* daily cases with CI

twoway (rarea DayCasLoRaA01S00V03 DayCasUpRaA01S00V03 date, sort color(green*.2)) ///
(line DayCasMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != ., legend(off) ///	   
xtitle(Date) xlabel(22354 "21-03-15" 22371 "21-04-01" 22385 "21-04-15" 22401 "21-05-01" 22415 "21-05-15", format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
subtitle("with confidence limits", size(small))	
	
	   

graph save "graph 6 COVID-19 daily cases, Iran, DELP with CI.gph", replace
graph export "graph 6 COVID-19 daily cases, Iran, DELP with CI.pdf", replace






* total cases wo CI

twoway ///
(line TotCasMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != ., legend(off) ///	   
xtitle(Date) xlabel(22354 "21-03-15" 22371 "21-04-01" 22385 "21-04-15" 22401 "21-05-01" 22415 "21-05-15", format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
	   

graph save "graph 7 COVID-19 total cases, Iran, DELP wo CI.gph", replace
graph export "graph 7 COVID-19 total cases, Iran, DELP wo CI.pdf", replace



* total cases with CI

twoway (rarea TotCasLoRaA01S00V03 TotCasUpRaA01S00V03 date, sort color(green*.2)) ///
(line TotCasMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != ., legend(off) ///	   
xtitle(Date) xlabel(22354 "21-03-15" 22371 "21-04-01" 22385 "21-04-15" 22401 "21-05-01" 22415 "21-05-15", format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
subtitle("with confidence limits", size(small))	
	
	   

graph save "graph 8 COVID-19 total cases, Iran, DELP with CI.gph", replace
graph export "graph 8 COVID-19 total cases, Iran, DELP with CI.pdf", replace





* daily cfr 

twoway (rarea DayCfrLoRaA01S00V03 DayCfrUpRaA01S00V03 date, sort color(green*.2)) ///
(line DayCfrMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != ., legend(off) ///	   
xtitle(Date) xlabel(22354 "21-03-15" 22371 "21-04-01" 22385 "21-04-15" 22401 "21-05-01" 22415 "21-05-15", format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily CFR, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
	   

graph save "graph 9 COVID-19 daily CFR, Iran, DELP.gph", replace
graph export "graph 9 COVID-19 daily CFR, Iran, DELP.pdf", replace







* daily cases active, active hospitalized, active ventilated

* DayCasAcRaA01S00V03 DayCasAhRaA01S00V03 DayCasAvRaA01S00V03 TotCasAcRaA01S00V03


twoway ///
(line DayActMeRaA01S00V03 date, sort lcolor(green)) ///
(line DayHosMeRaA01S00V03 date, sort lcolor(black)) ///
(line DayVenMeRaA01S00V03 date, sort lcolor(red)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != ., ///	   
xtitle(Date) xlabel(22354 "21-03-15" 22371 "21-04-01" 22385 "21-04-15" 22401 "21-05-01" 22415 "21-05-15", format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcome) title("COVID-19 daily cases, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Active cases" 2 "Active hospitalized" 3 "Active ventilated") rows(1)) ///
subtitle("active cases, active hospitalized, active ventilated", size(small))	


	   
graph save "graph 10 COVID-19 daily cases etc, Iran, DELP wo CI.gph", replace
graph export "graph 10 COVID-19 daily cases etc, Iran, DELP wo CI.pdf", replace




* daily active hospitalized, active ventilated


twoway ///
(line DayHosMeRaA01S00V03 date, sort lcolor(black)) ///
(line DayVenMeRaA01S00V03 date, sort lcolor(red)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != .,  ///	   
xtitle(Date) xlabel(22354 "21-03-15" 22371 "21-04-01" 22385 "21-04-15" 22401 "21-05-01" 22415 "21-05-15", format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcome) title("COVID-19 daily cases, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Active hospitalized" 2 "Active ventilated") rows(1)) ///
subtitle("active hospitalized, active ventilated", size(small))	

	   

graph save "graph 11 COVID-19 daily cases etc, Iran, DELP wo CI.gph", replace
graph export "graph 11 COVID-19 daily cases etc, Iran, DELP wo CI.pdf", replace















*************************************

* Locate peak dates and values - deaths 




* consistently decreasing


* start value (P7)

summ DayDeaMeRaA01S00V03 

gen DayDeaMeRaA01S00V03P7V = r(max)

label var DayDeaMeRaA01S00V03P7V "DayDeaMeRaA01S00V03 start Value"

summ date 

gen DayDeaMeRaA01S00V03P7D = r(min)

label var DayDeaMeRaA01S00V03P7D "DayDeaMeRaA01S00V03 start Date"

format DayDeaMeRaA01S00V03P7D %tdDDMonCCYY


summ DayDeaLoRaA01S00V03 

gen DayDeaLoRaA01S00V03P7V = r(max)

label var DayDeaLoRaA01S00V03P7V "DayDeaLoRaA01S00V03 start Value"


summ DayDeaUpRaA01S00V03 

gen DayDeaUpRaA01S00V03P7V = r(max)

label var DayDeaUpRaA01S00V03P7V "DayDeaUpRaA01S00V03 start Value"


tab1 DayDeaMeRaA01S00V03P7V DayDeaLoRaA01S00V03P7V DayDeaUpRaA01S00V03P7V DayDeaMeRaA01S00V03P7D



* end value (P8)

summ DayDeaMeRaA01S00V03 

gen DayDeaMeRaA01S00V03P8V = r(min)

label var DayDeaMeRaA01S00V03P8V "DayDeaMeRaA01S00V03 end Value"


summ date 

gen DayDeaMeRaA01S00V03P8D = r(max)

label var DayDeaMeRaA01S00V03P8D "DayDeaMeRaA01S00V03 end Date"

format DayDeaMeRaA01S00V03P8D %tdDDMonCCYY


summ DayDeaLoRaA01S00V03 

gen DayDeaLoRaA01S00V03P8V = r(min)

label var DayDeaLoRaA01S00V03P8V "DayDeaLoRaA01S00V03 end Value"


summ DayDeaUpRaA01S00V03 

gen DayDeaUpRaA01S00V03P8V = r(min)

label var DayDeaUpRaA01S00V03P8V "DayDeaUpRaA01S00V03 end Value"


tab1 DayDeaMeRaA01S00V03P8V DayDeaLoRaA01S00V03P8V DayDeaUpRaA01S00V03P8V DayDeaMeRaA01S00V03P8D



*************************************************

* Locate peak dates and values - cases 


* consistently decreasing



* start value (P7)

summ DayCasMeRaA01S00V03 

gen DayCasMeRaA01S00V03P7V = r(max)

label var DayCasMeRaA01S00V03P7V "DayCasMeRaA01S00V03 start Value"

summ date 

gen DayCasMeRaA01S00V03P7D = r(min)

label var DayCasMeRaA01S00V03P7D "DayCasMeRaA01S00V03 start Date"

format DayCasMeRaA01S00V03P7D %tdDDMonCCYY


summ DayCasLoRaA01S00V03 

gen DayCasLoRaA01S00V03P7V = r(max)

label var DayCasLoRaA01S00V03P7V "DayCasLoRaA01S00V03 start Value"


summ DayCasUpRaA01S00V03 

gen DayCasUpRaA01S00V03P7V = r(max)

label var DayCasUpRaA01S00V03P7V "DayCasUpRaA01S00V03 start Value"

tab1 DayCasMeRaA01S00V03P7V DayCasLoRaA01S00V03P7V DayCasUpRaA01S00V03P7V DayCasMeRaA01S00V03P7D



* end value (P8)

summ DayCasMeRaA01S00V03 

gen DayCasMeRaA01S00V03P8V = r(min)

label var DayCasMeRaA01S00V03P8V "DayCasMeRaA01S00V03 end Value"


summ date 

gen DayCasMeRaA01S00V03P8D = r(max)

label var DayCasMeRaA01S00V03P8D "DayCasMeRaA01S00V03 end Date"

format DayCasMeRaA01S00V03P8D %tdDDMonCCYY


summ DayCasLoRaA01S00V03 

gen DayCasLoRaA01S00V03P8V = r(min)

label var DayCasLoRaA01S00V03P8V "DayCasLoRaA01S00V03 end Value"


summ DayCasUpRaA01S00V03 

gen DayCasUpRaA01S00V03P8V = r(min)

label var DayCasUpRaA01S00V03P8V "DayCasUpRaA01S00V03 end Value"

tab1 DayCasMeRaA01S00V03P8V DayCasLoRaA01S00V03P8V DayCasUpRaA01S00V03P8V DayCasMeRaA01S00V03P8V


sort date

compress

save "Iran DELP.dta", replace


********************

* tab the peaks


use "Iran DELP.dta", clear 


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


save "Iran DELP peaks.dta", replace

export delimite using "Iran DELP peaks.csv", replace 










view "log Iran DELP.smcl"

log close

exit, clear




