
clear all

cd "$pathcovir2"

cd DELP




***************************************************************************
* This is "do country DELP.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek 
***************************************************************************



do "do country DELP 1.do"
* download and prepare update files
* input data files: download csv files
* output data files: "country DELP 202?????.dta " 



do "do country DELP 2.do"
* merge update files
* input data files: "country DELP 202?????.dta " 
* output data files: "country DELP longit.dta"



do "do country DELP 3.do"
* graphs, daily deaths: updates separate 
* input data files: "country DELP longit.dta"
* output data files: none. no change in data.



do "do country DELP 4.do"

