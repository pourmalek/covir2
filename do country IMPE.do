
clear all
 
cd "$pathcovir2"

cd IMPE

capture log close 

log using "log country IMPE.smcl", replace

******************************************************************************
* This is "do country IMPE.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare IMPE data for country
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
DayDeaMeRaA03S02 DayINFMeRaA03S02 TotDeaMeRaA03S02 TotINFMeRaA03S02


* add uptake dte to the end of varname

local varlist ///
DayDeaMeRaA03S02 DayINFMeRaA03S02 TotDeaMeRaA03S02 TotINFMeRaA03S02

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

cd IMPE

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

save "country IMPE.dta", replace




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

cd IMPE

save "JOHN.dta", replace


}
*


merge date loc_grand_name using "country IMPE.dta"

drop _merge


local uptakedatelist ///
20210401 20210406 20210409 20210416 20210417 ///
20210423 20210424 20210506 20210514 20210515 ///
20210516 20210521 20210522 20210528 20210603 ///
20210604 20210605 20210610 20210611 20210618 ///
20210624 20210625 20210703 20210704 20210709


foreach l of local uptakedatelist {

gen DayDeaMeRaA03S02U`l'D = DayDeaMeRaA03S02U`l' - DayDeaMeSmA00S00 // D Difference 
gen DayDeaMeRaA03S02U`l'T = DayDeaMeRaA03S02U`l' / DayDeaMeSmA00S00 // T Times (more or less)
gen DayDeaMeRaA03S02U`l'P = 100 * (DayDeaMeRaA03S02U`l' - DayDeaMeSmA00S00) / DayDeaMeSmA00S00 // P Percent

gen DayINFMeRaA03S02U`l'D = DayINFMeRaA03S02U`l' - DayCasMeSmA00S00 // D Difference 
gen DayINFMeRaA03S02U`l'T = DayINFMeRaA03S02U`l' / DayCasMeSmA00S00 // T Times (more or less)
gen DayINFMeRaA03S02U`l'P = 100 * (DayINFMeRaA03S02U`l' - DayCasMeSmA00S00) / DayCasMeSmA00S00 // P Percent

gen TotDeaMeRaA03S02U`l'D = TotDeaMeRaA03S02U`l' - TotDeaMeRaA00S00 // D Difference 
gen TotDeaMeRaA03S02U`l'T = TotDeaMeRaA03S02U`l' / TotDeaMeRaA00S00 // T Times (more or less)
gen TotDeaMeRaA03S02U`l'P = 100 * (TotDeaMeRaA03S02U`l' - TotDeaMeRaA00S00) / TotDeaMeRaA00S00 // P Percent

gen TotINFMeRaA03S02U`l'D = TotINFMeRaA03S02U`l' - TotCasMeRaA00S00 // D Difference 
gen TotINFMeRaA03S02U`l'T = TotINFMeRaA03S02U`l' / TotCasMeRaA00S00 // T Times (more or less)
gen TotINFMeRaA03S02U`l'P = 100 * (TotINFMeRaA03S02U`l' - TotCasMeRaA00S00) / TotCasMeRaA00S00 // P Percent 

}
*



save "country IMPE.dta", replace



* IMPE V8 2021-05-10 on
* IMPE V7 2021-04-24 and before (IMPE V7 2021-01-18 to 2021-04-24)



**********************************************************

* graphs


grstyle init

grstyle color background white




* daily deaths

**************************************

* daily deaths, Absolute value

