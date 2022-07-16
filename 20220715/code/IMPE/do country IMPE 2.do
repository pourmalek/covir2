
clear all

cd "$pathcovir2"

cd IMPE

capture log close 

log using "log country IMPE 2.smcl", replace

***************************************************************************
* This is "do country IMPE 2.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek
***************************************************************************


* download updates after uptake 20220708
* input data files: "country IMPE longit 20220708.dta"
* output data files: "country IMPE longit.dta"





****************************************

* download updates after uptake 20220708



********************

* 2022-07-03_v9.csv.zip 

* creates:
* Users/gbarnsle/Documents/LMIC_fitting/global-lmic-reports-orderly/gh-pages/data/2022-07-03_v9.csv



clear
			   
copy https://raw.githubusercontent.com/mrc-ide/global-lmic-reports/master/data/2022-07-03_v9.csv.zip 2022-07-03_v9.csv.zip
unzipfile 2022-07-03_v9.csv.zip, replace
erase 2022-07-03_v9.csv.zip

cd Users
cd gbarnsle
cd Documents
cd LMIC_fitting
cd "global-lmic-reports-orderly"
cd "gh-pages"
cd data

import delimited "2022-07-03_v9.csv", clear varnames(1)


cd "$pathcovir2"

cd IMPE


keep if regexm(country,"$country") == 1

keep if scenario == "Central"

drop scenario

keep if compartment == "deaths"

drop compartment

drop y_025 y_25 y_median y_75 y_975 // keeps y_mean


* gen date 

rename date date_original
gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date
drop year month day date2 date_original


rename country loc_grand_name 

drop iso3c report_date version

rename y_mean DayDeaMeRaA03S02

order loc_grand_name date DayDeaMeRaA03S02

rename DayDeaMeRaA03S02 DayDeaMeRaA0320220703


* smooth

tsset date, daily   
	
qui tssmooth ma DayDeaMeRaA0320220703window = DayDeaMeRaA0320220703 if DayDeaMeRaA0320220703 >= 0, window(3 1 3)

qui tssmooth ma DayDeaMeSmA0320220703 = DayDeaMeRaA0320220703window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA0320220703 "Daily deaths mean smooth IMPE"

drop *window

tsset, clear



* gen Forecast only
	
capture drop update_date

gen update_date = td(20Jun2022)

cap drop DayDeaFOREA0320220703

gen DayDeaFOREA0320220703 = DayDeaMeSmA0320220703

replace DayDeaFOREA0320220703 = . if date < update_date

label var DayDeaFOREA0320220703 "DayDeaMeRaA03 `update' Forecast only"
	
qui compress 

save "country IMPE 20220703.dta", replace

*








****************************************

* merge "country IMPE longit 20220708.dta" with downloadED updates after uptake 20220708



use "country IMPE longit 20220708.dta", clear

	merge m:m date loc_grand_name using "country IMPE 20220703.dta"
	
	drop _merge


save "country IMPE longit.dta", replace









view "log country IMPE 2.smcl"

log close

exit, clear
