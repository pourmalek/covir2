
clear all

cd "$pathcovir2"

cd SRIV

capture log close 

log using "log country SRIV 1.smcl", replace

***************************************************************************
* This is "do country SRIV 1.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek
***************************************************************************


* get downloaded and prepared update files from covir2/20220708/output/
* input data files: web "country SRIV longit.dta"
* output data files: "country SRIV longit 20220708.dta" 


clear 

use https://raw.githubusercontent.com/pourmalek/covir2/main/20220708/output/SRIV/country%20SRIV%20longit.dta

save "country SRIV longit 20220708.dta", replace




view "log country SRIV 1.smcl"

log close

exit, clear




