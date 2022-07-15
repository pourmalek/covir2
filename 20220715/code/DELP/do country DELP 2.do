
clear all

cd "$pathcovir2"

cd DELP

capture log close 

log using "log country DELP 2.smcl", replace

***************************************************************************
* This is "do country DELP 2.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek
***************************************************************************


* merge update files
* input data files: "country DELP 202?????.dta " 
* output data files: "country DELP longit.dta"


use "country DELP 20220106.dta", clear  

local list ///
20220106 ///
20220113 ///
20220114 ///
20220115 ///
20220116 ///
20220117 ///
20220118 ///
20220119 ///
20220120 ///
20220121 ///
20220122 ///
20220123 ///
20220124 ///
20220125 ///
20220126 ///
20220127 ///
20220128 ///
20220129 ///
20220130 ///
20220131 ///
20220201 ///
20220202 ///
20220203 ///
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
20220302 ///
20220303 ///
20220304 ///
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
20220412 ///
20220413 ///
20220414 ///
20220415 ///
20220416 ///
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
20220503 ///
20220504 ///
20220505 ///
20220506 ///
20220507 ///
20220508 ///
20220509 ///
20220510 ///
20220511 ///
20220512 ///
20220513 ///
20220514 ///
20220515 ///
20220516 ///
20220517 ///
20220518 ///
20220519 ///
20220520 ///
20220521 ///
20220522 ///
20220523 ///
20220524 ///
20220525 ///
20220526 ///
20220527 ///
20220528 ///
20220529 ///
20220530 ///
20220531 ///
20220601 ///
20220602 ///
20220603 ///
20220604 ///
20220605 ///
20220606 ///
20220607 ///
20220608 ///
20220609 ///
20220610 ///
20220611 ///
20220612 ///
20220613 ///
20220614 ///
20220615 ///
20220616 ///
20220617 ///
20220618
 

 


foreach update of local list {

use "country DELP `update'.dta", clear

capture rename DayDeaMeSmA01S00`update' DayDeaMeSmA01`update'

capture drop update_date

gen update_date = date("`update'", "YMD")
 
capture drop DayDeaFOREA01`update'

gen DayDeaFOREA01`update' = DayDeaMeSmA01`update'

replace DayDeaFOREA01`update' = . if date < update_date

label var DayDeaFOREA01`update' "DayDeaMeSmA01 Forecast only"

save "country DELP `update'.dta", replace

}
* 




foreach update of local list {

	di in red "This is update " `update'
	
	merge m:m date loc_grand_name provincestate using "country DELP `update'.dta"
	
	drop _merge
	
}
*


isid provincestate date, missok

sort loc_grand_name provincestate date

save "country DELP longit.dta", replace




* add JOHN

cd .. // /code/

cd JOHN

use "country JOHN.dta", clear 

cd ..

cd DELP 

gen provincestate = " National"

save "country JOHN.dta", replace

merge m:m date loc_grand_name provincestate using "country DELP longit.dta"
 
drop _merge

duplicates report date, gen duptag


isid provincestate date, missok

sort loc_grand_name provincestate date

qui compress

save "country DELP longit.dta", replace










view "log country DELP 2.smcl"

log close

exit, clear
