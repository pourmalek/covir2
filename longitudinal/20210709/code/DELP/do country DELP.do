
clear all
 
cd "$pathcovir2"

cd DELP

capture log close 

log using "log country DELP.smcl", replace

******************************************************************************
* This is "do country DELP.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare DELPHI data for country
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
DayDeaMeRaA01S00 DayCasMeRaA01S00 TotDeaMeRaA01S00 TotCasMeRaA01S00


* add uptake dte to the end of varname

local varlist ///
DayDeaMeRaA01S00 DayCasMeRaA01S00 TotDeaMeRaA01S00 TotCasMeRaA01S00

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

cd DELP

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

save "country DELP.dta", replace




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

cd DELP

save "JOHN.dta", replace


}
*


merge date loc_grand_name using "country DELP.dta"

drop _merge


local uptakedatelist ///
20210401 20210406 20210409 20210416 20210417 ///
20210423 20210424 20210506 20210514 20210515 ///
20210516 20210521 20210522 20210528 20210603 ///
20210604 20210605 20210610 20210611 20210618 ///
20210624 20210625 20210703 20210704 20210709


foreach l of local uptakedatelist {

gen DayDeaMeRaA01S00U`l'D = DayDeaMeRaA01S00U`l' - DayDeaMeSmA00S00 // D Difference 
gen DayDeaMeRaA01S00U`l'T = DayDeaMeRaA01S00U`l' / DayDeaMeSmA00S00 // T Times (more or less)
gen DayDeaMeRaA01S00U`l'P = 100 * (DayDeaMeRaA01S00U`l' - DayDeaMeSmA00S00) / DayDeaMeSmA00S00 // P Percent

gen DayCasMeRaA01S00U`l'D = DayCasMeRaA01S00U`l' - DayCasMeSmA00S00 // D Difference 
gen DayCasMeRaA01S00U`l'T = DayCasMeRaA01S00U`l' / DayCasMeSmA00S00 // T Times (more or less)
gen DayCasMeRaA01S00U`l'P = 100 * (DayCasMeRaA01S00U`l' - DayCasMeSmA00S00) / DayCasMeSmA00S00 // P Percent

gen TotDeaMeRaA01S00U`l'D = TotDeaMeRaA01S00U`l' - TotDeaMeRaA00S00 // D Difference 
gen TotDeaMeRaA01S00U`l'T = TotDeaMeRaA01S00U`l' / TotDeaMeRaA00S00 // T Times (more or less)
gen TotDeaMeRaA01S00U`l'P = 100 * (TotDeaMeRaA01S00U`l' - TotDeaMeRaA00S00) / TotDeaMeRaA00S00 // P Percent

gen TotCasMeRaA01S00U`l'D = TotCasMeRaA01S00U`l' - TotCasMeRaA00S00 // D Difference 
gen TotCasMeRaA01S00U`l'T = TotCasMeRaA01S00U`l' / TotCasMeRaA00S00 // T Times (more or less)
gen TotCasMeRaA01S00U`l'P = 100 * (TotCasMeRaA01S00U`l' - TotCasMeRaA00S00) / TotCasMeRaA00S00 // P Percent 

}
*



save "country DELP.dta", replace





**********************************************************

* graphs


grstyle init

grstyle color background white




* daily deaths

**************************************

* daily deaths, Absolute value

twoway  ///
(line DayDeaMeRaA01S00U20210401 date, sort lcolor(red)) /// 1
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
(line DayDeaMeRaA01S00U20210528 date, sort lcolor(red)) /// 
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
(line DayDeaMeSmA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; with extreme uptake 20210528", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(25 "DELP" 26 "JOHN raw") size(small))	
  	   
qui graph save "graph 11a COVID-19 daily deaths, $country, DELP.gph", replace
qui graph export "graph 11a COVID-19 daily deaths, $country, DELP.pdf", replace





*********

* daily deaths, wo extreme 20210528, Absolute value

twoway  ///
(line DayDeaMeRaA01S00U20210401 date, sort lcolor(red)) /// 1
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
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium)) /// 25
(line DayDeaMeSmA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(24 "DELP" 25 "JOHN raw" 26 "JOHN smooth") size(small) rows(1))		
  	   
