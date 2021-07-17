
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
LANL A04
SRIV A05

*/



* read JOHN from latest uptake


qui {

cd "$pathcovir2" // "/Users/`usrnam'/Downloads/covir2-main/longitudinal/20210709/code"

cd .. // 20210709

cd .. // longitudinal

cd .. //  covir2-main

cd 20210709

cd output

cd merge

use "country.dta", clear 

keep date loc_grand_name DayDeaMeRaA00S00 DayDeaMeSmA00S00 TotDeaMeRaA00S00 DayCasMeRaA00S00 DayCasMeSmA00S00 TotCasMeRaA00S00

sort date loc_grand_name

cd .. // output

cd .. // 20210709

cd .. //  covir2-main

cd longitudinal 

cd 20210709

cd code

cd merge

save "JOHN.dta", replace


}
*


* read each study

local studylist DELP IHME IMPE LANL SRIV

foreach l of local studylist {

cd .. // code

cd `l'

use "country `l'.dta", clear 

cd .. // code

cd merge

save "country `l'.dta", replace


}
*


use "JOHN.dta", clear 


foreach l of local studylist {

merge m:m date loc_grand_name using "country `l'.dta"

drop _merge

}
*


* IHME correction factor for under-reporting of deaths in Iran = 2.4.

gen DayDeaMeSmA00S002p4 = DayDeaMeSmA00S00 * 2.4 

gen TotDeaMeRaA00S002p4 = TotDeaMeRaA00S00 * 2.4



save "country merge.dta", replace






**********************************************************

* graphs


grstyle init

grstyle color background white




* daily deaths

**************************************

* daily deaths, Absolute value

twoway  ///
(line DayDeaMeRaA01S00U20210401 date, sort lcolor(red)) /// 1 "DELP"
(line DayDeaMeRaA01S00U20210406 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210409 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210416 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210417 date, sort lcolor(red)) /// 5
(line DayDeaMeRaA01S00U20210423 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210424 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210506 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210514 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210515 date, sort lcolor(red)) /// 10
(line DayDeaMeRaA01S00U20210516 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210521 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210522 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210528 date, sort lcolor(red)) /// greatest extreme, i.e., DELP 20210528
(line DayDeaMeRaA01S00U20210603 date, sort lcolor(red)) /// 15 
(line DayDeaMeRaA01S00U20210604 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210605 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210610 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210611 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210618 date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210624 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210625 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210703 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210704 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210709 date, sort lcolor(red)) /// 25
(line DayDeaMeSmA02S01U20210401 date, sort lcolor(black) lpattern(dash)) /// 26 IHME
(line DayDeaMeSmA02S01U20210406 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210409 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210416 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210417 date, sort lcolor(black) lpattern(dash)) /// 30
(line DayDeaMeSmA02S01U20210423 date, sort lcolor(black) lpattern(dash)) /// 
(line DayDeaMeSmA02S01U20210424 date, sort lcolor(black) lpattern(dash)) /// 32 IHME v3
(line DayDeaMeSmA02S01U20210506 date, sort lcolor(black)) /// 33 IHME v4 
(line DayDeaMeSmA02S01U20210514 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210515 date, sort lcolor(black)) /// 35
(line DayDeaMeSmA02S01U20210516 date, sort lcolor(black)) ///  
(line DayDeaMeSmA02S01U20210521 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210522 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210528 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210603 date, sort lcolor(black)) /// 40
(line DayDeaMeSmA02S01U20210604 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210605 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210610 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210611 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210618 date, sort lcolor(black)) /// 45
(line DayDeaMeSmA02S01U20210624 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210625 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210703 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210704 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210709 date, sort lcolor(black)) /// 50
(line DayDeaMeRaA03S02U20210401 date, sort lcolor(magenta) lpattern(dash)) /// 51 IMPE
(line DayDeaMeRaA03S02U20210406 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210409 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210416 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210417 date, sort lcolor(magenta) lpattern(dash)) /// 55
(line DayDeaMeRaA03S02U20210423 date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210424 date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210506 date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210514 date, sort lcolor(magenta) lpattern(dash)) /// 59  IMPE v7
(line DayDeaMeRaA03S02U20210515 date, sort lcolor(magenta)) /// 60 IMPE v8 
(line DayDeaMeRaA03S02U20210516 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210521 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210522 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210528 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210603 date, sort lcolor(magenta)) /// 65
(line DayDeaMeRaA03S02U20210604 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210605 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210610 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210611 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210618 date, sort lcolor(magenta)) /// 70
(line DayDeaMeRaA03S02U20210624 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210625 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210703 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210704 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210709 date, sort lcolor(magenta)) /// 75
(line DayDeaMeSmA04S00U20210401 date, sort lcolor(gold)) /// 76 "LANL"
(line DayDeaMeSmA04S00U20210406 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210409 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210416 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210417 date, sort lcolor(gold)) /// 80 
(line DayDeaMeSmA04S00U20210423 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210424 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210506 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210514 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210515 date, sort lcolor(gold)) /// 85
(line DayDeaMeSmA04S00U20210516 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210521 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210522 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210528 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210603 date, sort lcolor(gold)) /// 90
(line DayDeaMeSmA04S00U20210604 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210605 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210610 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210611 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210618 date, sort lcolor(gold)) /// 95
(line DayDeaMeSmA04S00U20210624 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210625 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210703 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210704 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210709 date, sort lcolor(gold)) /// 100
(line DayDeaMeSmA05S00U20210401 date, sort lcolor(green)) /// 101 "SRIV"
(line DayDeaMeSmA05S00U20210406 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210409 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210416 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210417 date, sort lcolor(green)) /// 105 
(line DayDeaMeSmA05S00U20210423 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210424 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210506 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210514 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210515 date, sort lcolor(green)) /// 110
(line DayDeaMeSmA05S00U20210516 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210521 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210522 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210528 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210603 date, sort lcolor(green)) /// 115
(line DayDeaMeSmA05S00U20210604 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210605 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210610 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210611 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210618 date, sort lcolor(green)) /// 120
(line DayDeaMeSmA05S00U20210624 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210625 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210703 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210704 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210709 date, sort lcolor(green)) /// 125
(line DayDeaMeSmA00S00 date, lcolor(cyan*1.2) lwidth(vthick)) /// 126
if date >= td(01apr2021), ///	   
xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09" ///
"with the greatest extreme estimate, i.e., DELP 20210528", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 33 "IHME" 60 "IMPE" 76 "LANL" 101 "SRIV" 126 "JOHN") size(small) rows(1))	///
note("Note: Dashed magenta curves denote estimates from model version 7 of IMPE.", size(small))

qui graph save "graph 11a COVID-19 daily deaths, $country.gph", replace
qui graph export "graph 11a COVID-19 daily deaths, $country.pdf", replace	
  	   
	   



* daily deaths, Absolute value, wo greatest extreme, i.e., DELP 20210528

twoway  ///
(line DayDeaMeRaA01S00U20210401 date, sort lcolor(red)) /// 1 "DELP"
(line DayDeaMeRaA01S00U20210406 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210409 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210416 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210417 date, sort lcolor(red)) /// 5
(line DayDeaMeRaA01S00U20210423 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210424 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210506 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210514 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210515 date, sort lcolor(red)) /// 10
(line DayDeaMeRaA01S00U20210516 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210521 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210522 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210603 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210604 date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20210605 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210610 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210611 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210618 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210624 date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210625 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210703 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210704 date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210709 date, sort lcolor(red)) /// 24
(line DayDeaMeSmA02S01U20210401 date, sort lcolor(black) lpattern(dash)) /// 25 IHME
(line DayDeaMeSmA02S01U20210406 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210409 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210416 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210417 date, sort lcolor(black) lpattern(dash)) /// 
(line DayDeaMeSmA02S01U20210423 date, sort lcolor(black) lpattern(dash)) /// 30
(line DayDeaMeSmA02S01U20210424 date, sort lcolor(black) lpattern(dash)) /// IHME v3
(line DayDeaMeSmA02S01U20210506 date, sort lcolor(black)) /// IHME v4 // 32 "IHME"
(line DayDeaMeSmA02S01U20210514 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210515 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210516 date, sort lcolor(black)) /// 35 
(line DayDeaMeSmA02S01U20210521 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210522 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210528 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210603 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210604 date, sort lcolor(black)) /// 40
(line DayDeaMeSmA02S01U20210605 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210610 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210611 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210618 date, sort lcolor(black)) /// 44
(line DayDeaMeSmA02S01U20210624 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210625 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210703 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210704 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210709 date, sort lcolor(black)) /// 49
(line DayDeaMeRaA03S02U20210401 date, sort lcolor(magenta) lpattern(dash)) /// 50 IMPE
(line DayDeaMeRaA03S02U20210406 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210409 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210416 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210417 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210423 date, sort lcolor(magenta) lpattern(dash)) /// 55
(line DayDeaMeRaA03S02U20210424 date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210506 date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210514 date, sort lcolor(magenta) lpattern(dash)) /// 58  IMPE v7
(line DayDeaMeRaA03S02U20210515 date, sort lcolor(magenta)) /// 59 IMPE v8 // 59 "IMPE"
(line DayDeaMeRaA03S02U20210516 date, sort lcolor(magenta)) /// 60
(line DayDeaMeRaA03S02U20210521 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210522 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210528 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210603 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210604 date, sort lcolor(magenta)) /// 65
(line DayDeaMeRaA03S02U20210605 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210610 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210611 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210618 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210624 date, sort lcolor(magenta)) /// 70
(line DayDeaMeRaA03S02U20210625 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210703 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210704 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210709 date, sort lcolor(magenta)) /// 74
(line DayDeaMeSmA04S00U20210401 date, sort lcolor(gold)) /// 75 "LANL"
(line DayDeaMeSmA04S00U20210406 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210409 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210416 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210417 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210423 date, sort lcolor(gold)) /// 80
(line DayDeaMeSmA04S00U20210424 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210506 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210514 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210515 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210516 date, sort lcolor(gold)) /// 85
(line DayDeaMeSmA04S00U20210521 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210522 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210528 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210603 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210604 date, sort lcolor(gold)) /// 90
(line DayDeaMeSmA04S00U20210605 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210610 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210611 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210618 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210624 date, sort lcolor(gold)) /// 95
(line DayDeaMeSmA04S00U20210625 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210703 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210704 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210709 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA05S00U20210401 date, sort lcolor(green)) /// 100 "SRIV"
(line DayDeaMeSmA05S00U20210406 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210409 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210416 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210417 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210423 date, sort lcolor(green)) /// 105
(line DayDeaMeSmA05S00U20210424 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210506 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210514 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210515 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210516 date, sort lcolor(green)) /// 110
(line DayDeaMeSmA05S00U20210521 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210522 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210528 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210603 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210604 date, sort lcolor(green)) /// 115
(line DayDeaMeSmA05S00U20210605 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210610 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210611 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210618 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210624 date, sort lcolor(green)) /// 120
(line DayDeaMeSmA05S00U20210625 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210703 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210704 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210709 date, sort lcolor(green)) /// 
(line DayDeaMeSmA00S00 date, lcolor(cyan*1.2) lwidth(vthick)) /// 125
if date >= td(01apr2021), ///	   
xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09" ///
"without the greatest extreme estimate, i.e., DELP 20210528", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 32 "IHME" 59 "IMPE" 75 "LANL" 100 "SRIV" 125 "JOHN") size(small) rows(1))	///
note("Note: Dashed magenta curves denote estimates from model version 7 of IMPE," ///
"and dashed black curves denote estimates from model version 3 of IHME.", size(small))	
  	   
