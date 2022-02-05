
clear all

cd "$pathcovir2"

cd merge

capture log close

log using "log country merge.smcl", replace


***************************************************************************
* This is "do country merge.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Merge component studies' estimates for country, graphs
***************************************************************************


/* 

List of component studies:

JOHN A00

DELP A01
IHME A02
IMPE A03
LANL A04 // The LANL COVID-19 Team made its last real-time forecast on September 27th, 2021. [for 20210926]. This is more than two weeks old and will not be used. 
SRIV A05 // Some labs were much bettre with physics. 

*/


clear 

* JOHN

if regexm(c(os),"Mac") == 1 {

	use "$pathcovir2/JOHN/country JOHN.dta", clear 
}
else if regexm(c(os),"Windows") == 1 use "$pathcovir2\JOHN\country JOHN.dta", clear 


label var loc_grand_name "Location"



*

sort date

qui compress

save "country.dta", replace

export delimited using "country.csv", replace 


*





***************

* graphs 


grstyle init

grstyle color background white







**********

* gen monthspast vars for #thicknumber of graphs


summ date

gen mergemaxdate = r(max)


gen monthspast01jan2020merge = ((mergemaxdate - td(01jan2020)) / 30) + 1

replace monthspast01jan2020merge = round(monthspast01jan2020merge)

global monthspast01jan2020merge = monthspast01jan2020merge

di $monthspast01jan2020merge



gen monthspast01jan2021merge = ((mergemaxdate - td(01jan2021)) / 30) + 1

replace monthspast01jan2021merge = round(monthspast01jan2021merge)

global monthspast01jan2021merge = monthspast01jan2021merge

di $monthspast01jan2021merge



gen monthspast01jan2022merge = ((mergemaxdate - td(01jan2022)) / 30) + 2

replace monthspast01jan2022merge = round(monthspast01jan2022merge)

global monthspast01jan2022merge = monthspast01jan2022merge

di $monthspast01jan2022merge





******************



* daily deaths (graph numbers start with 11)


****
* daily deaths, JOHN, all time

twoway ///
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 
(line DayDeaMeSmA00S00_CF3 date, sort lcolor(cyan) lwidth(medthick) lpattern(dash)) /// 
(line DayDeaMeSmA00S00_CF4 date, sort lcolor(cyan) lwidth(medthick)) /// 
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, $country, all time", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Daily reported deaths" 2 "Daily reported deaths correction factor 3" ///
3 "Daily reported deaths correction factor 4") size(small) rows (2)) 

qui graph save "graph 11 COVID-19 daily deaths, $country, JOHN, all time.gph", replace
qui graph export "graph 11 COVID-19 daily deaths, $country, JOHN, all time.pdf", replace



****
* daily deaths, JOHN, 2021 on

twoway ///
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 
(line DayDeaMeSmA00S00_CF3 date, sort lcolor(cyan) lwidth(medthick) lpattern(dash)) /// 
(line DayDeaMeSmA00S00_CF4 date, sort lcolor(cyan) lwidth(medthick)) ///  
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, $country, 2021 on", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Daily reported deaths" 2 "Daily reported deaths correction factor 3" ///
3 "Daily reported deaths correction factor 4") size(small) rows (2)) 

qui graph save "graph 12 COVID-19 daily deaths, $country, JOHN, 2021.gph", replace
qui graph export "graph 12 COVID-19 daily deaths, $country, JOHN, 2021.pdf", replace




****
* daily deaths, JOHN, recent

twoway ///
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 
(line DayDeaMeSmA00S00_CF3 date, sort lcolor(cyan) lwidth(medthick) lpattern(dash)) /// 
(line DayDeaMeSmA00S00_CF4 date, sort lcolor(cyan) lwidth(medthick)) /// 
if date >= td(01dec2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2022merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, $country, recent", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Daily reported deaths" 2 "Daily reported deaths correction factor 3" ///
3 "Daily reported deaths correction factor 4") size(small) rows (2)) 

qui graph save "graph 12 COVID-19 daily deaths, $country, JOHN, 2022.gph", replace
qui graph export "graph 12 COVID-19 daily deaths, $country, JOHN, 2022.pdf", replace








* daily cases (graph numbers start with 21)


****
* daily cases, JOHN, all time

