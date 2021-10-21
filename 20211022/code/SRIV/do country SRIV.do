
clear all

cd "$pathcovir2"

cd SRIV

capture log close 

log using "log country SRIV.smcl", replace

*****************************************************************************
* This is "do country SRIV.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare SRIV data for country
*****************************************************************************


                                                                                                         ***************************
* To change update date, find and replace all, 2021-10-22 (old), with 2021-10-22 (new) <<--       <<<--- * change update date here *
                                                                                                         ***************************

																										 																										 
******* Also, find and replace ALL, 21oct2021 (old), with 21oct2021 (new) **********              <<<---       *  AND HERE  *
                                                                                                         ***************************
* Start date of estimates in each release of SRIV is one day before the release date. 



* Get SRIV estimates 

copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/2021-10-22/global_forecasts_deaths.csv global_forecasts_deaths.csv
copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/2021-10-22/global_forecasts_deaths_lb.csv global_forecasts_deaths_lb.csv
copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/2021-10-22/global_forecasts_deaths_ub.csv global_forecasts_deaths_ub.csv
copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/2021-10-22/global_forecasts_cases.csv global_forecasts_cases.csv
copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/2021-10-22/global_forecasts_cases_lb.csv global_forecasts_cases_lb.csv
copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/2021-10-22/global_forecasts_cases_ub.csv global_forecasts_cases_ub.csv



local list ///
global_forecasts_deaths global_forecasts_deaths_lb global_forecasts_deaths_ub ///
global_forecasts_cases global_forecasts_cases_lb global_forecasts_cases_ub

foreach l of local list {
	import delimited "`l'.csv", clear varnames(1)
	keep if regexm(country,"$country") == 1
	drop id	country
	
	gen i = _n
	reshape long v, i(i) j(j)
	rename v `l'
	rename j date
	drop i

	save "`l'.dta", replace 
}
*

foreach l of local list {
	merge 1:1 date using "`l'.dta"
	drop _merge
}
*

rename global_forecasts_deaths_lb TotDeaLoRaA05S00	
rename global_forecasts_deaths_ub TotDeaUpRaA05S00	
rename global_forecasts_deaths    TotDeaMeRaA05S00
rename global_forecasts_cases_lb  TotCasLoRaA05S00
rename global_forecasts_cases_ub  TotCasUpRaA05S00	
rename global_forecasts_cases	  TotCasMeRaA05S00

label var TotDeaMeRaA05S00 "Total Deaths Mean SRIV"
label var TotDeaLoRaA05S00 "Total Deaths Lower SRIV"
label var TotDeaUpRaA05S00 "Total Deaths Upper SRIV"
label var TotCasMeRaA05S00 "Total Cases Mean SRIV"
label var TotCasLoRaA05S00 "Total Cases Lower SRIV"
label var TotCasUpRaA05S00 "Total Cases Upper SRIV"


* first date in csv files is one day before the update date

rename date date_original
gen date = .
replace date = td(21oct2021) in 1
replace date = date[_n-1] + 1 in 2/l
format date %tdDDMonCCYY
codebook date
drop date_original

sort date

local list ///
DeaMeRaA05S00 DeaLoRaA05S00 DeaUpRaA05S00 ///
CasMeRaA05S00 CasLoRaA05S00 CasUpRaA05S00 

foreach l of local list {
	gen Day`l' =  Tot`l'[_n] - Tot`l'[_n-1]
}
*


label var DayDeaMeRaA05S00 "Daily Deaths Mean SRIV"
label var DayDeaLoRaA05S00 "Daily Deaths Lower SRIV"
label var DayDeaUpRaA05S00 "Daily Deaths Upper SRIV"
label var DayCasMeRaA05S00 "Daily Cases Mean SRIV"
label var DayCasLoRaA05S00 "Daily Cases Lower SRIV"
label var DayCasUpRaA05S00 "Daily Cases Upper SRIV"

gen loc_grand_name = "$country"


order date loc_grand_name

* gen cfr 

gen DayCfrMeRaA05S00 = 100 * DayDeaMeRaA05S00 / DayCasMeRaA05S00
gen DayCfrLoRaA05S00 = 100 * DayDeaLoRaA05S00 / DayCasLoRaA05S00
gen DayCfrUpRaA05S00 = 100 * DayDeaUpRaA05S00 / DayCasUpRaA05S00

label var DayCfrMeRaA05S00 "Daily CFR Mean SRIV"
label var DayCfrLoRaA05S00 "Daily CFR Lower SRIV"
label var DayCfrUpRaA05S00 "Daily CFR Upper SRIV"





* gen "Daily cases mean div by daily deaths mean SRIV  DayCbD" for visulization of temporal relation of deaths and cases peaks 


summ DayDeaMeRaA05S00 
gen DayDeMMeRaA05S00   = r(mean)
label var DayDeMMeRaA05S00   "Daily deaths mean SRIV  DayDeM"

summ DayCasMeRaA05S00   
gen DayCaMMeRaA05S00   = r(mean)
label var DayCaMMeRaA05S00   "Daily cases mean SRIV  DayCaM"
                           
