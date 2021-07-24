

clear all

cd "$pathcovir2"

cd IHME

capture log close 

log using "log country IHME merge.smcl", replace

*****************************************************************************
* This is "do country IHME merge.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare IHME study estimates for country
*****************************************************************************


* 20200625 (unrevoked) update dates starting from 20200625, to 20210715.
* IHME model versions:
* IHME V1 20200325 to 20200429: Curve Fit (CF) // not applicable here
* IHME V2 20200504 to 20200526: Curve Fit & SEIR (CF-SEIR) // not applicable here
* IHME V3 20200529 to 20210430: Spline Fit & SEIR (SF-SEIR)
* IHME V4 20210506 to when specified otherwise: SF-SEIR & excess mortality





* get JOHN	


qui {

cd "$pathcovir2" // "/Users/`usrnam'/Downloads/covir2-main/longitudinal/20210715/code"

cd JOHN 

use "country JOHN.dta", clear 

keep date loc_grand_name DayDeaMeRaA00S00 DayDeaMeSmA00S00 TotDeaMeRaA00S00 DayCasMeRaA00S00 DayCasMeSmA00S00 TotCasMeRaA00S00

sort date loc_grand_name

cd .. // code

cd IHME

save "JOHN.dta", replace

}
*
	
	
	
	



global IHMEupdatelist ///
20200625 /// 1
20200629 /// 2
20200707 /// 3
20200714 /// 4
20200722 /// 5
20200730 /// 6
20200806 /// 7
20200821 /// 8
20200827 /// 9
20200903 /// 10
20200911 /// 11
20200918 /// 12
20200924 /// 13
20201002 /// 14
20201009 /// 15
20201015 /// 16
20201022 /// 17
20201029 /// 18
20201112 /// 19
20201119 /// 20
20201203 /// 21
20201210 /// 22
20201217 /// 23
20201223 /// 24
20210115 /// 25
20210122 /// 26
20210128 /// 27
20210204 /// 28
20210212 /// 29
20210220 /// 30
20210225 /// 31
20210306 /// 32
20210311 /// 33
20210317 /// 34
20210325 /// 35
20210401 /// 36
20210409 /// 37
20210416 /// 38
20210423 /// 39
20210506 /// 40
20210514 /// 41
20210521 /// 42
20210528 /// 43
20210604 /// 44
20210610 /// 45
20210618 /// 46
20210625 /// 47
20210702 /// 48
20210715 //  49





foreach l of global IHMEupdatelist {

qui {

merge m:m date loc_grand_name using "IHME `l' country.dta"

drop _merge

* quitely running commands ...

}
}
*



* gen vars for D Difference, T Times (more or less), P Percent

/* sample 20210115
DayDeaMeRaA02S01U20210115 
DayDeaMeSmA02S01U20210115 
TotDeaMeRaA02S01U20210115 
DayINFMeRaA02S01U20210115 
TotINFMeRaA02S01U20210115 
TotDeaMeSmA02S01U20210115
*/


/*

Target of IHME model v3 estimates for deaths in Iran was the reported deaths.  

Target of IHME model v4 estimates for deaths in Iran was the (reported deaths) * 2.4, 
where 2.4 is IHME’s estimate for correction factor of deaths under-reporting in Iran. 

*/


global IHMEupdatelistv3 ///
20200625 /// 1
20200629 /// 2
20200707 /// 3
20200714 /// 4
20200722 /// 5
20200730 /// 6
20200806 /// 7
20200821 /// 8
20200827 /// 9
20200903 /// 10
20200911 /// 11
20200918 /// 12
20200924 /// 13
20201002 /// 14
20201009 /// 15
20201015 /// 16
20201022 /// 17
20201029 /// 18
20201112 /// 19
20201119 /// 20
20201203 /// 21
20201210 /// 22
20201217 /// 23
20201223 /// 24
20210115 /// 25
20210122 /// 26
20210128 /// 27
20210204 /// 28
20210212 /// 29
20210220 /// 30
20210225 /// 31
20210306 /// 32
20210311 /// 33
20210317 /// 34
20210325 /// 35
20210401 /// 36
20210409 /// 37
20210416 /// 38
20210423 // 39


global IHMEupdatelistv4 ///
20210506 /// 40
20210514 /// 41
20210521 /// 42
20210528 /// 43
20210604 /// 44
20210610 /// 45
20210618 /// 46
20210625 /// 47
20210702 /// 48
20210715 //  49






foreach l of global IHMEupdatelistv3 {

qui {

gen DayDeaMeSmA02S01U`l'D = DayDeaMeSmA02S01U`l' - (DayDeaMeSmA00S00 * 1) // D Difference 
gen DayDeaMeSmA02S01U`l'T = DayDeaMeSmA02S01U`l' / (DayDeaMeSmA00S00 * 1) // T Times (more or less)
gen DayDeaMeSmA02S01U`l'P = 100 * (DayDeaMeSmA02S01U`l' - (DayDeaMeSmA00S00 * 1)) / (DayDeaMeSmA00S00 * 1) // P Percent

gen TotDeaMeRaA02S01U`l'D = TotDeaMeRaA02S01U`l' - (TotDeaMeRaA00S00 * 1) // D Difference 
gen TotDeaMeRaA02S01U`l'T = TotDeaMeRaA02S01U`l' / (TotDeaMeRaA00S00 * 1) // T Times (more or less)
gen TotDeaMeRaA02S01U`l'P = 100 * (TotDeaMeRaA02S01U`l' - (TotDeaMeRaA00S00 * 1)) / (TotDeaMeRaA00S00 * 1) // P Percent

}
}
*






foreach l of global IHMEupdatelistv4 {

qui {

gen DayDeaMeSmA02S01U`l'D = DayDeaMeSmA02S01U`l' - (DayDeaMeSmA00S00 * 2.4) // D Difference 
gen DayDeaMeSmA02S01U`l'T = DayDeaMeSmA02S01U`l' / (DayDeaMeSmA00S00 * 2.4) // T Times (more or less)
gen DayDeaMeSmA02S01U`l'P = 100 * (DayDeaMeSmA02S01U`l' - (DayDeaMeSmA00S00 * 2.4)) / (DayDeaMeSmA00S00 * 2.4) // P Percent

gen TotDeaMeRaA02S01U`l'D = TotDeaMeRaA02S01U`l' - (TotDeaMeRaA00S00 * 2.4) // D Difference 
gen TotDeaMeRaA02S01U`l'T = TotDeaMeRaA02S01U`l' / (TotDeaMeRaA00S00 * 2.4) // T Times (more or less)
gen TotDeaMeRaA02S01U`l'P = 100 * (TotDeaMeRaA02S01U`l' - (TotDeaMeRaA00S00 * 2.4)) / (TotDeaMeRaA00S00 * 2.4) // P Percent

}
}
*




sort date loc_grand_name

qui compress 

save "country IHME.dta", replace







**********************************************************

* graphs


grstyle init

grstyle color background white



* daily deaths

**************************************

* daily deaths, Absolute value, individual updates


foreach l of global IHMEupdatelist {

twoway  /// 
(line DayDeaMeSmA00S00 date, lcolor(cyan*1.2)) /// 
(line DayDeaMeSmA02S01U`l' date, sort lcolor(black)) /// 
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, IHME, update `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(2 "IHME `l'" 1 "JOHN smooth") size(small) rows(1))	yscale(titlegap(2))

qui graph save "graph 11i COVID-19 daily deaths, $country, IHME update `l'.gph", replace
qui graph export "graph 11i COVID-19 daily deaths, $country, IHME update `l'.pdf", replace

}
*


 


