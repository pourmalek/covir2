

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
* To change update date, find and replace all, 2021-10-15 (old), with 2021-10-15 (new) <<--       <<<--- * change update date here *
                                                                                                         ***************************


																									 
clear 
 
*****************************

* get IHME estimates

* URLs as of  2021-10-15

copy https://ihmecovid19storage.blob.core.windows.net/latest/data_download_file_reference_2020.csv data_download_file_reference_2020.csv 
copy https://ihmecovid19storage.blob.core.windows.net/latest/data_download_file_reference_2021.csv data_download_file_reference_2021.csv 
copy https://ihmecovid19storage.blob.core.windows.net/latest/data_download_file_best_masks_2020.csv data_download_file_best_masks_2020.csv 
copy https://ihmecovid19storage.blob.core.windows.net/latest/data_download_file_best_masks_2021.csv data_download_file_best_masks_2021.csv 
copy https://ihmecovid19storage.blob.core.windows.net/latest/data_download_file_worse_2020.csv data_download_file_worse_2020.csv
copy https://ihmecovid19storage.blob.core.windows.net/latest/data_download_file_worse_2021.csv data_download_file_worse_2021.csv
copy https://ihmecovid19storage.blob.core.windows.net/latest/data_dictionary.csv data_dictionary.csv 
copy https://ihmecovid19storage.blob.core.windows.net/latest/IHME_COVID_19_Data_Release_Information_Sheet.pdf IHME_COVID_19_Data_Release_Information_Sheet.pdf 
copy https://ihmecovid19storage.blob.core.windows.net/latest/sha256sums.txt sha256sums.txt

******************************

* import csv files



import delimited using data_download_file_reference_2020.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1
save data_download_file_reference_2020.dta, replace

import delimited using data_download_file_reference_2021.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1
save data_download_file_reference_2021.dta, replace



	
import delimited using data_download_file_best_masks_2020.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1
save data_download_file_best_masks_2020.dta, replace

import delimited using data_download_file_best_masks_2021.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1
save data_download_file_best_masks_2021.dta, replace

	
	
import delimited using data_download_file_worse_2020.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1
save data_download_file_worse_2020.dta, replace

import delimited using data_download_file_worse_2021.csv, clear varnames(1)
keep if regexm(location_name,"$country") == 1
save data_download_file_worse_2021.dta, replace



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

save "data_download_file_reference_2020_21.dta", replace

*

use "data_download_file_best_masks_2020.dta", clear

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

save "data_download_file_best_masks_2020.dta", replace



use "data_download_file_best_masks_2021.dta", clear

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

save "data_download_file_best_masks_2021.dta", replace

append using "data_download_file_best_masks_2020.dta"

save "data_download_file_best_masks_2020_21.dta", replace

*

use "data_download_file_worse_2020.dta", clear 

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

save "data_download_file_worse_2020.dta", replace 



use "data_download_file_worse_2021.dta", clear 

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

save "data_download_file_worse_2021.dta", replace 

append using "data_download_file_worse_2020.dta"

save "data_download_file_worse_2020_21.dta", replace




******************************

* read scenario files


/*
Scenarios:

S1 Reference [Current projection] version_name = "reference"
S2 Best [Universal masks]         version_name = "best_masks"
S3 Worse [Mandates easing]		  version_name = "worse"
*/



/*

data_dictionary.csv

variable								description

version_name							Scenario version (reference, worse, best_masks)

inf_mean								Daily infections (mean estimate)
inf_upper								Daily infections (upper 95% confidence interval)
inf_lower								Daily infections (lower 95% confidence interval)
seir_cumulative_mean					Cumulative excess deaths (mean estimate)
seir_cumulative_lower					Cumulative excess deaths (lower 95% confidence interval)
seir_cumulative_upper					Cumulative excess deaths (upper 95% confidence interval)
inf_cuml_mean							Cumulative infections (mean estimate)
inf_cuml_lower							Cumulative infections (lower 95% confidence interval)
inf_cuml_upper							Cumulative infections (upper 95% confidence interval)
seir_daily_mean							Daily excess deaths (mean estimate)
seir_daily_lower						Daily excess deaths (lower 95% confidence interval)
seir_daily_upper						Daily excess deaths upper 95% confidence interval)
seir_daily_unscaled_mean				Daily reported deaths (mean estimate)
seir_daily_unscaled_lower				Daily reported deaths (lower 95% confidence interval)
seir_daily_unscaled_upper				Daily reported deaths upper 95% confidence interval)
seir_cumulative_unscaled_mean			Cumulative reported deaths (mean estimate)
seir_cumulative_unscaled_lower			Cumulative reported deaths (lower 95% confidence interval)
seir_cumulative_unscaled_upper			Cumulative reported deaths (upper 95% confidence interval)

reff_mean								R effective (mean estimate)
reff_lower								R effective (lower 95% confidence interval)
reff_upper								R effective (upper 95% confidence interval)


cumulative_cases						Cumulative cases (raw data)
cumulative_deaths						Cumulative deaths (raw data with excess mortality scalar applied)
cumulative_hospitalizations				Cumulative hospitalizations (raw data)
daily_deaths							Daily deaths (raw data with excess mortality scalar applied)
daily_infections						Daily infections (raw data)
cumulative_deaths_unscaled				Cumulative deaths (raw data without excess mortality scalar applied)
daily_deaths_unscaled					Daily deaths (raw data without excess mortality scalar applied)

infection_fatality						Infection fatality ratio
infection_detection						Infection detection ratio
infection_hospitalization				Infection hospitalization ratio



IDENTICAL ACROSS SCENARIOS:

date									Date of projection

location_name							Location name
location_id								Location ID code

population								Population size
mobility_mean							Percent change in mobility from baseline (mean)
mobility_obs							Indicator for whether mobility estimate comes from observed data (1) or modelled estimates (0)
testing_mean							Tests per 100,000 (mean estimate)
testing_lower							Tests per 100,000 (lower 95% confidence interval)
testing_upper							Tests per 100,000 (upper 95% confidence interval)
testing_obs								Indicator for whether testing estimate comes from observed data (1) or modelled estimates (0)
pneumonia_mean							Ratio of pneumonia deaths in a given week to the average weekly pneumonia deaths by location
pneumonia_obs							Indicator for whether pneumonia estimate comes from observed data (1) or modelled estimates (0)
mask_use_mean							Percent of population reporting always wearing a mask when leaving home
mask_use_obs							Indicator for whether mask estimate comes from observed data (1) or modelled estimates (0)
cumulative_all_vaccinated				Initially vaccinated (one dose of two doses)
cumulative_all_effectively_vaccinated	Effectively vaccinated (one and two dose with efficacy)
cumulative_all_fully_vaccinated			Fully vaccinated (one of one and†two†of two doses)
hospital_beds_mean						Daily COVID-19 hospital beds needed (mean estimate)
hospital_beds_upper						Daily COVID-19 hospital beds needed (upper 95% confidence interval)
hospital_beds_lower						Daily COVID-19 hospital beds needed (lower 95% confidence interval)
icu_beds_mean							Daily COVID-19 ICU beds needed (mean estimate)
icu_beds_upper							Daily COVID-19 ICU beds needed (upper 95% confidence interval)
icu_beds_lower							Daily COVID-19 ICU beds needed (lower 95% confidence interval)
admis_mean								Daily COVID-19 hospital admissions (mean estimate)
admis_upper								Daily COVID-19 hospital admissions (mean estimate)
admis_lower								Daily COVID-19 hospital admissions (mean estimate)
all_bed_capacity						Total number of beds that exist at a location
icu_bed_capacity						Total number of ICU beds that exist at a location


BY DEFINITION, THE FOLLOWING VARIABLES SHOULD NOT BE IDENTICAL ACROSS SCENARIOS:

mobility_mean

mask_use_mean

hospital_beds_mean
hospital_beds_upper
hospital_beds_lower
icu_beds_mean
icu_beds_upper
icu_beds_lower
admis_mean
admis_upper
admis_lower

infection_fatality						Infection fatality ratio
infection_detection						Infection detection ratio
infection_hospitalization				Infection hospitalization ratio

*/

**********************

* S1 Reference

use "data_download_file_reference_2020_21.dta", clear

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

* Total Reported Deaths smoothed
rename seir_cumulative_unscaled_mean  TotDeaMeSmA02S01
rename seir_cumulative_unscaled_lower TotDeaLoSmA02S01
rename seir_cumulative_unscaled_upper TotDeaUpSmA02S01
label var TotDeaMeSmA02S01 "Total Reported Deaths Mean smoothed IHME S1" // Cumulative reported deaths (mean estimate)
label var TotDeaLoSmA02S01 "Total Reported Deaths Lower smoothed IHME S1" // Cumulative reported deaths (lower 95% confidence interval)
label var TotDeaUpSmA02S01 "Total Reported Deaths Upper smoothed IHME S1" // Cumulative reported deaths (upper 95% confidence interval)

* Total Excess Deaths smoothed
rename seir_cumulative_mean  TotDeXMeSmA02S01
rename seir_cumulative_lower TotDeXLoSmA02S01
rename seir_cumulative_upper TotDeXUpSmA02S01
label var TotDeXMeSmA02S01 "Total Excess Deaths Mean smoothed IHME S1" // Cumulative excess deaths (mean estimate)
label var TotDeXLoSmA02S01 "Total Excess Deaths Lower smoothed IHME S1" // Cumulative excess deaths (lower 95% confidence interval)
label var TotDeXUpSmA02S01 "Total Excess Deaths Upper smoothed IHME S1" // Cumulative excess deaths (upper 95% confidence interval)

* Daily Reported Deaths smoothed
rename seir_daily_unscaled_mean  DayDeaMeSmA02S01
rename seir_daily_unscaled_lower DayDeaLoSmA02S01
rename seir_daily_unscaled_upper DayDeaUpSmA02S01
label var DayDeaMeSmA02S01 "Daily Reported Deaths Mean smoothed IHME S1" // Daily reported deaths (mean estimate)
label var DayDeaLoSmA02S01 "Daily Reported Deaths Lower smoothed IHME S1" // Daily reported deaths (lower 95% confidence interval)
label var DayDeaUpSmA02S01 "Daily Reported Deaths Upper smoothed IHME S1" // Daily reported deaths upper 95% confidence interval)
	
* Daily Excess Deaths smoothed
rename seir_daily_mean  DayDeXMeSmA02S01
rename seir_daily_lower DayDeXLoSmA02S01
rename seir_daily_upper DayDeXUpSmA02S01
label var DayDeXMeSmA02S01 "Daily Excess Deaths Mean smoothed IHME S1" // Daily excess deaths (mean estimate)
label var DayDeXLoSmA02S01 "Daily Excess Deaths Lower smoothed IHME S1" // Daily excess deaths (lower 95% confidence interval)
label var DayDeXUpSmA02S01 "Daily Excess Deaths Upper smoothed IHME S1" // Daily excess deaths upper 95% confidence interval)
		
