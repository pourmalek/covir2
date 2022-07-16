
clear all

cd "$pathcovir2"

cd SRIV




***************************************************************************
* This is "do country SRIV.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek
***************************************************************************



do "do country SRIV 1.do"
* get downloaded and prepared update files from covir2/20220708/output/
* input data files: web "country SRIV longit.dta"
* output data files: "country SRIV longit 20220708.dta" 



do "do country SRIV 2.do"
* continue preparation of estimates files, merge them, and graphs: updates together 
* input data files: "country SRIV `update'.dta" and "country JOHN.dta"
* output data files: "country SRIV longit.dta"



do "do country SRIV 3.do"
* latest update used in this uptake
* input data files: csv files on web site
* output data files: "country SRIV.dta"



