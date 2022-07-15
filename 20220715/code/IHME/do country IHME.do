
clear all

cd "$pathcovir2"

cd IHME

 



***************************************************************************
* This is "do country IHME.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek
***************************************************************************



do "do country IHME 1.do"
* download and prepare estimates files
* input data files: download csv files
* output data files: "IHME 202?????.dta " 
* "graph epoch update 202?????.pdf"


do "do country IHME 2.do"
* continue preparation of estimates files and merge them, graphs
* Forecast and backcast
* input data files: "IHME`update'.dta" and "country JOHN.dta"
* output data files: "country IHME longit.dta"


do "do country IHME 3.do"
* latest update used in this uptake
* input data files: csv files on web site
* output data files: "country IHME.dta"