qui graph save "graph 11b COVID-19 daily deaths, $country.gph", replace
qui graph export "graph 11b COVID-19 daily deaths, $country.pdf", replace





************

* daily deaths, Absolute value, wo extremes


/*

impe extremes:

(line DayDeaMeRaA03S02U20210406 date, sort lcolor(red) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210409 date, sort lcolor(red) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210416 date, sort lcolor(red) lpattern(dash)) ///  
(line DayDeaMeRaA03S02U20210417 date, sort lcolor(red) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210423 date, sort lcolor(red) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210424 date, sort lcolor(red) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210506 date, sort lcolor(red) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210514 date, sort lcolor(red) lpattern(dash)) /// 

sriv extremes:

(line DayDeaMeSmA05S00U20210409 date, sort lcolor(red)) ///
(line DayDeaMeSmA05S00U20210416 date, sort lcolor(red)) ///
(line DayDeaMeSmA05S00U20210417 date, sort lcolor(red)) /// 

*/


twoway  ///
(line DayDeaMeRaA01S00U20210401 date, sort lcolor(red)) /// 1 "DELP"
(line DayDeaMeRaA01S00U20210406 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210409 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210416 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210417 date, sort lcolor(red)) /// 5
(line DayDeaMeRaA01S00U20210423 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210424 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210506 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210514 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210515 date, sort lcolor(red)) /// 10
(line DayDeaMeRaA01S00U20210516 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210521 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210522 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210603 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210604 date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20210605 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210610 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210611 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210618 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210624 date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210625 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210703 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210704 date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210709 date, sort lcolor(red)) /// 
(line DayDeaMeSmA02S01U20210401 date, sort lcolor(black) lpattern(dash)) /// 25 IHME
(line DayDeaMeSmA02S01U20210406 date, sort lcolor(black) lpattern(dash)) /// 
(line DayDeaMeSmA02S01U20210409 date, sort lcolor(black) lpattern(dash)) /// 
(line DayDeaMeSmA02S01U20210416 date, sort lcolor(black) lpattern(dash)) /// 
(line DayDeaMeSmA02S01U20210417 date, sort lcolor(black) lpattern(dash)) /// 
(line DayDeaMeSmA02S01U20210423 date, sort lcolor(black) lpattern(dash)) /// 30
(line DayDeaMeSmA02S01U20210424 date, sort lcolor(black) lpattern(dash)) /// 31 IHME v3
(line DayDeaMeSmA02S01U20210506 date, sort lcolor(black)) /// 32 IHME v4 
(line DayDeaMeSmA02S01U20210514 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210515 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210516 date, sort lcolor(black)) /// 35 
(line DayDeaMeSmA02S01U20210521 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210522 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210528 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210603 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210604 date, sort lcolor(black)) /// 40
(line DayDeaMeSmA02S01U20210605 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210610 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210611 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210618 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210624 date, sort lcolor(black)) /// 45
(line DayDeaMeSmA02S01U20210625 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210703 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210704 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210709 date, sort lcolor(black)) /// 
(line DayDeaMeRaA03S02U20210515 date, sort lcolor(magenta)) /// 50 IMPE v8 
(line DayDeaMeRaA03S02U20210516 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210521 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210522 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210528 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210603 date, sort lcolor(magenta)) /// 55
(line DayDeaMeRaA03S02U20210604 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210605 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210610 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210611 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210618 date, sort lcolor(magenta)) /// 60
(line DayDeaMeRaA03S02U20210624 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210625 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210703 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210704 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210709 date, sort lcolor(magenta)) /// 65
(line DayDeaMeSmA04S00U20210401 date, sort lcolor(gold)) /// 66 "LANL"
(line DayDeaMeSmA04S00U20210406 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210409 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210416 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210417 date, sort lcolor(gold)) /// 70 
(line DayDeaMeSmA04S00U20210423 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210424 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210506 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210514 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210515 date, sort lcolor(gold)) /// 75
(line DayDeaMeSmA04S00U20210516 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210521 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210522 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210528 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210603 date, sort lcolor(gold)) /// 80
(line DayDeaMeSmA04S00U20210604 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210605 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210610 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210611 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210618 date, sort lcolor(gold)) /// 85
(line DayDeaMeSmA04S00U20210624 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210625 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210703 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210704 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210709 date, sort lcolor(gold)) /// 90
(line DayDeaMeSmA05S00U20210401 date, sort lcolor(green)) /// 91 "SRIV"
(line DayDeaMeSmA05S00U20210406 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210423 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210424 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210506 date, sort lcolor(green)) /// 95
(line DayDeaMeSmA05S00U20210514 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210515 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210516 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210521 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210522 date, sort lcolor(green)) /// 100
(line DayDeaMeSmA05S00U20210528 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210603 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210604 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210605 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210610 date, sort lcolor(green)) /// 105
(line DayDeaMeSmA05S00U20210611 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210618 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210624 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210625 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210703 date, sort lcolor(green)) /// 110
(line DayDeaMeSmA05S00U20210704 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210709 date, sort lcolor(green)) /// 
(line DayDeaMeSmA00S00 date, lcolor(cyan*1.2) lwidth(vthick)) /// 113
(line DayDeaMeSmA00S002p4 date, lcolor(cyan*1.2) lwidth(vthick) lpattern(dash)) /// 114
if date >= td(01apr2021), ///	   
xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09" ///
"without extremes", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 32 "IHME" 50 "IMPE" 66 "LANL" 91 "SRIV" 113 "JOHN" 114 "JOHN*2.4") size(small) rows(1)) ///		
note("Note: Dashed black curves denote estimates from model version 3 of IHME." ///
"IHME estimate of correction factor for under-reporting of COVID-19 deaths in Iran = 2.4", size(small))	
  	   
qui graph save "graph 11c COVID-19 daily deaths, $country, wo extremes.gph", replace
qui graph export "graph 11c COVID-19 daily deaths, $country, wo extremes.pdf", replace






*************

* daily deaths, minus JOHN

twoway  ///
(line DayDeaMeRaA01S00U20210401D date, sort lcolor(red)) /// 1 "DELP"
(line DayDeaMeRaA01S00U20210406D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210409D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210416D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210417D date, sort lcolor(red)) /// 5
(line DayDeaMeRaA01S00U20210423D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210424D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210506D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210514D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210515D date, sort lcolor(red)) /// 10
(line DayDeaMeRaA01S00U20210516D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210521D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210522D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210528D date, sort lcolor(red)) /// greatest extreme, i.e., DELP 20210528
(line DayDeaMeRaA01S00U20210603D date, sort lcolor(red)) /// 15 
(line DayDeaMeRaA01S00U20210604D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210605D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210610D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210611D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210618D date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210624D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210625D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210703D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210704D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210709D date, sort lcolor(red)) /// 25
(line DayDeaMeSmA02S01U20210401D date, sort lcolor(black) lpattern(dash)) /// 26 IHME
(line DayDeaMeSmA02S01U20210406D date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210409D date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210416D date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210417D date, sort lcolor(black) lpattern(dash)) /// 30
(line DayDeaMeSmA02S01U20210423D date, sort lcolor(black) lpattern(dash)) /// 
(line DayDeaMeSmA02S01U20210424D date, sort lcolor(black) lpattern(dash)) /// 32 IHME v3
(line DayDeaMeSmA02S01U20210506D date, sort lcolor(black)) /// 33 IHME v4 
(line DayDeaMeSmA02S01U20210514D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210515D date, sort lcolor(black)) /// 35
(line DayDeaMeSmA02S01U20210516D date, sort lcolor(black)) ///  
(line DayDeaMeSmA02S01U20210521D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210522D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210528D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210603D date, sort lcolor(black)) /// 40
(line DayDeaMeSmA02S01U20210604D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210605D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210610D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210611D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210618D date, sort lcolor(black)) /// 45
(line DayDeaMeSmA02S01U20210624D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210625D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210703D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210704D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210709D date, sort lcolor(black)) /// 50
(line DayDeaMeRaA03S02U20210401D date, sort lcolor(magenta) lpattern(dash)) /// 51 IMPE
(line DayDeaMeRaA03S02U20210406D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210409D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210416D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210417D date, sort lcolor(magenta) lpattern(dash)) /// 55
(line DayDeaMeRaA03S02U20210423D date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210424D date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210506D date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210514D date, sort lcolor(magenta) lpattern(dash)) /// 59  IMPE v7
(line DayDeaMeRaA03S02U20210515D date, sort lcolor(magenta)) /// 60 IMPE v8 
(line DayDeaMeRaA03S02U20210516D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210521D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210522D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210528D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210603D date, sort lcolor(magenta)) /// 65
(line DayDeaMeRaA03S02U20210604D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210605D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210610D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210611D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210618D date, sort lcolor(magenta)) /// 70
(line DayDeaMeRaA03S02U20210624D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210625D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210703D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210704D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210709D date, sort lcolor(magenta)) /// 75
(line DayDeaMeSmA04S00U20210401D date, sort lcolor(gold)) /// 76 "LANL"
(line DayDeaMeSmA04S00U20210406D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210409D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210416D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210417D date, sort lcolor(gold)) /// 80 
(line DayDeaMeSmA04S00U20210423D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210424D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210506D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210514D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210515D date, sort lcolor(gold)) /// 85
(line DayDeaMeSmA04S00U20210516D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210521D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210522D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210528D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210603D date, sort lcolor(gold)) /// 90
(line DayDeaMeSmA04S00U20210604D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210605D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210610D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210611D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210618D date, sort lcolor(gold)) /// 95
(line DayDeaMeSmA04S00U20210624D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210625D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210703D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210704D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210709D date, sort lcolor(gold)) /// 100
(line DayDeaMeSmA05S00U20210401D date, sort lcolor(green)) /// 101 "SRIV"
(line DayDeaMeSmA05S00U20210406D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210409D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210416D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210417D date, sort lcolor(green)) /// 105 
(line DayDeaMeSmA05S00U20210423D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210424D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210506D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210514D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210515D date, sort lcolor(green)) /// 110
(line DayDeaMeSmA05S00U20210516D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210521D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210522D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210528D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210603D date, sort lcolor(green)) /// 115
(line DayDeaMeSmA05S00U20210604D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210605D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210610D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210611D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210618D date, sort lcolor(green)) /// 120
(line DayDeaMeSmA05S00U20210624D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210625D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210703D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210704D date, sort lcolor(green)) /// 124
if date >= td(01apr2021) & date <= td(01aug2021), ///	   
xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths minus JOHN) title("COVID-19 daily deaths minus JOHN, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09" ///
"with greatest extreme, i.e., DELP 20210528", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 33 "IHME" 60 "IMPE" 76 "LANL" 101 "SRIV") size(small) rows(1)) ///		
note("Note: Dashed magenta curves denote estimates from model version 7 of IMPE." ///
"Dashed black curves denote estimates from model version 3 of IHME.", size(small))	
  	   
