
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
(line DayDeaMeSmA00S002p4 date, lcolor(cyan*1.2) lwidth(vthick) lpattern(dash)) /// 126
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 32 "IHME" 59 "IMPE" 75 "LANL" 100 "SRIV" 125 "JOHN" 126 "JOHN*2.4") size(small) rows(1))		
  	   
qui graph save "graph 11a COVID-19 daily deaths, $country.gph", replace
qui graph export "graph 11a COVID-19 daily deaths, $country.pdf", replace



*




* daily deaths, Absolute value, wo extremes


/*

impe extremes:

(line DayDeaMeRaA03S02U20210406 date, sort lcolor(red) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210409 date, sort lcolor(red) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210416 date, sort lcolor(red) lpattern(dash)) ///  
(line DayDeaMeRaA03S02U20210417 date, sort lcolor(red) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210423 date, sort lcolor(red) lpattern(dash)) /// 55 
(line DayDeaMeRaA03S02U20210424 date, sort lcolor(red) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210506 date, sort lcolor(red) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210514 date, sort lcolor(red) lpattern(dash)) /// 58  IMPE v7 

sriv extremes:

(line DayDeaMeSmA05S00U20210409 date, sort lcolor(red)) ///
(line DayDeaMeSmA05S00U20210416 date, sort lcolor(red)) ///
(line DayDeaMeSmA05S00U20210417 date, sort lcolor(red)) /// 

*/


