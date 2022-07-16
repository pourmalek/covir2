
clear all

cd "$pathcovir2"

cd IHME

 



***************************************************************************
* This is "do country IHME.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek
***************************************************************************



do "do country IHME 1.do"
* get downloaded and prepared update files from covir2/20220708/output/
* input data files: web "country IHME longit.dta"
* output data files: "country IHME longit 20220708.dta" 


do "do country IHME 2.do"
* download updates after uptake 20220708 + graph 1
* input data files: "country IHME longit 20220708.dta"
* output data files: "country IHME longit.dta"


do "do country IHME 3.do"
* latest update used in this uptake
* input data files: csv files on web site
* output data files: "country IHME.dta"



