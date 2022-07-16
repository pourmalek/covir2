
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


* get downloaded and prepared update files from covir2/20220708/output/
* input data files: web "country DELP longit.dta"
* output data files: "country DELP longit 20220708.dta" 


clear 

use https://raw.githubusercontent.com/pourmalek/covir2/main/20220708/output/DELP/country%20DELP%20longit.dta

save "country DELP longit 20220708.dta", replace



view "log country DELP 1.smcl"

log close

exit, clear




