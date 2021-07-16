
clear all
 
cd "$pathcovir2"

cd SRIV

capture log close 

log using "log country SRIV.smcl", replace

******************************************************************************
* This is "do country SRIV.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare SRIV data for country
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
DayDeaMeRaA05S00 DayCasMeRaA05S00 TotDeaMeRaA05S00 TotCasMeRaA05S00


* smooth 

tsset date, daily   

tssmooth ma DayDeaMeRaA05S00_window = DayDeaMeRaA05S00 if DayDeaMeRaA05S00 >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmA05S00 = DayDeaMeRaA05S00_window, weights( 1 2 3 <4> 3 2 1) replace

drop DayDeaMeRaA05S00_window


tssmooth ma DayCasMeRaA05S00_window = DayCasMeRaA05S00 if DayCasMeRaA05S00 >= 0, window(3 1 3)

tssmooth ma DayCasMeSmA05S00 = DayCasMeRaA05S00_window, weights( 1 2 3 <4> 3 2 1) replace

drop DayCasMeRaA05S00_window

tsset, clear


* add uptake date to the end of varname

local varlist ///
DayDeaMeSmA05S00 DayCasMeSmA05S00 TotDeaMeRaA05S00 TotCasMeRaA05S00

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

cd SRIV

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

save "country SRIV.dta", replace




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

cd SRIV

save "JOHN.dta", replace


}
*


merge date loc_grand_name using "country SRIV.dta"

drop _merge


local uptakedatelist ///
20210401 20210406 20210409 20210416 20210417 ///
20210423 20210424 20210506 20210514 20210515 ///
20210516 20210521 20210522 20210528 20210603 ///
20210604 20210605 20210610 20210611 20210618 ///
20210624 20210625 20210703 20210704 20210709


foreach l of local uptakedatelist {

gen DayDeaMeSmA05S00U`l'D = DayDeaMeSmA05S00U`l' - DayDeaMeSmA00S00 // D Difference 
gen DayDeaMeSmA05S00U`l'T = DayDeaMeSmA05S00U`l' / DayDeaMeSmA00S00 // T Times (more or less)
gen DayDeaMeSmA05S00U`l'P = 100 * (DayDeaMeSmA05S00U`l' - DayDeaMeSmA00S00) / DayDeaMeSmA00S00 // P Percent

gen DayCasMeSmA05S00U`l'D = DayCasMeSmA05S00U`l' - DayCasMeSmA00S00 // D Difference 
gen DayCasMeSmA05S00U`l'T = DayCasMeSmA05S00U`l' / DayCasMeSmA00S00 // T Times (more or less)
gen DayCasMeSmA05S00U`l'P = 100 * (DayCasMeSmA05S00U`l' - DayCasMeSmA00S00) / DayCasMeSmA00S00 // P Percent

gen TotDeaMeRaA05S00U`l'D = TotDeaMeRaA05S00U`l' - TotDeaMeRaA00S00 // D Difference 
gen TotDeaMeRaA05S00U`l'T = TotDeaMeRaA05S00U`l' / TotDeaMeRaA00S00 // T Times (more or less)
gen TotDeaMeRaA05S00U`l'P = 100 * (TotDeaMeRaA05S00U`l' - TotDeaMeRaA00S00) / TotDeaMeRaA00S00 // P Percent

gen TotCasMeRaA05S00U`l'D = TotCasMeRaA05S00U`l' - TotCasMeRaA00S00 // D Difference 
gen TotCasMeRaA05S00U`l'T = TotCasMeRaA05S00U`l' / TotCasMeRaA00S00 // T Times (more or less)
gen TotCasMeRaA05S00U`l'P = 100 * (TotCasMeRaA05S00U`l' - TotCasMeRaA00S00) / TotCasMeRaA00S00 // P Percent 

}
*



save "country SRIV.dta", replace





**********************************************************

* graphs


grstyle init

grstyle color background white




* daily deaths

**************************************

* daily deaths, Absolute value

