
clear all

cd "$pathcovir2"

cd IMPE

capture log close 

log using "log country IMPE 3.smcl", replace

***************************************************************************
* This is "do country IMPE 3.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek
***************************************************************************


* graphs, daily deaths: updates separate 
* input data files: "country IMPE longit.dta"
* output data files: none. no change in data.






use "country IMPE longit.dta", clear



grstyle init

grstyle color background white



***********************************************

* graph 1 Daily deaths, Updates together, with extremes, backcasts and forecasts

twoway /// 
(line DayDeaMeSmA0320220102 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0320220120 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0320220131 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0320220315 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0320220530 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0320220620 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0320220703 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaFOREA0320220102 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220120 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220131 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220315 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220530 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220620 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220703 date, sort lcolor(black) lwidth(thick)) /// 
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// "JOHN smooth"
if date >= td(01jan2022) ///
, xtitle(Date) xlabel(#11, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("C19 daily deaths, $country, IMPE, updates in 2022", size(medium) color(black)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(15 "JOHN" 1 "IMPE previous updates, backcast" 8 "IMPE previous updates, forecast" ///
14 "IMPE latest update 20220703, forecast") size(small) row(2)) ///
subtitle("Forecasts and backcasts; smooth; with extremes", size(small)) yscale(titlegap(2))

qui graph export "graph 1 $country C19 daily deaths, IMPE, Updates together, forecasts and backcasts, with extremes.pdf", replace







***********************************************

* graph 2 Daily deaths, Updates together, with extremes, forecasts only

twoway /// 
(line DayDeaFOREA0320220102 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220120 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220131 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220315 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220530 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220620 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220703 date, sort lcolor(black) lwidth(thick)) /// 
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// "JOHN smooth"
if date >= td(01jan2022) ///
, xtitle(Date) xlabel(#11, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("C19 daily deaths, $country, IMPE, updates in 2022", size(medium) color(black)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(8 "JOHN" 1 "IMPE previous updates, forecast" ///
7 "IMPE latest update 20220703, forecast") size(small) row(2)) ///
subtitle("Forecasts only; smooth; with extremes", size(small)) yscale(titlegap(2))

qui graph export "graph 2 $country C19 daily deaths, IMPE, Updates together, forecasts and backcasts, with extremes.pdf", replace








***********************************************

* graph 3 Daily deaths, Updates together, without extremes, backcasts and forecasts

* extremes: 20220131

twoway /// 
(line DayDeaMeSmA0320220102 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0320220120 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0320220315 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0320220530 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0320220620 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0320220703 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaFOREA0320220102 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220120 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220315 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220530 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220620 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220703 date, sort lcolor(black) lwidth(thick)) /// 
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// "JOHN smooth"
if date >= td(01jan2022) ///
, xtitle(Date) xlabel(#11, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("C19 daily deaths, $country, IMPE, updates in 2022", size(medium) color(black)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(13 "JOHN" 1 "IMPE previous updates, backcast" 6 "IMPE previous updates, forecast" ///
12 "IMPE latest update 20220703, forecast") size(small) row(2)) ///
subtitle("Forecasts and backcasts; smooth; without extremes", size(small)) yscale(titlegap(2))

qui graph export "graph 3 $country C19 daily deaths, IMPE, Updates together, forecasts only, without extremes.pdf", replace







***********************************************

* graph 4 Daily deaths, Updates together, without extremes, forecasts only

twoway /// 
(line DayDeaFOREA0320220102 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220120 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220315 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220530 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220620 date, sort lcolor(magenta) lwidth(medium)) /// 
(line DayDeaFOREA0320220620 date, sort lcolor(black) lwidth(thick)) /// 
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// "JOHN smooth"
if date >= td(01jan2022) ///
, xtitle(Date) xlabel(#11, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("C19 daily deaths, $country, IMPE, updates in 2022", size(medium) color(black)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "JOHN" 1 "IMPE previous updates, forecast" ///
6 "IMPE latest update 20220703, forecast") size(small) row(2)) ///
subtitle("Forecasts only; smooth; without extremes", size(small)) yscale(titlegap(2))

qui graph export "graph 4 $country C19 daily deaths, IMPE, Updates together, forecasts only, without extremes.pdf", replace







view "log country IMPE 3.smcl"

log close

exit, clear
