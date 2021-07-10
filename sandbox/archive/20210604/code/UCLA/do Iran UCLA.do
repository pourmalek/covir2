
clear all

cd "$pathcovir2"

cd UCLA

capture log close 

log using "log Iran UCLA.smcl", replace

***************************************************************************
* This is "do Iran UCLA.do"

* Project: COVID-19 Iran Review No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare UCLA data for Iran
***************************************************************************


* Get UCLA estimates 

/* 

estimates files:


		ucla-covid19-forecasts-master/
		
		/current_projection/pred_world_new.csv			24 days ago on 20210530 (History on GitHub: _latest interaction_)
		
			Iran 2021-05-02 to 2021-08-09

		/current_projection/pred_world.csv				5 months ago on 20210530 (History on GitHub)
		
			Iran 2020-11-08 to 2021-02-15
			
			
		/projection_reult/pred_world_01-03.csv to pred_world-05-08.csv
		
			pred_world-05-08.csv		Region = US						3 months ago on 20210530 (History on GitHub)
			pred_world-05-01-210		Region = US
			pred_world-4-24				Region = US
			pred_world_12-20			Iran 2020-12-20 to 2021-03-29
			...			
			pred_world_01-03			Iran 2021-01-03 to 2021-04-12	5 months ago on 20210530 (History on GitHub)
		
		
		timeline for Iran:
		
		2020-11-08 to 2021-02-15		/current_projection/pred_world.csv
		2021-01-03 to 2021-04-12		/projection_reult/pred_world_01-03.csv		overlap = 2021-01-03 to 2021-02-15
		2021-05-02 to 2021-08-09		/current_projection/pred_world_new.csv
		
		
*/ 


** get 2020-11-08 to 2021-02-15		/current_projection/pred_world.csv

clear

copy https://raw.githubusercontent.com/uclaml/ucla-covid19-forecasts/master/current_projection/pred_world.csv pred_world.csv

import delimited using "pred_world.csv", clear varnames(1)

rename region loc_grand_name

keep if loc_grand_name == "Iran"

* gen date

rename date date_original
gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date // 08nov2020,15feb2021
drop year month day date2

save "pred_world.dta", replace




** get 2021-01-03 to 2021-04-12		/projection_reult/pred_world_01-03.csv


clear

copy https://raw.githubusercontent.com/uclaml/ucla-covid19-forecasts/master/projection_result/pred_world_01-03.csv pred_world_01-03.csv

import delimited using "pred_world_01-03.csv", clear varnames(1)

rename region loc_grand_name

keep if loc_grand_name == "Iran"

* gen date

rename date date_original
gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date // 03jan2021,12apr2021
drop year month day date2

save "pred_world_01-03.dta", replace




** get 2021-05-02 to 2021-08-09		/current_projection/pred_world_new.csv


clear

copy https://raw.githubusercontent.com/uclaml/ucla-covid19-forecasts/master/current_projection/pred_world_new.csv pred_world_new.csv

import delimited using "pred_world_new.csv", clear varnames(1)

rename region loc_grand_name

keep if loc_grand_name == "Iran"

* gen date

rename date date_original
gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date // 02may2021,09aug2021
drop year month day date2

save "pred_world_new.dta", replace

*


** append timelines for Iran

use "pred_world.dta", clear

append using "pred_world_01-03.dta", gen(source_pred_world_01_03) 

append using "pred_world_new.dta", gen(source_pred_world_new) 

duplicates tag date, gen(duptag)

tab duptag

gsort -duptag date 

list in 1/2, clean

* get estimates for overlap period from /current_projection/pred_world.csv rather than from /projection_reult/pred_world_01-03.csv	

drop if source_pred_world_01_03 == 1


isid date

drop source_pred_world_01_03 source_pred_world_new duptag

sort date

codebook date // 08nov2020,09aug2021


line pre_fata_daily date

line pre_fata_daily lower_pre_fata_daily upper_pre_fata_daily date

line pre_act date

*


** keep using /ucla-covid19-forecasts-master/current_projection/pred_world_new.csv Iran 2021-05-02 to 2021-08-09

use "pred_world_new.dta", clear 


line pre_fata_daily lower_pre_fata_daily upper_pre_fata_daily date


