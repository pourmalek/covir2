
clear all

cd "$pathcovir2"

cd SRIV

capture log close 

log using "log country SRIV 2.smcl", replace

***************************************************************************
* This is "do country SRIV 2.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek
***************************************************************************



* download updates after uptake 20220708 + graphs
* input data files: "country SRIV longit 20220708.dta"
* output data files: "country SRIV longit.dta"



**********************************************
* download updates after uptake 20220708


local list `" 2022-07-08 "2022-07-09" "2022-07-10" "2022-07-11" "2022-07-12" "2022-07-13" "2022-07-14" "2022-07-15" "'

foreach update of local list {	

	di in red ">>>>> This is update " "`update'"
	
	* transfrom update (2022-01-01) to updatestring (20220101)
	
	capture drop updatestring
	gen updatestring = "`update'"
	
	gen year = substr(updatestring,1,4) 
	gen month = substr(updatestring,6,2) 
	gen day = substr(updatestring,9,2) 
	capture drop updatestring2
	egen updatestring2 = concat(year month day)
	
	drop updatestring
	rename updatestring2 updatestring
	local updatestring = updatestring
	
	
	* download "global_forecasts_deaths.csv" for new updates
	
	copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/`update'/global_forecasts_deaths.csv global_forecasts_deaths.csv 
			
	import delimited "global_forecasts_deaths.csv", clear varnames(1) 
	
			keep if regexm(country,"$country") == 1
		
	qui destring *, replace
	
	* destring for Total Deaths that contain NaN instead of numbers
	
	qui {
		foreach v of var * {
			capture replace `v' = "" if `v' == "NaN"
		}
			*
		destring *, replace
	}	
	
	drop id
	
	* use varlables for varnames
	
	foreach v of var v* {
		local lbl : var label `v'
		local lbl = strtoname("`lbl'")
		rename `v' `lbl'					
	}		
*
 
	rename (_*) (v_*)
	
	* reshape long
		
	gen i = _n
	qui reshape long v, i(i) j(j, string)
	rename v TotDeaMeRaA05
	rename j date_original
	drop i
	
	* gen date
	
	gen year = substr(date_original,2,4) 
	gen month = substr(date_original,7,2) 
	gen day = substr(date_original,10,2) 
	egen date2 = concat(day month year)
	gen date = date(date2, "DMY", 2050)
	format date %tdDDMonCCYY
	codebook date
	drop year month day date2 date_original

	* add update date to the end of Total Deaths

	rename TotDeaMeRaA05 TotDeaMeRaA05`updatestring'
	
	* gen update date for this update
	
	gen update = "`updatestring'"
	gen update_date = date(update, "YMD")
	format update_date %tdDDMonCCYY
	codebook update_date
	
	destring update, replace
	local update = update
	
	
	
	
	* gen daily deaths
	
	sort date 
		    
	gen DayDeaMeRaA05`update' =  TotDeaMeRaA05`update'[_n] - TotDeaMeRaA05`update'[_n-1]
	
	drop TotDeaMeRaA05`update'
	
	
	
	* smooth
	
	tsset date, daily   
	
	qui {
		tssmooth ma DayDeaMeRaA05`update'_window = DayDeaMeRaA05`update' if DayDeaMeRaA05`update' >= 0, window(3 1 3) 
		
		tssmooth ma DayDeaMeSmA05`update' = DayDeaMeRaA05`update'_window, weights( 1 2 3 <4> 3 2 1) replace
		
		label var DayDeaMeSmA05`update' "Daily deaths smooth mean SRIV"
		
		drop DayDeaMeRaA05`update'_window DayDeaMeRaA05`update'
		
	}	
	*	
	
	
	
	local update_date = update_date
		
		
	* gen FORE, that is forecast only 
		
	gen DayDeaFOREA05`update' = DayDeaMeSmA05`update'
	
	label var DayDeaFOREA05`update' "Daily deaths smooth mean forecast only SRIV"
	
	di ">>>>> update_date is " `update_date'
	
	replace DayDeaFOREA05`update' = . if date < `update_date'
	
	rename country loc_grand_name	
		
	qui compress
	
	save "country SRIV `updatestring'.dta", replace

	 
	shell rm -r "global_forecasts_deaths.csv" 

}
*





*****************************

* merge the new updates


use "country SRIV 20220709.dta", clear  


local list ///
20220709 /// 
20220710 /// 
20220711 /// 
20220712 /// 
20220713 /// 
20220714 ///
20220715

foreach update of local list {
		
	merge m:m date loc_grand_name using "country SRIV `update'.dta", force
		
	drop _merge
	
*	

duplicates drop

order loc_grand_name date 

drop update	update_date

qui compress

save "country SRIV longit 20220715.dta", replace

}
*






**********************************************
* merge "country SRIV longit 20220708.dta" with downloadED updates after uptake 20220708

use "country SRIV longit 20220708.dta", clear

	merge m:m date loc_grand_name using "country SRIV longit 20220715.dta"
	
	drop _merge


save "country SRIV longit.dta", replace



**********************

* graphs

grstyle init

grstyle color background white




***********************************************

* Daily deaths, country, Updates together, With extremes

