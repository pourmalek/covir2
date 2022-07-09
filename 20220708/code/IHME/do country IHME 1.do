
clear all

cd "$pathcovir2"

cd IHME

capture log close 

log using "log country IHME 1.smcl", replace

***************************************************************************
* This is "do country IHME 1.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek
***************************************************************************


* download and prepare estimates files
* input data files: download csv files
* output data files: "IHME 202?????.dta " 
* "graph epoch update 202?????.pdf"

* based on combinations of linkdate, download, and urldate
* e.g., 				   04-Nov-21 ihme-covid19  2021-11-04	https://ihmecovid19storage.blob.core.windows.net/archive/2021-11-04/ihme-covid19.zip	data_download_file_reference_2020




/*
Explanation of “linkdate”, “download”, and “urldate”:

“linkdate” is the date of update as shown on web page https://www.healthdata.org/node/8787 titled “COVID-19 estimate downloads | Archive” that mentions “Archive dates correspond to the update in the projections tool with most recent data, which may differ from the date listed on the downloaded file.” 

“linkdate” is the “update date” here.

“download” is the name of the directory that is created after downloading the files and unzipped. Later updates do not create a directory and the files get downloaded directly to the root of -present working directory- that is /IHME/.

“download” is used here with command -cd- to change directory to the created directory (and later, -cd ..- is used to come back to the root /IHME/.

“urldate” is the date mentioned in the URL of the update.

“urldate” is used in the download URL here. 
*/







grstyle init

grstyle color background white







**********************************************
**********************************************
**********************************************

* Iran update 2022 No. 1 
* linkdate		download		urldate
* Jan 8, 2022	ihme-covid19	2022-01-10
* filename: data_download_file_reference_2020.csv and data_download_file_reference_2021.csv

		

di in red "This is urldate 2022-01-10, linkdate Jan 8, 2022"

*****************************

* get IHME estimates

copy https://ihmecovid19storage.blob.core.windows.net/archive/2022-01-10/ihme-covid19.zip ihme-covid19.zip
unzipfile ihme-covid19.zip, replace
erase ihme-covid19.zip


******************************

* import csv files

import delimited using data_download_file_reference_2020.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2020.dta, replace

import delimited using data_download_file_reference_2021.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2021.dta, replace



******************************

* gen scenario dta files

use "data_download_file_reference_2020.dta", clear 

local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2020.dta", replace 



use "data_download_file_reference_2021.dta", clear 


local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2021.dta", replace 

append using "data_download_file_reference_2020.dta"




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

* Daily Deaths smoothed
rename seir_daily_unscaled_mean  DayDeaMeSmA02S01
label var DayDeaMeSmA02S01 "Daily Deaths Mean smoothed IHME S1" // Daily reported deaths (mean estimate)
		

rename location_name provincestate

gen loc_grand_name = "$country"

replace provincestate = " National" if provincestate == "$country"



keep date loc_grand_name provincestate DayDeaMeSmA02S01 daily_deaths_unscaled

order date loc_grand_name provincestate DayDeaMeSmA02S01

sort loc_grand_name provincestate date


rename (DayDeaMeSmA02S01) (DayDeaMeSmA0220220110)




qui compress

save "IHME 20220110.dta", replace



shell rm -r "data_dictionary.csv"
shell rm -r "data_download_file_best_masks_2020.csv"
shell rm -r "data_download_file_best_masks_2021.csv"
shell rm -r "data_download_file_reference_2020.csv"
shell rm -r "data_download_file_reference_2021.csv"
shell rm -r "IHME_COVID_19_Data_Release_Information_Sheet.pdf"
shell rm -r "data_download_file_reference_2020.dta"
shell rm -r "data_download_file_reference_2021.dta"

shell rm -r "data_download_file_severe_omicron_2020.csv"
shell rm -r "data_download_file_severe_omicron_2021.csv"
shell rm -r "data_download_file_third_dose_2020.csv"
shell rm -r "data_download_file_third_dose_2021.csv"
shell rm -r "data_download_file_reduce_hesitancy_2020.csv"
shell rm -r "data_download_file_reduce_hesitancy_2021.csv"



***





* update 20220110 epoch

use "IHME 20220110.dta", clear

// br date DayDeaMeSmA0220220110 daily_deaths_unscaled
gen epoch = td(04Jan2022)
di td(04Jan2022)
label var epoch "Forecast start date"
local epoch = epoch


