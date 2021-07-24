

clear all

cd "$pathcovir2"

cd IHME

capture log close 

log using "log country IHME 20210423.smcl", replace

*****************************************************************************
* This is "do country IHME 20210423.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare IHME study estimates for country
*****************************************************************************


** details of this update from IHME updates Iran.xlsx :

* update number	| update date | web date day year | web address	| local dir name | file name | cd to local dir needed

* 39	20210423	April	23	2021	https://ihmecovid19storage.blob.core.windows.net/archive/2021-04-23/ihme-covid19.zip	
* 2021_04_22	reference_hospitalization_all_locs			yes



** changes needed for adjusting the do file for this update :


* find and replace all item (old), with item (new) 

* (1) update date: 							20210423 

* (2) web address directory: 				2021-04-23 

* (3) local dir name: 						2021-04-23

* (4) reference scenario csv file name		reference_hospitalization_all_locs: file name with small or captital R                                        

* (5) cd local dir name or not cd?			yes cd

* (6) has inf_cuml_mean (TotINFMeRaA02S01) and est_infections_mean (DayINFMeRaA02S01) ?
* find (6) and change accordingly


clear 
 
*****************************

* get IHME estimates

copy https://ihmecovid19storage.blob.core.windows.net/archive/2021-04-23/ihme-covid19.zip ihme-covid19.zip
unzipfile ihme-covid19.zip, replace
erase ihme-covid19.zip


cd 2021_04_22 // cd needed


import delimited using reference_hospitalization_all_locs.csv, clear varnames(1)
	

keep if regexm(location_name,"$country") == 1
	
	
rename date date_original
gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date
drop year month day date2




* rename variables

* Total Deaths not smoothed
rename totdea_mean  TotDeaMeRaA02S01
label var TotDeaMeRaA02S01 "Total Deaths Mean not smoothed IHME S1"


* Daily Deaths not smoothed
rename deaths_mean  DayDeaMeRaA02S01
label var DayDeaMeRaA02S01 "Daily Deaths Mean not smoothed IHME S1"

* (6) has inf_cuml_mean (TotINFMeRaA02S01) and est_infections_mean (DayINFMeRaA02S01) ?


* Total infections not smoothed
rename inf_cuml_mean  TotINFMeRaA02S01
label var TotINFMeRaA02S01 "Total infections Mean not smoothed IHME S1" 

* Daily infections not smoothed
rename est_infections_mean  DayINFMeRaA02S01
label var DayINFMeRaA02S01 "Daily infections Mean not smoothed IHME S1"


* Total Deaths smoothed
rename totdea_mean_smoothed   TotDeaMeSmA02S01
label var TotDeaMeSmA02S01 "Total Deaths Mean smoothed IHME S1"

* Daily Deaths smoothed
rename deaths_mean_smoothed  DayDeaMeSmA02S01    	
label var DayDeaMeSmA02S01 "Daily Deaths Mean smoothed IHME S1"


rename location_name loc_grand_name 

replace loc_grand_name = "$country"



keep date loc_grand_name DayDeaMeRaA02S01 DayDeaMeSmA02S01 TotDeaMeRaA02S01 DayINFMeRaA02S01 TotINFMeRaA02S01 TotDeaMeSmA02S01

order date loc_grand_name DayDeaMeRaA02S01 DayDeaMeSmA02S01 TotDeaMeRaA02S01 DayINFMeRaA02S01 TotINFMeRaA02S01 TotDeaMeSmA02S01


* or

* (6) has inf_cuml_mean (TotINFMeRaA02S01) and est_infections_mean (DayINFMeRaA02S01) ?


// keep date loc_grand_name DayDeaMeRaA02S01 DayDeaMeSmA02S01 TotDeaMeRaA02S01 TotDeaMeSmA02S01

// order date loc_grand_name DayDeaMeRaA02S01 DayDeaMeSmA02S01 TotDeaMeRaA02S01 TotDeaMeSmA02S01





* add update date to end of varnames

local varlist DayDeaMeRaA02S01 DayDeaMeSmA02S01 TotDeaMeRaA02S01 DayINFMeRaA02S01 TotINFMeRaA02S01 TotDeaMeSmA02S01

* or 

* (6) has inf_cuml_mean (TotINFMeRaA02S01) and est_infections_mean (DayINFMeRaA02S01) ?


// local varlist DayDeaMeRaA02S01 DayDeaMeSmA02S01 TotDeaMeRaA02S01 TotDeaMeSmA02S01


foreach v of local varlist {

	rename `v' `v'U20210423
	
}
*	





qui compress

cd .. // needed

save "IHME 20210423 country.dta", replace

shell rm -r reference_hospitalization_all_locs.csv

shell rm -r 2021_04_22 // local dir




view "log country IHME 20210423.smcl"

log close

exit, clear



