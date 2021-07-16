
clear all
 
cd "$pathcovir2"

cd LANL

capture log close 

log using "log country LANL.smcl", replace

******************************************************************************
* This is "do country LANL.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare LANL data for country
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
DayDeaMeRaA04S00 DayCasMeRaA04S00 TotDeaMeRaA04S00 TotCasMeRaA04S00


* smooth 

tsset date, daily   

tssmooth ma DayDeaMeRaA04S00_window = DayDeaMeRaA04S00 if DayDeaMeRaA04S00 >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmA04S00 = DayDeaMeRaA04S00_window, weights( 1 2 3 <4> 3 2 1) replace

drop DayDeaMeRaA04S00_window


tssmooth ma DayCasMeRaA04S00_window = DayCasMeRaA04S00 if DayCasMeRaA04S00 >= 0, window(3 1 3)

tssmooth ma DayCasMeSmA04S00 = DayCasMeRaA04S00_window, weights( 1 2 3 <4> 3 2 1) replace

drop DayCasMeRaA04S00_window

tsset, clear


* add uptake date to the end of varname

local varlist ///
DayDeaMeSmA04S00 DayCasMeSmA04S00 TotDeaMeRaA04S00 TotCasMeRaA04S00

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

cd LANL

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

save "country LANL.dta", replace




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

cd LANL

save "JOHN.dta", replace


}
*


merge date loc_grand_name using "country LANL.dta"

drop _merge


local uptakedatelist ///
20210401 20210406 20210409 20210416 20210417 ///
20210423 20210424 20210506 20210514 20210515 ///
20210516 20210521 20210522 20210528 20210603 ///
20210604 20210605 20210610 20210611 20210618 ///
20210624 20210625 20210703 20210704 20210709


foreach l of local uptakedatelist {

gen DayDeaMeSmA04S00U`l'D = DayDeaMeSmA04S00U`l' - DayDeaMeSmA00S00 // D Difference 
gen DayDeaMeSmA04S00U`l'T = DayDeaMeSmA04S00U`l' / DayDeaMeSmA00S00 // T Times (more or less)
gen DayDeaMeSmA04S00U`l'P = 100 * (DayDeaMeSmA04S00U`l' - DayDeaMeSmA00S00) / DayDeaMeSmA00S00 // P Percent

gen DayCasMeSmA04S00U`l'D = DayCasMeSmA04S00U`l' - DayCasMeSmA00S00 // D Difference 
gen DayCasMeSmA04S00U`l'T = DayCasMeSmA04S00U`l' / DayCasMeSmA00S00 // T Times (more or less)
gen DayCasMeSmA04S00U`l'P = 100 * (DayCasMeSmA04S00U`l' - DayCasMeSmA00S00) / DayCasMeSmA00S00 // P Percent

gen TotDeaMeRaA04S00U`l'D = TotDeaMeRaA04S00U`l' - TotDeaMeRaA00S00 // D Difference 
gen TotDeaMeRaA04S00U`l'T = TotDeaMeRaA04S00U`l' / TotDeaMeRaA00S00 // T Times (more or less)
gen TotDeaMeRaA04S00U`l'P = 100 * (TotDeaMeRaA04S00U`l' - TotDeaMeRaA00S00) / TotDeaMeRaA00S00 // P Percent

gen TotCasMeRaA04S00U`l'D = TotCasMeRaA04S00U`l' - TotCasMeRaA00S00 // D Difference 
gen TotCasMeRaA04S00U`l'T = TotCasMeRaA04S00U`l' / TotCasMeRaA00S00 // T Times (more or less)
gen TotCasMeRaA04S00U`l'P = 100 * (TotCasMeRaA04S00U`l' - TotCasMeRaA00S00) / TotCasMeRaA00S00 // P Percent 

}
*



save "country LANL.dta", replace





**********************************************************

* graphs


grstyle init

grstyle color background white




* daily deaths

**************************************

* daily deaths, Absolute value

