
clear all

cd "$pathcovir2"

cd merge

capture log close

log using "log Iran merge.smcl", replace


***************************************************************************
* This is "do Iran merge.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time: 2021-02-10

* OBJECTIVE: Merge component studies' estimates for Iran, grphas
***************************************************************************


/* studies:
JOHN
DELP
IHME
IMPE
LANL
SRIV
SOLT
GHAN
*/




* JOHN

if regexm(c(os),"Mac") == 1 {

	use "$pathcovir2/JOHN/Iran JOHN.dta", clear 
}
else if regexm(c(os),"Windows") == 1 use "$pathcovir2\JOHN\Iran JOHN.dta", clear 



* DELP 

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/DELP/Iran DELP.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\DELP\Iran DELP.dta"

drop _merge



* IHME

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/IHME/Iran IHME.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\IHME\Iran IHME.dta"

drop _merge



* IMPE

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/IMPE/Iran IMPE.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\IMPE\Iran IMPE.dta"

drop _merge



* LANL

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/LANL/Iran LANL.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\LANL\Iran LANL.dta"

drop _merge



* SRIV



if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/SRIV/Iran SRIV.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\SRIV\Iran SRIV.dta"

drop _merge



* SOLT



if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/SOLT/Iran SOLT"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\SOLT\Iran SOLT"

drop _merge 



* GHAN

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date using "$pathcovir2/GHAN/Iran GHAN"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathcovir2\GHAN\Iran GHAN"

drop _merge 







* 

label var loc_grand_name "Location"


compress

save "Iran.dta", replace

export delimited using "Iran.csv", replace 


*





***************

* graphs 


grstyle init

grstyle color background white


* daily deaths, daily cases, total deaths, total cases


*****************

* daily deaths (graph numbers start with 11)


* daily deaths, median or reference scenario


twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line DayDeaMeSmA02S01V03 date, sort lcolor(black)) /// 3 "IHME"
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
if date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1))


graph save "graph 11a COVID-19 daily deaths, Iran, reference scenarios.gph", replace
graph export "graph 11a COVID-19 daily deaths, Iran, reference scenarios.pdf", replace





* daily deaths, median or reference scenario, w CF


twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(thick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line DayDeaMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line DayDeaMeRaA01S00V03 date, sort lcolor(red)) /// 4 "DELP"
(line DayDeaMeSmA02S01V03 date, sort lcolor(black)) /// 5 "IHME"
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 6 "IMPE"
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 7 "LANL"
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 8 "SRIV"
if date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 5 "IHME" 6 "IMPE" 7 "LANL" 8 "SRIV") size(small) row(1)) ///
subtitle("with correction factors 2 and 5", size(small))


graph save "graph 11b COVID-19 daily deaths, Iran, reference scenarios, w CF.gph", replace
graph export "graph 11b COVID-19 daily deaths, Iran, reference scenarios, w CF.pdf", replace





* daily deaths, median or reference scenario, 01dec2020 on


twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line DayDeaMeSmA02S01V03 date, sort lcolor(black)) /// 3 "IHME"
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
if date > td(30nov2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#8, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1))


graph save "graph 12a COVID-19 daily deaths, Iran, reference scenarios, 01dec2020 on.gph", replace
graph export "graph 12a COVID-19 daily deaths, Iran, reference scenarios, 01dec2020 on.pdf", replace






* daily deaths, median or reference scenario, 01dec2020 on, w CF


twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line DayDeaMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line DayDeaMeRaA01S00V03 date, sort lcolor(red)) /// 4 "DELP"
(line DayDeaMeSmA02S01V03 date, sort lcolor(black)) /// 5 "IHME"
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 6 "IMPE"
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 7 "LANL"
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 8 "SRIV"
if date > td(30nov2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#8, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 5 "IHME" 6 "IMPE" 7 "LANL" 8 "SRIV") size(small) row(1)) ///
subtitle("with correction factors 2 and 5", size(small))


graph save "graph 12b COVID-19 daily deaths, Iran, reference scenarios, 01dec2020 on, w CF.gph", replace
graph export "graph 12b COVID-19 daily deaths, Iran, reference scenarios, 01dec2020 on, w CF.pdf", replace






* daily deaths, median or reference scenario, 01dec2020 on, CI


twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayDeaMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayDeaLoRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayDeaUpRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" upper
(line DayDeaMeSmA02S02V03 date, sort lcolor(black)) /// 5 IHME mean
(line DayDeaLoSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line DayDeaUpSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 8 IMPE mean
(line DayDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line DayDeaUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 11 LANL mean
(line DayDeaLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL lower
(line DayDeaUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL upper
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 14 "SRIV" mean
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" lower
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" upper
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "LANL" 14 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves") 


graph save "graph 13a COVID-19 daily deaths, Iran, reference scenarios, 01dec2020 on, CI.gph", replace
graph export "graph 13a COVID-19 daily deaths, Iran, reference scenarios, 01dec2020 on, CI.pdf", replace


summ DayDeaUpRaA03S02V07 // 3272.17 = 3272
list date if DayDeaUpRaA03S02V07 > 3272.16 & DayDeaUpRaA03S02V07 != . // 21apr2021






* daily deaths, median or reference scenario, 01dec2020 on, CI, w CF


twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayDeaMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line DayDeaMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line DayDeaMeRaA01S00V03 date, sort lcolor(red)) /// 4 "DELP" mean
(line DayDeaLoRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 5 "DELP" lower
(line DayDeaUpRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 6 "DELP" upper
(line DayDeaMeSmA02S02V03 date, sort lcolor(black)) /// 7 IHME mean
(line DayDeaLoSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 8 IHME lower
(line DayDeaUpSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 9 IHME upper
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 10 IMPE mean
(line DayDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 11 IMPE lower
(line DayDeaUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 12 IMPE upper
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 13 LANL mean
(line DayDeaLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 14 LANL lower
(line DayDeaUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 15 LANL upper
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 16 "SRIV" mean
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 17 "SRIV" lower
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 18 "SRIV" upper
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 7 "IHME" 10 "IMPE" 13 "LANL" 16 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves") ///
subtitle("with correction factors 2 and 5", size(small))


graph save "graph 13b COVID-19 daily deaths, Iran, reference scenarios, 01dec2020 on, CI, w CF.gph", replace
graph export "graph 13b COVID-19 daily deaths, Iran, reference scenarios, 01dec2020 on, CI, w CF.pdf", replace







* daily deaths, median or reference scenario, 01dec2020 on, CI, wo DELP upper and IMPE upper  



twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayDeaMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayDeaLoRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayDeaMeSmA02S02V03 date, sort lcolor(black)) /// 4 IHME mean
(line DayDeaLoSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 5 IHME lower
(line DayDeaUpSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 6 IHME upper
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 7 IMPE mean
(line DayDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 8 IMPE lower
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 9 LANL mean
(line DayDeaLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 10 LANL lower
(line DayDeaUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 11 LANL upper
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 12 "SRIV" mean
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 13 "SRIV" lower
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 14 "SRIV" upper
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 4 "IHME" 7 "IMPE" 9 "LANL" 12 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves. DELP upper and IMPE upper not shown.")

// DELP upper and IMPE upper not shown (higher than others).

graph save "graph 14a COVID-19 daily deaths, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper.gph", replace
graph export "graph 14a COVID-19 daily deaths, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper.pdf", replace







* daily deaths, median or reference scenario, 01dec2020 on, CI, wo DELP upper and IMPE upper  



twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayDeaMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line DayDeaMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line DayDeaMeRaA01S00V03 date, sort lcolor(red)) /// 4 "DELP" mean
(line DayDeaLoRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 5 "DELP" lower
(line DayDeaMeSmA02S02V03 date, sort lcolor(black)) /// 6 IHME mean
(line DayDeaLoSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 7 IHME lower
(line DayDeaUpSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 8 IHME upper
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 9 IMPE mean
(line DayDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE lower
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 11 LANL mean
(line DayDeaLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL lower
(line DayDeaUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL upper
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 14 "SRIV" mean
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" lower
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" upper
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 6 "IHME" 9 "IMPE" 11 "LANL" 14 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves. DELP upper and IMPE upper not shown.") ///
subtitle("with correction factors 2 and 5", size(small))


// DELP upper and IMPE upper not shown (higher than others).

graph save "graph 14b COVID-19 daily deaths, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper, w CF.gph", replace
graph export "graph 14b COVID-19 daily deaths, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper, w CF.pdf", replace




***********************

* Daily cases (graph numbers start with 21)




* daily cases, median or reference scenario


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA01S00V03 date, sort lcolor(red)) /// 4 "DELP"
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) /// 5 "IHME"
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 6 "IMPE"
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 7 "LANL"
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 8 "SRIV"
if date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV" ) size(small) row(1)) 


graph save "graph 21a COVID-19 daily cases, Iran, reference scenarios.gph", replace
graph export "graph 21a COVID-19 daily cases, Iran, reference scenarios.pdf", replace




* daily cases, median or reference scenario, w CF


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line DayCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line DayCasMeRaA01S00V03 date, sort lcolor(red)) /// 4 "DELP"
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) /// 5 "IHME"
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 6 "IMPE"
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 7 "LANL"
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 8 "SRIV"
if date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 5 "IHME" 6 "IMPE" 7 "LANL" 8 "SRIV" ) size(small) row(1)) ///
subtitle("with correction factors 2 and 5", size(small))


graph save "graph 21b COVID-19 daily cases, Iran, reference scenarios, w CF.gph", replace
graph export "graph 21b COVID-19 daily cases, Iran, reference scenarios, w CF.pdf", replace






* daily cases, median or reference scenario, 01dec2020 on


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) /// 3 "IHME"
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#8, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV" ) size(small) row(2)) 


graph save "graph 22a COVID-19 daily cases, Iran, reference scenarios, 01dec2020 on.gph", replace
graph export "graph 22a COVID-19 daily cases, Iran, reference scenarios, 01dec2020 on.pdf", replace







* daily cases, median or reference scenario, 01dec2020 on, w CF


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line DayCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line DayCasMeRaA01S00V03 date, sort lcolor(red)) /// 4 "DELP"
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) /// 5 "IHME"
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 6 "IMPE"
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 7 "LANL"
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 8 "SRIV"
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#8, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 5 "IHME" 6 "IMPE" 7 "LANL" 8 "SRIV" ) size(small) row(2)) ///
subtitle("with correction factors 2 and 5", size(small))


graph save "graph 22b COVID-19 daily cases, Iran, reference scenarios, 01dec2020 on, w CF.gph", replace
graph export "graph 22b COVID-19 daily cases, Iran, reference scenarios, 01dec2020 on, w CF.pdf", replace








* daily cases, median or reference scenario, 01dec2020 on, CI


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayCasMeRaA01S00V03  date, sort lcolor(red)) /// 2 DELP mean
(line DayCasLoRaA01S00V03  date, sort lcolor(red) lpattern(dash)) /// 3 DELP lower
(line DayCasUpRaA01S00V03  date, sort lcolor(red) lpattern(dash)) /// 4 DELP upper
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) /// 5 IHME mean
(line DayCasLoRaA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line DayCasUpRaA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 8 IMPE mean
(line DayCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line DayCasUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 11 LANL mean
(line DayCasLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL lower
(line DayCasUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL upper
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 14 "SRIV" mean
(line DayCasLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" lower
(line DayCasUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" upper
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "LANL" 14 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves")


graph save "graph 23a COVID-19 daily cases, Iran, reference scenarios, 01dec2020 on, CI.gph", replace
graph export "graph 23a COVID-19 daily cases, Iran, reference scenarios, 01dec2020 on, CI.pdf", replace


summ DayCasUpRaA03S02V07 // 681418
list date if DayCasUpRaA03S02V07 > 681417.9 & DayCasUpRaA03S02V07 != . // 14apr2021







* daily cases, median or reference scenario, 01dec2020 on, CI, w CF


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line DayCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line DayCasMeRaA01S00V03  date, sort lcolor(red)) /// 4 DELP mean
(line DayCasLoRaA01S00V03  date, sort lcolor(red) lpattern(dash)) /// 5 DELP lower
(line DayCasUpRaA01S00V03  date, sort lcolor(red) lpattern(dash)) /// 6 DELP upper
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) /// 7 IHME mean
(line DayCasLoRaA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 8 IHME lower
(line DayCasUpRaA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 9 IHME upper
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 10 IMPE mean
(line DayCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 11 IMPE lower
(line DayCasUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 12 IMPE upper
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 13 LANL mean
(line DayCasLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 14 LANL lower
(line DayCasUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 15 LANL upper
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 16 "SRIV" mean
(line DayCasLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 17 "SRIV" lower
(line DayCasUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 18 "SRIV" upper
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 7 "IHME" 10 "IMPE" 13 "LANL" 17 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves") ///
subtitle("with correction factors 2 and 5", size(small))


graph save "graph 23b COVID-19 daily cases, Iran, reference scenarios, 01dec2020 on, CI., w CFgph", replace
graph export "graph 23b COVID-19 daily cases, Iran, reference scenarios, 01dec2020 on, CI, w CF.pdf", replace







* daily cases, median or reference scenario, 01dec2020 on, CI, wo IMPE upper


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayCasMeRaA01S00V03  date, sort lcolor(red)) /// 2 DELP mean
(line DayCasLoRaA01S00V03  date, sort lcolor(red) lpattern(dash)) /// 3 DELP lower
(line DayCasUpRaA01S00V03  date, sort lcolor(red) lpattern(dash)) /// 4 DELP upper
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) /// 5 IHME mean
(line DayCasLoRaA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line DayCasUpRaA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 8 IMPE mean
(line DayCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 10 LANL mean
(line DayCasLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 11 LANL lower
(line DayCasUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL upper
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 13 "SRIV" mean
(line DayCasLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 14 "SRIV" lower
(line DayCasUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" upper
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 10 "LANL" 13 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves. IMPE upper not shown.")

* IMPE upper not shown (higher than others)."

graph save "graph 24a COVID-19 daily cases, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper.gph", replace
graph export "graph 24a COVID-19 daily cases, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper.pdf", replace







* daily cases, median or reference scenario, 01dec2020 on, CI, wo IMPE upper, w CF


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line DayCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line DayCasMeRaA01S00V03  date, sort lcolor(red)) /// 4 DELP mean
(line DayCasLoRaA01S00V03  date, sort lcolor(red) lpattern(dash)) /// 5 DELP lower
(line DayCasUpRaA01S00V03  date, sort lcolor(red) lpattern(dash)) /// 6 DELP upper
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) /// 7 IHME mean
(line DayCasLoRaA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 8 IHME lower
(line DayCasUpRaA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 9 IHME upper
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 10 IMPE mean
(line DayCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 11 IMPE lower
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 12 LANL mean
(line DayCasLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL lower
(line DayCasUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 14 LANL upper
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 15 "SRIV" mean
(line DayCasLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" lower
(line DayCasUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 17 "SRIV" upper
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 7 "IHME" 10 "IMPE" 12 "LANL" 15 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves. IMPE upper not shown.") ///
subtitle("with correction factors 2 and 5", size(small))

* IMPE upper not shown (higher than others)."

graph save "graph 24b COVID-19 daily cases, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper., w CFgph", replace
graph export "graph 24b COVID-19 daily cases, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper, w CF.pdf", replace






*****************

* total deaths (graph numbers start with 31)



* total deaths, median or reference scenario


twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotDeaMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01V03 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 5 "LANL"
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
if date > td(31dec2019) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1))


graph save "graph 31a COVID-19 total deaths, Iran, reference scenarios.gph", replace
graph export "graph 31a COVID-19 total deaths, Iran, reference scenarios.pdf", replace





* total deaths, median or reference scenariom, w CF


twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotDeaMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line TotDeaMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line TotDeaMeRaA01S00V03 date, sort lcolor(red)) /// 4 "DELP"
(line TotDeaMeSmA02S01V03 date, sort lcolor(black)) /// 5 "IHME"
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 6 "IMPE"
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 7 "LANL"
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 8 "SRIV"
if date > td(31dec2019) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 5 "IHME" 6 "IMPE" 7 "LANL" 8 "SRIV") size(small) row(1)) ///
subtitle("with correction factors 2 and 5", size(small))


graph save "graph 31b COVID-19 total deaths, Iran, reference scenarios, w CF.gph", replace
graph export "graph 31b COVID-19 total deaths, Iran, reference scenarios, w CF.pdf", replace







* total deaths, median or reference scenario, 01dec2020 on


twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotDeaMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01V03 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 5 "LANL"
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1))


graph save "graph 32a COVID-19 total deaths, Iran, reference scenarios, 01dec2020 on.gph", replace
graph export "graph 32a COVID-19 total deaths, Iran, reference scenarios, 01dec2020 on.pdf", replace






* total deaths, median or reference scenario, 01dec2020 on, w CF


twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line TotCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line TotDeaMeRaA01S00V03 date, sort lcolor(red)) /// 4 "DELP"
(line TotDeaMeSmA02S01V03 date, sort lcolor(black)) /// 5 "IHME"
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 6 "IMPE"
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 7 "LANL"
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 8 "SRIV"
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 5 "IHME" 6 "IMPE" 7 "LANL" 8 "SRIV") size(small) row(1)) ///
subtitle("with correction factors 2 and 5", size(small))


graph save "graph 32b COVID-19 total deaths, Iran, reference scenarios, 01dec2020 on, w CF.gph", replace
graph export "graph 32b COVID-19 total deaths, Iran, reference scenarios, 01dec2020 on, w CF.pdf", replace








* total deaths, median or reference scenario, 01dec2020 on, CI


twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotDeaMeRaA01S00V03 date, sort lcolor(red)) /// 2 DELP mean
(line TotDeaLoRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 3 DELP lower
(line TotDeaUpRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 4 DELP upper
(line TotDeaMeSmA02S02V03 date, sort lcolor(black)) /// 5 IHME mean
(line TotDeaLoSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotDeaUpSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 8 IMPE mean
(line TotDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line TotDeaUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 11 LANL mean
(line TotDeaLoRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL lower
(line TotDeaUpRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL upper
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 14 "SRIV" mean
(line TotDeaLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" lower
(line TotDeaUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" upper
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "LANL" 14 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves")


graph save "graph 34a COVID-19 total deaths, Iran, reference scenarios, 01dec2020 on, CI.gph", replace
graph export "graph 34a COVID-19 total deaths, Iran, reference scenarios, 01dec2020 on, CI.pdf", replace


summ date if TotDeaUpRaA03S02V07 > 100000
di %td 22376 // 06apr2021
summ date if TotDeaUpRaA03S02V07 > 200000
di %td 22410 // 10may2021







* total deaths, median or reference scenario, 01dec2020 on, CI, w CF


twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotDeaMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line TotDeaMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line TotDeaMeRaA01S00V03 date, sort lcolor(red)) /// 4 DELP mean
(line TotDeaLoRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 5 DELP lower
(line TotDeaUpRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 6 DELP upper
(line TotDeaMeSmA02S02V03 date, sort lcolor(black)) /// 7 IHME mean
(line TotDeaLoSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 8 IHME lower
(line TotDeaUpSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 9 IHME upper
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 10 IMPE mean
(line TotDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 11 IMPE lower
(line TotDeaUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 12 IMPE upper
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 13 LANL mean
(line TotDeaLoRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 14 LANL lower
(line TotDeaUpRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 15 LANL upper
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 16 "SRIV" mean
(line TotDeaLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 17 "SRIV" lower
(line TotDeaUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 18 "SRIV" upper
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 7 "IHME" 10 "IMPE" 13 "LANL" 16 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves") ///
subtitle("with correction factors 2 and 5", size(small))


graph save "graph 34b COVID-19 total deaths, Iran, reference scenarios, 01dec2020 on, CI, w CF.gph", replace
graph export "graph 34b COVID-19 total deaths, Iran, reference scenarios, 01dec2020 on, CI, w CF.pdf", replace









* total deaths, median or reference scenario, 01dec2020 on, CI, wo IMPE upper


twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotDeaMeRaA01S00V03 date, sort lcolor(red)) /// 2 DELP mean
(line TotDeaLoRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 3 DELP lower
(line TotDeaUpRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 4 DELP upper
(line TotDeaMeSmA02S02V03 date, sort lcolor(black)) /// 5 IHME mean
(line TotDeaLoSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotDeaUpSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 8 IMPE mean
(line TotDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 10 LANL mean
(line TotDeaLoRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 11 LANL lower
(line TotDeaUpRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL upper
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 13 "SRIV" mean
(line TotDeaLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 14 "SRIV" lower
(line TotDeaUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" upper
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 10 "LANL" 13 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves. IMPE upper not shown.")

* IMPE upper not shown (higher than others).

graph save "graph 35a COVID-19 total deaths, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper.gph", replace
graph export "graph 35a COVID-19 total deaths, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper.pdf", replace










* total deaths, median or reference scenario, 01dec2020 on, CI, wo IMPE upper, w CF


twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotDeaMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line TotDeaMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line TotDeaMeRaA01S00V03 date, sort lcolor(red)) /// 4 DELP mean
(line TotDeaLoRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 5 DELP lower
(line TotDeaUpRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 6 DELP upper
(line TotDeaMeSmA02S02V03 date, sort lcolor(black)) /// 7 IHME mean
(line TotDeaLoSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 8 IHME lower
(line TotDeaUpSmA02S02V03 date, sort lcolor(black) lpattern(dash)) /// 9 IHME upper
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 10 IMPE mean
(line TotDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 11 IMPE lower
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 12 LANL mean
(line TotDeaLoRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL lower
(line TotDeaUpRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 14 LANL upper
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 15 "SRIV" mean
(line TotDeaLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" lower
(line TotDeaUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 17 "SRIV" upper
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 7 "IHME" 10 "IMPE" 12 "LANL" 15 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves. IMPE upper not shown.") ///
subtitle("with correction factors 2 and 5", size(small))

* IMPE upper not shown (higher than others).

graph save "graph 35b COVID-19 total deaths, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper, w CF.gph", replace
graph export "graph 35b COVID-19 total deaths, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper, w CF.pdf", replace






*****************

* total cases (graph numbers start with 41)


* total cases, median or reference scenario


twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 3 "IHME"
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
if date > td(31dec2019) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1))


graph save "graph 41a COVID-19 total cases, Iran, reference scenarios.gph", replace
graph export "graph 41a COVID-19 total cases, Iran, reference scenarios.pdf", replace





* total cases, median or reference scenario, w CF


twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line TotCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line TotCasMeRaA01S00V03 date, sort lcolor(red)) /// 4 "DELP"
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 5 "IHME"
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 6 "IMPE"
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 7 "LANL"
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 8 "SRIV"
if date > td(31dec2019) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 5 "IHME" 6 "IMPE" 7 "LANL" 8 "SRIV") size(small) row(1)) ///
subtitle("with correction factors 2 and 5", size(small))


graph save "graph 41b COVID-19 total cases, Iran, reference scenarios, w CF.gph", replace
graph export "graph 41b COVID-19 total cases, Iran, reference scenarios, w CF.pdf", replace







* total cases, median or reference scenario, 01dec2020 on


twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 3 "IHME"
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1))


graph save "graph 42a COVID-19 total cases, Iran, reference scenarios, 01dec2020 on.gph", replace
graph export "graph 42a COVID-19 total cases, Iran, reference scenarios, 01dec2020 on.pdf", replace




* total cases, median or reference scenario, 01dec2020 on, w CF


twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line TotCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line TotCasMeRaA01S00V03 date, sort lcolor(red)) /// 4 "DELP"
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 5 "IHME"
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 6 "IMPE"
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 7 "LANL"
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 8 "SRIV"
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 5 "IHME" 6 "IMPE" 7 "LANL" 8 "SRIV") size(small) row(1)) ///
subtitle("with correction factors 2 and 5", size(small))


graph save "graph 42b COVID-19 total cases, Iran, reference scenarios, 01dec2020 on, w CF.gph", replace
graph export "graph 42b COVID-19 total cases, Iran, reference scenarios, 01dec2020 on, w CF.pdf", replace








* total cases, median or reference scenario, 01dec2020 on, CI



twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotCasMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasLoRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP"
(line TotCasUpRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP"
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 5 IHME mean
(line TotCasLoRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotCasUpRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 8 IMPE mean
(line TotCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line TotCasUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 11 LANL mean
(line TotCasLoRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL lower
(line TotCasUpRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL upper
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 14 "SRIV" mean
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" lower
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" upper
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "LANL" 14 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves")


graph save "graph 43a COVID-19 total cases, Iran, reference scenarios, 01dec2020 on, CI.gph", replace
graph export "graph 43a COVID-19 total cases, Iran, reference scenarios, 01dec2020 on, CI.pdf", replace


summ date if TotCasUpRaA03S02V07 > 40000000
di %td 22387 // 17apr2021








* total cases, median or reference scenario, 01dec2020 on, CI, w CF



twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line TotCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line TotCasMeRaA01S00V03 date, sort lcolor(red)) /// 4 "DELP"
(line TotCasLoRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 5 "DELP"
(line TotCasUpRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 6 "DELP"
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 7 IHME mean
(line TotCasLoRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 8 IHME lower
(line TotCasUpRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 9 IHME upper
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 10 IMPE mean
(line TotCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 11 IMPE lower
(line TotCasUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 12 IMPE upper
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 13 LANL mean
(line TotCasLoRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 14 LANL lower
(line TotCasUpRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 15 LANL upper
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 16 "SRIV" mean
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 17 "SRIV" lower
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 18 "SRIV" upper
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 7 "IHME" 10 "IMPE" 13 "LANL" 17 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves")  ///
subtitle("with correction factors 2 and 5", size(small))


graph save "graph 43b COVID-19 total cases, Iran, reference scenarios, 01dec2020 on, CI, w CF.gph", replace
graph export "graph 43b COVID-19 total cases, Iran, reference scenarios, 01dec2020 on, CI, w CF.pdf", replace







* total cases, median or reference scenario, 01dec2020 on, CI, wo IMPE upper


twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotCasMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasLoRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP"
(line TotCasUpRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP"
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 5 IHME mean
(line TotCasLoRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotCasUpRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 8 IMPE mean
(line TotCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 10 LANL mean
(line TotCasLoRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 11 LANL lower
(line TotCasUpRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL upper
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 13 "SRIV" mean
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 14 "SRIV" lower
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" upper
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 10 "LANL" 13 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves. IMPE upper not shown.")

* IMPE upper not shown (higher than others).

graph save "graph 44a COVID-19 total cases, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper.gph", replace
graph export "graph 44a COVID-19 total cases, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper.pdf", replace







* total cases, median or reference scenario, 01dec2020 on, CI, wo IMPE upper, w CF


twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotCasMeRaA00S00V00_CF2 date, sort lcolor(cyan) lpattern(tight_dot)) /// 2 "JOHN" CF2
(line TotCasMeRaA00S00V00_CF5 date, sort lcolor(cyan) lpattern(tight_dot)) /// 3 "JOHN" CF5
(line TotCasMeRaA01S00V03 date, sort lcolor(red)) /// 4 "DELP"
(line TotCasLoRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 5 "DELP"
(line TotCasUpRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 6 "DELP"
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) /// 7 IHME mean
(line TotCasLoRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 8 IHME lower
(line TotCasUpRaA02S01V03 date, sort lcolor(black) lpattern(dash)) /// 9 IHME upper
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 10 IMPE mean
(line TotCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 11 IMPE lower
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 12 LANL mean
(line TotCasLoRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL lower
(line TotCasUpRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 14 LANL upper
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 15 "SRIV" mean
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" lower
(line TotCasMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 17 "SRIV" upper
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "CF 2" 3 "CF 5" 4 "DELP" 7 "IHME" 10 "IMPE" 12 "LANL" 15 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves. IMPE upper not shown.")  ///
subtitle("with correction factors 2 and 5", size(small))

* IMPE upper not shown (higher than others).

graph save "graph 44b COVID-19 total cases, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper, w CF.gph", replace
graph export "graph 44b COVID-19 total cases, Iran, reference scenarios, 01dec2020 on, CI, wo IMPE upper, w CF.pdf", replace






*****************

* daily cfr (graph numbers start with 51)


* cfr all studies, all time, reference scenarios


twoway ///
(line DayCfrMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCfrMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line DayCfrMeRaA02S01V03 date, sort lcolor(black)) /// 3 "IHME"
(line DayCfrMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCfrMeRaA04S00V0 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCfrMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
if date > td(31dec2019) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1))


graph save "graph 51 COVID-19 daily CFR, Iran, reference scenarios.gph", replace
graph export "graph 51 COVID-19 daily CFR, Iran, reference scenarios.pdf", replace





* cfr all studies, 01mar2020 on, reference scenarios



twoway ///
(line DayCfrMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCfrMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line DayCfrMeRaA02S01V03 date, sort lcolor(black)) /// 3 "IHME"
(line DayCfrMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCfrMeRaA04S00V0 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCfrMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
if date > td(01mar2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("after 2020-12-01", size(small))


graph save "graph 52 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on.gph", replace
graph export "graph 52 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on.pdf", replace








* cfr wo LANL SRIV, 01mar2020 on, reference scenarios


twoway ///
(line DayCfrMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCfrMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line DayCfrMeRaA02S01V03 date, sort lcolor(black)) /// 3 "IHME"
(line DayCfrMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
if date > td(01mar2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE") size(small) row(1)) ///
subtitle("after 2020-03-01, without LANL, SRIV", size(small))



graph save "graph 53 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on, wo LANL SRIV.gph", replace
graph export "graph 53 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on, wo LANL SRIV.pdf", replace







* cfr wo JOHN LANL SRIV, 01mar2020 on, reference scenarios


twoway ///
(line DayCfrMeRaA01S00V03 date, sort lcolor(red)) /// 1 "DELP"
(line DayCfrMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line DayCfrMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
if date > td(01mar2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 2 "IHME" 3 "IMPE") size(small) row(1)) ///
subtitle("after 2020-03-01, without JOHN, LANL, SRIV", size(small))


graph save "graph 54 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on, wo JOHN LANL SRIV.gph", replace
graph export "graph 54 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on,wo JOHN LANL SRIV.pdf", replace






* cfr wo JOHN LANL SRIV, 01mar2020 on, reference scenarios, with CIs



twoway ///
(line DayCfrMeRaA01S00V03 date, sort lcolor(red)) /// 1 "DELP" mean
(line DayCfrLoRaA01S00V03 date, sort lcolor(red*.3) lpattern(dash)) /// 2 "DELP" lower
(line DayCfrUpRaA01S00V03 date, sort lcolor(red*.3) lpattern(dash)) /// 3 "DELP" upper
(line DayCfrMeRaA02S01V03 date, sort lcolor(black)) /// 4 "IHME" mean
(line DayCfrLoRaA02S01V03 date, sort lcolor(black*.2) lpattern(dash)) /// 5 "IHME" lower
(line DayCfrUpRaA02S01V03 date, sort lcolor(black*.2) lpattern(dash)) /// 6 "IHME" upper
(line DayCfrMeRaA03S02V07 date, sort lcolor(magenta)) /// 7 "IMPE" mean
(line DayCfrLoRaA03S02V07 date, sort lcolor(magenta*.2) lpattern(dash)) /// 8 "IMPE" lower
(line DayCfrUpRaA03S02V07 date, sort lcolor(magenta*.2) lpattern(dash)) /// 9 "IMPE" upper
if date > td(01mar2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 4 "IHME" 7 "IMPE") size(small) row(1)) ///
note("Uncertainty limits: dashed light curves.") ///
subtitle("after 2020-03-01, without JOHN, LANL, SRIV, with confidence limits", size(small))


graph save "graph 55 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on, wo JOHN LANL SRIV, with CIs.gph", replace
graph export "graph 55 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on,wo JOHN LANL SRIV, with CIs.pdf", replace












*****************

* daily active cases (graph numbers start with 61)


* daily active cases, w GHAN

twoway ///
(line DayActMeRaA01S00V03 date, sort lcolor(red)) /// 1 "DELP" 
(line DayActMeRaA07S09V00 date, sort lcolor(black)) /// 2 "GHAN" 
(line DayActMeRaA06S01V00 date, sort lcolor(red) lpattern(dash)) /// 3 "SOLT S1"
(line DayActMeRaA06S02V00 date, sort lcolor(blue) lpattern(dash)) /// 4 "SOLT S2"
if date > td(01jan2020) & date < td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily active cases) title("COVID-19 daily active cases, Iran", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 2 "GHAN" 3 "SOLT S1" 4 "SOLT S2") size(small) row(1)) 


graph save "graph 61 COVID-19 daily active cases w GHAN.gph", replace
graph export "graph 61 COVID-19 daily active cases w GHAN.pdf", replace





* daily active cases, wo GHAN

twoway ///
(line DayActMeRaA01S00V03 date, sort lcolor(red)) /// 1 "DELP" 
(line DayActMeRaA06S01V00 date, sort lcolor(red) lpattern(dash)) /// 2 "SOLT S1"
(line DayActMeRaA06S02V00 date, sort lcolor(blue) lpattern(dash)) /// 3 "SOLT S2"
if date > td(01jan2020) & date < td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily active cases) title("COVID-19 daily active cases, Iran", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 2 "SOLT S1" 3 "SOLT S2") size(small) row(1)) ///
subtitle("without GHAN", size(small))


graph save "graph 62 COVID-19 daily active cases wo GHAN.gph", replace
graph export "graph 62 COVID-19 daily active cases wo GHAN.pdf", replace








* daily active cases, wo GHAN, 01dec2020 on


twoway ///
(line DayActMeRaA01S00V03 date, sort lcolor(red)) /// 1 "DELP" 
(line DayActMeRaA06S01V00 date, sort lcolor(red) lpattern(dash)) /// 2 "SOLT S1"
(line DayActMeRaA06S02V00 date, sort lcolor(blue) lpattern(dash)) /// 3 "SOLT S2"
if date > td(01dec2020) & date < td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily active cases) title("COVID-19 daily active cases, Iran", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 2 "SOLT S1" 3 "SOLT S2") size(small) row(1)) ///
subtitle("without GHAN, after 2020-12-01", size(small))


graph save "graph 63 COVID-19 daily active cases wo GHAN.gph", replace
graph export "graph 63 COVID-19 daily active cases wo GHAN.pdf", replace




************************

* other outcomes (graph numbers start with 71)

	   


* daily hospital-related outcomes, DELP, IHME, IMPE


twoway ///
(line DayHosMeRaA01S00V03 date, sort lcolor(red)  lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0 V3)
(line DayVenMeRaA01S00V03 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0 V3)
(line DayBedMeSmA02S01V03 date, sort lcolor(black)) /// 3 IHME Bed need (Daily Beds needed Mean IHME S1)
(line DayIcuMeSmA02S01V03 date, sort lcolor(green)) /// 4 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayVenMeSmA02S01V03 date, sort lcolor(red)) /// 5 IHME Vent need (Daily invasive Ventilation needed Mean IHME S1)
(line DayAdmMeSmA02S01V03 date, sort lcolor(yellow)) /// 6 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayIcnMeSmA02S01V03 date, sort lcolor(blue)) /// 7 IHME ICU new (Daily new people going to ICU Mean IHME S1)
(line DayBeoMeSmA02S01V03 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) /// 8 IHME Bed over Daily bedover [covid all beds needed] - ([total bed capacity] - [average all bed])
(line DayHodMeRaA03S01V07 date, sort lcolor(magenta)) /// 9 IMPE Hosp demand (Daily hospital demand Mean A03 S01 V07)
(line DayHoiMeRaA03S01V07 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE Hosp incidence (Daily hospital incidence Mean A03 S01 V07)
(line DayIcdMeRaA03S01V07 date, sort lcolor(magenta) lpattern(dash_dot)) /// 11 IMPE ICU demand (Daily ICU demand Mean A03 S01 V07)
(line DayIciMeRaA03S01V07 date, sort lcolor(magenta) lpattern(longdash_shortdash)) /// 12 IMPE ICU incidence (Daily ICU incidence Mean A03 S01 V07)
if date > td(30dec2019) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, median scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME Bed need" 4 "IHME ICU need" 5 "IHME Vent need" ///
6 "IHME Admissions" 7 "IHME ICU new" 8 "IHME Bed over" 9 "IMPE Hosp demand" ///
10 "IMPE Hosp incidence" 11 "IMPE ICU demand" 12 "IMPE ICU incidence") rows(4) size(small))


graph save "graph 71 COVID-19 hospital-related outcomes.gph", replace
graph export "graph 71 COVID-19 hospital-related outcomes.pdf", replace




* daily hospital-related outcomes, DELP, IHME, IMPE, wo extremes (IHME Bed need, IHME Bed over, IMPE Hosp demand)


twoway ///
(line DayHosMeRaA01S00V03 date, sort lcolor(red)  lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0 V3)
(line DayVenMeRaA01S00V03 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0 V3)
(line DayIcuMeSmA02S01V03 date, sort lcolor(green)) /// 3 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayVenMeSmA02S01V03 date, sort lcolor(red)) /// 4 IHME Vent need (Daily invasive Ventilation needed Mean IHME S1)
(line DayAdmMeSmA02S01V03 date, sort lcolor(yellow)) /// 5 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayIcnMeSmA02S01V03 date, sort lcolor(blue)) /// 6 IHME ICU new (Daily new people going to ICU Mean IHME S1)
(line DayHoiMeRaA03S01V07 date, sort lcolor(magenta) lpattern(dash)) /// 7 IMPE Hosp incidence (Daily hospital incidence Mean A03 S01 V07)
(line DayIcdMeRaA03S01V07 date, sort lcolor(magenta) lpattern(dash_dot)) /// 8 IMPE ICU demand (Daily ICU demand Mean A03 S01 V07)
(line DayIciMeRaA03S01V07 date, sort lcolor(magenta) lpattern(longdash_shortdash)) /// 9 IMPE ICU incidence (Daily ICU incidence Mean A03 S01 V07)
if date > td(30dec2019) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, median scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME ICU need" 4 "IHME Vent need" ///
5 "IHME Admissions" 6 "IHME ICU new" 7 "IMPE Hosp incidence" 8 "IMPE ICU demand" 9 "IMPE ICU incidence") rows(3) size(small)) ///
subtitle("without extremes (IHME Bed need, IHME Bed over, IMPE Hosp demand)", size(small))


graph save "graph 72 COVID-19 hospital-related outcomes, wo extremes.gph", replace
graph export "graph 72 COVID-19 hospital-related outcomes, wo extremes.pdf", replace




* daily hospital-related outcomes, DELP, IHME, IMPE, wo extremes (IHME Bed need, IHME Bed over, IMPE Hosp demand), 01dec2020 on 



twoway ///
(line DayHosMeRaA01S00V03 date, sort lcolor(red)  lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0 V3)
(line DayVenMeRaA01S00V03 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0 V3)
(line DayIcuMeSmA02S01V03 date, sort lcolor(green)) /// 3 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayVenMeSmA02S01V03 date, sort lcolor(red)) /// 4 IHME Vent need (Daily invasive Ventilation needed Mean IHME S1)
(line DayAdmMeSmA02S01V03 date, sort lcolor(yellow)) /// 5 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayIcnMeSmA02S01V03 date, sort lcolor(blue)) /// 6 IHME ICU new (Daily new people going to ICU Mean IHME S1)
(line DayHoiMeRaA03S01V07 date, sort lcolor(magenta) lpattern(dash)) /// 7 IMPE Hosp incidence (Daily hospital incidence Mean A03 S01 V07)
(line DayIcdMeRaA03S01V07 date, sort lcolor(magenta) lpattern(dash_dot)) /// 8 IMPE ICU demand (Daily ICU demand Mean A03 S01 V07)
(line DayIciMeRaA03S01V07 date, sort lcolor(magenta) lpattern(longdash_shortdash)) /// 9 IMPE ICU incidence (Daily ICU incidence Mean A03 S01 V07)
if date > td(30nov2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#8, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, median scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME ICU need" 4 "IHME Vent need" ///
5 "IHME Admissions" 6 "IHME ICU new" 7 "IMPE Hosp incidence" 8 "IMPE ICU demand" 9 "IMPE ICU incidence") rows(3) size(small)) ///
subtitle("without extremes (IHME Bed need, IHME Bed over, IMPE Hosp demand), after 2020-12-01", size(small))


graph save "graph 73 COVID-19 hospital-related outcomes, wo extremes, 01dec2020 on.gph", replace
graph export "graph 73 COVID-19 hospital-related outcomes, wo extremes, 01dec2020 on.pdf", replace
















*************************************************


*********** table 2


use "Iran.dta", clear


/*

Select end of each hijri month

1399 09 30 = 2020 12 20
1399 10 30 = 2021 01 19
1399 11 30 = 2021 02 18
1399 12 30 = 2021 03 20
1400 01 31 = 2021 04 20
1400 02 31 = 2021 05 21
1400 03 31 = 2021 06 21
1400 04 10 = 2021 07 01

*/


* keep estimates for selected dates

keep if date == td(12dec2020) | date == td(19jan2021) | date == td(18feb2021) | ///
date == td(20mar2021) | date == td(20apr2021) | date == td(21may2021) | ///
date == td(21jun2021) | date == td(01jul2021) 


* drop Peak vars and IHME rates

forvalues n = 0/9 {

	qui  lookfor P`n'
	local this "`r(varlist)'"

	foreach var of local this {
		qui drop `var' 
	}
*

}
*

lookfor rate
local this "`r(varlist)'"

foreach var of local this {
	drop `var' 
}
*


drop loc_grand_name



xpose, clear varname 

rename _varname varname

order varname

rename v1 d_1399_09_30
rename v2 d_1399_10_30 
rename v3 d_1399_11_30
rename v4 d_1399_12_30
rename v5 d_1400_01_31
rename v6 d_1400_02_31 
rename v7 d_1400_03_31 
rename v8 d_1400_04_10 


save "Iran table 2.dta", replace

export delimited using "Iran table 2.csv", replace 





************************************************

* gen merged Iran peak results


clear 



*

if regexm(c(os),"Mac") == 1 {

	local studylist JOHN DELP IHME IMPE LANL SRIV SOLT GHAN

		foreach st in `studylist' {

		append using "$pathcovir2/`st'/Iran `st' peaks.dta", generate(`st')
		}
}								
else if regexm(c(os),"Windows") == 1 {

	local studylist JOHN DELP IHME IMPE LANL SRIV SOLT GHAN

		foreach st in `studylist' {

		append using "$pathcovir2\`st'\Iran `st' peaks.dta", generate(`st')
		}
}
* 


gen source = ""

replace source = "JOHN" if JOHN == 1

gen sourcenum = .

replace sourcenum = 0 if JOHN == 1

replace source = "DELP" if DELP == 1

replace sourcenum = 1 if DELP == 1

replace source = "IHME" if IHME == 1

replace sourcenum = 2 if IHME == 1

replace source = "IMPE" if IMPE == 1

replace sourcenum = 3 if IMPE == 1

replace source = "LANL" if LANL == 1

replace sourcenum = 4 if LANL == 1

replace source = "SRIV" if SRIV == 1

replace sourcenum = 5 if SRIV == 1

replace source = "SOLT" if SOLT == 1

replace sourcenum = 6 if SOLT == 1

replace source = "GHAN" if GHAN == 1

replace sourcenum = 7 if GHAN == 1


drop JOHN DELP IHME IMPE LANL SRIV SOLT GHAN


sort sourcenum 


order sourcenum source

compress



if regexm(c(os),"Mac") == 1 {

	save "$pathcovir2/merge/Iran peaks.dta", replace
	
	export delimited using "$pathcovir2/merge/Iran peaks.csv", replace 
	
}
else if regexm(c(os),"Windows") == 1 {

	save "$pathcovir2\merge\Iran peaks.dta", replace

	export delimited using "$pathcovir2\merge\Iran peaks.csv", replace 

}
* 




***************************************************

* gen fourth peak condensed table 


use "Iran.dta", clear


/*

keep fourth peak, four of five int'l studies (excluding A01 DELP), mean estimates 

A02 IHME Institute for Health Metrics and Evaluation
A03 IMPE Imperial College
A04 LANL Los Alamos National Laboratory
A05 SRIV Srivastava

*/



local sriv "DayDeaMeRaA05S00V02P0V DayDeaMeRaA05S00V02P0D DayCasMeRaA05S00V02P0V DayCasMeRaA05S00V02P0D"

di "`sriv'"


lookfor P4

local keep "`r(varlist)'"

di "`r(varlist)'"


keep `sriv'  `keep'


contract *

keep in 1 

drop _freq



lookfor Me

keep `r(varlist)'





foreach v in  * {

rename (`v') S`v'

}
*
 

foreach v in  * {

rename (`v') `v'j# , addnumber

}
*


gen counter = _n


gen i = _n

reshape long S, i(i) j(j, string)

drop i counter

rename j varname

rename S varvalue


replace varname = "DayDeaMeRaA02S01V03P4Vj01" if varname == "DayDeaMeRaA02S01V03P4Vj1"
replace varname = "DayDeaMeRaA02S01V03P4Dj02" if varname == "DayDeaMeRaA02S01V03P4Dj2"
replace varname = "DayDeaLoRaA02S01V03P4Vj03" if varname == "DayDeaLoRaA02S01V03P4Vj3"
replace varname = "DayDeaUpRaA02S01V03P4Vj04" if varname == "DayDeaUpRaA02S01V03P4Vj4"
replace varname = "DayDeaMeSmA02S02V03P4Vj05" if varname == "DayDeaMeSmA02S02V03P4Vj5"
replace varname = "DayDeaMeSmA02S02V03P4Dj06" if varname == "DayDeaMeSmA02S02V03P4Dj6"
replace varname = "DayDeaLoSmA02S02V03P4Vj07" if varname == "DayDeaLoSmA02S02V03P4Vj7"
replace varname = "DayDeaUpSmA02S02V03P4Vj08" if varname == "DayDeaUpSmA02S02V03P4Vj8"
replace varname = "DayDeaMeSmA02S03V03P4Vj09" if varname == "DayDeaMeSmA02S03V03P4Vj9"

			
replace varname = substr(varname,1,22)	



keep if regexm(varname,"A02") == 1 | regexm(varname,"A03") == 1 | regexm(varname,"A04") == 1 | regexm(varname,"A05") == 1 

		
	
/*	
study	Scenario 		Time point	Type	Daily deaths value	Daily cases value	
                                            Daily deaths date	Daily cases date 
											
																				DayDeaMe__A0_S0_V0_P4V	DayDeaMe__A0_S0_V0_P4D	DayCasMe__A0_S0_V0_P4V	DayCasMe__A0_S0_V0_P4D		
																				
IHME	Current (S1)	Fourth peak	Mean	196	00 03 08	54,927	00 02 14	DayDeaMeRaA02S01V03P4V	DayDeaMeRaA02S01V03P4D	DayCasMeRaA02S01V03P4V	DayCasMeRaA02S01V03P4D
IHME	Best (S2)		Fourth peak	Mean	108	00 01 14	35,055	99 12 19	DayDeaMeSmA02S02V03P4V	DayDeaMeSmA02S02V03P4D	DayCasMeRaA02S02V03P4V	DayCasMeRaA02S02V03P4D
IHME	Worse (S3)		Fourth peak	Mean	205	00 03 12	57,333	00 02 19	DayDeaMeRaA02S03V03P4V	DayDeaMeRaA02S03V03P4D	DayCasMeRaA02S03V03P4V	DayCasMeRaA03S02V03P4D
IMPE	Current (S2)	Fourth peak	Mean	346	00 03 08	83,706	00 02 26	DayDeaMeRaA03S02V07P4V	DayDeaMeRaA03S02V07P4D	DayCasMeRaA03S02V07P4V	DayCasMeRaA03S02V07P4D
IMPE	Best (S1)		Fourth peak	Mean	84	99 12 23	28,002	99 12 16	DayDeaMeRaA03S01V07P4V	DayDeaMeRaA03S01V07P4D	DayCasMeRaA03S01V07P4V	DayCasMeRaA03S01V07P4D	
IMPE	Worst (S3)		Fourth peak	Mean 2,578	00 02 17	549,142	00 02 08	DayDeaMeRaA03S03V07P4V	DayDeaMeRaA03S03V07P4D	DayCasMeRaA03S03V07P4V	DayCasMeRaA03S03V07P4D
LANL	Single (S0)		Fourth peak	Mean	108	99 12 11	8,548	99 12 19	DayDeaMeRaA04S00V02P4V	DayDeaMeRaA04S00V02P4D	DayCasMeRaA04S00V02P4V	DayCasMeRaA04S00V02P4D
SRIV	Current (S0)	One peak	Mean	86	00 01 05	8,236	99 12 25	DayDeaMeRaA05S00V02P0V	DayDeaMeRaA05S00V02P0D	DayCasMeRaA05S00V02P0V	DayCasMeRaA05S00V02P0D
*/		
	


gen Study = substr(varname,11,3)

gen Scenario = substr(varname,14,3)

gen Dateorvalue = substr(varname,22,1)

gen Deathorcase = substr(varname,4,3)

sort Study Scenario Deathorcase Dateorvalue

order Study Scenario Deathorcase Dateorvalue	

save "fourth peak condensed table.dta", replace







* sort by Daily deaths value


use "fourth peak condensed table.dta", clear

keep if Deathorcase == "Dea" 

sort Dateorvalue varvalue

* obs 9/16 are ascending Daily deaths value 

keep if ((Study == Study[9]) | (Study == Study[16])) & ((Scenario == Scenario[9]) | (Scenario == Scenario[16])) 

drop Deathorcase Dateorvalue

sort varvalue in 1/2

sort varvalue in 3/4

gen Estimate_name = "Daily deaths value" in 3/4

gen Extreme_value_name = "Lowest" in 3

replace Extreme_value_name = "Highest" in 4

gen Related_estiamte = "Daily deaths date" in 3/4

gen Related_estiamte_value = varvalue[1] in 3

replace Related_estiamte_value = varvalue[2] in 4

drop in 1/2

format Related_estiamte_value %tdDDMonCCYY

drop varname

rename varvalue Extreme_value

order Estimate_name Extreme_value_name Extreme_value Related_estiamte Related_estiamte_value Study Scenario

save "Daily deaths value.dta",  replace


*






* sort by Daily cases value


use "fourth peak condensed table.dta", clear

keep if Deathorcase == "Cas" 

sort Dateorvalue varvalue

* obs 9/16 are ascending Daily cases value 

keep if ((Study == Study[9]) | (Study == Study[16])) & ((Scenario == Scenario[9]) | (Scenario == Scenario[16])) 

drop Deathorcase Dateorvalue

sort varvalue in 1/2

sort varvalue in 3/4

gen Estimate_name = "Daily cases value" in 3/4

gen Extreme_value_name = "Lowest" in 3

replace Extreme_value_name = "Highest" in 4

gen Related_estiamte = "Daily cases date" in 3/4

gen Related_estiamte_value = varvalue[1] in 3

replace Related_estiamte_value = varvalue[2] in 4

drop in 1/2

format Related_estiamte_value %tdDDMonCCYY

drop varname

rename varvalue Extreme_value

order Estimate_name Extreme_value_name Extreme_value Related_estiamte Related_estiamte_value Study Scenario

save "Daily cases value.dta",  replace



*






* sort by Daily deaths date


use "fourth peak condensed table.dta", clear

keep if Deathorcase == "Dea" 

sort Dateorvalue varvalue

* obs 1/8 are ascending Daily deaths date

keep if ((Study == Study[1]) | (Study == Study[8])) & ((Scenario == Scenario[1]) | (Scenario == Scenario[8])) 

drop Deathorcase Dateorvalue

sort varvalue in 1/2

sort varvalue in 3/4

gen Estimate_name = "Daily deaths date" in 1/2

gen Extreme_value_name = "Lowest" in 1

replace Extreme_value_name = "Highest" in 2

gen Related_estiamte = "Daily deaths value" in 1/2

gen Related_estiamte_value = varvalue[3] in 1

replace Related_estiamte_value = varvalue[4] in 2

drop in 3/4

drop varname

rename varvalue Extreme_value

format Extreme_value %tdDDMonCCYY

order Estimate_name Extreme_value_name Extreme_value Related_estiamte Related_estiamte_value Study Scenario

save "Daily deaths date.dta",  replace


*





* sort by Daily cases date


use "fourth peak condensed table.dta", clear

keep if Deathorcase == "Cas" 

sort Dateorvalue varvalue

* obs 1/8 are ascending Daily cases date

keep if ((Study == Study[1]) | (Study == Study[8])) & ((Scenario == Scenario[1]) | (Scenario == Scenario[8])) 

drop Deathorcase Dateorvalue

sort varvalue in 1/2

sort varvalue in 3/4

gen Estimate_name = "Daily cases date" in 1/2

gen Extreme_value_name = "Lowest" in 1

replace Extreme_value_name = "Highest" in 2

gen Related_estiamte = "Daily cases value" in 1/2

gen Related_estiamte_value = varvalue[3] in 1

replace Related_estiamte_value = varvalue[4] in 2

drop in 3/4

drop varname

rename varvalue Extreme_value

format Extreme_value %tdDDMonCCYY

order Estimate_name Extreme_value_name Extreme_value Related_estiamte Related_estiamte_value Study Scenario

save "Daily cases date.dta",  replace


*


use "Daily deaths value.dta", clear 

append using "Daily cases value.dta"

save "fourth peak condensed table daily values.dta", replace

export delimited "fourth peak condensed table daily values.csv", replace


use "Daily deaths date.dta", clear 

append using "Daily cases date.dta"

save "fourth peak condensed table daily dates.dta", replace

export delimited "fourth peak condensed table daily dates.csv", replace





************

* restore native scheme (of the local machine)

set scheme $nativescheme

di c(scheme)


view "log Iran merge.smcl"

log close

exit, clear