twoway  ///
(line DayDeaMeRaA03S02U20210401 date, sort lcolor(magenta) lpattern(dash)) /// 1
(line DayDeaMeRaA03S02U20210406 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210409 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210416 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210417 date, sort lcolor(magenta) lpattern(dash)) /// 5
(line DayDeaMeRaA03S02U20210423 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210424 date, sort lcolor(magenta) lpattern(dash)) /// 7 
(line DayDeaMeRaA03S02U20210506 date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210514 date, sort lcolor(magenta) lpattern(dash)) /// 9  20210514 v7
(line DayDeaMeRaA03S02U20210515 date, sort lcolor(magenta)) /// 10 20210515 v8
(line DayDeaMeRaA03S02U20210516 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210521 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210522 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210528 date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210603 date, sort lcolor(magenta)) /// 15
(line DayDeaMeRaA03S02U20210604 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210605 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210610 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210611 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210618 date, sort lcolor(magenta)) /// 20
(line DayDeaMeRaA03S02U20210624 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210625 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210703 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210704 date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210709 date, sort lcolor(magenta)) /// 25
(line DayDeaMeSmA00S00 date, lcolor(cyan) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8" 26 "JOHN raw") size(small) rows(1)) yscale(titlegap(2))	
  	   
qui graph save "graph 11a COVID-19 daily deaths, $country, IMPE.gph", replace
qui graph export "graph 11a COVID-19 daily deaths, $country, IMPE.pdf", replace



*********

* daily deaths, Difference

twoway  ///
(line DayDeaMeRaA03S02U20210401D date, sort lcolor(magenta) lpattern(dash)) /// 1
(line DayDeaMeRaA03S02U20210406D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210409D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210416D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210417D date, sort lcolor(magenta) lpattern(dash)) /// 5
(line DayDeaMeRaA03S02U20210423D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210424D date, sort lcolor(magenta) lpattern(dash)) /// 7 
(line DayDeaMeRaA03S02U20210506D date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210514D date, sort lcolor(magenta) lpattern(dash)) /// 9  20210514 v7
(line DayDeaMeRaA03S02U20210515D date, sort lcolor(magenta)) /// 10 20210515 v8
(line DayDeaMeRaA03S02U20210516D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210521D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210522D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210528D date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210603D date, sort lcolor(magenta)) /// 15
(line DayDeaMeRaA03S02U20210604D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210605D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210610D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210611D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210618D date, sort lcolor(magenta)) /// 20
(line DayDeaMeRaA03S02U20210624D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210625D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210703D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210704D date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210709D date, sort lcolor(magenta)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths IMPE minus JOHN smooth) title("COVID-19 daily deaths, $country, IMPE minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 12a COVID-19 daily deaths, $country, IMPE, Difference.gph", replace
qui graph export "graph 12a COVID-19 daily deaths, $country, IMPE, Difference.pdf", replace





*********

* daily deaths, Times

twoway  ///
(line DayDeaMeRaA03S02U20210401T date, sort lcolor(magenta) lpattern(dash)) /// 1
(line DayDeaMeRaA03S02U20210406T date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210409T date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210416T date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210417T date, sort lcolor(magenta) lpattern(dash)) /// 5
(line DayDeaMeRaA03S02U20210423T date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210424T date, sort lcolor(magenta) lpattern(dash)) /// 7 
(line DayDeaMeRaA03S02U20210506T date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210514T date, sort lcolor(magenta) lpattern(dash)) /// 9  20210514 v7
(line DayDeaMeRaA03S02U20210515T date, sort lcolor(magenta)) /// 10 20210515 v8
(line DayDeaMeRaA03S02U20210516T date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210521T date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210522T date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210528T date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210603T date, sort lcolor(magenta)) /// 15
(line DayDeaMeRaA03S02U20210604T date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210605T date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210610T date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210611T date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210618T date, sort lcolor(magenta)) /// 20
(line DayDeaMeRaA03S02U20210624T date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210625T date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210703T date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210704T date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210709T date, sort lcolor(magenta)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths IMPE divided by JOHN smooth) title("COVID-19 daily deaths, $country, IMPE divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 13a COVID-19 daily deaths, $country, IMPE, Times.gph", replace
qui graph export "graph 13a COVID-19 daily deaths, $country, IMPE, Times.pdf", replace




*********

* daily deaths, Percent

twoway  ///
(line DayDeaMeRaA03S02U20210401P date, sort lcolor(magenta) lpattern(dash)) /// 1
(line DayDeaMeRaA03S02U20210406P date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210409P date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210416P date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210417P date, sort lcolor(magenta) lpattern(dash)) /// 5
(line DayDeaMeRaA03S02U20210423P date, sort lcolor(magenta) lpattern(dash)) ///
(line DayDeaMeRaA03S02U20210424P date, sort lcolor(magenta) lpattern(dash)) /// 7 
(line DayDeaMeRaA03S02U20210506P date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayDeaMeRaA03S02U20210514P date, sort lcolor(magenta) lpattern(dash)) /// 9  20210514 v7
(line DayDeaMeRaA03S02U20210515P date, sort lcolor(magenta)) /// 10 20210515 v8
(line DayDeaMeRaA03S02U20210516P date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210521P date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210522P date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210528P date, sort lcolor(magenta)) /// 
(line DayDeaMeRaA03S02U20210603P date, sort lcolor(magenta)) /// 15
(line DayDeaMeRaA03S02U20210604P date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210605P date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210610P date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210611P date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210618P date, sort lcolor(magenta)) /// 20
(line DayDeaMeRaA03S02U20210624P date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210625P date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210703P date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210704P date, sort lcolor(magenta)) ///
(line DayDeaMeRaA03S02U20210709P date, sort lcolor(magenta)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths IMPE percent JOHN) title("COVID-19 daily deaths, $country, IMPE percent JOH", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 14a COVID-19 daily deaths, $country, IMPE, Percent.gph", replace
qui graph export "graph 14a COVID-19 daily deaths, $country, IMPE, Percent.pdf", replace











* daily infections

**************************************



* daily infections, Absolute value

twoway  ///
(line DayINFMeRaA03S02U20210401 date, sort lcolor(magenta) lpattern(dash)) /// 1
(line DayINFMeRaA03S02U20210406 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210409 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210416 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210417 date, sort lcolor(magenta) lpattern(dash)) /// 5
(line DayINFMeRaA03S02U20210423 date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210424 date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210506 date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210514 date, sort lcolor(magenta) lpattern(dash)) /// 9  20210514 v7
(line DayINFMeRaA03S02U20210515 date, sort lcolor(magenta)) /// 10 20210515 v8
(line DayINFMeRaA03S02U20210516 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210521 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210522 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210528 date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210603 date, sort lcolor(magenta)) /// 15
(line DayINFMeRaA03S02U20210604 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210605 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210610 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210611 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210618 date, sort lcolor(magenta)) /// 20
(line DayINFMeRaA03S02U20210624 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210625 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210703 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210704 date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210709 date, sort lcolor(magenta)) /// 25
(line DayCasMeSmA00S00 date, lcolor(cyan) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections or cases) title("COVID-19 daily infections, $country, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8" 26 "JOHN cases") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 21a COVID-19 daily infections, $country, IMPE.gph", replace
qui graph export "graph 21a COVID-19 daily infections, $country, IMPE.pdf", replace






*********

* daily infections, Difference

twoway  ///
(line DayINFMeRaA03S02U20210401D date, sort lcolor(magenta) lpattern(dash)) /// 1
(line DayINFMeRaA03S02U20210406D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210409D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210416D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210417D date, sort lcolor(magenta) lpattern(dash)) /// 5
(line DayINFMeRaA03S02U20210423D date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210424D date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210506D date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210514D date, sort lcolor(magenta) lpattern(dash)) /// 9  20210514 v7
(line DayINFMeRaA03S02U20210515D date, sort lcolor(magenta)) /// 10 20210515 v8
(line DayINFMeRaA03S02U20210516D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210521D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210522D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210528D date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210603D date, sort lcolor(magenta)) /// 15
(line DayINFMeRaA03S02U20210604D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210605D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210610D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210611D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210618D date, sort lcolor(magenta)) /// 20
(line DayINFMeRaA03S02U20210624D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210625D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210703D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210704D date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210709D date, sort lcolor(magenta)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections minus JOHN cases) title("COVID-19 daily infections, $country, IMPE infections minus cases JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 22a COVID-19 daily infections, $country, IMPE, Difference.gph", replace
qui graph export "graph 22a COVID-19 daily infections, $country, IMPE, Difference.pdf", replace






*********

* daily infections, Times

twoway  ///
(line DayINFMeRaA03S02U20210401T date, sort lcolor(magenta) lpattern(dash)) /// 1
(line DayINFMeRaA03S02U20210406T date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210409T date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210416T date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210417T date, sort lcolor(magenta) lpattern(dash)) /// 5
(line DayINFMeRaA03S02U20210423T date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210424T date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210506T date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210514T date, sort lcolor(magenta) lpattern(dash)) /// 9  20210514 v7
(line DayINFMeRaA03S02U20210515T date, sort lcolor(magenta)) /// 10 20210515 v8
(line DayINFMeRaA03S02U20210516T date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210521T date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210522T date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210528T date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210603T date, sort lcolor(magenta)) /// 15
(line DayINFMeRaA03S02U20210604T date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210605T date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210610T date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210611T date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210618T date, sort lcolor(magenta)) /// 20
(line DayINFMeRaA03S02U20210624T date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210625T date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210703T date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210704T date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210709T date, sort lcolor(magenta)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections divided by JOHN cases) title("COVID-19 daily infections, $country, IMPE infections divided by JOHN cases ", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 23a COVID-19 daily infections, $country, IMPE, Times.gph", replace
qui graph export "graph 23a COVID-19 daily infections, $country, IMPE, Times.pdf", replace








*********

* daily infections, Percent

twoway  ///
(line DayINFMeRaA03S02U20210401P date, sort lcolor(magenta) lpattern(dash)) /// 1
(line DayINFMeRaA03S02U20210406P date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210409P date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210416P date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210417P date, sort lcolor(magenta) lpattern(dash)) /// 5
(line DayINFMeRaA03S02U20210423P date, sort lcolor(magenta) lpattern(dash)) ///
(line DayINFMeRaA03S02U20210424P date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210506P date, sort lcolor(magenta) lpattern(dash)) /// 
(line DayINFMeRaA03S02U20210514P date, sort lcolor(magenta) lpattern(dash)) /// 9  20210514 v7
(line DayINFMeRaA03S02U20210515P date, sort lcolor(magenta)) /// 10 20210515 v8
(line DayINFMeRaA03S02U20210516P date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210521P date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210522P date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210528P date, sort lcolor(magenta)) /// 
(line DayINFMeRaA03S02U20210603P date, sort lcolor(magenta)) /// 15
(line DayINFMeRaA03S02U20210604P date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210605P date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210610P date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210611P date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210618P date, sort lcolor(magenta)) /// 20
(line DayINFMeRaA03S02U20210624P date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210625P date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210703P date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210704P date, sort lcolor(magenta)) ///
(line DayINFMeRaA03S02U20210709P date, sort lcolor(magenta)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections percent JOHN cases) title("COVID-19 daily infections percent, $country, IMPE percent JOHN cases", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Daily infections percent JOHN cases = 100 (IMPE infections minus JOHN cases) / JOHN cases" ///
"reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 24a COVID-19 daily infections, $country, IMPE, Percent.gph", replace
qui graph export "graph 24a COVID-19 daily infections, $country, IMPE, Percent.pdf", replace


















* total deaths

**************************************

* total deaths, Absolute value

twoway  ///
(line TotDeaMeRaA03S02U20210401 date, sort lcolor(magenta) lpattern(dash)) /// 1
(line TotDeaMeRaA03S02U20210406 date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210409 date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210416 date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210417 date, sort lcolor(magenta) lpattern(dash)) /// 5
(line TotDeaMeRaA03S02U20210423 date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210424 date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotDeaMeRaA03S02U20210506 date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotDeaMeRaA03S02U20210514 date, sort lcolor(magenta) lpattern(dash)) /// 9  20210514 v7
(line TotDeaMeRaA03S02U20210515 date, sort lcolor(magenta)) /// 10 20210515 v8
(line TotDeaMeRaA03S02U20210516 date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210521 date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210522 date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210528 date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210603 date, sort lcolor(magenta)) /// 15
(line TotDeaMeRaA03S02U20210604 date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210605 date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210610 date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210611 date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210618 date, sort lcolor(magenta)) /// 20
(line TotDeaMeRaA03S02U20210624 date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210625 date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210703 date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210704 date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210709 date, sort lcolor(magenta)) /// 25
(line TotDeaMeRaA00S00 date, lcolor(cyan) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8" 26 "JOHN") size(small) rows(1)) yscale(titlegap(2))	
  	   
qui graph save "graph 31a COVID-19 total deaths, $country, IMPE.gph", replace
qui graph export "graph 31a COVID-19 total deaths, $country, IMPE.pdf", replace







*********

* total deaths, Difference

twoway  ///
(line TotDeaMeRaA03S02U20210401D date, sort lcolor(magenta) lpattern(dash)) /// 1
(line TotDeaMeRaA03S02U20210406D date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210409D date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210416D date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210417D date, sort lcolor(magenta) lpattern(dash)) /// 5
(line TotDeaMeRaA03S02U20210423D date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210424D date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotDeaMeRaA03S02U20210506D date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotDeaMeRaA03S02U20210514D date, sort lcolor(magenta) lpattern(dash)) /// 9  20210514 v7
(line TotDeaMeRaA03S02U20210515D date, sort lcolor(magenta)) /// 10 20210515 v8
(line TotDeaMeRaA03S02U20210516D date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210521D date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210522D date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210528D date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210603D date, sort lcolor(magenta)) /// 15
(line TotDeaMeRaA03S02U20210604D date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210605D date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210610D date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210611D date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210618D date, sort lcolor(magenta)) /// 20
(line TotDeaMeRaA03S02U20210624D date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210625D date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210703D date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210704D date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210709D date, sort lcolor(magenta)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths IMPE minus JOHN) title("COVID-19 total deaths, $country, IMPE minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 32a COVID-19 total deaths, $country, IMPE, Difference.gph", replace
qui graph export "graph 32a COVID-19 total deaths, $country, IMPE, Difference.pdf", replace







*********

* total deaths, Times

twoway  ///
(line TotDeaMeRaA03S02U20210401T date, sort lcolor(magenta) lpattern(dash)) /// 1
(line TotDeaMeRaA03S02U20210406T date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210409T date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210416T date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210417T date, sort lcolor(magenta) lpattern(dash)) /// 5
(line TotDeaMeRaA03S02U20210423T date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210424T date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotDeaMeRaA03S02U20210506T date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotDeaMeRaA03S02U20210514T date, sort lcolor(magenta) lpattern(dash)) /// 9  20210514 v7
(line TotDeaMeRaA03S02U20210515T date, sort lcolor(magenta)) /// 10 20210515 v8
(line TotDeaMeRaA03S02U20210516T date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210521T date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210522T date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210528T date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210603T date, sort lcolor(magenta)) /// 15
(line TotDeaMeRaA03S02U20210604T date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210605T date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210610T date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210611T date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210618T date, sort lcolor(magenta)) /// 20
(line TotDeaMeRaA03S02U20210624T date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210625T date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210703T date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210704T date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210709T date, sort lcolor(magenta)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths IMPE divided by JOHN) title("COVID-19 total deaths, $country, IMPE divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 33a COVID-19 total deaths, $country, IMPE, Times.gph", replace
qui graph export "graph 33a COVID-19 total deaths, $country, IMPE, Times.pdf", replace




*********

* total deaths, Percent

twoway  ///
(line TotDeaMeRaA03S02U20210401P date, sort lcolor(magenta) lpattern(dash)) /// 1
(line TotDeaMeRaA03S02U20210406P date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210409P date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210416P date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210417P date, sort lcolor(magenta) lpattern(dash)) /// 5
(line TotDeaMeRaA03S02U20210423P date, sort lcolor(magenta) lpattern(dash)) ///
(line TotDeaMeRaA03S02U20210424P date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotDeaMeRaA03S02U20210506P date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotDeaMeRaA03S02U20210514P date, sort lcolor(magenta) lpattern(dash)) /// 9  20210514 v7
(line TotDeaMeRaA03S02U20210515P date, sort lcolor(magenta)) /// 10 20210515 v8
(line TotDeaMeRaA03S02U20210516P date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210521P date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210522P date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210528P date, sort lcolor(magenta)) /// 
(line TotDeaMeRaA03S02U20210603P date, sort lcolor(magenta)) /// 15
(line TotDeaMeRaA03S02U20210604P date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210605P date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210610P date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210611P date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210618P date, sort lcolor(magenta)) /// 20
(line TotDeaMeRaA03S02U20210624P date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210625P date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210703P date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210704P date, sort lcolor(magenta)) ///
(line TotDeaMeRaA03S02U20210709P date, sort lcolor(magenta)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths IMPE percent JOHN) title("COVID-19 total deaths, $country, Total deaths IMPE percent JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Total deaths IMPE percent JOHN = 100 (IMPE deaths minus JOHN deaths) / JOHN deaths" ///
"reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 34a COVID-19 total deaths, $country, IMPE, Percent.gph", replace
qui graph export "graph 34a COVID-19 total deaths, $country, IMPE, Percent.pdf", replace
















* total infections

**************************************



* total infections, Absolute value

twoway  ///
(line TotINFMeRaA03S02U20210401 date, sort lcolor(magenta) lpattern(dash)) /// 1
(line TotINFMeRaA03S02U20210406 date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210409 date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210416 date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210417 date, sort lcolor(magenta) lpattern(dash)) /// 5
(line TotINFMeRaA03S02U20210423 date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210424 date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotINFMeRaA03S02U20210506 date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotINFMeRaA03S02U20210514 date, sort lcolor(magenta) lpattern(dash)) /// 9  20210514 v7
(line TotINFMeRaA03S02U20210515 date, sort lcolor(magenta)) /// 10 20210515 v8
(line TotINFMeRaA03S02U20210516 date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210521 date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210522 date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210528 date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210603 date, sort lcolor(magenta)) /// 15
(line TotINFMeRaA03S02U20210604 date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210605 date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210610 date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210611 date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210618 date, sort lcolor(magenta)) /// 20
(line TotINFMeRaA03S02U20210624 date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210625 date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210703 date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210704 date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210709 date, sort lcolor(magenta)) /// 25
(line TotCasMeRaA00S00 date, lcolor(cyan) lwidth(thick)) /// 26
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total infections or cases) title("COVID-19 total infections, $country, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8" 26 "JOHN cases") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 41a COVID-19 total infections, $country, IMPE.gph", replace
qui graph export "graph 41a COVID-19 total infections, $country, IMPE.pdf", replace






*********

* total infections, Difference

twoway  ///
(line TotINFMeRaA03S02U20210401D date, sort lcolor(magenta) lpattern(dash)) /// 1
(line TotINFMeRaA03S02U20210406D date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210409D date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210416D date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210417D date, sort lcolor(magenta) lpattern(dash)) /// 5
(line TotINFMeRaA03S02U20210423D date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210424D date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotINFMeRaA03S02U20210506D date, sort lcolor(magenta) lpattern(dash)) /// 
(line TotINFMeRaA03S02U20210514D date, sort lcolor(magenta) lpattern(dash)) /// 9  20210514 v7
(line TotINFMeRaA03S02U20210515D date, sort lcolor(magenta)) /// 10 20210515 v8
(line TotINFMeRaA03S02U20210516D date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210521D date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210522D date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210528D date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210603D date, sort lcolor(magenta)) /// 15
(line TotINFMeRaA03S02U20210604D date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210605D date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210610D date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210611D date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210618D date, sort lcolor(magenta)) /// 20
(line TotINFMeRaA03S02U20210624D date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210625D date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210703D date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210704D date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210709D date, sort lcolor(magenta)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total infections IMPE minus JOHN cases) title("COVID-19 total infections, $country, infections IMPE minus cases JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8") size(small) rows(1))	yscale(titlegap(2))	
  	   
qui graph save "graph 42a COVID-19 total infections, $country, IMPE, Difference.gph", replace
qui graph export "graph 42a COVID-19 total infections, $country, IMPE, Difference.pdf", replace





*********

* total infections, Times

twoway  ///
(line TotINFMeRaA03S02U20210401T date, sort lcolor(magenta) lpattern(dash)) /// 1
(line TotINFMeRaA03S02U20210406T date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210409T date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210416T date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210417T date, sort lcolor(magenta) lpattern(dash)) /// 5
(line TotINFMeRaA03S02U20210423T date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210424T date, sort lcolor(magenta) lpattern(dash)) /// 7 20210424
(line TotINFMeRaA03S02U20210506T date, sort lcolor(magenta)) /// 8 20210506
(line TotINFMeRaA03S02U20210514T date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210515T date, sort lcolor(magenta)) /// 10
(line TotINFMeRaA03S02U20210516T date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210521T date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210522T date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210528T date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210603T date, sort lcolor(magenta)) /// 15
(line TotINFMeRaA03S02U20210604T date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210605T date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210610T date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210611T date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210618T date, sort lcolor(magenta)) /// 20
(line TotINFMeRaA03S02U20210624T date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210625T date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210703T date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210704T date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210709T date, sort lcolor(magenta)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total infections IMPE divided by JOHN cases) title("COVID-19 total infections, $country, infections IMPE divided by cases JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8") size(small) rows(1)) yscale(titlegap(2))	
  	   
qui graph save "graph 43a COVID-19 total infections, $country, IMPE, Times.gph", replace
qui graph export "graph 43a COVID-19 total infections, $country, IMPE, Times.pdf", replace






*********

* total infections, Percent

twoway  ///
(line TotINFMeRaA03S02U20210401P date, sort lcolor(magenta) lpattern(dash)) /// 1
(line TotINFMeRaA03S02U20210406P date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210409P date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210416P date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210417P date, sort lcolor(magenta) lpattern(dash)) /// 5
(line TotINFMeRaA03S02U20210423P date, sort lcolor(magenta) lpattern(dash)) ///
(line TotINFMeRaA03S02U20210424P date, sort lcolor(magenta) lpattern(dash)) /// 7 20210424
(line TotINFMeRaA03S02U20210506P date, sort lcolor(magenta)) /// 8 20210506
(line TotINFMeRaA03S02U20210514P date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210515P date, sort lcolor(magenta)) /// 10
(line TotINFMeRaA03S02U20210516P date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210521P date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210522P date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210528P date, sort lcolor(magenta)) /// 
(line TotINFMeRaA03S02U20210603P date, sort lcolor(magenta)) /// 15
(line TotINFMeRaA03S02U20210604P date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210605P date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210610P date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210611P date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210618P date, sort lcolor(magenta)) /// 20
(line TotINFMeRaA03S02U20210624P date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210625P date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210703P date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210704P date, sort lcolor(magenta)) ///
(line TotINFMeRaA03S02U20210709P date, sort lcolor(magenta)) /// 25
if date >= td(01apr2021) & date <= td(01sep2021), ///	   
xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total infections IMPE percent JOHN cases) title("COVID-19 total infections, $country, IMPE percent JOHN cases", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("Total infections IMPE percent JOHN cases = 100 (IMPE infections minus JOHN cases) / JOHN cases" ///
"reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(9 "IMPE model v7" 10 "IMPE model v8") size(small) rows(1))  yscale(titlegap(2))	
  	   
qui graph save "graph 44a COVID-19 total infections, $country, IMPE, Percent.gph", replace
qui graph export "graph 44a COVID-19 total infections, $country, IMPE, Percent.pdf", replace







view "log country IMPE.smcl"

log close

exit, clear




