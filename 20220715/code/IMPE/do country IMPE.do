
clear all

cd "$pathcovir2"

cd IMPE




***************************************************************************
* This is "do country IMPE.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek 
***************************************************************************



do "do country IMPE 1.do"
* download and prepare update files
* input data files: download csv files
* output data files: "country IMPE 202?????.dta " 



do "do country IMPE 2.do"
* merge update files
* input data files: "country IMPE 202?????.dta " 
* output data files: "country IMPE longit.dta"



do "do country IMPE 3.do"
* graphs, daily deaths: updates separate 
* input data files: "country IMPE longit.dta"
* output data files: none. no change in data.



do "do country IMPE 4.do"

