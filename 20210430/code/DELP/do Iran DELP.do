
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




*





* gen "Daily cases mean div by daily deaths mean DELP DayCbD" for visulization of temporal relation of deaths and cases peaks 


	summ DayDeaMeRaA01S00V03 
	gen DayDeMMeRaA01S00V03 = r(mean)
	label var DayDeMMeRaA01S00V03 "Daily deaths mean DELP DayDeM"

	summ DayCasMeRaA01S00V03 
	gen DayCaMMeRaA01S00V03 = r(mean)
	label var DayCaMMeRaA01S00V03 "Daily cases mean DELP DayCaM"
                              
	gen DayCbDMeRaA01S00V03 = DayCaMMeRaA01S00V03 / DayDeaMeRaA01S00V03
	label var DayCbDMeRaA01S00V03 "Daily cases mean div by daily deaths mean DELP DayCbD"
	summ DayCbDMeRaA01S00V03
	
	gen DayDMuMeRaA01S00V03 = DayDeaMeRaA01S00V03 * DayCbDMeRaA01S00V03
    label var DayDMuMeRaA01S00V03 "Daily deaths scaled (times means of cases by deaths) only for visualization DELP"
	summ DayDMuMeRaA01S00V03	




***********************

* graphs


grstyle init

grstyle color background white



* daily deaths wo CI


twoway  ///
(line DayDeaMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != ., legend(off) ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
   
  	   
graph save "graph 1 COVID-19 daily deaths, Iran, DELP wo CI.gph", replace
graph export "graph 1 COVID-19 daily deaths, Iran, DELP wo CI.pdf", replace


* daily deaths with CI


twoway (rarea DayDeaLoRaA01S00V03 DayDeaUpRaA01S00V03 date, sort color(green*.2)) ///
(line DayDeaMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != ., legend(off) ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
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
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)

graph save "graph 3 COVID-19 total deaths, Iran, DELP wo CI.gph", replace
graph export "graph 3 COVID-19 total deaths, Iran, DELP wo CI.pdf", replace




* total deaths with CI 


twoway (rarea TotDeaLoRaA01S00V03 TotDeaUpRaA01S00V03 date, sort color(green*.2)) ///
(line TotDeaMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != ., legend(off) ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
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
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
	   

graph save "graph 5 COVID-19 daily cases, Iran, DELP wo CI.gph", replace
graph export "graph 5 COVID-19 daily cases, Iran, DELP wo CI.pdf", replace



* daily cases with CI

twoway (rarea DayCasLoRaA01S00V03 DayCasUpRaA01S00V03 date, sort color(green*.2)) ///
(line DayCasMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != ., legend(off) ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
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
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
	   

graph save "graph 7 COVID-19 total cases, Iran, DELP wo CI.gph", replace
graph export "graph 7 COVID-19 total cases, Iran, DELP wo CI.pdf", replace



* total cases with CI

twoway (rarea TotCasLoRaA01S00V03 TotCasUpRaA01S00V03 date, sort color(green*.2)) ///
(line TotCasMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & DayDeaMeRaA01S00V03 != ., legend(off) ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
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
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
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
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
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
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcome) title("COVID-19 daily cases, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Active hospitalized" 2 "Active ventilated") rows(1)) ///
subtitle("active hospitalized, active ventilated", size(small))	

	   

graph save "graph 11 COVID-19 daily cases etc, Iran, DELP wo CI.gph", replace
graph export "graph 11 COVID-19 daily cases etc, Iran, DELP wo CI.pdf", replace






** DayCas DayDea DayDea_multip



twoway ///
(line DayCasMeRaA01S00V03 date, sort lcolor(blue)) ///
(line DayDeaMeRaA01S00V03 date, sort lcolor(red)) ///
(line DayDMuMeRaA01S00V03 date, sort lpattern(dot) lcolor(red)) ///
if date > td(01jan2020) ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases and deaths) title("COVID-19 daily cases and deaths, Iran, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) yscale(titlegap(4)) legend(region(lcolor(none)))  ///
legend(order(1 "Daily cases" 2 "Daily deaths" 3 "Daily deaths scaled for visualization") size(small)) ///
subtitle("Daily deaths, scaled = times (means of cases divided by deaths) for visualization only", size(small)) ///
note("Single scenario, mean estimate")


qui graph save "graph 12 COVID-19 daily deaths and cases Iran, DELP.gph", replace
qui graph export "graph 12 COVID-19 daily deaths and cases Iran, DELP.pdf", replace





sort date

compress

save "Iran DELP.dta", replace






view "log Iran DELP.smcl"

log close

exit, clear