* daily deaths, Absolute value, together

twoway  ///
(line DayDeaMeSmA02S01U20200625 date, sort lcolor(gray)) /// 1
(line DayDeaMeSmA02S01U20200629 date, sort lcolor(gray)) /// 2
(line DayDeaMeSmA02S01U20200707 date, sort lcolor(gray)) /// 3
(line DayDeaMeSmA02S01U20200714 date, sort lcolor(gray)) /// 4
(line DayDeaMeSmA02S01U20200722 date, sort lcolor(gray)) /// 5
(line DayDeaMeSmA02S01U20200730 date, sort lcolor(gray)) /// 6
(line DayDeaMeSmA02S01U20200806 date, sort lcolor(gray)) /// 7
(line DayDeaMeSmA02S01U20200821 date, sort lcolor(gray)) /// 8
(line DayDeaMeSmA02S01U20200827 date, sort lcolor(gray)) /// 9
(line DayDeaMeSmA02S01U20200903 date, sort lcolor(gray)) /// 10
(line DayDeaMeSmA02S01U20200911 date, sort lcolor(gray)) /// 11
(line DayDeaMeSmA02S01U20200918 date, sort lcolor(gray)) /// 12
(line DayDeaMeSmA02S01U20200924 date, sort lcolor(gray)) /// 13
(line DayDeaMeSmA02S01U20201002 date, sort lcolor(gray)) /// 14
(line DayDeaMeSmA02S01U20201009 date, sort lcolor(gray)) /// 15
(line DayDeaMeSmA02S01U20201015 date, sort lcolor(gray)) /// 16
(line DayDeaMeSmA02S01U20201022 date, sort lcolor(gray)) /// 17
(line DayDeaMeSmA02S01U20201029 date, sort lcolor(gray)) /// 18
(line DayDeaMeSmA02S01U20201112 date, sort lcolor(gray)) /// 19
(line DayDeaMeSmA02S01U20201119 date, sort lcolor(gray)) /// 20
(line DayDeaMeSmA02S01U20201203 date, sort lcolor(gray)) /// 21
(line DayDeaMeSmA02S01U20201210 date, sort lcolor(gray)) /// 22
(line DayDeaMeSmA02S01U20201217 date, sort lcolor(gray)) /// 23
(line DayDeaMeSmA02S01U20201223 date, sort lcolor(gray)) /// 24
(line DayDeaMeSmA02S01U20210115 date, sort lcolor(gray)) /// 25
(line DayDeaMeSmA02S01U20210122 date, sort lcolor(gray)) /// 26
(line DayDeaMeSmA02S01U20210128 date, sort lcolor(gray)) /// 27
(line DayDeaMeSmA02S01U20210204 date, sort lcolor(gray)) /// 28
(line DayDeaMeSmA02S01U20210212 date, sort lcolor(gray)) /// 29
(line DayDeaMeSmA02S01U20210220 date, sort lcolor(gray)) /// 30
(line DayDeaMeSmA02S01U20210225 date, sort lcolor(gray)) /// 31
(line DayDeaMeSmA02S01U20210306 date, sort lcolor(gray)) /// 32
(line DayDeaMeSmA02S01U20210311 date, sort lcolor(gray)) /// 33
(line DayDeaMeSmA02S01U20210317 date, sort lcolor(gray)) /// 34
(line DayDeaMeSmA02S01U20210325 date, sort lcolor(gray)) /// 35
(line DayDeaMeSmA02S01U20210401 date, sort lcolor(gray)) /// 36
(line DayDeaMeSmA02S01U20210409 date, sort lcolor(gray)) /// 37
(line DayDeaMeSmA02S01U20210416 date, sort lcolor(gray)) /// 38
(line DayDeaMeSmA02S01U20210423 date, sort lcolor(gray)) /// 39 v3
(line DayDeaMeSmA02S01U20210506 date, sort lcolor(red)) /// 40 v4
(line DayDeaMeSmA02S01U20210514 date, sort lcolor(red)) /// 41
(line DayDeaMeSmA02S01U20210521 date, sort lcolor(red)) /// 42
(line DayDeaMeSmA02S01U20210528 date, sort lcolor(red)) /// 43
(line DayDeaMeSmA02S01U20210604 date, sort lcolor(red)) /// 44
(line DayDeaMeSmA02S01U20210610 date, sort lcolor(red)) /// 45
(line DayDeaMeSmA02S01U20210618 date, sort lcolor(red)) /// 46
(line DayDeaMeSmA02S01U20210625 date, sort lcolor(red)) /// 47
(line DayDeaMeSmA02S01U20210702 date, sort lcolor(red)) /// 48
(line DayDeaMeSmA02S01U20210715 date, sort lcolor(red)) /// 49
(line DayDeaMeSmA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 50
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200625 to 20210715; reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(39 "IHME v3" 40 "IHME v4" 50 "JOHN smooth") size(small) rows(1)) yscale(titlegap(2))
	   	   
qui graph save "graph 11a COVID-19 daily deaths, $country, IHME.gph", replace
qui graph export "graph 11a COVID-19 daily deaths, $country, IHME.pdf", replace




*********

* daily deaths, Difference, together

