
clear all
 
cd "$pathcovir2"

cd IHME

capture log close 

log using "log country IHME.smcl", replace

******************************************************************************
* This is "do country IHME.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare IHME data for country
******************************************************************************



* read model estimates from each uptake


local uptakedatelist ///
20210401 20210406 20210409 20210416 20210417 ///
20210423 20210424 20210506 20210514 20210515 ///
20210516 20210521 20210522 20210528 20210603 ///
20210604 20210605 20210610 20210611 20210618 ///
20210624 20210625 20210703 20210704 20210709


foreach l of local uptakedatelist {

qui {

cd "$pathcovir2" // "/Users/`usrnam'/Downloads/covir2-main/longitudinal/20210709/code"

cd .. // 20210709

cd .. // longitudinal

cd .. //  covir2-main

cd `l'

cd output

cd merge

use "country.dta", clear 

* keep model estimates

keep date loc_grand_name ///
DayDeaMeSmA02S01 DayINFMeRaA02S01 TotDeaMeSmA02S01 TotINFMeRaA02S01


* add uptake dte to the end of varname

local varlist ///
DayDeaMeSmA02S01 DayINFMeRaA02S01 TotDeaMeSmA02S01 TotINFMeRaA02S01

	foreach v of local varlist {
	
	rename `v' `v'U`l'

	}
	*

  

qui compress

cd .. // merge

cd .. // output

cd .. // `l'

cd longitudinal 

cd 20210709

cd code

cd IHME

save "`l'.dta", replace

}

}
*



* merge individual uptake files

local uptakedatelist ///
20210401 20210406 20210409 20210416 20210417 ///
20210423 20210424 20210506 20210514 20210515 ///
20210516 20210521 20210522 20210528 20210603 ///
20210604 20210605 20210610 20210611 20210618 ///
20210624 20210625 20210703 20210704 20210709


foreach l of local uptakedatelist {

merge 1:1 date loc_grand_name using "`l'.dta"

drop _merge

}
*

sort date loc_grand_name

save "country IHME.dta", replace




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

keep date loc_grand_name DayDeaMeSmA00S00 TotDeaMeRaA00S00 DayCasMeSmA00S00 TotCasMeRaA00S00

sort date loc_grand_name

cd .. // output

cd .. // 20210709

cd .. //  covir2-main

cd longitudinal 

cd 20210709

cd code

cd IHME

save "JOHN.dta", replace


}
*


merge date loc_grand_name using "country IHME.dta"

drop _merge


local uptakedatelist ///
20210401 20210406 20210409 20210416 20210417 ///
20210423 20210424 20210506 20210514 20210515 ///
20210516 20210521 20210522 20210528 20210603 ///
20210604 20210605 20210610 20210611 20210618 ///
20210624 20210625 20210703 20210704 20210709


foreach l of local uptakedatelist {

gen DayDeaMeSmA02S01U`l'D = DayDeaMeSmA02S01U`l' - DayDeaMeSmA00S00 // D Difference 
gen DayDeaMeSmA02S01U`l'T = DayDeaMeSmA02S01U`l' / DayDeaMeSmA00S00 // T Times (more or less)
gen DayDeaMeSmA02S01U`l'P = 100 * (DayDeaMeSmA02S01U`l' - DayDeaMeSmA00S00) / DayDeaMeSmA00S00 // P Percent

gen DayINFMeRaA02S01U`l'D = DayINFMeRaA02S01U`l' - DayCasMeSmA00S00 // D Difference 
gen DayINFMeRaA02S01U`l'T = DayINFMeRaA02S01U`l' / DayCasMeSmA00S00 // T Times (more or less)
gen DayINFMeRaA02S01U`l'P = 100 * (DayINFMeRaA02S01U`l' - DayCasMeSmA00S00) / DayCasMeSmA00S00 // P Percent

gen TotDeaMeSmA02S01U`l'D = TotDeaMeSmA02S01U`l' - TotDeaMeRaA00S00 // D Difference 
gen TotDeaMeSmA02S01U`l'T = TotDeaMeSmA02S01U`l' / TotDeaMeRaA00S00 // T Times (more or less)
gen TotDeaMeSmA02S01U`l'P = 100 * (TotDeaMeSmA02S01U`l' - TotDeaMeRaA00S00) / TotDeaMeRaA00S00 // P Percent

gen TotINFMeRaA02S01U`l'D = TotINFMeRaA02S01U`l' - TotCasMeRaA00S00 // D Difference 
gen TotINFMeRaA02S01U`l'T = TotINFMeRaA02S01U`l' / TotCasMeRaA00S00 // T Times (more or less)
gen TotINFMeRaA02S01U`l'P = 100 * (TotINFMeRaA02S01U`l' - TotCasMeRaA00S00) / TotCasMeRaA00S00 // P Percent 

}
*



