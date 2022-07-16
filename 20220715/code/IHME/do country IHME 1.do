
clear all

cd "$pathcovir2"

cd IHME

capture log close 

log using "log country IHME 1.smcl", replace

***************************************************************************
* This is "do country IHME 1.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek
***************************************************************************



* get downloaded and prepared update files from covir2/20220708/output/
* input data files: web "country IHME longit.dta"
* output data files: "country IHME longit 20220708.dta" 



clear 

use https://raw.githubusercontent.com/pourmalek/covir2/main/20220708/output/IHME/country%20IHME%20longit.dta

save "country IHME longit 20220708.dta", replace



**********************

view "log country IHME 1.smcl"

log close

exit, clear