* Total infections smoothed
rename inf_cuml_mean  TotINFMeSmA02S01
rename inf_cuml_lower TotINFLoSmA02S01
rename inf_cuml_upper TotINFUpSmA02S01
label var TotINFMeSmA02S01 "Total infections Mean smoothed IHME S1" // Cumulative infections (mean estimate)
label var TotINFLoSmA02S01 "Total infections Lower smoothed IHME S1" // Cumulative infections (lower 95% confidence interval)
label var TotINFUpSmA02S01 "Total infections Upper smoothed IHME S1" // Cumulative infections (upper 95% confidence interval)

* Daily infections smoothed
rename inf_mean  DayINFMeSmA02S01 // previously est_infections_mean
rename inf_lower DayINFLoSmA02S01 // previously est_infections_lower
rename inf_upper DayINFUpSmA02S01 // previously est_infections_upper
label var DayINFMeSmA02S01 "Daily infections Mean smoothed IHME S1" // Daily infections (mean estimate)
label var DayINFLoSmA02S01 "Daily infections Lower smoothed IHME S1" // Daily infections (lower 95% confidence interval)
label var DayINFUpSmA02S01 "Daily infections Upper smoothed IHME S1" // Daily infections (upper 95% confidence interval)





* other variables 

rename reff_mean reff_mean_A02S01
rename reff_lower reff_lower_A02S01
rename reff_upper reff_upper_A02S01
label var reff_mean_A02S01 "IHME R effective (mean estimate) S1"
label var reff_lower_A02S01 "IHME R effective (lower 95% confidence interval) S1"
label var reff_upper_A02S01 "IHME R effective (upper 95% confidence interval) S1"

rename cumulative_cases cumulative_cases_A02S01
rename cumulative_deaths cumulative_deaths_A02S01
rename cumulative_hospitalizations cumulative_hosp_A02S01
rename daily_deaths daily_deaths_A02S01
rename daily_infections daily_infections_A02S01
rename cumulative_deaths_unscaled cumul_deaths_unscaled_A02S01
rename daily_deaths_unscaled dai_dea_unscaled_A02S01
label var cumulative_cases_A02S01 "IHME Cumulative cases (raw data) S1"
label var cumulative_deaths_A02S01 "IHME Cumulative deaths (raw data with excess mortality scalar applied) S1"
label var cumulative_hosp_A02S01 "IHME Cumulative hospitalizations (raw data) S1"
label var daily_deaths_A02S01 "IHME Daily deaths (raw data with excess mortality scalar applied) S1"
label var daily_infections_A02S01 "IHME Daily infections (raw data)"
label var cumul_deaths_unscaled_A02S01 "IHME umulative deaths (raw data without excess mortality scalar applied) S1"
label var dai_dea_unscaled_A02S01 "IHME Daily deaths (raw data without excess mortality scalar applied) S1"

rename daily_infections dai_inf_A02S01
label var dai_inf_A02S01 "IHME Daily infections (raw data without excess mortality scalar applied)" // present in data, not present in data_dictionary.csv





* IDENTICAL ACROSS SCENARIOS:

label var population "IHME Population size"
label var mobility_obs "IHME Indicator for whether mobility estimate comes from observed data (1) or modelled estimates (0)"
label var testing_mean "IHME Tests per 100,000 (mean estimate)"
label var testing_lower "IHME Tests per 100,000 (lower 95% confidence interval)"
label var testing_upper "IHME Tests per 100,000 (upper 95% confidence interval)"
label var testing_obs "IHME Indicator for whether testing estimate comes from observed data (1) or modelled estimates (0)"
label var pneumonia_mean "IHME Ratio of pneumonia deaths in a given week to the average weekly pneumonia deaths by location"
label var pneumonia_obs "IHME Indicator for whether pneumonia estimate comes from observed data (1) or modelled estimates (0)"
label var mask_use_obs "IHME Indicator for whether mask estimate comes from observed data (1) or modelled estimates (0)"
label var cumulative_all_vaccinated	"IHME Initially vaccinated (one dose of two doses)"
label var cumulative_all_effectively_vacci "IHME Effectively vaccinated (one and two dose with efficacy)" // cumulative_all_effectively_vaccinated
label var cumulative_all_fully_vaccinated "IHME Fully vaccinated (one of one and†two†of two doses)"

label var all_bed_capacity "IHME Total number of beds that exist at a location"
label var icu_bed_capacity "IHME Total number of ICU beds that exist at a location"


/*
BY DEFINITION, THE FOLLOWING VARIABLES SHOULD NOT BE IDENTICAL ACROSS SCENARIOS:

mobility_mean

mask_use_mean

hospital_beds_mean
hospital_beds_upper
hospital_beds_lower
icu_beds_mean
icu_beds_upper
icu_beds_lower
admis_mean
admis_upper
admis_lower

infection_fatality						Infection fatality ratio
infection_detection						Infection detection ratio
infection_hospitalization				Infection hospitalization ratio
*/


rename mobility_mean mobility_mean_A02S01
rename mask_use_mean mask_use_mean_A02S01
label var mobility_mean_A02S01 "IHME Percent change in mobility from baseline (mean)  S1"
label var mask_use_mean_A02S01 "IHME Percent of population reporting always wearing a mask when leaving home  S1"

rename hospital_beds_mean hospital_beds_mean_A02S01
rename hospital_beds_upper hospital_beds_upper_A02S01
rename hospital_beds_lower hospital_beds_lower_A02S01
rename icu_beds_mean icu_beds_mean_A02S01
rename icu_beds_upper icu_beds_upper_A02S01
rename icu_beds_lower icu_beds_lower_A02S01
rename admis_mean admis_mean_A02S01
rename admis_upper admis_upper_A02S01
rename admis_lower admis_lower_A02S01
label var hospital_beds_mean_A02S01 "IHME Daily COVID-19 hospital beds needed (mean estimate) S1"
label var hospital_beds_upper_A02S01 "IHME Daily COVID-19 hospital beds needed (upper 95% confidence interval) S1"
label var hospital_beds_lower_A02S01 "IHME Daily COVID-19 hospital beds needed (lower 95% confidence interval) S1"
label var icu_beds_mean_A02S01	"IHME Daily COVID-19 ICU beds needed (mean estimate) S1"
label var icu_beds_upper_A02S01 "IHME Daily COVID-19 ICU beds needed (upper 95% confidence interval) S1"
label var icu_beds_lower_A02S01 "IHME Daily COVID-19 ICU beds needed (lower 95% confidence interval) S1"
label var admis_mean_A02S01 "IHME Daily COVID-19 hospital admissions (mean estimate) S1"
label var admis_upper_A02S01 "IHME Daily COVID-19 hospital admissions (mean estimate) S1"
label var admis_lower_A02S01 "IHME Daily COVID-19 hospital admissions (mean estimate) S1"


rename infection_fatality infection_fatality_A02S01
rename infection_detection infection_detection_A02S01
rename infection_hospitalization infection_hospitalization_A02S01
label var infection_fatality_A02S01 "IHME Infection fatality ratio S1"
label var infection_detection_A02S01 "IHME Infection detection ratio S1"
label var infection_hospitalization_A02S01 "IHME Infection hospitalization ratio S1"






***********************
* rename convention  

/*

allbed		Bed 	covid beds needed by day 
icubed		Icu 	ICU covid beds needed by day
invven		Ven 	invasive ventilation needed by day
admis		Adm 	hospital admissions by day
newicu		Icn		number of new people going to the ICU by day
bedover		Beo		[covid all beds needed] - ([total bed capacity] - [average all bed usage]) (* has been retired by IHME)
icuover		Ico		[covid ICU beds needed] - ([total ICU capacity] - [average ICU bed usage]) (* has been retired by IHME)

total_tests		Tes	tests

seroprev_mean	Ser seroprevalence 

*/

*

/*

no more allbed_* , hospital_beds_* instead 

rename allbed_mean		DayBedMeSmA02S01
rename allbed_lower		DayBedLoSmA02S01
rename allbed_upper		DayBedUpSmA02S01

label var DayBedMeSmA02S01 "Daily Beds needed Mean IHME S1"
label var DayBedLoSmA02S01 "Daily Beds needed Lower IHME S1"
label var DayBedUpSmA02S01 "Daily Beds needed Upper IHME S1"
*/


rename hospital_beds_mean_A02S01		DayBedMeSmA02S01
rename hospital_beds_upper_A02S01		DayBedLoSmA02S01
rename hospital_beds_lower_A02S01		DayBedUpSmA02S01

label var DayBedMeSmA02S01 "IHME Daily COVID-19 hospital beds needed (mean estimate) S1"
label var DayBedLoSmA02S01 "IHME Daily COVID-19 hospital beds needed (upper 95% confidence interval) S1"
label var DayBedUpSmA02S01 "IHME Daily COVID-19 hospital beds needed (lower 95% confidence interval) S1"

*

rename icu_beds_mean_A02S01			DayIcuMeSmA02S01
rename icu_beds_lower_A02S01		DayIcuLoSmA02S01
rename icu_beds_upper_A02S01		DayIcuUpSmA02S01

label var DayIcuMeSmA02S01"IHME Daily COVID-19 ICU beds needed (mean estimate) S1"
label var DayIcuLoSmA02S01 "IHME Daily COVID-19 ICU beds needed (upper 95% confidence interval) S1"
label var DayIcuUpSmA02S01 "IHME Daily COVID-19 ICU beds needed (lower 95% confidence interval) S1"


/*

no more invven_*

rename invven_mean		DayVenMeSmA02S01
rename invven_lower		DayVenLoSmA02S01
rename invven_upper		DayVenUpSmA02S01

label var DayVenMeSmA02S01 "Daily invasive Ventilation needed Mean IHME S1"
label var DayVenLoSmA02S01 "Daily invasive Ventilation needed Lower IHME S1"
label var DayVenUpSmA02S01 "Daily invasive Ventilation needed Upper IHME S1"
*/


rename admis_mean_A02S01		DayAdmMeSmA02S01
rename admis_lower_A02S01		DayAdmLoSmA02S01
rename admis_upper_A02S01		DayAdmUpSmA02S01

label var DayAdmMeSmA02S01 "IHME Daily COVID-19 hospital admissions (mean estimate) S1"
label var DayAdmLoSmA02S01 "IHME Daily COVID-19 hospital admissions (mean estimate) S1"
label var DayAdmUpSmA02S01 "IHME Daily COVID-19 hospital admissions (mean estimate) S1"


/*

no more newicu_*

rename newicu_mean		DayIcnMeSmA02S01
rename newicu_lower		DayIcnLoSmA02S01
rename newicu_upper		DayIcnUpSmA02S01

label var DayIcnMeSmA02S01 "Daily new people going to ICU Mean IHME S1"
label var DayIcnLoSmA02S01 "Daily new people going to ICU Lower IHME S1"
label var DayIcnUpSmA02S01 "Daily new people going to ICU Upper IHME S1"

*/



label var all_bed_capacity "IHME Total number of beds that exist at a location"
label var icu_bed_capacity "IHME Total number of ICU beds that exist at a location"