local varlist pre_fata_daily lower_pre_fata_daily upper_pre_fata_daily lower_pre_act pre_confirm_daily lower_pre_confirm_daily upper_pre_confirm_daily

foreach var of local varlist {

	replace `var' = . if `var' == 0

}
*

line pre_fata_daily lower_pre_fata_daily upper_pre_fata_daily date

line pre_confirm_daily lower_pre_confirm_daily upper_pre_confirm_daily date

line pre_fata lower_pre_fata upper_pre_fata date

line pre_confirm lower_pre_confirm upper_pre_confirm date


rename pre_fata_daily       DayDeaMeRaA17S00
rename lower_pre_fata_daily DayDeaLoRaA17S00
rename upper_pre_fata_daily DayDeaUpRaA17S00

rename pre_confirm_daily       DayCasMeRaA17S00
rename lower_pre_confirm_daily DayCasLoRaA17S00
rename upper_pre_confirm_daily DayCasUpRaA17S00

rename pre_fata       TotDeaMeRaA17S00
rename lower_pre_fata TotDeaLoRaA17S00
rename upper_pre_fata TotDeaUpRaA17S00

rename pre_confirm       TotCasMeRaA17S00
rename lower_pre_confirm TotCasLoRaA17S00
rename upper_pre_confirm TotCasUpRaA17S00

label var DayDeaMeRaA17S00 "Daily Deaths Mean UCLA"
label var DayDeaLoRaA17S00 "Daily Deaths Lower UCLA"
label var DayDeaUpRaA17S00 "Daily Deaths Upper UCLA"

label var DayCasMeRaA17S00 "Daily Cases Mean UCLA"
label var DayCasLoRaA17S00 "Daily Cases Lower UCLA"
label var DayCasUpRaA17S00 "Daily Cases Upper UCLA"

label var TotDeaMeRaA17S00 "Total Deaths Mean UCLA"
label var TotDeaLoRaA17S00 "Total Deaths Lower UCLA"
label var TotDeaUpRaA17S00 "Total Deaths Upper UCLA"

label var TotCasMeRaA17S00 "Total Cases Mean UCLA"
label var TotCasMeRaA17S00 "Total Cases Lower UCLA"
label var TotCasUpRaA17S00 "Total Cases Upper UCLA"


* gen cfr 

gen DayCfrMeRaA17S00 = 100 * DayDeaMeRaA17S00 / DayCasMeRaA17S00
gen DayCfrLoRaA17S00 = 100 * DayDeaLoRaA17S00 / DayCasLoRaA17S00
gen DayCfrUpRaA17S00 = 100 * DayDeaUpRaA17S00 / DayCasUpRaA17S00

label var DayCfrMeRaA17S00 "Daily CFR Mean UCLA"
label var DayCfrLoRaA17S00 "Daily CFR Lower UCLA"
label var DayCfrUpRaA17S00 "Daily CFR Upper UCLA"


* gen "Daily cases mean div by daily deaths mean UCLA  DayCbD" for visulization of temporal relation of deaths and cases peaks 


summ DayDeaMeRaA17S00 
gen DayDeMMeRaA17S00   = r(mean)
label var DayDeMMeRaA17S00   "Daily deaths mean UCLA  DayDeM"

summ DayCasMeRaA17S00   
gen DayCaMMeRaA17S00   = r(mean)
label var DayCaMMeRaA17S00   "Daily cases mean UCLA  DayCaM"
                           
gen DayCbDMeRaA17S00   = DayCaMMeRaA17S00   / DayDeMMeRaA17S00  
label var DayCbDMeRaA17S00   "Daily cases mean div by daily deaths mean UCLA  DayCbD"
summ DayCbDMeRaA17S00  
                                              
gen DayDMuMeRaA17S00   = DayDeaMeRaA17S00   * DayCbDMeRaA17S00  
label var DayDMuMeRaA17S00   "Daily deaths scaled (times means of cases by deaths) UCLA "
summ DayDMuMeRaA17S00  
	




****************************

* graphs 

grstyle init

grstyle color background white



* daily deaths 