qui graph save "graph 11b COVID-19 daily deaths, $country, DELP, wo extreme.gph", replace
qui graph export "graph 11b COVID-19 daily deaths, $country, DELP, wo extreme.pdf", replace


*


*********

* daily deaths, Difference

twoway  ///
(line DayDeaMeRaA01S00U20210401D date, sort lcolor(red)) /// 1
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
(line DayDeaMeRaA01S00U20210528D date, sort lcolor(red)) /// 
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
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths DELP minus JOHN smooth) title("COVID-19 daily deaths, $country, DELP minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario; with extreme uptake 20210528", size(small))
  	   
qui graph save "graph 12a COVID-19 daily deaths, $country, DELP, Difference.gph", replace
qui graph export "graph 12a COVID-19 daily deaths, $country, DELP, Difference.pdf", replace





*********

* daily deaths, wo extreme 20210528, Difference

twoway  ///
(line DayDeaMeRaA01S00U20210401D date, sort lcolor(red)) /// 1
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
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths DELP divided by JOHN smooth) title("COVID-19 daily deaths, $country, DELP minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(off) ///
  	   
qui graph save "graph 12b COVID-19 daily deaths, $country, DELP, wo extreme, Difference.gph", replace
qui graph export "graph 12b COVID-19 daily deaths, $country, DELP, wo extreme, Difference.pdf", replace




*


*********

* daily deaths, Times

twoway  ///
(line DayDeaMeRaA01S00U20210401T date, sort lcolor(red)) /// 1
(line DayDeaMeRaA01S00U20210406T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210409T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210416T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210417T date, sort lcolor(red)) /// 5
(line DayDeaMeRaA01S00U20210423T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210424T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210506T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210514T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210515T date, sort lcolor(red)) /// 10
(line DayDeaMeRaA01S00U20210516T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210521T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210522T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210528T date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210603T date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20210604T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210605T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210610T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210611T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210618T date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210624T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210625T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210703T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210704T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210709T date, sort lcolor(red)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths DELP divided by JOHN smooth) title("COVID-19 daily deaths, $country, DELP divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario; with extreme uptake 20210528", size(small))
  	   
qui graph save "graph 13a COVID-19 daily deaths, $country, DELP, Times.gph", replace
qui graph export "graph 13a COVID-19 daily deaths, $country, DELP, Times.pdf", replace





*********

* daily deaths, wo extreme 20210528, Times

twoway  ///
(line DayDeaMeRaA01S00U20210401T date, sort lcolor(red)) /// 1
(line DayDeaMeRaA01S00U20210406T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210409T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210416T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210417T date, sort lcolor(red)) /// 5
(line DayDeaMeRaA01S00U20210423T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210424T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210506T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210514T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210515T date, sort lcolor(red)) /// 10
(line DayDeaMeRaA01S00U20210516T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210521T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210522T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210603T date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210604T date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20210605T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210610T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210611T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210618T date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210624T date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210625T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210703T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210704T date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210709T date, sort lcolor(red)) /// 24
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths DELP divided by JOHN smooth) title("COVID-19 daily deaths, $country, DELP divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(off) ///
  	   
qui graph save "graph 13b COVID-19 daily deaths, $country, DELP, wo extreme, Times.gph", replace
qui graph export "graph 13b COVID-19 daily deaths, $country, DELP, wo extreme, Times.pdf", replace




*


*********

* daily deaths, Percent

twoway  ///
(line DayDeaMeRaA01S00U20210401P date, sort lcolor(red)) /// 1
(line DayDeaMeRaA01S00U20210406P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210409P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210416P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210417P date, sort lcolor(red)) /// 5
(line DayDeaMeRaA01S00U20210423P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210424P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210506P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210514P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210515P date, sort lcolor(red)) /// 10
(line DayDeaMeRaA01S00U20210516P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210521P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210522P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210528P date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210603P date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20210604P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210605P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210610P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210611P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210618P date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210624P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210625P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210703P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210704P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210709P date, sort lcolor(red)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths DELP percent JOHN smooth) title("COVID-19 daily deaths, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario; with extreme uptake 20210528", size(small))
  	   
qui graph save "graph 14a COVID-19 daily deaths, $country, DELP, Percent.gph", replace
qui graph export "graph 14a COVID-19 daily deaths, $country, DELP, Percent.pdf", replace





*********

* daily deaths, wo extreme 20210528, Percent

twoway  ///
(line DayDeaMeRaA01S00U20210401P date, sort lcolor(red)) /// 1
(line DayDeaMeRaA01S00U20210406P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210409P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210416P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210417P date, sort lcolor(red)) /// 5
(line DayDeaMeRaA01S00U20210423P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210424P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210506P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210514P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210515P date, sort lcolor(red)) /// 10
(line DayDeaMeRaA01S00U20210516P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210521P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210522P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210603P date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210604P date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20210605P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210610P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210611P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210618P date, sort lcolor(red)) /// 
(line DayDeaMeRaA01S00U20210624P date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210625P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210703P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210704P date, sort lcolor(red)) ///
(line DayDeaMeRaA01S00U20210709P date, sort lcolor(red)) /// 24
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths DELP percent JOHN smooth) title("COVID-19 daily deaths, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(off) ///
  	   
qui graph save "graph 14b COVID-19 daily deaths, $country, DELP, wo extreme, Percent.gph", replace
qui graph export "graph 14b COVID-19 daily deaths, $country, DELP, wo extreme, Percent.pdf", replace













* daily cases

**************************************



* daily cases, Absolute value

twoway  ///
(line DayCasMeRaA01S00U20210401 date, sort lcolor(red)) /// 1
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
(line DayCasMeSmA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; with extreme uptake 20210528", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(25 "DELP" 26 "JOHN raw") size(small))	
  	   
qui graph save "graph 21a COVID-19 daily cases, $country, DELP.gph", replace
qui graph export "graph 21a COVID-19 daily cases, $country, DELP.pdf", replace





*********

* daily cases, wo extreme 20210528, Absolute value

twoway  ///
(line DayCasMeRaA01S00U20210401 date, sort lcolor(red)) /// 1
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
(line DayCasMeRaA01S00U20210709 date, sort lcolor(red)) /// 24
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(medium)) /// 25
(line DayCasMeSmA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(24 "DELP" 25 "JOHN raw" 26 "JOHN smooth") size(small) rows(1))		
  	   
qui graph save "graph 21b COVID-19 daily cases, $country, DELP, wo extreme.gph", replace
qui graph export "graph 21b COVID-19 daily cases, $country, DELP, wo extreme.pdf", replace


*


*********

* daily cases, Difference

twoway  ///
(line DayCasMeRaA01S00U20210401D date, sort lcolor(red)) /// 1
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
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases DELP minus JOHN smooth) title("COVID-19 daily cases, $country, DELP minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario; with extreme uptake 20210528", size(small))
  	   