rename all_bed_capacity DayBEDMeSmA02
label var DayBEDMeSmA02 "IHME Total number of beds that exist at a location"

rename icu_bed_capacity DayICUMeSmA02
label var DayICUMeSmA02 "IHME Total number of ICU beds that exist at a location"




/* using IHME's seroprev_mean in covir2 codes is retired, 
after a number of on-and-offs of existence of this variable in released estimates files. 

rename seroprev_mean 		TotSerMeSmA02S01
rename seroprev_upper 		TotSerLoSmA02S01
rename seroprev_lower		TotSerUpSmA02S01

label var TotSerMeSmA02S01 "Total seroprevalence Mean IHME S1"
label var TotSerLoSmA02S01 "Total seroprevalence Lower IHME S1"
label var TotSerUpSmA02S01 "Total seroprevalence Upper IHME S1"
*/


order date location_name 

sort date location_name 

drop location_id date_original version_name

save "Reference country.dta", replace








**********************

* S2 Best

use "data_download_file_best_masks_2020_21.dta", clear


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

* Total Reported Deaths smoothed
rename seir_cumulative_unscaled_mean  TotDeaMeSmA02S02
rename seir_cumulative_unscaled_lower TotDeaLoSmA02S02
rename seir_cumulative_unscaled_upper TotDeaUpSmA02S02
label var TotDeaMeSmA02S02 "Total Reported Deaths Mean smoothed IHME S2" // Cumulative reported deaths (mean estimate)
label var TotDeaLoSmA02S02 "Total Reported Deaths Lower smoothed IHME S2" // Cumulative reported deaths (lower 95% confidence interval)
label var TotDeaUpSmA02S02 "Total Reported Deaths Upper smoothed IHME S2" // Cumulative reported deaths (upper 95% confidence interval)

* Total Excess Deaths smoothed
rename seir_cumulative_mean  TotDeXMeSmA02S02
rename seir_cumulative_lower TotDeXLoSmA02S02
rename seir_cumulative_upper TotDeXUpSmA02S02
label var TotDeXMeSmA02S02 "Total Excess Deaths Mean smoothed IHME S2" // Cumulative excess deaths (mean estimate)
label var TotDeXLoSmA02S02 "Total Excess Deaths Lower smoothed IHME S2" // Cumulative excess deaths (lower 95% confidence interval)
label var TotDeXUpSmA02S02 "Total Excess Deaths Upper smoothed IHME S2" // Cumulative excess deaths (upper 95% confidence interval)

* Daily Reported Deaths smoothed
rename seir_daily_unscaled_mean  DayDeaMeSmA02S02
rename seir_daily_unscaled_lower DayDeaLoSmA02S02
rename seir_daily_unscaled_upper DayDeaUpSmA02S02
label var DayDeaMeSmA02S02 "Daily Reported Deaths Mean smoothed IHME S2" // Daily reported deaths (mean estimate)
label var DayDeaLoSmA02S02 "Daily Reported Deaths Lower smoothed IHME S2" // Daily reported deaths (lower 95% confidence interval)
label var DayDeaUpSmA02S02 "Daily Reported Deaths Upper smoothed IHME S2" // Daily reported deaths upper 95% confidence interval)
	
* Daily Excess Deaths smoothed
rename seir_daily_mean  DayDeXMeSmA02S02
rename seir_daily_lower DayDeXLoSmA02S02
rename seir_daily_upper DayDeXUpSmA02S02
label var DayDeXMeSmA02S02 "Daily Excess Deaths Mean smoothed IHME S2" // Daily excess deaths (mean estimate)
label var DayDeXLoSmA02S02 "Daily Excess Deaths Lower smoothed IHME S2" // Daily excess deaths (lower 95% confidence interval)
label var DayDeXUpSmA02S02 "Daily Excess Deaths Upper smoothed IHME S2" // Daily excess deaths upper 95% confidence interval)
		
* Total infections smoothed
rename inf_cuml_mean  TotINFMeSmA02S02
rename inf_cuml_lower TotINFLoSmA02S02
rename inf_cuml_upper TotINFUpSmA02S02
label var TotINFMeSmA02S02 "Total infections Mean smoothed IHME S2" // Cumulative infections (mean estimate)
label var TotINFLoSmA02S02 "Total infections Lower smoothed IHME S2" // Cumulative infections (lower 95% confidence interval)
label var TotINFUpSmA02S02 "Total infections Upper smoothed IHME S2" // Cumulative infections (upper 95% confidence interval)

* Daily infections smoothed
rename inf_mean  DayINFMeSmA02S02 // previously est_infections_mean
rename inf_lower DayINFLoSmA02S02 // previously est_infections_lower
rename inf_upper DayINFUpSmA02S02 // previously est_infections_upper
label var DayINFMeSmA02S02 "Daily infections Mean smoothed IHME S2" // Daily infections (mean estimate)
label var DayINFLoSmA02S02 "Daily infections Lower smoothed IHME S2" // Daily infections (lower 95% confidence interval)
label var DayINFUpSmA02S02 "Daily infections Upper smoothed IHME S2" // Daily infections (upper 95% confidence interval)





* other variables 

rename reff_mean reff_mean_A02S02
rename reff_lower reff_lower_A02S02
rename reff_upper reff_upper_A02S02
label var reff_mean_A02S02 "IHME R effective (mean estimate) S2"
label var reff_lower_A02S02 "IHME R effective (lower 95% confidence interval) S2"
label var reff_upper_A02S02 "IHME R effective (upper 95% confidence interval) S2"

rename cumulative_cases cumulative_cases_A02S02
rename cumulative_deaths cumulative_deaths_A02S02
rename cumulative_hospitalizations cumulative_hosp_A02S02
rename daily_deaths daily_deaths_A02S02
rename daily_infections daily_infections_A02S02
rename cumulative_deaths_unscaled cumul_deaths_unscaled_A02S02
rename daily_deaths_unscaled dai_dea_unscaled_A02S02
label var cumulative_cases_A02S02 "IHME Cumulative cases (raw data) S2"
label var cumulative_deaths_A02S02 "IHME Cumulative deaths (raw data with excess mortality scalar applied) S2"
label var cumulative_hosp_A02S02 "IHME Cumulative hospitalizations (raw data) S2"
label var daily_deaths_A02S02 "IHME Daily deaths (raw data with excess mortality scalar applied) S2"
label var daily_infections_A02S02 "IHME Daily infections (raw data)"
label var cumul_deaths_unscaled_A02S02 "IHME umulative deaths (raw data without excess mortality scalar applied) S2"
label var dai_dea_unscaled_A02S02 "IHME Daily deaths (raw data without excess mortality scalar applied) S2"

rename daily_infections dai_inf_A02S02
label var dai_inf_A02S02 "IHME Daily infections (raw data without excess mortality scalar applied)" // present in data, not present in data_dictionary.csv





* IDENTICAL ACROSS SCENARIOS:

label var population "IHME Population size"
label var mobility_obs "IHME Indicator for whether mobility estimate comes from observed data (1) or modelled estimates (0)"
label var testing_mean "IHME Tests per 100,000 (mean estimate)"
label var testing_lower "IHME Tests per 100,000 (lower 95% confidence interval)"
label var testing_upper "IHME Tests per 100,000 (upper 95% confidence interval)"
label var testing_obs "IHME Indicator for whether testing estimate comes from observed data (1) or modelled estimates (0)"
label var pneumonia_mean "IHME Ratio of pneumonia deaths in a given week to the average weekly pneumonia deaths by location"
label var pneumonia_obs "IHME Indicator for whether pneumonia estimate comes from observed data (1) or modelled estimates (0)"
label var mask_use_obs "IHME Indicator for whether mask estimate comes from observed data (1) or modelled estimates (0)"
label var cumulative_all_vaccinated	"IHME Initially vaccinated (one dose of two doses)"
label var cumulative_all_effectively_vacci "IHME Effectively vaccinated (one and two dose with efficacy)" // cumulative_all_effectively_vaccinated
label var cumulative_all_fully_vaccinated "IHME Fully vaccinated (one of one and†two†of two doses)"

label var all_bed_capacity "IHME Total number of beds that exist at a location"
label var icu_bed_capacity "IHME Total number of ICU beds that exist at a location"


/*
BY DEFINITION, THE FOLLOWING VARIABLES SHOULD NOT BE IDENTICAL ACROSS SCENARIOS:

mobility_mean

mask_use_mean

hospital_beds_mean
hospital_beds_upper
hospital_beds_lower
icu_beds_mean
icu_beds_upper
icu_beds_lower
admis_mean
admis_upper
admis_lower

infection_fatality						Infection fatality ratio
infection_detection						Infection detection ratio
infection_hospitalization				Infection hospitalization ratio
*/


rename mobility_mean mobility_mean_A02S02
rename mask_use_mean mask_use_mean_A02S02
label var mobility_mean_A02S02 "IHME Percent change in mobility from baseline (mean) S2"
label var mask_use_mean_A02S02 "IHME Percent of population reporting always wearing a mask when leaving home S2"

rename hospital_beds_mean hospital_beds_mean_A02S02
rename hospital_beds_upper hospital_beds_upper_A02S02
rename hospital_beds_lower hospital_beds_lower_A02S02
rename icu_beds_mean icu_beds_mean_A02S02
rename icu_beds_upper icu_beds_upper_A02S02
rename icu_beds_lower icu_beds_lower_A02S02
rename admis_mean admis_mean_A02S02
rename admis_upper admis_upper_A02S02
rename admis_lower admis_lower_A02S02
label var hospital_beds_mean_A02S02 "IHME Daily COVID-19 hospital beds needed (mean estimate) S2"
label var hospital_beds_upper_A02S02 "IHME Daily COVID-19 hospital beds needed (upper 95% confidence interval) S2"
label var hospital_beds_lower_A02S02 "IHME Daily COVID-19 hospital beds needed (lower 95% confidence interval) S2"
label var icu_beds_mean_A02S02	"IHME Daily COVID-19 ICU beds needed (mean estimate) S2"
label var icu_beds_upper_A02S02 "IHME Daily COVID-19 ICU beds needed (upper 95% confidence interval) S2"
label var icu_beds_lower_A02S02 "IHME Daily COVID-19 ICU beds needed (lower 95% confidence interval) S2"
label var admis_mean_A02S02 "IHME Daily COVID-19 hospital admissions (mean estimate) S2"
label var admis_upper_A02S02 "IHME Daily COVID-19 hospital admissions (mean estimate) S2"
label var admis_lower_A02S02 "IHME Daily COVID-19 hospital admissions (mean estimate) S2"


rename infection_fatality infection_fatality_A02S02
rename infection_detection infection_detection_A02S02
rename infection_hospitalization infection_hospitalization_A02S02
label var infection_fatality_A02S02 "IHME Infection fatality ratio S2"
label var infection_detection_A02S02 "IHME Infection detection ratio S2"
label var infection_hospitalization_A02S02 "IHME Infection hospitalization ratio S2"





