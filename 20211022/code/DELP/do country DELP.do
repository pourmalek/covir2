
clear all
 
cd "$pathcovir2"

cd DELP

capture log close 

log using "log country DELP.smcl", replace

******************************************************************************
* This is "do country DELP.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare DELPHI data for country
******************************************************************************


                                                                                                         ***************************
* To change update date, find and replace all, 20211022 (old), with 20211022 (new) <<--           <<<--- * change update date here *
                                                                                                         ***************************

* Get DELPHI data for country


clear

copy https://raw.githubusercontent.com/COVIDAnalytics/website/master/data/predicted/Global_V4_since100_20211022.csv Global_V4_since100_20211022.csv

import delimited using "Global_V4_since100_20211022.csv", clear varnames(1)

rename country loc_grand_name

keep if regexm(loc_grand_name,"$country") == 1


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

rename totaldetecteddeaths   TotDeaMeRaA01S00
rename totaldetecteddeathslb TotDeaLoRaA01S00
rename totaldetecteddeathsub TotDeaUpRaA01S00

label var TotDeaMeRaA01S00 "Total Deaths Mean DELP S0"
label var TotDeaMeRaA01S00 "Total Deaths Lower DELP S0"
label var TotDeaMeRaA01S00 "Total Deaths Upper DELP S0"

rename totaldetected   TotCasMeRaA01S00
rename totaldetectedlb TotCasLoRaA01S00
rename totaldetectedub TotCasUpRaA01S00

label var TotCasMeRaA01S00 "Total Cases Mean DELP S0"
label var TotCasMeRaA01S00 "Total Cases Lower DELP S0"
label var TotCasMeRaA01S00 "Total Cases Upper DELP S0"


* gen daily vars and rename

sort date

gen DayDeaMeRaA01S00 =  TotDeaMeRaA01S00[_n] - TotDeaMeRaA01S00[_n-1]

gen DayDeaLoRaA01S00 =  TotDeaLoRaA01S00[_n] - TotDeaLoRaA01S00[_n-1]

gen DayDeaUpRaA01S00 =  TotDeaUpRaA01S00[_n] - TotDeaUpRaA01S00[_n-1]

gen DayCasMeRaA01S00 =  TotCasMeRaA01S00[_n] - TotCasMeRaA01S00[_n-1]

gen DayCasLoRaA01S00 =  TotCasLoRaA01S00[_n] - TotCasLoRaA01S00[_n-1]

gen DayCasUpRaA01S00 =  TotCasUpRaA01S00[_n] - TotCasUpRaA01S00[_n-1]


label var DayDeaMeRaA01S00 "Daily Deaths Mean DELP S0"
label var DayDeaLoRaA01S00 "Daily Deaths Lower DELP S0"
label var DayDeaUpRaA01S00 "Daily Deaths Upper DELP S0"

label var DayCasMeRaA01S00 "Daily Cases Mean DELP S0"
label var DayCasLoRaA01S00 "Daily Cases Lower DELP S0"
label var DayCasUpRaA01S00 "Daily Cases Upper DELP S0"

label var TotDeaMeRaA01S00 "Total Deaths Mean DELP S0"
label var TotDeaLoRaA01S00 "Total Deaths Lower DELP S0"
label var TotDeaUpRaA01S00 "Total Deaths Upper DELP S0"

label var TotCasMeRaA01S00 "Total Cases Mean DELP S0"
label var TotCasLoRaA01S00 "Total Cases Lower DELP S0"
label var TotCasUpRaA01S00 "Total Cases Upper DELP S0"



rename active DayActMeRaA01S00

rename activehospitalized DayHosMeRaA01S00

rename activeventilated DayVenMeRaA01S00

rename cumulativehospitalized TotHosMeRaA01S00

label var DayActMeRaA01S00 "Daily Cases Active Mean DELP S0"

label var DayHosMeRaA01S00 "Daily Cases Active Hospitalized Mean DELP S0"

label var DayVenMeRaA01S00 "Daily Cases Active Ventilated Mean DELP S0"

label var TotHosMeRaA01S00 "Total Cases Active Mean DELP S0"

 

keep ///
loc_grand_name date ///
TotDeaMeRaA01S00 TotDeaLoRaA01S00 TotDeaUpRaA01S00 ///
DayDeaMeRaA01S00 DayDeaLoRaA01S00 DayDeaUpRaA01S00 ///
TotCasMeRaA01S00 TotCasLoRaA01S00 TotCasUpRaA01S00 ///
DayCasMeRaA01S00 DayCasLoRaA01S00 DayCasUpRaA01S00 ///
DayActMeRaA01S00 DayHosMeRaA01S00 DayVenMeRaA01S00 TotHosMeRaA01S00


