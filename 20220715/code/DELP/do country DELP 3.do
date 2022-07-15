
clear all

cd "$pathcovir2"

cd DELP

capture log close 

log using "log country DELP 3.smcl", replace

***************************************************************************
* This is "do country DELP 3.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek
***************************************************************************


* graphs, daily deaths: updates separate 
* input data files: "country DELP longit.dta"
* output data files: none. no change in data.






use "country DELP longit.dta", clear



grstyle init

grstyle color background white



***********************************************

* graph 1 Daily deaths, Updates together, no extremes, backcasts and forecasts

twoway /// 
(line DayDeaMeSmA0120220106 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220113 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220114 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220115 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220116 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220117 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220118 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220119 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220120 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220121 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220122 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220123 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220124 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220125 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220126 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220127 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220128 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220129 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220130 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220131 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220201 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220202 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220203 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220204 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220205 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220206 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220207 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220208 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220209 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220210 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220211 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220212 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220213 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220214 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220215 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220216 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220217 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220218 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220219 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220220 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220221 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220222 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220223 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220224 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220225 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220226 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220227 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220228 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220301 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220302 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220303 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220304 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220305 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220306 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220307 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220308 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220309 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220310 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220311 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220312 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220313 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220314 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220315 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220316 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220317 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220318 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220319 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220320 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220321 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220322 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220323 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220324 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220325 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220326 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220327 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220328 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220329 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220330 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220331 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220401 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220402 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220403 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220404 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220405 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220406 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220407 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220408 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220409 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220410 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220411 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220412 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220413 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220414 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220415 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220416 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220417 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220418 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220419 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220420 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220421 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220422 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220423 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220424 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220425 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220426 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220427 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220428 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220429 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220430 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220501 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220502 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220503 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220504 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220505 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220506 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220507 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220508 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220509 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220510 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220511 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220512 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220513 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220514 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220515 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220516 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220517 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220518 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220519 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220520 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220521 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220522 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220523 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220524 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220525 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220526 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220527 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220528 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220529 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220530 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220531 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220601 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220602 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220603 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220604 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220605 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220606 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220607 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220608 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220609 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220610 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220611 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220612 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220613 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220614 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220615 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220616 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220617 date, sort lcolor(gold) lwidth(medium)) /// 
(line DayDeaMeSmA0120220618 date, sort lcolor(gold) lwidth(medium)) /// 158
(line DayDeaFOREA0120220106 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220113 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220114 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220115 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220116 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220117 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220118 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220119 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220120 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220121 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220122 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220123 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220124 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220125 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220126 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220127 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220128 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220129 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220130 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220131 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220201 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220202 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220203 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220204 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220205 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220206 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220207 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220208 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220209 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220210 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220211 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220212 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220213 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220214 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220215 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220216 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220217 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220218 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220219 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220220 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220221 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220222 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220223 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220224 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220225 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220226 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220227 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220228 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220301 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220302 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220303 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220304 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220305 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220306 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220307 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220308 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220309 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220310 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220311 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220312 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220313 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220314 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220315 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220316 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220317 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220318 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220319 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220320 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220321 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220322 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220323 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220324 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220325 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220326 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220327 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220328 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220329 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220330 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220331 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220401 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220402 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220403 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220404 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220405 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220406 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220407 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220408 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220409 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220410 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220411 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220412 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220413 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220414 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220415 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220416 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220417 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220418 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220419 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220420 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220421 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220422 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220423 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220424 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220425 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220426 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220427 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220428 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220429 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220430 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220501 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220502 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220503 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220504 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220505 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220506 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220507 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220508 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220509 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220510 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220511 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220512 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220513 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220514 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220515 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220516 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220517 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220518 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220519 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220520 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220521 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220522 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220523 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220524 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220525 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220526 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220527 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220528 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220529 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220530 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220531 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220601 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220602 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220603 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220604 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220605 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220606 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220607 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220608 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220609 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220610 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220611 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220612 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220613 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220614 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220615 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220616 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220617 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220618 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// "JOHN smooth"
if date >= td(01jan2022) & provincestate == " National" ///
, xtitle(Date) xlabel(#11, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("C19 daily deaths, $country, DELP, updates in 2022", size(medium) color(black)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(317 "JOHN" 1 "DELP previous updates, backcast" 159 "DELP previous updates, forecast") ///
size(small) row(2)) ///
subtitle("Forecasts and backcasts; smooth; no extremes", size(small)) yscale(titlegap(2))

qui graph export "graph 1 $country C19 daily deaths, DELP, Updates together no extremes.pdf", replace







***********************************************

* graph 1 Daily deaths, Updates together, no extremes, forecasts only

twoway /// 
(line DayDeaFOREA0120220106 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220113 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220114 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220115 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220116 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220117 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220118 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220119 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220120 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220121 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220122 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220123 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220124 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220125 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220126 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220127 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220128 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220129 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220130 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220131 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220201 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220202 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220203 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220204 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220205 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220206 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220207 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220208 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220209 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220210 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220211 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220212 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220213 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220214 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220215 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220216 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220217 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220218 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220219 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220220 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220221 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220222 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220223 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220224 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220225 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220226 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220227 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220228 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220301 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220302 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220303 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220304 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220305 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220306 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220307 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220308 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220309 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220310 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220311 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220312 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220313 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220314 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220315 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220316 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220317 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220318 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220319 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220320 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220321 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220322 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220323 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220324 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220325 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220326 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220327 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220328 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220329 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220330 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220331 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220401 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220402 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220403 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220404 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220405 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220406 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220407 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220408 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220409 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220410 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220411 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220412 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220413 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220414 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220415 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220416 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220417 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220418 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220419 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220420 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220421 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220422 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220423 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220424 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220425 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220426 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220427 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220428 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220429 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220430 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220501 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220502 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220503 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220504 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220505 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220506 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220507 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220508 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220509 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220510 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220511 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220512 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220513 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220514 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220515 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220516 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220517 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220518 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220519 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220520 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220521 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220522 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220523 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220524 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220525 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220526 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220527 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220528 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220529 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220530 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220531 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220601 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220602 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220603 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220604 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220605 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220606 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220607 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220608 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220609 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220610 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220611 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220612 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220613 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220614 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220615 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220616 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220617 date, sort lcolor(red) lwidth(medium)) ///
(line DayDeaFOREA0120220618 date, sort lcolor(black) lwidth(thick)) ///
(line DayDeaMeSmA00 date, sort lcolor(cyan) lwidth(thick)) /// "JOHN smooth"
if date >= td(01jan2022) & provincestate == " National" ///
, xtitle(Date) xlabel(#11, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("C19 daily deaths, $country, DELP, updates in 2022", size(medium) color(black)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(159 "JOHN" 1 "DELP previous updates, forecast" 158 "DELP latest update 20220618, forecast") ///
size(small) row(2)) ///
subtitle("Forecasts only; smooth; no extremes", size(small)) yscale(titlegap(2))

qui graph export "graph 2 $country C19 daily deaths, DELP, Updates together no extremes.pdf", replace















view "log country DELP 3.smcl"

log close

exit, clear
