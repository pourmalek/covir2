
clear all

cd "$pathcovir2"

cd ensemble

capture log close

log using "log country ensemble.smcl", replace

	
******************************************************************************
* This is "do country ensemble.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10; Time (initial) for subproject ensemble 21-08-14

* OBJECTIVE: run ensemble model for country
******************************************************************************


                                                                                                         ***************************
* To change update date, find and replace all, 20210813 (old), with 20210813 (new) <<--           <<<--- * change update date here *
                                                                                                         ***************************
cd .. // code

cd .. // 20210813																										 																	 
		
cd output 		

cd merge

use "country.dta", clear 

cd .. // output

cd .. // 20210813			

cd code																							 																	 

cd ensemble

save "country ensemble.dta", replace 


* 



* smooth daily deaths and cases LANL



tsset date, daily   


tssmooth ma DayDeaMeRaA04S00_window = DayDeaMeRaA04S00 if DayDeaMeRaA04S00 >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmA04S00 = DayDeaMeRaA04S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA04S00 "Daily deaths smooth A04 LANL"

drop DayDeaMeRaA04S00_window


tssmooth ma DayCasMeRaA04S00_window = DayCasMeRaA04S00 if DayCasMeRaA04S00 >= 0, window(3 1 3)

tssmooth ma DayCasMeSmA04S00 = DayCasMeRaA04S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasMeSmA04S00 "Daily cases smooth A04 LANL"

drop DayCasMeRaA04S00_window


tsset, clear




**************************************************************
**************************************************************

* daily deaths


* daily deaths, reference scenario, 2021

twoway ///
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN smooth"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDeaMeSmA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("after 2021-01-01, reference scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 12a COVID-19 daily deaths, $country, reference scenarios.gph", replace
graph export "graph 12a COVID-19 daily deaths, $country, reference scenarios.pdf", replace




*************************************************************************

* ensemble unweighted (ENS1) 


gen DayDeaMeRaENS1 = (DayDeaMeRaA01S00 + DayDeaMeSmA02S01 + DayDeaMeRaA03S02 + DayDeaMeSmA04S00 + DayDeaMeRaA05S00) / 5 

label var DayDeaMeRaENS1 "Daily deaths mean ensemble unweighted raw"

gen DayDeaMeRaENS_FOUR = (DayDeaMeRaA01S00 + DayDeaMeSmA02S01 + DayDeaMeRaA03S02 + DayDeaMeRaA05S00) / 4  // DELP IHME IMPE SRIV; for when LANL ends
 
replace DayDeaMeRaENS1 = DayDeaMeRaENS_FOUR if DayDeaMeRaENS1 == . 
 
gen DayDeaMeRaENS_THREE = (DayDeaMeSmA02S01 + DayDeaMeRaA03S02 + DayDeaMeRaA05S00) / 3  // IHME IMPE SRIV; for when DELP ends
 
replace DayDeaMeRaENS1 = DayDeaMeRaENS_THREE if DayDeaMeRaENS1 == . 
 



tsset date, daily   

tssmooth ma DayDeaMeRaENS1_window = DayDeaMeRaENS1 if DayDeaMeRaENS1 >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmENS1 = DayDeaMeRaENS1_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmENS1 "Daily deaths mean ensemble unweighted smooth"

drop DayDeaMeRaENS1_window

tsset, clear



lowess DayDeaMeRaENS1 date, gen(DayDeaMeRaENS1_lowess)