twoway ///
(line daily_deaths_unscaled date, sort lwidth(medium) lcolor(black)) /// 	
(line DayDeaMeSmA0220220110 date, sort lwidth(medium) lcolor(gold)) /// 	
if date >= td(01Jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, $country, National, IHME, update 20220110", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
xline(22649, lwidth(thin) lcolor(red)) ///
subtitle("Forecast start date is denoted with red line: 04Jan2022") ///
legend(order(1 "Daily deaths unscaled" 2 "Daily deaths reference scenario smooth") size(small))


qui graph export "graph $country IHME epoch update 20220110.pdf", replace
		
drop daily_deaths_unscaled
rename epoch epoch20220110

save "IHME 20220110.dta", replace

*

















**********************************************
**********************************************
**********************************************

* Iran update 2022 No. 2 
* linkdate		download		urldate
* Jan 14, 2022	ihme-covid19	2022-01-14
* filename: data_download_file_reference_2020.csv and data_download_file_reference_2021.csv

		

di in red "This is urldate 2022-01-14, linkdate Jan 14, 2022"

*****************************

* get IHME estimates

copy https://ihmecovid19storage.blob.core.windows.net/archive/2022-01-14/ihme-covid19.zip ihme-covid19.zip
unzipfile ihme-covid19.zip, replace
erase ihme-covid19.zip


******************************

* import csv files

import delimited using data_download_file_reference_2020.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2020.dta, replace

import delimited using data_download_file_reference_2021.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2021.dta, replace



******************************

* gen scenario dta files

use "data_download_file_reference_2020.dta", clear 

local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2020.dta", replace 



use "data_download_file_reference_2021.dta", clear 


local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2021.dta", replace 

append using "data_download_file_reference_2020.dta"




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

* Daily Deaths smoothed
rename seir_daily_unscaled_mean  DayDeaMeSmA02S01
label var DayDeaMeSmA02S01 "Daily Deaths Mean smoothed IHME S1" // Daily reported deaths (mean estimate)
		

rename location_name provincestate

gen loc_grand_name = "$country"

replace provincestate = " National" if provincestate == "$country"



keep date loc_grand_name provincestate DayDeaMeSmA02S01 daily_deaths_unscaled

order date loc_grand_name provincestate DayDeaMeSmA02S01

sort loc_grand_name provincestate date


rename (DayDeaMeSmA02S01) (DayDeaMeSmA0220220114)




qui compress

save "IHME 20220114.dta", replace



shell rm -r "data_dictionary.csv"
shell rm -r "data_download_file_best_masks_2020.csv"
shell rm -r "data_download_file_best_masks_2021.csv"
shell rm -r "data_download_file_reference_2020.csv"
shell rm -r "data_download_file_reference_2021.csv"
shell rm -r "IHME_COVID_19_Data_Release_Information_Sheet.pdf"
shell rm -r "data_download_file_reference_2020.dta"
shell rm -r "data_download_file_reference_2021.dta"

shell rm -r "data_download_file_severe_omicron_2020.csv"
shell rm -r "data_download_file_severe_omicron_2021.csv"
shell rm -r "data_download_file_third_dose_2020.csv"
shell rm -r "data_download_file_third_dose_2021.csv"
shell rm -r "data_download_file_reduce_hesitancy_2020.csv"
shell rm -r "data_download_file_reduce_hesitancy_2021.csv"



***





* update 20220114 epoch

use "IHME 20220114.dta", clear

// br date DayDeaMeSmA0220220114 daily_deaths_unscaled
gen epoch = td(11Jan2022)
di td(11Jan2022)
label var epoch "Forecast start date"
local epoch = epoch


twoway ///
(line daily_deaths_unscaled date, sort lwidth(medium) lcolor(black)) /// 	
(line DayDeaMeSmA0220220114 date, sort lwidth(medium) lcolor(gold)) /// 	
if date >= td(01Jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, $country, National, IHME, update 20220114", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
xline(22656, lwidth(thin) lcolor(red)) ///
subtitle("Forecast start date is denoted with red line: 11Jan2022") ///
legend(order(1 "Daily deaths unscaled" 2 "Daily deaths reference scenario smooth") size(small))


qui graph export "graph $country IHME epoch update 20220114.pdf", replace
		
drop daily_deaths_unscaled
rename epoch epoch20220114

save "IHME 20220114.dta", replace

*












**********************************************
**********************************************
**********************************************

* Iran update 2022 No. 3
* linkdate		download		urldate
* Jan 21, 2022	ihme-covid19	2022-01-21
* filename: data_download_file_reference_2020.csv and data_download_file_reference_2021.csv

		

di in red "This is urldate 2022-01-21, linkdate Jan 21, 2022"

*****************************

* get IHME estimates

copy https://ihmecovid19storage.blob.core.windows.net/archive/2022-01-21/ihme-covid19.zip ihme-covid19.zip
unzipfile ihme-covid19.zip, replace
erase ihme-covid19.zip


******************************

* import csv files

import delimited using data_download_file_reference_2020.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2020.dta, replace

import delimited using data_download_file_reference_2021.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2021.dta, replace



******************************

* gen scenario dta files

use "data_download_file_reference_2020.dta", clear 

local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2020.dta", replace 



use "data_download_file_reference_2021.dta", clear 


local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2021.dta", replace 

append using "data_download_file_reference_2020.dta"




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

* Daily Deaths smoothed
rename seir_daily_unscaled_mean  DayDeaMeSmA02S01
label var DayDeaMeSmA02S01 "Daily Deaths Mean smoothed IHME S1" // Daily reported deaths (mean estimate)
		

rename location_name provincestate

gen loc_grand_name = "$country"

replace provincestate = " National" if provincestate == "$country"



keep date loc_grand_name provincestate DayDeaMeSmA02S01 daily_deaths_unscaled

order date loc_grand_name provincestate DayDeaMeSmA02S01

sort loc_grand_name provincestate date


rename (DayDeaMeSmA02S01) (DayDeaMeSmA0220220121)




qui compress

save "IHME 20220121.dta", replace



shell rm -r "data_dictionary.csv"
shell rm -r "data_download_file_best_masks_2020.csv"
shell rm -r "data_download_file_best_masks_2021.csv"
shell rm -r "data_download_file_reference_2020.csv"
shell rm -r "data_download_file_reference_2021.csv"
shell rm -r "IHME_COVID_19_Data_Release_Information_Sheet.pdf"
shell rm -r "data_download_file_reference_2020.dta"
shell rm -r "data_download_file_reference_2021.dta"

shell rm -r "data_download_file_severe_omicron_2020.csv"
shell rm -r "data_download_file_severe_omicron_2021.csv"
shell rm -r "data_download_file_third_dose_2020.csv"
shell rm -r "data_download_file_third_dose_2021.csv"
shell rm -r "data_download_file_reduce_hesitancy_2020.csv"
shell rm -r "data_download_file_reduce_hesitancy_2021.csv"



***





* update 20220121 epoch

use "IHME 20220121.dta", clear

// br date DayDeaMeSmA0220220121 daily_deaths_unscaled
gen epoch = td(19Jan2022)
di td(19Jan2022)
label var epoch "Forecast start date"
local epoch = epoch


twoway ///
(line daily_deaths_unscaled date, sort lwidth(medium) lcolor(black)) /// 	
(line DayDeaMeSmA0220220121 date, sort lwidth(medium) lcolor(gold)) /// 	
if date >= td(01Jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, $country, National, IHME, update 20220121", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
xline(22664, lwidth(thin) lcolor(red)) ///
subtitle("Forecast start date is denoted with red line: 19Jan2022") ///
legend(order(1 "Daily deaths unscaled" 2 "Daily deaths reference scenario smooth") size(small))


qui graph export "graph $country IHME epoch update 20220121.pdf", replace
		
drop daily_deaths_unscaled
rename epoch epoch20220121

save "IHME 20220121.dta", replace

*















**********************************************
**********************************************
**********************************************

* Iran update 2022 No. 4
* linkdate		download		urldate
* Feb 4, 2022	ihme-covid19	2022-02-04
* filename: data_download_file_reference_2020.csv and data_download_file_reference_2021.csv
* and data_download_file_reference_2022.csv
		

di in red "This is urldate 2022-02-04, linkdate Feb 4, 2022"

*****************************

* get IHME estimates

copy https://ihmecovid19storage.blob.core.windows.net/archive/2022-02-04/ihme-covid19.zip ihme-covid19.zip
unzipfile ihme-covid19.zip, replace
erase ihme-covid19.zip


******************************

* import csv files

import delimited using data_download_file_reference_2020.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2020.dta, replace

import delimited using data_download_file_reference_2021.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2021.dta, replace

import delimited using data_download_file_reference_2022.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2022.dta, replace


******************************

* gen scenario dta files

use "data_download_file_reference_2020.dta", clear 

local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2020.dta", replace 



use "data_download_file_reference_2021.dta", clear 


local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2021.dta", replace 





use "data_download_file_reference_2022.dta", clear 


local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2022.dta", replace 



append using "data_download_file_reference_2020.dta"

append using "data_download_file_reference_2021.dta"




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

* Daily Deaths smoothed
rename seir_daily_unscaled_mean  DayDeaMeSmA02S01
label var DayDeaMeSmA02S01 "Daily Deaths Mean smoothed IHME S1" // Daily reported deaths (mean estimate)
		

rename location_name provincestate

gen loc_grand_name = "$country"

replace provincestate = " National" if provincestate == "$country"



keep date loc_grand_name provincestate DayDeaMeSmA02S01 daily_deaths_unscaled

order date loc_grand_name provincestate DayDeaMeSmA02S01

sort loc_grand_name provincestate date


rename (DayDeaMeSmA02S01) (DayDeaMeSmA0220220204)




qui compress

save "IHME 20220204.dta", replace



shell rm -r "data_dictionary.csv"
shell rm -r "data_download_file_best_masks_2020.csv"
shell rm -r "data_download_file_best_masks_2021.csv"
shell rm -r "data_download_file_reference_2020.csv"
shell rm -r "data_download_file_reference_2021.csv"
shell rm -r "IHME_COVID_19_Data_Release_Information_Sheet.pdf"
shell rm -r "data_download_file_reference_2020.dta"
shell rm -r "data_download_file_reference_2021.dta"

shell rm -r "data_download_file_severe_omicron_2020.csv"
shell rm -r "data_download_file_severe_omicron_2021.csv"
shell rm -r "data_download_file_third_dose_2020.csv"
shell rm -r "data_download_file_third_dose_2021.csv"
shell rm -r "data_download_file_reduce_hesitancy_2020.csv"
shell rm -r "data_download_file_reduce_hesitancy_2021.csv"



***





* update 20220204 epoch

use "IHME 20220204.dta", clear

// br date DayDeaMeSmA0220220204 daily_deaths_unscaled
gen epoch = td(01Feb2022)
di td(01Feb2022)
label var epoch "Forecast start date"
local epoch = epoch


twoway ///
(line daily_deaths_unscaled date, sort lwidth(medium) lcolor(black)) /// 	
(line DayDeaMeSmA0220220204 date, sort lwidth(medium) lcolor(gold)) /// 	
if date >= td(01Jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, $country, National, IHME, update 20220204", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
xline(22677, lwidth(thin) lcolor(red)) ///
subtitle("Forecast start date is denoted with red line: 01Feb2022") ///
legend(order(1 "Daily deaths unscaled" 2 "Daily deaths reference scenario smooth") size(small))


qui graph export "graph $country IHME epoch update 20220204.pdf", replace
		
drop daily_deaths_unscaled
rename epoch epoch20220204

save "IHME 20220204.dta", replace

*













**********************************************
**********************************************
**********************************************

* Iran update 2022 No. 5
* linkdate		download		urldate
* Feb 18, 2022	ihme-covid19	2022-02-18
* filename: data_download_file_reference_2020.csv and data_download_file_reference_2021.csv
* and data_download_file_reference_2022.csv
		

di in red "This is urldate 2022-02-18, linkdate Feb 18, 2022"

*****************************

* get IHME estimates

copy https://ihmecovid19storage.blob.core.windows.net/archive/2022-02-18/ihme-covid19.zip ihme-covid19.zip
unzipfile ihme-covid19.zip, replace
erase ihme-covid19.zip


******************************

* import csv files

import delimited using data_download_file_reference_2020.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2020.dta, replace

import delimited using data_download_file_reference_2021.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2021.dta, replace

import delimited using data_download_file_reference_2022.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2022.dta, replace


******************************

* gen scenario dta files

use "data_download_file_reference_2020.dta", clear 

local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2020.dta", replace 



use "data_download_file_reference_2021.dta", clear 


local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2021.dta", replace 





use "data_download_file_reference_2022.dta", clear 


local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2022.dta", replace 



append using "data_download_file_reference_2020.dta"

append using "data_download_file_reference_2021.dta"




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

* Daily Deaths smoothed
rename seir_daily_unscaled_mean  DayDeaMeSmA02S01
label var DayDeaMeSmA02S01 "Daily Deaths Mean smoothed IHME S1" // Daily reported deaths (mean estimate)
		

rename location_name provincestate

gen loc_grand_name = "$country"

replace provincestate = " National" if provincestate == "$country"



keep date loc_grand_name provincestate DayDeaMeSmA02S01 daily_deaths_unscaled

order date loc_grand_name provincestate DayDeaMeSmA02S01

sort loc_grand_name provincestate date


rename (DayDeaMeSmA02S01) (DayDeaMeSmA0220220218)




qui compress

save "IHME 20220218.dta", replace



shell rm -r "data_dictionary.csv"
shell rm -r "data_download_file_best_masks_2020.csv"
shell rm -r "data_download_file_best_masks_2021.csv"
shell rm -r "data_download_file_reference_2020.csv"
shell rm -r "data_download_file_reference_2021.csv"
shell rm -r "IHME_COVID_19_Data_Release_Information_Sheet.pdf"
shell rm -r "data_download_file_reference_2020.dta"
shell rm -r "data_download_file_reference_2021.dta"

shell rm -r "data_download_file_severe_omicron_2020.csv"
shell rm -r "data_download_file_severe_omicron_2021.csv"
shell rm -r "data_download_file_third_dose_2020.csv"
shell rm -r "data_download_file_third_dose_2021.csv"
shell rm -r "data_download_file_reduce_hesitancy_2020.csv"
shell rm -r "data_download_file_reduce_hesitancy_2021.csv"



***





* update 20220218 epoch

use "IHME 20220218.dta", clear

// br date DayDeaMeSmA0220220218 daily_deaths_unscaled
gen epoch = td(15Feb2022)
di td(15Feb2022)
label var epoch "Forecast start date"
local epoch = epoch


twoway ///
(line daily_deaths_unscaled date, sort lwidth(medium) lcolor(black)) /// 	
(line DayDeaMeSmA0220220218 date, sort lwidth(medium) lcolor(gold)) /// 	
if date >= td(01Jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, $country, National, IHME, update 20220218", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
xline(22691, lwidth(thin) lcolor(red)) ///
subtitle("Forecast start date is denoted with red line: 15Feb2022") ///
legend(order(1 "Daily deaths unscaled" 2 "Daily deaths reference scenario smooth") size(small))


qui graph export "graph $country IHME epoch update 20220218.pdf", replace
		
drop daily_deaths_unscaled
rename epoch epoch20220218

save "IHME 20220218.dta", replace

*














**********************************************
**********************************************
**********************************************

* Iran update 2022 No. 6
* linkdate		download		urldate
* Mar 21, 2022	ihme-covid19	2022-03-22
* filename: data_download_file_reference_2020.csv and data_download_file_reference_2021.csv
* and data_download_file_reference_2022.csv
		

di in red "This is urldate 2022-03-22, linkdate Mar 21, 2022"

*****************************

* get IHME estimates

copy https://ihmecovid19storage.blob.core.windows.net/archive/2022-03-22/ihme-covid19.zip ihme-covid19.zip
unzipfile ihme-covid19.zip, replace
erase ihme-covid19.zip


******************************

* import csv files

import delimited using data_download_file_reference_2020.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2020.dta, replace

import delimited using data_download_file_reference_2021.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2021.dta, replace

import delimited using data_download_file_reference_2022.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2022.dta, replace


******************************

* gen scenario dta files

use "data_download_file_reference_2020.dta", clear 

local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2020.dta", replace 



use "data_download_file_reference_2021.dta", clear 


local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2021.dta", replace 





use "data_download_file_reference_2022.dta", clear 


local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2022.dta", replace 



append using "data_download_file_reference_2020.dta"

append using "data_download_file_reference_2021.dta"




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

* Daily Deaths smoothed
rename seir_daily_unscaled_mean  DayDeaMeSmA02S01
label var DayDeaMeSmA02S01 "Daily Deaths Mean smoothed IHME S1" // Daily reported deaths (mean estimate)
		

rename location_name provincestate

gen loc_grand_name = "$country"

replace provincestate = " National" if provincestate == "$country"



keep date loc_grand_name provincestate DayDeaMeSmA02S01 daily_deaths_unscaled

order date loc_grand_name provincestate DayDeaMeSmA02S01

sort loc_grand_name provincestate date


rename (DayDeaMeSmA02S01) (DayDeaMeSmA0220220321)




qui compress

save "IHME 20220321.dta", replace



shell rm -r "data_dictionary.csv"
shell rm -r "data_download_file_best_masks_2020.csv"
shell rm -r "data_download_file_best_masks_2021.csv"
shell rm -r "data_download_file_reference_2020.csv"
shell rm -r "data_download_file_reference_2021.csv"
shell rm -r "IHME_COVID_19_Data_Release_Information_Sheet.pdf"
shell rm -r "data_download_file_reference_2020.dta"
shell rm -r "data_download_file_reference_2021.dta"

shell rm -r "data_download_file_severe_omicron_2020.csv"
shell rm -r "data_download_file_severe_omicron_2021.csv"
shell rm -r "data_download_file_third_dose_2020.csv"
shell rm -r "data_download_file_third_dose_2021.csv"
shell rm -r "data_download_file_reduce_hesitancy_2020.csv"
shell rm -r "data_download_file_reduce_hesitancy_2021.csv"



***





* update 20220321 epoch

use "IHME 20220321.dta", clear

// br date DayDeaMeSmA0220220321 daily_deaths_unscaled
gen epoch = td(15Mar2022)
di td(15Mar2022)
label var epoch "Forecast start date"
local epoch = epoch


twoway ///
(line daily_deaths_unscaled date, sort lwidth(medium) lcolor(black)) /// 	
(line DayDeaMeSmA0220220321 date, sort lwidth(medium) lcolor(gold)) /// 	
if date >= td(01Jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, $country, National, IHME, update 20220321", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
xline(22719, lwidth(thin) lcolor(red)) ///
subtitle("Forecast start date is denoted with red line: 15Mar2022") ///
legend(order(1 "Daily deaths unscaled" 2 "Daily deaths reference scenario smooth") size(small))


qui graph export "graph $country IHME epoch update 20220321.pdf", replace
		
drop daily_deaths_unscaled
rename epoch epoch20220321

save "IHME 20220321.dta", replace

*













**********************************************
**********************************************
**********************************************

* Iran update 2022 No. 7
* linkdate		download		urldate
* Apr 8, 2022	ihme-covid19	2022-04-08
* filename: data_download_file_reference_2020.csv and data_download_file_reference_2021.csv
* and data_download_file_reference_2022.csv
		

di in red "This is urldate 2022-04-08, linkdate Apr 8, 2022"

*****************************

* get IHME estimates

copy https://ihmecovid19storage.blob.core.windows.net/archive/2022-04-08/ihme-covid19.zip ihme-covid19.zip
unzipfile ihme-covid19.zip, replace
erase ihme-covid19.zip


******************************

* import csv files

import delimited using data_download_file_reference_2020.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2020.dta, replace

import delimited using data_download_file_reference_2021.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2021.dta, replace

import delimited using data_download_file_reference_2022.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2022.dta, replace


******************************

* gen scenario dta files

use "data_download_file_reference_2020.dta", clear 

local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2020.dta", replace 



use "data_download_file_reference_2021.dta", clear 


local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2021.dta", replace 





use "data_download_file_reference_2022.dta", clear 


local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2022.dta", replace 



append using "data_download_file_reference_2020.dta"

append using "data_download_file_reference_2021.dta"




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

* Daily Deaths smoothed
rename seir_daily_unscaled_mean  DayDeaMeSmA02S01
label var DayDeaMeSmA02S01 "Daily Deaths Mean smoothed IHME S1" // Daily reported deaths (mean estimate)
		

rename location_name provincestate

gen loc_grand_name = "$country"

replace provincestate = " National" if provincestate == "$country"



keep date loc_grand_name provincestate DayDeaMeSmA02S01 daily_deaths_unscaled

order date loc_grand_name provincestate DayDeaMeSmA02S01

sort loc_grand_name provincestate date


rename (DayDeaMeSmA02S01) (DayDeaMeSmA0220220408)




qui compress

save "IHME 20220408.dta", replace



shell rm -r "data_dictionary.csv"
shell rm -r "data_download_file_best_masks_2020.csv"
shell rm -r "data_download_file_best_masks_2021.csv"
shell rm -r "data_download_file_reference_2020.csv"
shell rm -r "data_download_file_reference_2021.csv"
shell rm -r "IHME_COVID_19_Data_Release_Information_Sheet.pdf"
shell rm -r "data_download_file_reference_2020.dta"
shell rm -r "data_download_file_reference_2021.dta"

shell rm -r "data_download_file_severe_omicron_2020.csv"
shell rm -r "data_download_file_severe_omicron_2021.csv"
shell rm -r "data_download_file_third_dose_2020.csv"
shell rm -r "data_download_file_third_dose_2021.csv"
shell rm -r "data_download_file_reduce_hesitancy_2020.csv"
shell rm -r "data_download_file_reduce_hesitancy_2021.csv"



***





* update 20220408 epoch

use "IHME 20220408.dta", clear

// br date DayDeaMeSmA0220220408 daily_deaths_unscaled
gen epoch = td(05Apr2022)
di td(05Apr2022)
label var epoch "Forecast start date"
local epoch = epoch


twoway ///
(line daily_deaths_unscaled date, sort lwidth(medium) lcolor(black)) /// 	
(line DayDeaMeSmA0220220408 date, sort lwidth(medium) lcolor(gold)) /// 	
if date >= td(01Jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, $country, National, IHME, update 20220408", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
xline(22740, lwidth(thin) lcolor(red)) ///
subtitle("Forecast start date is denoted with red line: 05Apr2022") ///
legend(order(1 "Daily deaths unscaled" 2 "Daily deaths reference scenario smooth") size(small))


qui graph export "graph $country IHME epoch update 20220408.pdf", replace
		
drop daily_deaths_unscaled
rename epoch epoch20220408

save "IHME 20220408.dta", replace

*











**********************************************
**********************************************
**********************************************

* Iran update 2022 No. 8
* linkdate		download		urldate
* May 6, 2022	ihme-covid19	2022-05-18
* filename: data_download_file_reference_2020.csv and data_download_file_reference_2021.csv
* and data_download_file_reference_2022.csv
		

di in red "This is urldate 2022-05-18, linkdate May 6, 2022"

*****************************

* get IHME estimates

copy https://ihmecovid19storage.blob.core.windows.net/archive/2022-05-18/ihme-covid19.zip ihme-covid19.zip
unzipfile ihme-covid19.zip, replace
erase ihme-covid19.zip


******************************

* import csv files

import delimited using data_download_file_reference_2020.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2020.dta, replace

import delimited using data_download_file_reference_2021.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2021.dta, replace

import delimited using data_download_file_reference_2022.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2022.dta, replace


******************************

* gen scenario dta files

use "data_download_file_reference_2020.dta", clear 

local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2020.dta", replace 



use "data_download_file_reference_2021.dta", clear 


local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2021.dta", replace 





use "data_download_file_reference_2022.dta", clear 


local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2022.dta", replace 



append using "data_download_file_reference_2020.dta"

append using "data_download_file_reference_2021.dta"




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

* Daily Deaths smoothed
rename seir_daily_unscaled_mean  DayDeaMeSmA02S01
label var DayDeaMeSmA02S01 "Daily Deaths Mean smoothed IHME S1" // Daily reported deaths (mean estimate)
		

rename location_name provincestate

gen loc_grand_name = "$country"

replace provincestate = " National" if provincestate == "$country"



keep date loc_grand_name provincestate DayDeaMeSmA02S01 daily_deaths_unscaled

order date loc_grand_name provincestate DayDeaMeSmA02S01

sort loc_grand_name provincestate date


rename (DayDeaMeSmA02S01) (DayDeaMeSmA0220220506)




qui compress

save "IHME 20220506.dta", replace



shell rm -r "data_dictionary.csv"
shell rm -r "data_download_file_best_masks_2020.csv"
shell rm -r "data_download_file_best_masks_2021.csv"
shell rm -r "data_download_file_reference_2020.csv"
shell rm -r "data_download_file_reference_2021.csv"
shell rm -r "IHME_COVID_19_Data_Release_Information_Sheet.pdf"
shell rm -r "data_download_file_reference_2020.dta"
shell rm -r "data_download_file_reference_2021.dta"

shell rm -r "data_download_file_severe_omicron_2020.csv"
shell rm -r "data_download_file_severe_omicron_2021.csv"
shell rm -r "data_download_file_third_dose_2020.csv"
shell rm -r "data_download_file_third_dose_2021.csv"
shell rm -r "data_download_file_reduce_hesitancy_2020.csv"
shell rm -r "data_download_file_reduce_hesitancy_2021.csv"



***





* update 20220506 epoch

use "IHME 20220506.dta", clear

// br date DayDeaMeSmA0220220506 daily_deaths_unscaled
gen epoch = td(03May2022)
di td(03May2022)
label var epoch "Forecast start date"
local epoch = epoch


twoway ///
(line daily_deaths_unscaled date, sort lwidth(medium) lcolor(black)) /// 	
(line DayDeaMeSmA0220220506 date, sort lwidth(medium) lcolor(gold)) /// 	
if date >= td(01Jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, $country, National, IHME, update 20220506", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
xline(22768, lwidth(thin) lcolor(red)) ///
subtitle("Forecast start date is denoted with red line: 03May2022") ///
legend(order(1 "Daily deaths unscaled" 2 "Daily deaths reference scenario smooth") size(small))


qui graph export "graph $country IHME epoch update 20220506.pdf", replace
		
drop daily_deaths_unscaled
rename epoch epoch20220506

save "IHME 20220506.dta", replace

*










**********************************************
**********************************************
**********************************************

* Iran update 2022 No. 9
* linkdate		download		urldate
* Jun 10, 2022	ihme-covid19	2022-06-10
* filename: data_download_file_reference_2020.csv and data_download_file_reference_2021.csv
* and data_download_file_reference_2022.csv
		

di in red "This is urldate 2022-06-10, linkdate Jun 10, 2022"

*****************************

* get IHME estimates

copy https://ihmecovid19storage.blob.core.windows.net/archive/2022-06-10/ihme-covid19.zip ihme-covid19.zip
unzipfile ihme-covid19.zip, replace
erase ihme-covid19.zip


******************************

* import csv files

import delimited using data_download_file_reference_2020.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2020.dta, replace

import delimited using data_download_file_reference_2021.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2021.dta, replace

import delimited using data_download_file_reference_2022.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1 
replace location_name = "Iran" if regexm(location_name,"$country") == 1
save data_download_file_reference_2022.dta, replace


******************************

* gen scenario dta files

use "data_download_file_reference_2020.dta", clear 

local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2020.dta", replace 



use "data_download_file_reference_2021.dta", clear 


local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2021.dta", replace 





use "data_download_file_reference_2022.dta", clear 


local varlist reff_mean reff_lower reff_upper infection_fatality infection_detection infection_hospitalization

foreach v of local varlist {
	capture confirm numeric variable `v'
    if !_rc {
		di "`v'" " is numeric"
    }
    else {
		di "`v'" " contains string"
		replace `v' = "." if `v' == "Inf"
		destring `v', replace 
    }
}
*

save "data_download_file_reference_2022.dta", replace 



append using "data_download_file_reference_2020.dta"

append using "data_download_file_reference_2021.dta"




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

* Daily Deaths smoothed
rename seir_daily_unscaled_mean  DayDeaMeSmA02S01
label var DayDeaMeSmA02S01 "Daily Deaths Mean smoothed IHME S1" // Daily reported deaths (mean estimate)
		

rename location_name provincestate

gen loc_grand_name = "$country"

replace provincestate = " National" if provincestate == "$country"



keep date loc_grand_name provincestate DayDeaMeSmA02S01 daily_deaths_unscaled

order date loc_grand_name provincestate DayDeaMeSmA02S01

sort loc_grand_name provincestate date


rename (DayDeaMeSmA02S01) (DayDeaMeSmA0220220610)




qui compress

save "IHME 20220610.dta", replace



shell rm -r "data_dictionary.csv"
shell rm -r "data_download_file_best_masks_2020.csv"
shell rm -r "data_download_file_best_masks_2021.csv"
shell rm -r "data_download_file_reference_2020.csv"
shell rm -r "data_download_file_reference_2021.csv"
shell rm -r "IHME_COVID_19_Data_Release_Information_Sheet.pdf"
shell rm -r "data_download_file_reference_2020.dta"
shell rm -r "data_download_file_reference_2021.dta"

shell rm -r "data_download_file_severe_omicron_2020.csv"
shell rm -r "data_download_file_severe_omicron_2021.csv"
shell rm -r "data_download_file_third_dose_2020.csv"
shell rm -r "data_download_file_third_dose_2021.csv"
shell rm -r "data_download_file_reduce_hesitancy_2020.csv"
shell rm -r "data_download_file_reduce_hesitancy_2021.csv"



***





* update 20220610 epoch

use "IHME 20220610.dta", clear

// br date DayDeaMeSmA0220220610 daily_deaths_unscaled
gen epoch = td(07Jun2022)
di td(07Jun2022)
label var epoch "Forecast start date"
local epoch = epoch


twoway ///
(line daily_deaths_unscaled date, sort lwidth(medium) lcolor(black)) /// 	
(line DayDeaMeSmA0220220610 date, sort lwidth(medium) lcolor(gold)) /// 	
if date >= td(01Jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, $country, National, IHME, update 20220610", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
xline(22803, lwidth(thin) lcolor(red)) ///
subtitle("Forecast start date is denoted with red line: 07Jun2022") ///
legend(order(1 "Daily deaths unscaled" 2 "Daily deaths reference scenario smooth") size(small))


qui graph export "graph $country IHME epoch update 20220610.pdf", replace
		
drop daily_deaths_unscaled
rename epoch epoch20220610

save "IHME 20220610.dta", replace

*









**********************

view "log country IHME 1.smcl"

log close

exit, clear