*

rename hospital_beds_mean_A02S02		DayBedMeSmA02S02
rename hospital_beds_upper_A02S02		DayBedLoSmA02S02
rename hospital_beds_lower_A02S02		DayBedUpSmA02S02

label var DayBedMeSmA02S02 "IHME Daily COVID-19 hospital beds needed (mean estimate) S2"
label var DayBedLoSmA02S02 "IHME Daily COVID-19 hospital beds needed (upper 95% confidence interval) S2"
label var DayBedUpSmA02S02 "IHME Daily COVID-19 hospital beds needed (lower 95% confidence interval) S2"

*

rename icu_beds_mean_A02S02			DayIcuMeSmA02S02
rename icu_beds_lower_A02S02		DayIcuLoSmA02S02
rename icu_beds_upper_A02S02		DayIcuUpSmA02S02

label var DayIcuMeSmA02S02"IHME Daily COVID-19 ICU beds needed (mean estimate) S2"
label var DayIcuLoSmA02S02 "IHME Daily COVID-19 ICU beds needed (upper 95% confidence interval) S2"
label var DayIcuUpSmA02S02 "IHME Daily COVID-19 ICU beds needed (lower 95% confidence interval) S2"

*

rename admis_mean_A02S02		DayAdmMeSmA02S02
rename admis_lower_A02S02		DayAdmLoSmA02S02
rename admis_upper_A02S02		DayAdmUpSmA02S02

label var DayAdmMeSmA02S02 "IHME Daily COVID-19 hospital admissions (mean estimate) S2"
label var DayAdmLoSmA02S02 "IHME Daily COVID-19 hospital admissions (mean estimate) S2"
label var DayAdmUpSmA02S02 "IHME Daily COVID-19 hospital admissions (mean estimate) S2"

*

label var all_bed_capacity "IHME Total number of beds that exist at a location"
label var icu_bed_capacity "IHME Total number of ICU beds that exist at a location"

rename all_bed_capacity DayBEDMeSmA02
label var DayBEDMeSmA02 "IHME Total number of beds that exist at a location"

rename icu_bed_capacity DayICUMeSmA02 
label var DayICUMeSmA02 "IHME Total number of ICU beds that exist at a location"





order date location_name 

sort date location_name 

drop location_id date_original version_name


save "Best country.dta", replace








**********************

* S3 Worse

use "data_download_file_worse_2020_21.dta", clear



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

* Total Reported Deaths smoothed
rename seir_cumulative_unscaled_mean  TotDeaMeSmA02S03
rename seir_cumulative_unscaled_lower TotDeaLoSmA02S03
rename seir_cumulative_unscaled_upper TotDeaUpSmA02S03
label var TotDeaMeSmA02S03 "Total Reported Deaths Mean smoothed IHME S3" // Cumulative reported deaths (mean estimate)
label var TotDeaLoSmA02S03 "Total Reported Deaths Lower smoothed IHME S3" // Cumulative reported deaths (lower 95% confidence interval)
label var TotDeaUpSmA02S03 "Total Reported Deaths Upper smoothed IHME S3" // Cumulative reported deaths (upper 95% confidence interval)

* Total Excess Deaths smoothed
rename seir_cumulative_mean  TotDeXMeSmA02S03
rename seir_cumulative_lower TotDeXLoSmA02S03
rename seir_cumulative_upper TotDeXUpSmA02S03
label var TotDeXMeSmA02S03 "Total Excess Deaths Mean smoothed IHME S3" // Cumulative excess deaths (mean estimate)
label var TotDeXLoSmA02S03 "Total Excess Deaths Lower smoothed IHME S3" // Cumulative excess deaths (lower 95% confidence interval)
label var TotDeXUpSmA02S03 "Total Excess Deaths Upper smoothed IHME S3" // Cumulative excess deaths (upper 95% confidence interval)

* Daily Reported Deaths smoothed
rename seir_daily_unscaled_mean  DayDeaMeSmA02S03
rename seir_daily_unscaled_lower DayDeaLoSmA02S03
rename seir_daily_unscaled_upper DayDeaUpSmA02S03
label var DayDeaMeSmA02S03 "Daily Reported Deaths Mean smoothed IHME S3" // Daily reported deaths (mean estimate)
label var DayDeaLoSmA02S03 "Daily Reported Deaths Lower smoothed IHME S3" // Daily reported deaths (lower 95% confidence interval)
label var DayDeaUpSmA02S03 "Daily Reported Deaths Upper smoothed IHME S3" // Daily reported deaths upper 95% confidence interval)
	
* Daily Excess Deaths smoothed
rename seir_daily_mean  DayDeXMeSmA02S03
rename seir_daily_lower DayDeXLoSmA02S03
rename seir_daily_upper DayDeXUpSmA02S03
label var DayDeXMeSmA02S03 "Daily Excess Deaths Mean smoothed IHME S3" // Daily excess deaths (mean estimate)
label var DayDeXLoSmA02S03 "Daily Excess Deaths Lower smoothed IHME S3" // Daily excess deaths (lower 95% confidence interval)
label var DayDeXUpSmA02S03 "Daily Excess Deaths Upper smoothed IHME S3" // Daily excess deaths upper 95% confidence interval)
		
* Total infections smoothed
rename inf_cuml_mean  TotINFMeSmA02S03
rename inf_cuml_lower TotINFLoSmA02S03
rename inf_cuml_upper TotINFUpSmA02S03
label var TotINFMeSmA02S03 "Total infections Mean smoothed IHME S3" // Cumulative infections (mean estimate)
label var TotINFLoSmA02S03 "Total infections Lower smoothed IHME S3" // Cumulative infections (lower 95% confidence interval)
label var TotINFUpSmA02S03 "Total infections Upper smoothed IHME S3" // Cumulative infections (upper 95% confidence interval)

* Daily infections smoothed
rename inf_mean  DayINFMeSmA02S03 // previously est_infections_mean
rename inf_lower DayINFLoSmA02S03 // previously est_infections_lower
rename inf_upper DayINFUpSmA02S03 // previously est_infections_upper
label var DayINFMeSmA02S03 "Daily infections Mean smoothed IHME S3" // Daily infections (mean estimate)
label var DayINFLoSmA02S03 "Daily infections Lower smoothed IHME S3" // Daily infections (lower 95% confidence interval)
label var DayINFUpSmA02S03 "Daily infections Upper smoothed IHME S3" // Daily infections (upper 95% confidence interval)





* other variables 

rename reff_mean reff_mean_A02S03
rename reff_lower reff_lower_A02S03
rename reff_upper reff_upper_A02S03
label var reff_mean_A02S03 "IHME R effective (mean estimate) S3"
label var reff_lower_A02S03 "IHME R effective (lower 95% confidence interval) S3"
label var reff_upper_A02S03 "IHME R effective (upper 95% confidence interval) S3"

rename cumulative_cases cumulative_cases_A02S03
rename cumulative_deaths cumulative_deaths_A02S03
rename cumulative_hospitalizations cumulative_hosp_A02S03
rename daily_deaths daily_deaths_A02S03
rename daily_infections daily_infections_A02S03
rename cumulative_deaths_unscaled cumul_deaths_unscaled_A02S03
rename daily_deaths_unscaled dai_dea_unscaled_A02S03
label var cumulative_cases_A02S03 "IHME Cumulative cases (raw data) S3"
label var cumulative_deaths_A02S03 "IHME Cumulative deaths (raw data with excess mortality scalar applied) S3"
label var cumulative_hosp_A02S03 "IHME Cumulative hospitalizations (raw data) S3"
label var daily_deaths_A02S03 "IHME Daily deaths (raw data with excess mortality scalar applied) S3"
label var daily_infections_A02S03 "IHME Daily infections (raw data)"
label var cumul_deaths_unscaled_A02S03 "IHME umulative deaths (raw data without excess mortality scalar applied) S3"
label var dai_dea_unscaled_A02S03 "IHME Daily deaths (raw data without excess mortality scalar applied) S3"

rename daily_infections dai_inf_A02S03
label var dai_inf_A02S03 "IHME Daily infections (raw data without excess mortality scalar applied)" // present in data, not present in data_dictionary.csv





* IDENTICAL ACROSS SCENARIOS:

label var population "IHME Population size"
label var mobility_obs "IHME Indicator for whether mobility estimate comes from observed data (1) or modelled estimates (0)"
label var testing_mean "IHME Tests per 100,000 (mean estimate)"
label var testing_lower "IHME Tests per 100,000 (lower 95% confidence interval)"
label var testing_upper "IHME Tests per 100,000 (upper 95% confidence interval)"
label var testing_obs "IHME Indicator for whether testing estimate comes from observed data (1) or modelled estimates (0)"
label var pneumonia_mean "IHME Ratio of pneumonia deaths in a given week to the average weekly pneumonia deaths by location"
label var pneumonia_obs "IHME Indicator for whether pneumonia estimate comes from observed data (1) or modelled estimates (0)"
label var mask_use_obs "IHME Indicator for whether mask estimate comes from observed data (1) or modelled estimates (0)"
label var cumulative_all_vaccinated	"IHME Initially vaccinated (one dose of two doses)"
label var cumulative_all_effectively_vacci "IHME Effectively vaccinated (one and two dose with efficacy)" // cumulative_all_effectively_vaccinated
label var cumulative_all_fully_vaccinated "IHME Fully vaccinated (one of one and†two†of two doses)"

label var all_bed_capacity "IHME Total number of beds that exist at a location"
label var icu_bed_capacity "IHME Total number of ICU beds that exist at a location"


/*
BY DEFINITION, THE FOLLOWING VARIABLES SHOULD NOT BE IDENTICAL ACROSS SCENARIOS:

mobility_mean

mask_use_mean

hospital_beds_mean
hospital_beds_upper
hospital_beds_lower
icu_beds_mean
icu_beds_upper
icu_beds_lower
admis_mean
admis_upper
admis_lower

infection_fatality						Infection fatality ratio
infection_detection						Infection detection ratio
infection_hospitalization				Infection hospitalization ratio
*/


rename mobility_mean mobility_mean_A02S03
rename mask_use_mean mask_use_mean_A02S03
label var mobility_mean_A02S03 "IHME Percent change in mobility from baseline (mean) S3"
label var mask_use_mean_A02S03 "IHME Percent of population reporting always wearing a mask when leaving home S3"

