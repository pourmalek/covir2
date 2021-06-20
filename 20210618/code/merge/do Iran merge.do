
clear all

cd "$pathcovir2"

cd merge

capture log close

log using "log Iran merge.smcl", replace


***************************************************************************
* This is "do Iran merge.do"

* Project: COVID-19 Iran Review No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Merge component studies' estimates for Iran, grphas
***************************************************************************


/* 

List of component studies:

JOHN A00

DELP A01
IHME A02
IMPE A03
LANL A04
SRIV A05

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




* 

label var loc_grand_name "Location"







*************************************


* Cases to deaths ratio


gen DayCTDMeRaA00S00 =  DayCasMeRaA00S00 / DayDeaMeRaA00S00

label var DayCTDMeRaA00S00  "Daily Cases to Deaths S0 JOHN"

gen TotCTDMeRaA00S00 =  TotCasMeRaA00S00 / TotDeaMeRaA00S00

label var TotCTDMeRaA00S00  "Total Cases to Deaths S0 JOHN"




gen DayCTDMeRaA01S00 =  DayCasMeRaA01S00 / DayDeaMeRaA01S00

label var DayCTDMeRaA01S00  "Daily Cases to Deaths S0 DELP"

gen TotCTDMeRaA01S00 =  TotCasMeRaA01S00 / TotDeaMeRaA01S00

label var TotCTDMeRaA01S00  "Total Cases to Deaths S0 DELP"  




gen DayCTDMeRaA02S01  =  DayCasMeRaA02S01  / DayDeaMeRaA02S01 

label var DayCTDMeRaA02S01   "Daily Cases to Deaths S1 IHME"

gen TotCTDMeRaA02S01  =  TotCasMeRaA02S01  / TotDeaMeRaA02S01 

label var TotCTDMeRaA02S01   "Total Cases to Deaths S1 IHME"




gen DayCTDMeRaA02S02 = DayCasMeRaA02S02 / DayDeaMeRaA02S02  

label var DayCTDMeRaA02S02 "Daily Cases to Deaths S2 IHME"

gen TotCTDMeRaA02S02 = TotCasMeRaA02S02 / TotDeaMeRaA02S02  

label var TotCTDMeRaA02S02 "Total Cases to Deaths S2 IHME"




gen DayCTDMeRaA02S03  = DayCasMeRaA02S03  / DayDeaMeRaA02S03   

label var DayCTDMeRaA02S03  "Daily Cases to Deaths S3 IHME"

gen TotCTDMeRaA02S03  = TotCasMeRaA02S03  / TotDeaMeRaA02S03   

label var TotCTDMeRaA02S03  "Total Cases to Deaths S3 IHME"






gen DayCTDMeRaA03S01  = DayCasMeRaA03S01  / DayDeaMeRaA03S01   

label var DayCTDMeRaA03S01  "Daily Cases to Deaths S1 IMPE"

gen TotCTDMeRaA03S01  = TotCasMeRaA03S01  / TotDeaMeRaA03S01   

label var TotCTDMeRaA03S01  "Total Cases to Deaths S1 IMPE"



gen DayCTDMeRaA03S02  = DayCasMeRaA03S02  / DayDeaMeRaA03S02   

label var DayCTDMeRaA03S02  "Daily Cases to Deaths S2 IMPE"

gen TotCTDMeRaA03S02  = TotCasMeRaA03S02  / TotDeaMeRaA03S02   

label var TotCTDMeRaA03S02  "Total Cases to Deaths S2 IMPE"



gen DayCTDMeRaA03S03  = DayCasMeRaA03S03  / DayDeaMeRaA03S03   

label var DayCTDMeRaA03S03  "Daily Cases to Deaths S3 IMPE"

gen TotCTDMeRaA03S03  = TotCasMeRaA03S03  / TotDeaMeRaA03S03   

label var TotCTDMeRaA03S03  "Total Cases to Deaths S3 IMPE"





gen DayCTDMeRaA04S00  = DayCasMeRaA04S00  / DayDeaMeRaA04S00   

label var DayCTDMeRaA04S00  "Daily Cases to Deaths S0 LANL"

gen TotCTDMeRaA04S00  = TotCasMeRaA04S00  / TotDeaMeRaA04S00   

label var TotCTDMeRaA04S00  "Total Cases to Deaths S0 LANL"





gen DayCTDMeRaA05S00  = DayCasMeRaA05S00  / DayDeaMeRaA05S00   

label var DayCTDMeRaA05S00  "Daily Cases to Deaths S0 SRIV"

gen TotCTDMeRaA05S00  = TotCasMeRaA05S00  / TotDeaMeRaA05S00   

label var TotCTDMeRaA05S00  "Total Cases to Deaths S0 SRIV"






***********************

* daily deaths estimated to reported  

    
gen DayDERMeRaA00S00 = DayDeaMeRaA00S00 / DayDeaMeRaA00S00

label var DayDERMeRaA00S00 "Daily Deaths estim to reported JOHN = 1" 


gen DayDERMeRaA01S00 = DayDeaMeRaA01S00 / DayDeaMeRaA00S00

label var DayDERMeRaA01S00 "Daily Deaths estim to reported Mean DELP S0"

line DayDeaMeRaA01S00  DayDeaMeRaA00S00 date




gen DayDERMeRaA02S01 = DayDeaMeRaA02S01 / DayDeaMeRaA00S00

label var DayDERMeRaA02S01 "Daily Deaths estim to reported Mean not smoothed IHME S1"


gen DayDERMeRaA02S02 = DayDeaMeRaA02S02 / DayDeaMeRaA00S00

label var DayDERMeRaA02S02 "Daily Deaths estim to reported Mean not smoothed IHME S2"


gen DayDERMeRaA02S03 = DayDeaMeRaA02S03 / DayDeaMeRaA00S00

label var DayDERMeRaA02S03 "Daily Deaths estim to reported Mean not smoothed IHME S3"



gen DayDERMeRaA03S01 = DayDeaMeRaA03S01 / DayDeaMeRaA00S00

label var DayDERMeRaA03S01 "Daily Deaths estim to reported Mean S1 IMPE"


gen DayDERMeRaA03S02 = DayDeaMeRaA03S02 / DayDeaMeRaA00S00

label var DayDERMeRaA03S02 "Daily Deaths estim to reported Mean S2 IMPE"


gen DayDERMeRaA03S03 = DayDeaMeRaA03S03 / DayDeaMeRaA00S00

label var DayDERMeRaA03S03 "Daily Deaths estim to reported Mean S3 IMPE"



gen DayDERMeRaA04S00 = DayDeaMeRaA04S00 / DayDeaMeRaA00S00

label var DayDERMeRaA04S00 "Daily Deaths estim to reported to Deaths S0 LANL"



gen DayDERMeRaA05S00  = DayDeaMeRaA05S00 / DayDeaMeRaA00S00

label var DayDERMeRaA05S00 "Daily Deaths estim to reported S0 SRIV"







* daily cases estimated to reported  


gen DayCERMeRaA00S00 = DayCasMeRaA00S00 / DayCasMeRaA00S00

label var DayCERMeRaA00S00 "Daily Cases estim to reported JOHN = 1" 



gen DayCERMeRaA01S00 = DayCasMeRaA01S00 / DayCasMeRaA00S00

label var DayCERMeRaA01S00 "Daily Cases estim to reported Mean DELP S0"



gen DayCERMeRaA02S01 = DayCasMeRaA02S01 / DayCasMeRaA00S00

label var DayCERMeRaA02S01 "Daily Cases estim to reported Mean not smoothed IHME S1"


gen DayCERMeRaA02S02 = DayCasMeRaA02S02 / DayCasMeRaA00S00

label var DayCERMeRaA02S02 "Daily Cases estim to reported Mean not smoothed IHME S2"


gen DayCERMeRaA02S03 = DayCasMeRaA02S03 / DayCasMeRaA00S00

label var DayCERMeRaA02S03 "Daily Cases estim to reported Mean not smoothed IHME S3"



gen DayCERMeRaA03S01 = DayCasMeRaA03S01 / DayCasMeRaA00S00

label var DayCERMeRaA03S01 "Daily Cases estim to reported Mean S1 IMPE"


gen DayCERMeRaA03S02 = DayCasMeRaA03S02 / DayCasMeRaA00S00

label var DayCERMeRaA03S02 "Daily Cases estim to reported Mean S2 IMPE"


gen DayCERMeRaA03S03 = DayCasMeRaA03S03 / DayCasMeRaA00S00

label var DayCERMeRaA03S03 "Daily Cases estim to reported Mean S3 IMPE"



gen DayCERMeRaA04S00 = DayCasMeRaA04S00 / DayCasMeRaA00S00

label var DayCERMeRaA04S00 "Daily Cases estim to reported to Cases S0 LANL"



gen DayCERMeRaA05S00  = DayCasMeRaA05S00 / DayCasMeRaA00S00

label var DayCERMeRaA05S00 "Daily Cases estim to reported S0 SRIV"







* Total deaths estimated to reported  


gen TotDERMeRaA00S00 = TotDeaMeRaA00S00 / TotDeaMeRaA00S00

label var TotDERMeRaA00S00 "Total Deaths estim to reported JOHN = 1" 



gen TotDERMeRaA01S00 = TotDeaMeRaA01S00 / TotDeaMeRaA00S00

label var TotDERMeRaA01S00 "Total Deaths estim to reported Mean DELP S0"



gen TotDERMeRaA02S01 = TotDeaMeRaA02S01 / TotDeaMeRaA00S00

label var TotDERMeRaA02S01 "Total Deaths estim to reported Mean not smoothed IHME S1"


gen TotDERMeRaA02S02 = TotDeaMeRaA02S02 / TotDeaMeRaA00S00

label var TotDERMeRaA02S02 "Total Deaths estim to reported Mean not smoothed IHME S2"


gen TotDERMeRaA02S03 = TotDeaMeRaA02S03 / TotDeaMeRaA00S00

label var TotDERMeRaA02S03 "Total Deaths estim to reported Mean not smoothed IHME S3"



gen TotDERMeRaA03S01 = TotDeaMeRaA03S01 / TotDeaMeRaA00S00

label var TotDERMeRaA03S01 "Total Deaths estim to reported Mean S1 IMPE"


gen TotDERMeRaA03S02 = TotDeaMeRaA03S02 / TotDeaMeRaA00S00

label var TotDERMeRaA03S02 "Total Deaths estim to reported Mean S2 IMPE"


gen TotDERMeRaA03S03 = TotDeaMeRaA03S03 / TotDeaMeRaA00S00

label var TotDERMeRaA03S03 "Total Deaths estim to reported Mean S3 IMPE"



gen TotDERMeRaA04S00 = TotDeaMeRaA04S00 / TotDeaMeRaA00S00

label var TotDERMeRaA04S00 "Total Deaths estim to reported to Deaths S0 LANL"



gen TotDERMeRaA05S00  = TotDeaMeRaA05S00 / TotDeaMeRaA00S00

label var TotDERMeRaA05S00 "Total Deaths estim to reported S0 SRIV"







* Total cases estimated to reported  


gen TotCERMeRaA00S00 = TotCasMeRaA00S00 / TotCasMeRaA00S00

label var TotCERMeRaA00S00 "Total Cases estim to reported JOHN = 1" 


gen TotCERMeRaA01S00 = TotCasMeRaA01S00 / TotCasMeRaA00S00

label var TotCERMeRaA01S00 "Total Cases estim to reported Mean DELP S0"



gen TotCERMeRaA02S01 = TotCasMeRaA02S01 / TotCasMeRaA00S00

label var TotCERMeRaA02S01 "Total Cases estim to reported Mean not smoothed IHME S1"


gen TotCERMeRaA02S02 = TotCasMeRaA02S02 / TotCasMeRaA00S00

label var TotCERMeRaA02S02 "Total Cases estim to reported Mean not smoothed IHME S2"


gen TotCERMeRaA02S03 = TotCasMeRaA02S03 / TotCasMeRaA00S00

label var TotCERMeRaA02S03 "Total Cases estim to reported Mean not smoothed IHME S3"



gen TotCERMeRaA03S01 = TotCasMeRaA03S01 / TotCasMeRaA00S00

label var TotCERMeRaA03S01 "Total Cases estim to reported Mean S1 IMPE"


gen TotCERMeRaA03S02 = TotCasMeRaA03S02 / TotCasMeRaA00S00

label var TotCERMeRaA03S02 "Total Cases estim to reported Mean S2 IMPE"


gen TotCERMeRaA03S03 = TotCasMeRaA03S03 / TotCasMeRaA00S00

label var TotCERMeRaA03S03 "Total Cases estim to reported Mean S3 IMPE"



gen TotCERMeRaA04S00 = TotCasMeRaA04S00 / TotCasMeRaA00S00

label var TotCERMeRaA04S00 "Total Cases estim to reported to Cases S0 LANL"



gen TotCERMeRaA05S00  = TotCasMeRaA05S00 / TotCasMeRaA00S00

label var TotCERMeRaA05S00 "Total Cases estim to reported S0 SRIV"








*

di in red "********* Description of vars in final combined file Iran.dta *********" 


desc, fullnames
 
 
*

sort date

qui compress

save "Iran.dta", replace

export delimited using "Iran.csv", replace 


*





***************

* graphs 


grstyle init

grstyle color background white



******************



* daily deaths (graph numbers start with 11)


****
* daily deaths, median or reference scenario

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDeaMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(22nov2019) & date <= td(22Dec2021) ///
, xtitle(Date) xlabel(21875 21905 21935 21965 21994 22025 22056 22087 22118 22149 22180 ///
22210 22240 22270 22300 22330 22360 22391 22422 22453 22484 22515 22546 22576 22606 22636, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white)) ///
ttext(0 22nov2019  "Aza" 0 22dec2019  "Dey" 0 21jan2020  "Bah" 0 20feb2020  "Esf" ///
0 20mar2020  "99"   0 20apr2020  "Ord" 0 21may2020  "Kho" ///
0 21jun2020  "Tir"  0 22jul2020  "Mor" 0 22aug2020  "Sha" ///
0 22sep2020  "Meh"  0 22oct2020  "Aba" 0 21nov2020  "Aza" ///
0 21dec2020  "Dey"  0 20jan2021  "Bah" 0 19feb2021  "Esf" ///
0 21mar2021  "00"   0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  0 23Oct2021  "Aba" 0 22Nov2021  "Aza" ///
0 22Dec2021  "Dey"  , size(small) color(black) placement(south))

graph save "graph 11 COVID-19 daily deaths, Iran, reference scenarios.gph", replace
graph export "graph 11 COVID-19 daily deaths, Iran, reference scenarios.pdf", replace



****
* daily deaths, median or reference scenario, 2020-12-01 on

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDeaMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(20dec2020) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22270 22300 22330 22360 22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("after 2020-12-01", size(small)) ///
ttext(0 21dec2020  "Dey"  0 20jan2021  "Bah" 0 19feb2021  "Esf" ///
0 21mar2021  "00"   0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 13 COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on.gph", replace
graph export "graph 13 COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on.pdf", replace



****
* daily deaths, median or reference scenario, Ordibeshet 1400 on

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDeaMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("after Ordibeshet 1400", size(small)) ///
ttext(0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 14 COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on.gph", replace
graph export "graph 14 COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on.pdf", replace



****
* daily deaths, median or reference scenario, 2020-12-01 on, CI

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayDeaLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayDeaUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" upper
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line DayDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line DayDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line DayDeaLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line DayDeaUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line DayDeaMeRaA04S00 date, sort lcolor(gold)) /// 11 LANL mean
(line DayDeaLoRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL lower
(line DayDeaUpRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL upper
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 14 "SRIV" mean
(line DayDeaMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" lower
(line DayDeaMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" upper
if date >= td(30nov2020) & date <= td(23Aug2021)  ///
, xtitle(Date) xlabel(#9, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "LANL" 14 "SRIV") size(small) row(1)) ///
subtitle("after 2020-12-01, with uncertainty", size(small)) ///
note("Uncertainty limits: dashed curves") 

graph save "graph 15 COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on, CI.gph", replace
graph export "graph 15 COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on, CI.pdf", replace



****
* daily deaths, median or reference scenario, 2020-12-01 on, CI

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayDeaLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayDeaUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" upper
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line DayDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line DayDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line DayDeaLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line DayDeaUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line DayDeaMeRaA04S00 date, sort lcolor(gold)) /// 11 LANL mean
(line DayDeaLoRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL lower
(line DayDeaUpRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL upper
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 14 "SRIV" mean
(line DayDeaMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" lower
(line DayDeaMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" upper
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "LANL" 17 "SRIV") size(small) row(1)) ///
subtitle("after Ordibeshet 1400, with uncertainty", size(small)) ///
note("Uncertainty limits: dashed curves") ///
ttext(0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 16 COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on, CI.gph", replace
graph export "graph 16 COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on, CI.pdf", replace



****
* daily deaths, median or reference scenario, 2020-12-01 on, CI

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayDeaLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 4 IHME mean
(line DayDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 5 IHME lower
(line DayDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME upper
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 7 IMPE mean
(line DayDeaLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 8 IMPE lower
(line DayDeaUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE upper
(line DayDeaMeRaA04S00 date, sort lcolor(gold)) /// 10 LANL mean
(line DayDeaLoRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 11 LANL lower
(line DayDeaUpRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL upper
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 13 "SRIV" mean
(line DayDeaMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 14 "SRIV" lower
(line DayDeaMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" upper
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 4 "IHME" 7 "IMPE" 10 "LANL" 13 "SRIV") size(small) row(1)) ///
subtitle("after Ordibeshet 1400, with uncertainty", size(small)) ///
note("Uncertainty limits: dashed curves") ///
ttext(0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 17 COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on, CI.gph", replace
graph export "graph 17 COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on, CI.pdf", replace



****
* daily deaths, after Ordibeshet 1400, reference scenario with uncertainty, IHME 

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayDeaMeRaA02S01 date, sort lcolor(black)) /// 2 IHME reference mean
(line DayDeaLoRaA02S01 date, sort lcolor(green) lpattern(dash)) /// 3 IHME reference lower
(line DayDeaUpRaA02S01 date, sort lcolor(red) lpattern(dash)) /// 4 IHME reference upper
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenario with uncertainty, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "reference scenario, mean" 3 "reference scenario, lower" 4 "reference scenario, upper") size(small) row(2)) ///
subtitle("after Ordibeshet 1400", size(small)) ///
note("Uncertainty limits: dashed (– – –) curves") ///
ttext(0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 19 a COVID-19 daily deaths, Iran, reference scenario with uncertainty, IHME.gph", replace
graph export "graph 19 a COVID-19 daily deaths, Iran, reference scenario with uncertainty, IHME.pdf", replace



****
* daily deaths, after Ordibeshet 1400, 3 scenarios, IHME 

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayDeaMeRaA02S01 date, sort lcolor(black)) /// 2 IHME reference mean
(line DayDeaMeRaA02S02 date, sort lcolor(green) lwidth(thick) lpattern(tight_dot)) /// 3 IHME better mean
(line DayDeaMeRaA02S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 4 IHME worse mean
(line DayDeaUpRaA02S03 date, sort lcolor(red) lpattern(dash)) /// 4 IHME worse upper
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, 3 scenarios, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "reference scenario, mean" 3 "better scenario, mean" 4 "worse scenario, mean") size(small) row(2)) ///
subtitle("after Ordibeshet 1400", size(small)) ///
note("Better and worse scenarios: tight dot (|||||) curves; Uncertainty limits: dashed (– – –) curves") ///
ttext(0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 19 b COVID-19 daily deaths, Iran, 3 scenarios, IHME.gph", replace
graph export "graph 19 b COVID-19 daily deaths, Iran, 3 scenarios, IHME.pdf", replace



****
* daily deaths, after Ordibeshet 1400, reference scenario with uncertainty, IMPE 

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayDeaMeRaA03S02 date, sort lcolor(black)) /// 2 IMPE reference mean
(line DayDeaLoRaA03S02 date, sort lcolor(green) lpattern(dash)) /// 3 IMPE reference lower
(line DayDeaUpRaA03S02 date, sort lcolor(red) lpattern(dash)) /// 4 IMPE reference upper
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenario with uncertainty, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "reference scenario, mean" 3 "reference scenario, lower" 4 "reference scenario, upper") size(small) row(2)) ///
subtitle("after Ordibeshet 1400", size(small)) ///
note("Uncertainty limits: dashed (– – –) curves") ///
ttext(0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 19 c COVID-19 daily deaths, Iran, reference scenario with uncertainty, IMPE.gph", replace
graph export "graph 19 c COVID-19 daily deaths, Iran, reference scenario with uncertainty, IMPE.pdf", replace



****
* daily deaths, after Ordibeshet 1400, 3 scenarios, IMPE 

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayDeaMeRaA03S02 date, sort lcolor(black)) /// 2 IMPE reference mean
(line DayDeaMeRaA03S01 date, sort lcolor(green) lwidth(thick) lpattern(tight_dot)) /// 3 IMPE better mean
(line DayDeaMeRaA03S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 4 IMPE worse mean
(line DayDeaUpRaA03S03 date, sort lcolor(red) lpattern(dash)) /// 4 IMPE worse upper
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, 3 scenarios, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "reference scenario, mean" 3 "better scenario, mean" 4 "worse scenario, mean") size(small) row(2)) ///
subtitle("after Ordibeshet 1400", size(small)) ///
note("Better and worse scenarios: tight dot (|||||) curves; Uncertainty limits: dashed (– – –) curves") ///
ttext(0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 19 d COVID-19 daily deaths, Iran, 3 scenarios, IMPE.gph", replace
graph export "graph 19 d COVID-19 daily deaths, Iran, 3 scenarios, IMPE.pdf", replace



***********************

* daily cases (graph numbers start with 21)


* daily cases, median or reference scenario

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCasMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCasMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(22nov2019) & date <= td(22Dec2021) ///
, xtitle(Date) xlabel(21875 21905 21935 21965 21994 22025 22056 22087 22118 22149 22180 ///
22210 22240 22270 22300 22330 22360 22391 22422 22453 22484 22515 22546 22576 22606 22636, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white)) ///
ttext(0 22nov2019  "Aza" 0 22dec2019  "Dey" 0 21jan2020  "Bah" 0 20feb2020  "Esf" ///
0 20mar2020  "99"   0 20apr2020  "Ord" 0 21may2020  "Kho" ///
0 21jun2020  "Tir"  0 22jul2020  "Mor" 0 22aug2020  "Sha" ///
0 22sep2020  "Meh"  0 22oct2020  "Aba" 0 21nov2020  "Aza" ///
0 21dec2020  "Dey"  0 20jan2021  "Bah" 0 19feb2021  "Esf" ///
0 21mar2021  "00"   0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  0 23Oct2021  "Aba" 0 22Nov2021  "Aza" ///
0 22Dec2021  "Dey"  , size(small) color(black) placement(south))

graph save "graph 21 COVID-19 daily cases, Iran, reference scenarios.gph", replace
graph export "graph 21 COVID-19 daily cases, Iran, reference scenarios.pdf", replace



****
* daily cases, median or reference scenario, 2020-12-01 on

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCasMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCasMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(20dec2020) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22270 22300 22330 22360 22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("after 2020-12-01", size(small)) ///
ttext(0 21dec2020  "Dey"  0 20jan2021  "Bah" 0 19feb2021  "Esf" ///
0 21mar2021  "00"   0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 23 COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on.gph", replace
graph export "graph 23 COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on.pdf", replace



****
* daily cases, median or reference scenario, Ordibeshet 1400 on

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCasMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCasMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("after Ordibeshet 1400", size(small)) ///
ttext(0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 24 COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on.gph", replace
graph export "graph 24 COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on.pdf", replace



****
* daily cases, median or reference scenario, 2020-12-01 on, CI

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" upper
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line DayCasLoRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line DayCasUpRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line DayCasMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line DayCasLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line DayCasUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line DayCasMeRaA04S00 date, sort lcolor(gold)) /// 11 LANL mean
(line DayCasLoRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL lower
(line DayCasUpRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL upper
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 14 "SRIV" mean
(line DayCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" lower
(line DayCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" upper
if date >= td(30nov2020) & date <= td(23Aug2021)  ///
, xtitle(Date) xlabel(#9, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "LANL" 14 "SRIV") size(small) row(1)) ///
subtitle("after 2020-12-01, with uncertainty", size(small)) ///
note("Uncertainty limits: dashed curves") 

graph save "graph 25 COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on, CI.gph", replace
graph export "graph 25 COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on, CI.pdf", replace



****
* daily cases, median or reference scenario, 2020-12-01 on, CI

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" upper
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line DayCasLoRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line DayCasUpRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line DayCasMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line DayCasLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line DayCasUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line DayCasMeRaA04S00 date, sort lcolor(gold)) /// 11 LANL mean
(line DayCasLoRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL lower
(line DayCasUpRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL upper
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 14 "SRIV" mean
(line DayCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" lower
(line DayCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" upper
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "LANL" 14 "SRIV") size(small) row(1)) ///
subtitle("after Ordibeshet 1400, with uncertainty", size(small)) ///
note("Uncertainty limits: dashed curves") ///
ttext(0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 26 COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on, CI.gph", replace
graph export "graph 26 COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on, CI.pdf", replace



****
* daily cases, after Ordibeshet 1400, full scenarios, with uncertainty, without DELP upper

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP" mean
(line DayCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP" lower
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 4 IHME reference mean
(line DayCasLoRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 5 IHME reference lower
(line DayCasUpRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME reference upper
(line DayCasMeRaA02S02 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 7 IHME better mean
(line DayCasMeRaA02S03 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 8 IHME worse mean
(line DayCasMeRaA03S02 date, sort lcolor(magenta)) /// 9 IMPE reference mean
(line DayCasLoRaA03S02 date, sort lcolor(magenta) lwidth(thick) lpattern(tight_dot)) /// 10 IMPE reference lower
(line DayCasUpRaA03S02 date, sort lcolor(magenta) lwidth(thick) lpattern(tight_dot)) /// 11 IMPE reference upper
(line DayCasMeRaA03S01 date, sort lcolor(magenta)) /// 12 IMPE better mean
(line DayCasMeRaA03S03 date, sort lcolor(magenta)) /// 13 IMPE worse mean
(line DayCasMeRaA04S00 date, sort lcolor(gold)) /// 14 LANL mean
(line DayCasLoRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 15 LANL lower
(line DayCasUpRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 16 LANL upper
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 17 "SRIV" mean
(line DayCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 18 "SRIV" lower
(line DayCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 19 "SRIV" upper
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, full scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 4 "IHME reference mean" 5 "IHME ref uncertainty" 7 "IHME better and worse" ///
9 "IMPE reference" 10 "IMPE ref uncertainty" 12 "IMPE better and worse" ///
14 "LANL" 17 "SRIV") size(small) row(4)) ///
subtitle("after Ordibeshet 1400, full scenarios, with uncertainty, without DELP upper", size(small)) ///
note("Uncertainty limits: dashed (– – –) curves; Better and worse scenarios: tight dot (|||||) curves") ///
ttext(0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 27 COVID-19 daily cases, Iran, full scenarios, 2020-12-01 on, CI.gph", replace
graph export "graph 27 COVID-19 daily cases, Iran, full scenarios, 2020-12-01 on, CI.pdf", replace



****
* daily cases, after Ordibeshet 1400, reference scenario with uncertainty, IHME 

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 2 IHME reference mean
(line DayCasLoRaA02S01 date, sort lcolor(green) lpattern(dash)) /// 3 IHME reference lower
(line DayCasUpRaA02S01 date, sort lcolor(red) lpattern(dash)) /// 4 IHME reference upper
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenario with uncertainty, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "reference scenario, mean" 3 "reference scenario, lower" 4 "reference scenario, upper") size(small) row(2)) ///
subtitle("after Ordibeshet 1400", size(small)) ///
note("Uncertainty limits: dashed (– – –) curves") ///
ttext(0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 29 a COVID-19 daily cases, Iran, reference scenario with uncertainty, IHME.gph", replace
graph export "graph 29 a COVID-19 daily cases, Iran, reference scenario with uncertainty, IHME.pdf", replace



****
* daily cases, after Ordibeshet 1400, 3 scenarios, IHME 

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 2 IHME reference mean
(line DayCasMeRaA02S02 date, sort lcolor(green) lwidth(thick) lpattern(tight_dot)) /// 3 IHME better mean
(line DayCasMeRaA02S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 4 IHME worse mean
(line DayCasUpRaA02S03 date, sort lcolor(red) lpattern(dash)) /// 4 IHME worse upper
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, 3 scenarios, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "reference scenario, mean" 3 "better scenario, mean" 4 "worse scenario, mean") size(small) row(2)) ///
subtitle("after Ordibeshet 1400", size(small)) ///
note("Better and worse scenarios: tight dot (|||||) curves; Uncertainty limits: dashed (– – –) curves") ///
ttext(0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 29 b COVID-19 daily cases, Iran, 3 scenarios, IHME.gph", replace
graph export "graph 29 b COVID-19 daily cases, Iran, 3 scenarios, IHME.pdf", replace



****
* daily cases, after Ordibeshet 1400, reference scenario with uncertainty, IMPE 

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayCasMeRaA03S02 date, sort lcolor(black)) /// 2 IMPE reference mean
(line DayCasLoRaA03S02 date, sort lcolor(green) lpattern(dash)) /// 3 IMPE reference lower
(line DayCasUpRaA03S02 date, sort lcolor(red) lpattern(dash)) /// 4 IMPE reference upper
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenario with uncertainty, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "reference scenario, mean" 3 "reference scenario, lower" 4 "reference scenario, upper") size(small) row(2)) ///
subtitle("after Ordibeshet 1400", size(small)) ///
note("Uncertainty limits: dashed (– – –) curves") ///
ttext(0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 29 c COVID-19 daily cases, Iran, reference scenario with uncertainty, IMPE.gph", replace
graph export "graph 29 c COVID-19 daily cases, Iran, reference scenario with uncertainty, IMPE.pdf", replace



****
* daily cases, after Ordibeshet 1400, 3 scenarios, IMPE 

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line DayCasMeRaA03S02 date, sort lcolor(black)) /// 2 IMPE reference mean
(line DayCasMeRaA03S01 date, sort lcolor(green) lwidth(thick) lpattern(tight_dot)) /// 3 IMPE better mean
(line DayCasMeRaA03S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 4 IMPE worse mean
(line DayCasUpRaA03S03 date, sort lcolor(red) lpattern(dash)) /// 4 IMPE worse upper
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, 3 scenarios, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "reference scenario, mean" 3 "better scenario, mean" 4 "worse scenario, mean") size(small) row(2)) ///
subtitle("after Ordibeshet 1400", size(small)) ///
note("Better and worse scenarios: tight dot (|||||) curves; Uncertainty limits: dashed (– – –) curves") ///
ttext(0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 29 d COVID-19 daily cases, Iran, 3 scenarios, IMPE.gph", replace
graph export "graph 29 d COVID-19 daily cases, Iran, 3 scenarios, IMPE.pdf", replace



*****************

* total deaths (graph numbers start with 31)


****
* total deaths, median or reference scenario

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDeaMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 31 COVID-19 total deaths, Iran, reference scenarios.gph", replace
graph export "graph 31 COVID-19 total deaths, Iran, reference scenarios.pdf", replace



****
* total deaths, median or reference scenario, 2020-12-01 on

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDeaMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("after 2020-12-01", size(small))

graph save "graph 33 COVID-19 total deaths, Iran, reference scenarios, 2020-12-01 on.gph", replace
graph export "graph 33 COVID-19 total deaths, Iran, reference scenarios, 2020-12-01 on.pdf", replace



****
* total deaths, median or reference scenario, 2020-12-01 on, CI

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 DELP mean
(line TotDeaLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 DELP lower
(line TotDeaUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 DELP upper
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line TotDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line TotDeaLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line TotDeaUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line TotDeaMeRaA04S00 date, sort lcolor(gold)) /// 11 LANL mean
(line TotDeaLoRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 12 LANL lower
(line TotDeaUpRaA04S00 date, sort lcolor(gold) lpattern(dash)) /// 13 LANL upper
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 14 "SRIV" mean
(line TotDeaLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" lower
(line TotDeaUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" upper
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "LANL" 14 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves") ///
subtitle("after 2020-12-01, with uncertainty", size(small))

graph save "graph 34 COVID-19 total deaths, Iran, reference scenarios, 2020-12-01 on, CI.gph", replace
graph export "graph 34 COVID-19 total deaths, Iran, reference scenarios, 2020-12-01 on, CI.pdf", replace




*****************

* total cases (graph numbers start with 41)


****
* total cases, median or reference scenario

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotCasMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCasMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 41 COVID-19 total cases, Iran, reference scenarios.gph", replace
graph export "graph 41 COVID-19 total cases, Iran, reference scenarios.pdf", replace



****
* total cases, median or reference scenario, 2020-12-01 on

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotCasMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCasMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("after 2020-12-01", size(small))

graph save "graph 43 COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on.gph", replace
graph export "graph 43 COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on.pdf", replace



****
* total cases, median or reference scenario, 2020-12-01 on, CI

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 JOHN
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP"
(line TotCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP"
(line TotCasMeRaA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line TotCasLoRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotCasUpRaA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line TotCasMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line TotCasLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line TotCasUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line TotCasMeRaA04S00 date, sort lcolor(gold)) /// 11 LANL mean
(line TotCasLoRaA04S00 date, sort lcolor(gold)  lpattern(dash)) /// 12 LANL lower
(line TotCasUpRaA04S00 date, sort lcolor(gold)  lpattern(dash)) /// 13 LANL upper
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 14 "SRIV" mean
(line TotCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 15 "SRIV" lower
(line TotCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" upper
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "LANL" 14 "SRIV") size(small) row(1)) ///
note("Uncertainty limits: dashed curves") ///
subtitle("after 2020-12-01, with uncertainty", size(small))

graph save "graph 45 COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on, CI.gph", replace
graph export "graph 45 COVID-19 total cases, Iran, reference scenarios, 2020-12-01 on, CI.pdf", replace



****************

* daily cfr (graph numbers start with 51)


****
* cfr all studies, all time, reference scenarios

twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCfrMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCfrMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCfrMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCfrMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCfrMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 51 COVID-19 daily CFR, Iran, reference scenarios.gph", replace
graph export "graph 51 COVID-19 daily CFR, Iran, reference scenarios.pdf", replace



****
* cfr all studies, 2021-01-01 on, reference scenarios

twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCfrMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCfrMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCfrMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCfrMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCfrMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("after 2021-01-01", size(small))

graph save "graph 52 COVID-19 daily CFR, Iran, reference scenarios, 2021-01-01 on.gph", replace
graph export "graph 52 COVID-19 daily CFR, Iran, reference scenarios,2021-01-01 on.pdf", replace





************************

* other outcomes (graph numbers start with 71)


* base codes with IHME and IMPE, all hospital-related outcomes

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red)  lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayBedMeSmA02S01 date, sort lcolor(black)) /// 3 IHME Bed need (Daily Beds needed Mean IHME S1)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 4 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 5 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayIcnMeSmA02S01 date, sort lcolor(blue)) /// 6 IHME ICU new (Daily new people going to ICU Mean IHME S1)
(line DayHodMeRaA03S01 date, sort lcolor(magenta)) /// 7 IMPE Hosp demand (Daily hospital demand Mean A03 S01 )
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 8 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, median scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME Bed need" 4 "IHME ICU need" ///
5 "IHME Admissions" 6 "IHME ICU new" 7 "IMPE Hosp demand" ///
8 "IMPE ICU demand") rows(4) size(small)) ///
subtitle("  .", size(small) color(white))

graph save "graph 71 COVID-19 hospital-related outcomes.gph", replace
graph export "graph 71 COVID-19 hospital-related outcomes.pdf", replace



****
* daily hospital-related outcomes, DELP, IHME, IMPE, wo IHME Bed need, IMPE Hosp demand

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red)  lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 3 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 4 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayIcnMeSmA02S01 date, sort lcolor(blue)) /// 5 IHME ICU new (Daily new people going to ICU Mean IHME S1)
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 6 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, median scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME ICU need" ///
4 "IHME Admissions" 5 "IHME ICU new" 6 "IMPE ICU demand") rows(3) size(small)) ///
subtitle("after 2021-01-01, without IHME Bed need, IMPE Hosp demand", size(small))

graph save "graph 73 COVID-19 hospital-related outcomes, wo extremes, 2020-12-01 on.gph", replace
graph export "graph 73 COVID-19 hospital-related outcomes, wo extremes, 2020-12-01 on.pdf", replace



****
* daily hospital-related outcomes, DELP, IHME, IMPE, wo IHME Bed need, IMPE Hosp demand, Ordibehesht 1400 on

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red)  lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 3 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 4 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayIcnMeSmA02S01 date, sort lcolor(blue)) /// 5 IHME ICU new (Daily new people going to ICU Mean IHME S1)
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 6 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(#8, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, median scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME ICU need" ///
4 "IHME Admissions" 5 "IHME ICU new" 6 "IMPE ICU demand") rows(3) size(small)) ///
subtitle("after Ordibehesht 1400, without IHME Bed need, IMPE Hosp demand", size(small))

graph save "graph 74 COVID-19 hospital-related outcomes, wo extremes, Ordibehesht 1400 on.gph", replace
graph export "graph 74 COVID-19 hospital-related outcomes, wo extremes, Ordibehesht 1400 on.pdf", replace




*******************************

* daily cases to deaths (CTD) 


****
* Daily cases to deaths (CTD) all studies, all time, reference scenarios

twoway ///
(line DayCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCTDMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCTDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCTDMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCTDMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases to deaths) title("COVID-19 daily cases to deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 81 COVID-19 daily cases to deaths, Iran, reference scenarios.gph", replace
graph export "graph 81 COVID-19 daily cases to deaths, Iran, reference scenarios.pdf", replace



****
* Daily cases to deaths (CTD) all studies, 2021-01-01 on, reference scenarios

twoway ///
(line DayCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCTDMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCTDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCTDMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCTDMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases to deaths) title("COVID-19 daily cases to deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("after 2021-01-01", size(small))

graph save "graph 82 COVID-19 daily cases to deaths, Iran, reference scenarios, 2021-01-01 on.gph", replace
graph export "graph 82 COVID-19 daily cases to deaths, Iran, reference scenarios, 2021-01-01 on.pdf", replace



* Daily cases to deaths (CTD) all studies, Ordibehesht 1400 on, 3 scenarios

twoway ///
(line DayCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCTDMeRaA02S02 date, sort lcolor(black)) /// 3 "IHME" S2 reference 
(line DayCTDMeRaA02S01 date, sort lcolor(black*.2) lpattern(dash)) /// 4 "IHME" S1 better 
(line DayCTDMeRaA02S03 date, sort lcolor(black*.2) lpattern(dash)) /// 5 "IHME" S3 worse
(line DayCTDMeRaA03S02 date, sort lcolor(magenta)) /// 6 "IMPE" S2 reference
(line DayCTDMeRaA03S01 date, sort lcolor(magenta*.2) lpattern(dash)) /// 7 "IMPE" S1 better
(line DayCTDMeRaA03S03 date, sort lcolor(magenta*.2) lpattern(dash)) /// 8 "IMPE" S3 worse
(line DayCTDMeRaA04S00 date, sort lcolor(gold)) /// 9 "LANL"
(line DayCTDMeRaA05S00 date, sort lcolor(green)) /// 10 "SRIV"
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases to deaths) title("COVID-19 daily cases to deaths, Iran, 3 scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 6 "IMPE" 9 "LANL" 10 "SRIV") size(small) row(1)) ///
note("Current scenarios: solid curves. Best and worst scenarios: dashed curves") ///
subtitle("after Ordibehesht 1400, 3 scenarios", size(small))

graph save "graph 83 COVID-19 daily cases to deaths, Iran, 3 scenarios, Ordibehesht 1400 on.gph", replace
graph export "graph 83 COVID-19 daily cases to deaths, Iran, 3 scenarios, Ordibehesht 1400 on.pdf", replace



****
* Total cases to deaths (CTD) all studies, all time, reference scenarios

twoway ///
(line TotCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotCTDMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotCTDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCTDMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCTDMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases to deaths) title("COVID-19 total cases to deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 84 COVID-19 total cases to deaths, Iran, reference scenarios.gph", replace
graph export "graph 84 COVID-19 total cases to deaths, Iran, reference scenarios.pdf", replace



****
* Total cases to deaths (CTD) all studies, Ordibehesht 1400 on, reference scenarios

twoway ///
(line TotCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotCTDMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotCTDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCTDMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCTDMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases to deaths) title("COVID-19 total cases to deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("after Ordibehesht 1400", size(small))

graph save "graph 85 COVID-19 total cases to deaths, Iran, reference scenarios, Ordibehesht 1400 on.gph", replace
graph export "graph 85 COVID-19 total cases to deaths, Iran, reference scenarios, Ordibehesht 1400 on.pdf", replace




*******************************

*  estimated to reported (graph numbers start with 91)


* daily deaths estimated to reported  


****
* daily deaths estimated to reported (DER) all studies, all time, reference scenarios

twoway ///
(line DayDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths estimated to reported) title("COVID-19 daily deaths estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 91 COVID-19 daily deaths estimated to reported, Iran, reference scenarios.gph", replace
graph export "graph 91 COVID-19 daily deaths estimated to reported, Iran, reference scenarios.pdf", replace



****
* daily deaths estimated to reported (DER) all studies, 2021-01-01 on, reference scenarios

twoway ///
(line DayDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths estimated to reported) title("COVID-19 daily deaths estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 92 COVID-19 daily deaths estimated to reported, Iran, reference scenarios, 2021-01-01 on.gph", replace
graph export "graph 92 COVID-19 daily deaths estimated to reported, Iran, reference scenarios, 2021-01-01 on.pdf", replace



* daily cases estimated to reported  


****
* daily cases estimated to reported (CER) all studies, all time, reference scenarios

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases estimated to reported) title("COVID-19 daily cases estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 93 COVID-19 daily cases estimated to reported, Iran, reference scenarios.gph", replace
graph export "graph 93 COVID-19 daily cases estimated to reported, Iran, reference scenarios.pdf", replace



****
* daily cases estimated to reported (CER) all studies, 2021-01-01 on, reference scenarios

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases estimated to reported) title("COVID-19 daily cases estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 94 COVID-19 daily cases estimated to reported, Iran, reference scenarios, 2021-01-01 on.gph", replace
graph export "graph 94 COVID-19 daily cases estimated to reported, Iran, reference scenarios, 2021-01-01 on.pdf", replace



****
* total deaths estimated to reported (DER) all studies, all time, reference scenarios

twoway ///
(line TotDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN
(line TotDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotDERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths estimated to reported) title("COVID-19 total deaths estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 95 COVID-19 total deaths estimated to reported, Iran, reference scenarios.gph", replace
graph export "graph 95 COVID-19 total deaths estimated to reported, Iran, reference scenarios.pdf", replace



****
* total deaths estimated to reported (DER) all studies, 2021-01-01 on, reference scenarios

twoway ///
(line TotDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN
(line TotDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotDERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths estimated to reported) title("COVID-19 total deaths estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 96 COVID-19 total deaths estimated to reported, Iran, reference scenarios, 2021-01-01 on.gph", replace
graph export "graph 96 COVID-19 total deaths estimated to reported, Iran, reference scenarios, 2021-01-01 on.pdf", replace



****
* total cases estimated to reported (CER) all studies, all time, reference scenarios

twoway ///
(line TotCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotCERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotCERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases estimated to reported) title("COVID-19 total cases estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 97 COVID-19 total cases estimated to reported, Iran, reference scenarios.gph", replace
graph export "graph 97 COVID-19 total cases estimated to reported, Iran, reference scenarios.pdf", replace



****
* total cases estimated to reported (CER) all studies, 2021-01-01 on, reference scenarios

twoway ///
(line TotCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotCERMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotCERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCERMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCERMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases estimated to reported) title("COVID-19 total cases estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 98 COVID-19 total cases estimated to reported, Iran, reference scenarios, 2021-01-01 on.gph", replace
graph export "graph 98 COVID-19 total cases estimated to reported, Iran, reference scenarios, 2021-01-01 on.pdf", replace

***









************

* restore native scheme (of the local machine)

set scheme $nativescheme

di c(scheme)


view "log Iran merge.smcl"

log close

exit, clear




