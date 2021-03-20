
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


* daily deaths, median or reference scenario, with DELPHI


twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaLoRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
if date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1))


graph save "graph 11 COVID-19 daily deaths, Iran, reference scenarios, with DELPHI.gph", replace
// graph export "graph 11 COVID-19 daily deaths, Iran, reference scenarios, with DELPHI.pdf", replace






* daily deaths, median or reference scenario, without DELPHI


twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 2 "IHME"
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1))


graph save "graph 12 COVID-19 daily deaths, Iran, reference scenarios, without DELPHI.gph", replace
// graph export "graph 12 COVID-19 daily deaths, Iran, reference scenarios, without DELPHI.pdf", replace







* daily deaths, median or reference scenario, without DELPHI, 01dec2020 on


twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 2 "IHME"
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1))


graph save "graph 13 COVID-19 daily deaths, Iran, reference scenarios, without DELPHI, 01dec2020 on.gph", replace
// graph export "graph 13 COVID-19 daily deaths, Iran, reference scenarios, without DELPHI, 01dec2020 on.pdf", replace




* daily deaths, median or reference scenario, without DELPHI, 01dec2020 on, CI


twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayDeaMeSmA02S02 date, sort lcolor(black)) /// 2 IHME mean
(line DayDeaLoSmA02S02 date, sort lcolor(black) lpattern(dash)) /// 3 IHME lower
(line DayDeaUpSmA02S02 date, sort lcolor(black) lpattern(dash)) /// 4 IHME upper
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 IMPE mean
(line DayDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 6 IMPE lower
(line DayDeaUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 7 IMPE upper
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 8 LANL mean
(line DayDeaLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 9 LANL lower
(line DayDeaUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 10 LANL upper
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 11 "SRIV" mean
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 12 "SRIV" lower
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 13 "SRIV" upper
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 5 "IMPE" 8 "LANL" 11 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves")


graph save "graph 14 COVID-19 daily deaths, Iran, reference scenarios, without DELPHI, 01dec2020 on, CI.gph", replace
// graph export "graph 14 COVID-19 daily deaths, Iran, reference scenarios, without DELPHI, 01dec2020 on, CI.pdf", replace


summ DayDeaUpRaA03S02V07 // 3272.17 = 3272
list date if DayDeaUpRaA03S02V07 > 3272.16 & DayDeaUpRaA03S02V07 != . // 21apr2021






* daily deaths, median or reference scenario, without DELPHI, 01dec2020 on, CI, wo IMPE upper


twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayDeaMeSmA02S02 date, sort lcolor(black)) /// 2 IHME mean
(line DayDeaLoSmA02S02 date, sort lcolor(black) lpattern(dash)) /// 3 IHME lower
(line DayDeaUpSmA02S02 date, sort lcolor(black) lpattern(dash)) /// 4 IHME upper
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 IMPE mean
(line DayDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 6 IMPE lower
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 7 LANL mean
(line DayDeaLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 8 LANL lower
(line DayDeaUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 9 LANL upper
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 10 "SRIV" mean
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 11 "SRIV" lower
(line DayDeaMeRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 12 "SRIV" upper
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 5 "IMPE" 7 "LANL" 10 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves. IMPE upper not shown.")

// IMPE upper not shown (higher than others).

graph save "graph 15 COVID-19 daily deaths, Iran, reference scenarios, without DELPHI, 01dec2020 on, CI, wo IMPE upper.gph", replace
// graph export "graph 15 COVID-19 daily deaths, Iran, reference scenarios, without DELPHI, 01dec2020 on, CI, wo IMPE upper.pdf", replace









***********************

* Daily cases (graph numbers start with 20)




* daily cases, median or reference scenario, with DELPHI, with GHAN


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
(line DayCasAcRaA06S01V00 date, sort lcolor(brown) lpattern(dash)) /// 7 "SOLT S1"
(line DayCasAcRaA06S02V00 date, sort lcolor(brown) lpattern("-.")) /// 8 "SOLT S2"
(line DayCasMeRaA07S09V00 date, sort lcolor(yellow) lpattern(dash)) /// 9 "GHAN"
if date > td(31dec2019) & date < td(02jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV" 7 "SOLT S1" 8 "SOLT S2" 9 "GHAN") size(small) row(2)) ///
note("SOLT estiamtes daily active cases, not daily incident cases.")


graph save "graph 21 COVID-19 daily cases, Iran, reference scenarios, with DELPHI, with GHAN.gph", replace
// graph export "graph 21 COVID-19 daily cases, Iran, reference scenarios, with DELPHI, with GHAN.pdf", replace




* daily cases, median or reference scenario, with DELPHI, wo GHAN


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
(line DayCasAcRaA06S01V00 date, sort lcolor(brown) lpattern(dash)) /// 7 "SOLT S1"
(line DayCasAcRaA06S02V00 date, sort lcolor(brown) lpattern("-.")) /// 8 "SOLT S2"
if date > td(31dec2019) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV" 7 "SOLT S1" 8 "SOLT S2") size(small) row(2)) ///
note("SOLT estiamtes daily active cases, not daily incident cases.")


graph save "graph 21 COVID-19 daily cases, Iran, reference scenarios, with DELPHI, wo GHAN.gph", replace
// graph export "graph 21 COVID-19 daily cases, Iran, reference scenarios, with DELPHI, wo GHAN.pdf", replace





* daily cases, median or reference scenario, without DELPHI


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 2 "IHME"
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
(line DayCasAcRaA06S01V00 date, sort lcolor(brown) lpattern(dash)) /// 6 "SOLT S1"
(line DayCasAcRaA06S02V00 date, sort lcolor(brown) lpattern("-.")) /// 7 "SOLT S2"
if date > td(31dec2019) & date < td(02jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV" 6 "SOLT S1" 7 "SOLT S2") size(small) row(2)) ///
note("SOLT estiamtes daily active cases, not daily incident cases.")


graph save "graph 22 COVID-19 daily cases, Iran, reference scenarios, without DELPHI.gph", replace
// graph export "graph 22 COVID-19 daily cases, Iran, reference scenarios, without DELPHI.pdf", replace






* daily cases, median or reference scenario, without DELPHI, 01dec2020 on, with SOLT


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 2 "IHME"
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
(line DayCasAcRaA06S01V00 date, sort lcolor(brown) lpattern(dash)) /// 6 "SOLT S1"
(line DayCasAcRaA06S02V00 date, sort lcolor(brown) lpattern("-.")) /// 7 "SOLT S2"
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV" 6 "SOLT S1" 7 "SOLT S2") size(small) row(2)) ///
note("SOLT estiamtes daily active cases, not daily incident cases.")


graph save "graph 23 COVID-19 daily cases, Iran, reference scenarios, without DELPHI, 01dec2020 on, with SOLT.gph", replace
// graph export "graph 23 COVID-19 daily cases, Iran, reference scenarios, without DELPHI, 01dec2020 on, with SOLT.pdf", replace






* daily cases, median or reference scenario, without DELPHI, 01dec2020 on, wo SOLT


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 2 "IHME"
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) 


graph save "graph 24 COVID-19 daily cases, Iran, reference scenarios, without DELPHI, 01dec2020 on, wo SOLT.gph", replace
// graph export "graph 24 COVID-19 daily cases, Iran, reference scenarios, without DELPHI, 01dec2020 on, wo SOLT.pdf", replace




* daily cases, median or reference scenario, without DELPHI, 01dec2020 on, CI


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 2 IHME mean
(line DayCasLoRaA02S02 date, sort lcolor(black) lpattern(dash)) /// 3 IHME lower
(line DayCasUpRaA02S02 date, sort lcolor(black) lpattern(dash)) /// 4 IHME upper
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 IMPE mean
(line DayCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 6 IMPE lower
(line DayCasUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 7 IMPE upper
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 8 LANL mean
(line DayCasLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 9 LANL lower
(line DayCasUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 10 LANL upper
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 11 "SRIV" mean
(line DayCasLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 12 "SRIV" lower
(line DayCasUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 13 "SRIV" upper
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 5 "IMPE" 8 "LANL" 11 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves")


graph save "graph 25 COVID-19 daily cases, Iran, reference scenarios, without DELPHI, 01dec2020 on, CI.gph", replace
// graph export "graph 25 COVID-19 daily cases, Iran, reference scenarios, without DELPHI, 01dec2020 on, CI.pdf", replace


summ DayCasUpRaA03S02V07 // 681418
list date if DayCasUpRaA03S02V07 > 681417.9 & DayCasUpRaA03S02V07 != . // 14apr2021






* daily cases, median or reference scenario, without DELPHI, 01dec2020 on, CI, wo IMPE upper


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayCasMeRaA02S02 date, sort lcolor(black)) /// 2 IHME mean
(line DayCasLoRaA02S02 date, sort lcolor(black) lpattern(dash)) /// 3 IHME lower
(line DayCasUpRaA02S02 date, sort lcolor(black) lpattern(dash)) /// 4 IHME upper
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 IMPE mean
(line DayCasLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 6 IMPE lower
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 7 LANL mean
(line DayCasLoRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 8 LANL lower
(line DayCasUpRaA04S00V02 date, sort lcolor(gold) lpattern(dash)) /// 9 LANL upper
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 10 "SRIV" mean
(line DayCasLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 11 "SRIV" lower
(line DayCasUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 12 "SRIV" upper
if date < td(02jul2021) & date > td(01dec2020) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 5 "IMPE" 7 "LANL" 10 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves. IMPE upper not shown.")

* IMPE upper not shown (higher than others)."

graph save "graph 26 COVID-19 daily cases, Iran, reference scenarios, without DELPHI, 01dec2020 on, CI, wo IMPE upper.gph", replace
// graph export "graph 26 COVID-19 daily cases, Iran, reference scenarios, without DELPHI, 01dec2020 on, CI, wo IMPE upper.pdf", replace







*****************

* total deaths (graph numbers start with 31)


* total deaths, median or reference scenario, with DELPHI


twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotDeaMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 5 "LANL"
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
if date > td(31dec2019) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1))


graph save "graph 31 COVID-19 total deaths, Iran, reference scenarios, with DELPHI.gph", replace
// graph export "graph 31 COVID-19 total deaths, Iran, reference scenarios, with DELPHI.pdf", replace






* total deaths, median or reference scenario, without DELPHI


twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 2 "IHME"
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 4 "LANL"
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date > td(31dec2019) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1))


graph save "graph 32 COVID-19 total deaths, Iran, reference scenarios, without DELPHI.gph", replace
// graph export "graph 32 COVID-19 total deaths, Iran, reference scenarios, without DELPHI.pdf", replace







* total deaths, median or reference scenario, without DELPHI, 01dec2020 on


twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 2 "IHME"
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 4 "LANL"
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1))


graph save "graph 33 COVID-19 total deaths, Iran, reference scenarios, without DELPHI, 01dec2020 on.gph", replace
// graph export "graph 33 COVID-19 total deaths, Iran, reference scenarios, without DELPHI, 01dec2020 on.pdf", replace




* total deaths, median or reference scenario, without DELPHI, 01dec2020 on, CI


twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotDeaMeSmA02S02 date, sort lcolor(black)) /// 2 IHME mean
(line TotDeaLoSmA02S02 date, sort lcolor(black) lpattern(dash)) /// 3 IHME lower
(line TotDeaUpSmA02S02 date, sort lcolor(black) lpattern(dash)) /// 4 IHME upper
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 IMPE mean
(line TotDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 6 IMPE lower
(line TotDeaUpRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 7 IMPE upper
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 8 LANL mean
(line TotDeaLoRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 9 LANL lower
(line TotDeaUpRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 10 LANL upper
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 11 "SRIV" mean
(line TotDeaLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 12 "SRIV" lower
(line TotDeaUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 13 "SRIV" upper
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 5 "IMPE" 8 "LANL" 11 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves")


graph save "graph 34 COVID-19 total deaths, Iran, reference scenarios, without DELPHI, 01dec2020 on, CI.gph", replace
// graph export "graph 34 COVID-19 total deaths, Iran, reference scenarios, without DELPHI, 01dec2020 on, CI.pdf", replace


summ date if TotDeaUpRaA03S02V07 > 100000
di %td 22376 // 06apr2021
summ date if TotDeaUpRaA03S02V07 > 200000
di %td 22410 // 10may2021






* total deaths, median or reference scenario, without DELPHI, 01dec2020 on, CI, wo IMPE upper


twoway ///
(line TotDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotDeaMeSmA02S02 date, sort lcolor(black)) /// 2 IHME mean
(line TotDeaLoSmA02S02 date, sort lcolor(black) lpattern(dash)) /// 3 IHME lower
(line TotDeaUpSmA02S02 date, sort lcolor(black) lpattern(dash)) /// 4 IHME upper
(line TotDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 5 IMPE mean
(line TotDeaLoRaA03S02V07 date, sort lcolor(magenta) lpattern(dash)) /// 6 IMPE lower
(line TotDeaMeRaA04S00V0 date, sort lcolor(gold)) /// 7 LANL mean
(line TotDeaLoRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 8 LANL lower
(line TotDeaUpRaA04S00V0 date, sort lcolor(gold) lpattern(dash)) /// 9 LANL upper
(line TotDeaMeRaA05S00V02 date, sort lcolor(green)) /// 10 "SRIV" mean
(line TotDeaLoRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 11 "SRIV" lower
(line TotDeaUpRaA05S00V02 date, sort lcolor(green) lpattern(dash)) /// 12 "SRIV" upper
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 5 "IMPE" 7 "LANL" 10 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves. IMPE upper not shown.")

* MPE upper not shown (higher than others).

graph save "graph 35 COVID-19 total deaths, Iran, reference scenarios, without DELPHI, 01dec2020 on, CI, wo IMPE upper.gph", replace
// graph export "graph 35 COVID-19 total deaths, Iran, reference scenarios, without DELPHI, 01dec2020 on, CI, wo IMPE upper.pdf", replace








*****************

* total cases (graph numbers start with 41)


* total cases, median or reference scenario, with DELPHI


twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
if date > td(31dec2019) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1))


graph save "graph 41 COVID-19 total cases, Iran, reference scenarios, with DELPHI.gph", replace
// graph export "graph 41 COVID-19 total cases, Iran, reference scenarios, with DELPHI.pdf", replace






* total cases, median or reference scenario, without DELPHI (though DELPHI is not the highest, IMPE is the highest - as graph counter placeholder)


twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA02S01 date, sort lcolor(black)) /// 2 "IHME"
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 4 "LANL"
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date > td(31dec2019) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#19, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1))


graph save "graph 42 COVID-19 total cases, Iran, reference scenarios, without DELPHI.gph", replace
// graph export "graph 42 COVID-19 total cases, Iran, reference scenarios, without DELPHI.pdf", replace







* total cases, median or reference scenario, with DELPHI, 01dec2020 on

two (line TotCasMeRaA04S00V0 date, sort lcolor(gold)) // 5 "LANL"


twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCasMeRaA04S00V0 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCasMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
if date > td(01dec2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1))


graph save "graph 43 COVID-19 total cases, Iran, reference scenarios, with DELPHI, 01dec2020 on.gph", replace
// graph export "graph 43 COVID-19 total cases, Iran, reference scenarios, with DELPHI, 01dec2020 on.pdf", replace




* total cases, median or reference scenario, with DELPHI, 01dec2020 on, CI



twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotCasMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasLoRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP"
(line TotCasUpRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP"
(line TotCasMeRaA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line TotCasLoRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotCasUpRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
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
ytitle(total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "LANL" 14 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves")


graph save "graph 44 COVID-19 total cases, Iran, reference scenarios, with DELPHI, 01dec2020 on, CI.gph", replace
// graph export "graph 44 COVID-19 total cases, Iran, reference scenarios, with DELPHI, 01dec2020 on, CI.pdf", replace


summ date if TotCasUpRaA03S02V07 > 40000000
di %td 22387 // 17apr2021







* total cases, median or reference scenario, without DELPHI, 01dec2020 on, CI, wo IMPE upper


twoway ///
(line TotCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotCasMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasLoRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP"
(line TotCasUpRaA01S00V03 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP"
(line TotCasMeRaA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line TotCasLoRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotCasUpRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
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
ytitle(total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 10 "LANL" 13 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves. IMPE upper not shown.")

* IMPE upper not shown (higher than others).

graph save "graph 45 COVID-19 total cases, Iran, reference scenarios, with DELPHI, 01dec2020 on, CI, wo IMPE upper.gph", replace
// graph export "graph 45 COVID-19 total cases, Iran, reference scenarios, with DELPHI, 01dec2020 on, CI, wo IMPE upper.pdf", replace









*****************

* daily cfr (graph numbers start with 51)


* all studies, all time, reference scenarios


twoway ///
(line DayCfrMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCfrMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line DayCfrMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
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
// graph export "graph 51 COVID-19 daily CFR, Iran, reference scenarios.pdf", replace





* all studies, 01mar2020 on, reference scenarios



twoway ///
(line DayCfrMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCfrMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line DayCfrMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCfrMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCfrMeRaA04S00V0 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCfrMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
if date > td(01mar2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1))


graph save "graph 52 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on.gph", replace
// graph export "graph 52 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on.pdf", replace








* wo LANL SRIV, 01mar2020 on, reference scenarios


twoway ///
(line DayCfrMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCfrMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line DayCfrMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCfrMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
if date > td(01mar2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE") size(small) row(1))


graph save "graph 53 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on, wo LANL SRIV.gph", replace
// graph export "graph 53 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on, wo LANL SRIV.pdf", replace







* wo JOHN LANL SRIV, 01mar2020 on, reference scenarios


twoway ///
(line DayCfrMeRaA01S00V03 date, sort lcolor(red)) /// 1 "DELP"
(line DayCfrMeRaA02S01 date, sort lcolor(black)) /// 2 "IHME"
(line DayCfrMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
if date > td(01mar2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 2 "IHME" 3 "IMPE") size(small) row(1))


graph save "graph 54 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on, wo JOHN LANL SRIV.gph", replace
// graph export "graph 54 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on,wo JOHN LANL SRIV.pdf", replace






* wo JOHN LANL SRIV, 01mar2020 on, reference scenarios, with CIs



twoway ///
(line DayCfrMeRaA01S00V03 date, sort lcolor(red)) /// 1 "DELP" mean
(line DayCfrLoRaA01S00V03 date, sort lcolor(red*.3) lpattern(dash)) /// 2 "DELP" lower
(line DayCfrUpRaA01S00V03 date, sort lcolor(red*.3) lpattern(dash)) /// 3 "DELP" upper
(line DayCfrMeRaA02S01 date, sort lcolor(black)) /// 4 "IHME" mean
(line DayCfrLoRaA02S01 date, sort lcolor(black*.2) lpattern(dash)) /// 5 "IHME" lower
(line DayCfrUpRaA02S01 date, sort lcolor(black*.2) lpattern(dash)) /// 6 "IHME" upper
(line DayCfrMeRaA03S02V07 date, sort lcolor(magenta)) /// 7 "IMPE" mean
(line DayCfrLoRaA03S02V07 date, sort lcolor(magenta*.2) lpattern(dash)) /// 8 "IMPE" lower
(line DayCfrUpRaA03S02V07 date, sort lcolor(magenta*.2) lpattern(dash)) /// 9 "IMPE" upper
if date > td(01mar2020) & date < td(02jul2021) ///
, xtitle(Date) xlabel(#16, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 4 "IHME" 7 "IMPE") size(small) row(1)) ///
note("Uncertainty limits: dashed light curves.")


graph save "graph 55 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on, wo JOHN LANL SRIV, with CIs.gph", replace
// graph export "graph 55 COVID-19 daily CFR, Iran, reference scenarios, 01mar2020 on,wo JOHN LANL SRIV, with CIs.pdf", replace


************

* restore native scheme (of the local machine)

set scheme $nativescheme

di c(scheme)







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





view "log Iran merge.smcl"

log close

exit, clear