twoway  ///
(line DayDeaMeSmA04S00U20210401 date, sort lcolor(gold)) /// 1
(line DayDeaMeSmA04S00U20210406 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210409 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210416 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210417 date, sort lcolor(gold)) /// 5
(line DayDeaMeSmA04S00U20210423 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210424 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210506 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210514 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210515 date, sort lcolor(gold)) /// 10
(line DayDeaMeSmA04S00U20210516 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210521 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210522 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210528 date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210603 date, sort lcolor(gold)) /// 15
(line DayDeaMeSmA04S00U20210604 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210605 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210610 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210611 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210618 date, sort lcolor(gold)) /// 20
(line DayDeaMeSmA04S00U20210624 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210625 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210703 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210704 date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210709 date, sort lcolor(gold)) /// 25
(line DayDeaMeSmA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, LANL", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(25 "LANL" 26 "JOHN raw") size(small))	
  	   
qui graph save "graph 11a COVID-19 daily deaths, $country, LANL.gph", replace
qui graph export "graph 11a COVID-19 daily deaths, $country, LANL.pdf", replace





*********

* daily deaths, Difference

twoway  ///
(line DayDeaMeSmA04S00U20210401D date, sort lcolor(gold)) /// 1
(line DayDeaMeSmA04S00U20210406D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210409D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210416D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210417D date, sort lcolor(gold)) /// 5
(line DayDeaMeSmA04S00U20210423D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210424D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210506D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210514D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210515D date, sort lcolor(gold)) /// 10
(line DayDeaMeSmA04S00U20210516D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210521D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210522D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210528D date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210603D date, sort lcolor(gold)) /// 15
(line DayDeaMeSmA04S00U20210604D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210605D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210610D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210611D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210618D date, sort lcolor(gold)) /// 20
(line DayDeaMeSmA04S00U20210624D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210625D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210703D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210704D date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210709D date, sort lcolor(gold)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths LANL minus JOHN smooth) title("COVID-19 daily deaths, $country, LANL minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 12a COVID-19 daily deaths, $country, LANL, Difference.gph", replace
qui graph export "graph 12a COVID-19 daily deaths, $country, LANL, Difference.pdf", replace





*********

* daily deaths, Times

twoway  ///
(line DayDeaMeSmA04S00U20210401T date, sort lcolor(gold)) /// 1
(line DayDeaMeSmA04S00U20210406T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210409T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210416T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210417T date, sort lcolor(gold)) /// 5
(line DayDeaMeSmA04S00U20210423T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210424T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210506T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210514T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210515T date, sort lcolor(gold)) /// 10
(line DayDeaMeSmA04S00U20210516T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210521T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210522T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210528T date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210603T date, sort lcolor(gold)) /// 15
(line DayDeaMeSmA04S00U20210604T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210605T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210610T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210611T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210618T date, sort lcolor(gold)) /// 20
(line DayDeaMeSmA04S00U20210624T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210625T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210703T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210704T date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210709T date, sort lcolor(gold)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths LANL divided by JOHN smooth) title("COVID-19 daily deaths, $country, LANL divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 13a COVID-19 daily deaths, $country, LANL, Times.gph", replace
qui graph export "graph 13a COVID-19 daily deaths, $country, LANL, Times.pdf", replace





*********

* daily deaths, Percent

twoway  ///
(line DayDeaMeSmA04S00U20210401P date, sort lcolor(gold)) /// 1
(line DayDeaMeSmA04S00U20210406P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210409P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210416P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210417P date, sort lcolor(gold)) /// 5
(line DayDeaMeSmA04S00U20210423P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210424P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210506P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210514P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210515P date, sort lcolor(gold)) /// 10
(line DayDeaMeSmA04S00U20210516P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210521P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210522P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210528P date, sort lcolor(gold)) /// 
(line DayDeaMeSmA04S00U20210603P date, sort lcolor(gold)) /// 15
(line DayDeaMeSmA04S00U20210604P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210605P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210610P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210611P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210618P date, sort lcolor(gold)) /// 20
(line DayDeaMeSmA04S00U20210624P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210625P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210703P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210704P date, sort lcolor(gold)) ///
(line DayDeaMeSmA04S00U20210709P date, sort lcolor(gold)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths LANL percent JOHN smooth) title("COVID-19 daily deaths, $country, % (LANL minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 14a COVID-19 daily deaths, $country, LANL, Percent.gph", replace
qui graph export "graph 14a COVID-19 daily deaths, $country, LANL, Percent.pdf", replace

















* daily cases

**************************************



* daily cases, Absolute value

twoway  ///
(line DayCasMeSmA04S00U20210401 date, sort lcolor(gold)) /// 1
(line DayCasMeSmA04S00U20210406 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210409 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210416 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210417 date, sort lcolor(gold)) /// 5
(line DayCasMeSmA04S00U20210423 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210424 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210506 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210514 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210515 date, sort lcolor(gold)) /// 10
(line DayCasMeSmA04S00U20210516 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210521 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210522 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210528 date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210603 date, sort lcolor(gold)) /// 15
(line DayCasMeSmA04S00U20210604 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210605 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210610 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210611 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210618 date, sort lcolor(gold)) /// 20
(line DayCasMeSmA04S00U20210624 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210625 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210703 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210704 date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210709 date, sort lcolor(gold)) /// 25
(line DayCasMeSmA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country, LANL", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(25 "LANL" 26 "JOHN raw") size(small))	
  	   
qui graph save "graph 21a COVID-19 daily cases, $country, LANL.gph", replace
qui graph export "graph 21a COVID-19 daily cases, $country, LANL.pdf", replace






*********

* daily cases, Difference

twoway  ///
(line DayCasMeSmA04S00U20210401D date, sort lcolor(gold)) /// 1
(line DayCasMeSmA04S00U20210406D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210409D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210416D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210417D date, sort lcolor(gold)) /// 5
(line DayCasMeSmA04S00U20210423D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210424D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210506D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210514D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210515D date, sort lcolor(gold)) /// 10
(line DayCasMeSmA04S00U20210516D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210521D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210522D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210528D date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210603D date, sort lcolor(gold)) /// 15
(line DayCasMeSmA04S00U20210604D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210605D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210610D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210611D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210618D date, sort lcolor(gold)) /// 20
(line DayCasMeSmA04S00U20210624D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210625D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210703D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210704D date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210709D date, sort lcolor(gold)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases LANL minus JOHN smooth) title("COVID-19 daily cases, $country, LANL minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 22a COVID-19 daily cases, $country, LANL, Difference.gph", replace
qui graph export "graph 22a COVID-19 daily cases, $country, LANL, Difference.pdf", replace






*********

* daily cases, Times

twoway  ///
(line DayCasMeSmA04S00U20210401T date, sort lcolor(gold)) /// 1
(line DayCasMeSmA04S00U20210406T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210409T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210416T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210417T date, sort lcolor(gold)) /// 5
(line DayCasMeSmA04S00U20210423T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210424T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210506T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210514T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210515T date, sort lcolor(gold)) /// 10
(line DayCasMeSmA04S00U20210516T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210521T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210522T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210528T date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210603T date, sort lcolor(gold)) /// 15
(line DayCasMeSmA04S00U20210604T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210605T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210610T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210611T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210618T date, sort lcolor(gold)) /// 20
(line DayCasMeSmA04S00U20210624T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210625T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210703T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210704T date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210709T date, sort lcolor(gold)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases LANL divided by JOHN smooth) title("COVID-19 daily cases, $country, LANL divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 23a COVID-19 daily cases, $country, LANL, Times.gph", replace
qui graph export "graph 23a COVID-19 daily cases, $country, LANL, Times.pdf", replace






*********

* daily cases, Percent

twoway  ///
(line DayCasMeSmA04S00U20210401P date, sort lcolor(gold)) /// 1
(line DayCasMeSmA04S00U20210406P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210409P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210416P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210417P date, sort lcolor(gold)) /// 5
(line DayCasMeSmA04S00U20210423P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210424P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210506P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210514P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210515P date, sort lcolor(gold)) /// 10
(line DayCasMeSmA04S00U20210516P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210521P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210522P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210528P date, sort lcolor(gold)) /// 
(line DayCasMeSmA04S00U20210603P date, sort lcolor(gold)) /// 15
(line DayCasMeSmA04S00U20210604P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210605P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210610P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210611P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210618P date, sort lcolor(gold)) /// 20
(line DayCasMeSmA04S00U20210624P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210625P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210703P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210704P date, sort lcolor(gold)) ///
(line DayCasMeSmA04S00U20210709P date, sort lcolor(gold)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases LANL percent JOHN smooth) title("COVID-19 daily cases, $country, % (LANL minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 24a COVID-19 daily cases, $country, LANL, Percent.gph", replace
qui graph export "graph 24a COVID-19 daily cases, $country, LANL, Percent.pdf", replace


















* total deaths

**************************************

* total deaths, Absolute value

twoway  ///
(line TotDeaMeRaA04S00U20210401 date, sort lcolor(gold)) /// 1
(line TotDeaMeRaA04S00U20210406 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210409 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210416 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210417 date, sort lcolor(gold)) /// 5
(line TotDeaMeRaA04S00U20210423 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210424 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210506 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210514 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210515 date, sort lcolor(gold)) /// 10
(line TotDeaMeRaA04S00U20210516 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210521 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210522 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210528 date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210603 date, sort lcolor(gold)) /// 15
(line TotDeaMeRaA04S00U20210604 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210605 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210610 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210611 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210618 date, sort lcolor(gold)) /// 20
(line TotDeaMeRaA04S00U20210624 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210625 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210703 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210704 date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210709 date, sort lcolor(gold)) /// 25
(line TotDeaMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, LANL", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(25 "LANL" 26 "JOHN") size(small))	
  	   
qui graph save "graph 31a COVID-19 total deaths, $country, LANL.gph", replace
qui graph export "graph 31a COVID-19 total deaths, $country, LANL.pdf", replace





*********

* total deaths, Difference

twoway  ///
(line TotDeaMeRaA04S00U20210401D date, sort lcolor(gold)) /// 1
(line TotDeaMeRaA04S00U20210406D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210409D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210416D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210417D date, sort lcolor(gold)) /// 5
(line TotDeaMeRaA04S00U20210423D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210424D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210506D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210514D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210515D date, sort lcolor(gold)) /// 10
(line TotDeaMeRaA04S00U20210516D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210521D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210522D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210528D date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210603D date, sort lcolor(gold)) /// 15
(line TotDeaMeRaA04S00U20210604D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210605D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210610D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210611D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210618D date, sort lcolor(gold)) /// 20
(line TotDeaMeRaA04S00U20210624D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210625D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210703D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210704D date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210709D date, sort lcolor(gold)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths LANL minus JOHN) title("COVID-19 total deaths, $country, LANL minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 32a COVID-19 total deaths, $country, LANL, Difference.gph", replace
qui graph export "graph 32a COVID-19 total deaths, $country, LANL, Difference.pdf", replace






*********

* total deaths, Times

twoway  ///
(line TotDeaMeRaA04S00U20210401T date, sort lcolor(gold)) /// 1
(line TotDeaMeRaA04S00U20210406T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210409T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210416T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210417T date, sort lcolor(gold)) /// 5
(line TotDeaMeRaA04S00U20210423T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210424T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210506T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210514T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210515T date, sort lcolor(gold)) /// 10
(line TotDeaMeRaA04S00U20210516T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210521T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210522T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210528T date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210603T date, sort lcolor(gold)) /// 15
(line TotDeaMeRaA04S00U20210604T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210605T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210610T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210611T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210618T date, sort lcolor(gold)) /// 20
(line TotDeaMeRaA04S00U20210624T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210625T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210703T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210704T date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210709T date, sort lcolor(gold)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths LANL divided by JOHN) title("COVID-19 total deaths, $country, LANL divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 33a COVID-19 total deaths, $country, LANL, Times.gph", replace
qui graph export "graph 33a COVID-19 total deaths, $country, LANL, Times.pdf", replace





*********

* total deaths, Percent

twoway  ///
(line TotDeaMeRaA04S00U20210401P date, sort lcolor(gold)) /// 1
(line TotDeaMeRaA04S00U20210406P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210409P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210416P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210417P date, sort lcolor(gold)) /// 5
(line TotDeaMeRaA04S00U20210423P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210424P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210506P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210514P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210515P date, sort lcolor(gold)) /// 10
(line TotDeaMeRaA04S00U20210516P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210521P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210522P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210528P date, sort lcolor(gold)) /// 
(line TotDeaMeRaA04S00U20210603P date, sort lcolor(gold)) /// 15
(line TotDeaMeRaA04S00U20210604P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210605P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210610P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210611P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210618P date, sort lcolor(gold)) /// 20
(line TotDeaMeRaA04S00U20210624P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210625P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210703P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210704P date, sort lcolor(gold)) ///
(line TotDeaMeRaA04S00U20210709P date, sort lcolor(gold)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths LANL percent JOHN) title("COVID-19 total deaths, $country, % (LANL minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 34a COVID-19 total deaths, $country, LANL, Percent.gph", replace
qui graph export "graph 34a COVID-19 total deaths, $country, LANL, Percent.pdf", replace


















* total cases

**************************************



* total cases, Absolute value

twoway  ///
(line TotCasMeRaA04S00U20210401 date, sort lcolor(gold)) /// 1
(line TotCasMeRaA04S00U20210406 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210409 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210416 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210417 date, sort lcolor(gold)) /// 5
(line TotCasMeRaA04S00U20210423 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210424 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210506 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210514 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210515 date, sort lcolor(gold)) /// 10
(line TotCasMeRaA04S00U20210516 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210521 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210522 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210528 date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210603 date, sort lcolor(gold)) /// 15
(line TotCasMeRaA04S00U20210604 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210605 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210610 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210611 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210618 date, sort lcolor(gold)) /// 20
(line TotCasMeRaA04S00U20210624 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210625 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210703 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210704 date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210709 date, sort lcolor(gold)) /// 25
(line TotCasMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, $country, LANL", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(25 "LANL" 26 "JOHN") size(small))	
  	   
qui graph save "graph 41a COVID-19 total cases, $country, LANL.gph", replace
qui graph export "graph 41a COVID-19 total cases, $country, LANL.pdf", replace





*********

* total cases, Difference

twoway  ///
(line TotCasMeRaA04S00U20210401D date, sort lcolor(gold)) /// 1
(line TotCasMeRaA04S00U20210406D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210409D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210416D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210417D date, sort lcolor(gold)) /// 5
(line TotCasMeRaA04S00U20210423D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210424D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210506D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210514D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210515D date, sort lcolor(gold)) /// 10
(line TotCasMeRaA04S00U20210516D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210521D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210522D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210528D date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210603D date, sort lcolor(gold)) /// 15
(line TotCasMeRaA04S00U20210604D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210605D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210610D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210611D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210618D date, sort lcolor(gold)) /// 20
(line TotCasMeRaA04S00U20210624D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210625D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210703D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210704D date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210709D date, sort lcolor(gold)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases LANL minus JOHN) title("COVID-19 total cases, $country, LANL minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 42a COVID-19 total cases, $country, LANL, Difference.gph", replace
qui graph export "graph 42a COVID-19 total cases, $country, LANL, Difference.pdf", replace






*********

* total cases, Times

twoway  ///
(line TotCasMeRaA04S00U20210401T date, sort lcolor(gold)) /// 1
(line TotCasMeRaA04S00U20210406T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210409T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210416T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210417T date, sort lcolor(gold)) /// 5
(line TotCasMeRaA04S00U20210423T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210424T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210506T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210514T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210515T date, sort lcolor(gold)) /// 10
(line TotCasMeRaA04S00U20210516T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210521T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210522T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210528T date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210603T date, sort lcolor(gold)) /// 15
(line TotCasMeRaA04S00U20210604T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210605T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210610T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210611T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210618T date, sort lcolor(gold)) /// 20
(line TotCasMeRaA04S00U20210624T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210625T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210703T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210704T date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210709T date, sort lcolor(gold)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases LANL divided by JOHN) title("COVID-19 total cases, $country, LANL divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 43a COVID-19 total cases, $country, LANL, Times.gph", replace
qui graph export "graph 43a COVID-19 total cases, $country, LANL, Times.pdf", replace








*********

* total cases, Percent

twoway  ///
(line TotCasMeRaA04S00U20210401P date, sort lcolor(gold)) /// 1
(line TotCasMeRaA04S00U20210406P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210409P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210416P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210417P date, sort lcolor(gold)) /// 5
(line TotCasMeRaA04S00U20210423P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210424P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210506P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210514P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210515P date, sort lcolor(gold)) /// 10
(line TotCasMeRaA04S00U20210516P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210521P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210522P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210528P date, sort lcolor(gold)) /// 
(line TotCasMeRaA04S00U20210603P date, sort lcolor(gold)) /// 15
(line TotCasMeRaA04S00U20210604P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210605P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210610P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210611P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210618P date, sort lcolor(gold)) /// 20
(line TotCasMeRaA04S00U20210624P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210625P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210703P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210704P date, sort lcolor(gold)) ///
(line TotCasMeRaA04S00U20210709P date, sort lcolor(gold)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases LANL percent JOHN) title("COVID-19 total cases, $country, % (LANL minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 44a COVID-19 total cases, $country, LANL, Percent.gph", replace
qui graph export "graph 44a COVID-19 total cases, $country, LANL, Percent.pdf", replace







view "log country LANL.smcl"

log close

exit, clear