save "country IHME.dta", replace



* IHME correction for under-reporting of deaths
* starting from update 20210506
* last uncorrected 20210424



**********************************************************

* graphs


grstyle init

grstyle color background white




* daily deaths

**************************************

* daily deaths, Absolute value

twoway  ///
(line DayDeaMeSmA02S01U20210401 date, sort lcolor(black) lpattern(dash)) /// 1
(line DayDeaMeSmA02S01U20210406 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210409 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210416 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210417 date, sort lcolor(black) lpattern(dash)) /// 5
(line DayDeaMeSmA02S01U20210423 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210424 date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line DayDeaMeSmA02S01U20210506 date, sort lcolor(black)) /// 8 20210506
(line DayDeaMeSmA02S01U20210514 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210515 date, sort lcolor(black)) /// 10
(line DayDeaMeSmA02S01U20210516 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210521 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210522 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210528 date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210603 date, sort lcolor(black)) /// 15
(line DayDeaMeSmA02S01U20210604 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210605 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210610 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210611 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210618 date, sort lcolor(black)) /// 20
(line DayDeaMeSmA02S01U20210624 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210625 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210703 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210704 date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210709 date, sort lcolor(black)) /// 25
(line DayDeaMeSmA00S00 date, lcolor(cyan) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4" 26 "JOHN raw") size(small) rows(1)) yscale(titlegap(2))	
  	   
qui graph save "graph 11a COVID-19 daily deaths, $country, IHME.gph", replace
qui graph export "graph 11a COVID-19 daily deaths, $country, IHME.pdf", replace



*********

* daily deaths, Difference

twoway  ///
(line DayDeaMeSmA02S01U20210401D date, sort lcolor(black) lpattern(dash)) /// 1
(line DayDeaMeSmA02S01U20210406D date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210409D date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210416D date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210417D date, sort lcolor(black) lpattern(dash)) /// 5
(line DayDeaMeSmA02S01U20210423D date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210424D date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line DayDeaMeSmA02S01U20210506D date, sort lcolor(black)) /// 8 20210506
(line DayDeaMeSmA02S01U20210514D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210515D date, sort lcolor(black)) /// 10
(line DayDeaMeSmA02S01U20210516D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210521D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210522D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210528D date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210603D date, sort lcolor(black)) /// 15
(line DayDeaMeSmA02S01U20210604D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210605D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210610D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210611D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210618D date, sort lcolor(black)) /// 20
(line DayDeaMeSmA02S01U20210624D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210625D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210703D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210704D date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210709D date, sort lcolor(black)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths IHME minus JOHN smooth) title("COVID-19 daily deaths, $country, IHME minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 12a COVID-19 daily deaths, $country, IHME, Difference.gph", replace
qui graph export "graph 12a COVID-19 daily deaths, $country, IHME, Difference.pdf", replace





*********

* daily deaths, Times

twoway  ///
(line DayDeaMeSmA02S01U20210401T date, sort lcolor(black) lpattern(dash)) /// 1
(line DayDeaMeSmA02S01U20210406T date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210409T date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210416T date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210417T date, sort lcolor(black) lpattern(dash)) /// 5
(line DayDeaMeSmA02S01U20210423T date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210424T date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line DayDeaMeSmA02S01U20210506T date, sort lcolor(black)) /// 8 20210506
(line DayDeaMeSmA02S01U20210514T date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210515T date, sort lcolor(black)) /// 10
(line DayDeaMeSmA02S01U20210516T date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210521T date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210522T date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210528T date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210603T date, sort lcolor(black)) /// 15
(line DayDeaMeSmA02S01U20210604T date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210605T date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210610T date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210611T date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210618T date, sort lcolor(black)) /// 20
(line DayDeaMeSmA02S01U20210624T date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210625T date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210703T date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210704T date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210709T date, sort lcolor(black)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths IHME divided by JOHN smooth) title("COVID-19 daily deaths, $country, IHME divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 13a COVID-19 daily deaths, $country, IHME, Times.gph", replace
qui graph export "graph 13a COVID-19 daily deaths, $country, IHME, Times.pdf", replace




*********

* daily deaths, Percent

twoway  ///
(line DayDeaMeSmA02S01U20210401P date, sort lcolor(black) lpattern(dash)) /// 1
(line DayDeaMeSmA02S01U20210406P date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210409P date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210416P date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210417P date, sort lcolor(black) lpattern(dash)) /// 5
(line DayDeaMeSmA02S01U20210423P date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA02S01U20210424P date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line DayDeaMeSmA02S01U20210506P date, sort lcolor(black)) /// 8 20210506
(line DayDeaMeSmA02S01U20210514P date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210515P date, sort lcolor(black)) /// 10
(line DayDeaMeSmA02S01U20210516P date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210521P date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210522P date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210528P date, sort lcolor(black)) /// 
(line DayDeaMeSmA02S01U20210603P date, sort lcolor(black)) /// 15
(line DayDeaMeSmA02S01U20210604P date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210605P date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210610P date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210611P date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210618P date, sort lcolor(black)) /// 20
(line DayDeaMeSmA02S01U20210624P date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210625P date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210703P date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210704P date, sort lcolor(black)) ///
(line DayDeaMeSmA02S01U20210709P date, sort lcolor(black)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths IHME percent JOHN) title("COVID-19 daily deaths, $country, IHME percent JOH", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 14a COVID-19 daily deaths, $country, IHME, Percent.gph", replace
qui graph export "graph 14a COVID-19 daily deaths, $country, IHME, Percent.pdf", replace











* daily infections

**************************************



* daily infections, Absolute value

twoway  ///
(line DayINFMeRaA02S01U20210401 date, sort lcolor(black) lpattern(dash)) /// 1
(line DayINFMeRaA02S01U20210406 date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210409 date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210416 date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210417 date, sort lcolor(black) lpattern(dash)) /// 5
(line DayINFMeRaA02S01U20210423 date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210424 date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line DayINFMeRaA02S01U20210506 date, sort lcolor(black)) /// 8 20210506
(line DayINFMeRaA02S01U20210514 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210515 date, sort lcolor(black)) /// 10
(line DayINFMeRaA02S01U20210516 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210521 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210522 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210528 date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210603 date, sort lcolor(black)) /// 15
(line DayINFMeRaA02S01U20210604 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210605 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210610 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210611 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210618 date, sort lcolor(black)) /// 20
(line DayINFMeRaA02S01U20210624 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210625 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210703 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210704 date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210709 date, sort lcolor(black)) /// 25
(line DayCasMeSmA00S00 date, lcolor(cyan) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections or cases) title("COVID-19 daily infections, $country, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4" 26 "JOHN cases") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 21a COVID-19 daily infections, $country, IHME.gph", replace
qui graph export "graph 21a COVID-19 daily infections, $country, IHME.pdf", replace






*********

* daily infections, Difference

twoway  ///
(line DayINFMeRaA02S01U20210401D date, sort lcolor(black) lpattern(dash)) /// 1
(line DayINFMeRaA02S01U20210406D date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210409D date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210416D date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210417D date, sort lcolor(black) lpattern(dash)) /// 5
(line DayINFMeRaA02S01U20210423D date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210424D date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line DayINFMeRaA02S01U20210506D date, sort lcolor(black)) /// 8 20210506
(line DayINFMeRaA02S01U20210514D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210515D date, sort lcolor(black)) /// 10
(line DayINFMeRaA02S01U20210516D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210521D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210522D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210528D date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210603D date, sort lcolor(black)) /// 15
(line DayINFMeRaA02S01U20210604D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210605D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210610D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210611D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210618D date, sort lcolor(black)) /// 20
(line DayINFMeRaA02S01U20210624D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210625D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210703D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210704D date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210709D date, sort lcolor(black)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections minus JOHN cases) title("COVID-19 daily infections, $country, IHME infections minus cases JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 22a COVID-19 daily infections, $country, IHME, Difference.gph", replace
qui graph export "graph 22a COVID-19 daily infections, $country, IHME, Difference.pdf", replace






*********

* daily infections, Times

twoway  ///
(line DayINFMeRaA02S01U20210401T date, sort lcolor(black) lpattern(dash)) /// 1
(line DayINFMeRaA02S01U20210406T date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210409T date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210416T date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210417T date, sort lcolor(black) lpattern(dash)) /// 5
(line DayINFMeRaA02S01U20210423T date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210424T date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line DayINFMeRaA02S01U20210506T date, sort lcolor(black)) /// 8 20210506
(line DayINFMeRaA02S01U20210514T date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210515T date, sort lcolor(black)) /// 10
(line DayINFMeRaA02S01U20210516T date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210521T date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210522T date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210528T date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210603T date, sort lcolor(black)) /// 15
(line DayINFMeRaA02S01U20210604T date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210605T date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210610T date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210611T date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210618T date, sort lcolor(black)) /// 20
(line DayINFMeRaA02S01U20210624T date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210625T date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210703T date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210704T date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210709T date, sort lcolor(black)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections divided by JOHN cases) title("COVID-19 daily infections, $country, IHME infections divided by JOHN cases ", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 23a COVID-19 daily infections, $country, IHME, Times.gph", replace
qui graph export "graph 23a COVID-19 daily infections, $country, IHME, Times.pdf", replace








*********

* daily infections, Percent

twoway  ///
(line DayINFMeRaA02S01U20210401P date, sort lcolor(black) lpattern(dash)) /// 1
(line DayINFMeRaA02S01U20210406P date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210409P date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210416P date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210417P date, sort lcolor(black) lpattern(dash)) /// 5
(line DayINFMeRaA02S01U20210423P date, sort lcolor(black) lpattern(dash)) ///
(line DayINFMeRaA02S01U20210424P date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line DayINFMeRaA02S01U20210506P date, sort lcolor(black)) /// 8 20210506
(line DayINFMeRaA02S01U20210514P date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210515P date, sort lcolor(black)) /// 10
(line DayINFMeRaA02S01U20210516P date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210521P date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210522P date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210528P date, sort lcolor(black)) /// 
(line DayINFMeRaA02S01U20210603P date, sort lcolor(black)) /// 15
(line DayINFMeRaA02S01U20210604P date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210605P date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210610P date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210611P date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210618P date, sort lcolor(black)) /// 20
(line DayINFMeRaA02S01U20210624P date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210625P date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210703P date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210704P date, sort lcolor(black)) ///
(line DayINFMeRaA02S01U20210709P date, sort lcolor(black)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections percent JOHN cases) title("COVID-19 daily infections percent, $country, IHME percent JOHN cases", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Daily infections percent JOHN cases = 100 (IHME infections minus JOHN cases) / JOHN cases" ///
"reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 24a COVID-19 daily infections, $country, IHME, Percent.gph", replace
qui graph export "graph 24a COVID-19 daily infections, $country, IHME, Percent.pdf", replace


















* total deaths

**************************************

* total deaths, Absolute value

twoway  ///
(line TotDeaMeSmA02S01U20210401 date, sort lcolor(black) lpattern(dash)) /// 1
(line TotDeaMeSmA02S01U20210406 date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210409 date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210416 date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210417 date, sort lcolor(black) lpattern(dash)) /// 5
(line TotDeaMeSmA02S01U20210423 date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210424 date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line TotDeaMeSmA02S01U20210506 date, sort lcolor(black)) /// 8 20210506
(line TotDeaMeSmA02S01U20210514 date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210515 date, sort lcolor(black)) /// 10
(line TotDeaMeSmA02S01U20210516 date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210521 date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210522 date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210528 date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210603 date, sort lcolor(black)) /// 15
(line TotDeaMeSmA02S01U20210604 date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210605 date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210610 date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210611 date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210618 date, sort lcolor(black)) /// 20
(line TotDeaMeSmA02S01U20210624 date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210625 date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210703 date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210704 date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210709 date, sort lcolor(black)) /// 25
(line TotDeaMeRaA00S00 date, lcolor(cyan) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4" 26 "JOHN") size(small) rows(1)) yscale(titlegap(2))	
  	   
qui graph save "graph 31a COVID-19 total deaths, $country, IHME.gph", replace
qui graph export "graph 31a COVID-19 total deaths, $country, IHME.pdf", replace







*********

* total deaths, Difference

twoway  ///
(line TotDeaMeSmA02S01U20210401D date, sort lcolor(black) lpattern(dash)) /// 1
(line TotDeaMeSmA02S01U20210406D date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210409D date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210416D date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210417D date, sort lcolor(black) lpattern(dash)) /// 5
(line TotDeaMeSmA02S01U20210423D date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210424D date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line TotDeaMeSmA02S01U20210506D date, sort lcolor(black)) /// 8 20210506
(line TotDeaMeSmA02S01U20210514D date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210515D date, sort lcolor(black)) /// 10
(line TotDeaMeSmA02S01U20210516D date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210521D date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210522D date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210528D date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210603D date, sort lcolor(black)) /// 15
(line TotDeaMeSmA02S01U20210604D date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210605D date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210610D date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210611D date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210618D date, sort lcolor(black)) /// 20
(line TotDeaMeSmA02S01U20210624D date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210625D date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210703D date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210704D date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210709D date, sort lcolor(black)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths IHME minus JOHN) title("COVID-19 total deaths, $country, IHME minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 32a COVID-19 total deaths, $country, IHME, Difference.gph", replace
qui graph export "graph 32a COVID-19 total deaths, $country, IHME, Difference.pdf", replace







*********

* total deaths, Times

twoway  ///
(line TotDeaMeSmA02S01U20210401T date, sort lcolor(black) lpattern(dash)) /// 1
(line TotDeaMeSmA02S01U20210406T date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210409T date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210416T date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210417T date, sort lcolor(black) lpattern(dash)) /// 5
(line TotDeaMeSmA02S01U20210423T date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210424T date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line TotDeaMeSmA02S01U20210506T date, sort lcolor(black)) /// 8 20210506
(line TotDeaMeSmA02S01U20210514T date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210515T date, sort lcolor(black)) /// 10
(line TotDeaMeSmA02S01U20210516T date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210521T date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210522T date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210528T date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210603T date, sort lcolor(black)) /// 15
(line TotDeaMeSmA02S01U20210604T date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210605T date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210610T date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210611T date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210618T date, sort lcolor(black)) /// 20
(line TotDeaMeSmA02S01U20210624T date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210625T date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210703T date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210704T date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210709T date, sort lcolor(black)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths IHME divided by JOHN) title("COVID-19 total deaths, $country, IHME divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 33a COVID-19 total deaths, $country, IHME, Times.gph", replace
qui graph export "graph 33a COVID-19 total deaths, $country, IHME, Times.pdf", replace




*********

* total deaths, Percent

twoway  ///
(line TotDeaMeSmA02S01U20210401P date, sort lcolor(black) lpattern(dash)) /// 1
(line TotDeaMeSmA02S01U20210406P date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210409P date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210416P date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210417P date, sort lcolor(black) lpattern(dash)) /// 5
(line TotDeaMeSmA02S01U20210423P date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeSmA02S01U20210424P date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line TotDeaMeSmA02S01U20210506P date, sort lcolor(black)) /// 8 20210506
(line TotDeaMeSmA02S01U20210514P date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210515P date, sort lcolor(black)) /// 10
(line TotDeaMeSmA02S01U20210516P date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210521P date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210522P date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210528P date, sort lcolor(black)) /// 
(line TotDeaMeSmA02S01U20210603P date, sort lcolor(black)) /// 15
(line TotDeaMeSmA02S01U20210604P date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210605P date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210610P date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210611P date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210618P date, sort lcolor(black)) /// 20
(line TotDeaMeSmA02S01U20210624P date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210625P date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210703P date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210704P date, sort lcolor(black)) ///
(line TotDeaMeSmA02S01U20210709P date, sort lcolor(black)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths IHME percent JOHN) title("COVID-19 total deaths, $country, Total deaths IHME percent JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Total deaths IHME percent JOHN = 100 (IHME deaths minus JOHN deaths) / JOHN deaths" ///
"reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 34a COVID-19 total deaths, $country, IHME, Percent.gph", replace
qui graph export "graph 34a COVID-19 total deaths, $country, IHME, Percent.pdf", replace
















* total infections

**************************************



* total infections, Absolute value

twoway  ///
(line TotINFMeRaA02S01U20210401 date, sort lcolor(black) lpattern(dash)) /// 1
(line TotINFMeRaA02S01U20210406 date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210409 date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210416 date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210417 date, sort lcolor(black) lpattern(dash)) /// 5
(line TotINFMeRaA02S01U20210423 date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210424 date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line TotINFMeRaA02S01U20210506 date, sort lcolor(black)) /// 8 20210506
(line TotINFMeRaA02S01U20210514 date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210515 date, sort lcolor(black)) /// 10
(line TotINFMeRaA02S01U20210516 date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210521 date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210522 date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210528 date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210603 date, sort lcolor(black)) /// 15
(line TotINFMeRaA02S01U20210604 date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210605 date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210610 date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210611 date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210618 date, sort lcolor(black)) /// 20
(line TotINFMeRaA02S01U20210624 date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210625 date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210703 date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210704 date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210709 date, sort lcolor(black)) /// 25
(line TotCasMeRaA00S00 date, lcolor(cyan) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total infections or cases) title("COVID-19 total infections, $country, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4" 26 "JOHN cases") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 41a COVID-19 total infections, $country, IHME.gph", replace
qui graph export "graph 41a COVID-19 total infections, $country, IHME.pdf", replace






*********

* total infections, Difference

twoway  ///
(line TotINFMeRaA02S01U20210401D date, sort lcolor(black) lpattern(dash)) /// 1
(line TotINFMeRaA02S01U20210406D date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210409D date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210416D date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210417D date, sort lcolor(black) lpattern(dash)) /// 5
(line TotINFMeRaA02S01U20210423D date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210424D date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line TotINFMeRaA02S01U20210506D date, sort lcolor(black)) /// 8 20210506
(line TotINFMeRaA02S01U20210514D date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210515D date, sort lcolor(black)) /// 10
(line TotINFMeRaA02S01U20210516D date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210521D date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210522D date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210528D date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210603D date, sort lcolor(black)) /// 15
(line TotINFMeRaA02S01U20210604D date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210605D date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210610D date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210611D date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210618D date, sort lcolor(black)) /// 20
(line TotINFMeRaA02S01U20210624D date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210625D date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210703D date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210704D date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210709D date, sort lcolor(black)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total infections IHME minus JOHN cases) title("COVID-19 total infections, $country, infections IHME minus cases JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 42a COVID-19 total infections, $country, IHME, Difference.gph", replace
qui graph export "graph 42a COVID-19 total infections, $country, IHME, Difference.pdf", replace





*********

* total infections, Times

twoway  ///
(line TotINFMeRaA02S01U20210401T date, sort lcolor(black) lpattern(dash)) /// 1
(line TotINFMeRaA02S01U20210406T date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210409T date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210416T date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210417T date, sort lcolor(black) lpattern(dash)) /// 5
(line TotINFMeRaA02S01U20210423T date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210424T date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line TotINFMeRaA02S01U20210506T date, sort lcolor(black)) /// 8 20210506
(line TotINFMeRaA02S01U20210514T date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210515T date, sort lcolor(black)) /// 10
(line TotINFMeRaA02S01U20210516T date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210521T date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210522T date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210528T date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210603T date, sort lcolor(black)) /// 15
(line TotINFMeRaA02S01U20210604T date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210605T date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210610T date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210611T date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210618T date, sort lcolor(black)) /// 20
(line TotINFMeRaA02S01U20210624T date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210625T date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210703T date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210704T date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210709T date, sort lcolor(black)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total infections IHME divided by JOHN cases) title("COVID-19 total infections, $country, infections IHME divided by cases JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4") size(small) rows(1)) yscale(titlegap(2))	
  	   
qui graph save "graph 43a COVID-19 total infections, $country, IHME, Times.gph", replace
qui graph export "graph 43a COVID-19 total infections, $country, IHME, Times.pdf", replace






*********

* total infections, Percent

twoway  ///
(line TotINFMeRaA02S01U20210401P date, sort lcolor(black) lpattern(dash)) /// 1
(line TotINFMeRaA02S01U20210406P date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210409P date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210416P date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210417P date, sort lcolor(black) lpattern(dash)) /// 5
(line TotINFMeRaA02S01U20210423P date, sort lcolor(black) lpattern(dash)) ///
(line TotINFMeRaA02S01U20210424P date, sort lcolor(black) lpattern(dash)) /// 7 20210424
(line TotINFMeRaA02S01U20210506P date, sort lcolor(black)) /// 8 20210506
(line TotINFMeRaA02S01U20210514P date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210515P date, sort lcolor(black)) /// 10
(line TotINFMeRaA02S01U20210516P date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210521P date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210522P date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210528P date, sort lcolor(black)) /// 
(line TotINFMeRaA02S01U20210603P date, sort lcolor(black)) /// 15
(line TotINFMeRaA02S01U20210604P date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210605P date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210610P date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210611P date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210618P date, sort lcolor(black)) /// 20
(line TotINFMeRaA02S01U20210624P date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210625P date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210703P date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210704P date, sort lcolor(black)) ///
(line TotINFMeRaA02S01U20210709P date, sort lcolor(black)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total infections IHME percent JOHN cases) title("COVID-19 total infections, $country, IHME percent JOHN cases", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Total infections IHME percent JOHN cases = 100 (IHME infections minus JOHN cases) / JOHN cases" ///
"reference scenario; model v3 and v4: without and with correction for death under-reporting", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(7 "IHME model v3" 8 "IHME model v4") size(small) rows(1))  yscale(titlegap(2))	
  	   
qui graph save "graph 44a COVID-19 total infections, $country, IHME, Percent.gph", replace
qui graph export "graph 44a COVID-19 total infections, $country, IHME, Percent.pdf", replace







view "log country IHME.smcl"

log close

exit, clear