twoway ///
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 1 "JOHN smooth"
(line DayCasMeSmA00S00_CF5 date, sort lcolor(cyan) lwidth(thick) lpattern(dash)) /// 
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported cases) title("COVID-19 daily reported cases, $country, all time", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Daily reported cases" 2 "Daily reported cases correction factor 5") size(small) rows (1)) 

qui graph save "graph 21 COVID-19 daily cases, $country, JOHN, all time.gph", replace
qui graph export "graph 21 COVID-19 daily cases, $country, JOHN, all time.pdf", replace



****
* daily cases, JOHN, 2021 on

twoway ///
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 1 "JOHN smooth"
(line DayCasMeSmA00S00_CF5 date, sort lcolor(cyan) lwidth(thick) lpattern(dash)) /// 
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported cases) title("COVID-19 daily reported cases, $country, 2021 on", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Daily reported cases" 2 "Daily reported cases correction factor 5") size(small) rows (1)) 

qui graph save "graph 22 COVID-19 daily cases, $country, JOHN, 2021.gph", replace
qui graph export "graph 22 COVID-19 daily cases, $country, JOHN, 2021.pdf", replace




****
* daily cases, JOHN, recent

twoway ///
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 1 "JOHN smooth"
(line DayCasMeSmA00S00_CF5 date, sort lcolor(cyan) lwidth(thick) lpattern(dash)) /// 
if date >= td(01dec2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2022merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported cases) title("COVID-19 daily reported cases, $country, recent", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Daily reported cases" 2 "Daily reported cases correction factor 5") size(small) rows (1)) 

qui graph save "graph 22 COVID-19 daily cases, $country, JOHN, 2022.gph", replace
qui graph export "graph 22 COVID-19 daily cases, $country, JOHN, 2022.pdf", replace








****
* daily cases, JOHN, comparison of 5th and 6th waves

twoway ///
(line DayCasMeSmA00S00wave5 wave5day, sort lcolor(cyan*1.2) lwidth(thick)) /// 1 "5th wave"
(line DayCasMeSmA00S00wave6 wave5day, sort lcolor(red) lwidth(thick)) /// 2 "6th wave"
if date >= td(06jun2021) ///
, xtitle(Days from wave start) xlabel(0(10)210, labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported cases) yscale(titlegap(2)) ///
title("COVID-19 daily reported cases, $country, comparison of 5th and 6th waves", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "5th wave" 2 "6th wave") size(small) rows (1)) 

qui graph save "graph 31 COVID-19 daily cases, $country, JOHN, 5th and 6th waves.gph", replace
qui graph export "graph 31 COVID-19 daily cases, $country, JOHN, 5th and 6th waves.pdf", replace



****
* daily cases, JOHN, comparison of 5th and 6th waves, with correction factor

twoway ///
(line DayCasMeSmA00S00wave5 wave5day, sort lcolor(cyan*1.2) lwidth(thick)) /// 1 "5th wave"
(line DayCasMeSmA00S00wave6 wave5day, sort lcolor(red) lwidth(thick)) /// 2 "6th wave"
(line DayCasMeSmA00S00wave6_CF5 wave5day, sort lcolor(red) lwidth(thick) lpattern(dash)) /// 3 "6th wave w CF"
if date >= td(06jun2021) ///
, xtitle(Days from wave start) xlabel(0(10)210, labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported cases) yscale(titlegap(2)) ///
title("COVID-19 daily reported cases, $country, comparison of 5th and 6th waves", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "5th wave" 2 "6th wave" 3 "6th wave correction factor 5") size(small) rows (1)) 

qui graph save "graph 31b COVID-19 daily cases, $country, JOHN, 5th and 6th waves.gph", replace
qui graph export "graph 31b COVID-19 daily cases, $country, JOHN, 5th and 6th waves.pdf", replace



****
* daily deaths, JOHN, comparison of 5th and 6th waves

twoway ///
(line DayDeaMeSmA00S00wave5 wave5day, sort lcolor(cyan*1.2) lwidth(thick)) /// 1 "5th wave"
(line DayDeaMeSmA00S00wave6 wave5day, sort lcolor(red) lwidth(thick)) /// 2 "6th wave"
if date >= td(06jun2021) ///
, xtitle(Days from wave start) xlabel(0(10)210, labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) yscale(titlegap(2)) ///
title("COVID-19 daily reported deaths, $country, comparison of 5th and 6th waves", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "5th wave" 2 "6th wave") size(small) rows (1)) 

qui graph save "graph 32 COVID-19 daily deaths, $country, JOHN, 5th and 6th waves.gph", replace
qui graph export "graph 32 COVID-19 daily deaths, $country, JOHN, 5th and 6th waves.pdf", replace





****
* daily deaths, JOHN, comparison of 5th and 6th waves, with correction factor

twoway ///
(line DayDeaMeSmA00S00wave5 wave5day, sort lcolor(cyan*1.2) lwidth(thick)) /// 1 "5th wave"
(line DayDeaMeSmA00S00wave5_CF3 wave5day, sort lcolor(cyan) lwidth(thick) lpattern(dash)) /// 2 "5th wave w CF"
(line DayDeaMeSmA00S00wave6 wave5day, sort lcolor(red) lwidth(thick)) /// 3 "6th wave"
(line DayDeaMeSmA00S00wave6_CF3 wave5day, sort lcolor(red) lwidth(medthick) lpattern(dash)) /// 4 "6th wave CF 3"
(line DayDeaMeSmA00S00wave6_CF4 wave5day, sort lcolor(red) lwidth(medthick)) /// 5 "6th wave CF 4"
if date >= td(06jun2021) ///
, xtitle(Days from wave start) xlabel(0(10)210, labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) yscale(titlegap(2)) ///
title("COVID-19 daily reported deaths, $country, comparison of 5th and 6th waves", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "5th wave reported" 2 "5th wave correction factor 3" ///
3 "6th wave reported" 4 "6th wave correction factor 3" 5 "6th wave correction factor 4") size(small) rows (3)) 

qui graph save "graph 32b COVID-19 daily deaths, $country, JOHN, 5th and 6th waves.gph", replace
qui graph export "graph 32b COVID-19 daily deaths, $country, JOHN, 5th and 6th waves.pdf", replace






****
* total deaths, JOHN

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(red) lwidth(thick)) ///
(line TotDeaMeRaA00S00_CF3 date, sort lcolor(red) lwidth(thick) lpattern(dash)) /// 
(line TotDeaMeRaA00S00_CF4 date, sort lcolor(red) lwidth(thick) lpattern(dash_dot)) ///  
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) yscale(titlegap(2)) ///
title("COVID-19 total deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Reported deaths" 2 "Reported deaths correction factor 3" ///
3 "Reported deaths correction factor 4") size(small) rows (2)) 

qui graph save "graph 33 COVID-19 total deaths, $country, JOHN.gph", replace
qui graph export "graph 33 COVID-19 total deaths, $country, JOHN.pdf", replace






************

* restore native scheme (of the local machine)

set scheme $nativescheme

di c(scheme)


view "log country merge.smcl"

log close

exit, clear