qui graph save "graph 12a COVID-19 daily deaths, $country, minus.gph", replace
qui graph export "graph 12a COVID-19 daily deaths, $country, minus.pdf", replace





*********

* daily deaths, minus JOHN, wo greatest extreme, i.e., DELP 20210528

twoway  ///
(line DayDeaMeRaA01S00U20210401D date, sort lcolor(red)) /// 1 "DELP"
(line DayDeaMeRaA01S00U20210406D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210409D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210416D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210417D date, sort lcolor(red)) /// 5
(line DayDeaMeRaA01S00U20210423D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210424D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210506D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210514D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210515D date, sort lcolor(red)) /// 10
(line DayDeaMeRaA01S00U20210516D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210521D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210522D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210603D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210604D date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20210605D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210610D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210611D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210618D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210624D date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210625D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210703D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210704D date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210709D date, sort lcolor(red)) /// 24
(line DayDeaMeSmA02S01U20210401D date, sort lcolor(black) lpattern(dash)) /// 25 IHME
(line DayDeaMeSmA02S01U20210406D date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210409D date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210416D date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210417D date, sort lcolor(black) lpattern(dash)) /// 
(line DayDeaMeSmA02S01U20210423D date, sort lcolor(black) lpattern(dash)) /// 30
(line DayDeaMeSmA02S01U20210424D date, sort lcolor(black) lpattern(dash)) /// IHME v3
(line DayDeaMeSmA02S01U20210506D date, sort lcolor(black)) /// IHME v4 // 32 "IHME"
(line DayDeaMeSmA02S01U20210514D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210515D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210516D date, sort lcolor(black)) /// 35 
(line DayDeaMeSmA02S01U20210521D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210522D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210528D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210603D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210604D date, sort lcolor(black)) /// 40
(line DayDeaMeSmA02S01U20210605D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210610D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210611D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210618D date, sort lcolor(black)) /// 44
(line DayDeaMeSmA02S01U20210624D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210625D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210703D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210704D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210709D date, sort lcolor(black)) /// 49
(line DayDeaMeRaA03S02U20210401D date, sort lcolor(magenta) lpattern(dash)) /// 50 IMPE
(line DayDeaMeRaA03S02U20210406D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210409D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210416D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210417D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210423D date, sort lcolor(magenta) lpattern(dash)) /// 55
(line DayDeaMeRaA03S02U20210424D date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210506D date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210514D date, sort lcolor(magenta) lpattern(dash)) /// 58  IMPE v7
(line DayDeaMeRaA03S02U20210515D date, sort lcolor(magenta)) /// 59 IMPE v8 // 59 "IMPE"
(line DayDeaMeRaA03S02U20210516D date, sort lcolor(magenta)) /// 60
(line DayDeaMeRaA03S02U20210521D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210522D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210528D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210603D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210604D date, sort lcolor(magenta)) /// 65
(line DayDeaMeRaA03S02U20210605D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210610D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210611D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210618D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210624D date, sort lcolor(magenta)) /// 70
(line DayDeaMeRaA03S02U20210625D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210703D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210704D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210709D date, sort lcolor(magenta)) /// 74
(line DayDeaMeSmA04S00U20210401D date, sort lcolor(gold)) /// 75 "LANL"
(line DayDeaMeSmA04S00U20210406D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210409D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210416D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210417D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210423D date, sort lcolor(gold)) /// 80
(line DayDeaMeSmA04S00U20210424D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210506D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210514D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210515D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210516D date, sort lcolor(gold)) /// 85
(line DayDeaMeSmA04S00U20210521D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210522D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210528D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210603D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210604D date, sort lcolor(gold)) /// 90
(line DayDeaMeSmA04S00U20210605D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210610D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210611D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210618D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210624D date, sort lcolor(gold)) /// 95
(line DayDeaMeSmA04S00U20210625D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210703D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210704D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210709D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA05S00U20210401D date, sort lcolor(green)) /// 100 "SRIV"
(line DayDeaMeSmA05S00U20210406D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210409D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210416D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210417D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210423D date, sort lcolor(green)) /// 105
(line DayDeaMeSmA05S00U20210424D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210506D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210514D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210515D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210516D date, sort lcolor(green)) /// 110
(line DayDeaMeSmA05S00U20210521D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210522D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210528D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210603D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210604D date, sort lcolor(green)) /// 115
(line DayDeaMeSmA05S00U20210605D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210610D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210611D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210618D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210624D date, sort lcolor(green)) /// 120
(line DayDeaMeSmA05S00U20210625D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210703D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210704D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210709D date, sort lcolor(green)) /// 
if date >= td(01apr2021) & date <= td(01aug2021), ///	   
xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths minus JOHN) title("COVID-19 daily deaths minus JOHN, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09" ///
"without greatest extreme, i.e., DELP 20210528", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 32 "IHME" 59 "IMPE" 75 "LANL" 100 "SRIV") size(small) rows(1)) ///		
note("Note: Dashed magenta curves denote estimates from model version 7 of IMPE." ///
"Dashed black curves denote estimates from model version 3 of IHME.", size(small))	
  	   
qui graph save "graph 12b COVID-19 daily deaths, $country, wo extremes, minus.gph", replace
qui graph export "graph 12b COVID-19 daily deaths, $country, wo extremes, minus.pdf", replace






*********

* daily deaths, minus JOHN, wo extremes


twoway  ///
(line DayDeaMeRaA01S00U20210401D date, sort lcolor(red)) /// 1 "DELP"
(line DayDeaMeRaA01S00U20210406D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210409D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210416D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210417D date, sort lcolor(red)) /// 5
(line DayDeaMeRaA01S00U20210423D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210424D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210506D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210514D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210515D date, sort lcolor(red)) /// 10
(line DayDeaMeRaA01S00U20210516D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210521D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210522D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210603D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210604D date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20210605D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210610D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210611D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210618D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210624D date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210625D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210703D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210704D date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210709D date, sort lcolor(red)) /// 
(line DayDeaMeSmA02S01U20210401D date, sort lcolor(black) lpattern(dash)) /// 25 IHME
(line DayDeaMeSmA02S01U20210406D date, sort lcolor(black) lpattern(dash)) /// 
(line DayDeaMeSmA02S01U20210409D date, sort lcolor(black) lpattern(dash)) /// 
(line DayDeaMeSmA02S01U20210416D date, sort lcolor(black) lpattern(dash)) /// 
(line DayDeaMeSmA02S01U20210417D date, sort lcolor(black) lpattern(dash)) /// 
(line DayDeaMeSmA02S01U20210423D date, sort lcolor(black) lpattern(dash)) /// 30
(line DayDeaMeSmA02S01U20210424D date, sort lcolor(black) lpattern(dash)) /// 31 IHME v3
(line DayDeaMeSmA02S01U20210506D date, sort lcolor(black)) /// 32 IHME v4 
(line DayDeaMeSmA02S01U20210514D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210515D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210516D date, sort lcolor(black)) /// 35 
(line DayDeaMeSmA02S01U20210521D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210522D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210528D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210603D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210604D date, sort lcolor(black)) /// 40
(line DayDeaMeSmA02S01U20210605D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210610D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210611D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210618D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210624D date, sort lcolor(black)) /// 45
(line DayDeaMeSmA02S01U20210625D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210703D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210704D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210709D date, sort lcolor(black)) /// 
(line DayDeaMeRaA03S02U20210515D date, sort lcolor(magenta)) /// 50 IMPE v8 
(line DayDeaMeRaA03S02U20210516D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210521D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210522D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210528D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210603D date, sort lcolor(magenta)) /// 55
(line DayDeaMeRaA03S02U20210604D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210605D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210610D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210611D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210618D date, sort lcolor(magenta)) /// 60
(line DayDeaMeRaA03S02U20210624D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210625D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210703D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210704D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210709D date, sort lcolor(magenta)) /// 65
(line DayDeaMeSmA04S00U20210401D date, sort lcolor(gold)) /// 66 "LANL"
(line DayDeaMeSmA04S00U20210406D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210409D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210416D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210417D date, sort lcolor(gold)) /// 70 
(line DayDeaMeSmA04S00U20210423D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210424D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210506D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210514D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210515D date, sort lcolor(gold)) /// 75
(line DayDeaMeSmA04S00U20210516D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210521D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210522D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210528D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210603D date, sort lcolor(gold)) /// 80
(line DayDeaMeSmA04S00U20210604D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210605D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210610D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210611D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210618D date, sort lcolor(gold)) /// 85
(line DayDeaMeSmA04S00U20210624D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210625D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210703D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210704D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210709D date, sort lcolor(gold)) /// 90
(line DayDeaMeSmA05S00U20210401D date, sort lcolor(green)) /// 91 "SRIV"
(line DayDeaMeSmA05S00U20210406D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210423D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210424D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210506D date, sort lcolor(green)) /// 95
(line DayDeaMeSmA05S00U20210514D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210515D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210516D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210521D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210522D date, sort lcolor(green)) /// 100
(line DayDeaMeSmA05S00U20210528D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210603D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210604D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210605D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210610D date, sort lcolor(green)) /// 105
(line DayDeaMeSmA05S00U20210611D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210618D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210624D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210625D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210703D date, sort lcolor(green)) /// 110
(line DayDeaMeSmA05S00U20210704D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210709D date, sort lcolor(green)) /// 
if date >= td(01apr2021) & date <= td(01aug2021), ///	   
xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths minus JOHN) title("COVID-19 daily deaths minus JOHN, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09" ///
"without extremes", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 32 "IHME" 50 "IMPE" 66 "LANL" 91 "SRIV") size(small) rows(1)) ///		
note("Note: Dashed magenta curves denote estimates from model version 7 of IMPE." ///
"Dashed black curves denote estimates from model version 3 of IHME.", size(small))	
  	   