gen DayCbDMeRaA05S00   = DayCaMMeRaA05S00   / DayDeMMeRaA05S00  
label var DayCbDMeRaA05S00   "Daily cases mean div by daily deaths mean SRIV  DayCbD"
summ DayCbDMeRaA05S00  
                                              
gen DayDMuMeRaA05S00   = DayDeaMeRaA05S00   * DayCbDMeRaA05S00  
label var DayDMuMeRaA05S00   "Daily deaths scaled (times means of cases by deaths) SRIV "
summ DayDMuMeRaA05S00  
	




****************************

* graphs 

grstyle init

grstyle color background white



* daily deaths 

twoway ///
(line DayDeaMeRaA05S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 1 COVID-19 daily deaths, default scenario, $country, SRIV.gph", replace
graph export "graph 1 COVID-19 daily deaths, default scenario, $country, SRIV.pdf", replace




* daily deaths CI

twoway ///
(rarea DayDeaLoRaA05S00 DayDeaUpRaA05S00 date, sort color(black*.2)) ///
(line DayDeaMeRaA05S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 2 COVID-19 daily deaths, default scenario, $country, SRIV.gph", replace
graph export "graph 2 COVID-19 daily deaths, default scenario, $country, SRIV.pdf", replace




* daily cases 

twoway ///
(line DayCasMeRaA05S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 3 COVID-19 daily cases, default scenario, $country, SRIV.gph", replace
graph export "graph 3 COVID-19 daily cases, default scenario, $country, SRIV.pdf", replace




* daily cases CI

twoway ///
(rarea DayCasLoRaA05S00 DayCasUpRaA05S00 date, sort color(black*.2)) ///
(line DayCasMeRaA05S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 4 COVID-19 daily cases, default scenario, $country, SRIV.gph", replace
graph export "graph 4 COVID-19 daily cases, default scenario, $country, SRIV.pdf", replace




* total deaths 

twoway ///
(line TotDeaMeRaA05S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 5 COVID-19 total deaths, default scenario, $country, SRIV.gph", replace
graph export "graph 5 COVID-19 total deaths, default scenario, $country, SRIV.pdf", replace




* total deaths CI

twoway ///
(rarea TotDeaLoRaA05S00 TotDeaUpRaA05S00 date, sort color(black*.2)) ///
(line TotDeaMeRaA05S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 6 COVID-19 total deaths, default scenario, $country, SRIV.gph", replace
graph export "graph 6 COVID-19 total deaths, default scenario, $country, SRIV.pdf", replace




* total cases 

twoway ///
(line TotCasMeRaA05S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, $country, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 7 COVID-19 total cases, default scenario, $country, SRIV.gph", replace
graph export "graph 7 COVID-19 total cases, default scenario, $country, SRIV.pdf", replace




* total cases CI

twoway ///
(rarea TotCasLoRaA05S00 TotCasUpRaA05S00 date, sort color(black*.2)) ///
(line TotCasMeRaA05S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, $country, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 8 COVID-19 total cases, default scenario, $country, SRIV.gph", replace
graph export "graph 8 COVID-19 total cases, default scenario, $country, SRIV.pdf", replace




* daily CFR 

twoway ///
(line DayCfrMeRaA05S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, $country, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 9 COVID-19 daily CFR, default scenario, $country, SRIV.gph", replace
graph export "graph 9 COVID-19 daily CFR, default scenario, $country, SRIV.pdf", replace




* daily CFR CI

twoway ///
(rarea DayCfrLoRaA05S00 DayCfrUpRaA05S00 date, sort color(black*.2)) ///
(line DayCfrMeRaA05S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, $country, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 10 COVID-19 daily CFR, default scenario, $country, SRIV.gph", replace
graph export "graph 10 COVID-19 daily CFR, default scenario, $country, SRIV.pdf", replace




* DayCas DayDeaDay Dea_multip

twoway ///
(line DayCasMeRaA05S00 date, sort lcolor(blue)) ///
(line DayDeaMeRaA05S00 date, sort lcolor(red)) ///
(line DayDMuMeRaA05S00 date, sort lpattern(dot) lcolor(red)) ///
if date > td(01jan2020) ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases and deaths) title("COVID-19 daily cases and deaths, $country, SRIV ", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) yscale(titlegap(4)) legend(region(lcolor(none)))  ///
legend(order(1 "Daily cases" 2 "Daily deaths" 3 "Daily deaths scaled for visualization") size(small)) ///
subtitle("Daily deaths, scaled = times (means of cases divided by deaths) for visualization only", size(small)) ///
note("Current scenario, mean estimate")

qui graph save "graph 10 COVID-19 daily deaths and cases $country, SRIV .gph", replace
qui graph export "graph 10 COVID-19 daily deaths and cases $country, SRIV .pdf", replace

***




qui compress

sort date loc_grand_name 

save "country SRIV.dta", replace
 


view "log country SRIV.smcl"

log close

exit, clear