rename hospital_beds_mean hospital_beds_mean_A02S03
rename hospital_beds_upper hospital_beds_upper_A02S03
rename hospital_beds_lower hospital_beds_lower_A02S03
rename icu_beds_mean icu_beds_mean_A02S03
rename icu_beds_upper icu_beds_upper_A02S03
rename icu_beds_lower icu_beds_lower_A02S03
rename admis_mean admis_mean_A02S03
rename admis_upper admis_upper_A02S03
rename admis_lower admis_lower_A02S03
label var hospital_beds_mean_A02S03 "IHME Daily COVID-19 hospital beds needed (mean estimate) S3"
label var hospital_beds_upper_A02S03 "IHME Daily COVID-19 hospital beds needed (upper 95% confidence interval) S3"
label var hospital_beds_lower_A02S03 "IHME Daily COVID-19 hospital beds needed (lower 95% confidence interval) S3"
label var icu_beds_mean_A02S03	"IHME Daily COVID-19 ICU beds needed (mean estimate) S3"
label var icu_beds_upper_A02S03 "IHME Daily COVID-19 ICU beds needed (upper 95% confidence interval) S3"
label var icu_beds_lower_A02S03 "IHME Daily COVID-19 ICU beds needed (lower 95% confidence interval) S3"
label var admis_mean_A02S03 "IHME Daily COVID-19 hospital admissions (mean estimate) S3"
label var admis_upper_A02S03 "IHME Daily COVID-19 hospital admissions (mean estimate) S3"
label var admis_lower_A02S03 "IHME Daily COVID-19 hospital admissions (mean estimate) S3"


rename infection_fatality infection_fatality_A02S03
rename infection_detection infection_detection_A02S03
rename infection_hospitalization infection_hospitalization_A02S03
label var infection_fatality_A02S03 "IHME Infection fatality ratio S3"
label var infection_detection_A02S03 "IHME Infection detection ratio S3"
label var infection_hospitalization_A02S03 "IHME Infection hospitalization ratio S3"





*

rename hospital_beds_mean_A02S03		DayBedMeSmA02S03
rename hospital_beds_upper_A02S03		DayBedLoSmA02S03
rename hospital_beds_lower_A02S03		DayBedUpSmA02S03

label var DayBedMeSmA02S03 "IHME Daily COVID-19 hospital beds needed (mean estimate) S3"
label var DayBedLoSmA02S03 "IHME Daily COVID-19 hospital beds needed (upper 95% confidence interval) S3"
label var DayBedUpSmA02S03 "IHME Daily COVID-19 hospital beds needed (lower 95% confidence interval) S3"

*

rename icu_beds_mean_A02S03			DayIcuMeSmA02S03
rename icu_beds_lower_A02S03		DayIcuLoSmA02S03
rename icu_beds_upper_A02S03		DayIcuUpSmA02S03

label var DayIcuMeSmA02S03"IHME Daily COVID-19 ICU beds needed (mean estimate) S3"
label var DayIcuLoSmA02S03 "IHME Daily COVID-19 ICU beds needed (upper 95% confidence interval) S3"
label var DayIcuUpSmA02S03 "IHME Daily COVID-19 ICU beds needed (lower 95% confidence interval) S3"

*

rename admis_mean_A02S03		DayAdmMeSmA02S03
rename admis_lower_A02S03		DayAdmLoSmA02S03
rename admis_upper_A02S03		DayAdmUpSmA02S03

label var DayAdmMeSmA02S03 "IHME Daily COVID-19 hospital admissions (mean estimate) S3"
label var DayAdmLoSmA02S03 "IHME Daily COVID-19 hospital admissions (mean estimate) S3"
label var DayAdmUpSmA02S03 "IHME Daily COVID-19 hospital admissions (mean estimate) S3"

*

label var all_bed_capacity "IHME Total number of beds that exist at a location"
label var icu_bed_capacity "IHME Total number of ICU beds that exist at a location"

rename all_bed_capacity DayBEDMeSmA02
label var DayBEDMeSmA02 "IHME Total number of beds that exist at a location"

rename icu_bed_capacity DayICUMeSmA02 
label var DayICUMeSmA02 "IHME Total number of ICU beds that exist at a location"





order date location_name 

sort date location_name 

drop location_id date_original version_name


save "Worse country.dta", replace


 
 
 
 
**********************

 
* merge scenario files


use "Reference country.dta", clear
merge 1:1 location_name date using "Best country.dta"
drop _merge
merge 1:1 location_name date using "Worse country.dta"
drop _merge


rename location_name loc_grand_name

replace loc_grand_name = "$country"



* gen "Daily infections mean div by daily deaths mean IHME DayCbD" for visulization of temporal relation of deaths and infections peaks 

summ DayDeaMeSmA02S01 
gen DayDeMMeSmA02S01 = r(mean)
label var DayDeMMeSmA02S01 "Daily deaths mean IHME DayDeM"
  
summ DayINFMeSmA02S01 
gen DayCaMMeSmA02S01 = r(mean)
label var DayCaMMeSmA02S01 "Daily infections mean IHME DayCaM"
                           
gen DayCbDMeSmA02S01 = DayCaMMeSmA02S01 / DayDeMMeSmA02S01
label var DayCbDMeSmA02S01 "Daily infections mean div by daily deaths mean IHME DayCbD"
summ DayCbDMeSmA02S01
                                              
gen DayDMuMeSmA02S01 = DayDeaMeSmA02S01 * DayCbDMeSmA02S01
label var DayDMuMeSmA02S01 "Daily deaths scaled (times means of infections by deaths) IHME"
summ DayDMuMeSmA02S01



* gen percent vaccinated 

gen cumulative_all_vaccin_pct = 100 * (cumulative_all_vaccinated / population)
label var cumulative_all_vaccin_pct "% population IHME Initially vaccinated (one dose of two doses)"

gen cumul_all_effect_vacci_pct = 100 * (cumulative_all_effectively_vacci / population)
label var cumul_all_effect_vacci_pct "% population IHME Effectively vaccinated (one and two dose with efficacy)"

gen cumul_all_fully_vacci_pct = 100 * (cumulative_all_fully_vaccinated / population)
label var cumul_all_fully_vacci_pct "% population IHME Fully vaccinated (one of one and two of two doses)"



* gen daily vaccinated number 

sort loc_grand_name date

bysort loc_grand_name: gen daily_all_vaccinated = cumulative_all_vaccinated[_n] - cumulative_all_vaccinated[_n-1]
label var daily_all_vaccinated "Daily population IHME Initially vaccinated (one dose of two doses)"
bysort loc_grand_name: gen daily_all_effectively_vacci = cumulative_all_effectively_vacci[_n] - cumulative_all_effectively_vacci[_n-1]
label var daily_all_effectively_vacci "Daily population IHME Effectively vaccinated (one and two dose with efficacy)"
bysort loc_grand_name: gen daily_all_fully_vaccinated = cumulative_all_fully_vaccinated[_n] - cumulative_all_fully_vaccinated[_n-1]
label var daily_all_fully_vaccinated "Daily population IHME Fully vaccinated (one of one and two of two doses)"




* gen daily vaccinated percent

sort loc_grand_name date

bysort loc_grand_name: gen daily_all_vaccin_pct = cumulative_all_vaccin_pct[_n] - cumulative_all_vaccin_pct[_n-1]
label var daily_all_vaccin_pct "% Daily population IHME Initially vaccinated (one dose of two doses)"
bysort loc_grand_name: gen daily_all_effect_vacci_pct = cumul_all_effect_vacci_pct[_n] - cumul_all_effect_vacci_pct[_n-1]
label var daily_all_effect_vacci_pct "% Daily population IHME Effectively vaccinated (one and two dose with efficacy)"
bysort loc_grand_name: gen daily_all_fully_vacci_pct = cumul_all_fully_vacci_pct[_n] - cumul_all_fully_vacci_pct[_n-1]
label var daily_all_fully_vacci_pct "% Daily population IHME Fully vaccinated (one of one and two of two doses)"



qui compress

save "country IHME.dta", replace


***********************


* graphs


grstyle init

grstyle color background white


* daily deaths


* daily reported deaths, reference scenario = S1 	   
	   