qui graph save "graph 22a COVID-19 daily cases, $country, DELP, Difference.gph", replace
qui graph export "graph 22a COVID-19 daily cases, $country, DELP, Difference.pdf", replace





*********

* daily cases, wo extreme 20210528, Difference

twoway  ///
(line DayCasMeRaA01S00U20210401D date, sort lcolor(red)) /// 1
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
(line DayCasMeRaA01S00U20210709D date, sort lcolor(red)) /// 24
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases DELP divided by JOHN smooth) title("COVID-19 daily cases, $country, DELP minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(off) ///
  	   
qui graph save "graph 22b COVID-19 daily cases, $country, DELP, wo extreme, Difference.gph", replace
qui graph export "graph 22b COVID-19 daily cases, $country, DELP, wo extreme, Difference.pdf", replace




*


*********

* daily cases, Times

twoway  ///
(line DayCasMeRaA01S00U20210401T date, sort lcolor(red)) /// 1
(line DayCasMeRaA01S00U20210406T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210409T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210416T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210417T date, sort lcolor(red)) /// 5
(line DayCasMeRaA01S00U20210423T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210424T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210506T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210514T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210515T date, sort lcolor(red)) /// 10
(line DayCasMeRaA01S00U20210516T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210521T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210522T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210528T date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210603T date, sort lcolor(red)) /// 15
(line DayCasMeRaA01S00U20210604T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210605T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210610T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210611T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210618T date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210624T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210625T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210703T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210704T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210709T date, sort lcolor(red)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases DELP divided by JOHN smooth) title("COVID-19 daily cases, $country, DELP divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario; with extreme uptake 20210528", size(small))
  	   
qui graph save "graph 23a COVID-19 daily cases, $country, DELP, Times.gph", replace
qui graph export "graph 23a COVID-19 daily cases, $country, DELP, Times.pdf", replace





*********

* daily cases, wo extreme 20210528, Times

twoway  ///
(line DayCasMeRaA01S00U20210401T date, sort lcolor(red)) /// 1
(line DayCasMeRaA01S00U20210406T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210409T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210416T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210417T date, sort lcolor(red)) /// 5
(line DayCasMeRaA01S00U20210423T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210424T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210506T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210514T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210515T date, sort lcolor(red)) /// 10
(line DayCasMeRaA01S00U20210516T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210521T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210522T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210603T date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210604T date, sort lcolor(red)) /// 15
(line DayCasMeRaA01S00U20210605T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210610T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210611T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210618T date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210624T date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210625T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210703T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210704T date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210709T date, sort lcolor(red)) /// 24
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases DELP divided by JOHN smooth) title("COVID-19 daily cases, $country, DELP divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(off) ///
  	   
qui graph save "graph 23b COVID-19 daily cases, $country, DELP, wo extreme, Times.gph", replace
qui graph export "graph 23b COVID-19 daily cases, $country, DELP, wo extreme, Times.pdf", replace






*********

* daily cases, Percent

twoway  ///
(line DayCasMeRaA01S00U20210401P date, sort lcolor(red)) /// 1
(line DayCasMeRaA01S00U20210406P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210409P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210416P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210417P date, sort lcolor(red)) /// 5
(line DayCasMeRaA01S00U20210423P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210424P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210506P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210514P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210515P date, sort lcolor(red)) /// 10
(line DayCasMeRaA01S00U20210516P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210521P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210522P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210528P date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210603P date, sort lcolor(red)) /// 15
(line DayCasMeRaA01S00U20210604P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210605P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210610P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210611P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210618P date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210624P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210625P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210703P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210704P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210709P date, sort lcolor(red)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases DELP percent JOHN smooth) title("COVID-19 daily cases, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario; with extreme uptake 20210528", size(small))
  	   
qui graph save "graph 24a COVID-19 daily cases, $country, DELP, Percent.gph", replace
qui graph export "graph 24a COVID-19 daily cases, $country, DELP, Percent.pdf", replace





*********

* daily cases, wo extreme 20210528, Percent

twoway  ///
(line DayCasMeRaA01S00U20210401P date, sort lcolor(red)) /// 1
(line DayCasMeRaA01S00U20210406P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210409P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210416P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210417P date, sort lcolor(red)) /// 5
(line DayCasMeRaA01S00U20210423P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210424P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210506P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210514P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210515P date, sort lcolor(red)) /// 10
(line DayCasMeRaA01S00U20210516P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210521P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210522P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210603P date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210604P date, sort lcolor(red)) /// 15
(line DayCasMeRaA01S00U20210605P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210610P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210611P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210618P date, sort lcolor(red)) /// 
(line DayCasMeRaA01S00U20210624P date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210625P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210703P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210704P date, sort lcolor(red)) ///
(line DayCasMeRaA01S00U20210709P date, sort lcolor(red)) /// 24
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases DELP percent JOHN smooth) title("COVID-19 daily cases, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(off) ///
  	   
qui graph save "graph 24b COVID-19 daily cases, $country, DELP, wo extreme, Percent.gph", replace
qui graph export "graph 24b COVID-19 daily cases, $country, DELP, wo extreme, Percent.pdf", replace

















* total deaths

**************************************

* total deaths, Absolute value

twoway  ///
(line TotDeaMeRaA01S00U20210401 date, sort lcolor(red)) /// 1
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
(line TotDeaMeRaA01S00U20210528 date, sort lcolor(red)) /// 
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
(line TotDeaMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; with extreme uptake 20210528", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(25 "DELP" 26 "JOHN") size(small))	
  	   
qui graph save "graph 31a COVID-19 total deaths, $country, DELP.gph", replace
qui graph export "graph 31a COVID-19 total deaths, $country, DELP.pdf", replace





*********

* total deaths, wo extreme 20210528, Absolute value

twoway  ///
(line TotDeaMeRaA01S00U20210401 date, sort lcolor(red)) /// 1
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
(line TotDeaMeRaA01S00U20210709 date, sort lcolor(red)) /// 24
(line TotDeaMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(24 "DELP" 25 "JOHN") size(small) rows(1))		
  	   
qui graph save "graph 31b COVID-19 total deaths, $country, DELP, wo extreme.gph", replace
qui graph export "graph 31b COVID-19 total deaths, $country, DELP, wo extreme.pdf", replace


*


*********

* total deaths, Difference

twoway  ///
(line TotDeaMeRaA01S00U20210401D date, sort lcolor(red)) /// 1
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
(line TotDeaMeRaA01S00U20210528D date, sort lcolor(red)) /// 
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
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths DELP minus JOHN) title("COVID-19 total deaths, $country, DELP minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario; with extreme uptake 20210528", size(small))
  	   
qui graph save "graph 32a COVID-19 total deaths, $country, DELP, Difference.gph", replace
qui graph export "graph 32a COVID-19 total deaths, $country, DELP, Difference.pdf", replace





*********

* total deaths, wo extreme 20210528, Difference

twoway  ///
(line TotDeaMeRaA01S00U20210401D date, sort lcolor(red)) /// 1
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
(line TotDeaMeRaA01S00U20210709D date, sort lcolor(red)) /// 24
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths DELP divided by JOHN) title("COVID-19 total deaths, $country, DELP minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(off) ///
  	   
qui graph save "graph 32b COVID-19 total deaths, $country, DELP, wo extreme, Difference.gph", replace
qui graph export "graph 32b COVID-19 total deaths, $country, DELP, wo extreme, Difference.pdf", replace




*


*********

* total deaths, Times

twoway  ///
(line TotDeaMeRaA01S00U20210401T date, sort lcolor(red)) /// 1
(line TotDeaMeRaA01S00U20210406T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210409T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210416T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210417T date, sort lcolor(red)) /// 5
(line TotDeaMeRaA01S00U20210423T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210424T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210506T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210514T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210515T date, sort lcolor(red)) /// 10
(line TotDeaMeRaA01S00U20210516T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210521T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210522T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210528T date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210603T date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20210604T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210605T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210610T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210611T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210618T date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210624T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210625T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210703T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210704T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210709T date, sort lcolor(red)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths DELP divided by JOHN) title("COVID-19 total deaths, $country, DELP divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario; with extreme uptake 20210528", size(small))
  	   
qui graph save "graph 33a COVID-19 total deaths, $country, DELP, Times.gph", replace
qui graph export "graph 33a COVID-19 total deaths, $country, DELP, Times.pdf", replace





*********

* total deaths, wo extreme 20210528, Times

twoway  ///
(line TotDeaMeRaA01S00U20210401T date, sort lcolor(red)) /// 1
(line TotDeaMeRaA01S00U20210406T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210409T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210416T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210417T date, sort lcolor(red)) /// 5
(line TotDeaMeRaA01S00U20210423T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210424T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210506T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210514T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210515T date, sort lcolor(red)) /// 10
(line TotDeaMeRaA01S00U20210516T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210521T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210522T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210603T date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210604T date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20210605T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210610T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210611T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210618T date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210624T date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210625T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210703T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210704T date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210709T date, sort lcolor(red)) /// 24
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths DELP divided by JOHN) title("COVID-19 total deaths, $country, DELP divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(off) ///
  	   
qui graph save "graph 33b COVID-19 total deaths, $country, DELP, wo extreme, Times.gph", replace
qui graph export "graph 33b COVID-19 total deaths, $country, DELP, wo extreme, Times.pdf", replace


*


*********

* total deaths, Percent

twoway  ///
(line TotDeaMeRaA01S00U20210401P date, sort lcolor(red)) /// 1
(line TotDeaMeRaA01S00U20210406P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210409P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210416P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210417P date, sort lcolor(red)) /// 5
(line TotDeaMeRaA01S00U20210423P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210424P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210506P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210514P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210515P date, sort lcolor(red)) /// 10
(line TotDeaMeRaA01S00U20210516P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210521P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210522P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210528P date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210603P date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20210604P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210605P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210610P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210611P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210618P date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210624P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210625P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210703P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210704P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210709P date, sort lcolor(red)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths DELP percent JOHN) title("COVID-19 total deaths, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario; with extreme uptake 20210528", size(small))
  	   
qui graph save "graph 34a COVID-19 total deaths, $country, DELP, Percent.gph", replace
qui graph export "graph 34a COVID-19 total deaths, $country, DELP, Percent.pdf", replace





*********

* total deaths, wo extreme 20210528, Percent

twoway  ///
(line TotDeaMeRaA01S00U20210401P date, sort lcolor(red)) /// 1
(line TotDeaMeRaA01S00U20210406P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210409P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210416P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210417P date, sort lcolor(red)) /// 5
(line TotDeaMeRaA01S00U20210423P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210424P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210506P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210514P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210515P date, sort lcolor(red)) /// 10
(line TotDeaMeRaA01S00U20210516P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210521P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210522P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210603P date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210604P date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20210605P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210610P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210611P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210618P date, sort lcolor(red)) /// 
(line TotDeaMeRaA01S00U20210624P date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210625P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210703P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210704P date, sort lcolor(red)) ///
(line TotDeaMeRaA01S00U20210709P date, sort lcolor(red)) /// 24
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths DELP percent JOHN) title("COVID-19 total deaths, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(off) ///
  	   
qui graph save "graph 34b COVID-19 total deaths, $country, DELP, wo extreme, Percent.gph", replace
qui graph export "graph 34b COVID-19 total deaths, $country, DELP, wo extreme, Percent.pdf", replace
















* total cases

**************************************



* total cases, Absolute value

twoway  ///
(line TotCasMeRaA01S00U20210401 date, sort lcolor(red)) /// 1
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
(line TotCasMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; with extreme uptake 20210528", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(25 "DELP" 26 "JOHN") size(small))	
  	   
qui graph save "graph 41a COVID-19 total cases, $country, DELP.gph", replace
qui graph export "graph 41a COVID-19 total cases, $country, DELP.pdf", replace





*********

* total cases, wo extreme 20210528, Absolute value

twoway  ///
(line TotCasMeRaA01S00U20210401 date, sort lcolor(red)) /// 1
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
(line TotCasMeRaA01S00U20210603 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210604 date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20210605 date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210610 date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210611 date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210618 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210624 date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210625 date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210703 date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210704 date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210709 date, sort lcolor(red)) /// 24
(line TotCasMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(24 "DELP" 25 "JOHN") size(small) rows(1))		
  	   
qui graph save "graph 41b COVID-19 total cases, $country, DELP, wo extreme.gph", replace
qui graph export "graph 41b COVID-19 total cases, $country, DELP, wo extreme.pdf", replace


*


*********

* total cases, Difference

twoway  ///
(line TotCasMeRaA01S00U20210401D date, sort lcolor(red)) /// 1
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
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases DELP minus JOHN) title("COVID-19 total cases, $country, DELP minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario; with extreme uptake 20210528", size(small))
  	   
qui graph save "graph 42a COVID-19 total cases, $country, DELP, Difference.gph", replace
qui graph export "graph 42a COVID-19 total cases, $country, DELP, Difference.pdf", replace





*********

* total cases, wo extreme 20210528, Difference

twoway  ///
(line TotCasMeRaA01S00U20210401D date, sort lcolor(red)) /// 1
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
(line TotCasMeRaA01S00U20210603D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210604D date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20210605D date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210610D date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210611D date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210618D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210624D date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210625D date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210703D date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210704D date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210709D date, sort lcolor(red)) /// 24
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases DELP divided by JOHN) title("COVID-19 total cases, $country, DELP minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(off) ///
  	   
qui graph save "graph 42b COVID-19 total cases, $country, DELP, wo extreme, Difference.gph", replace
qui graph export "graph 42b COVID-19 total cases, $country, DELP, wo extreme, Difference.pdf", replace




*


*********

* total cases, Times

twoway  ///
(line TotCasMeRaA01S00U20210401T date, sort lcolor(red)) /// 1
(line TotCasMeRaA01S00U20210406T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210409T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210416T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210417T date, sort lcolor(red)) /// 5
(line TotCasMeRaA01S00U20210423T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210424T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210506T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210514T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210515T date, sort lcolor(red)) /// 10
(line TotCasMeRaA01S00U20210516T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210521T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210522T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210528T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210603T date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20210604T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210605T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210610T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210611T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210618T date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210624T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210625T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210703T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210704T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210709T date, sort lcolor(red)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases DELP divided by JOHN) title("COVID-19 total cases, $country, DELP divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario; with extreme uptake 20210528", size(small))
  	   
qui graph save "graph 43a COVID-19 total cases, $country, DELP, Times.gph", replace
qui graph export "graph 43a COVID-19 total cases, $country, DELP, Times.pdf", replace





*********

* total cases, wo extreme 20210528, Times

twoway  ///
(line TotCasMeRaA01S00U20210401T date, sort lcolor(red)) /// 1
(line TotCasMeRaA01S00U20210406T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210409T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210416T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210417T date, sort lcolor(red)) /// 5
(line TotCasMeRaA01S00U20210423T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210424T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210506T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210514T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210515T date, sort lcolor(red)) /// 10
(line TotCasMeRaA01S00U20210516T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210521T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210522T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210603T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210604T date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20210605T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210610T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210611T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210618T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210624T date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210625T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210703T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210704T date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210709T date, sort lcolor(red)) /// 24
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases DELP divided by JOHN) title("COVID-19 total cases, $country, DELP divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(off) ///
  	   
qui graph save "graph 43b COVID-19 total cases, $country, DELP, wo extreme, Times.gph", replace
qui graph export "graph 43b COVID-19 total cases, $country, DELP, wo extreme, Times.pdf", replace






*********

* total cases, Percent

twoway  ///
(line TotCasMeRaA01S00U20210401P date, sort lcolor(red)) /// 1
(line TotCasMeRaA01S00U20210406P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210409P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210416P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210417P date, sort lcolor(red)) /// 5
(line TotCasMeRaA01S00U20210423P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210424P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210506P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210514P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210515P date, sort lcolor(red)) /// 10
(line TotCasMeRaA01S00U20210516P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210521P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210522P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210528P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210603P date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20210604P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210605P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210610P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210611P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210618P date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210624P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210625P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210703P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210704P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210709P date, sort lcolor(red)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases DELP percent JOHN) title("COVID-19 total cases, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario; with extreme uptake 20210528", size(small))
  	   
qui graph save "graph 44a COVID-19 total cases, $country, DELP, Percent.gph", replace
qui graph export "graph 44a COVID-19 total cases, $country, DELP, Percent.pdf", replace





*********

* total cases, wo extreme 20210528, Percent

twoway  ///
(line TotCasMeRaA01S00U20210401P date, sort lcolor(red)) /// 1
(line TotCasMeRaA01S00U20210406P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210409P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210416P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210417P date, sort lcolor(red)) /// 5
(line TotCasMeRaA01S00U20210423P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210424P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210506P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210514P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210515P date, sort lcolor(red)) /// 10
(line TotCasMeRaA01S00U20210516P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210521P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210522P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210603P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210604P date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20210605P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210610P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210611P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210618P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210624P date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210625P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210703P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210704P date, sort lcolor(red)) ///
(line TotCasMeRaA01S00U20210709P date, sort lcolor(red)) /// 24
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases DELP percent JOHN) title("COVID-19 total cases, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario; without extreme uptake 20210528", size(small)) legend(off) ///
  	   
qui graph save "graph 44b COVID-19 total cases, $country, DELP, wo extreme, Percent.gph", replace
qui graph export "graph 44b COVID-19 total cases, $country, DELP, wo extreme, Percent.pdf", replace







view "log country DELP.smcl"

log close

exit, clear




