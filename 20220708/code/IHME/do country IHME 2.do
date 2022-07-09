
clear all

cd "$pathcovir2"

cd IHME

capture log close 

log using "log country IHME 2.smcl", replace

***************************************************************************
* This is "do country IHME 2.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek
***************************************************************************



* continue preparation of estimates files and merge them, graphs
* Forecast and backcast
* input data files: "IHME`update'.dta" and "country JOHN.dta"
* output data files: "country IHME longit.dta"




local list ///
20220110 ///
20220114 ///
20220121 ///
20220204 ///
20220218 ///
20220321 ///
20220408 ///
20220506 ///
20220610 ///




foreach update of local list {
	
	use "IHME `update'.dta", clear

	capture drop DayDeaFOREA02`update'
	
	gen DayDeaFOREA02`update' = DayDeaMeSmA02`update'
	
	replace DayDeaFOREA02`update' = . if date < epoch`update'
	
	label var DayDeaFOREA02`update' "DayDeaMeSmA02S01 Forecast only"
	
	save "IHME `update'.dta", replace

}
*


foreach update of local list {
	
	merge m:m date loc_grand_name using "IHME `update'.dta"
	
	drop _merge
	
}
*	





duplicates drop date, force

isid date

order loc_grand_name date DayDeaFOREA02* epoch*

sort loc_grand_name date

qui compress

save "country IHME longit.dta", replace







* add JOHN

cd ..

cd JOHN

use "country JOHN.dta", clear 

cd ..

cd IHME

save "country JOHN.dta", replace 


merge m:m loc_grand_name date using "country IHME longit.dta"

drop _merge


drop DayDeaMeRa*

drop Tot*

drop provincestate


duplicates drop date, force

isid date

qui compress

save "country IHME longit.dta", replace







***********************************************

* graphs



grstyle init

grstyle color background white



***********************************************

* graph 1 Daily deaths, Updates together, no extremes, backcasts and forecasts

twoway /// 
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// "JOHN smooth"
(line DayDeaMeSmA0220220110 date, sort lcolor(gold) lwidth(medium)) ///
(line DayDeaMeSmA0220220114 date, sort lcolor(gold) lwidth(medium)) ///
(line DayDeaMeSmA0220220121 date, sort lcolor(gold) lwidth(medium)) ///
(line DayDeaMeSmA0220220204 date, sort lcolor(gold) lwidth(medium)) ///
(line DayDeaMeSmA0220220218 date, sort lcolor(gold) lwidth(medium)) ///
(line DayDeaMeSmA0220220321 date, sort lcolor(gold) lwidth(medium)) ///
(line DayDeaMeSmA0220220408 date, sort lcolor(gold) lwidth(medium)) ///
(line DayDeaMeSmA0220220506 date, sort lcolor(gold) lwidth(medium)) ///
(line DayDeaMeSmA0220220610 date, sort lcolor(gold) lwidth(medium)) /// 9
(line DayDeaFOREA0220220110 date, sort lcolor(black) lwidth(medium)) ///
(line DayDeaFOREA0220220114 date, sort lcolor(black) lwidth(medium)) ///
(line DayDeaFOREA0220220121 date, sort lcolor(black) lwidth(medium)) ///
(line DayDeaFOREA0220220204 date, sort lcolor(black) lwidth(medium)) ///
(line DayDeaFOREA0220220218 date, sort lcolor(black) lwidth(medium)) ///
(line DayDeaFOREA0220220321 date, sort lcolor(black) lwidth(medium)) ///
(line DayDeaFOREA0220220408 date, sort lcolor(black) lwidth(medium)) ///
(line DayDeaFOREA0220220506 date, sort lcolor(black) lwidth(medium)) ///
(line DayDeaFOREA0220220610 date, sort lcolor(red) lwidth(thick)) ///
if date >= td(01jan2022) ///
, xtitle(Date) xlabel(#11, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("C19 daily deaths, $country, IHME, updates in 2022", size(medium) color(black)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME previous updates, backcast" 11 "IHME previous updates, forecast" ///
19 "IHME latest update 20220610, forecast") size(small) row(2)) ///
subtitle("Forecasts and backcasts; smooth; no extremes", size(small)) yscale(titlegap(2))

qui graph export "graph 1 $country C19 daily deaths, IHME, Updates together no extremes.pdf", replace






**********************

view "log country IHME 2.smcl"

log close

exit, clear


