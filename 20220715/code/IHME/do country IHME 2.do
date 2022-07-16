
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





* download updates after uptake 20220708 + graph 1
* input data files: "country IHME longit 20220708.dta"
* output data files: "country IHME longit.dta"


* download updates after uptake 20220708

* no IHME update/s after uptake 20220708


* merge "country IHME longit 20220708.dta" with downloadED updates after uptake 20220708



use "country IHME longit 20220708.dta", clear


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