qui graph save "graph 12c COVID-19 daily deaths, $country, wo extremes, minus.gph", replace
qui graph export "graph 12c COVID-19 daily deaths, $country, wo extremes, minus.pdf", replace

















* daily cases or infections

**************************************

* daily cases or infections, Absolute value

twoway  ///
(line DayCasMeRaA01S00U20210401 date, sort lcolor(red)) /// 1 "DELP"
(line DayCasMeRaA01S00U20210406 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210409 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210416 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210417 date, sort lcolor(red)) /// 5
(line DayCasMeRaA01S00U20210423 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210424 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210506 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210514 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210515 date, sort lcolor(red)) /// 10
(line DayCasMeRaA01S00U20210516 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210521 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210522 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210528 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210603 date, sort lcolor(red)) /// 15 
(line DayCasMeRaA01S00U20210604 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210605 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210610 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210611 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210618 date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210624 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210625 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210703 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210704 date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210709 date, sort lcolor(red)) /// 25
(line DayINFMeRaA02S01U20210401 date, sort lcolor(black) lpattern(dash)) /// 26 IHME
(line DayINFMeRaA02S01U20210406 date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210409 date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210416 date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210417 date, sort lcolor(black) lpattern(dash)) /// 30
(line DayINFMeRaA02S01U20210423 date, sort lcolor(black) lpattern(dash)) /// 
(line DayINFMeRaA02S01U20210424 date, sort lcolor(black) lpattern(dash)) /// 32 IHME v3
(line DayINFMeRaA02S01U20210506 date, sort lcolor(black)) /// 33 IHME v4 
(line DayINFMeRaA02S01U20210514 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210515 date, sort lcolor(black)) /// 35
(line DayINFMeRaA02S01U20210516 date, sort lcolor(black)) ///  
(line DayINFMeRaA02S01U20210521 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210522 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210528 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210603 date, sort lcolor(black)) /// 40
(line DayINFMeRaA02S01U20210604 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210605 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210610 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210611 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210618 date, sort lcolor(black)) /// 45
(line DayINFMeRaA02S01U20210624 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210625 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210703 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210704 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210709 date, sort lcolor(black)) /// 50
(line DayINFMeRaA03S02U20210401 date, sort lcolor(magenta) lpattern(dash)) /// 51 IMPE
(line DayINFMeRaA03S02U20210406 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210409 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210416 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210417 date, sort lcolor(magenta) lpattern(dash)) /// 55
(line DayINFMeRaA03S02U20210423 date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210424 date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210506 date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210514 date, sort lcolor(magenta) lpattern(dash)) /// 59  IMPE v7
(line DayINFMeRaA03S02U20210515 date, sort lcolor(magenta)) /// 60 IMPE v8 
(line DayINFMeRaA03S02U20210516 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210521 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210522 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210528 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210603 date, sort lcolor(magenta)) /// 65
(line DayINFMeRaA03S02U20210604 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210605 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210610 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210611 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210618 date, sort lcolor(magenta)) /// 70
(line DayINFMeRaA03S02U20210624 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210625 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210703 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210704 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210709 date, sort lcolor(magenta)) /// 75
(line DayCasMeSmA04S00U20210401 date, sort lcolor(gold)) /// 76 "LANL"
(line DayCasMeSmA04S00U20210406 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210409 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210416 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210417 date, sort lcolor(gold)) /// 80 
(line DayCasMeSmA04S00U20210423 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210424 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210506 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210514 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210515 date, sort lcolor(gold)) /// 85
(line DayCasMeSmA04S00U20210516 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210521 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210522 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210528 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210603 date, sort lcolor(gold)) /// 90
(line DayCasMeSmA04S00U20210604 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210605 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210610 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210611 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210618 date, sort lcolor(gold)) /// 95
(line DayCasMeSmA04S00U20210624 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210625 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210703 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210704 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210709 date, sort lcolor(gold)) /// 100
(line DayCasMeSmA05S00U20210401 date, sort lcolor(green)) /// 101 "SRIV"
(line DayCasMeSmA05S00U20210406 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210409 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210416 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210417 date, sort lcolor(green)) /// 105 
(line DayCasMeSmA05S00U20210423 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210424 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210506 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210514 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210515 date, sort lcolor(green)) /// 110
(line DayCasMeSmA05S00U20210516 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210521 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210522 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210528 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210603 date, sort lcolor(green)) /// 115
(line DayCasMeSmA05S00U20210604 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210605 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210610 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210611 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210618 date, sort lcolor(green)) /// 120
(line DayCasMeSmA05S00U20210624 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210625 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210703 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210704 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210709 date, sort lcolor(green)) /// 125
(line DayCasMeSmA00S00 date, lcolor(cyan*1.2) lwidth(vthick)) /// 126
if date >= td(01apr2021), ///	   
xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP cases" 33 "IHME infections" 60 "IMPE infections" ///
76 "LANL cases" 101 "SRIV cases" 126 "JOHN cases") size(small) rows(2))	///
note("Note: Dashed magenta curves denote estimates from model version 7 of IMPE," ///
"and dashed black curves denote estimates from model version 3 of IHME.", size(small))	

qui graph save "graph 21a COVID-19 daily cases, $country.gph", replace
qui graph export "graph 21a COVID-19 daily cases, $country.pdf", replace	
  	   
	   




************

* daily cases or infections, Absolute value, wo extremes


/*

impe extremes:

(line DayINFMeRaA03S02U20210406 date, sort lcolor(red) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210409 date, sort lcolor(red) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210416 date, sort lcolor(red) lpattern(dash)) ///  
(line DayINFMeRaA03S02U20210417 date, sort lcolor(red) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210423 date, sort lcolor(red) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210424 date, sort lcolor(red) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210506 date, sort lcolor(red) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210514 date, sort lcolor(red) lpattern(dash)) /// 

sriv extremes:

(line DayCasMeSmA05S00U20210409 date, sort lcolor(red)) ///
(line DayCasMeSmA05S00U20210416 date, sort lcolor(red)) ///
(line DayCasMeSmA05S00U20210417 date, sort lcolor(red)) /// 

*/


twoway  ///
(line DayCasMeRaA01S00U20210401 date, sort lcolor(red)) /// 1 "DELP"
(line DayCasMeRaA01S00U20210406 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210409 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210416 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210417 date, sort lcolor(red)) /// 5
(line DayCasMeRaA01S00U20210423 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210424 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210506 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210514 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210515 date, sort lcolor(red)) /// 10
(line DayCasMeRaA01S00U20210516 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210521 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210522 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210603 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210604 date, sort lcolor(red)) /// 15
(line DayCasMeRaA01S00U20210605 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210610 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210611 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210618 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210624 date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210625 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210703 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210704 date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210709 date, sort lcolor(red)) /// 
(line DayINFMeRaA02S01U20210401 date, sort lcolor(black) lpattern(dash)) /// 25 IHME
(line DayINFMeRaA02S01U20210406 date, sort lcolor(black) lpattern(dash)) /// 
(line DayINFMeRaA02S01U20210409 date, sort lcolor(black) lpattern(dash)) /// 
(line DayINFMeRaA02S01U20210416 date, sort lcolor(black) lpattern(dash)) /// 
(line DayINFMeRaA02S01U20210417 date, sort lcolor(black) lpattern(dash)) /// 
(line DayINFMeRaA02S01U20210423 date, sort lcolor(black) lpattern(dash)) /// 30
(line DayINFMeRaA02S01U20210424 date, sort lcolor(black) lpattern(dash)) /// 31 IHME v3
(line DayINFMeRaA02S01U20210506 date, sort lcolor(black)) /// 32 IHME v4 
(line DayINFMeRaA02S01U20210514 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210515 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210516 date, sort lcolor(black)) /// 35 
(line DayINFMeRaA02S01U20210521 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210522 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210528 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210603 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210604 date, sort lcolor(black)) /// 40
(line DayINFMeRaA02S01U20210605 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210610 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210611 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210618 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210624 date, sort lcolor(black)) /// 45
(line DayINFMeRaA02S01U20210625 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210703 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210704 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210709 date, sort lcolor(black)) /// 
(line DayINFMeRaA03S02U20210515 date, sort lcolor(magenta)) /// 50 IMPE v8 
(line DayINFMeRaA03S02U20210516 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210521 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210522 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210528 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210603 date, sort lcolor(magenta)) /// 55
(line DayINFMeRaA03S02U20210604 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210605 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210610 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210611 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210618 date, sort lcolor(magenta)) /// 60
(line DayINFMeRaA03S02U20210624 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210625 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210703 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210704 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210709 date, sort lcolor(magenta)) /// 65
(line DayCasMeSmA04S00U20210401 date, sort lcolor(gold)) /// 66 "LANL"
(line DayCasMeSmA04S00U20210406 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210409 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210416 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210417 date, sort lcolor(gold)) /// 70 
(line DayCasMeSmA04S00U20210423 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210424 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210506 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210514 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210515 date, sort lcolor(gold)) /// 75
(line DayCasMeSmA04S00U20210516 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210521 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210522 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210528 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210603 date, sort lcolor(gold)) /// 80
(line DayCasMeSmA04S00U20210604 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210605 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210610 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210611 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210618 date, sort lcolor(gold)) /// 85
(line DayCasMeSmA04S00U20210624 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210625 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210703 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210704 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210709 date, sort lcolor(gold)) /// 90
(line DayCasMeSmA05S00U20210401 date, sort lcolor(green)) /// 91 "SRIV"
(line DayCasMeSmA05S00U20210406 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210423 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210424 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210506 date, sort lcolor(green)) /// 95
(line DayCasMeSmA05S00U20210514 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210515 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210516 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210521 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210522 date, sort lcolor(green)) /// 100
(line DayCasMeSmA05S00U20210528 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210603 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210604 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210605 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210610 date, sort lcolor(green)) /// 105
(line DayCasMeSmA05S00U20210611 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210618 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210624 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210625 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210703 date, sort lcolor(green)) /// 110
(line DayCasMeSmA05S00U20210704 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210709 date, sort lcolor(green)) /// 
(line DayCasMeSmA00S00 date, lcolor(cyan*1.2) lwidth(vthick)) /// 113
if date >= td(01apr2021), ///	   
xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09" ///
"without extremes", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP cases" 25 "IHME infections" 50 "IMPE infections" ///
66 "LANL cases" 91 "SRIV cases" 113 "JOHN cases") size(small) rows(2)) ///
note("Note: Dashed black curves denote estimates from model version 3 of IHME.", size(small))	
  	   
