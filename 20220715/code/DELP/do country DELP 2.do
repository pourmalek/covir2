
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


* download updates after uptake 20220708
* input data files: "country DELP longit 20220708.dta"
* output data files: "country DELP longit.dta"


* download updates after uptake 20220708

* no DELP update/s after uptake 20220708


* merge "country DELP longit 20220708.dta" with downloadED updates after uptake 20220708



use "country DELP longit 20220708.dta", clear


save "country DELP longit.dta", replace






view "log country DELP 2.smcl"

log close

exit, clear
