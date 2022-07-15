
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


* download and prepare update files
* input data files: download csv files
* output data files: "country IMPE 202?????.dta " 






****************************************************************
* files stored in: 
* https://github.com/mrc-ide/global-lmic-reports/tree/master/data

               
			   
			   
local list `" "2022-01-20_v9" "2022-01-31_v9" "2022-03-15_v9" "2022-05-30_v9" "'



foreach update of local list {

	clear 

	set obs 1
	
	gen this = "`update'"
	
	gen that = substr(this,1,10)
	
	gen update2022MMDD = subinstr(that, "-", "",.)
	
	local update2022MMDD = update2022MMDD

	di in red "This is IMPE update " "`update2022MMDD'"
	
	clear
	
	copy https://raw.githubusercontent.com/mrc-ide/global-lmic-reports/master/data/`update'.csv.zip `update'.csv.zip
	unzipfile `update'.csv.zip, replace
	erase `update'.csv.zip
	
	import delimited "`update'.csv", clear varnames(1)

	keep if regexm(country,"$country") == 1

	keep if scenario == "Maintain Status Quo"
	
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
	
	rename DayDeaMeRaA03S02 DayDeaMeRaA03`update2022MMDD'
	

	* smooth

	tsset date, daily   
		
	qui tssmooth ma DayDeaMeRaA03`update2022MMDD'window = DayDeaMeRaA03`update2022MMDD' if DayDeaMeRaA03`update2022MMDD' >= 0, window(3 1 3)
	
	qui tssmooth ma DayDeaMeSmA03`update2022MMDD' = DayDeaMeRaA03`update2022MMDD'window, weights( 1 2 3 <4> 3 2 1) replace
	
	label var DayDeaMeSmA03`update2022MMDD' "Daily deaths mean smooth IMPE"
	
	drop *window
	
	tsset, clear
	
	

	* gen Forecast only
		
	capture drop update_date
	
	gen update_date = date("`update2022MMDD'", "YMD")
	
	cap drop DayDeaFOREA03`update2022MMDD'
	
	gen DayDeaFOREA03`update2022MMDD' = DayDeaMeSmA03`update2022MMDD'
	
	replace DayDeaFOREA03`update2022MMDD' = . if date < update_date
	
	label var DayDeaFOREA03`update2022MMDD' "DayDeaMeRaA03 `update' Forecast only"
		

	qui compress 

	save "IMPE `update2022MMDD'.dta", replace


}
*




shell rm -r "2022-01-20_v9.csv"
shell rm -r "2022-01-31_v9.csv"
shell rm -r "2022-03-15_v9.csv"
shell rm -r "2022-05-30_v9.csv"






********************

* 2022-06-20_v9.csv.zip is one of a kind

* creates:
* Users/gbarnsle/Documents/LMIC_fitting/global-lmic-reports-orderly/gh-pages/data/2022-06-20_v9.csv




clear
			   
copy https://raw.githubusercontent.com/mrc-ide/global-lmic-reports/master/data/2022-06-20_v9.csv.zip 2022-06-20_v9.csv.zip
unzipfile 2022-06-20_v9.csv.zip, replace
erase 2022-06-20_v9.csv.zip


import delimited "2022-06-20_v9.csv", clear varnames(1)

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

rename DayDeaMeRaA03S02 DayDeaMeRaA0320220620


* smooth

tsset date, daily   
	
qui tssmooth ma DayDeaMeRaA0320220620window = DayDeaMeRaA0320220620 if DayDeaMeRaA0320220620 >= 0, window(3 1 3)

qui tssmooth ma DayDeaMeSmA0320220620 = DayDeaMeRaA0320220620window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA0320220620 "Daily deaths mean smooth IMPE"

drop *window

tsset, clear



* gen Forecast only
	
capture drop update_date

gen update_date = td(20Jun2022)

cap drop DayDeaFOREA0320220620

gen DayDeaFOREA0320220620 = DayDeaMeSmA0320220620

replace DayDeaFOREA0320220620 = . if date < update_date

label var DayDeaFOREA0320220620 "DayDeaMeRaA03 `update' Forecast only"
	

qui compress 

save "IMPE 20220620.dta", replace

*










****************************************************************
* files stored in: 
* https://mrcdata.dide.ic.ac.uk/global-lmic-reports/




local list `" "2022-01-02_v9" "'


foreach update of local list {

	clear

	set obs 1
	
	gen this = "`update'"
	
	gen that = substr(this,1,10)
	
	gen update2022MMDD = subinstr(that, "-", "",.)
	
	local update2022MMDD = update2022MMDD

	di in red "This is IMPE update " "`update2022MMDD'"
	
	clear
	
	copy https://mrcdata.dide.ic.ac.uk/global-lmic-reports/`update'.csv.zip `update'.csv.zip
	unzipfile `update'.csv.zip, replace
	erase `update'.csv.zip
	
	import delimited "`update'.csv", clear varnames(1)

	keep if regexm(country,"$country") == 1

	keep if scenario == "Maintain Status Quo"
	
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
	
	rename DayDeaMeRaA03S02 DayDeaMeRaA03`update2022MMDD'
	

	* smooth

	tsset date, daily   
		
	qui tssmooth ma DayDeaMeRaA03`update2022MMDD'window = DayDeaMeRaA03`update2022MMDD' if DayDeaMeRaA03`update2022MMDD' >= 0, window(3 1 3)
	
	qui tssmooth ma DayDeaMeSmA03`update2022MMDD' = DayDeaMeRaA03`update2022MMDD'window, weights( 1 2 3 <4> 3 2 1) replace
	
	label var DayDeaMeSmA03`update2022MMDD' "Daily deaths mean smooth IMPE"
	
	drop *window
	
	tsset, clear
	
	

	* gen Forecast only
		
	capture drop update_date
	
	gen update_date = date("`update2022MMDD'", "YMD")
	
	cap drop DayDeaFOREA03`update2022MMDD'
	
	gen DayDeaFOREA03`update2022MMDD' = DayDeaMeSmA03`update2022MMDD'
	
	replace DayDeaFOREA03`update2022MMDD' = . if date < update_date
	
	label var DayDeaFOREA03`update2022MMDD' "DayDeaMeRaA03 `update' Forecast only"
		

	qui compress 

	save "IMPE `update2022MMDD'.dta", replace


}
*




shell rm -r "2022-01-02_v9.csv"












view "log country IMPE 1.smcl"

log close

exit, clear




