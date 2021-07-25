

clear all

cd "$pathcovir2"

cd IMPE

capture log close 

log using "log country IMPE 1 get updates.smcl", replace

*****************************************************************************
* This is "do country IMPE 1 get updates.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare IMPE study estimates for country
*****************************************************************************


clear


local list ///
2020-06-19_v4 /// 1
2020-06-23_v4 /// 2
2020-07-02_v4 /// 3
2020-07-03_v4 /// 4
2020-07-04_v4 /// 5
2020-07-07_v4 /// 6
2020-07-11_v4 /// 7
2020-07-14_v4 /// 8
2020-07-15_v4 /// 9
2020-07-18_v4 /// 10
2020-07-20_v4 /// 11
2020-07-22_v4 /// 12
2020-07-25_v4 /// 13
2020-07-27_v4 /// 14
2020-07-31_v4 /// 15
2020-08-08_v5 /// 16
2020-08-10_v5 /// 17
2020-08-11_v5 /// 18
2020-08-13_v5 /// 19
2020-08-14_v5 /// 20
2020-08-17_v5 /// 21
2020-08-23_v5 /// 22
2020-08-25_v5 /// 23
2020-08-27_v5 /// 24
2020-08-31_v5 /// 25
2020-09-02_v5 /// 26
2020-09-06_v5 /// 27
2020-09-08_v5 /// 28
2020-09-12_v5 /// 29
2020-09-15_v5 /// 30
2020-09-19_v5 /// 31
2020-09-23_v5 /// 32
2020-09-25_v5 /// 33
2020-10-03_v5 /// 34
2020-10-06_v5 /// 35
2020-10-12_v5 /// 36
2020-10-19_v5 /// 37
2020-10-25_v5 /// 38
2020-10-28_v5 /// 39
2020-11-01_v5 /// 40
2020-11-10_v6 /// 41
2020-11-14_v6 /// 42
2020-11-18_v6 /// 43
2020-11-23_v6 /// 44
2020-11-29_v6 /// 45
2020-12-04_v6 /// 46
2020-12-12_v6 /// 47
2020-12-20_v6 /// 48
2020-12-26_v6 /// 49
2021-01-04_v6 /// 50
2021-01-10_v6 /// 51
2021-01-12_v6 /// 52
2021-01-18_v7 /// 53
2021-01-24_v7 /// 54
2021-01-30_v7 /// 55
2021-02-03_v7 /// 56
2021-02-10_v7 /// 57
2021-02-17_v7 /// 58
2021-02-26_v7 /// 59
2021-03-05_v7 /// 60
2021-03-12_v7 /// 61
2021-03-19_v7 /// 62
2021-03-29_v7 /// 63
2021-04-06_v7 /// 64
2021-04-17_v7 /// 65
2021-04-24_v7 /// 66
2021-05-10_v8 /// 67
2021-05-16_v8 /// 68
2021-05-22_v8 /// 69
2021-05-27_v8 /// 70
2021-06-04_v8 /// 71
2021-06-11_v8 /// 72
2021-06-18_v8 /// 73
2021-06-26_v8 /// 74
2021-07-02_v8 /// 75
2021-07-09_v8 //  76


foreach l of local list {

     
* get IMPE estimates


copy https://raw.githubusercontent.com/mrc-ide/global-lmic-reports/master/data/`l'.csv.zip `l'.csv.zip
unzipfile `l'.csv.zip, replace
erase `l'.csv.zip

 
******************************

* import csv file


import delimited "`l'.csv", clear varnames(1) // takes a while
keep if regexm(country,"$country") == 1



* gen date 

rename date date_original

gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2)
egen dateblock = concat(year month day)
drop year month day


* rename uncertainty limits

rename y_mean 	y_mea_




* rename scenarios 

keep if scenario == "Maintain Status Quo"

gen scenario_snail = ""
replace scenario_snail = "S2" if scenario == "Maintain Status Quo"

gen underline = "_"
egen scenario_snail_dateblock = concat(scenario_snail underline dateblock)

drop date_original scenario

drop scenario_snail_dateblock 
   

* Primary outcomes Total Deaths, Total infections, Daily Deaths, and Daily infections

replace compartment = "cumul_death" if compartment == "cumulative_deaths"
replace compartment = "cumul_infec" if compartment == "cumulative_infections"
replace compartment = "daily_death" if compartment == "deaths"
replace compartment = "daily_infec" if compartment == "infections"

keep if compartment == "cumul_death" | /// 
compartment == "cumul_infec" | ///          
compartment == "daily_death" | ///
compartment == "daily_infec"


drop y_025 y_25 y_median y_75 y_975 // keeps mean y_mea_	


* reshape

egen compartment_scenario_snail = concat(compartment underline scenario_snail)	

drop compartment underline scenario_snail

tab compartment_scenario_snail

reshape wide y_mea_ , i(country dateblock) j(compartment_scenario_snail) string


*

rename y_mea_cumul_death_S2 TotDeaMeRaA03S02
rename y_mea_cumul_infec_S2 TotINFMeRaA03S02
rename y_mea_daily_death_S2 DayDeaMeRaA03S02
rename y_mea_daily_infec_S2 DayINFMeRaA03S02




* gen date

gen year = substr(dateblock,1,4) 
gen month = substr(dateblock,5,2) 
gen day = substr(dateblock,7,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date


rename country loc_grand_name

replace loc_grand_name = "$country"


keep date loc_grand_name DayDeaMeRaA03S02 DayINFMeRaA03S02 TotDeaMeRaA03S02 TotINFMeRaA03S02

order date loc_grand_name DayDeaMeRaA03S02 DayINFMeRaA03S02 TotDeaMeRaA03S02 TotINFMeRaA03S02


** add update date to end of varnames

	* gen this update's date = update_date

gen year = substr("`l'",1,4)
gen month = substr("`l'",6,2)
gen day = substr("`l'",9,2)
gen dating = year + month + day
local update_date = dating

drop year month day dating


local varlist DayDeaMeRaA03S02 DayINFMeRaA03S02 TotDeaMeRaA03S02 TotINFMeRaA03S02

foreach v of local varlist {

	rename `v' `v'U`update_date'
	
}
*	


sort date loc_grand_name

qui compress


save "IMPE `update_date' country.dta", replace

shell rm -r `l'.csv



clear

}
*


view "log country IMPE 1 get updates.smcl"

log close

exit, clear