twoway ///
(line DayDeaFOREA0520220101 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220102 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220103 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220104 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220105 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220106 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220108 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220109 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220110 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220111 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220112 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220113 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220115 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220116 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220117 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220118 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220119 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220120 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220122 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220123 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220124 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220125 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220126 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220127 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220129 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220130 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220204 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220205 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220206 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220207 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220208 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220209 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220210 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220211 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220212 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220213 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220214 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220215 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220216 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220217 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220218 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220219 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220220 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220221 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220222 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220223 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220224 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220225 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220226 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220227 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220228 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220301 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220305 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220306 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220307 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220308 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220309 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220310 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220311 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220312 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220313 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220314 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220315 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220316 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220317 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220318 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220319 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220320 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220321 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220322 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220323 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220324 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220325 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220326 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220327 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220328 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220329 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220330 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220331 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220401 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220402 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220403 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220404 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220405 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220406 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220407 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220408 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220409 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220410 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220411 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220413 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220417 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220418 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220419 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220420 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220421 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220422 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220423 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220424 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220425 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220426 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220427 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220428 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220429 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220430 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220501 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220502 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220508 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220515 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220516 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220517 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220518 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220519 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220520 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220521 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220522 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220602 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220603 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220605 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220606 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220607 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220608 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220609 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220610 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220611 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220612 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220614 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220615 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220617 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220618 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220619 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220620 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220621 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220622 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220623 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220624 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220625 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220626 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220627 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220628 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220629 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220630 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220701 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220702 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220703 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220704 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220705 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220706 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220707 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220708 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220709 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220710 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220711 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220712 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220713 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220714 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220715 date, sort lcolor(black) lwidth(thick)) ///
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// "JOHN smooth"
if date >= td(01jan2022) ///
, xtitle(Date) xlabel(#11, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, SRIV, updates in 2022", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(158 "JOHN" 1 "SRIV previous updates" 157 "SRIV latest update 20220715") size(small) row(2)) ///
subtitle("Forecasts only; smooth; with extremes", size(small)) 

qui graph export "graph 1 $country C19 daily deaths, SRIV, Updates together With extremes.pdf", replace






***********************************************

* Daily deaths, country, Updates together, Without extremes


* all-time max DayDeaMeSmA00 = 640. 640 * 5 = 3200. DayDeaFOREA05 > 3200 = extreme.

/*
20220119
20220120
20220122
20220123
20220124
20220125
20220126
20220129
20220130
20220204
20220205
20220206
20220207
20220208
20220209
20220211
20220212
20220213
20220327
20220406
20220407
20220408

20220714
*/

twoway ///
(line DayDeaFOREA0520220101 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220102 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220103 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220104 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220105 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220106 date, sort lcolor(green) lwidth(thin)) /// 
(line DayDeaFOREA0520220108 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220109 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220110 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220111 date, sort lcolor(green) lwidth(thin)) /// 
(line DayDeaFOREA0520220112 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220113 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220115 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220116 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220117 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220118 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220127 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220210 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220214 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220215 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220216 date, sort lcolor(green) lwidth(thin)) /// 
(line DayDeaFOREA0520220218 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220219 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220220 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220221 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220222 date, sort lcolor(green) lwidth(thin)) /// 
(line DayDeaFOREA0520220223 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220224 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220225 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220226 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220227 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220228 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220301 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220305 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220306 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220307 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220308 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220309 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220310 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220311 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220312 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220313 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220314 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220315 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220316 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220317 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220318 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220319 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220320 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220321 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220322 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220323 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220324 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220325 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220326 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220328 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220329 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220330 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220331 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220401 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220402 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220403 date, sort lcolor(green) lwidth(thin)) /// 
(line DayDeaFOREA0520220404 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220405 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220409 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220410 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220411 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220413 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220417 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220418 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220419 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220420 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220421 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220422 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220423 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220424 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220425 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220426 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220427 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220428 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220429 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220430 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220501 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220502 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220508 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220515 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220516 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220517 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220518 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220519 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220520 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220521 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220522 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220602 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220603 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220605 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220606 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220607 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220608 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220609 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220610 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220611 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220612 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220614 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220615 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220617 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220618 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220619 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220620 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220621 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220622 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220623 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220624 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220625 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220626 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220627 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220628 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220629 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220630 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220701 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220702 date, sort lcolor(green) lwidth(thin)) /// 
(line DayDeaFOREA0520220703 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220704 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220705 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220706 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220707 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220708 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220709 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220710 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220711 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220712 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220713 date, sort lcolor(green) lwidth(thin)) ///
(line DayDeaFOREA0520220715 date, sort lcolor(black) lwidth(thick)) ///
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// "JOHN smooth"
if date >= td(01jan2022) ///
, xtitle(Date) xlabel(#11, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, SRIV, updates in 2022", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(134 "JOHN" 1 "SRIV previous updates" 133 "SRIV latest update 20220715") size(small) row(2)) ///
subtitle("Forecasts only; smooth; without extremes", size(small)) 

qui graph export "graph 2 $country C19 daily deaths, SRIV, Updates together Without extremes.pdf", replace






				
view "log country SRIV 2.smcl"

log close

exit, clear




