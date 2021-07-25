

clear all

cd "$pathcovir2"

cd IMPE



*****************************************************************************
* This is "do country DELP.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare IMPE study estimates for country
*****************************************************************************


do "do country IMPE 1 get updates.do" // time consuning

do "do country IMPE 2 merge updates.do"






log close

exit, clear



