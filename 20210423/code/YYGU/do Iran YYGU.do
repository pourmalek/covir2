
clear all

cd "$pathcovir2"

cd YYGU

capture log close 

log using "log Iran YYGU.smcl", replace

***************************************************************************
* This is "do Iran YYGU win.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare YYGU data for Iran, Locate peak dates and values
***************************************************************************


/*
YYGU model, model by Youyang Gu, is a SEIR model + Machine Learning, conducted in 2020. 
Study web site, "COVID-19 Projections Using Machine Learning" (https://covid19-projections.com).
Model described here: https://covid19-projections.com/about/#table-of-contents-death-forecasting-model
*/


* Get YYGU estimates 

copy https://raw.githubusercontent.com/youyanggu/covid19_projections/master/projections/combined/latest_global.csv latest_global.csv

import delimited "latest_global.csv", clear varnames(1)

keep if strpos(country, "Iran")
	

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


rename predicted_deaths_mean  DayDeaMeRaA08S00V99 
rename predicted_deaths_lower DayDeaLoRaA08S00V99 
rename predicted_deaths_upper DayDeaUpRaA08S00V99 

label var DayDeaMeRaA08S00V99 "Daily deaths mean YYGU"
label var DayDeaLoRaA08S00V99 "Daily deaths lower YYGU"
label var DayDeaUpRaA08S00V99 "Daily deaths upper YYGU"
	
rename predicted_total_deaths_mean  TotDeaMeRaA08S00V99
rename predicted_total_deaths_lower TotDeaLoRaA08S00V99
rename predicted_total_deaths_upper TotDeaUpRaA08S00V99
	
label var TotDeaMeRaA08S00V99 "Total deaths mean YYGU"
label var TotDeaLoRaA08S00V99 "Total deaths lower YYGU"
label var TotDeaUpRaA08S00V99 "Total deaths upper YYGU"
	
rename predicted_new_infected_mean  DayCasMeRaA08S00V99
rename predicted_new_infected_lower DayCasLoRaA08S00V99
rename predicted_new_infected_upper DayCasUpRaA08S00V99
	
label var DayCasMeRaA08S00V99 "Daily cases mean YYGU"
label var DayCasLoRaA08S00V99 "Daily cases lower YYGU"
label var DayCasUpRaA08S00V99 "Daily cases upper YYGU"

rename predicted_current_infected_mean  DayActMeRaA08S00V99
rename predicted_current_infected_lower DayActLoRaA08S00V99
rename predicted_current_infected_upper DayActUpRaA08S00V99

label var DayActMeRaA08S00V99 "Daily active cases mean YYGU"	
label var DayActLoRaA08S00V99 "Daily active cases lower YYGU"	
label var DayActUpRaA08S00V99 "Daily active cases upper YYGU"	
	
rename predicted_total_infected_mean  TotCasMeRaA08S00V99
rename predicted_total_infected_lower TotCasLoRaA08S00V99
rename predicted_total_infected_upper TotCasUpRaA08S00V99

label var TotCasMeRaA08S00V99 "Total cases mean YYGU"
label var TotCasLoRaA08S00V99 "Total cases lower YYGU"
label var TotCasUpRaA08S00V99 "Total cases upper YYGU"

rename r_values_mean  DayRttMeRaA08S00V99	
rename r_values_lower DayRttLoRaA08S00V99	
rename r_values_upper DayRttUpRaA08S00V99	

label var DayRttMeRaA08S00V99 "Daily R mean YYGU"
label var DayRttLoRaA08S00V99 "Daily R lower YYGU"
label var DayRttUpRaA08S00V99 "Daily R upper YYGU"
	
rename country loc_grand_name 

drop region subregion actual_deaths total_deaths

order date loc_grand_name


* gen cfr 

gen DayCfrMeRaA08S00V99= 100 * DayDeaMeRaA08S00V99 / DayCasMeRaA08S00V99
gen DayCfrLoRaA08S00V99= 100 * DayDeaLoRaA08S00V99 / DayCasLoRaA08S00V99
gen DayCfrUpRaA08S00V99= 100 * DayDeaUpRaA08S00V99/  DayCasUpRaA08S00V99

label var DayCfrMeRaA08S00V99 "Daily CFR Mean YYGU"
label var DayCfrLoRaA08S00V99 "Daily CFR Lower YYGU"
label var DayCfrUpRaA08S00V99 "Daily CFR Upper YYGU"





* gen "Daily cases mean div by daily deaths mean YYGU  DayCbD" for visulization of temporal relation of deaths and cases peaks 


	summ DayDeaMeRaA08S00V99
	gen DayDeMMeRaA08S00V99  = r(mean)
	label var DayDeMMeRaA08S00V99  "Daily deaths mean YYGU  DayDeM"

	summ DayCasMeRaA08S00V99  
	gen DayCaMMeRaA08S00V99  = r(mean)
	label var DayCaMMeRaA08S00V99  "Daily cases mean YYGU  DayCaM"
                           
	gen DayCbDMeRaA08S00V99  = DayCaMMeRaA08S00V99  / DayDeMMeRaA08S00V99 
	label var DayCbDMeRaA08S00V99  "Daily cases mean div by daily deaths mean YYGU  DayCbD"
	summ DayCbDMeRaA08S00V99 
                                              
	gen DayDMuMeRaA08S00V99  = DayDeaMeRaA08S00V99  * DayCbDMeRaA08S00V99 
    label var DayDMuMeRaA08S00V99  "Daily deaths scaled (times means of cases by deaths) YYGU "
	summ DayDMuMeRaA08S00V99 
	




