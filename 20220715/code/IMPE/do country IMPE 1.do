
clear all

cd "$pathcovir2"

cd IMPE

capture log close 

log using "log country IMPE 1.smcl", replace

***************************************************************************
* This is "do country IMPE 1.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek 
***************************************************************************


* get downloaded and prepared update files from covir2/20220708/output/
* input data files: web "country IMPE longit.dta"
* output data files: "country IMPE longit 20220708.dta" 


clear 

use https://raw.githubusercontent.com/pourmalek/covir2/main/20220708/output/IMPE/country%20IMPE%20longit.dta

save "country IMPE longit 20220708.dta", replace






view "log country IMPE 1.smcl"

log close

exit, clear