qui graph save "graph 21b COVID-19 daily cases, $country, wo extremes.gph", replace
qui graph export "graph 21b COVID-19 daily cases, $country, wo extremes.pdf", replace







**************************************

* daily cases or infections, minus JOHN

twoway  ///
(line DayCasMeRaA01S00U20210401D date, sort lcolor(red)) /// 1 "DELP"
(line DayCasMeRaA01S00U20210406D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210409D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210416D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210417D date, sort lcolor(red)) /// 5
(line DayCasMeRaA01S00U20210423D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210424D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210506D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210514D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210515D date, sort lcolor(red)) /// 10
(line DayCasMeRaA01S00U20210516D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210521D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210522D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210528D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210603D date, sort lcolor(red)) /// 15 
(line DayCasMeRaA01S00U20210604D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210605D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210610D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210611D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210618D date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210624D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210625D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210703D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210704D date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210709D date, sort lcolor(red)) /// 25
(line DayINFMeRaA02S01U20210401D date, sort lcolor(black) lpattern(dash)) /// 26 IHME
(line DayINFMeRaA02S01U20210406D date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210409D date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210416D date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210417D date, sort lcolor(black) lpattern(dash)) /// 30
(line DayINFMeRaA02S01U20210423D date, sort lcolor(black) lpattern(dash)) /// 
(line DayINFMeRaA02S01U20210424D date, sort lcolor(black) lpattern(dash)) /// 32 IHME v3
(line DayINFMeRaA02S01U20210506D date, sort lcolor(black)) /// 33 IHME v4 
(line DayINFMeRaA02S01U20210514D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210515D date, sort lcolor(black)) /// 35
(line DayINFMeRaA02S01U20210516D date, sort lcolor(black)) ///  
(line DayINFMeRaA02S01U20210521D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210522D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210528D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210603D date, sort lcolor(black)) /// 40
(line DayINFMeRaA02S01U20210604D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210605D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210610D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210611D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210618D date, sort lcolor(black)) /// 45
(line DayINFMeRaA02S01U20210624D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210625D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210703D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210704D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210709D date, sort lcolor(black)) /// 50
(line DayINFMeRaA03S02U20210401D date, sort lcolor(magenta) lpattern(dash)) /// 51 IMPE
(line DayINFMeRaA03S02U20210406D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210409D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210416D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210417D date, sort lcolor(magenta) lpattern(dash)) /// 55
(line DayINFMeRaA03S02U20210423D date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210424D date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210506D date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210514D date, sort lcolor(magenta) lpattern(dash)) /// 59  IMPE v7
(line DayINFMeRaA03S02U20210515D date, sort lcolor(magenta)) /// 60 IMPE v8 
(line DayINFMeRaA03S02U20210516D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210521D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210522D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210528D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210603D date, sort lcolor(magenta)) /// 65
(line DayINFMeRaA03S02U20210604D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210605D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210610D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210611D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210618D date, sort lcolor(magenta)) /// 70
(line DayINFMeRaA03S02U20210624D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210625D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210703D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210704D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210709D date, sort lcolor(magenta)) /// 75
(line DayCasMeSmA04S00U20210401D date, sort lcolor(gold)) /// 76 "LANL"
(line DayCasMeSmA04S00U20210406D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210409D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210416D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210417D date, sort lcolor(gold)) /// 80 
(line DayCasMeSmA04S00U20210423D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210424D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210506D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210514D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210515D date, sort lcolor(gold)) /// 85
(line DayCasMeSmA04S00U20210516D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210521D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210522D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210528D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210603D date, sort lcolor(gold)) /// 90
(line DayCasMeSmA04S00U20210604D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210605D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210610D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210611D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210618D date, sort lcolor(gold)) /// 95
(line DayCasMeSmA04S00U20210624D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210625D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210703D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210704D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210709D date, sort lcolor(gold)) /// 100
(line DayCasMeSmA05S00U20210401D date, sort lcolor(green)) /// 101 "SRIV"
(line DayCasMeSmA05S00U20210406D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210409D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210416D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210417D date, sort lcolor(green)) /// 105 
(line DayCasMeSmA05S00U20210423D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210424D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210506D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210514D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210515D date, sort lcolor(green)) /// 110
(line DayCasMeSmA05S00U20210516D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210521D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210522D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210528D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210603D date, sort lcolor(green)) /// 115
(line DayCasMeSmA05S00U20210604D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210605D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210610D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210611D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210618D date, sort lcolor(green)) /// 120
(line DayCasMeSmA05S00U20210624D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210625D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210703D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210704D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210709D date, sort lcolor(green)) /// 125
if date >= td(01apr2021) & date <= td(01aug2021), ///	   
xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections minus JOHN cases) title("COVID-19 daily cases or infections minus JOHN cases, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP cases" 33 "IHME infections" 60 "IMPE infections" ///
76 "LANL cases" 101 "SRIV cases") size(small) rows(2))	///
note("Note: Dashed magenta curves denote estimates from model version 7 of IMPE," ///
"and dashed black curves denote estimates from model version 3 of IHME.", size(small))	

qui graph save "graph 22a COVID-19 daily cases, $country, minus.gph", replace
qui graph export "graph 22a COVID-19 daily cases, $country, minus.pdf", replace	
  	   
	   




************

* daily cases or infections, minus JOHN, wo extremes


/*

impe extremes:

(line DayINFMeRaA03S02U20210406D date, sort lcolor(red) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210409D date, sort lcolor(red) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210416D date, sort lcolor(red) lpattern(dash)) ///  
(line DayINFMeRaA03S02U20210417D date, sort lcolor(red) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210423D date, sort lcolor(red) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210424D date, sort lcolor(red) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210506D date, sort lcolor(red) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210514D date, sort lcolor(red) lpattern(dash)) /// 

sriv extremes:

(line DayCasMeSmA05S00U20210409D date, sort lcolor(red)) ///
(line DayCasMeSmA05S00U20210416D date, sort lcolor(red)) ///
(line DayCasMeSmA05S00U20210417D date, sort lcolor(red)) /// 

*/


twoway  ///
(line DayCasMeRaA01S00U20210401D date, sort lcolor(red)) /// 1 "DELP"
(line DayCasMeRaA01S00U20210406D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210409D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210416D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210417D date, sort lcolor(red)) /// 5
(line DayCasMeRaA01S00U20210423D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210424D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210506D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210514D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210515D date, sort lcolor(red)) /// 10
(line DayCasMeRaA01S00U20210516D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210521D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210522D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210603D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210604D date, sort lcolor(red)) /// 15
(line DayCasMeRaA01S00U20210605D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210610D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210611D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210618D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210624D date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210625D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210703D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210704D date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210709D date, sort lcolor(red)) /// 
(line DayINFMeRaA02S01U20210401D date, sort lcolor(black) lpattern(dash)) /// 25 IHME
(line DayINFMeRaA02S01U20210406D date, sort lcolor(black) lpattern(dash)) /// 
(line DayINFMeRaA02S01U20210409D date, sort lcolor(black) lpattern(dash)) /// 
(line DayINFMeRaA02S01U20210416D date, sort lcolor(black) lpattern(dash)) /// 
(line DayINFMeRaA02S01U20210417D date, sort lcolor(black) lpattern(dash)) /// 
(line DayINFMeRaA02S01U20210423D date, sort lcolor(black) lpattern(dash)) /// 30
(line DayINFMeRaA02S01U20210424D date, sort lcolor(black) lpattern(dash)) /// 31 IHME v3
(line DayINFMeRaA02S01U20210506D date, sort lcolor(black)) /// 32 IHME v4 
(line DayINFMeRaA02S01U20210514D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210515D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210516D date, sort lcolor(black)) /// 35 
(line DayINFMeRaA02S01U20210521D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210522D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210528D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210603D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210604D date, sort lcolor(black)) /// 40
(line DayINFMeRaA02S01U20210605D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210610D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210611D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210618D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210624D date, sort lcolor(black)) /// 45
(line DayINFMeRaA02S01U20210625D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210703D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210704D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210709D date, sort lcolor(black)) /// 
(line DayINFMeRaA03S02U20210515D date, sort lcolor(magenta)) /// 50 IMPE v8 
(line DayINFMeRaA03S02U20210516D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210521D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210522D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210528D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210603D date, sort lcolor(magenta)) /// 55
(line DayINFMeRaA03S02U20210604D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210605D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210610D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210611D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210618D date, sort lcolor(magenta)) /// 60
(line DayINFMeRaA03S02U20210624D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210625D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210703D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210704D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210709D date, sort lcolor(magenta)) /// 65
(line DayCasMeSmA04S00U20210401D date, sort lcolor(gold)) /// 66 "LANL"
(line DayCasMeSmA04S00U20210406D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210409D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210416D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210417D date, sort lcolor(gold)) /// 70 
(line DayCasMeSmA04S00U20210423D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210424D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210506D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210514D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210515D date, sort lcolor(gold)) /// 75
(line DayCasMeSmA04S00U20210516D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210521D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210522D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210528D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210603D date, sort lcolor(gold)) /// 80
(line DayCasMeSmA04S00U20210604D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210605D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210610D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210611D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210618D date, sort lcolor(gold)) /// 85
(line DayCasMeSmA04S00U20210624D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210625D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210703D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210704D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210709D date, sort lcolor(gold)) /// 90
(line DayCasMeSmA05S00U20210401D date, sort lcolor(green)) /// 91 "SRIV"
(line DayCasMeSmA05S00U20210406D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210423D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210424D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210506D date, sort lcolor(green)) /// 95
(line DayCasMeSmA05S00U20210514D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210515D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210516D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210521D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210522D date, sort lcolor(green)) /// 100
(line DayCasMeSmA05S00U20210528D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210603D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210604D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210605D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210610D date, sort lcolor(green)) /// 105
(line DayCasMeSmA05S00U20210611D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210618D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210624D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210625D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210703D date, sort lcolor(green)) /// 110
(line DayCasMeSmA05S00U20210704D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210709D date, sort lcolor(green)) /// 
if date >= td(01apr2021) & date <= td(01aug2021), ///	   
xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections minus JOHN cases) title("COVID-19 daily cases or infections minus JOHN cases, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09" ///
"without extremes", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP cases" 32 "IHME infections" 50 "IMPE infections" ///
66 "LANL cases" 91 "SRIV cases") size(small) rows(2)) ///
note("Note: Dashed black curves denote estimates from model version 3 of IHME.", size(small))	
  	   