order ///
loc_grand_name date ///
TotDeaMeRaA01S00 TotDeaLoRaA01S00 TotDeaUpRaA01S00 ///
DayDeaMeRaA01S00 DayDeaLoRaA01S00 DayDeaUpRaA01S00 ///
TotCasMeRaA01S00 TotCasLoRaA01S00 TotCasUpRaA01S00 ///
DayCasMeRaA01S00 DayCasLoRaA01S00 DayCasUpRaA01S00 ///
DayActMeRaA01S00 DayHosMeRaA01S00 DayVenMeRaA01S00 TotHosMeRaA01S00



* gen cfr

gen DayCfrMeRaA01S00 = 100 * DayDeaMeRaA01S00 / DayCasMeRaA01S00
gen DayCfrLoRaA01S00 = 100 * DayDeaLoRaA01S00 / DayCasLoRaA01S00
gen DayCfrUpRaA01S00 = 100 * DayDeaUpRaA01S00 / DayCasUpRaA01S00

label var DayCfrMeRaA01S00 "Daily CFR Mean DELP S0 V4"
label var DayCfrLoRaA01S00 "Daily CFR Lower DELP S0 V4"
label var DayCfrUpRaA01S00 "Daily CFR Upper DELP S0 V4"




*





* gen "Daily cases mean div by daily deaths mean DELP DayCbD" for visulization of temporal relation of deaths and cases peaks 


summ DayDeaMeRaA01S00 
gen DayDeMMeRaA01S00 = r(mean)
label var DayDeMMeRaA01S00 "Daily deaths mean DELP DayDeM"

summ DayCasMeRaA01S00 
gen DayCaMMeRaA01S00 = r(mean)
label var DayCaMMeRaA01S00 "Daily cases mean DELP DayCaM"
                              
gen DayCbDMeRaA01S00 = DayCaMMeRaA01S00 / DayDeaMeRaA01S00
label var DayCbDMeRaA01S00 "Daily cases mean div by daily deaths mean DELP DayCbD"
summ DayCbDMeRaA01S00
	
gen DayDMuMeRaA01S00 = DayDeaMeRaA01S00 * DayCbDMeRaA01S00
label var DayDMuMeRaA01S00 "Daily deaths scaled (times means of cases by deaths) only for visualization DELP"
summ DayDMuMeRaA01S00	




***********************

* graphs


grstyle init

grstyle color background white



* daily deaths wo CI

twoway  ///
(line DayDeaMeRaA01S00 date, sort lcolor(green)) ///
if DayDeaMeRaA01S00 != ., legend(off) ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
  	   
graph save "graph 1 COVID-19 daily deaths, $country, DELP wo CI.gph", replace
graph export "graph 1 COVID-19 daily deaths, $country, DELP wo CI.pdf", replace




* daily deaths with CI

twoway (rarea DayDeaLoRaA01S00 DayDeaUpRaA01S00 date, sort color(green*.2)) ///
(line DayDeaMeRaA01S00 date, sort lcolor(green)) ///
if DayDeaMeRaA01S00 != ., legend(off) ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
subtitle("with confidence limits", size(small))	
  	   
graph save "graph 2 COVID-19 daily deaths, $country, DELP with CI.gph", replace
graph export "graph 2 COVID-19 daily deaths, $country, DELP with CI.pdf", replace




* total deaths wo CI 

twoway  ///
(line TotDeaMeRaA01S00 date, sort lcolor(green)) ///
if DayDeaMeRaA01S00 != ., legend(off) ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)

graph save "graph 3 COVID-19 total deaths, $country, DELP wo CI.gph", replace
graph export "graph 3 COVID-19 total deaths, $country, DELP wo CI.pdf", replace




* total deaths with CI 

twoway (rarea TotDeaLoRaA01S00 TotDeaUpRaA01S00 date, sort color(green*.2)) ///
(line TotDeaMeRaA01S00 date, sort lcolor(green)) ///
if DayDeaMeRaA01S00 != ., legend(off) ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
subtitle("with confidence limits", size(small))	
	
graph save "graph 4 COVID-19 total deaths, $country, DELP with CI.gph", replace
graph export "graph 4 COVID-19 total deaths, $country, DELP with CI.pdf", replace




* daily cases wo CI

twoway ///
(line DayCasMeRaA01S00 date, sort lcolor(green)) ///
if DayDeaMeRaA01S00 != ., legend(off) ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	