twoway ///
(line DayDeaMeRaA17S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, UCLA, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 1 COVID-19 daily deaths, default scenario, Iran, UCLA.gph", replace
graph export "graph 1 COVID-19 daily deaths, default scenario, Iran, UCLA.pdf", replace




* daily deaths CI

twoway ///
(rarea DayDeaLoRaA17S00 DayDeaUpRaA17S00 date, sort color(black*.2)) ///
(line DayDeaMeRaA17S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, UCLA, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 2 COVID-19 daily deaths, default scenario, Iran, UCLA.gph", replace
graph export "graph 2 COVID-19 daily deaths, default scenario, Iran, UCLA.pdf", replace




* daily cases 

twoway ///
(line DayCasMeRaA17S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, UCLA, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 3 COVID-19 daily cases, default scenario, Iran, UCLA.gph", replace
graph export "graph 3 COVID-19 daily cases, default scenario, Iran, UCLA.pdf", replace




* daily cases CI

twoway ///
(rarea DayCasLoRaA17S00 DayCasUpRaA17S00 date, sort color(black*.2)) ///
(line DayCasMeRaA17S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, UCLA, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 4 COVID-19 daily cases, default scenario, Iran, UCLA.gph", replace
graph export "graph 4 COVID-19 daily cases, default scenario, Iran, UCLA.pdf", replace




* total deaths 

twoway ///
(line TotDeaMeRaA17S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, UCLA, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 5 COVID-19 total deaths, default scenario, Iran, UCLA.gph", replace
graph export "graph 5 COVID-19 total deaths, default scenario, Iran, UCLA.pdf", replace




* total deaths CI

twoway ///
(rarea TotDeaLoRaA17S00 TotDeaUpRaA17S00 date, sort color(black*.2)) ///
(line TotDeaMeRaA17S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, UCLA, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 6 COVID-19 total deaths, default scenario, Iran, UCLA.gph", replace
graph export "graph 6 COVID-19 total deaths, default scenario, Iran, UCLA.pdf", replace




* total cases 

twoway ///
(line TotCasMeRaA17S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, UCLA, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 7 COVID-19 total cases, default scenario, Iran, UCLA.gph", replace
graph export "graph 7 COVID-19 total cases, default scenario, Iran, UCLA.pdf", replace




* total cases CI

twoway ///
(rarea TotCasLoRaA17S00 TotCasUpRaA17S00 date, sort color(black*.2)) ///
(line TotCasMeRaA17S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, UCLA, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 8 COVID-19 total cases, default scenario, Iran, UCLA.gph", replace
graph export "graph 8 COVID-19 total cases, default scenario, Iran, UCLA.pdf", replace




* daily CFR 

twoway ///
(line DayCfrMeRaA17S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, UCLA, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 9 COVID-19 daily CFR, default scenario, Iran, UCLA.gph", replace
graph export "graph 9 COVID-19 daily CFR, default scenario, Iran, UCLA.pdf", replace




* daily CFR CI

twoway ///
(rarea DayCfrLoRaA17S00 DayCfrUpRaA17S00 date, sort color(black*.2)) ///
(line DayCfrMeRaA17S00 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, UCLA, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 10 COVID-19 daily CFR, default scenario, Iran, UCLA.gph", replace
graph export "graph 10 COVID-19 daily CFR, default scenario, Iran, UCLA.pdf", replace




* DayCas DayDeaDay Dea_multip

twoway ///
(line DayCasMeRaA17S00 date, sort lcolor(blue)) ///
(line DayDeaMeRaA17S00 date, sort lcolor(red)) ///
(line DayDMuMeRaA17S00 date, sort lpattern(dot) lcolor(red)) ///
if date > td(01jan2020) ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases and deaths) title("COVID-19 daily cases and deaths, Iran, UCLA ", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) yscale(titlegap(4)) legend(region(lcolor(none)))  ///
legend(order(1 "Daily cases" 2 "Daily deaths" 3 "Daily deaths scaled for visualization") size(small)) ///
subtitle("Daily deaths, scaled = times (means of cases divided by deaths) for visualization only", size(small)) ///
note("Current scenario, mean estimate")

qui graph save "graph 10 COVID-19 daily deaths and cases Iran, UCLA .gph", replace
qui graph export "graph 10 COVID-19 daily deaths and cases Iran, UCLA .pdf", replace

***




qui compress

sort date loc_grand_name 

save "Iran UCLA.dta", replace
 


view "log Iran UCLA.smcl"

log close

exit, clear




