
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



* continue preparation of estimates files, merge them, and graphs: updates together 
* input data files: "country SRIV `update'.dta" and "country JOHN.dta"
* output data files: "country SRIV longit.dta"





use "country SRIV 20220101.dta", clear  


local list ///
20220101 /// 
20220102 /// 
20220103 /// 
20220104 /// 
20220105 /// 
20220106 /// 
20220108 /// 
20220109 /// 
20220110 /// 
20220111 /// 
20220112 /// 
20220113 /// 
20220115 /// 
20220116 /// 
20220117 /// 
20220118 /// 
20220119 /// 
20220120 /// 
20220122 /// 
20220123 /// 
20220124 /// 
20220125 /// 
20220126 /// 
20220127 /// 
20220129 /// 
20220130 /// 
20220204 /// 
20220205 /// 
20220206 /// 
20220207 /// 
20220208 /// 
20220209 /// 
20220210 /// 
20220211 /// 
20220212 /// 
20220213 /// 
20220214 /// 
20220215 /// 
20220216 /// 
20220217 /// 
20220218 /// 
20220219 /// 
20220220 /// 
20220221 /// 
20220222 /// 
20220223 /// 
20220224 /// 
20220225 /// 
20220226 /// 
20220227 /// 
20220228 /// 
20220301 /// 
20220305 /// 
20220306 /// 
20220307 /// 
20220308 /// 
20220309 /// 
20220310 /// 
20220311 /// 
20220312 /// 
20220313 /// 
20220314 /// 
20220315 /// 
20220316 /// 
20220317 /// 
20220318 /// 
20220319 /// 
20220320 /// 
20220321 /// 
20220322 /// 
20220323 /// 
20220324 /// 
20220325 /// 
20220326 /// 
20220327 /// 
20220328 /// 
20220329 /// 
20220330 /// 
20220331 /// 
20220401 /// 
20220402 /// 
20220403 /// 
20220404 /// 
20220405 /// 
20220406 /// 
20220407 /// 
20220408 /// 
20220409 /// 
20220410 /// 
20220411 /// 
20220413 /// 
20220417 /// 
20220418 /// 
20220419 /// 
20220420 /// 
20220421 /// 
20220422 /// 
20220423 /// 
20220424 /// 
20220425 /// 
20220426 /// 
20220427 /// 
20220428 /// 
20220429 /// 
20220430 /// 
20220501 /// 
20220502 /// 
20220508 /// 
20220515 /// 
20220516 /// 
20220517 /// 
20220518 /// 
20220519 /// 
20220520 /// 
20220521 /// 
20220522 /// 
20220602 /// 
20220603 /// 
20220605 /// 
20220606 /// 
20220607 /// 
20220608 /// 
20220609 /// 
20220610 /// 
20220611 /// 
20220612 /// 
20220614 /// 
20220615 /// 
20220617 /// 
20220618 /// 
20220619 /// 
20220620 /// 
20220621 /// 
20220622 /// 
20220623 /// 
20220624 /// 
20220625 /// 
20220626 /// 
20220627 /// 
20220628 /// 
20220629 /// 
20220630 /// 
20220701 /// 
20220702 /// 
20220703 /// 
20220704 /// 
20220705 /// 
20220706 /// 
20220707 /// 
20220708 





**********

* merge updates
	
foreach update of local list {
		
	merge m:m date loc_grand_name using "country SRIV `update'.dta", force
		
	drop _merge
	
*	

duplicates drop

order loc_grand_name date 

drop update	update_date

qui compress

save "country SRIV longit.dta", replace

}
*






* add JOHN

cd ..

cd JOHN

use "country JOHN.dta", clear 

cd ..

cd SRIV

save "country JOHN.dta", replace 


merge m:m date loc_grand_name using "country SRIV longit.dta"

drop _merge

drop DayDeaMeRa*


qui compress

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
(line DayDeaFOREA0520220708 date, sort lcolor(black) lwidth(thick)) ///
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// "JOHN smooth"
if date >= td(01jan2022) ///
, xtitle(Date) xlabel(#11, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, SRIV, updates in 2022", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(151 "JOHN" 1 "SRIV previous updates" 150 "SRIV latest update 20220708") size(small) row(2)) ///
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
(line DayDeaFOREA0520220708 date, sort lcolor(black) lwidth(thick)) ///
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// "JOHN smooth"
if date >= td(01jan2022) ///
, xtitle(Date) xlabel(#11, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, SRIV, updates in 2022", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(128 "JOHN" 1 "SRIV previous updates" 127 "SRIV latest update 20220708") size(small) row(2)) ///
subtitle("Forecasts only; smooth; without extremes", size(small)) 

qui graph export "graph 2 $country C19 daily deaths, SRIV, Updates together Without extremes.pdf", replace






				
view "log country SRIV 2.smcl"

log close

exit, clear