qui graph save "graph 22b COVID-19 daily cases, $country, wo extremes, minus.gph", replace
qui graph export "graph 22b COVID-19 daily cases, $country, wo extremes, minus.pdf", replace























* total deaths

***************************

* total deaths, Absolute value

twoway  ///
(line TotDeaMeRaA01S00U20210401 date, sort lcolor(red)) /// 1 "DELP"
(line TotDeaMeRaA01S00U20210406 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210409 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210416 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210417 date, sort lcolor(red)) /// 5
(line TotDeaMeRaA01S00U20210423 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210424 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210506 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210514 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210515 date, sort lcolor(red)) /// 10
(line TotDeaMeRaA01S00U20210516 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210521 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210522 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210528 date, sort lcolor(red)) /// greatest extreme, i.e., DELP 20210528
(line TotDeaMeRaA01S00U20210603 date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20210604 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210605 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210610 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210611 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210618 date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210624 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210625 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210703 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210704 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210709 date, sort lcolor(red)) /// 25
(line TotDeaMeSmA02S01U20210401 date, sort lcolor(black) lpattern(dash)) /// 26 IHME
(line TotDeaMeSmA02S01U20210406 date, sort lcolor(black) lpattern(dash)) /// 
(line TotDeaMeSmA02S01U20210409 date, sort lcolor(black) lpattern(dash)) /// 
(line TotDeaMeSmA02S01U20210416 date, sort lcolor(black) lpattern(dash)) /// 
(line TotDeaMeSmA02S01U20210417 date, sort lcolor(black) lpattern(dash)) /// 30 
(line TotDeaMeSmA02S01U20210423 date, sort lcolor(black) lpattern(dash)) /// 
(line TotDeaMeSmA02S01U20210424 date, sort lcolor(black) lpattern(dash)) /// 32 IHME v3
(line TotDeaMeSmA02S01U20210506 date, sort lcolor(black)) /// 33 IHME v4 
(line TotDeaMeSmA02S01U20210514 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210515 date, sort lcolor(black)) /// 35
(line TotDeaMeSmA02S01U20210516 date, sort lcolor(black)) ///  
(line TotDeaMeSmA02S01U20210521 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210522 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210528 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210603 date, sort lcolor(black)) /// 40
(line TotDeaMeSmA02S01U20210604 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210605 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210610 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210611 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210618 date, sort lcolor(black)) /// 45
(line TotDeaMeSmA02S01U20210624 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210625 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210703 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210704 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210709 date, sort lcolor(black)) /// 50
(line TotDeaMeRaA03S02U20210401 date, sort lcolor(magenta) lpattern(dash)) /// 51 IMPE
(line TotDeaMeRaA03S02U20210406 date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210409 date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210416 date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210417 date, sort lcolor(magenta) lpattern(dash)) /// 55
(line TotDeaMeRaA03S02U20210423 date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotDeaMeRaA03S02U20210424 date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotDeaMeRaA03S02U20210506 date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotDeaMeRaA03S02U20210514 date, sort lcolor(magenta) lpattern(dash)) /// 59  IMPE v7
(line TotDeaMeRaA03S02U20210515 date, sort lcolor(magenta)) /// 60 IMPE v8 
(line TotDeaMeRaA03S02U20210516 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210521 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210522 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210528 date, sort lcolor(magenta)) /// 65
(line TotDeaMeRaA03S02U20210603 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210604 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210605 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210610 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210611 date, sort lcolor(magenta)) /// 70
(line TotDeaMeRaA03S02U20210618 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210624 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210625 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210703 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210704 date, sort lcolor(magenta)) /// 75
(line TotDeaMeRaA03S02U20210709 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA04S00U20210401 date, sort lcolor(gold)) /// 77 "LANL"
(line TotDeaMeRaA04S00U20210406 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210409 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210416 date, sort lcolor(gold)) /// 80
(line TotDeaMeRaA04S00U20210417 date, sort lcolor(gold)) ///  
(line TotDeaMeRaA04S00U20210423 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210424 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210506 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210514 date, sort lcolor(gold)) /// 85
(line TotDeaMeRaA04S00U20210515 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210516 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210521 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210522 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210528 date, sort lcolor(gold)) /// 90
(line TotDeaMeRaA04S00U20210603 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210604 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210605 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210610 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210611 date, sort lcolor(gold)) /// 95
(line TotDeaMeRaA04S00U20210618 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210624 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210625 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210703 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210704 date, sort lcolor(gold)) /// 100
(line TotDeaMeRaA04S00U20210709 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA05S00U20210401 date, sort lcolor(green)) /// 102 "SRIV"
(line TotDeaMeRaA05S00U20210406 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210423 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210424 date, sort lcolor(green)) /// 105
(line TotDeaMeRaA05S00U20210506 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210514 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210515 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210516 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210521 date, sort lcolor(green)) /// 110
(line TotDeaMeRaA05S00U20210522 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210528 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210603 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210604 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210605 date, sort lcolor(green)) /// 115
(line TotDeaMeRaA05S00U20210610 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210611 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210618 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210624 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210625 date, sort lcolor(green)) /// 120
(line TotDeaMeRaA05S00U20210703 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210704 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210709 date, sort lcolor(green)) /// 
(line TotDeaMeRaA00S00 date, lcolor(cyan*1.2) lwidth(vthick)) /// 124
if date >= td(01apr2021), ///	   
xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09" ///
"with the greatest extreme estimate, i.e., DELP 20210528", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 33 "IHME" 60 "IMPE" 77 "LANL" 102 "SRIV" 124 "JOHN") size(small) rows(1))	///
note("Note: Dashed magenta curves denote estimates from model version 7 of IMPE," ///
"and dashed black curves denote estimates from model version 3 of IHME.", size(small))		
  	   
qui graph save "graph 31a COVID-19 total deaths, $country.gph", replace
qui graph export "graph 31a COVID-19 total deaths, $country.pdf", replace






* total deaths, Absolute value, wo extremes

twoway  ///
(line TotDeaMeRaA01S00U20210401 date, sort lcolor(red)) /// 1 "DELP"
(line TotDeaMeRaA01S00U20210406 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210409 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210416 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210417 date, sort lcolor(red)) /// 5
(line TotDeaMeRaA01S00U20210423 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210424 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210506 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210514 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210515 date, sort lcolor(red)) /// 10
(line TotDeaMeRaA01S00U20210516 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210521 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210522 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210603 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210604 date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20210605 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210610 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210611 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210618 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210624 date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210625 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210703 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210704 date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210709 date, sort lcolor(red)) /// 
(line TotDeaMeSmA02S01U20210401 date, sort lcolor(black) lpattern(dash)) /// 25 IHME
(line TotDeaMeSmA02S01U20210406 date, sort lcolor(black) lpattern(dash)) /// 
(line TotDeaMeSmA02S01U20210409 date, sort lcolor(black) lpattern(dash)) /// 
(line TotDeaMeSmA02S01U20210416 date, sort lcolor(black) lpattern(dash)) /// 
(line TotDeaMeSmA02S01U20210417 date, sort lcolor(black) lpattern(dash)) ///  
(line TotDeaMeSmA02S01U20210423 date, sort lcolor(black) lpattern(dash)) /// 30
(line TotDeaMeSmA02S01U20210424 date, sort lcolor(black) lpattern(dash)) /// 31 IHME v3
(line TotDeaMeSmA02S01U20210506 date, sort lcolor(black)) /// 32 IHME v4 
(line TotDeaMeSmA02S01U20210514 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210515 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210516 date, sort lcolor(black)) /// 35 
(line TotDeaMeSmA02S01U20210521 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210522 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210528 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210603 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210604 date, sort lcolor(black)) /// 40
(line TotDeaMeSmA02S01U20210605 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210610 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210611 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210618 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210624 date, sort lcolor(black)) /// 45
(line TotDeaMeSmA02S01U20210625 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210703 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210704 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210709 date, sort lcolor(black)) /// 
(line TotDeaMeRaA03S02U20210515 date, sort lcolor(magenta)) /// 50 IMPE v8 
(line TotDeaMeRaA03S02U20210516 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210521 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210522 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210528 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210603 date, sort lcolor(magenta)) /// 55
(line TotDeaMeRaA03S02U20210604 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210605 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210610 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210611 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210618 date, sort lcolor(magenta)) /// 60
(line TotDeaMeRaA03S02U20210624 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210625 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210703 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210704 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210709 date, sort lcolor(magenta)) /// 65
(line TotDeaMeRaA04S00U20210401 date, sort lcolor(gold)) /// 66 "LANL"
(line TotDeaMeRaA04S00U20210406 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210409 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210416 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210417 date, sort lcolor(gold)) /// 70 
(line TotDeaMeRaA04S00U20210423 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210424 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210506 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210514 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210515 date, sort lcolor(gold)) /// 75
(line TotDeaMeRaA04S00U20210516 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210521 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210522 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210528 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210603 date, sort lcolor(gold)) /// 80
(line TotDeaMeRaA04S00U20210604 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210605 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210610 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210611 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210618 date, sort lcolor(gold)) /// 85
(line TotDeaMeRaA04S00U20210624 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210625 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210703 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210704 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210709 date, sort lcolor(gold)) /// 90
(line TotDeaMeRaA05S00U20210401 date, sort lcolor(green)) /// 91 "SRIV"
(line TotDeaMeRaA05S00U20210406 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210423 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210424 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210506 date, sort lcolor(green)) /// 95 
(line TotDeaMeRaA05S00U20210514 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210515 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210516 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210521 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210522 date, sort lcolor(green)) /// 100
(line TotDeaMeRaA05S00U20210528 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210603 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210604 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210605 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210610 date, sort lcolor(green)) /// 105
(line TotDeaMeRaA05S00U20210611 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210618 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210624 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210625 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210703 date, sort lcolor(green)) /// 110
(line TotDeaMeRaA05S00U20210704 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210709 date, sort lcolor(green)) /// 
(line TotDeaMeRaA00S00 date, lcolor(cyan*1.2) lwidth(vthick)) /// 113
(line TotDeaMeRaA00S002p4 date, lcolor(cyan*1.2) lwidth(vthick) lpattern(dash)) /// 114
if date >= td(01apr2021), ///	   
xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09" ///
"without extremes", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 26 "IHME" 51 "IMPE" 67 "LANL" 92 "SRIV" 114 "JOHN" 115 "JOHN*2.4") size(small) rows(1)) ///		
note("Note: Dashed black curves denote estimates from model version 3 of IHME." ///
"IHME estimate of correction factor for under-reporting of COVID-19 deaths in Iran = 2.4", size(small))	
  	   