twoway (rarea DayDeaLoSmA02S01 DayDeaUpSmA02S01 date, sort color(black*.2)) ///
(line DayDeaMeSmA02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 1a COVID-19 daily reported deaths, reference scenario, $country, IHME.gph", replace
graph export "graph 1a COVID-19 daily reported deaths, reference scenario, $country, IHME.pdf", replace



* daily excess deaths, reference scenario = S1 	   
	   
twoway (rarea DayDeXLoSmA02S01 DayDeXUpSmA02S01 date, sort color(black*.2)) ///
(line DayDeXMeSmA02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily excess deaths) title("COVID-19 daily excess deaths, $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 1b COVID-19 daily excess deaths, reference scenario, $country, IHME.gph", replace
graph export "graph 1b COVID-19 daily excess deaths, reference scenario, $country, IHME.pdf", replace




* daily reported & excess deaths, reference scenario = S1 	   

twoway (rarea DayDeaLoSmA02S01 DayDeaUpSmA02S01 date, sort color(black*.2)) ///
(line DayDeaMeSmA02S01 date, sort lcolor(black)) ///	   
(rarea DayDeXLoSmA02S01 DayDeXUpSmA02S01 date, sort color(red*.2)) ///
(line DayDeXMeSmA02S01 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported & excess deaths) title("COVID-19 daily reported & excess deaths, $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(2 "Reported deaths" 4 "Excess deaths") rows(1)) yscale(titlegap(2))
	   
graph save "graph 1c COVID-19 daily reported & excess deaths, reference scenario, $country, IHME.gph", replace
graph export "graph 1c COVID-19 daily reported & excess deaths, reference scenario, $country, IHME.pdf", replace







* daily reported deaths, 3 scenarios  
  
twoway ///
(line DayDeaMeSmA02S01 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line DayDeaMeSmA02S02 date, sort lcolor(green)) ///
(line DayDeaMeSmA02S03 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))

graph save "graph 2a COVID-19 daily reported deaths, $country 3 scenarios, IHME.gph", replace
graph export "graph 2a COVID-19 daily reported deaths, $country 3 scenarios, IHME.pdf", replace




* daily excess deaths, 3 scenarios  
  
twoway ///
(line DayDeXMeSmA02S01 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line DayDeXMeSmA02S02 date, sort lcolor(green)) ///
(line DayDeXMeSmA02S03 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily excess deaths) title("COVID-19 daily excess deaths, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))

graph save "graph 2b COVID-19 daily excess deaths, $country 3 scenarios, IHME.gph", replace
graph export "graph 2b COVID-19 daily excess deaths, $country 3 scenarios, IHME.pdf", replace




* daily reported & excess deaths, 3 scenarios  
  
twoway ///
(line DayDeaMeSmA02S01 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line DayDeaMeSmA02S02 date, sort lcolor(green)) ///
(line DayDeaMeSmA02S03 date, sort lcolor(red)) ///
(line DayDeXMeSmA02S01 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeXMeSmA02S02 date, sort lcolor(green) lpattern(dash)) ///
(line DayDeXMeSmA02S03 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported & excess deaths) title("COVID-19 daily reported & excess deaths, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1)) yscale(titlegap(2)) ///
note("Excess deaths: dashed curves")

graph save "graph 2c COVID-19 daily reported & excess deaths, $country 3 scenarios, IHME.gph", replace
graph export "graph 2c COVID-19 daily reported & excess deaths, $country 3 scenarios, IHME.pdf", replace





* daily reported deaths, reference scenario = S1, CI
  
twoway ///
(line DayDeaMeSmA02S01 date, sort lcolor(black)) ///
(line DayDeaLoSmA02S01 date, sort lcolor(green)) ///
(line DayDeaUpSmA02S01 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 3 COVID-19 daily deaths, $country reference scenario CI, IHME.gph", replace
graph export "graph 3 COVID-19 daily deaths, $country reference scenario CI, IHME.pdf", replace




* daily reported deaths, best scenario = S2, CI
  
twoway ///
(line DayDeaMeSmA02S02 date, sort lcolor(black)) ///
(line DayDeaLoSmA02S02 date, sort lcolor(green)) ///
(line DayDeaUpSmA02S02 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, $country, IHME, best scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 4 COVID-19 daily deaths, $country best scenario CI, IHME.gph", replace
graph export "graph 4 COVID-19 daily deaths, $country best scenario CI, IHME.pdf", replace




* daily reported deaths, worse scenario = S3, CI
  
twoway ///
(line DayDeaMeSmA02S03 date, sort lcolor(black)) ///
(line DayDeaLoSmA02S03 date, sort lcolor(green)) ///
(line DayDeaUpSmA02S03 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily reported deaths) title("COVID-19 daily reported deaths, $country, IHME, worse scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 5 COVID-19 daily deaths, $country worse scenario CI, IHME.gph", replace
graph export "graph 5 COVID-19 daily deaths, $country worse scenario CI, IHME.pdf", replace




* daily infections


* daily infections, reference scenario = S1 	   
	   
twoway (rarea DayINFLoSmA02S01 DayINFUpSmA02S01 date, sort color(black*.2)) ///
(line DayINFMeSmA02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections) title("COVID-19 daily infections, $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 6 COVID-19 daily infections, reference scenario, $country, IHME.gph", replace
graph export "graph 6 COVID-19 daily infections, reference scenario, $country, IHME.pdf", replace




* daily infections, 3 scenarios  
  
twoway ///
(line DayINFMeSmA02S01 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line DayINFMeSmA02S02 date, sort lcolor(green)) ///
(line DayINFMeSmA02S03 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections) title("COVID-19 daily infections, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))

graph save "graph 7 COVID-19 daily infections, $country 3 scenarios, IHME.gph", replace
graph export "graph 7 COVID-19 daily infections, $country 3 scenarios, IHME.pdf", replace




* daily infections, reference scenario = S1, CI
  
twoway ///
(line DayINFMeSmA02S01 date, sort lcolor(black)) ///
(line DayINFLoSmA02S01 date, sort lcolor(green)) ///
(line DayINFUpSmA02S01 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections) title("COVID-19 daily infections, $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 8 COVID-19 daily infections, $country reference scenario CI, IHME.gph", replace
graph export "graph 8 COVID-19 daily infections, $country reference scenario CI, IHME.pdf", replace




* daily infections, best scenario = S2, CI 
  
twoway ///
(line DayINFMeSmA02S02 date, sort lcolor(black)) ///
(line DayINFLoSmA02S02 date, sort lcolor(green)) ///
(line DayINFUpSmA02S02 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections) title("COVID-19 daily infections, $country, IHME, best scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 9 COVID-19 daily infections, $country best scenario CI, IHME.gph", replace
graph export "graph 9 COVID-19 daily infections, $country best scenario CI, IHME.pdf", replace




* daily infections, worse scenario = S3, CI
  
twoway ///
(line DayINFMeSmA02S03 date, sort lcolor(black)) ///
(line DayINFLoSmA02S03 date, sort lcolor(green)) ///
(line DayINFUpSmA02S03 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections) title("COVID-19 daily infections, $country, IHME, worse scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 10 COVID-19 daily infections, $country worse scenario CI, IHME.gph", replace
graph export "graph 10 COVID-19 daily infections, $country worse scenario CI, IHME.pdf", replace




* total deaths


* total reported deaths, reference scenario = S1 	   
	   
twoway (rarea TotDeaLoSmA02S01 TotDeaUpSmA02S01 date, sort color(black*.2)) ///
(line TotDeaMeSmA02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total reported deaths) title("COVID-19 total reported deaths, $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 11a COVID-19 total reported deaths, reference scenario, $country, IHME.gph", replace
graph export "graph 11a COVID-19 total reported deaths, reference scenario, $country, IHME.pdf", replace



* total excess deaths, reference scenario = S1 	   
	   
twoway (rarea TotDeXLoSmA02S01 TotDeXUpSmA02S01 date, sort color(black*.2)) ///
(line TotDeXMeSmA02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total excess deaths) title("COVID-19 total excess deaths, $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 11b COVID-19 total excess deaths, reference scenario, $country, IHME.gph", replace
graph export "graph 11b COVID-19 total excess deaths, reference scenario, $country, IHME.pdf", replace




* total reported & excess deaths, reference scenario = S1 	   
	   
twoway (rarea TotDeaLoSmA02S01 TotDeaUpSmA02S01 date, sort color(black*.2)) ///
(line TotDeaMeSmA02S01 date, sort lcolor(black)) ///
(rarea TotDeXLoSmA02S01 TotDeXUpSmA02S01 date, sort color(black*.2)) ///
(line TotDeXMeSmA02S01 date, sort lcolor(black) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total reported and excess deaths) title("COVID-19 total reported & excess deaths, $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) yscale(titlegap(4)) legend(off) ///
note("Excess deaths: dashed curve")
	   
graph save "graph 11c COVID-19 total reported & excess deaths, reference scenario, $country, IHME.gph", replace
graph export "graph 11c COVID-19 total reported & excess deaths, reference scenario, $country, IHME.pdf", replace




* total reported deaths, 3 scenarios  
  
twoway ///
(line TotDeaMeSmA02S01 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line TotDeaMeSmA02S02 date, sort lcolor(green)) ///
(line TotDeaMeSmA02S03 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total reported deaths) title("COVID-19 total reported deaths, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))

graph save "graph 12a COVID-19 total reported deaths, $country 3 scenarios, IHME.gph", replace
graph export "graph 12a COVID-19 total reported deaths, $country 3 scenarios, IHME.pdf", replace




* total excess deaths, 3 scenarios  
  
twoway ///
(line TotDeXLoSmA02S01 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line TotDeXLoSmA02S02 date, sort lcolor(green)) ///
(line TotDeXLoSmA02S03 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total excess deaths) title("COVID-19 total excess deaths, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))

graph save "graph 12b COVID-19 total excess deaths, $country 3 scenarios, IHME.gph", replace
graph export "graph 12b COVID-19 total excess deaths, $country 3 scenarios, IHME.pdf", replace




* total reported & excess deaths, 3 scenarios  
  
twoway ///
(line TotDeaMeSmA02S01 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line TotDeaMeSmA02S02 date, sort lcolor(green)) ///
(line TotDeaMeSmA02S03 date, sort lcolor(red)) ///
(line TotDeXLoSmA02S01 date, sort lcolor(black) lpattern(dash)) ///
(line TotDeXLoSmA02S02 date, sort lcolor(green) lpattern(dash)) ///
(line TotDeXLoSmA02S03 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total reported and excess deaths) title("COVID-19 total reported & excess deaths, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1)) ///
note("Excess deaths: dashed curves")

graph save "graph 12c COVID-19 total reported & excess deaths, $country 3 scenarios, IHME.gph", replace
graph export "graph 12c COVID-19 total reported & excess deaths, $country 3 scenarios, IHME.pdf", replace





* total reported deaths, reference scenario = S1, CI
  
twoway ///
(line TotDeaMeSmA02S01 date, sort lcolor(black)) ///
(line TotDeaLoSmA02S01 date, sort lcolor(green)) ///
(line TotDeaUpSmA02S01 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total reported deaths) title("COVID-19 total reported deaths, $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 13 COVID-19 total deaths, $country reference scenario CI, IHME.gph", replace
graph export "graph 13 COVID-19 total deaths, $country reference scenario CI, IHME.pdf", replace




* total reported deaths, best scenario = S2, CI
  
twoway ///
(line TotDeaMeSmA02S02 date, sort lcolor(black)) ///
(line TotDeaLoSmA02S02 date, sort lcolor(green)) ///
(line TotDeaUpSmA02S02 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total reported deaths) title("COVID-19 total reported deaths, $country, IHME, best scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 14 COVID-19 total deaths, $country best scenario CI, IHME.gph", replace
graph export "graph 14 COVID-19 total deaths, $country best scenario CI, IHME.pdf", replace




* total reported deaths, worse scenario = S3, CI
  
twoway ///
(line TotDeaMeSmA02S03 date, sort lcolor(black)) ///
(line TotDeaLoSmA02S03 date, sort lcolor(green)) ///
(line TotDeaUpSmA02S03 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total reported deaths) title("COVID-19 total reported deaths, $country, IHME, worse scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 15 COVID-19 total deaths, $country worse scenario CI, IHME.gph", replace
graph export "graph 15 COVID-19 total deaths, $country worse scenario CI, IHME.pdf", replace




* total infections


* total infections, reference scenario = S1 	   
	   
twoway (rarea TotINFLoSmA02S01 TotINFUpSmA02S01 date, sort color(black*.2)) ///
(line TotINFMeSmA02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total infections) title("COVID-19 total infections, $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 16 COVID-19 total infections, reference scenario, $country, IHME.gph", replace
graph export "graph 16 COVID-19 total infections, reference scenario, $country, IHME.pdf", replace




* total infections, reference scenario = S1, CI
  
twoway ///
(line TotINFMeSmA02S01 date, sort lcolor(black)) ///
(line TotINFLoSmA02S01 date, sort lcolor(green)) ///
(line TotINFUpSmA02S01 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total infections) title("COVID-19 total infections, $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 18 COVID-19 total infections, $country reference scenario CI, IHME.gph", replace
graph export "graph 18 COVID-19 total infections, $country reference scenario CI, IHME.pdf", replace




* total infections, best scenario = S2, CI

twoway ///
(line TotINFMeSmA02S02 date, sort lcolor(black)) ///
(line TotINFLoSmA02S02 date, sort lcolor(green)) ///
(line TotINFUpSmA02S02 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total infections) title("COVID-19 total infections, $country, IHME, better scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 19 COVID-19 total infections, $country better scenario CI, IHME.gph", replace
graph export "graph 19 COVID-19 total infections, $country better scenario CI, IHME.pdf", replace
 

 
* total infections, worse scenario = S3, CI
  
twoway ///
(line TotINFMeSmA02S03 date, sort lcolor(black)) ///
(line TotINFLoSmA02S03 date, sort lcolor(green)) ///
(line TotINFUpSmA02S03 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total infections) title("COVID-19 total infections, $country, IHME, worse scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 19 COVID-19 total infections, $country worse scenario CI, IHME.gph", replace
graph export "graph 19 COVID-19 total infections, $country worse scenario CI, IHME.pdf", replace




* total infections, 3 scenarios, CI
  
twoway ///
(line TotINFMeSmA02S02 date, sort lcolor(green)) ///
(line TotINFLoSmA02S02 date, sort lcolor(green*.5) lpattern(dash)) ///
(line TotINFUpSmA02S02 date, sort lcolor(green*.5) lpattern(dash)) ///
(line TotINFMeSmA02S03 date, sort lcolor(red)) ///
(line TotINFLoSmA02S03 date, sort lcolor(red*.5) lpattern(dash)) ///
(line TotINFUpSmA02S03 date, sort lcolor(red*.5) lpattern(dash)) ///
(line TotINFMeSmA02S01 date, sort lcolor(black)) ///
(line TotINFLoSmA02S01 date, sort lcolor(black) lpattern(dash)) ///
(line TotINFUpSmA02S01 date, sort lcolor(black) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total infections) title("COVID-19 total infections, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Worse" 4 "Better" 7 "Reference") rows(1)) ///
note("Uncertainty limits: dashed curves")

graph save "graph 20 COVID-19 total infections, $country 3 scenarios CI, IHME.gph", replace
graph export "graph 20 COVID-19 total infections, $country 3 scenarios CI, IHME.pdf", replace





  
  
* IDR, IHR, IFR


* daily Infection fatality ratio, 3 scenarios  
  
twoway ///
(line infection_fatality_A02S02 date, sort lcolor(green)) ///
(line infection_fatality_A02S03 date, sort lcolor(red)) ///
(line infection_fatality_A02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.3fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily Infection fatality ratio) title("COVID-19 daily Infection fatality ratio, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Better" 2 "Worse" 3 "Reference") rows(1))

graph save "graph 21a COVID-19 daily IFR, $country 3 scenarios, IHME.gph", replace
graph export "graph 21a COVID-19 daily IFR, $country 3 scenarios, IHME.pdf", replace




* daily Infection detection ratio, 3 scenarios  
  
twoway ///
(line infection_detection_A02S02 date, sort lcolor(green)) ///
(line infection_detection_A02S03 date, sort lcolor(red)) ///
(line infection_detection_A02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily Infection detection ratio) title("COVID-19 daily Infection detection ratio, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Better" 2 "Worse" 3 "Reference") rows(1))

graph save "graph 21b COVID-19 daily IDR, $country 3 scenarios, IHME.gph", replace
graph export "graph 21b COVID-19 daily IDR, $country 3 scenarios, IHME.pdf", replace





* daily Infection hospitalization ratio, 3 scenarios  
  
twoway ///
(line infection_hospitalization_A02S02 date, sort lcolor(green)) ///
(line infection_hospitalization_A02S03 date, sort lcolor(red)) ///
(line infection_hospitalization_A02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily Infection hospitalization ratio) title("COVID-19 daily Infection hospitalization ratio, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Better" 2 "Worse" 3 "Reference") rows(1))

graph save "graph 21c COVID-19 daily IHR, $country 3 scenarios, IHME.gph", replace
graph export "graph 21c COVID-19 daily IHR, $country 3 scenarios, IHME.pdf", replace




* daily Infection outcomes ratios, reference scenario 
  
twoway ///
(line infection_detection_A02S01 date, sort lcolor(green)) ///
(line infection_hospitalization_A02S01 date, sort lcolor(black)) ///
(line infection_fatality_A02S01 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infection outcome ratios) title("COVID-19 daily infection outcome ratios, $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Infection detection ratio" 2 "Infection hospitalization ratio" 3 "Infection fatality ratio") rows(2))

graph save "graph 21d COVID-19 daily Infection outcomes ratios, $country reference scenario, IHME.gph", replace
graph export "graph 21d COVID-19 daily Infection outcomes ratios, $country reference scenario, IHME.pdf", replace



* daily Infection outcomes ratios, better scenario 
  
twoway ///
(line infection_detection_A02S02 date, sort lcolor(green)) ///
(line infection_hospitalization_A02S02 date, sort lcolor(black)) ///
(line infection_fatality_A02S02 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infection outcome ratios) title("COVID-19 daily infection outcome ratios, $country, IHME, better scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Infection detection ratio" 2 "Infection hospitalization ratio" 3 "Infection fatality ratio") rows(2))

graph save "graph 21e COVID-19 daily Infection outcomes ratios, $country better scenario, IHME.gph", replace
graph export "graph 21e COVID-19 daily Infection outcomes ratios, $country better scenario, IHME.pdf", replace





* daily Infection outcomes ratios, worse scenario 
  
twoway ///
(line infection_detection_A02S03 date, sort lcolor(green)) ///
(line infection_hospitalization_A02S03 date, sort lcolor(black)) ///
(line infection_fatality_A02S03 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infection outcome ratios) title("COVID-19 daily infection outcome ratios, $country, IHME, worse scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Infection detection ratio" 2 "Infection hospitalization ratio" 3 "Infection fatality ratio") rows(2))

graph save "graph 21f COVID-19 daily Infection outcomes ratios, $country worse scenario, IHME.gph", replace
graph export "graph 21f COVID-19 daily Infection outcomes ratios, $country worse scenario, IHME.pdf", replace






* daily Infection outcomes ratios, 3 scenarios 
  
twoway ///
(line infection_detection_A02S01 date, sort lcolor(green)) ///
(line infection_hospitalization_A02S01 date, sort lcolor(black)) ///
(line infection_fatality_A02S01 date, sort lcolor(red)) ///
(line infection_detection_A02S02 date, sort lcolor(green) lpattern(dash)) ///
(line infection_hospitalization_A02S02 date, sort lcolor(black) lpattern(dash)) ///
(line infection_fatality_A02S02 date, sort lcolor(red) lpattern(dash)) ///
(line infection_detection_A02S03 date, sort lcolor(green) lpattern(dash)) ///
(line infection_hospitalization_A02S03 date, sort lcolor(black) lpattern(dash)) ///
(line infection_fatality_A02S03 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infection outcome ratios) title("COVID-19 daily infection outcome ratios, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Infection detection ratio" 2 "Infection hospitalization ratio" 3 "Infection fatality ratio") rows(2)) ///
note("Better and worse scenarios: dashed curves")

graph save "graph 21g COVID-19 daily Infection outcomes ratios, $country 3 scenarios, IHME.gph", replace
graph export "graph 21g COVID-19 daily Infection outcomes ratios, $country 3 scenarios, IHME.pdf", replace







* other outcomes 


* daily beds needed, 3 scenarios

twoway (rarea DayBedLoSmA02S01 DayBedUpSmA02S01 date, sort color(black*.2)) ///
(line DayBedMeSmA02S01 date, sort lcolor(black)) ///
(line DayBedMeSmA02S02 date, sort lcolor(green)) ///
(line DayBedMeSmA02S03 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily beds needed) title("COVID-19 daily beds needed, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(2 "Reference" 3 "Better" 4 "Worse") rows(1)) ///
note("Note: Values in the 3 scenarios are identical.")

graph save "graph 22a COVID-19 daily beds needed, $country 3 scenarios, IHME.gph", replace
graph export "graph 22a COVID-19 daily beds needed, $country 3 scenarios, IHME.pdf", replace




* daily beds needed, 3 scenarios, with all_bed_capacity

twoway (rarea DayBedLoSmA02S01 DayBedUpSmA02S01 date, sort color(black*.2)) ///
(line DayBedMeSmA02S01 date, sort lcolor(black)) ///
(line DayBedMeSmA02S02 date, sort lcolor(green)) ///
(line DayBedMeSmA02S03 date, sort lcolor(red)) ///
(line DayBEDMeSmA02 date, sort lcolor(blue) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily beds needed) title("COVID-19 daily beds needed, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(2 "Reference" 3 "Better" 4 "Worse" 5 "All bed capacity") rows(2)) ///
note("Note: Values in the 3 scenarios are identical.") ///
subtitle("All bed capacity: Total number of beds that exist at a location", size(small))

graph save "graph 22b COVID-19 daily beds needed, $country 3 scenarios, IHME all_bed_capacity.gph", replace
graph export "graph 22b COVID-19 daily beds needed, $country 3 scenarios, IHME all_bed_capacity.pdf", replace




* ICU beds needed, 3 scenarios

twoway (rarea DayIcuLoSmA02S01 DayIcuUpSmA02S01 date, sort color(black*.2)) ///
(line DayIcuMeSmA02S01 date, sort lcolor(black)) ///
(line DayIcuMeSmA02S02 date, sort lcolor(green)) ///
(line DayIcuMeSmA02S03 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(ICU beds needed) title("COVID-19 daily ICU beds needed, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(2 "Reference" 3 "Better" 4 "Worse") rows(1)) ///
note("Note: Values in the 3 scenarios are identical.")
	   
graph save "graph 23a COVID-19 daily ICU beds needed, $country 3 scenarios, IHME.gph", replace
graph export "graph 23a COVID-19 daily ICU beds needed, $country 3 scenarios, IHME.pdf", replace



* ICU beds needed, 3 scenarios, with icu_bed_capacity

twoway (rarea DayIcuLoSmA02S01 DayIcuUpSmA02S01 date, sort color(black*.2)) ///
(line DayIcuMeSmA02S01 date, sort lcolor(black)) ///
(line DayIcuMeSmA02S02 date, sort lcolor(green)) ///
(line DayIcuMeSmA02S03 date, sort lcolor(red)) ///
(line DayICUMeSmA02 date, sort lcolor(blue) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(ICU beds needed) title("COVID-19 daily ICU beds needed, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(2 "Reference" 3 "Better" 4 "Worse" 5 "ICU bed capacity") rows(2)) ///
note("Note: Values in the 3 scenarios are identical.") ///
subtitle("ICU bed capacity: Total number of ICU beds that exist at a location", size(small))

	   
graph save "graph 23b COVID-19 daily ICU beds needed, $country 3 scenarios, IHME icu_bed_capacity.gph", replace
graph export "graph 23b COVID-19 daily ICU beds needed, $country 3 scenarios, IHME icu_bed_capacity.pdf", replace




* daily hospital admissions, 3 scenarios

twoway (rarea DayAdmLoSmA02S01 DayAdmUpSmA02S01 date, sort color(black*.2)) ///
(line DayAdmMeSmA02S01 date, sort lcolor(black)) ///
(line DayAdmMeSmA02S02 date, sort lcolor(green)) ///
(line DayAdmMeSmA02S02 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily hospital admissions) title("COVID-19 daily hospital admissions $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(2 "Reference" 3 "Better" 4 "Worse") rows(1)) ///
note("Note: Values in the 3 scenarios are identical.")
	   
graph save "graph 25 COVID-19 daily hospital admissions, $country 3 scenarios, IHME.gph", replace
graph export "graph 26 COVID-19 daily hospital admissions, $country 3 scenarios, IHME.pdf", replace




* daily ICU beds needed

twoway (rarea DayIcuLoSmA02S01 DayIcuUpSmA02S01 date, sort color(black*.2)) ///
(line DayIcuMeSmA02S01 date, sort lcolor(black)) ///
(line DayIcuMeSmA02S02 date, sort lcolor(green)) ///
(line DayIcuMeSmA02S03 date, sort lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily ICU beds needed) title("COVID-19 daily ICU beds needed $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(2 "Reference" 3 "Better" 4 "Worse") rows(1)) ///
note("Note: Values in the 3 scenarios are identical.")

graph save "graph 26 COVID-19 daily ICU beds needed, $country 3 scenarios, IHME.gph", replace
graph export "graph 26 COVID-19 ICU beds needed, $country 3 scenarios, IHME.pdf", replace




* Tests per 100,000

twoway (rarea testing_lower testing_upper date, sort color(black*.2)) ///
(line testing_mean date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Tests per 100K) title("COVID-19 tests per 100K, $country, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	

graph save "graph 29 COVID-19 Tests per 100,000, $country, IHME.gph", replace
graph export "graph 29 COVID-19 Tests per 100,000, $country, IHME.pdf", replace




* daily hospital-related outcomes

twoway ///
(line DayBedMeSmA02S01 date, sort lcolor(black)) ///
(line DayIcuMeSmA02S01 date, sort lcolor(green)) ///
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Bed" 2 "ICU" 3 "Admission") rows(1)) yscale(titlegap(4))

graph save "graph 31a COVID-19 daily hospital-related outcomes, $country reference scenario, IHME.gph", replace
graph export "graph 31a COVID-19 daily hospital-related outcomes, $country reference scenario, IHME.pdf", replace




* daily hospital-related outcomes, with all_bed_capacity ICU_bed_capacity

twoway ///
(line DayBedMeSmA02S01 date, sort lcolor(black)) ///
(line DayIcuMeSmA02S01 date, sort lcolor(green)) ///
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) ///
(line DayBEDMeSmA02 date, sort lcolor(blue) lpattern(dash)) ///
(line DayICUMeSmA02 date, sort lcolor(cyan) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Bed" 2 "ICU" 3 "Admission" 4 "All bed capacity" 5 "ICU bed capacity") rows(2)) yscale(titlegap(4))

graph save "graph 31b COVID-19 daily hospital-related outcomes, $country reference scenario, IHME all_bed_capacity.gph", replace
graph export "graph 31b COVID-19 daily hospital-related outcomes, $country reference scenario, IHME all_bed_capacity.pdf", replace






* daily hospital-related outcomes, wo beds needed 

twoway ///
(line DayIcuMeSmA02S01 date, sort lcolor(green)) ///
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) ///
(line DayICUMeSmA02 date, sort lcolor(cyan) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "ICU" 2 "Admission" 3 "ICU bed capacity") rows(1)) ///
subtitle("without beds needed", size(small)) yscale(titlegap(4))

graph save "graph 32 COVID-19 daily hospital-related outcomes, $country reference scenario, IHME, wo beds needed.gph", replace
graph export "graph 32 COVID-19 daily hospital-related outcomes, $country reference scenario, IHME, wo beds needed.pdf", replace






* daily % change in mobility, CI

twoway ///
(line mobility_mean_A02S02 date, sort lcolor(green)) ///
(line mobility_mean_A02S03 date, sort lcolor(red)) ///
(line mobility_mean_A02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily % change in mobility from baseline) title("COVID-19 daily % change in mobility, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Better" 2 "Worse" 3 "Reference") rows(1)) 

graph save "graph 33 COVID-19 daily mobility, $country, 3 scenarios.gph", replace
graph export "graph 33 COVID-19 daily mobility, $country, 3 scenarios.pdf", replace





* daily mask_use Percent of population reporting always wearing a mask when leaving home

twoway ///
(line mask_use_mean_A02S02 date, sort lcolor(green)) ///
(line mask_use_mean_A02S03 date, sort lcolor(red)) ///
(line mask_use_mean_A02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily mask use) title("COVID-19 daily mask use, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Better" 2 "Worse" 3 "Reference") rows(1)) ///
subtitle(Percent of population reporting always wearing a mask when leaving home, size(small))

graph save "graph 34 COVID-19 daily mask_use, $country, 3 scenarios.gph", replace
graph export "graph 34 COVID-19 daily mask_use, $country, 3 scenarios.pdf", replace




* daily pneumonia_mean Ratio of pneumonia deaths in a given week to the average weekly pneumonia deaths by location

twoway ///
(line pneumonia_mean date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily ratio of pneumonia deaths) title("COVID-19 daily ratio of pneumonia deaths, $country, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle(Ratio of pneumonia deaths in a given week to the average weekly pneumonia deaths, size(small))

graph save "graph 35 COVID-19 daily ratio of pneumonia deaths, $country.gph", replace
graph export "graph 35 COVID-19 daily ratio of pneumonia deaths, $country.pdf", replace





* cumulative vaccinated number

twoway ///
(line cumulative_all_vaccinated date, sort lcolor(black)) ///
(line cumulative_all_effectively_vacci date, sort lcolor(blue)) ///
(line cumulative_all_fully_vaccinated date, sort lcolor(green) lwidth(thick)) ///
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#13, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Cumulative vaccinated number) title("COVID-19 cumulative vaccinated number, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Vaccinated" 2 "Effectively vaccinated" 3 "Fully vaccinated") rows(1)) ///
note("Vaccinated: Initially vaccinated (one dose of two doses)" ///
"Effectively vaccinated: one and two dose with efficacy" ///
"Fully vaccinated: one of one and two of two doses", size(small))

graph save "graph 36 COVID-19 cumulative vaccinated number, $country.gph", replace
graph export "graph 36 COVID-19 cumulative vaccinated number, $country.pdf", replace




* daily vaccinated number

twoway ///
(line daily_all_vaccinated date, sort lcolor(black)) ///
(line daily_all_effectively_vacci date, sort lcolor(blue)) ///
(line daily_all_fully_vaccinated date, sort lcolor(green) lwidth(thick)) ///
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#13, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily vaccinated number) title("COVID-19 daily vaccinated number, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Vaccinated" 2 "Effectively vaccinated" 3 "Fully vaccinated") rows(1)) ///
note("Vaccinated: Initially vaccinated (one dose of two doses)" ///
"Effectively vaccinated: one and two dose with efficacy" ///
"Fully vaccinated: one of one and two of two doses", size(small))

graph save "graph 36b COVID-19 daily vaccinated number, $country.gph", replace
graph export "graph 36b COVID-19 daily vaccinated number, $country.pdf", replace





* cumulative vaccinated percent

twoway ///
(line cumulative_all_vaccin_pct date, sort lcolor(black)) ///
(line cumul_all_effect_vacci_pct date, sort lcolor(blue)) ///
(line cumul_all_fully_vacci_pct date, sort lcolor(green) lwidth(thick)) ///
if date >= td(01dec2020) ///
, xtitle(Date) xlabel(#13, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(% Cumulative vaccinated percent) title("COVID-19 cumulative vaccinated percent, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "% Vaccinated" 2 "% Effectively vaccinated" 3 "% Fully vaccinated") rows(1)) ///
note("Vaccinated: Initially vaccinated (one dose of two doses)" ///
"Effectively vaccinated: one and two dose with efficacy" ///
"Fully vaccinated: one of one and two of two doses", size(small))

graph save "graph 37 COVID-19 cumulative vaccinated percent, $country.gph", replace
graph export "graph 37 COVID-19 cumulative vaccinated percent, $country.pdf", replace





* daily vaccinated percent

twoway ///
(line daily_all_vaccin_pct date, sort lcolor(black)) ///
(line daily_all_effect_vacci_pct date, sort lcolor(blue)) ///
(line daily_all_fully_vacci_pct date, sort lcolor(green) lwidth(thick)) ///
if date >= td(01dec2020) ///
, xtitle(Date) xlabel(#13, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(% Daily vaccinated percent) title("COVID-19 daily vaccinated percent, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "% Vaccinated" 2 "% Effectively vaccinated" 3 "% Fully vaccinated") rows(1)) ///
note("Vaccinated: Initially vaccinated (one dose of two doses)" ///
"Effectively vaccinated: one and two dose with efficacy" ///
"Fully vaccinated: one of one and two of two doses", size(small))

graph save "graph 37b COVID-19 daily vaccinated percent, $country.gph", replace
graph export "graph 37b COVID-19 daily vaccinated percent, $country.pdf", replace





* R effective, all time

twoway ///
(line reff_mean_A02S02 date, sort lcolor(green)) ///
(line reff_mean_A02S03 date, sort lcolor(red)) ///
(rarea reff_lower_A02S01 reff_upper_A02S01 date, sort color(black*.2)) ///
(line reff_mean_A02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(R effective) title("COVID-19 R effective, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Better" 2 "Worse" 4 "Reference") rows(1)) 

graph save "graph 38 COVID-19 R effective, $country, 3 scenarios.gph", replace
graph export "graph 38 COVID-19 R effective, $country, 3 scenarios.pdf", replace





* R effective, 01jun2021 on

twoway ///
(line reff_mean_A02S02 date, sort lcolor(green) lwidth(thick)) ///
(line reff_mean_A02S03 date, sort lcolor(red) lwidth(thick)) ///
(line reff_lower_A02S03 date, sort lcolor(red*.5) lpattern(dash)) ///
(line reff_upper_A02S03 date, sort lcolor(red*.5) lpattern(dash)) ///
(line reff_mean_A02S01 date, sort lcolor(black) lwidth(thick)) ///
(line reff_lower_A02S01 date, sort lcolor(black*.5) lpattern(dash)) ///
(line reff_upper_A02S01 date, sort lcolor(black*.5) lpattern(dash)) ///
if date >= td(01jun2021) ///
, xtitle(Date) xlabel(#6, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(R effective) title("COVID-19 R effective, $country, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Better" 2 "Worse" 5 "Reference") rows(1)) ///
note(Uncertainty limits: dashed curves)

graph save "graph 39 COVID-19 R effective, $country, 3 scenarios 01jun2021 on.gph", replace
graph export "graph 39 COVID-19 R effective, $country, 3 scenarios 01jun2021 on.pdf", replace






* DayINF DayDea Dea_multip

twoway ///
(line DayINFMeSmA02S01 date, sort lcolor(blue)) ///
(line DayDeaMeSmA02S01 date, sort lcolor(red)) ///
(line DayDMuMeSmA02S01 date, sort lpattern(dot) lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections and deaths) title("COVID-19 daily infections and deaths, $country, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) yscale(titlegap(4)) legend(region(lcolor(none)))  ///
legend(order(1 "Daily infections" 2 "Daily deaths" 3 "Daily deaths scaled for visualization") size(small)) ///
subtitle("Daily deaths, scaled = times (means of infections divided by deaths) for visualization only", size(small)) ///
note("Current scenario, mean estimate")

graph save "graph 45 COVID-19 daily deaths and infections $country, IHME.gph", replace
qui graph export "graph 45 COVID-19 daily deaths and infections $country, IHME.pdf", replace













view "log country IHME.smcl"

log close

exit, clear



