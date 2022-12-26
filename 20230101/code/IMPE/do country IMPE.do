
clear all

cd "$pathcovir2"

cd IMPE

capture log close 

log using "log country IMPE.smcl", replace

*****************************************************************************
* This is "do country IMPE.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek
*****************************************************************************


* latest update used in this uptake
* input data files: csv files on web site
* output data files: "country IMPE.dta"
																 

clear 

*****************************

* get IMPE estimates

capture shell rm -r "2022-09-01_v10.csv.zip"

copy https://raw.githubusercontent.com/mrc-ide/global-lmic-reports/master/data/2022-09-01_v10.csv.zip 2022-09-01_v10.csv.zip
unzipfile 2022-09-01_v10.csv.zip, replace
erase 2022-09-01_v10.csv.zip



 
******************************

* import csv file

/*
* Users/gbarnsle/Documents/LMIC_fitting/global-lmic-reports-orderly/gh-pages/data/2022-09-01_v10.csv

cd Users
cd gbarnsle
cd Documents
cd LMIC_fitting
cd "global-lmic-reports-orderly"
cd "gh-pages"
cd data
*/


import delimited "2022-09-01_v10.csv", clear varnames(1)

keep if regexm(country,"$country") == 1




keep if fit_type == "Reported Deaths"


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

replace loc_grand_name = "Brunei" if loc_grand_name == "Brunei Darussalam"
replace loc_grand_name = "Cape Verde" if loc_grand_name == "Cabo Verde"
replace loc_grand_name = "Congo" if loc_grand_name == "Republic of the Congo"
replace loc_grand_name = "Congo DR" if loc_grand_name == "Democratic Republic of Congo"
replace loc_grand_name = "Guinea Bissau" if loc_grand_name == "Guinea-Bissau"
replace loc_grand_name = "Korea North" if loc_grand_name == "North Korea"
replace loc_grand_name = "Korea South" if loc_grand_name == "South Korea"
replace loc_grand_name = "Kyrgyzstan" if loc_grand_name == "Kyrgyz Republic"
replace loc_grand_name = "Laos" if loc_grand_name == "Lao PDR"
replace loc_grand_name = "Palestine" if loc_grand_name == "State of Palestine"
replace loc_grand_name = "Saint Lucia" if loc_grand_name == "St. Lucia"
replace loc_grand_name = "Saint Vincent and the Grenadines" if loc_grand_name == "St. Vincent and the Grenadines"
replace loc_grand_name = "Timor Leste" if loc_grand_name == "Timor-Leste"
replace loc_grand_name = "United States of America" if loc_grand_name == "United States"
replace loc_grand_name = "Viet Nam" if loc_grand_name == "Vietnam"

 

drop iso3c report_date version

rename y_mean DayDeaMeRaA03S02

order loc_grand_name date DayDeaMeRaA03S02

gen DayDeaMeSmA03S02 = DayDeaMeRaA03S02 // already smoothed

label var DayDeaMeSmA03S02 "Daily deaths smooth mean IMPE"

* gen Daily deaths smooth forecast only
		
clonevar DayDeaFOREA03S02 = DayDeaMeRaA03S02

label var DayDeaFOREA03S02 "Daily deaths smooth mean forecast only IMPE"
				
qui replace DayDeaFOREA03S02 = . if date < td(01Sep2022)
	
	
	
drop fit_type death_calibrated
	

sort date loc_grand_name

qui compress

cd "$pathcovir2"

cd IMPE


save "country IMPE.dta", replace





view "log country IMPE.smcl"

log close

exit, clear