qui graph save "graph 31b COVID-19 total deaths, $country, wo extremes.gph", replace
qui graph export "graph 31b COVID-19 total deaths, $country, wo extremes.pdf", replace





***************************

* total deaths, minus JOHN

twoway  ///
(line TotDeaMeRaA01S00U20210401D date, sort lcolor(red)) /// 1 "DELP"
(line TotDeaMeRaA01S00U20210406D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210409D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210416D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210417D date, sort lcolor(red)) /// 5
(line TotDeaMeRaA01S00U20210423D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210424D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210506D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210514D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210515D date, sort lcolor(red)) /// 10
(line TotDeaMeRaA01S00U20210516D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210521D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210522D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210528D date, sort lcolor(red)) /// greatest extreme, i.e., DELP 20210528
(line TotDeaMeRaA01S00U20210603D date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20210604D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210605D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210610D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210611D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210618D date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210624D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210625D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210703D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210704D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210709D date, sort lcolor(red)) /// 25
(line TotDeaMeSmA02S01U20210401D date, sort lcolor(black) lpattern(dash)) /// 26 IHME
(line TotDeaMeSmA02S01U20210406D date, sort lcolor(black) lpattern(dash)) /// 
(line TotDeaMeSmA02S01U20210409D date, sort lcolor(black) lpattern(dash)) /// 
(line TotDeaMeSmA02S01U20210416D date, sort lcolor(black) lpattern(dash)) /// 
(line TotDeaMeSmA02S01U20210417D date, sort lcolor(black) lpattern(dash)) /// 30 
(line TotDeaMeSmA02S01U20210423D date, sort lcolor(black) lpattern(dash)) /// 
(line TotDeaMeSmA02S01U20210424D date, sort lcolor(black) lpattern(dash)) /// 32 IHME v3
(line TotDeaMeSmA02S01U20210506D date, sort lcolor(black)) /// 33 IHME v4 
(line TotDeaMeSmA02S01U20210514D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210515D date, sort lcolor(black)) /// 35
(line TotDeaMeSmA02S01U20210516D date, sort lcolor(black)) ///  
(line TotDeaMeSmA02S01U20210521D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210522D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210528D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210603D date, sort lcolor(black)) /// 40
(line TotDeaMeSmA02S01U20210604D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210605D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210610D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210611D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210618D date, sort lcolor(black)) /// 45
(line TotDeaMeSmA02S01U20210624D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210625D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210703D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210704D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210709D date, sort lcolor(black)) /// 50
(line TotDeaMeRaA03S02U20210401D date, sort lcolor(magenta) lpattern(dash)) /// 51 IMPE
(line TotDeaMeRaA03S02U20210406D date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210409D date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210416D date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210417D date, sort lcolor(magenta) lpattern(dash)) /// 55
(line TotDeaMeRaA03S02U20210423D date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotDeaMeRaA03S02U20210424D date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotDeaMeRaA03S02U20210506D date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotDeaMeRaA03S02U20210514D date, sort lcolor(magenta) lpattern(dash)) /// 59  IMPE v7
(line TotDeaMeRaA03S02U20210515D date, sort lcolor(magenta)) /// 60 IMPE v8 
(line TotDeaMeRaA03S02U20210516D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210521D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210522D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210528D date, sort lcolor(magenta)) /// 65
(line TotDeaMeRaA03S02U20210603D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210604D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210605D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210610D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210611D date, sort lcolor(magenta)) /// 70
(line TotDeaMeRaA03S02U20210618D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210624D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210625D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210703D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210704D date, sort lcolor(magenta)) /// 75
(line TotDeaMeRaA03S02U20210709D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA04S00U20210401D date, sort lcolor(gold)) /// 77 "LANL"
(line TotDeaMeRaA04S00U20210406D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210409D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210416D date, sort lcolor(gold)) /// 80
(line TotDeaMeRaA04S00U20210417D date, sort lcolor(gold)) ///  
(line TotDeaMeRaA04S00U20210423D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210424D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210506D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210514D date, sort lcolor(gold)) /// 85
(line TotDeaMeRaA04S00U20210515D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210516D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210521D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210522D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210528D date, sort lcolor(gold)) /// 90
(line TotDeaMeRaA04S00U20210603D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210604D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210605D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210610D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210611D date, sort lcolor(gold)) /// 95
(line TotDeaMeRaA04S00U20210618D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210624D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210625D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210703D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210704D date, sort lcolor(gold)) /// 100
(line TotDeaMeRaA04S00U20210709D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA05S00U20210401D date, sort lcolor(green)) /// 102 "SRIV"
(line TotDeaMeRaA05S00U20210406D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210423D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210424D date, sort lcolor(green)) /// 105
(line TotDeaMeRaA05S00U20210506D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210514D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210515D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210516D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210521D date, sort lcolor(green)) /// 110
(line TotDeaMeRaA05S00U20210522D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210528D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210603D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210604D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210605D date, sort lcolor(green)) /// 115
(line TotDeaMeRaA05S00U20210610D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210611D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210618D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210624D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210625D date, sort lcolor(green)) /// 120
(line TotDeaMeRaA05S00U20210703D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210704D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210709D date, sort lcolor(green)) /// 
if date >= td(01apr2021) & date <= td(01aug2021), ///	   
xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths minus JOHN) title("COVID-19 total deaths minus JOHN, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09" ///
"with the greatest extreme estimate, i.e., DELP 20210528", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 33 "IHME" 60 "IMPE" 77 "LANL" 102 "SRIV") size(small) rows(1))	///
note("Note: Dashed magenta curves denote estimates from model version 7 of IMPE," ///
"and dashed black curves denote estimates from model version 3 of IHME.", size(small))		
  	   
qui graph save "graph 32a COVID-19 total deaths, $country, minus.gph", replace
qui graph export "graph 32a COVID-19 total deaths, $country, minus.pdf", replace






* total deaths, minus JOHN, wo extremes

twoway  ///
(line TotDeaMeRaA01S00U20210401D date, sort lcolor(red)) /// 1 "DELP"
(line TotDeaMeRaA01S00U20210406D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210409D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210416D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210417D date, sort lcolor(red)) /// 5
(line TotDeaMeRaA01S00U20210423D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210424D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210506D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210514D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210515D date, sort lcolor(red)) /// 10
(line TotDeaMeRaA01S00U20210516D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210521D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210522D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210603D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210604D date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20210605D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210610D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210611D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210618D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210624D date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210625D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210703D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210704D date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210709D date, sort lcolor(red)) /// 
(line TotDeaMeSmA02S01U20210401D date, sort lcolor(black) lpattern(dash)) /// 25 IHME
(line TotDeaMeSmA02S01U20210406D date, sort lcolor(black) lpattern(dash)) /// 
(line TotDeaMeSmA02S01U20210409D date, sort lcolor(black) lpattern(dash)) /// 
(line TotDeaMeSmA02S01U20210416D date, sort lcolor(black) lpattern(dash)) /// 
(line TotDeaMeSmA02S01U20210417D date, sort lcolor(black) lpattern(dash)) ///  
(line TotDeaMeSmA02S01U20210423D date, sort lcolor(black) lpattern(dash)) /// 30
(line TotDeaMeSmA02S01U20210424D date, sort lcolor(black) lpattern(dash)) /// 31 IHME v3
(line TotDeaMeSmA02S01U20210506D date, sort lcolor(black)) /// 32 IHME v4 
(line TotDeaMeSmA02S01U20210514D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210515D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210516D date, sort lcolor(black)) /// 35 
(line TotDeaMeSmA02S01U20210521D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210522D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210528D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210603D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210604D date, sort lcolor(black)) /// 40
(line TotDeaMeSmA02S01U20210605D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210610D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210611D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210618D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210624D date, sort lcolor(black)) /// 45
(line TotDeaMeSmA02S01U20210625D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210703D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210704D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210709D date, sort lcolor(black)) /// 
(line TotDeaMeRaA03S02U20210515D date, sort lcolor(magenta)) /// 50 IMPE v8 
(line TotDeaMeRaA03S02U20210516D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210521D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210522D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210528D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210603D date, sort lcolor(magenta)) /// 55
(line TotDeaMeRaA03S02U20210604D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210605D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210610D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210611D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210618D date, sort lcolor(magenta)) /// 60
(line TotDeaMeRaA03S02U20210624D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210625D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210703D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210704D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210709D date, sort lcolor(magenta)) /// 65
(line TotDeaMeRaA04S00U20210401D date, sort lcolor(gold)) /// 66 "LANL"
(line TotDeaMeRaA04S00U20210406D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210409D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210416D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210417D date, sort lcolor(gold)) /// 70 
(line TotDeaMeRaA04S00U20210423D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210424D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210506D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210514D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210515D date, sort lcolor(gold)) /// 75
(line TotDeaMeRaA04S00U20210516D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210521D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210522D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210528D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210603D date, sort lcolor(gold)) /// 80
(line TotDeaMeRaA04S00U20210604D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210605D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210610D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210611D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210618D date, sort lcolor(gold)) /// 85
(line TotDeaMeRaA04S00U20210624D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210625D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210703D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210704D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210709D date, sort lcolor(gold)) /// 90
(line TotDeaMeRaA05S00U20210401D date, sort lcolor(green)) /// 91 "SRIV"
(line TotDeaMeRaA05S00U20210406D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210423D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210424D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210506D date, sort lcolor(green)) /// 95 
(line TotDeaMeRaA05S00U20210514D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210515D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210516D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210521D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210522D date, sort lcolor(green)) /// 100
(line TotDeaMeRaA05S00U20210528D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210603D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210604D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210605D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210610D date, sort lcolor(green)) /// 105
(line TotDeaMeRaA05S00U20210611D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210618D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210624D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210625D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210703D date, sort lcolor(green)) /// 110
(line TotDeaMeRaA05S00U20210704D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210709D date, sort lcolor(green)) /// 
if date >= td(01apr2021) & date <= td(01aug2021), ///	   
xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths minus JOHN) title("COVID-19 total deaths minus JOHN, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09" ///
"without extremes", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 32 "IHME" 51 "IMPE" 67 "LANL" 92 "SRIV") size(small) rows(1)) ///		
note("Note: Dashed black curves denote estimates from model version 3 of IHME.", size(small))	
  	   
qui graph save "graph 32b COVID-19 total deaths, $country, wo extremes, minus.gph", replace
qui graph export "graph 32b COVID-19 total deaths, $country, wo extremes, minus.pdf", replace



















* total cases or infections

***************************

* total cases or infections, Absolute value