twoway  ///
(line DayDeaMeRaA01S00U20210401 date, sort lcolor(red)) /// 1 "DELP"
(line DayDeaMeRaA01S00U20210406 date, sort lcolor(red)) /// 2
(line DayDeaMeRaA01S00U20210409 date, sort lcolor(red)) /// 3
(line DayDeaMeRaA01S00U20210416 date, sort lcolor(red)) /// 4
(line DayDeaMeRaA01S00U20210417 date, sort lcolor(red)) /// 5
(line DayDeaMeRaA01S00U20210423 date, sort lcolor(red)) /// 6
(line DayDeaMeRaA01S00U20210424 date, sort lcolor(red)) /// 7
(line DayDeaMeRaA01S00U20210506 date, sort lcolor(red)) /// 8
(line DayDeaMeRaA01S00U20210514 date, sort lcolor(red)) /// 9
(line DayDeaMeRaA01S00U20210515 date, sort lcolor(red)) /// 10
(line DayDeaMeRaA01S00U20210516 date, sort lcolor(red)) /// 11
(line DayDeaMeRaA01S00U20210521 date, sort lcolor(red)) /// 12
(line DayDeaMeRaA01S00U20210522 date, sort lcolor(red)) /// 13
(line DayDeaMeRaA01S00U20210603 date, sort lcolor(red)) /// 14
(line DayDeaMeRaA01S00U20210604 date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20210605 date, sort lcolor(red)) /// 16
(line DayDeaMeRaA01S00U20210610 date, sort lcolor(red)) /// 17
(line DayDeaMeRaA01S00U20210611 date, sort lcolor(red)) /// 18
(line DayDeaMeRaA01S00U20210618 date, sort lcolor(red)) /// 19
(line DayDeaMeRaA01S00U20210624 date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210625 date, sort lcolor(red)) /// 21
(line DayDeaMeRaA01S00U20210703 date, sort lcolor(red)) /// 22
(line DayDeaMeRaA01S00U20210704 date, sort lcolor(red)) /// 23
(line DayDeaMeRaA01S00U20210709 date, sort lcolor(red)) /// 24
(line DayDeaMeSmA02S01U20210401 date, sort lcolor(black)) /// 25 IHME
(line DayDeaMeSmA02S01U20210406 date, sort lcolor(black)) /// 26
(line DayDeaMeSmA02S01U20210409 date, sort lcolor(black)) /// 27
(line DayDeaMeSmA02S01U20210416 date, sort lcolor(black)) /// 28
(line DayDeaMeSmA02S01U20210417 date, sort lcolor(black)) /// 29
(line DayDeaMeSmA02S01U20210423 date, sort lcolor(black)) /// 30
(line DayDeaMeSmA02S01U20210424 date, sort lcolor(black)) /// 31 IHME v3
(line DayDeaMeSmA02S01U20210506 date, sort lcolor(black)) /// 32 IHME v4 // 32 "IHME"
(line DayDeaMeSmA02S01U20210514 date, sort lcolor(black)) /// 33
(line DayDeaMeSmA02S01U20210515 date, sort lcolor(black)) /// 34
(line DayDeaMeSmA02S01U20210516 date, sort lcolor(black)) /// 35 
(line DayDeaMeSmA02S01U20210521 date, sort lcolor(black)) /// 36
(line DayDeaMeSmA02S01U20210522 date, sort lcolor(black)) /// 37
(line DayDeaMeSmA02S01U20210528 date, sort lcolor(black)) /// 38
(line DayDeaMeSmA02S01U20210603 date, sort lcolor(black)) /// 39
(line DayDeaMeSmA02S01U20210604 date, sort lcolor(black)) /// 40
(line DayDeaMeSmA02S01U20210605 date, sort lcolor(black)) /// 41
(line DayDeaMeSmA02S01U20210610 date, sort lcolor(black)) /// 42
(line DayDeaMeSmA02S01U20210611 date, sort lcolor(black)) /// 43
(line DayDeaMeSmA02S01U20210618 date, sort lcolor(black)) /// 44
(line DayDeaMeSmA02S01U20210624 date, sort lcolor(black)) /// 45
(line DayDeaMeSmA02S01U20210625 date, sort lcolor(black)) /// 46
(line DayDeaMeSmA02S01U20210703 date, sort lcolor(black)) /// 47
(line DayDeaMeSmA02S01U20210704 date, sort lcolor(black)) /// 48
(line DayDeaMeSmA02S01U20210709 date, sort lcolor(black)) /// 49
(line DayDeaMeRaA03S02U20210515 date, sort lcolor(magenta)) /// 50 IMPE v8 // 50 "IMPE"
(line DayDeaMeRaA03S02U20210516 date, sort lcolor(magenta)) /// 51
(line DayDeaMeRaA03S02U20210521 date, sort lcolor(magenta)) /// 52
(line DayDeaMeRaA03S02U20210522 date, sort lcolor(magenta)) /// 53
(line DayDeaMeRaA03S02U20210528 date, sort lcolor(magenta)) /// 54
(line DayDeaMeRaA03S02U20210603 date, sort lcolor(magenta)) /// 55
(line DayDeaMeRaA03S02U20210604 date, sort lcolor(magenta)) /// 56
(line DayDeaMeRaA03S02U20210605 date, sort lcolor(magenta)) /// 57
(line DayDeaMeRaA03S02U20210610 date, sort lcolor(magenta)) /// 58
(line DayDeaMeRaA03S02U20210611 date, sort lcolor(magenta)) /// 59
(line DayDeaMeRaA03S02U20210618 date, sort lcolor(magenta)) /// 60
(line DayDeaMeRaA03S02U20210624 date, sort lcolor(magenta)) /// 61
(line DayDeaMeRaA03S02U20210625 date, sort lcolor(magenta)) /// 62
(line DayDeaMeRaA03S02U20210703 date, sort lcolor(magenta)) /// 63
(line DayDeaMeRaA03S02U20210704 date, sort lcolor(magenta)) /// 64
(line DayDeaMeRaA03S02U20210709 date, sort lcolor(magenta)) /// 65
(line DayDeaMeSmA04S00U20210401 date, sort lcolor(gold)) /// 66 "LANL"
(line DayDeaMeSmA04S00U20210406 date, sort lcolor(gold)) /// 67
(line DayDeaMeSmA04S00U20210409 date, sort lcolor(gold)) /// 68
(line DayDeaMeSmA04S00U20210416 date, sort lcolor(gold)) /// 69
(line DayDeaMeSmA04S00U20210417 date, sort lcolor(gold)) /// 70 
(line DayDeaMeSmA04S00U20210423 date, sort lcolor(gold)) /// 71
(line DayDeaMeSmA04S00U20210424 date, sort lcolor(gold)) /// 72
(line DayDeaMeSmA04S00U20210506 date, sort lcolor(gold)) /// 73
(line DayDeaMeSmA04S00U20210514 date, sort lcolor(gold)) /// 75
(line DayDeaMeSmA04S00U20210515 date, sort lcolor(gold)) /// 75
(line DayDeaMeSmA04S00U20210516 date, sort lcolor(gold)) /// 76
(line DayDeaMeSmA04S00U20210521 date, sort lcolor(gold)) /// 77
(line DayDeaMeSmA04S00U20210522 date, sort lcolor(gold)) /// 78
(line DayDeaMeSmA04S00U20210528 date, sort lcolor(gold)) /// 79
(line DayDeaMeSmA04S00U20210603 date, sort lcolor(gold)) /// 80
(line DayDeaMeSmA04S00U20210604 date, sort lcolor(gold)) /// 81
(line DayDeaMeSmA04S00U20210605 date, sort lcolor(gold)) /// 82
(line DayDeaMeSmA04S00U20210610 date, sort lcolor(gold)) /// 83
(line DayDeaMeSmA04S00U20210611 date, sort lcolor(gold)) /// 84
(line DayDeaMeSmA04S00U20210618 date, sort lcolor(gold)) /// 85
(line DayDeaMeSmA04S00U20210624 date, sort lcolor(gold)) /// 86
(line DayDeaMeSmA04S00U20210625 date, sort lcolor(gold)) /// 87
(line DayDeaMeSmA04S00U20210703 date, sort lcolor(gold)) /// 88
(line DayDeaMeSmA04S00U20210704 date, sort lcolor(gold)) /// 89
(line DayDeaMeSmA04S00U20210709 date, sort lcolor(gold)) /// 90
(line DayDeaMeSmA05S00U20210401 date, sort lcolor(green)) /// 91 "SRIV"
(line DayDeaMeSmA05S00U20210406 date, sort lcolor(green)) /// 92
(line DayDeaMeSmA05S00U20210423 date, sort lcolor(green)) /// 93
(line DayDeaMeSmA05S00U20210424 date, sort lcolor(green)) /// 94
(line DayDeaMeSmA05S00U20210506 date, sort lcolor(green)) /// 95
(line DayDeaMeSmA05S00U20210514 date, sort lcolor(green)) /// 96
(line DayDeaMeSmA05S00U20210515 date, sort lcolor(green)) /// 97
(line DayDeaMeSmA05S00U20210516 date, sort lcolor(green)) /// 98
(line DayDeaMeSmA05S00U20210521 date, sort lcolor(green)) /// 99
(line DayDeaMeSmA05S00U20210522 date, sort lcolor(green)) /// 100
(line DayDeaMeSmA05S00U20210528 date, sort lcolor(green)) /// 101
(line DayDeaMeSmA05S00U20210603 date, sort lcolor(green)) /// 102
(line DayDeaMeSmA05S00U20210604 date, sort lcolor(green)) /// 103
(line DayDeaMeSmA05S00U20210605 date, sort lcolor(green)) /// 104
(line DayDeaMeSmA05S00U20210610 date, sort lcolor(green)) /// 105
(line DayDeaMeSmA05S00U20210611 date, sort lcolor(green)) /// 106
(line DayDeaMeSmA05S00U20210618 date, sort lcolor(green)) /// 107
(line DayDeaMeSmA05S00U20210624 date, sort lcolor(green)) /// 108
(line DayDeaMeSmA05S00U20210625 date, sort lcolor(green)) /// 109
(line DayDeaMeSmA05S00U20210703 date, sort lcolor(green)) /// 110
(line DayDeaMeSmA05S00U20210704 date, sort lcolor(red)) /// 111
(line DayDeaMeSmA05S00U20210709 date, sort lcolor(green)) /// 112
(line DayDeaMeSmA00S00 date, lcolor(cyan*1.2) lwidth(vthick)) /// 113
(line DayDeaMeSmA00S002p4 date, lcolor(cyan*1.2) lwidth(vthick) lpattern(dash)) /// 114
if date >= td(01apr2021) , ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("without extremes", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 25 "IHME" 50 "IMPE" 66 "LANL" 91 "SRIV" 113 "JOHN" 114 "JOHN*2.4") size(small) rows(1))		
  	   