twoway  ///
(line DayDeaMeSmA05S00U20210401 date, sort lcolor(green)) /// 1
(line DayDeaMeSmA05S00U20210406 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210409 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210416 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210417 date, sort lcolor(green)) /// 5
(line DayDeaMeSmA05S00U20210423 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210424 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210506 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210514 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210515 date, sort lcolor(green)) /// 10
(line DayDeaMeSmA05S00U20210516 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210521 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210522 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210528 date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210603 date, sort lcolor(green)) /// 15
(line DayDeaMeSmA05S00U20210604 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210605 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210610 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210611 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210618 date, sort lcolor(green)) /// 20
(line DayDeaMeSmA05S00U20210624 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210625 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210703 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210704 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210709 date, sort lcolor(green)) /// 25
(line DayDeaMeSmA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, SRIV", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(25 "SRIV" 26 "JOHN raw") size(small))	
  	   
qui graph save "graph 11a COVID-19 daily deaths, $country, SRIV.gph", replace
qui graph export "graph 11a COVID-19 daily deaths, $country, SRIV.pdf", replace





*********

* daily deaths, Difference

twoway  ///
(line DayDeaMeSmA05S00U20210401D date, sort lcolor(green)) /// 1
(line DayDeaMeSmA05S00U20210406D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210409D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210416D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210417D date, sort lcolor(green)) /// 5
(line DayDeaMeSmA05S00U20210423D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210424D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210506D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210514D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210515D date, sort lcolor(green)) /// 10
(line DayDeaMeSmA05S00U20210516D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210521D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210522D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210528D date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210603D date, sort lcolor(green)) /// 15
(line DayDeaMeSmA05S00U20210604D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210605D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210610D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210611D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210618D date, sort lcolor(green)) /// 20
(line DayDeaMeSmA05S00U20210624D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210625D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210703D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210704D date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210709D date, sort lcolor(green)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths SRIV minus JOHN smooth) title("COVID-19 daily deaths, $country, SRIV minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 12a COVID-19 daily deaths, $country, SRIV, Difference.gph", replace
qui graph export "graph 12a COVID-19 daily deaths, $country, SRIV, Difference.pdf", replace





*********

* daily deaths, Times

twoway  ///
(line DayDeaMeSmA05S00U20210401T date, sort lcolor(green)) /// 1
(line DayDeaMeSmA05S00U20210406T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210409T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210416T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210417T date, sort lcolor(green)) /// 5
(line DayDeaMeSmA05S00U20210423T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210424T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210506T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210514T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210515T date, sort lcolor(green)) /// 10
(line DayDeaMeSmA05S00U20210516T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210521T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210522T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210528T date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210603T date, sort lcolor(green)) /// 15
(line DayDeaMeSmA05S00U20210604T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210605T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210610T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210611T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210618T date, sort lcolor(green)) /// 20
(line DayDeaMeSmA05S00U20210624T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210625T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210703T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210704T date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210709T date, sort lcolor(green)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths SRIV divided by JOHN smooth) title("COVID-19 daily deaths, $country, SRIV divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 13a COVID-19 daily deaths, $country, SRIV, Times.gph", replace
qui graph export "graph 13a COVID-19 daily deaths, $country, SRIV, Times.pdf", replace





*********

* daily deaths, Percent

twoway  ///
(line DayDeaMeSmA05S00U20210401P date, sort lcolor(green)) /// 1
(line DayDeaMeSmA05S00U20210406P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210409P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210416P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210417P date, sort lcolor(green)) /// 5
(line DayDeaMeSmA05S00U20210423P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210424P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210506P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210514P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210515P date, sort lcolor(green)) /// 10
(line DayDeaMeSmA05S00U20210516P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210521P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210522P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210528P date, sort lcolor(green)) /// 
(line DayDeaMeSmA05S00U20210603P date, sort lcolor(green)) /// 15
(line DayDeaMeSmA05S00U20210604P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210605P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210610P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210611P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210618P date, sort lcolor(green)) /// 20
(line DayDeaMeSmA05S00U20210624P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210625P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210703P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210704P date, sort lcolor(green)) ///
(line DayDeaMeSmA05S00U20210709P date, sort lcolor(green)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths SRIV percent JOHN smooth) title("COVID-19 daily deaths, $country, % (SRIV minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 14a COVID-19 daily deaths, $country, SRIV, Percent.gph", replace
qui graph export "graph 14a COVID-19 daily deaths, $country, SRIV, Percent.pdf", replace

















* daily cases

**************************************



* daily cases, Absolute value

twoway  ///
(line DayCasMeSmA05S00U20210401 date, sort lcolor(green)) /// 1
(line DayCasMeSmA05S00U20210406 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210409 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210416 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210417 date, sort lcolor(green)) /// 5
(line DayCasMeSmA05S00U20210423 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210424 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210506 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210514 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210515 date, sort lcolor(green)) /// 10
(line DayCasMeSmA05S00U20210516 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210521 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210522 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210528 date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210603 date, sort lcolor(green)) /// 15
(line DayCasMeSmA05S00U20210604 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210605 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210610 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210611 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210618 date, sort lcolor(green)) /// 20
(line DayCasMeSmA05S00U20210624 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210625 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210703 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210704 date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210709 date, sort lcolor(green)) /// 25
(line DayCasMeSmA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country, SRIV", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(25 "SRIV" 26 "JOHN raw") size(small))	
  	   
qui graph save "graph 21a COVID-19 daily cases, $country, SRIV.gph", replace
qui graph export "graph 21a COVID-19 daily cases, $country, SRIV.pdf", replace






*********

* daily cases, Difference

twoway  ///
(line DayCasMeSmA05S00U20210401D date, sort lcolor(green)) /// 1
(line DayCasMeSmA05S00U20210406D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210409D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210416D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210417D date, sort lcolor(green)) /// 5
(line DayCasMeSmA05S00U20210423D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210424D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210506D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210514D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210515D date, sort lcolor(green)) /// 10
(line DayCasMeSmA05S00U20210516D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210521D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210522D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210528D date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210603D date, sort lcolor(green)) /// 15
(line DayCasMeSmA05S00U20210604D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210605D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210610D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210611D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210618D date, sort lcolor(green)) /// 20
(line DayCasMeSmA05S00U20210624D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210625D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210703D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210704D date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210709D date, sort lcolor(green)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases SRIV minus JOHN smooth) title("COVID-19 daily cases, $country, SRIV minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 22a COVID-19 daily cases, $country, SRIV, Difference.gph", replace
qui graph export "graph 22a COVID-19 daily cases, $country, SRIV, Difference.pdf", replace






*********

* daily cases, Times

twoway  ///
(line DayCasMeSmA05S00U20210401T date, sort lcolor(green)) /// 1
(line DayCasMeSmA05S00U20210406T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210409T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210416T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210417T date, sort lcolor(green)) /// 5
(line DayCasMeSmA05S00U20210423T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210424T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210506T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210514T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210515T date, sort lcolor(green)) /// 10
(line DayCasMeSmA05S00U20210516T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210521T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210522T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210528T date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210603T date, sort lcolor(green)) /// 15
(line DayCasMeSmA05S00U20210604T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210605T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210610T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210611T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210618T date, sort lcolor(green)) /// 20
(line DayCasMeSmA05S00U20210624T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210625T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210703T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210704T date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210709T date, sort lcolor(green)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases SRIV divided by JOHN smooth) title("COVID-19 daily cases, $country, SRIV divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 23a COVID-19 daily cases, $country, SRIV, Times.gph", replace
qui graph export "graph 23a COVID-19 daily cases, $country, SRIV, Times.pdf", replace






*********

* daily cases, Percent

twoway  ///
(line DayCasMeSmA05S00U20210401P date, sort lcolor(green)) /// 1
(line DayCasMeSmA05S00U20210406P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210409P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210416P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210417P date, sort lcolor(green)) /// 5
(line DayCasMeSmA05S00U20210423P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210424P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210506P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210514P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210515P date, sort lcolor(green)) /// 10
(line DayCasMeSmA05S00U20210516P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210521P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210522P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210528P date, sort lcolor(green)) /// 
(line DayCasMeSmA05S00U20210603P date, sort lcolor(green)) /// 15
(line DayCasMeSmA05S00U20210604P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210605P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210610P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210611P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210618P date, sort lcolor(green)) /// 20
(line DayCasMeSmA05S00U20210624P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210625P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210703P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210704P date, sort lcolor(green)) ///
(line DayCasMeSmA05S00U20210709P date, sort lcolor(green)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases SRIV percent JOHN smooth) title("COVID-19 daily cases, $country, % (SRIV minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 24a COVID-19 daily cases, $country, SRIV, Percent.gph", replace
qui graph export "graph 24a COVID-19 daily cases, $country, SRIV, Percent.pdf", replace


















* total deaths

**************************************

* total deaths, Absolute value

twoway  ///
(line TotDeaMeRaA05S00U20210401 date, sort lcolor(green)) /// 1
(line TotDeaMeRaA05S00U20210406 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210409 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210416 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210417 date, sort lcolor(green)) /// 5
(line TotDeaMeRaA05S00U20210423 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210424 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210506 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210514 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210515 date, sort lcolor(green)) /// 10
(line TotDeaMeRaA05S00U20210516 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210521 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210522 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210528 date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210603 date, sort lcolor(green)) /// 15
(line TotDeaMeRaA05S00U20210604 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210605 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210610 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210611 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210618 date, sort lcolor(green)) /// 20
(line TotDeaMeRaA05S00U20210624 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210625 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210703 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210704 date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210709 date, sort lcolor(green)) /// 25
(line TotDeaMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, SRIV", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(25 "SRIV" 26 "JOHN") size(small))	
  	   
qui graph save "graph 31a COVID-19 total deaths, $country, SRIV.gph", replace
qui graph export "graph 31a COVID-19 total deaths, $country, SRIV.pdf", replace





*********

* total deaths, Difference

twoway  ///
(line TotDeaMeRaA05S00U20210401D date, sort lcolor(green)) /// 1
(line TotDeaMeRaA05S00U20210406D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210409D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210416D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210417D date, sort lcolor(green)) /// 5
(line TotDeaMeRaA05S00U20210423D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210424D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210506D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210514D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210515D date, sort lcolor(green)) /// 10
(line TotDeaMeRaA05S00U20210516D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210521D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210522D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210528D date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210603D date, sort lcolor(green)) /// 15
(line TotDeaMeRaA05S00U20210604D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210605D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210610D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210611D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210618D date, sort lcolor(green)) /// 20
(line TotDeaMeRaA05S00U20210624D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210625D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210703D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210704D date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210709D date, sort lcolor(green)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths SRIV minus JOHN) title("COVID-19 total deaths, $country, SRIV minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 32a COVID-19 total deaths, $country, SRIV, Difference.gph", replace
qui graph export "graph 32a COVID-19 total deaths, $country, SRIV, Difference.pdf", replace






*********

* total deaths, Times

twoway  ///
(line TotDeaMeRaA05S00U20210401T date, sort lcolor(green)) /// 1
(line TotDeaMeRaA05S00U20210406T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210409T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210416T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210417T date, sort lcolor(green)) /// 5
(line TotDeaMeRaA05S00U20210423T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210424T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210506T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210514T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210515T date, sort lcolor(green)) /// 10
(line TotDeaMeRaA05S00U20210516T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210521T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210522T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210528T date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210603T date, sort lcolor(green)) /// 15
(line TotDeaMeRaA05S00U20210604T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210605T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210610T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210611T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210618T date, sort lcolor(green)) /// 20
(line TotDeaMeRaA05S00U20210624T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210625T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210703T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210704T date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210709T date, sort lcolor(green)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths SRIV divided by JOHN) title("COVID-19 total deaths, $country, SRIV divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 33a COVID-19 total deaths, $country, SRIV, Times.gph", replace
qui graph export "graph 33a COVID-19 total deaths, $country, SRIV, Times.pdf", replace





*********

* total deaths, Percent

twoway  ///
(line TotDeaMeRaA05S00U20210401P date, sort lcolor(green)) /// 1
(line TotDeaMeRaA05S00U20210406P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210409P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210416P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210417P date, sort lcolor(green)) /// 5
(line TotDeaMeRaA05S00U20210423P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210424P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210506P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210514P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210515P date, sort lcolor(green)) /// 10
(line TotDeaMeRaA05S00U20210516P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210521P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210522P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210528P date, sort lcolor(green)) /// 
(line TotDeaMeRaA05S00U20210603P date, sort lcolor(green)) /// 15
(line TotDeaMeRaA05S00U20210604P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210605P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210610P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210611P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210618P date, sort lcolor(green)) /// 20
(line TotDeaMeRaA05S00U20210624P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210625P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210703P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210704P date, sort lcolor(green)) ///
(line TotDeaMeRaA05S00U20210709P date, sort lcolor(green)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths SRIV percent JOHN) title("COVID-19 total deaths, $country, % (SRIV minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 34a COVID-19 total deaths, $country, SRIV, Percent.gph", replace
qui graph export "graph 34a COVID-19 total deaths, $country, SRIV, Percent.pdf", replace


















* total cases

**************************************



* total cases, Absolute value

twoway  ///
(line TotCasMeRaA05S00U20210401 date, sort lcolor(green)) /// 1
(line TotCasMeRaA05S00U20210406 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210409 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210416 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210417 date, sort lcolor(green)) /// 5
(line TotCasMeRaA05S00U20210423 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210424 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210506 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210514 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210515 date, sort lcolor(green)) /// 10
(line TotCasMeRaA05S00U20210516 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210521 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210522 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210528 date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210603 date, sort lcolor(green)) /// 15
(line TotCasMeRaA05S00U20210604 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210605 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210610 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210611 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210618 date, sort lcolor(green)) /// 20
(line TotCasMeRaA05S00U20210624 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210625 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210703 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210704 date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210709 date, sort lcolor(green)) /// 25
(line TotCasMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, $country, SRIV", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(25 "SRIV" 26 "JOHN") size(small))	
  	   
qui graph save "graph 41a COVID-19 total cases, $country, SRIV.gph", replace
qui graph export "graph 41a COVID-19 total cases, $country, SRIV.pdf", replace





*********

* total cases, Difference

twoway  ///
(line TotCasMeRaA05S00U20210401D date, sort lcolor(green)) /// 1
(line TotCasMeRaA05S00U20210406D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210409D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210416D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210417D date, sort lcolor(green)) /// 5
(line TotCasMeRaA05S00U20210423D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210424D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210506D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210514D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210515D date, sort lcolor(green)) /// 10
(line TotCasMeRaA05S00U20210516D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210521D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210522D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210528D date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210603D date, sort lcolor(green)) /// 15
(line TotCasMeRaA05S00U20210604D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210605D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210610D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210611D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210618D date, sort lcolor(green)) /// 20
(line TotCasMeRaA05S00U20210624D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210625D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210703D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210704D date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210709D date, sort lcolor(green)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases SRIV minus JOHN) title("COVID-19 total cases, $country, SRIV minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 42a COVID-19 total cases, $country, SRIV, Difference.gph", replace
qui graph export "graph 42a COVID-19 total cases, $country, SRIV, Difference.pdf", replace






*********

* total cases, Times

twoway  ///
(line TotCasMeRaA05S00U20210401T date, sort lcolor(green)) /// 1
(line TotCasMeRaA05S00U20210406T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210409T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210416T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210417T date, sort lcolor(green)) /// 5
(line TotCasMeRaA05S00U20210423T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210424T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210506T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210514T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210515T date, sort lcolor(green)) /// 10
(line TotCasMeRaA05S00U20210516T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210521T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210522T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210528T date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210603T date, sort lcolor(green)) /// 15
(line TotCasMeRaA05S00U20210604T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210605T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210610T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210611T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210618T date, sort lcolor(green)) /// 20
(line TotCasMeRaA05S00U20210624T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210625T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210703T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210704T date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210709T date, sort lcolor(green)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases SRIV divided by JOHN) title("COVID-19 total cases, $country, SRIV divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 43a COVID-19 total cases, $country, SRIV, Times.gph", replace
qui graph export "graph 43a COVID-19 total cases, $country, SRIV, Times.pdf", replace








*********

* total cases, Percent

twoway  ///
(line TotCasMeRaA05S00U20210401P date, sort lcolor(green)) /// 1
(line TotCasMeRaA05S00U20210406P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210409P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210416P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210417P date, sort lcolor(green)) /// 5
(line TotCasMeRaA05S00U20210423P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210424P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210506P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210514P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210515P date, sort lcolor(green)) /// 10
(line TotCasMeRaA05S00U20210516P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210521P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210522P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210528P date, sort lcolor(green)) /// 
(line TotCasMeRaA05S00U20210603P date, sort lcolor(green)) /// 15
(line TotCasMeRaA05S00U20210604P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210605P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210610P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210611P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210618P date, sort lcolor(green)) /// 20
(line TotCasMeRaA05S00U20210624P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210625P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210703P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210704P date, sort lcolor(green)) ///
(line TotCasMeRaA05S00U20210709P date, sort lcolor(green)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases SRIV percent JOHN) title("COVID-19 total cases, $country, % (SRIV minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("single scenario", size(small))
  	   
qui graph save "graph 44a COVID-19 total cases, $country, SRIV, Percent.gph", replace
qui graph export "graph 44a COVID-19 total cases, $country, SRIV, Percent.pdf", replace







view "log country SRIV.smcl"

log close

exit, clear