twoway  ///
(line TotCasMeRaA01S00U20210401 date, sort lcolor(red)) /// 1 "DELP"
(line TotCasMeRaA01S00U20210406 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210409 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210416 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210417 date, sort lcolor(red)) /// 5
(line TotCasMeRaA01S00U20210423 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210424 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210506 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210514 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210515 date, sort lcolor(red)) /// 10
(line TotCasMeRaA01S00U20210516 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210521 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210522 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210528 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210603 date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20210604 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210605 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210610 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210611 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210618 date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210624 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210625 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210703 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210704 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210709 date, sort lcolor(red)) /// 25
(line TotINFMeRaA02S01U20210401 date, sort lcolor(black) lpattern(dash)) /// 26 IHME
(line TotINFMeRaA02S01U20210406 date, sort lcolor(black) lpattern(dash)) /// 
(line TotINFMeRaA02S01U20210409 date, sort lcolor(black) lpattern(dash)) /// 
(line TotINFMeRaA02S01U20210416 date, sort lcolor(black) lpattern(dash)) /// 
(line TotINFMeRaA02S01U20210417 date, sort lcolor(black) lpattern(dash)) /// 30 
(line TotINFMeRaA02S01U20210423 date, sort lcolor(black) lpattern(dash)) /// 
(line TotINFMeRaA02S01U20210424 date, sort lcolor(black) lpattern(dash)) /// 32 IHME v3
(line TotINFMeRaA02S01U20210506 date, sort lcolor(black)) /// 33 IHME v4 
(line TotINFMeRaA02S01U20210514 date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210515 date, sort lcolor(black)) /// 35
(line TotINFMeRaA02S01U20210516 date, sort lcolor(black)) ///  
(line TotINFMeRaA02S01U20210521 date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210522 date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210528 date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210603 date, sort lcolor(black)) /// 40
(line TotINFMeRaA02S01U20210604 date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210605 date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210610 date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210611 date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210618 date, sort lcolor(black)) /// 45
(line TotINFMeRaA02S01U20210624 date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210625 date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210703 date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210704 date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210709 date, sort lcolor(black)) /// 50
(line TotINFMeRaA03S02U20210401 date, sort lcolor(magenta) lpattern(dash)) /// 51 IMPE
(line TotINFMeRaA03S02U20210406 date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210409 date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210416 date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210417 date, sort lcolor(magenta) lpattern(dash)) /// 55
(line TotINFMeRaA03S02U20210423 date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotINFMeRaA03S02U20210424 date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotINFMeRaA03S02U20210506 date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotINFMeRaA03S02U20210514 date, sort lcolor(magenta) lpattern(dash)) /// 59  IMPE v7
(line TotINFMeRaA03S02U20210515 date, sort lcolor(magenta)) /// 60 IMPE v8 
(line TotINFMeRaA03S02U20210516 date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210521 date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210522 date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210528 date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210603 date, sort lcolor(magenta)) /// 65
(line TotINFMeRaA03S02U20210604 date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210605 date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210610 date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210611 date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210618 date, sort lcolor(magenta)) /// 71
(line TotINFMeRaA03S02U20210624 date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210625 date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210703 date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210704 date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210709 date, sort lcolor(magenta)) /// 75
(line TotCasMeRaA04S00U20210401 date, sort lcolor(gold)) /// 76 "LANL"
(line TotCasMeRaA04S00U20210406 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210409 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210416 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210417 date, sort lcolor(gold)) /// 80 
(line TotCasMeRaA04S00U20210423 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210424 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210506 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210514 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210515 date, sort lcolor(gold)) /// 85
(line TotCasMeRaA04S00U20210516 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210521 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210522 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210528 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210603 date, sort lcolor(gold)) /// 90
(line TotCasMeRaA04S00U20210604 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210605 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210610 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210611 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210618 date, sort lcolor(gold)) /// 95
(line TotCasMeRaA04S00U20210624 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210625 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210703 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210704 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210709 date, sort lcolor(gold)) /// 100
(line TotCasMeRaA05S00U20210401 date, sort lcolor(green)) /// 101 "SRIV"
(line TotCasMeRaA05S00U20210406 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210423 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210424 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210506 date, sort lcolor(green)) /// 105
(line TotCasMeRaA05S00U20210514 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210515 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210516 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210521 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210522 date, sort lcolor(green)) /// 110
(line TotCasMeRaA05S00U20210528 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210603 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210604 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210605 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210610 date, sort lcolor(green)) /// 115
(line TotCasMeRaA05S00U20210611 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210618 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210624 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210625 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210703 date, sort lcolor(green)) /// 120
(line TotCasMeRaA05S00U20210704 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210709 date, sort lcolor(green)) /// 
(line TotCasMeRaA00S00 date, lcolor(cyan*1.2) lwidth(vthick)) /// 123
if date >= td(01apr2021), ///	   
xtitle(Date) xlabel(#7, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP cases" 33 "IHME infections" 60 "IMPE infections" ///
76 "LANL cases" 101 "SRIV cases" 123 "JOHN cases") size(small) rows(2))	///
note("Note: Dashed magenta curves denote estimates from model version 7 of IMPE," ///
"and dashed black curves denote estimates from model version 3 of IHME.", size(small))		
  	   
qui graph save "graph 41a COVID-19 total cases, $country.gph", replace
qui graph export "graph 41a COVID-19 total cases, $country.pdf", replace



***************************

* total cases or infections, minus JOHN

twoway  ///
(line TotCasMeRaA01S00U20210401D date, sort lcolor(red)) /// 1 "DELP"
(line TotCasMeRaA01S00U20210406D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210409D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210416D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210417D date, sort lcolor(red)) /// 5
(line TotCasMeRaA01S00U20210423D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210424D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210506D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210514D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210515D date, sort lcolor(red)) /// 10
(line TotCasMeRaA01S00U20210516D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210521D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210522D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210528D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210603D date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20210604D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210605D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210610D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210611D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210618D date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210624D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210625D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210703D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210704D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210709D date, sort lcolor(red)) /// 25
(line TotINFMeRaA02S01U20210401D date, sort lcolor(black) lpattern(dash)) /// 26 IHME
(line TotINFMeRaA02S01U20210406D date, sort lcolor(black) lpattern(dash)) /// 
(line TotINFMeRaA02S01U20210409D date, sort lcolor(black) lpattern(dash)) /// 
(line TotINFMeRaA02S01U20210416D date, sort lcolor(black) lpattern(dash)) /// 
(line TotINFMeRaA02S01U20210417D date, sort lcolor(black) lpattern(dash)) /// 30 
(line TotINFMeRaA02S01U20210423D date, sort lcolor(black) lpattern(dash)) /// 
(line TotINFMeRaA02S01U20210424D date, sort lcolor(black) lpattern(dash)) /// 32 IHME v3
(line TotINFMeRaA02S01U20210506D date, sort lcolor(black)) /// 33 IHME v4 
(line TotINFMeRaA02S01U20210514D date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210515D date, sort lcolor(black)) /// 35
(line TotINFMeRaA02S01U20210516D date, sort lcolor(black)) ///  
(line TotINFMeRaA02S01U20210521D date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210522D date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210528D date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210603D date, sort lcolor(black)) /// 40
(line TotINFMeRaA02S01U20210604D date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210605D date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210610D date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210611D date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210618D date, sort lcolor(black)) /// 45
(line TotINFMeRaA02S01U20210624D date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210625D date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210703D date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210704D date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210709D date, sort lcolor(black)) /// 50
(line TotINFMeRaA03S02U20210401D date, sort lcolor(magenta) lpattern(dash)) /// 51 IMPE
(line TotINFMeRaA03S02U20210406D date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210409D date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210416D date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210417D date, sort lcolor(magenta) lpattern(dash)) /// 55
(line TotINFMeRaA03S02U20210423D date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotINFMeRaA03S02U20210424D date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotINFMeRaA03S02U20210506D date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotINFMeRaA03S02U20210514D date, sort lcolor(magenta) lpattern(dash)) /// 59  IMPE v7
(line TotINFMeRaA03S02U20210515D date, sort lcolor(magenta)) /// 60 IMPE v8 
(line TotINFMeRaA03S02U20210516D date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210521D date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210522D date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210528D date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210603D date, sort lcolor(magenta)) /// 65
(line TotINFMeRaA03S02U20210604D date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210605D date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210610D date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210611D date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210618D date, sort lcolor(magenta)) /// 71
(line TotINFMeRaA03S02U20210624D date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210625D date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210703D date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210704D date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210709D date, sort lcolor(magenta)) /// 75
(line TotCasMeRaA04S00U20210401D date, sort lcolor(gold)) /// 76 "LANL"
(line TotCasMeRaA04S00U20210406D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210409D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210416D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210417D date, sort lcolor(gold)) /// 80 
(line TotCasMeRaA04S00U20210423D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210424D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210506D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210514D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210515D date, sort lcolor(gold)) /// 85
(line TotCasMeRaA04S00U20210516D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210521D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210522D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210528D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210603D date, sort lcolor(gold)) /// 90
(line TotCasMeRaA04S00U20210604D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210605D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210610D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210611D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210618D date, sort lcolor(gold)) /// 95
(line TotCasMeRaA04S00U20210624D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210625D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210703D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210704D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210709D date, sort lcolor(gold)) /// 100
(line TotCasMeRaA05S00U20210401D date, sort lcolor(green)) /// 101 "SRIV"
(line TotCasMeRaA05S00U20210406D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210423D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210424D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210506D date, sort lcolor(green)) /// 105
(line TotCasMeRaA05S00U20210514D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210515D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210516D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210521D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210522D date, sort lcolor(green)) /// 110
(line TotCasMeRaA05S00U20210528D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210603D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210604D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210605D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210610D date, sort lcolor(green)) /// 115
(line TotCasMeRaA05S00U20210611D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210618D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210624D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210625D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210703D date, sort lcolor(green)) /// 120
(line TotCasMeRaA05S00U20210704D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210709D date, sort lcolor(green)) /// 
if date >= td(01apr2021) & date <= td(01aug2021), ///	   
xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections minus JOHN cases) title("COVID-19 total cases or infections minus JOHN cases, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Models’ estimates’ updates from 2021-04-01 to 2021-07-09", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP cases" 33 "IHME infections" 60 "IMPE infections" ///
76 "LANL cases" 101 "SRIV cases") size(small) rows(2))	///
note("Note: Dashed magenta curves denote estimates from model version 7 of IMPE," ///
"and dashed black curves denote estimates from model version 3 of IHME.", size(small))		
  	   
qui graph save "graph 42a COVID-19 total cases, $country, minus.gph", replace
qui graph export "graph 42a COVID-19 total cases, $country, minus.pdf", replace









************

* restore native scheme (of the local machine)

set scheme $nativescheme

di c(scheme)


view "log country merge.smcl"

log close

exit, clear