****************************

* graphs 

grstyle init

grstyle color background white



* daily deaths 

twoway ///
(line DayDeaMeRaA08S00V99 date, sort lcolor(black)) ///
if DayDeaMeRaA08S00V99 != . ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, YYGU, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 1 COVID-19 daily deaths, default scenario, Iran, YYGU.gph", replace
graph export "graph 1 COVID-19 daily deaths, default scenario, Iran, YYGU.pdf", replace


* daily deaths CI

twoway ///
(rarea DayDeaLoRaA08S00V99 DayDeaUpRaA08S00V99 date, sort color(black*.2)) ///
(line DayDeaMeRaA08S00V99 date, sort lcolor(black)) ///
if DayDeaMeRaA08S00V99 != . ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, YYGU, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 2 COVID-19 daily deaths, default scenario, Iran, YYGU.gph", replace
graph export "graph 2 COVID-19 daily deaths, default scenario, Iran, YYGU.pdf", replace




* daily cases 

twoway ///
(line DayCasMeRaA08S00V99 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, YYGU, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 3 COVID-19 daily cases, default scenario, Iran, YYGU.gph", replace
graph export "graph 3 COVID-19 daily cases, default scenario, Iran, YYGU.pdf", replace



* daily cases CI

twoway ///
(rarea DayCasLoRaA08S00V99 DayCasUpRaA08S00V99 date, sort color(black*.2)) ///
(line DayCasMeRaA08S00V99 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, YYGU, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 4 COVID-19 daily cases, default scenario, Iran, YYGU.gph", replace
graph export "graph 4 COVID-19 daily cases, default scenario, Iran, YYGU.pdf", replace





* total deaths 

twoway ///
(line TotDeaMeRaA08S00V99 date, sort lcolor(black)) ///
if TotDeaMeRaA08S00V99 != . ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, YYGU, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 5 COVID-19 total deaths, default scenario, Iran, YYGU.gph", replace
graph export "graph 5 COVID-19 total deaths, default scenario, Iran, YYGU.pdf", replace


* total deaths CI

twoway ///
(rarea TotDeaLoRaA08S00V99 TotDeaUpRaA08S00V99 date, sort color(black*.2)) ///
(line TotDeaMeRaA08S00V99 date, sort lcolor(black)) ///
if TotDeaMeRaA08S00V99 != . ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, YYGU, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 6 COVID-19 total deaths, default scenario, Iran, YYGU.gph", replace
graph export "graph 6 COVID-19 total deaths, default scenario, Iran, YYGU.pdf", replace




* total cases 

twoway ///
(line TotCasMeRaA08S00V99 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, YYGU, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 7 COVID-19 total cases, default scenario, Iran, YYGU.gph", replace
graph export "graph 7 COVID-19 total cases, default scenario, Iran, YYGU.pdf", replace


* total cases CI

twoway ///
(rarea TotCasLoRaA08S00V99 TotCasUpRaA08S00V99 date, sort color(black*.2)) ///
(line TotCasMeRaA08S00V99 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, YYGU, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 8 COVID-19 total cases, default scenario, Iran, YYGU.gph", replace
graph export "graph 8 COVID-19 total cases, default scenario, Iran, YYGU.pdf", replace






* daily CFR 

twoway ///
(line DayCfrMeRaA08S00V99 date, sort lcolor(black)) ///
if DayCfrMeRaA08S00V99 !=. ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, YYGU, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 9 COVID-19 daily CFR, default scenario, Iran, YYGU.gph", replace
graph export "graph 9 COVID-19 daily CFR, default scenario, Iran, YYGU.pdf", replace


* daily CFR CI

twoway ///
(rarea DayCfrLoRaA08S00V99 DayCfrUpRaA08S00V99 date, sort color(black*.2)) ///
(line DayCfrMeRaA08S00V99 date, sort lcolor(black)) ///
if DayCfrMeRaA08S00V99 !=. ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, YYGU, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 10 COVID-19 daily CFR, default scenario, Iran, YYGU.gph", replace
graph export "graph 10 COVID-19 daily CFR, default scenario, Iran, YYGU.pdf", replace




* DayCas DayDeaDay Dea_multip

twoway ///
(line DayCasMeRaA08S00V99 date, sort lcolor(blue)) ///
(line DayDeaMeRaA08S00V99 date, sort lcolor(red)) ///
(line DayDMuMeRaA08S00V99 date, sort lpattern(dot) lcolor(red)) ///
if date > td(01jan2020) ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases and deaths) title("COVID-19 daily cases and deaths, Iran, YYGU ", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) yscale(titlegap(4)) legend(region(lcolor(none)))  ///
legend(order(1 "Daily cases" 2 "Daily deaths" 3 "Daily deaths scaled for visualization") size(small)) ///
subtitle("Daily deaths, scaled = times (means of cases divided by deaths) for visualization only", size(small)) ///
note("Current scenario, mean estimate")

qui graph save "graph 10 COVID-19 daily deaths and cases Iran, YYGU .gph", replace
qui graph export "graph 10 COVID-19 daily deaths and cases Iran, YYGU .pdf", replace

***




qui compress

sort date

save "Iran YYGU.dta", replace
 


view "log Iran YYGU.smcl"

log close

exit, clear