twoway  ///
(line DayDeaMeSmA02S01U20200625D date, sort lcolor(gray)) /// 1
(line DayDeaMeSmA02S01U20200629D date, sort lcolor(gray)) /// 2
(line DayDeaMeSmA02S01U20200707D date, sort lcolor(gray)) /// 3
(line DayDeaMeSmA02S01U20200714D date, sort lcolor(gray)) /// 4
(line DayDeaMeSmA02S01U20200722D date, sort lcolor(gray)) /// 5
(line DayDeaMeSmA02S01U20200730D date, sort lcolor(gray)) /// 6
(line DayDeaMeSmA02S01U20200806D date, sort lcolor(gray)) /// 7
(line DayDeaMeSmA02S01U20200821D date, sort lcolor(gray)) /// 8
(line DayDeaMeSmA02S01U20200827D date, sort lcolor(gray)) /// 9
(line DayDeaMeSmA02S01U20200903D date, sort lcolor(gray)) /// 10
(line DayDeaMeSmA02S01U20200911D date, sort lcolor(gray)) /// 11
(line DayDeaMeSmA02S01U20200918D date, sort lcolor(gray)) /// 12
(line DayDeaMeSmA02S01U20200924D date, sort lcolor(gray)) /// 13
(line DayDeaMeSmA02S01U20201002D date, sort lcolor(gray)) /// 14
(line DayDeaMeSmA02S01U20201009D date, sort lcolor(gray)) /// 15
(line DayDeaMeSmA02S01U20201015D date, sort lcolor(gray)) /// 16
(line DayDeaMeSmA02S01U20201022D date, sort lcolor(gray)) /// 17
(line DayDeaMeSmA02S01U20201029D date, sort lcolor(gray)) /// 18
(line DayDeaMeSmA02S01U20201112D date, sort lcolor(gray)) /// 19
(line DayDeaMeSmA02S01U20201119D date, sort lcolor(gray)) /// 20
(line DayDeaMeSmA02S01U20201203D date, sort lcolor(gray)) /// 21
(line DayDeaMeSmA02S01U20201210D date, sort lcolor(gray)) /// 22
(line DayDeaMeSmA02S01U20201217D date, sort lcolor(gray)) /// 23
(line DayDeaMeSmA02S01U20201223D date, sort lcolor(gray)) /// 24
(line DayDeaMeSmA02S01U20210115D date, sort lcolor(gray)) /// 25
(line DayDeaMeSmA02S01U20210122D date, sort lcolor(gray)) /// 26
(line DayDeaMeSmA02S01U20210128D date, sort lcolor(gray)) /// 27
(line DayDeaMeSmA02S01U20210204D date, sort lcolor(gray)) /// 28
(line DayDeaMeSmA02S01U20210212D date, sort lcolor(gray)) /// 29
(line DayDeaMeSmA02S01U20210220D date, sort lcolor(gray)) /// 30
(line DayDeaMeSmA02S01U20210225D date, sort lcolor(gray)) /// 31
(line DayDeaMeSmA02S01U20210306D date, sort lcolor(gray)) /// 32
(line DayDeaMeSmA02S01U20210311D date, sort lcolor(gray)) /// 33
(line DayDeaMeSmA02S01U20210317D date, sort lcolor(gray)) /// 34
(line DayDeaMeSmA02S01U20210325D date, sort lcolor(gray)) /// 35
(line DayDeaMeSmA02S01U20210401D date, sort lcolor(gray)) /// 36
(line DayDeaMeSmA02S01U20210409D date, sort lcolor(gray)) /// 37
(line DayDeaMeSmA02S01U20210416D date, sort lcolor(gray)) /// 38
(line DayDeaMeSmA02S01U20210423D date, sort lcolor(gray)) /// 39 v3
(line DayDeaMeSmA02S01U20210506D date, sort lcolor(red)) /// 40 v4
(line DayDeaMeSmA02S01U20210514D date, sort lcolor(red)) /// 41
(line DayDeaMeSmA02S01U20210521D date, sort lcolor(red)) /// 42
(line DayDeaMeSmA02S01U20210528D date, sort lcolor(red)) /// 43
(line DayDeaMeSmA02S01U20210604D date, sort lcolor(red)) /// 44
(line DayDeaMeSmA02S01U20210610D date, sort lcolor(red)) /// 45
(line DayDeaMeSmA02S01U20210618D date, sort lcolor(red)) /// 46
(line DayDeaMeSmA02S01U20210625D date, sort lcolor(red)) /// 47
(line DayDeaMeSmA02S01U20210702D date, sort lcolor(red)) /// 48
(line DayDeaMeSmA02S01U20210715D date, sort lcolor(red)) /// 49
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths IHME minus JOHN smooth) title("COVID-19 daily deaths, $country, IHME minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
subtitle("all updates 20200625 to 20210715; reference scenario" ///
"IHME minus JOHN smooth for model v3, IHME minus 2.4 times JOHN smooth for model v4", size(small)) ///
legend(order(39 "IHME v3" 40 "IHME v4") size(small) rows(1)) yscale(titlegap(2))
  	   
qui graph save "graph 12a COVID-19 daily deaths, $country, IHME, Difference.gph", replace
qui graph export "graph 12a COVID-19 daily deaths, $country, IHME, Difference.pdf", replace



*********

* daily deaths, Times, together 



twoway  ///
(line DayDeaMeSmA02S01U20200625T date, sort lcolor(gray)) /// 1
(line DayDeaMeSmA02S01U20200629T date, sort lcolor(gray)) /// 2
(line DayDeaMeSmA02S01U20200707T date, sort lcolor(gray)) /// 3
(line DayDeaMeSmA02S01U20200714T date, sort lcolor(gray)) /// 4
(line DayDeaMeSmA02S01U20200722T date, sort lcolor(gray)) /// 5
(line DayDeaMeSmA02S01U20200730T date, sort lcolor(gray)) /// 6
(line DayDeaMeSmA02S01U20200806T date, sort lcolor(gray)) /// 7
(line DayDeaMeSmA02S01U20200821T date, sort lcolor(gray)) /// 8
(line DayDeaMeSmA02S01U20200827T date, sort lcolor(gray)) /// 9
(line DayDeaMeSmA02S01U20200903T date, sort lcolor(gray)) /// 10
(line DayDeaMeSmA02S01U20200911T date, sort lcolor(gray)) /// 11
(line DayDeaMeSmA02S01U20200918T date, sort lcolor(gray)) /// 12
(line DayDeaMeSmA02S01U20200924T date, sort lcolor(gray)) /// 13
(line DayDeaMeSmA02S01U20201002T date, sort lcolor(gray)) /// 14
(line DayDeaMeSmA02S01U20201009T date, sort lcolor(gray)) /// 15
(line DayDeaMeSmA02S01U20201015T date, sort lcolor(gray)) /// 16
(line DayDeaMeSmA02S01U20201022T date, sort lcolor(gray)) /// 17
(line DayDeaMeSmA02S01U20201029T date, sort lcolor(gray)) /// 18
(line DayDeaMeSmA02S01U20201112T date, sort lcolor(gray)) /// 19
(line DayDeaMeSmA02S01U20201119T date, sort lcolor(gray)) /// 20
(line DayDeaMeSmA02S01U20201203T date, sort lcolor(gray)) /// 21
(line DayDeaMeSmA02S01U20201210T date, sort lcolor(gray)) /// 22
(line DayDeaMeSmA02S01U20201217T date, sort lcolor(gray)) /// 23
(line DayDeaMeSmA02S01U20201223T date, sort lcolor(gray)) /// 24
(line DayDeaMeSmA02S01U20210115T date, sort lcolor(gray)) /// 25
(line DayDeaMeSmA02S01U20210122T date, sort lcolor(gray)) /// 26
(line DayDeaMeSmA02S01U20210128T date, sort lcolor(gray)) /// 27
(line DayDeaMeSmA02S01U20210204T date, sort lcolor(gray)) /// 28
(line DayDeaMeSmA02S01U20210212T date, sort lcolor(gray)) /// 29
(line DayDeaMeSmA02S01U20210220T date, sort lcolor(gray)) /// 30
(line DayDeaMeSmA02S01U20210225T date, sort lcolor(gray)) /// 31
(line DayDeaMeSmA02S01U20210306T date, sort lcolor(gray)) /// 32
(line DayDeaMeSmA02S01U20210311T date, sort lcolor(gray)) /// 33
(line DayDeaMeSmA02S01U20210317T date, sort lcolor(gray)) /// 34
(line DayDeaMeSmA02S01U20210325T date, sort lcolor(gray)) /// 35
(line DayDeaMeSmA02S01U20210401T date, sort lcolor(gray)) /// 36
(line DayDeaMeSmA02S01U20210409T date, sort lcolor(gray)) /// 37
(line DayDeaMeSmA02S01U20210416T date, sort lcolor(gray)) /// 38
(line DayDeaMeSmA02S01U20210423T date, sort lcolor(gray)) /// 39 v3
(line DayDeaMeSmA02S01U20210506T date, sort lcolor(red)) /// 40 v4
(line DayDeaMeSmA02S01U20210514T date, sort lcolor(red)) /// 41
(line DayDeaMeSmA02S01U20210521T date, sort lcolor(red)) /// 42
(line DayDeaMeSmA02S01U20210528T date, sort lcolor(red)) /// 43
(line DayDeaMeSmA02S01U20210604T date, sort lcolor(red)) /// 44
(line DayDeaMeSmA02S01U20210610T date, sort lcolor(red)) /// 45
(line DayDeaMeSmA02S01U20210618T date, sort lcolor(red)) /// 46
(line DayDeaMeSmA02S01U20210625T date, sort lcolor(red)) /// 47
(line DayDeaMeSmA02S01U20210702T date, sort lcolor(red)) /// 48
(line DayDeaMeSmA02S01U20210715T date, sort lcolor(red)) /// 49
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths IHME divided by JOHN smooth) title("COVID-19 daily deaths, $country, IHME divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200625 to 20210715; reference scenario" ///
"IHME divided by JOHN smooth for model v3, IHME divided by 2.4 times JOHN smooth for model v4", size(small)) ///
legend(order(39 "IHME v3" 40 "IHME v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))	
  	   
qui graph save "graph 13a COVID-19 daily deaths, $country, IHME, Times.gph", replace
qui graph export "graph 13a COVID-19 daily deaths, $country, IHME, Times.pdf", replace




*********

* daily deaths, Percent, together

twoway  ///
(line DayDeaMeSmA02S01U20200625P date, sort lcolor(gray)) /// 1
(line DayDeaMeSmA02S01U20200629P date, sort lcolor(gray)) /// 2
(line DayDeaMeSmA02S01U20200707P date, sort lcolor(gray)) /// 3
(line DayDeaMeSmA02S01U20200714P date, sort lcolor(gray)) /// 4
(line DayDeaMeSmA02S01U20200722P date, sort lcolor(gray)) /// 5
(line DayDeaMeSmA02S01U20200730P date, sort lcolor(gray)) /// 6
(line DayDeaMeSmA02S01U20200806P date, sort lcolor(gray)) /// 7
(line DayDeaMeSmA02S01U20200821P date, sort lcolor(gray)) /// 8
(line DayDeaMeSmA02S01U20200827P date, sort lcolor(gray)) /// 9
(line DayDeaMeSmA02S01U20200903P date, sort lcolor(gray)) /// 10
(line DayDeaMeSmA02S01U20200911P date, sort lcolor(gray)) /// 11
(line DayDeaMeSmA02S01U20200918P date, sort lcolor(gray)) /// 12
(line DayDeaMeSmA02S01U20200924P date, sort lcolor(gray)) /// 13
(line DayDeaMeSmA02S01U20201002P date, sort lcolor(gray)) /// 14
(line DayDeaMeSmA02S01U20201009P date, sort lcolor(gray)) /// 15
(line DayDeaMeSmA02S01U20201015P date, sort lcolor(gray)) /// 16
(line DayDeaMeSmA02S01U20201022P date, sort lcolor(gray)) /// 17
(line DayDeaMeSmA02S01U20201029P date, sort lcolor(gray)) /// 18
(line DayDeaMeSmA02S01U20201112P date, sort lcolor(gray)) /// 19
(line DayDeaMeSmA02S01U20201119P date, sort lcolor(gray)) /// 20
(line DayDeaMeSmA02S01U20201203P date, sort lcolor(gray)) /// 21
(line DayDeaMeSmA02S01U20201210P date, sort lcolor(gray)) /// 22
(line DayDeaMeSmA02S01U20201217P date, sort lcolor(gray)) /// 23
(line DayDeaMeSmA02S01U20201223P date, sort lcolor(gray)) /// 24
(line DayDeaMeSmA02S01U20210115P date, sort lcolor(gray)) /// 25
(line DayDeaMeSmA02S01U20210122P date, sort lcolor(gray)) /// 26
(line DayDeaMeSmA02S01U20210128P date, sort lcolor(gray)) /// 27
(line DayDeaMeSmA02S01U20210204P date, sort lcolor(gray)) /// 28
(line DayDeaMeSmA02S01U20210212P date, sort lcolor(gray)) /// 29
(line DayDeaMeSmA02S01U20210220P date, sort lcolor(gray)) /// 30
(line DayDeaMeSmA02S01U20210225P date, sort lcolor(gray)) /// 31
(line DayDeaMeSmA02S01U20210306P date, sort lcolor(gray)) /// 32
(line DayDeaMeSmA02S01U20210311P date, sort lcolor(gray)) /// 33
(line DayDeaMeSmA02S01U20210317P date, sort lcolor(gray)) /// 34
(line DayDeaMeSmA02S01U20210325P date, sort lcolor(gray)) /// 35
(line DayDeaMeSmA02S01U20210401P date, sort lcolor(gray)) /// 36
(line DayDeaMeSmA02S01U20210409P date, sort lcolor(gray)) /// 37
(line DayDeaMeSmA02S01U20210416P date, sort lcolor(gray)) /// 38
(line DayDeaMeSmA02S01U20210423P date, sort lcolor(gray)) /// 39 v3
(line DayDeaMeSmA02S01U20210506P date, sort lcolor(red)) /// 40 v4
(line DayDeaMeSmA02S01U20210514P date, sort lcolor(red)) /// 41
(line DayDeaMeSmA02S01U20210521P date, sort lcolor(red)) /// 42
(line DayDeaMeSmA02S01U20210528P date, sort lcolor(red)) /// 43
(line DayDeaMeSmA02S01U20210604P date, sort lcolor(red)) /// 44
(line DayDeaMeSmA02S01U20210610P date, sort lcolor(red)) /// 45
(line DayDeaMeSmA02S01U20210618P date, sort lcolor(red)) /// 46
(line DayDeaMeSmA02S01U20210625P date, sort lcolor(red)) /// 47
(line DayDeaMeSmA02S01U20210702P date, sort lcolor(red)) /// 48
(line DayDeaMeSmA02S01U20210715P date, sort lcolor(red)) /// 49
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths IHME percent JOHN smooth) title("COVID-19 daily deaths, $country, % (IHME minus JOHN smooth) / JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200625 to 20210715; reference scenario" ///
"(IHME minus JOHN) / JOHN for model v3, (IHME minus 2.4*JOHN) / 2.4*JOHN for model v4", size(small)) ///
legend(order(39 "IHME v3" 40 "IHME v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 14a COVID-19 daily deaths, $country, IHME, Percent.gph", replace
qui graph export "graph 14a COVID-19 daily deaths, $country, IHME, Percent.pdf", replace









* daily infections

**************************************



global IHMEupdatelistwithINF ///
20201009 /// 15
20201015 /// 16
20201022 /// 17
20201029 /// 18
20201112 /// 19
20201119 /// 20
20201203 /// 21
20201210 /// 22
20201217 /// 23
20201223 /// 24
20210115 /// 25
20210122 /// 26
20210128 /// 27
20210204 /// 28
20210212 /// 29
20210220 /// 30
20210225 /// 31
20210306 /// 32
20210311 /// 33
20210317 /// 34
20210325 /// 35
20210401 /// 36
20210409 /// 37
20210416 /// 38
20210423 /// 39
20210506 /// 40
20210514 /// 41
20210521 /// 42
20210528 /// 43
20210604 /// 44
20210610 /// 45
20210618 /// 46
20210625 /// 47
20210702 /// 48
20210715 //  49




* daily infections, Absolute value, individual updates


foreach l of global IHMEupdatelistwithINF {

twoway  /// 
(line DayCasMeSmA00S00 date, lcolor(cyan*1.2)) ///  
(line DayINFMeRaA02S01U`l' date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(daily infections) title("COVID-19 daily infections, $country, IHME, update `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases smooth" 2 "IHME infections `l'") size(small) rows(1))	

qui graph save "graph 21i COVID-19 daily infections, $country, IHME update `l'.gph", replace
qui graph export "graph 21i COVID-19 daily infections, $country, IHME update `l'.pdf", replace

}
*



* daily infections, Absolute value, together
       
twoway  ///
(line DayINFMeRaA02S01U20201009 date, sort lcolor(gray)) /// 15
(line DayINFMeRaA02S01U20201015 date, sort lcolor(gray)) /// 16
(line DayINFMeRaA02S01U20201022 date, sort lcolor(gray)) /// 17
(line DayINFMeRaA02S01U20201029 date, sort lcolor(gray)) /// 18
(line DayINFMeRaA02S01U20201112 date, sort lcolor(gray)) /// 19
(line DayINFMeRaA02S01U20201119 date, sort lcolor(gray)) /// 20
(line DayINFMeRaA02S01U20201203 date, sort lcolor(gray)) /// 21
(line DayINFMeRaA02S01U20201210 date, sort lcolor(gray)) /// 22
(line DayINFMeRaA02S01U20201217 date, sort lcolor(gray)) /// 23
(line DayINFMeRaA02S01U20201223 date, sort lcolor(gray)) /// 24
(line DayINFMeRaA02S01U20210115 date, sort lcolor(gray)) /// 25
(line DayINFMeRaA02S01U20210122 date, sort lcolor(gray)) /// 26
(line DayINFMeRaA02S01U20210128 date, sort lcolor(gray)) /// 27
(line DayINFMeRaA02S01U20210204 date, sort lcolor(gray)) /// 28
(line DayINFMeRaA02S01U20210212 date, sort lcolor(gray)) /// 29
(line DayINFMeRaA02S01U20210220 date, sort lcolor(gray)) /// 30
(line DayINFMeRaA02S01U20210225 date, sort lcolor(gray)) /// 31
(line DayINFMeRaA02S01U20210306 date, sort lcolor(gray)) /// 32
(line DayINFMeRaA02S01U20210311 date, sort lcolor(gray)) /// 33
(line DayINFMeRaA02S01U20210317 date, sort lcolor(gray)) /// 34
(line DayINFMeRaA02S01U20210325 date, sort lcolor(gray)) /// 35
(line DayINFMeRaA02S01U20210401 date, sort lcolor(gray)) /// 36
(line DayINFMeRaA02S01U20210409 date, sort lcolor(gray)) /// 37
(line DayINFMeRaA02S01U20210416 date, sort lcolor(gray)) /// 38
(line DayINFMeRaA02S01U20210423 date, sort lcolor(gray)) /// 39 v3
(line DayINFMeRaA02S01U20210506 date, sort lcolor(red)) /// 40 v4
(line DayINFMeRaA02S01U20210514 date, sort lcolor(red)) /// 41
(line DayINFMeRaA02S01U20210521 date, sort lcolor(red)) /// 42
(line DayINFMeRaA02S01U20210528 date, sort lcolor(red)) /// 43
(line DayINFMeRaA02S01U20210604 date, sort lcolor(red)) /// 44
(line DayINFMeRaA02S01U20210610 date, sort lcolor(red)) /// 45
(line DayINFMeRaA02S01U20210618 date, sort lcolor(red)) /// 46
(line DayINFMeRaA02S01U20210625 date, sort lcolor(red)) /// 47
(line DayINFMeRaA02S01U20210702 date, sort lcolor(red)) /// 48
(line DayINFMeRaA02S01U20210715 date, sort lcolor(red)) /// 49
(line DayCasMeSmA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 50
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections) title("COVID-19 daily infections, $country, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200625 to 20210715, infections from 20201009 on; reference scenario", size(small)) ///
legend(order(39 "IHME v3" 40 "IHME v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 21a COVID-19 daily infections, $country, IHME.gph", replace
qui graph export "graph 21a COVID-19 daily infections, $country, IHME.pdf", replace





* total deaths

**************************************



* total deaths, Absolute value, individual updates


foreach l of global IHMEupdatelist { 

twoway  /// 
(line TotDeaMeRaA00S00 date, lcolor(cyan*1.2)) /// 
(line TotDeaMeRaA02S01U`l' date, sort lcolor(red)) /// 
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, IHME, update `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(2 "IHME `l'" 1 "JOHN smooth") size(small) rows(1))	

qui graph save "graph 31i COVID-19 total deaths, $country, IHME update `l'.gph", replace
qui graph export "graph 31i COVID-19 total deaths, $country, IHME update `l'.pdf", replace

}
*





* total deaths, Absolute value, together

twoway  ///
(line TotDeaMeSmA02S01U20200625 date, sort lcolor(gray)) /// 1
(line TotDeaMeSmA02S01U20200629 date, sort lcolor(gray)) /// 2
(line TotDeaMeSmA02S01U20200707 date, sort lcolor(gray)) /// 3
(line TotDeaMeSmA02S01U20200714 date, sort lcolor(gray)) /// 4
(line TotDeaMeSmA02S01U20200722 date, sort lcolor(gray)) /// 5
(line TotDeaMeSmA02S01U20200730 date, sort lcolor(gray)) /// 6
(line TotDeaMeSmA02S01U20200806 date, sort lcolor(gray)) /// 7
(line TotDeaMeSmA02S01U20200821 date, sort lcolor(gray)) /// 8
(line TotDeaMeSmA02S01U20200827 date, sort lcolor(gray)) /// 9
(line TotDeaMeSmA02S01U20200903 date, sort lcolor(gray)) /// 10
(line TotDeaMeSmA02S01U20200911 date, sort lcolor(gray)) /// 11
(line TotDeaMeSmA02S01U20200918 date, sort lcolor(gray)) /// 12
(line TotDeaMeSmA02S01U20200924 date, sort lcolor(gray)) /// 13
(line TotDeaMeSmA02S01U20201002 date, sort lcolor(gray)) /// 14
(line TotDeaMeSmA02S01U20201009 date, sort lcolor(gray)) /// 15
(line TotDeaMeSmA02S01U20201015 date, sort lcolor(gray)) /// 16
(line TotDeaMeSmA02S01U20201022 date, sort lcolor(gray)) /// 17
(line TotDeaMeSmA02S01U20201029 date, sort lcolor(gray)) /// 18
(line TotDeaMeSmA02S01U20201112 date, sort lcolor(gray)) /// 19
(line TotDeaMeSmA02S01U20201119 date, sort lcolor(gray)) /// 20
(line TotDeaMeSmA02S01U20201203 date, sort lcolor(gray)) /// 21
(line TotDeaMeSmA02S01U20201210 date, sort lcolor(gray)) /// 22
(line TotDeaMeSmA02S01U20201217 date, sort lcolor(gray)) /// 23
(line TotDeaMeSmA02S01U20201223 date, sort lcolor(gray)) /// 24
(line TotDeaMeSmA02S01U20210115 date, sort lcolor(gray)) /// 25
(line TotDeaMeSmA02S01U20210122 date, sort lcolor(gray)) /// 26
(line TotDeaMeSmA02S01U20210128 date, sort lcolor(gray)) /// 27
(line TotDeaMeSmA02S01U20210204 date, sort lcolor(gray)) /// 28
(line TotDeaMeSmA02S01U20210212 date, sort lcolor(gray)) /// 29
(line TotDeaMeSmA02S01U20210220 date, sort lcolor(gray)) /// 30
(line TotDeaMeSmA02S01U20210225 date, sort lcolor(gray)) /// 31
(line TotDeaMeSmA02S01U20210306 date, sort lcolor(gray)) /// 32
(line TotDeaMeSmA02S01U20210311 date, sort lcolor(gray)) /// 33
(line TotDeaMeSmA02S01U20210317 date, sort lcolor(gray)) /// 34
(line TotDeaMeSmA02S01U20210325 date, sort lcolor(gray)) /// 35
(line TotDeaMeSmA02S01U20210401 date, sort lcolor(gray)) /// 36
(line TotDeaMeSmA02S01U20210409 date, sort lcolor(gray)) /// 37
(line TotDeaMeSmA02S01U20210416 date, sort lcolor(gray)) /// 38
(line TotDeaMeSmA02S01U20210423 date, sort lcolor(gray)) /// 39 v3
(line TotDeaMeSmA02S01U20210506 date, sort lcolor(red)) /// 40 v4
(line TotDeaMeSmA02S01U20210514 date, sort lcolor(red)) /// 41
(line TotDeaMeSmA02S01U20210521 date, sort lcolor(red)) /// 42
(line TotDeaMeSmA02S01U20210528 date, sort lcolor(red)) /// 43
(line TotDeaMeSmA02S01U20210604 date, sort lcolor(red)) /// 44
(line TotDeaMeSmA02S01U20210610 date, sort lcolor(red)) /// 45
(line TotDeaMeSmA02S01U20210618 date, sort lcolor(red)) /// 46
(line TotDeaMeSmA02S01U20210625 date, sort lcolor(red)) /// 47
(line TotDeaMeSmA02S01U20210702 date, sort lcolor(red)) /// 48
(line TotDeaMeSmA02S01U20210715 date, sort lcolor(red)) /// 49
(line TotDeaMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 50
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200625 to 20210715; reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(39 "IHME v3" 40 "IHME v4" 50 "JOHN") size(small) rows(1))	yscale(titlegap(2))
  	   
qui graph save "graph 31a COVID-19 total deaths, $country, IHME.gph", replace
qui graph export "graph 31a COVID-19 total deaths, $country, IHME.pdf", replace





*********

* total deaths, Difference, together

twoway  ///
(line TotDeaMeRaA02S01U20200625D date, sort lcolor(gray)) /// 1
(line TotDeaMeRaA02S01U20200629D date, sort lcolor(gray)) /// 2
(line TotDeaMeRaA02S01U20200707D date, sort lcolor(gray)) /// 3
(line TotDeaMeRaA02S01U20200714D date, sort lcolor(gray)) /// 4
(line TotDeaMeRaA02S01U20200722D date, sort lcolor(gray)) /// 5
(line TotDeaMeRaA02S01U20200730D date, sort lcolor(gray)) /// 6
(line TotDeaMeRaA02S01U20200806D date, sort lcolor(gray)) /// 7
(line TotDeaMeRaA02S01U20200821D date, sort lcolor(gray)) /// 8
(line TotDeaMeRaA02S01U20200827D date, sort lcolor(gray)) /// 9
(line TotDeaMeRaA02S01U20200903D date, sort lcolor(gray)) /// 10
(line TotDeaMeRaA02S01U20200911D date, sort lcolor(gray)) /// 11
(line TotDeaMeRaA02S01U20200918D date, sort lcolor(gray)) /// 12
(line TotDeaMeRaA02S01U20200924D date, sort lcolor(gray)) /// 13
(line TotDeaMeRaA02S01U20201002D date, sort lcolor(gray)) /// 14
(line TotDeaMeRaA02S01U20201009D date, sort lcolor(gray)) /// 15
(line TotDeaMeRaA02S01U20201015D date, sort lcolor(gray)) /// 16
(line TotDeaMeRaA02S01U20201022D date, sort lcolor(gray)) /// 17
(line TotDeaMeRaA02S01U20201029D date, sort lcolor(gray)) /// 18
(line TotDeaMeRaA02S01U20201112D date, sort lcolor(gray)) /// 19
(line TotDeaMeRaA02S01U20201119D date, sort lcolor(gray)) /// 20
(line TotDeaMeRaA02S01U20201203D date, sort lcolor(gray)) /// 21
(line TotDeaMeRaA02S01U20201210D date, sort lcolor(gray)) /// 22
(line TotDeaMeRaA02S01U20201217D date, sort lcolor(gray)) /// 23
(line TotDeaMeRaA02S01U20201223D date, sort lcolor(gray)) /// 24
(line TotDeaMeRaA02S01U20210115D date, sort lcolor(gray)) /// 25
(line TotDeaMeRaA02S01U20210122D date, sort lcolor(gray)) /// 26
(line TotDeaMeRaA02S01U20210128D date, sort lcolor(gray)) /// 27
(line TotDeaMeRaA02S01U20210204D date, sort lcolor(gray)) /// 28
(line TotDeaMeRaA02S01U20210212D date, sort lcolor(gray)) /// 29
(line TotDeaMeRaA02S01U20210220D date, sort lcolor(gray)) /// 30
(line TotDeaMeRaA02S01U20210225D date, sort lcolor(gray)) /// 31
(line TotDeaMeRaA02S01U20210306D date, sort lcolor(gray)) /// 32
(line TotDeaMeRaA02S01U20210311D date, sort lcolor(gray)) /// 33
(line TotDeaMeRaA02S01U20210317D date, sort lcolor(gray)) /// 34
(line TotDeaMeRaA02S01U20210325D date, sort lcolor(gray)) /// 35
(line TotDeaMeRaA02S01U20210401D date, sort lcolor(gray)) /// 36
(line TotDeaMeRaA02S01U20210409D date, sort lcolor(gray)) /// 37
(line TotDeaMeRaA02S01U20210416D date, sort lcolor(gray)) /// 38
(line TotDeaMeRaA02S01U20210423D date, sort lcolor(gray)) /// 39 v3
(line TotDeaMeRaA02S01U20210506D date, sort lcolor(red)) /// 40 v4
(line TotDeaMeRaA02S01U20210514D date, sort lcolor(red)) /// 41
(line TotDeaMeRaA02S01U20210521D date, sort lcolor(red)) /// 42
(line TotDeaMeRaA02S01U20210528D date, sort lcolor(red)) /// 43
(line TotDeaMeRaA02S01U20210604D date, sort lcolor(red)) /// 44
(line TotDeaMeRaA02S01U20210610D date, sort lcolor(red)) /// 45
(line TotDeaMeRaA02S01U20210618D date, sort lcolor(red)) /// 46
(line TotDeaMeRaA02S01U20210625D date, sort lcolor(red)) /// 47
(line TotDeaMeRaA02S01U20210702D date, sort lcolor(red)) /// 48
(line TotDeaMeRaA02S01U20210715D date, sort lcolor(red)) /// 49
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths IHME minus JOHN) title("COVID-19 total deaths, $country, IHME minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200625 to 20210715; reference scenario" ///
"IHME minus JOHN smooth for model v3, IHME minus 2.4 times JOHN smooth for model v4", size(small)) ///
legend(order(39 "IHME v3" 40 "IHME v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 32a COVID-19 total deaths, $country, IHME, Difference.gph", replace
qui graph export "graph 32a COVID-19 total deaths, $country, IHME, Difference.pdf", replace







*


*********

* total deaths, Times, together

twoway  ///
(line TotDeaMeRaA02S01U20200625T date, sort lcolor(gray)) /// 1
(line TotDeaMeRaA02S01U20200629T date, sort lcolor(gray)) /// 2
(line TotDeaMeRaA02S01U20200707T date, sort lcolor(gray)) /// 3
(line TotDeaMeRaA02S01U20200714T date, sort lcolor(gray)) /// 4
(line TotDeaMeRaA02S01U20200722T date, sort lcolor(gray)) /// 5
(line TotDeaMeRaA02S01U20200730T date, sort lcolor(gray)) /// 6
(line TotDeaMeRaA02S01U20200806T date, sort lcolor(gray)) /// 7
(line TotDeaMeRaA02S01U20200821T date, sort lcolor(gray)) /// 8
(line TotDeaMeRaA02S01U20200827T date, sort lcolor(gray)) /// 9
(line TotDeaMeRaA02S01U20200903T date, sort lcolor(gray)) /// 10
(line TotDeaMeRaA02S01U20200911T date, sort lcolor(gray)) /// 11
(line TotDeaMeRaA02S01U20200918T date, sort lcolor(gray)) /// 12
(line TotDeaMeRaA02S01U20200924T date, sort lcolor(gray)) /// 13
(line TotDeaMeRaA02S01U20201002T date, sort lcolor(gray)) /// 14
(line TotDeaMeRaA02S01U20201009T date, sort lcolor(gray)) /// 15
(line TotDeaMeRaA02S01U20201015T date, sort lcolor(gray)) /// 16
(line TotDeaMeRaA02S01U20201022T date, sort lcolor(gray)) /// 17
(line TotDeaMeRaA02S01U20201029T date, sort lcolor(gray)) /// 18
(line TotDeaMeRaA02S01U20201112T date, sort lcolor(gray)) /// 19
(line TotDeaMeRaA02S01U20201119T date, sort lcolor(gray)) /// 20
(line TotDeaMeRaA02S01U20201203T date, sort lcolor(gray)) /// 21
(line TotDeaMeRaA02S01U20201210T date, sort lcolor(gray)) /// 22
(line TotDeaMeRaA02S01U20201217T date, sort lcolor(gray)) /// 23
(line TotDeaMeRaA02S01U20201223T date, sort lcolor(gray)) /// 24
(line TotDeaMeRaA02S01U20210115T date, sort lcolor(gray)) /// 25
(line TotDeaMeRaA02S01U20210122T date, sort lcolor(gray)) /// 26
(line TotDeaMeRaA02S01U20210128T date, sort lcolor(gray)) /// 27
(line TotDeaMeRaA02S01U20210204T date, sort lcolor(gray)) /// 28
(line TotDeaMeRaA02S01U20210212T date, sort lcolor(gray)) /// 29
(line TotDeaMeRaA02S01U20210220T date, sort lcolor(gray)) /// 30
(line TotDeaMeRaA02S01U20210225T date, sort lcolor(gray)) /// 31
(line TotDeaMeRaA02S01U20210306T date, sort lcolor(gray)) /// 32
(line TotDeaMeRaA02S01U20210311T date, sort lcolor(gray)) /// 33
(line TotDeaMeRaA02S01U20210317T date, sort lcolor(gray)) /// 34
(line TotDeaMeRaA02S01U20210325T date, sort lcolor(gray)) /// 35
(line TotDeaMeRaA02S01U20210401T date, sort lcolor(gray)) /// 36
(line TotDeaMeRaA02S01U20210409T date, sort lcolor(gray)) /// 37
(line TotDeaMeRaA02S01U20210416T date, sort lcolor(gray)) /// 38
(line TotDeaMeRaA02S01U20210423T date, sort lcolor(gray)) /// 39 v3
(line TotDeaMeRaA02S01U20210506T date, sort lcolor(red)) /// 40 v4
(line TotDeaMeRaA02S01U20210514T date, sort lcolor(red)) /// 41
(line TotDeaMeRaA02S01U20210521T date, sort lcolor(red)) /// 42
(line TotDeaMeRaA02S01U20210528T date, sort lcolor(red)) /// 43
(line TotDeaMeRaA02S01U20210604T date, sort lcolor(red)) /// 44
(line TotDeaMeRaA02S01U20210610T date, sort lcolor(red)) /// 45
(line TotDeaMeRaA02S01U20210618T date, sort lcolor(red)) /// 46
(line TotDeaMeRaA02S01U20210625T date, sort lcolor(red)) /// 47
(line TotDeaMeRaA02S01U20210702T date, sort lcolor(red)) /// 48
(line TotDeaMeRaA02S01U20210715T date, sort lcolor(red)) /// 49
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths IHME divided by JOHN) title("COVID-19 total deaths, $country, IHME divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200625 to 20210715; reference scenario", size(small)) ///
legend(order(39 "IHME v3" 40 "IHME v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 33a COVID-19 total deaths, $country, IHME, Times.gph", replace
qui graph export "graph 33a COVID-19 total deaths, $country, IHME, Times.pdf", replace





*********

* total deaths, Percent, together

twoway  ///
(line TotDeaMeRaA02S01U20200625P date, sort lcolor(gray)) /// 1
(line TotDeaMeRaA02S01U20200629P date, sort lcolor(gray)) /// 2
(line TotDeaMeRaA02S01U20200707P date, sort lcolor(gray)) /// 3
(line TotDeaMeRaA02S01U20200714P date, sort lcolor(gray)) /// 4
(line TotDeaMeRaA02S01U20200722P date, sort lcolor(gray)) /// 5
(line TotDeaMeRaA02S01U20200730P date, sort lcolor(gray)) /// 6
(line TotDeaMeRaA02S01U20200806P date, sort lcolor(gray)) /// 7
(line TotDeaMeRaA02S01U20200821P date, sort lcolor(gray)) /// 8
(line TotDeaMeRaA02S01U20200827P date, sort lcolor(gray)) /// 9
(line TotDeaMeRaA02S01U20200903P date, sort lcolor(gray)) /// 10
(line TotDeaMeRaA02S01U20200911P date, sort lcolor(gray)) /// 11
(line TotDeaMeRaA02S01U20200918P date, sort lcolor(gray)) /// 12
(line TotDeaMeRaA02S01U20200924P date, sort lcolor(gray)) /// 13
(line TotDeaMeRaA02S01U20201002P date, sort lcolor(gray)) /// 14
(line TotDeaMeRaA02S01U20201009P date, sort lcolor(gray)) /// 15
(line TotDeaMeRaA02S01U20201015P date, sort lcolor(gray)) /// 16
(line TotDeaMeRaA02S01U20201022P date, sort lcolor(gray)) /// 17
(line TotDeaMeRaA02S01U20201029P date, sort lcolor(gray)) /// 18
(line TotDeaMeRaA02S01U20201112P date, sort lcolor(gray)) /// 19
(line TotDeaMeRaA02S01U20201119P date, sort lcolor(gray)) /// 20
(line TotDeaMeRaA02S01U20201203P date, sort lcolor(gray)) /// 21
(line TotDeaMeRaA02S01U20201210P date, sort lcolor(gray)) /// 22
(line TotDeaMeRaA02S01U20201217P date, sort lcolor(gray)) /// 23
(line TotDeaMeRaA02S01U20201223P date, sort lcolor(gray)) /// 24
(line TotDeaMeRaA02S01U20210115P date, sort lcolor(gray)) /// 25
(line TotDeaMeRaA02S01U20210122P date, sort lcolor(gray)) /// 26
(line TotDeaMeRaA02S01U20210128P date, sort lcolor(gray)) /// 27
(line TotDeaMeRaA02S01U20210204P date, sort lcolor(gray)) /// 28
(line TotDeaMeRaA02S01U20210212P date, sort lcolor(gray)) /// 29
(line TotDeaMeRaA02S01U20210220P date, sort lcolor(gray)) /// 30
(line TotDeaMeRaA02S01U20210225P date, sort lcolor(gray)) /// 31
(line TotDeaMeRaA02S01U20210306P date, sort lcolor(gray)) /// 32
(line TotDeaMeRaA02S01U20210311P date, sort lcolor(gray)) /// 33
(line TotDeaMeRaA02S01U20210317P date, sort lcolor(gray)) /// 34
(line TotDeaMeRaA02S01U20210325P date, sort lcolor(gray)) /// 35
(line TotDeaMeRaA02S01U20210401P date, sort lcolor(gray)) /// 36
(line TotDeaMeRaA02S01U20210409P date, sort lcolor(gray)) /// 37
(line TotDeaMeRaA02S01U20210416P date, sort lcolor(gray)) /// 38
(line TotDeaMeRaA02S01U20210423P date, sort lcolor(gray)) /// 39 v3
(line TotDeaMeRaA02S01U20210506P date, sort lcolor(red)) /// 40 v4
(line TotDeaMeRaA02S01U20210514P date, sort lcolor(red)) /// 41
(line TotDeaMeRaA02S01U20210521P date, sort lcolor(red)) /// 42
(line TotDeaMeRaA02S01U20210528P date, sort lcolor(red)) /// 43
(line TotDeaMeRaA02S01U20210604P date, sort lcolor(red)) /// 44
(line TotDeaMeRaA02S01U20210610P date, sort lcolor(red)) /// 45
(line TotDeaMeRaA02S01U20210618P date, sort lcolor(red)) /// 46
(line TotDeaMeRaA02S01U20210625P date, sort lcolor(red)) /// 47
(line TotDeaMeRaA02S01U20210702P date, sort lcolor(red)) /// 48
(line TotDeaMeRaA02S01U20210715P date, sort lcolor(red)) /// 49
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths IHME percent JOHN) title("COVID-19 total deaths, $country, % (IHME minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200625 to 20210715; reference scenario", size(small)) ///
legend(order(39 "IHME v3" 40 "IHME v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 34a COVID-19 total deaths, $country, IHME, Percent.gph", replace
qui graph export "graph 34a COVID-19 total deaths, $country, IHME, Percent.pdf", replace












* total infections

**************************************




* total infections, Absolute value, individual updates


foreach l of global IHMEupdatelistwithINF { 

twoway  /// 
(line TotCasMeRaA00S00 date, lcolor(cyan*1.2)) ///  
(line TotINFMeRaA02S01U`l' date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total infections) title("COVID-19 total infections, $country, IHME, update `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases smooth" 2 "IHME infections `l'") size(small) rows(1))	

qui graph save "graph 41i COVID-19 total infections, $country, IHME update `l'.gph", replace
qui graph export "graph 41i COVID-19 total infections, $country, IHME update `l'.pdf", replace

}
*





* total infections, Absolute value, together

twoway  ///
(line TotINFMeRaA02S01U20201009 date, sort lcolor(gray)) /// 15 - 14
(line TotINFMeRaA02S01U20201015 date, sort lcolor(gray)) /// 16
(line TotINFMeRaA02S01U20201022 date, sort lcolor(gray)) /// 17
(line TotINFMeRaA02S01U20201029 date, sort lcolor(gray)) /// 18
(line TotINFMeRaA02S01U20201112 date, sort lcolor(gray)) /// 19
(line TotINFMeRaA02S01U20201119 date, sort lcolor(gray)) /// 20
(line TotINFMeRaA02S01U20201203 date, sort lcolor(gray)) /// 21
(line TotINFMeRaA02S01U20201210 date, sort lcolor(gray)) /// 22
(line TotINFMeRaA02S01U20201217 date, sort lcolor(gray)) /// 23
(line TotINFMeRaA02S01U20201223 date, sort lcolor(gray)) /// 24
(line TotINFMeRaA02S01U20210115 date, sort lcolor(gray)) /// 25
(line TotINFMeRaA02S01U20210122 date, sort lcolor(gray)) /// 26
(line TotINFMeRaA02S01U20210128 date, sort lcolor(gray)) /// 27
(line TotINFMeRaA02S01U20210204 date, sort lcolor(gray)) /// 28
(line TotINFMeRaA02S01U20210212 date, sort lcolor(gray)) /// 29
(line TotINFMeRaA02S01U20210220 date, sort lcolor(gray)) /// 30
(line TotINFMeRaA02S01U20210225 date, sort lcolor(gray)) /// 31
(line TotINFMeRaA02S01U20210306 date, sort lcolor(gray)) /// 32
(line TotINFMeRaA02S01U20210311 date, sort lcolor(gray)) /// 33
(line TotINFMeRaA02S01U20210317 date, sort lcolor(gray)) /// 34
(line TotINFMeRaA02S01U20210325 date, sort lcolor(gray)) /// 35
(line TotINFMeRaA02S01U20210401 date, sort lcolor(gray)) /// 36
(line TotINFMeRaA02S01U20210409 date, sort lcolor(gray)) /// 37
(line TotINFMeRaA02S01U20210416 date, sort lcolor(gray)) /// 38
(line TotINFMeRaA02S01U20210423 date, sort lcolor(gray)) /// 39 v3 25
(line TotINFMeRaA02S01U20210506 date, sort lcolor(red)) /// 40 v4 26
(line TotINFMeRaA02S01U20210514 date, sort lcolor(red)) /// 
(line TotINFMeRaA02S01U20210521 date, sort lcolor(red)) /// 
(line TotINFMeRaA02S01U20210528 date, sort lcolor(red)) /// 
(line TotINFMeRaA02S01U20210604 date, sort lcolor(red)) /// 20
(line TotINFMeRaA02S01U20210610 date, sort lcolor(red)) /// 
(line TotINFMeRaA02S01U20210618 date, sort lcolor(red)) /// 
(line TotINFMeRaA02S01U20210625 date, sort lcolor(red)) /// 
(line TotINFMeRaA02S01U20210702 date, sort lcolor(red)) /// 
(line TotINFMeRaA02S01U20210715 date, sort lcolor(red)) /// 35
(line TotCasMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 36	   
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(total infections) title("COVID-19 total infections, $country, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200625 to 20210715; total infections starting on 20201009; reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(25 "IHME v3" 26 "IHME v4" 36 "JOHN cases") size(small) rows(1))	yscale(titlegap(2))
  	   
qui graph save "graph 41a COVID-19 total infections, $country, IHME.gph", replace
qui graph export "graph 41a COVID-19 total infections, $country, IHME.pdf", replace














view "log country IHME merge.smcl"

log close

exit, clear



