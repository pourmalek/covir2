
clear all

cd "$pathcovir2"

cd IMPE




***************************************************************************
* This is "do country IMPE.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek 
***************************************************************************



do "do country IMPE 1.do"
* get downloaded and prepared update files from covir2/20220708/output/
* input data files: web "country IMPE longit.dta"
* output data files: "country IMPE longit 20220708.dta" 



do "do country IMPE 2.do"
* download updates after uptake 20220708
* input data files: "country IMPE longit 20220708.dta"
* output data files: "country IMPE longit.dta"



do "do country IMPE 3.do"
* graphs, daily deaths: updates separate 
* input data files: "country IMPE longit.dta"
* output data files: none. no change in data.



do "do country IMPE 4.do"
* latest update used in this uptake
* input data files: csv files on web site
* output data files: "country IMPE.dta"
