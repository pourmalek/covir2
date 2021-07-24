

clear all

cd "$pathcovir2"

cd IHME

capture log close 

log using "log country IHME.smcl", replace

*****************************************************************************
* This is "do country IHME.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare IHME study estimates for country
*****************************************************************************


                                                                                                         ***************************
* To change update date, find and replace all, 2021-07-15 (old), with 2021-07-15 (new) <<--       <<<--- * change update date here *
                                                                                                         ***************************

																										 

do "do country IHME 20200629.do"
do "do country IHME 20200625.do"
do "do country IHME 20200707.do"
do "do country IHME 20200714.do"
do "do country IHME 20200722.do"
do "do country IHME 20200730.do"
do "do country IHME 20200806.do"
do "do country IHME 20200821.do"
do "do country IHME 20200827.do"
do "do country IHME 20200903.do"
do "do country IHME 20200911.do"
do "do country IHME 20200918.do"
do "do country IHME 20200924.do"
do "do country IHME 20201002.do"
do "do country IHME 20201009.do"
do "do country IHME 20201015.do"
do "do country IHME 20201022.do"
do "do country IHME 20201029.do"
do "do country IHME 20201112.do"
do "do country IHME 20201119.do"
do "do country IHME 20201203.do"
do "do country IHME 20201210.do"
do "do country IHME 20201217.do"
do "do country IHME 20201223.do"
do "do country IHME 20210115.do"
do "do country IHME 20210122.do"
do "do country IHME 20210204.do"
do "do country IHME 20210212.do"
do "do country IHME 20210220.do"
do "do country IHME 20210225.do"
do "do country IHME 20210306.do"
do "do country IHME 20210311.do"
do "do country IHME 20210317.do"
do "do country IHME 20210325.do"
do "do country IHME 20210401.do"
do "do country IHME 20210409.do"
do "do country IHME 20210416.do"
do "do country IHME 20210423.do"
do "do country IHME 20210506.do"
do "do country IHME 20210514.do"
do "do country IHME 20210521.do"
do "do country IHME 20210528.do"
do "do country IHME 20210604.do"
do "do country IHME 20210610.do"
do "do country IHME 20210618.do"
do "do country IHME 20210625.do"
do "do country IHME 20210702.do"
do "do country IHME 20210715.do"					


do "do country IHME merge.do"

																	 