graph save "graph 5 COVID-19 daily cases, $country, DELP wo CI.gph", replace
graph export "graph 5 COVID-19 daily cases, $country, DELP wo CI.pdf", replace




* daily cases with CI

twoway (rarea DayCasLoRaA01S00 DayCasUpRaA01S00 date, sort color(green*.2)) ///
(line DayCasMeRaA01S00 date, sort lcolor(green)) ///
if DayDeaMeRaA01S00 != ., legend(off) ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
subtitle("with confidence limits", size(small))	

graph save "graph 6 COVID-19 daily cases, $country, DELP with CI.gph", replace
graph export "graph 6 COVID-19 daily cases, $country, DELP with CI.pdf", replace




* total cases wo CI

twoway ///
(line TotCasMeRaA01S00 date, sort lcolor(green)) ///
if DayDeaMeRaA01S00 != ., legend(off) ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, $country, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	

graph save "graph 7 COVID-19 total cases, $country, DELP wo CI.gph", replace
graph export "graph 7 COVID-19 total cases, $country, DELP wo CI.pdf", replace




* total cases with CI

twoway (rarea TotCasLoRaA01S00 TotCasUpRaA01S00 date, sort color(green*.2)) ///
(line TotCasMeRaA01S00 date, sort lcolor(green)) ///
if DayDeaMeRaA01S00 != ., legend(off) ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, $country, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
subtitle("with confidence limits", size(small))	
	
graph save "graph 8 COVID-19 total cases, $country, DELP with CI.gph", replace
graph export "graph 8 COVID-19 total cases, $country, DELP with CI.pdf", replace




* daily cfr 

twoway (rarea DayCfrLoRaA01S00 DayCfrUpRaA01S00 date, sort color(green*.2)) ///
(line DayCfrMeRaA01S00 date, sort lcolor(green)) ///
if DayDeaMeRaA01S00 != ., legend(off) ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily CFR, $country, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	

graph save "graph 9 COVID-19 daily CFR, $country, DELP.gph", replace
graph export "graph 9 COVID-19 daily CFR, $country, DELP.pdf", replace




* daily cases active, active hospitalized, active ventilated

twoway ///
(line DayActMeRaA01S00 date, sort lcolor(green)) ///
(line DayHosMeRaA01S00 date, sort lcolor(black)) ///
(line DayVenMeRaA01S00 date, sort lcolor(red)) ///
if DayDeaMeRaA01S00 != ., ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcome) title("COVID-19 daily cases, $country, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Active cases" 2 "Active hospitalized" 3 "Active ventilated") rows(1)) ///
subtitle("active cases, active hospitalized, active ventilated", size(small))	
	   
graph save "graph 10 COVID-19 daily cases etc, $country, DELP wo CI.gph", replace
graph export "graph 10 COVID-19 daily cases etc, $country, DELP wo CI.pdf", replace




* daily active hospitalized, active ventilated

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(black)) ///
(line DayVenMeRaA01S00 date, sort lcolor(red)) ///
if DayDeaMeRaA01S00 != .,  ///	   
xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcome) title("COVID-19 daily cases, $country, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Active hospitalized" 2 "Active ventilated") rows(1)) ///
subtitle("active hospitalized, active ventilated", size(small))	

graph save "graph 11 COVID-19 daily cases etc, $country, DELP wo CI.gph", replace
graph export "graph 11 COVID-19 daily cases etc, $country, DELP wo CI.pdf", replace




** DayCas DayDea DayDea_multip

twoway ///
(line DayCasMeRaA01S00 date, sort lcolor(blue)) ///
(line DayDeaMeRaA01S00 date, sort lcolor(red)) ///
(line DayDMuMeRaA01S00 date, sort lpattern(dot) lcolor(red)) ///
if date > td(01jan2020) ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases and deaths) title("COVID-19 daily cases and deaths, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) yscale(titlegap(4)) legend(region(lcolor(none)))  ///
legend(order(1 "Daily cases" 2 "Daily deaths" 3 "Daily deaths scaled for visualization") size(small)) ///
subtitle("Daily deaths, scaled = times (means of cases divided by deaths) for visualization only", size(small)) ///
note("Single scenario, mean estimate")

graph save "graph 12 COVID-19 daily deaths and cases $country, DELP.gph", replace
graph export "graph 12 COVID-19 daily deaths and cases $country, DELP.pdf", replace





sort date loc_grand_name

qui compress

save "country DELP.dta", replace





view "log country DELP.smcl"

log close

exit, clear




