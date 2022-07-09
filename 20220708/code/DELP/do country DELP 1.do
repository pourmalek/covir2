
clear all

cd "$pathcovir2"

cd DELP

capture log close 

log using "log country DELP 1.smcl", replace

***************************************************************************
* This is "do country DELP 1.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek 
***************************************************************************


* download and prepare update files
* input data files: download csv files
* output data files: "country DELP 202?????.dta " 




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

di in red "This is update " `update'

clear

copy https://raw.githubusercontent.com/COVIDAnalytics/website/master/data/predicted/Global_V4_since100_`update'.csv Global_V4_since100_`update'.csv

import delimited using "Global_V4_since100_`update'.csv", clear varnames(1)

rename country loc_grand_name

keep if loc_grand_name == "$country"

drop continent

rename province provincestate

replace provincestate = " National" if provincestate == "None"



* gen date

rename day date_original

gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date

drop year month day date2


* rename outcome variables


* total vars

rename totaldetecteddeaths   TotDeaMeRaA01S00

label var TotDeaMeRaA01S00 "Total Deaths Mean DELP S0"



* gen daily vars and rename

sort provincestate date

bysort provincestate (date): gen DayDeaMeRaA01S00 =  TotDeaMeRaA01S00[_n] - TotDeaMeRaA01S00[_n-1]



label var DayDeaMeRaA01S00 "Daily Deaths Mean DELP S0"



keep loc_grand_name provincestate date DayDeaMeRaA01S00   

order loc_grand_name provincestate date DayDeaMeRaA01S00  



* smooth daily deaths 

qui {

encode provincestate, gen(provincestate_encoded)

tsset provincestate_encoded date, daily   


tssmooth ma DayDeaMeRaA01S00_window = DayDeaMeRaA01S00 if DayDeaMeRaA01S00 >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmA01S00 = DayDeaMeRaA01S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA01S00 "Daily deaths mean smooth DELP"



drop *_window

drop provincestate_encoded

tsset, clear

}
*



drop DayDeaMeRaA01S00 


capture drop update_date

gen update_date = date("`update'", "YMD")




* add update to varnames

rename (*) (*`update')

rename (date`update' loc_grand_name`update' provincestate`update') (date loc_grand_name provincestate)



sort date loc_grand_name provincestate 

order date loc_grand_name provincestate 

qui compress

save "country DELP `update'.dta", replace

shell rm -r "Global_V4_since100_`update'.csv"

}
*


view "log country DELP 1.smcl"

log close

exit, clear