twoway ///
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN smooth"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDeaMeSmA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
(line DayDeaMeRaENS1_lowess date, sort lcolor(black) lwidth(thick)) /// 7 "ensemble unweighted lowess"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(`dates2021', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(#12, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV" 7 "ensemble unweighted lowess") size(small) row(2)) ///
subtitle("after 2021-01-01, reference scenarios; with ensemble unweighted lowess", size(small)) xline(22424, lcolor(red) lwidth(thick)) ///
note("- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))

graph save "graph 12b COVID-19 daily deaths, $country, reference scenarios - ensemble unweighted lowess.gph", replace
graph export "graph 12b COVID-19 daily deaths, $country, reference scenarios - ensemble unweighted lowess.pdf", replace




**************************************************************
**************************************************************

* daily cases 


* daily cases or infections, reference scenario, 2021

twoway ///
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCasMeSmA04S00 date, sort lcolor(gold)) /// 3 "LANL"
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid)  ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases ) title("COVID-19 daily cases, with ensemble unweighted, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "LANL" 4 "SRIV") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick))  ///
note("- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small)) 


graph save "graph 22a COVID-19 daily cases, $country, reference scenarios, all time - ensemble unweighted.gph", replace
graph export "graph 22a COVID-19 daily cases, $country, reference scenarios, all time - ensemble unweighted.pdf", replace





*************************************************************************

* ensemble unweighted (ENS1) based on models DELP LANL SRIV


gen DayCasMeRaENS1 = (DayCasMeRaA01S00 + DayCasMeSmA04S00 + DayCasMeRaA05S00) / 3  // DELP LANL SRIV

label var DayCasMeRaENS1 "Daily cases mean ensemble unweighted raw"

gen DayCasMeRaENS_DELP_SRIV = (DayCasMeRaA01S00 + DayCasMeRaA05S00) / 2  // DELP SRIV; for when LANL ends

replace DayCasMeRaENS1 = DayCasMeRaENS_DELP_SRIV if DayCasMeRaENS1 == . 

gen DayCasMeRaENS_DELP_LANL = (DayCasMeRaA01S00 + DayCasMeSmA04S00) / 2  // DELP LANL; for past

replace DayCasMeRaENS1 = DayCasMeRaENS_DELP_LANL if DayCasMeRaENS1 == . 




twoway ///
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 1 "JOHN"
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCasMeSmA04S00 date, sort lcolor(gold)) /// 3 "LANL"
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
(line DayCasMeRaENS1 date, sort lcolor(black) lwidth(thick)) /// 5 "ensemble unweighted"
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid)  ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases ) title("COVID-19 daily cases, with ensemble unweighted, $country", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "LANL" 4 "SRIV" 5 "ensemble unweighted") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) xline(22424, lcolor(red) lwidth(thick))  ///
note("- Red vertical line: 20210424 online meeting; estimated probability, timing," ///
"dimensions, drivers, preventive measures of fifth wave discussed with MOH.", size(small))  

graph save "graph 22b COVID-19 daily cases, $country, reference scenarios, all time - ensemble unweighted.gph", replace
graph export "graph 22b COVID-19 daily cases, $country, reference scenarios, all time - ensemble unweighted.pdf", replace




*************************************************************************

* ensemble weighted ENS2 



* model start date						end date 

* LANL 	21-01-01						about 1.5 months to future

* DELP	about 3.5 months into past		about 2 months into future

* SRIV  1 day only						3 months into future



*                                            | release date
* LANL ----- . . .---------------------------|----.--           1.5
* DELP                      --.----.----.----|----.----         2
* SRIV                                      .|----.----.----    3



* model start earlier						projects more into future

* LANL	1									3

* DELP	2									2

* SRIV	3									1



ssc install epiweek

epiweek date, epiw(epi_week) epiy(epi_year)

egen wy = concat(epi_year epi_week), p(w)

epiweek2 wy, s(from) e(to)

label var epi_week "epidemiological week USCDC WHO"
label var epi_year "epidemiological year USCDC WHO"
label var wy "epidemiological year and week"
label var from "epidemiological week start date"
label var to "epidemiological week end date"



* DELP

bysort wy: gen DayCasMeRaA01S00_error = 100 * ((DayCasMeSmA00S00 - DayCasMeRaA01S00) / DayCasMeSmA00S00)
label var DayCasMeRaA01S00_error "Daily cases DELP error percent weekly"

bysort wy: gen DayCasMeRaA01S00_abs_err = abs(DayCasMeRaA01S00_error)
label var DayCasMeRaA01S00_abs_err "Daily cases DELP absolute error weekly"

egen DayCasMeRaA01S00_mape = median(DayCasMeRaA01S00_abs_err), by(wy)
label var DayCasMeRaA01S00_mape "Daily cases DELP median absolute percent error weekly"



* LANL

bysort wy: gen DayCasMeSmA04S00_error = 100 * ((DayCasMeSmA00S00 - DayCasMeSmA04S00) / DayCasMeSmA00S00)
label var DayCasMeSmA04S00_error "Daily cases LANL error percent weekly"

bysort wy: gen DayCasMeSmA04S00_abs_err = abs(DayCasMeSmA04S00_error)
label var DayCasMeSmA04S00_abs_err "Daily cases LANL absolute error weekly"

egen DayCasMeSmA04S00_mape = median(DayCasMeSmA04S00_abs_err), by(wy)
label var DayCasMeSmA04S00_mape "Daily cases LANL median absolute percent error weekly"



* SRIV

bysort wy: gen DayCasMeRaA05S00_error = 100 * ((DayCasMeSmA00S00 - DayCasMeRaA05S00) / DayCasMeSmA00S00)
label var DayCasMeRaA05S00_error "Daily cases SRIV error percent weekly"

bysort wy: gen DayCasMeRaA05S00_abs_err = abs(DayCasMeRaA05S00_error)
label var DayCasMeRaA05S00_abs_err "Daily cases SRIV absolute error weekly"

egen DayCasMeRaA05S00_mape = median(DayCasMeRaA05S00_abs_err), by(wy)
label var DayCasMeRaA05S00_mape "Daily cases SRIV median absolute percent error weekly"


















																			 
																										 
view "log country ensemble.smcl"

log close

exit, clear																										 