qui graph save "graph 11b COVID-19 daily deaths, $country, wo extremes.gph", replace
qui graph export "graph 11b COVID-19 daily deaths, $country, wo extremes.pdf", replace






* total deaths, Absolute value, wo extremes


twoway  ///
(line TotDeaMeRaA01S00U20210401 date, sort lcolor(red)) /// 1 "DELP"
(line TotDeaMeRaA01S00U20210406 date, sort lcolor(red)) /// 2
(line TotDeaMeRaA01S00U20210409 date, sort lcolor(red)) /// 3
(line TotDeaMeRaA01S00U20210416 date, sort lcolor(red)) /// 4
(line TotDeaMeRaA01S00U20210417 date, sort lcolor(red)) /// 5
(line TotDeaMeRaA01S00U20210423 date, sort lcolor(red)) /// 6
(line TotDeaMeRaA01S00U20210424 date, sort lcolor(red)) /// 7
(line TotDeaMeRaA01S00U20210506 date, sort lcolor(red)) /// 8
(line TotDeaMeRaA01S00U20210514 date, sort lcolor(red)) /// 9
(line TotDeaMeRaA01S00U20210515 date, sort lcolor(red)) /// 10
(line TotDeaMeRaA01S00U20210516 date, sort lcolor(red)) /// 11
(line TotDeaMeRaA01S00U20210521 date, sort lcolor(red)) /// 12
(line TotDeaMeRaA01S00U20210522 date, sort lcolor(red)) /// 13
(line TotDeaMeRaA01S00U20210603 date, sort lcolor(red)) /// 14
(line TotDeaMeRaA01S00U20210604 date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20210605 date, sort lcolor(red)) /// 16
(line TotDeaMeRaA01S00U20210610 date, sort lcolor(red)) /// 17
(line TotDeaMeRaA01S00U20210611 date, sort lcolor(red)) /// 18
(line TotDeaMeRaA01S00U20210618 date, sort lcolor(red)) /// 19
(line TotDeaMeRaA01S00U20210624 date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210625 date, sort lcolor(red)) /// 21
(line TotDeaMeRaA01S00U20210703 date, sort lcolor(red)) /// 22
(line TotDeaMeRaA01S00U20210704 date, sort lcolor(red)) /// 23
(line TotDeaMeRaA01S00U20210709 date, sort lcolor(red)) /// 24
(line TotDeaMeSmA02S01U20210401 date, sort lcolor(black)) /// 25 IHME
(line TotDeaMeSmA02S01U20210406 date, sort lcolor(black)) /// 26
(line TotDeaMeSmA02S01U20210409 date, sort lcolor(black)) /// 27
(line TotDeaMeSmA02S01U20210416 date, sort lcolor(black)) /// 28
(line TotDeaMeSmA02S01U20210417 date, sort lcolor(black)) /// 29
(line TotDeaMeSmA02S01U20210423 date, sort lcolor(black)) /// 30
(line TotDeaMeSmA02S01U20210424 date, sort lcolor(black)) /// 31 IHME v3
(line TotDeaMeSmA02S01U20210506 date, sort lcolor(black)) /// 32 IHME v4 // 32 "IHME"
(line TotDeaMeSmA02S01U20210514 date, sort lcolor(black)) /// 33
(line TotDeaMeSmA02S01U20210515 date, sort lcolor(black)) /// 34
(line TotDeaMeSmA02S01U20210516 date, sort lcolor(black)) /// 35 
(line TotDeaMeSmA02S01U20210521 date, sort lcolor(black)) /// 36
(line TotDeaMeSmA02S01U20210522 date, sort lcolor(black)) /// 37
(line TotDeaMeSmA02S01U20210528 date, sort lcolor(black)) /// 38
(line TotDeaMeSmA02S01U20210603 date, sort lcolor(black)) /// 39
(line TotDeaMeSmA02S01U20210604 date, sort lcolor(black)) /// 40
(line TotDeaMeSmA02S01U20210605 date, sort lcolor(black)) /// 41
(line TotDeaMeSmA02S01U20210610 date, sort lcolor(black)) /// 42
(line TotDeaMeSmA02S01U20210611 date, sort lcolor(black)) /// 43
(line TotDeaMeSmA02S01U20210618 date, sort lcolor(black)) /// 44
(line TotDeaMeSmA02S01U20210624 date, sort lcolor(black)) /// 45
(line TotDeaMeSmA02S01U20210625 date, sort lcolor(black)) /// 46
(line TotDeaMeSmA02S01U20210703 date, sort lcolor(black)) /// 47
(line TotDeaMeSmA02S01U20210704 date, sort lcolor(black)) /// 48
(line TotDeaMeSmA02S01U20210709 date, sort lcolor(black)) /// 49
(line TotDeaMeRaA03S02U20210515 date, sort lcolor(magenta)) /// 50 IMPE v8 // 50 "IMPE"
(line TotDeaMeRaA03S02U20210516 date, sort lcolor(magenta)) /// 51
(line TotDeaMeRaA03S02U20210521 date, sort lcolor(magenta)) /// 52
(line TotDeaMeRaA03S02U20210522 date, sort lcolor(magenta)) /// 53
(line TotDeaMeRaA03S02U20210528 date, sort lcolor(magenta)) /// 54
(line TotDeaMeRaA03S02U20210603 date, sort lcolor(magenta)) /// 55
(line TotDeaMeRaA03S02U20210604 date, sort lcolor(magenta)) /// 56
(line TotDeaMeRaA03S02U20210605 date, sort lcolor(magenta)) /// 57
(line TotDeaMeRaA03S02U20210610 date, sort lcolor(magenta)) /// 58
(line TotDeaMeRaA03S02U20210611 date, sort lcolor(magenta)) /// 59
(line TotDeaMeRaA03S02U20210618 date, sort lcolor(magenta)) /// 60
(line TotDeaMeRaA03S02U20210624 date, sort lcolor(magenta)) /// 61
(line TotDeaMeRaA03S02U20210625 date, sort lcolor(magenta)) /// 62
(line TotDeaMeRaA03S02U20210703 date, sort lcolor(magenta)) /// 63
(line TotDeaMeRaA03S02U20210704 date, sort lcolor(magenta)) /// 64
(line TotDeaMeRaA03S02U20210709 date, sort lcolor(magenta)) /// 65
(line TotDeaMeRaA04S00U20210401 date, sort lcolor(gold)) /// 66 "LANL"
(line TotDeaMeRaA04S00U20210406 date, sort lcolor(gold)) /// 67
(line TotDeaMeRaA04S00U20210409 date, sort lcolor(gold)) /// 68
(line TotDeaMeRaA04S00U20210416 date, sort lcolor(gold)) /// 69
(line TotDeaMeRaA04S00U20210417 date, sort lcolor(gold)) /// 70 
(line TotDeaMeRaA04S00U20210423 date, sort lcolor(gold)) /// 71
(line TotDeaMeRaA04S00U20210424 date, sort lcolor(gold)) /// 72
(line TotDeaMeRaA04S00U20210506 date, sort lcolor(gold)) /// 73
(line TotDeaMeRaA04S00U20210514 date, sort lcolor(gold)) /// 75
(line TotDeaMeRaA04S00U20210515 date, sort lcolor(gold)) /// 75
(line TotDeaMeRaA04S00U20210516 date, sort lcolor(gold)) /// 76
(line TotDeaMeRaA04S00U20210521 date, sort lcolor(gold)) /// 77
(line TotDeaMeRaA04S00U20210522 date, sort lcolor(gold)) /// 78
(line TotDeaMeRaA04S00U20210528 date, sort lcolor(gold)) /// 79
(line TotDeaMeRaA04S00U20210603 date, sort lcolor(gold)) /// 80
(line TotDeaMeRaA04S00U20210604 date, sort lcolor(gold)) /// 81
(line TotDeaMeRaA04S00U20210605 date, sort lcolor(gold)) /// 82
(line TotDeaMeRaA04S00U20210610 date, sort lcolor(gold)) /// 83
(line TotDeaMeRaA04S00U20210611 date, sort lcolor(gold)) /// 84
(line TotDeaMeRaA04S00U20210618 date, sort lcolor(gold)) /// 85
(line TotDeaMeRaA04S00U20210624 date, sort lcolor(gold)) /// 86
(line TotDeaMeRaA04S00U20210625 date, sort lcolor(gold)) /// 87
(line TotDeaMeRaA04S00U20210703 date, sort lcolor(gold)) /// 88
(line TotDeaMeRaA04S00U20210704 date, sort lcolor(gold)) /// 89
(line TotDeaMeRaA04S00U20210709 date, sort lcolor(gold)) /// 90
(line TotDeaMeRaA05S00U20210401 date, sort lcolor(green)) /// 91 "SRIV"
(line TotDeaMeRaA05S00U20210406 date, sort lcolor(green)) /// 92
(line TotDeaMeRaA05S00U20210423 date, sort lcolor(green)) /// 93
(line TotDeaMeRaA05S00U20210424 date, sort lcolor(green)) /// 94
(line TotDeaMeRaA05S00U20210506 date, sort lcolor(green)) /// 95
(line TotDeaMeRaA05S00U20210514 date, sort lcolor(green)) /// 96
(line TotDeaMeRaA05S00U20210515 date, sort lcolor(green)) /// 97
(line TotDeaMeRaA05S00U20210516 date, sort lcolor(green)) /// 98
(line TotDeaMeRaA05S00U20210521 date, sort lcolor(green)) /// 99
(line TotDeaMeRaA05S00U20210522 date, sort lcolor(green)) /// 100
(line TotDeaMeRaA05S00U20210528 date, sort lcolor(green)) /// 101
(line TotDeaMeRaA05S00U20210603 date, sort lcolor(green)) /// 102
(line TotDeaMeRaA05S00U20210604 date, sort lcolor(green)) /// 103
(line TotDeaMeRaA05S00U20210605 date, sort lcolor(green)) /// 104
(line TotDeaMeRaA05S00U20210610 date, sort lcolor(green)) /// 105
(line TotDeaMeRaA05S00U20210611 date, sort lcolor(green)) /// 106
(line TotDeaMeRaA05S00U20210618 date, sort lcolor(green)) /// 107
(line TotDeaMeRaA05S00U20210624 date, sort lcolor(green)) /// 108
(line TotDeaMeRaA05S00U20210625 date, sort lcolor(green)) /// 109
(line TotDeaMeRaA05S00U20210703 date, sort lcolor(green)) /// 110
(line TotDeaMeRaA05S00U20210704 date, sort lcolor(red)) /// 111
(line TotDeaMeRaA05S00U20210709 date, sort lcolor(green)) /// 112
(line TotDeaMeRaA00S00 date, lcolor(cyan*1.2) lwidth(vthick)) /// 113
(line TotDeaMeRaA00S002p4 date, lcolor(cyan*1.2) lwidth(vthick) lpattern(dash)) /// 114
if date >= td(01apr2021) , ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("without extremes", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP" 25 "IHME" 50 "IMPE" 66 "LANL" 91 "SRIV" 113 "JOHN" 114 "JOHN*2.4") size(small) rows(1))		
  	   
qui graph save "graph 12b COVID-19 total deaths, $country, wo extremes.gph", replace
qui graph export "graph 12b COVID-19 total deaths, $country, wo extremes.pdf", replace











************

* restore native scheme (of the local machine)

set scheme $nativescheme

di c(scheme)


view "log country merge.smcl"

log close

exit, clear



