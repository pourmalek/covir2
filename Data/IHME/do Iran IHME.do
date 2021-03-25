

clear all

cd "$pathcovir2"

cd IHME

capture log close 

log using "log Iran IHME.smcl", replace

***************************************************************************
* This is "do Iran IHME.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time: 2021-02-10

* OBJECTIVE: Get and prepare IHME study estimates for Iran, Locate peak dates and values
***************************************************************************


clear 
 
*****************************

* get IHME estimates

 
 
copy https://ihmecovid19storage.blob.core.windows.net/archive/2021-03-11/ihme-covid19.zip ihme-covid19.zip 
unzipfile ihme-covid19.zip, replace
erase ihme-covid19.zip

/* The following URL contains the latest IHME updates:
copy https://ihmecovid19storage.blob.core.windows.net/latest/ihme-covid19.zip ihme-covid19.zip
unzipfile ihme-covid19.zip, replace
erase ihme-covid19.zip */


******************************

* import csv files


/*

*!!! IMPORTANT NOTE !!!: 

Make sure that among different estimations updates which might be downloaded into this directory over a course of more than one to two weeks, 
the only update directory whose directory name is like 2021_03_06 should be the latest estimate. 
Might want to manually rename the previous directories (e.g., 2021_02_25 to some other format, like 2021-02-25). 

	
* Note on scenario changes in IHME COVID-19 model updates:

Since early 2020, IHME COVID-19 model has had three versions of their set of scenarios. 
The very first version had 3 scenarios, a next version had 6 scenarios and included vaccines, 
another version modified vaccine scenarios and added new variants, 
and as of updates 2021 02 25 and 2021 03 06, scenarios are back to the very first version with 3 scenarios. 

Once additional scenarios might be added, the code parts below would need to be updated in order to be able 
to intake the new files' names. 

*/


dis "`c(username)'"
local usrnam = "`c(username)'"
di "`usrnam'"


if regexm(c(os),"Mac") == 1 {
	local path "/Users/`usrnam'/Downloads/covir2-main/Data/IHME" 
	di "`path'"
}
else if regexm(c(os),"Windows") == 1 local path "C:\Users\\`usrnam'\Downloads\covir2-main\Data\IHME"
di "`path'"



if regexm(c(os),"Mac") == 1 {
	local path "/Users/`usrnam'/Downloads/covir2-main/Data/IHME" 
	di "`path'"
}
else if regexm(c(os),"Windows") == 1 {
	local path "C:\Users\\`usrnam'\Downloads\covir2-main\Data\IHME"
	di "`path'"
}
*

* set local folderList and dir (for the latest estimates)


local folderList : dir "`path'" dirs "2021_*"



foreach folder of local folderList {

    di "`folder'"
	
	* get reference_hospitalization_all_locs
	
	if regexm(c(os),"Mac") == 1 {
	import delimited using "`path'/`folder'/reference_hospitalization_all_locs.csv", clear varnames(1)
	save "$pathcovir2/IHME/Reference_hospitalization_all_locs.dta", replace
	}
	else if regexm(c(os),"Windows") == 1 {
	import delimited using "`path'\\`folder'\reference_hospitalization_all_locs.csv", clear varnames(1)
	capture save "$pathcovir2\IHME\Reference_hospitalization_all_locs.dta", replace
	}
	
	
	* get best_masks_hospitalization_all_locs
	
	if regexm(c(os),"Mac") == 1 {
	import delimited using "`path'/`folder'/best_masks_hospitalization_all_locs.csv", clear varnames(1)
	save "$pathcovir2/IHME/Best_masks_hospitalization_all_locs.dta", replace
	}
	else if regexm(c(os),"Windows") == 1 {
	import delimited using "`path'\\`folder'\best_masks_hospitalization_all_locs.csv", clear varnames(1)
	capture save "$pathcovir2\IHME\Best_masks_hospitalization_all_locs.dta", replace
	}
	
	
	* get worse_hospitalization_all_locs
	
	if regexm(c(os),"Mac") == 1 {
	import delimited using "`path'/`folder'/worse_hospitalization_all_locs.csv", clear varnames(1)
	save "$pathcovir2/IHME/Worse_hospitalization_all_locs.dta", replace
	}
	else if regexm(c(os),"Windows") == 1 {
	import delimited using "`path'\\`folder'\worse_hospitalization_all_locs.csv", clear varnames(1)
	capture save "$pathcovir2\IHME\Worse_hospitalization_all_locs.dta", replace	
	}
*
}
*


	



******************************

* read scenario files


**********************

* S1 Reference

use "Reference_hospitalization_all_locs.dta", clear

keep if strpos(location_name, "Iran")


* rename variables

* Total Deaths not smoothed
rename totdea_mean  TotDeaMeRaA02S01V03
rename totdea_lower TotDeaLoRaA02S01V03
rename totdea_upper TotDeaUpRaA02S01V03
label var TotDeaMeRaA02S01V03 "Total Deaths Mean not smoothed IHME S1"
label var TotDeaLoRaA02S01V03 "Total Deaths Lower not smoothed IHME S1"
label var TotDeaUpRaA02S01V03 "Total Deaths Upper not smoothed IHME S1"

* Daily Deaths not smoothed
rename deaths_mean  DayDeaMeRaA02S01V03
rename deaths_lower DayDeaLoRaA02S01V03
rename deaths_upper DayDeaUpRaA02S01V03
label var DayDeaMeRaA02S01V03 "Daily Deaths Mean not smoothed IHME S1"
label var DayDeaLoRaA02S01V03 "Daily Deaths Lower not smoothed IHME S1"
label var DayDeaUpRaA02S01V03 "Daily Deaths Upper not smoothed IHME S1"
	
* Total Cases not smoothed
rename inf_cuml_mean  TotCasMeRaA02S01V03
rename inf_cuml_lower TotCasLoRaA02S01V03
rename inf_cuml_upper TotCasUpRaA02S01V03
label var TotCasMeRaA02S01V03 "Total Cases Mean not smoothed IHME S1"
label var TotCasLoRaA02S01V03 "Total Cases Lower not smoothed IHME S1"
label var TotCasUpRaA02S01V03 "Total Cases Upper not smoothed IHME S1"

* Daily Cases not smoothed
rename est_infections_mean  DayCasMeRaA02S01V03
rename est_infections_lower DayCasLoRaA02S01V03
rename est_infections_upper DayCasUpRaA02S01V03
label var DayCasMeRaA02S01V03 "Daily Cases Mean not smoothed IHME S1"
label var DayCasLoRaA02S01V03 "Daily Cases Lower not smoothed IHME S1"
label var DayCasUpRaA02S01V03 "Daily Cases Upper not smoothed IHME S1"

* Total Deaths smoothed
rename totdea_mean_smoothed   TotDeaMeSmA02S01V03
rename totdea_lower_smoothed  TotDeaLoSmA02S01V03
rename totdea_upper_smoothed  TotDeaUpSmA02S01V03
label var TotDeaMeSmA02S01V03 "Total Deaths Mean smoothed IHME S1"
label var TotDeaLoSmA02S01V03 "Total Deaths Lower smoothed IHME S1"
label var TotDeaUpSmA02S01V03 "Total Deaths Upper smoothed IHME S1"

* Daily Deaths smoothed
rename deaths_mean_smoothed  DayDeaMeSmA02S01V03    	
rename deaths_lower_smoothed DayDeaLoSmA02S01V03    	
rename deaths_upper_smoothed DayDeaUpSmA02S01V03  
label var DayDeaMeSmA02S01V03 "Daily Deaths Mean smoothed IHME S1"
label var DayDeaLoSmA02S01V03 "Daily Deaths Lower smoothed IHME S1"
label var DayDeaUpSmA02S01V03 "Daily Deaths Upper smoothed IHME S1"








* other outcomes 

/*
allbed_mean		Mean covid beds needed by day
allbed_lower	Lower uncertainty bound of covid beds needed by day
allbed_upper	Upper uncertainty bound of covid beds needed by day
icubed_mean		Mean ICU covid beds needed by day
icubed_lower	Lower uncertainty bound of ICU covid beds needed by day
icubed_upper	Upper uncertainty bound of ICU covid beds needed by day
invven_mean		Mean invasive ventilation needed by day
invven_lower	Lower uncertainty bound of invasive ventilation needed by day
invven_upper	Upper uncertainty bound of invasive ventilation needed by day
admis_mean		Mean hospital admissions by day
admis_lower		Lower uncertainty bound of hospital admissions by day
admis_upper		Upper uncertainty bound of hospital admissions by day
newicu_mean		Mean number of new people going to the ICU by day
newicu_lower	Lower uncertainty bound of the number of new people going to the ICU by day
newicu_upper	Upper uncertainty bound of the number of new people going to the ICU by day
bedover_mean	[covid all beds needed] - ([total bed capacity] - [average all bed usage])
bedover_lower	Lower uncertainty bound of bedover (above)
bedover_upper	Upper uncertainty bound of bedover (above)
icuover_mean	[covid ICU beds needed] - ([total ICU capacity] - [average ICU bed usage])
icuover_lower	Lower uncertainty bound of icuover (above)
icuover_upper	Upper uncertainty bound of icuover (above)

total_tests		Total tests

seroprev_mean
seroprev_lower
seroprev_upper  


***********************
* rename convention

allbed		Bed 	covid beds needed by day
icubed		Icu 	ICU covid beds needed by day
invven		Ven 	invasive ventilation needed by day
admis		Adm 	hospital admissions by day
newicu		Icn		number of new people going to the ICU by day
bedover		Beo		[covid all beds needed] - ([total bed capacity] - [average all bed usage])
icuover		Ico		[covid ICU beds needed] - ([total ICU capacity] - [average ICU bed usage])

total_tests		Tes	tests

seroprev_mean	Ser seroprevalence 

*/


rename allbed_mean		DayBedMeSmA02S01V03
rename allbed_lower		DayBedLoSmA02S01V03
rename allbed_upper		DayBedUpSmA02S01V03

label var DayBedMeSmA02S01V03 "Daily Beds needed Mean IHME S1"
label var DayBedLoSmA02S01V03 "Daily Beds needed Lower IHME S1"
label var DayBedUpSmA02S01V03 "Daily Beds needed Upper IHME S1"



rename icubed_mean		DayIcuMeSmA02S01V03
rename icubed_lower		DayIcuLoSmA02S01V03
rename icubed_upper		DayIcuUpSmA02S01V03

label var DayIcuMeSmA02S01V03 "Daily ICU beds needed Mean IHME S1"
label var DayIcuLoSmA02S01V03 "Daily ICU beds needed Lower IHME S1"
label var DayIcuUpSmA02S01V03 "Daily ICU beds needed Upper IHME S1"



rename invven_mean		DayVenMeSmA02S01V03
rename invven_lower		DayVenLoSmA02S01V03
rename invven_upper		DayVenUpSmA02S01V03

label var DayVenMeSmA02S01V03 "Daily invasive Ventilation needed Mean IHME S1"
label var DayVenLoSmA02S01V03 "Daily invasive Ventilation needed Lower IHME S1"
label var DayVenUpSmA02S01V03 "Daily invasive Ventilation needed Upper IHME S1"



rename admis_mean		DayAdmMeSmA02S01V03
rename admis_lower		DayAdmLoSmA02S01V03
rename admis_upper		DayAdmUpSmA02S01V03

label var DayAdmMeSmA02S01V03 "Daily hospital admissions Mean IHME S1"
label var DayAdmLoSmA02S01V03 "Daily hospital admissions Lower IHME S1"
label var DayAdmUpSmA02S01V03 "Daily hospital admissions Upper IHME S1"



rename newicu_mean		DayIcnMeSmA02S01V03
rename newicu_lower		DayIcnLoSmA02S01V03
rename newicu_upper		DayIcnUpSmA02S01V03

label var DayIcnMeSmA02S01V03 "Daily new people going to ICU Mean IHME S1"
label var DayIcnLoSmA02S01V03 "Daily new people going to ICU Lower IHME S1"
label var DayIcnUpSmA02S01V03 "Daily new people going to ICU Upper IHME S1"



rename bedover_mean			DayBeoMeSmA02S01V03
rename bedover_lower		DayBeoLoSmA02S01V03
rename bedover_upper		DayBeoUpSmA02S01V03

label var DayBeoMeSmA02S01V03 "Daily bedover [covid all beds needed] - ([total bed capacity] - [average all bed usage]) Mean IHME S1"
label var DayBeoLoSmA02S01V03 "Daily bedover [covid all beds needed] - ([total bed capacity] - [average all bed usage]) Lower IHME S1"
label var DayBeoUpSmA02S01V03 "Daily bedover [covid all beds needed] - ([total bed capacity] - [average all bed usage]) Upper IHME S1"



rename icuover_mean			DayIcoMeSmA02S01V03
rename icuover_lower		DayIcoLoSmA02S01V03
rename icuover_upper		DayIcoUpSmA02S01V03

label var DayIcoMeSmA02S01V03 "Daily icuover [covid ICU beds needed] - ([total ICU capacity] - [average ICU bed usage]) Mean IHME S1"
label var DayIcoLoSmA02S01V03 "Daily icuover [covid ICU beds needed] - ([total ICU capacity] - [average ICU bed usage]) Lower IHME S1"
label var DayIcoUpSmA02S01V03 "Daily icuover [covid ICU beds needed] - ([total ICU capacity] - [average ICU bed usage]) Upper IHME S1"



rename total_tests TotTesMeSmA02S01V03

label var TotTesMeSmA02S01V03 "Total Tests Mean IHME S1"



rename seroprev_mean 		TotSerMeSmA02S01V03
rename seroprev_upper 		TotSerLoSmA02S01V03
rename seroprev_lower		TotSerUpSmA02S01V03

label var TotSerMeSmA02S01V03 "Total seroprevalence Mean IHME S1"
label var TotSerLoSmA02S01V03 "Total seroprevalence Lower IHME S1"
label var TotSerUpSmA02S01V03 "Total seroprevalence Upper IHME S1"


save "Reference Iran.dta", replace







**********************

* S2 Best

use "Best_masks_hospitalization_all_locs.dta", clear

keep if strpos(location_name, "Iran")


* rename variables


* Total Deaths not smoothed
rename totdea_mean  TotDeaMeRaA02S02V03
rename totdea_lower TotDeaLoRaA02S02V03
rename totdea_upper TotDeaUpRaA02S02V03
label var TotDeaMeRaA02S02V03 "Total Deaths Mean not smoothed IHME S2"
label var TotDeaLoRaA02S02V03 "Total Deaths Lower not smoothed IHME S2"
label var TotDeaUpRaA02S02V03 "Total Deaths Upper not smoothed IHME S2"

* Daily Deaths not smoothed
rename deaths_mean  DayDeaMeRaA02S02V03
rename deaths_lower DayDeaLoRaA02S02V03
rename deaths_upper DayDeaUpRaA02S02V03
label var DayDeaMeRaA02S02V03 "Daily Deaths Mean not smoothed IHME S2"
label var DayDeaLoRaA02S02V03 "Daily Deaths Lower not smoothed IHME S2"
label var DayDeaUpRaA02S02V03 "Daily Deaths Upper not smoothed IHME S2"
	
* Total Cases not smoothed
rename inf_cuml_mean  TotCasMeRaA02S02V03
rename inf_cuml_lower TotCasLoRaA02S02V03
rename inf_cuml_upper TotCasUpRaA02S02V03
label var TotCasMeRaA02S02V03 "Total Cases Mean not smoothed IHME S2"
label var TotCasLoRaA02S02V03 "Total Cases Lower not smoothed IHME S2"
label var TotCasUpRaA02S02V03 "Total Cases Upper not smoothed IHME S2"

* Daily Cases not smoothed
rename est_infections_mean  DayCasMeRaA02S02V03
rename est_infections_lower DayCasLoRaA02S02V03
rename est_infections_upper DayCasUpRaA02S02V03
label var DayCasMeRaA02S02V03 "Daily Cases Mean not smoothed IHME S2"
label var DayCasLoRaA02S02V03 "Daily Cases Lower not smoothed IHME S2"
label var DayCasUpRaA02S02V03 "Daily Cases Upper not smoothed IHME S2"

* Total Deaths smoothed
rename totdea_mean_smoothed   TotDeaMeSmA02S02V03
rename totdea_lower_smoothed  TotDeaLoSmA02S02V03
rename totdea_upper_smoothed  TotDeaUpSmA02S02V03
label var TotDeaMeSmA02S02V03 "Total Deaths Mean smoothed IHME S2"
label var TotDeaLoSmA02S02V03 "Total Deaths Lower smoothed IHME S2"
label var TotDeaUpSmA02S02V03 "Total Deaths Upper smoothed IHME S2"

* Daily Deaths smoothed
rename deaths_mean_smoothed  DayDeaMeSmA02S02V03    	
rename deaths_lower_smoothed DayDeaLoSmA02S02V03    	
rename deaths_upper_smoothed DayDeaUpSmA02S02V03  
label var DayDeaMeSmA02S02V03 "Daily Deaths Mean smoothed IHME S2"
label var DayDeaLoSmA02S02V03 "Daily Deaths Lower smoothed IHME S2"
label var DayDeaUpSmA02S02V03 "Daily Deaths Upper smoothed IHME S2"




* other outcomes


rename total_tests TotTesMeSmA02S02V03

label var TotTesMeSmA02S02V03 "Total Tests Mean IHME S2"



rename seroprev_mean 		TotSerMeSmA02S02V03
rename seroprev_upper 		TotSerLoSmA02S02V03
rename seroprev_lower		TotSerUpSmA02S02V03

label var TotSerMeSmA02S02V03 "Total seroprevalence Mean IHME S2"
label var TotSerLoSmA02S02V03 "Total seroprevalence Lower IHME S2"
label var TotSerUpSmA02S02V03 "Total seroprevalence Upper IHME S2"


save "Best Iran.dta", replace








**********************

* S3 Worse

use "Worse_hospitalization_all_locs.dta", clear

keep if strpos(location_name, "Iran")



* Total Deaths not smoothed
rename totdea_mean  TotDeaMeRaA02S03V03
rename totdea_lower TotDeaLoRaA02S03V03
rename totdea_upper TotDeaUpRaA02S03V03
label var TotDeaMeRaA02S03V03 "Total Deaths Mean not smoothed IHME S3"
label var TotDeaLoRaA02S03V03 "Total Deaths Lower not smoothed IHME S3"
label var TotDeaUpRaA02S03V03 "Total Deaths Upper not smoothed IHME S3"

* Daily Deaths not smoothed
rename deaths_mean  DayDeaMeRaA02S03V03
rename deaths_lower DayDeaLoRaA02S03V03
rename deaths_upper DayDeaUpRaA02S03V03
label var DayDeaMeRaA02S03V03 "Daily Deaths Mean not smoothed IHME S3"
label var DayDeaLoRaA02S03V03 "Daily Deaths Lower not smoothed IHME S3"
label var DayDeaUpRaA02S03V03 "Daily Deaths Upper not smoothed IHME S3"
	
* Total Cases not smoothed
rename inf_cuml_mean  TotCasMeRaA02S03V03
rename inf_cuml_lower TotCasLoRaA02S03V03
rename inf_cuml_upper TotCasUpRaA02S03V03
label var TotCasMeRaA02S03V03 "Total Cases Mean not smoothed IHME S3"
label var TotCasLoRaA02S03V03 "Total Cases Lower not smoothed IHME S3"
label var TotCasUpRaA02S03V03 "Total Cases Upper not smoothed IHME S3"

* Daily Cases not smoothed
rename est_infections_mean  DayCasMeRaA02S03V03
rename est_infections_lower DayCasLoRaA02S03V03
rename est_infections_upper DayCasUpRaA02S03V03
label var DayCasMeRaA02S03V03 "Daily Cases Mean not smoothed IHME S3"
label var DayCasLoRaA02S03V03 "Daily Cases Lower not smoothed IHME S3"
label var DayCasUpRaA02S03V03 "Daily Cases Upper not smoothed IHME S3"

* Total Deaths smoothed
rename totdea_mean_smoothed   TotDeaMeSmA02S03V03
rename totdea_lower_smoothed  TotDeaLoSmA02S03V03
rename totdea_upper_smoothed  TotDeaUpSmA02S03V03
label var TotDeaMeSmA02S03V03 "Total Deaths Mean smoothed IHME S3"
label var TotDeaLoSmA02S03V03 "Total Deaths Lower smoothed IHME S3"
label var TotDeaUpSmA02S03V03 "Total Deaths Upper smoothed IHME S3"

* Daily Deaths smoothed
rename deaths_mean_smoothed  DayDeaMeSmA02S03V03    	
rename deaths_lower_smoothed DayDeaLoSmA02S03V03    	
rename deaths_upper_smoothed DayDeaUpSmA02S03V03  
label var DayDeaMeSmA02S03V03 "Daily Deaths Mean smoothed IHME S3"
label var DayDeaLoSmA02S03V03 "Daily Deaths Lower smoothed IHME S3"
label var DayDeaUpSmA02S03V03 "Daily Deaths Upper smoothed IHME S3"


* other outcomes

rename total_tests TotTesMeSmA02S03V03

label var TotTesMeSmA02S03V03 "Total Tests Mean IHME S3"



rename seroprev_mean 		TotSerMeSmA02S03V03
rename seroprev_upper 		TotSerLoSmA02S03V03
rename seroprev_lower		TotSerUpSmA02S03V03

label var TotSerMeSmA02S03V03 "Total seroprevalence Mean IHME S3"
label var TotSerLoSmA02S03V03 "Total seroprevalence Lower IHME S3"
label var TotSerUpSmA02S03V03 "Total seroprevalence Upper IHME S3"



save "Worse Iran.dta", replace


 
 
 
**********************

 
* merge scenario files


use "Reference Iran.dta", clear
merge 1:1 location_name date using "Best Iran.dta"
drop _merge
merge 1:1 location_name date using "Worse Iran.dta"
drop _merge


rename date date_original
gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date
drop year month day date2



rename location_name loc_grand_name

replace loc_grand_name = "Iran"




drop date_original v1 hosp_data_type deaths_data_type ///
mobility_data_type mobility_composite ///
confirmed_infections_data_type confirmed_infections est_infections_data_type ///
total_pop seroprev_data_type

order deaths_mean_p100k_rate-est_infections_upper_p100k_rate, last


sort date

compress



* gen cfr

gen DayCfrMeRaA02S01V03 = 100 * DayDeaMeRaA02S01V03 / DayCasMeRaA02S01V03
gen DayCfrLoRaA02S01V03 = 100 * DayDeaLoRaA02S01V03 / DayCasLoRaA02S01V03
gen DayCfrUpRaA02S01V03 = 100 * DayDeaUpRaA02S01V03 / DayCasUpRaA02S01V03
gen DayCfrMeRaA02S02V03 = 100 * DayDeaMeRaA02S02V03 / DayCasMeRaA02S02V03
gen DayCfrLoRaA02S02V03 = 100 * DayDeaLoRaA02S02V03 / DayCasLoRaA02S02V03
gen DayCfrUpRaA02S02V03 = 100 * DayDeaUpRaA02S02V03 / DayCasUpRaA02S02V03
gen DayCfrMeRaA02S03V03 = 100 * DayDeaMeRaA02S03V03 / DayCasMeRaA02S03V03
gen DayCfrLoRaA02S03V03 = 100 * DayDeaLoRaA02S03V03 / DayCasLoRaA02S03V03
gen DayCfrUpRaA02S03V03 = 100 * DayDeaUpRaA02S03V03 / DayCasUpRaA02S03V03

label var DayCfrMeRaA02S01V03 "Daily CFR Mean Raw IHME S1" 
label var DayCfrLoRaA02S01V03 "Daily CFR Lower Raw IHME S1" 
label var DayCfrUpRaA02S01V03 "Daily CFR Upper Raw IHME S1" 
label var DayCfrMeRaA02S02V03 "Daily CFR Mean Raw IHME S2" 
label var DayCfrLoRaA02S02V03 "Daily CFR Lower Raw IHME S2" 
label var DayCfrUpRaA02S02V03 "Daily CFR Upper Raw IHME S2" 
label var DayCfrMeRaA02S03V03 "Daily CFR Mean Raw IHME S3" 
label var DayCfrLoRaA02S03V03 "Daily CFR Lower Raw IHME S3" 
label var DayCfrUpRaA02S03V03 "Daily CFR Upper Raw IHME S3" 



* graphs


grstyle init

grstyle color background white


* daily deaths


* daily deaths, medain scenario = S1 	   
	   
	   
twoway (rarea DayDeaLoSmA02S01V03 DayDeaUpSmA02S01V03 date, sort color(black*.2)) ///
(line DayDeaMeSmA02S01V03 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 1 COVID-19 daily deaths, reference scenario, Iran, IHME.gph", replace
graph export "graph 1 COVID-19 daily deaths, reference scenario, Iran, IHME.pdf", replace



* daily deaths, 3 scenarios  
  
  
twoway ///
(line DayDeaMeSmA02S01V03 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line DayDeaMeSmA02S02V03 date, sort lcolor(green)) ///
(line DayDeaMeSmA02S03V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))


graph save "graph 2 COVID-19 daily deaths, Iran 3 scenarios, IHME.gph", replace
graph export "graph 2 COVID-19 daily deaths, Iran 3 scenarios, IHME.pdf", replace



* daily deaths, medain scenario = S1, CI
  
  
twoway ///
(line DayDeaMeSmA02S01V03 date, sort lcolor(black)) ///
(line DayDeaLoSmA02S01V03 date, sort lcolor(green)) ///
(line DayDeaUpSmA02S01V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IHME, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 3 COVID-19 daily deaths, Iran median scenario CI, IHME.gph", replace
graph export "graph 3 COVID-19 daily deaths, Iran median scenario CI, IHME.pdf", replace




* daily deaths, best scenario = S2, CI
  
  
twoway ///
(line DayDeaMeSmA02S02V03 date, sort lcolor(black)) ///
(line DayDeaLoSmA02S02V03 date, sort lcolor(green)) ///
(line DayDeaUpSmA02S02V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IHME, best scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 4 COVID-19 daily deaths, Iran best scenario CI, IHME.gph", replace
graph export "graph 4 COVID-19 daily deaths, Iran best scenario CI, IHME.pdf", replace



* daily deaths, worst scenario = S3, CI
  
  
twoway ///
(line DayDeaMeSmA02S03V03 date, sort lcolor(black)) ///
(line DayDeaLoSmA02S03V03 date, sort lcolor(green)) ///
(line DayDeaUpSmA02S03V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IHME, worst scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 5 COVID-19 daily deaths, Iran worst scenario CI, IHME.gph", replace
graph export "graph 5 COVID-19 daily deaths, Iran worst scenario CI, IHME.pdf", replace


* daily cases


* daily cases, medain scenario = S1 	   
	   
	   
twoway (rarea DayCasLoRaA02S01V03 DayCasUpRaA02S01V03 date, sort color(black*.2)) ///
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 6 COVID-19 daily cases, reference scenario, Iran, IHME.gph", replace
graph export "graph 6 COVID-19 daily cases, reference scenario, Iran, IHME.pdf", replace




* daily cases, 3 scenarios  
  
  
twoway ///
(line DayCasMeRaA02S01V03 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line DayCasMeRaA02S02V03 date, sort lcolor(green)) ///
(line DayCasMeRaA02S03V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))


graph save "graph 7 COVID-19 daily cases, Iran 3 scenarios, IHME.gph", replace
graph export "graph 7 COVID-19 daily cases, Iran 3 scenarios, IHME.pdf", replace



* daily cases, medain scenario = S1, CI
  
  
twoway ///
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) ///
(line DayCasLoRaA02S01V03 date, sort lcolor(green)) ///
(line DayCasUpRaA02S01V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IHME, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 8 COVID-19 daily cases, Iran median scenario CI, IHME.gph", replace
graph export "graph 8 COVID-19 daily cases, Iran median scenario CI, IHME.pdf", replace




* daily cases, best scenario = S2, CI
  
  
twoway ///
(line DayCasMeRaA02S02V03 date, sort lcolor(black)) ///
(line DayCasLoRaA02S02V03 date, sort lcolor(green)) ///
(line DayCasUpRaA02S02V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IHME, best scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 9 COVID-19 daily cases, Iran best scenario CI, IHME.gph", replace
graph export "graph 9 COVID-19 daily cases, Iran best scenario CI, IHME.pdf", replace



* daily cases, worst scenario = S3, CI
  
  
twoway ///
(line DayCasMeRaA02S03V03 date, sort lcolor(black)) ///
(line DayCasLoRaA02S03V03 date, sort lcolor(green)) ///
(line DayCasUpRaA02S03V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IHME, worst scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 10 COVID-19 daily cases, Iran worst scenario CI, IHME.gph", replace
graph export "graph 10 COVID-19 daily cases, Iran worst scenario CI, IHME.pdf", replace



* total deaths


* total deaths, medain scenario = S1 	   
	   
	   
twoway (rarea TotDeaLoSmA02S01V03 TotDeaUpSmA02S01V03 date, sort color(black*.2)) ///
(line TotDeaMeSmA02S01V03 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 11 COVID-19 total deaths, reference scenario, Iran, IHME.gph", replace
graph export "graph 11 COVID-19 total deaths, reference scenario, Iran, IHME.pdf", replace



* total deaths, 3 scenarios  
  
  
twoway ///
(line TotDeaMeSmA02S01V03 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line TotDeaMeSmA02S02V03 date, sort lcolor(green)) ///
(line TotDeaMeSmA02S03V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))


graph save "graph 12 COVID-19 total deaths, Iran 3 scenarios, IHME.gph", replace
graph export "graph 12 COVID-19 total deaths, Iran 3 scenarios, IHME.pdf", replace



* total deaths, medain scenario = S1, CI
  
  
twoway ///
(line TotDeaMeSmA02S01V03 date, sort lcolor(black)) ///
(line TotDeaLoSmA02S01V03 date, sort lcolor(green)) ///
(line TotDeaUpSmA02S01V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, IHME, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 13 COVID-19 total deaths, Iran median scenario CI, IHME.gph", replace
graph export "graph 13 COVID-19 total deaths, Iran median scenario CI, IHME.pdf", replace




* total deaths, best scenario = S2, CI
  
  
twoway ///
(line TotDeaMeSmA02S02V03 date, sort lcolor(black)) ///
(line TotDeaLoSmA02S02V03 date, sort lcolor(green)) ///
(line TotDeaUpSmA02S02V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, IHME, best scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 14 COVID-19 total deaths, Iran best scenario CI, IHME.gph", replace
graph export "graph 14 COVID-19 total deaths, Iran best scenario CI, IHME.pdf", replace



* total deaths, worst scenario = S3, CI
  
  
twoway ///
(line TotDeaMeSmA02S03V03 date, sort lcolor(black)) ///
(line TotDeaLoSmA02S03V03 date, sort lcolor(green)) ///
(line TotDeaUpSmA02S03V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, IHME, worst scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 15 COVID-19 total deaths, Iran worst scenario CI, IHME.gph", replace
graph export "graph 15 COVID-19 total deaths, Iran worst scenario CI, IHME.pdf", replace



* total cases


* total cases, medain scenario = S1 	   
	   
	   
twoway (rarea TotCasLoRaA02S01V03 TotCasUpRaA02S01V03 date, sort color(black*.2)) ///
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 16 COVID-19 total cases, reference scenario, Iran, IHME.gph", replace
graph export "graph 16 COVID-19 total cases, reference scenario, Iran, IHME.pdf", replace




* total cases, 3 scenarios  
  
  
twoway ///
(line TotCasMeRaA02S01V03 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line TotCasMeRaA02S02V03 date, sort lcolor(green)) ///
(line TotCasMeRaA02S03V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))


graph save "graph 17 COVID-19 total cases, Iran 3 scenarios, IHME.gph", replace
graph export "graph 17 COVID-19 total cases, Iran 3 scenarios, IHME.pdf", replace



* total cases, medain scenario = S1, CI
  
  
twoway ///
(line TotCasMeRaA02S01V03 date, sort lcolor(black)) ///
(line TotCasLoRaA02S01V03 date, sort lcolor(green)) ///
(line TotCasUpRaA02S01V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, IHME, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 18 COVID-19 total cases, Iran median scenario CI, IHME.gph", replace
graph export "graph 18 COVID-19 total cases, Iran median scenario CI, IHME.pdf", replace




* total cases, best scenario = S2, CI, not available
 

* total cases, worst scenario = S3, CI, not available
  
  



* cfr




* daily cfr, 3 scenarios  
  
  
twoway ///
(line DayCfrMeRaA02S01V03 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line DayCfrMeRaA02S02V03 date, sort lcolor(green)) ///
(line DayCfrMeRaA02S03V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))


graph save "graph 21 COVID-19 daily CFR, Iran 3 scenarios, IHME.gph", replace
graph export "graph 21 COVID-19 daily CFR, Iran 3 scenarios, IHME.pdf", replace





* other outcomes 


* daily beds needed, only in S1


twoway (rarea DayBedLoSmA02S01V03 DayBedUpSmA02S01V03 date, sort color(black*.2)) ///
(line DayBedMeSmA02S01V03 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily beds needed) title("COVID-19 daily beds needed, Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   

graph save "graph 22 COVID-19 daily beds needed, Iran 3 scenarios, IHME.gph", replace
graph export "graph 22 COVID-19 daily beds needed, Iran 3 scenarios, IHME.pdf", replace




* ICU beds needed, only in S1


twoway (rarea DayIcuLoSmA02S01V03 DayIcuUpSmA02S01V03 date, sort color(black*.2)) ///
(line DayIcuMeSmA02S01V03 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(ICU beds needed) title("COVID-19 daily ICU beds needed, Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   


graph save "graph 23 COVID-19 daily ICU beds needed, Iran 3 scenarios, IHME.gph", replace
graph export "graph 23 COVID-19 daily ICU beds needed, Iran 3 scenarios, IHME.pdf", replace





* daily invasive ventilation needed, only in S1


twoway (rarea DayVenLoSmA02S01V03 DayVenUpSmA02S01V03 date, sort color(black*.2)) ///
(line DayVenMeSmA02S01V03 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily invasive ventilation needed) title("COVID-19 daily invasive ventilation Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   


graph save "graph 24 COVID-19 daily invasive ventilation needed, Iran 3 scenarios, IHME.gph", replace
graph export "graph 24 COVID-19 daily invasive ventilation needed, Iran 3 scenarios, IHME.pdf", replace




* daily hospital admissions, only in S1


twoway (rarea DayAdmLoSmA02S01V03 DayAdmUpSmA02S01V03 date, sort color(black*.2)) ///
(line DayAdmMeSmA02S01V03 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily hospital admissions) title("COVID-19 daily hospital admissions Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   


graph save "graph 25 COVID-19 daily hospital admissions, Iran 3 scenarios, IHME.gph", replace
graph export "graph 26 COVID-19 daily hospital admissions, Iran 3 scenarios, IHME.pdf", replace




* daily new people going to ICU

twoway (rarea DayIcnLoSmA02S01V03 DayIcnUpSmA02S01V03 date, sort color(black*.2)) ///
(line DayIcnMeSmA02S01V03 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily new people going to ICU) title("COVID-19 daily new people going to ICU Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   


graph save "graph 26 COVID-19 daily new people going to ICU, Iran 3 scenarios, IHME.gph", replace
graph export "graph 26 COVID-19 daily new people going to ICU, Iran 3 scenarios, IHME.pdf", replace






* daily bed over 


twoway (rarea DayBeoLoSmA02S01V03 DayBeoUpSmA02S01V03 date, sort color(black*.2)) ///
(line DayBeoMeSmA02S01V03 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily bed over) title("COVID-19 daily bed over, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   


graph save "graph 27 COVID-19 daily bed over, Iran 3 scenarios, IHME.gph", replace
graph export "graph 27 COVID-19 daily bed over, Iran 3 scenarios, IHME.pdf", replace




* daily ICU over (has same values as bed over)


twoway (rarea DayIcoLoSmA02S01V03 DayIcoUpSmA02S01V03 date, sort color(black*.2)) ///
(line DayIcoMeSmA02S01V03 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily ICU over) title("COVID-19 daily ICU over, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   

graph save "graph 28 COVID-19 ICU over, Iran 3 scenarios, IHME.gph", replace
graph export "graph 28 COVID-19 ICU over Iran 3 scenarios, IHME.pdf", replace




* total tests

twoway ///
(line TotTesMeSmA02S01V03 date, sort lcolor(black)) ///
(line TotTesMeSmA02S02V03 date, sort lcolor(green)) ///
(line TotTesMeSmA02S03V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total tests) title("COVID-19 total tests, Iran, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))

graph save "graph 29 COVID-19 total tests, Iran 3 scenarios, IHME.gph", replace
graph export "graph 29 COVID-19 total tests, Iran 3 scenarios, IHME.pdf", replace



* seroprevalence


twoway ///
(line TotSerMeSmA02S01V03 date, sort lcolor(black)) ///
(line TotSerMeSmA02S02V03 date, sort lcolor(green)) ///
(line TotSerMeSmA02S03V03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total seroprevalence) title("COVID-19 total seroprevalence, Iran, IHME, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))

graph save "graph 30 COVID-19 total seroprevalence, Iran 3 scenarios, IHME.gph", replace
graph export "graph 30 COVID-19 total seroprevalence, Iran 3 scenarios, IHME.pdf", replace






* daily hospital-related outcomes

twoway ///
(line DayBedMeSmA02S01V03 date, sort lcolor(black)) ///
(line DayIcuMeSmA02S01V03 date, sort lcolor(green)) ///
(line DayVenMeSmA02S01V03 date, sort lcolor(red)) ///
(line DayAdmMeSmA02S01V03 date, sort lcolor(yellow)) ///
(line DayIcnMeSmA02S01V03 date, sort lcolor(blue)) ///
(line DayBeoMeSmA02S01V03 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, IHME, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Bed" 2 "ICU" 3 "Vent" 4 "Adm" 5 "ICU new" 6 "Bed over") rows(2))


graph save "graph 31 COVID-19 daily hospital-related outcomes, Iran median scenario, IHME.gph", replace
graph export "graph 31 COVID-19 daily hospital-related outcomes, Iran median scenario, IHME.pdf", replace






* daily hospital-related outcomes, wo beds needed 

twoway ///
(line DayIcuMeSmA02S01V03 date, sort lcolor(green)) ///
(line DayVenMeSmA02S01V03 date, sort lcolor(red)) ///
(line DayAdmMeSmA02S01V03 date, sort lcolor(yellow)) ///
(line DayIcnMeSmA02S01V03 date, sort lcolor(blue)) ///
(line DayBeoMeSmA02S01V03 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, IHME, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "ICU" 2 "Vent" 3 "Adm" 4 "ICU new" 5 "Bedover") rows(1)) ///
subtitle("without beds needed", size(small))


graph save "graph 32 COVID-19 daily hospital-related outcomes, Iran median scenario, IHME, wo beds needed.gph", replace
graph export "graph 32 COVID-19 daily hospital-related outcomes, Iran median scenario, IHME, wo beds needed.pdf", replace





*************************************

* Locate peak dates and values - deaths 


* S1 Reference



* first peak

summ DayDeaMeRaA02S01V03 if date > td(01mar2020) & date < td(30apr2020) 

gen DayDeaMeRaA02S01V03P1V = r(max)

summ date if DayDeaMeRaA02S01V03 == DayDeaMeRaA02S01V03P1V & date > td(01mar2020) & date < td(30apr2020)

gen DayDeaMeRaA02S01V03P1D = r(max)

summ DayDeaLoRaA02S01V03 if date == DayDeaMeRaA02S01V03P1D

gen DayDeaLoRaA02S01V03P1V = r(max)

summ DayDeaUpRaA02S01V03 if date == DayDeaMeRaA02S01V03P1D

gen DayDeaUpRaA02S01V03P1V = r(max)

label var DayDeaMeRaA02S01V03P1V "DayDeaMeRaA02S01V03P1V Peak 1 Value"
label var DayDeaMeRaA02S01V03P1D "DayDeaMeRaA02S01V03P1D Peak 1 Date"
label var DayDeaLoRaA02S01V03P1V "DayDeaLoRaA02S01V03P1V Peak 1 Value"
label var DayDeaUpRaA02S01V03P1V "DayDeaUpRaA02S01V03P1V Peak 1 Value"
format DayDeaMeRaA02S01V03P1D %tdDDMonCCYY

tab1 DayDeaMeRaA02S01V03P1V DayDeaLoRaA02S01V03P1V DayDeaUpRaA02S01V03P1V DayDeaMeRaA02S01V03P1D


* second peak 

summ DayDeaMeRaA02S01V03 if date > td(01jul2020) & date < td(30jul2020) 

gen DayDeaMeRaA02S01V03P2V = r(max)

summ date if DayDeaMeRaA02S01V03 == DayDeaMeRaA02S01V03P2V & date > td(01jul2020) & date < td(30jul2020) 

gen DayDeaMeRaA02S01V03P2D = r(max)

summ DayDeaLoRaA02S01V03 if date == DayDeaMeRaA02S01V03P2D

gen DayDeaLoRaA02S01V03P2V = r(max)

summ DayDeaUpRaA02S01V03 if date == DayDeaMeRaA02S01V03P2D

gen DayDeaUpRaA02S01V03P2V = r(max)

label var DayDeaMeRaA02S01V03P2V "DayDeaMeRaA02S01V03P2V Peak 2 Value"
label var DayDeaMeRaA02S01V03P2D "DayDeaMeRaA02S01V03P2D Peak 2 Date"
label var DayDeaLoRaA02S01V03P2V "DayDeaLoRaA02S01V03P2V Peak 2 Value"
label var DayDeaUpRaA02S01V03P2V "DayDeaUpRaA02S01V03P2V Peak 2 Value"
format DayDeaMeRaA02S01V03P2D %tdDDMonCCYY

tab1 DayDeaMeRaA02S01V03P2V DayDeaLoRaA02S01V03P2V DayDeaLoRaA02S01V03P2V DayDeaMeRaA02S01V03P2D


* third peak 

summ DayDeaMeRaA02S01V03 if date > td(01nov2020) & date < td(30nov2020) 

gen DayDeaMeRaA02S01V03P3V = r(max)

summ date if DayDeaMeRaA02S01V03 == DayDeaMeRaA02S01V03P3V & date > td(01nov2020) & date < td(30nov2020) 

gen DayDeaMeRaA02S01V03P3D = r(max)

summ DayDeaLoRaA02S01V03 if date == DayDeaMeRaA02S01V03P3D

gen DayDeaLoRaA02S01V03P3V = r(max)

summ DayDeaUpRaA02S01V03 if date == DayDeaMeRaA02S01V03P3D

gen DayDeaUpRaA02S01V03P3V = r(max)

label var DayDeaMeRaA02S01V03P3V "DayDeaMeRaA02S01V03P2V Peak 3 Value"
label var DayDeaMeRaA02S01V03P3D "DayDeaMeRaA02S01V03P3D Peak 3 Date"
label var DayDeaLoRaA02S01V03P3V "DayDeaLoRaA02S01V03P3V Peak 3 Value"
label var DayDeaUpRaA02S01V03P3V "DayDeaUpRaA02S01V03P3V Peak 3 Value"
format DayDeaMeRaA02S01V03P3D %tdDDMonCCYY

tab1 DayDeaMeRaA02S01V03P3V DayDeaLoRaA02S01V03P3V DayDeaUpRaA02S01V03P3V DayDeaMeRaA02S01V03P3D


* fourth peak

summ DayDeaMeRaA02S01V03 if date > td(01mar2021) 

gen DayDeaMeRaA02S01V03P4V = r(max)

summ date if DayDeaMeRaA02S01V03 == DayDeaMeRaA02S01V03P4V & date > td(01mar2021) 

gen DayDeaMeRaA02S01V03P4D = r(max)

summ DayDeaLoRaA02S01V03 if date == DayDeaMeRaA02S01V03P4D

gen DayDeaLoRaA02S01V03P4V = r(max)

summ DayDeaUpRaA02S01V03 if date == DayDeaMeRaA02S01V03P4D

gen DayDeaUpRaA02S01V03P4V = r(max)

label var DayDeaMeRaA02S01V03P4V "DayDeaMeRaA02S01V03P4V Peak 4 Value"
label var DayDeaMeRaA02S01V03P4D "DayDeaMeRaA02S01V03P4D Peak 4 Date"
label var DayDeaLoRaA02S01V03P4V "DayDeaLoRaA02S01V03P4V Peak 4 Value"
label var DayDeaUpRaA02S01V03P4V "DayDeaUpRaA02S01V03P4V Peak 4 Value"
format DayDeaMeRaA02S01V03P4D %tdDDMonCCYY

tab1 DayDeaMeRaA02S01V03P4V DayDeaLoRaA02S01V03P4V DayDeaUpRaA02S01V03P4V DayDeaMeRaA02S01V03P4D


* end date avialable (P8)

summ date if DayDeaMeRaA02S01V03 != . 

gen A02DZ = r(max) 

summ DayDeaMeRaA02S01V03 if date == A02DZ

gen DayDeaMeRaA02S01V03P8V = r(max)

summ DayDeaLoRaA02S01V03 if date == A02DZ

gen DayDeaLoRaA02S01V03P8V = r(max)

summ DayDeaUpRaA02S01V03 if date == A02DZ

gen DayDeaUpRaA02S01V03P8V = r(max)

label var DayDeaMeRaA02S01V03P8V "DayDeaMeRaA02S01V03P8V End Value"
label var DayDeaLoRaA02S01V03P8V "DayDeaLoRaA02S01V03P8V End Value"
label var DayDeaUpRaA02S01V03P8V "DayDeaUpRaA02S01V03P8V End Value"
format A02DZ %tdDDMonCCYY

tab1 DayDeaMeRaA02S01V03P8V DayDeaLoRaA02S01V03P8V DayDeaUpRaA02S01V03P8V A02DZ


* S2 Best

* the first three peaks show same values for S1 and S2 

* fourth peak

summ DayDeaMeSmA02S02V03 if date > td(01mar2021) 

gen DayDeaMeSmA02S02V03P4V = r(max)

summ date if DayDeaMeSmA02S02V03 == DayDeaMeSmA02S02V03P4V & date > td(01mar2021) 

gen DayDeaMeSmA02S02V03P4D = r(max)

summ DayDeaLoSmA02S02V03 if date == DayDeaMeSmA02S02V03P4D

gen DayDeaLoSmA02S02V03P4V = r(max)

summ DayDeaUpSmA02S02V03 if date == DayDeaMeSmA02S02V03P4D

gen DayDeaUpSmA02S02V03P4V = r(max)

label var DayDeaMeSmA02S02V03P4V "DayDeaMeSmA02S02V03P4V Peak 4 Value"
label var DayDeaMeSmA02S02V03P4D "DayDeaMeSmA02S02V03P4D Peak 4 Date"
label var DayDeaLoSmA02S02V03P4V "DayDeaLoSmA02S02V03P4V Peak 4 Value"
label var DayDeaUpSmA02S02V03P4V "DayDeaUpSmA02S02V03P4V Peak 4 Value"
format DayDeaMeSmA02S02V03P4D %tdDDMonCCYY

tab1 DayDeaMeSmA02S02V03P4V DayDeaLoSmA02S02V03P4V DayDeaUpSmA02S02V03P4V DayDeaMeSmA02S02V03P4D


* end date avialable (P8)

summ DayDeaMeSmA02S02V03 if date == A02DZ

gen DayDeaMeSmA02S02V03P8V = r(max)

summ DayDeaLoSmA02S02V03 if date == A02DZ

gen DayDeaLoSmA02S02V03P8V = r(max)

summ DayDeaUpSmA02S02V03 if date == A02DZ

gen DayDeaUpSmA02S02V03P8V = r(max)

label var DayDeaMeSmA02S02V03P8V "DayDeaMeSmA02S02V03P8V End Value"
label var DayDeaLoSmA02S02V03P8V "DayDeaLoSmA02S02V03P8V End Value"
label var DayDeaUpSmA02S02V03P8V "DayDeaUpSmA02S02V03P8V End Value"

tab1 DayDeaMeSmA02S02V03P8V DayDeaLoSmA02S02V03P8V DayDeaUpSmA02S02V03P8V A02DZ




* S3 Worse estiamtes 

* fourth peak 

summ DayDeaMeSmA02S03V03 if date > td(01mar2021) 

gen DayDeaMeSmA02S03V03P4V = r(max)

label var DayDeaMeSmA02S03V03P4V "DayDeaMeSmA02S03V03P4V Peak 4 Value"

summ date if DayDeaMeSmA02S03V03 == DayDeaMeSmA02S03V03P4V & date > td(01mar2021) 

gen DayDeaMeSmA02S03V03P4D = r(max)

label var DayDeaMeSmA02S03V03P4D "DayDeaMeSmA02S03V03P4V Peak 4 Date"

format DayDeaMeSmA02S03V03P4D %tdDDMonCCYY

summ DayDeaLoSmA02S03V03 if date == DayDeaMeSmA02S03V03P4D

gen DayDeaLoSmA02S03V03P4V = r(max)

label var DayDeaLoSmA02S03V03P4V "DayDeaLoSmA02S03V03 Peak 4 Value"

summ DayDeaUpSmA02S03V03 if date == DayDeaMeSmA02S03V03P4D

gen DayDeaUpSmA02S03V03P4V = r(max)

label var DayDeaUpSmA02S03V03P4V "DayDeaUpSmA02S03V03 Peak 4 Value"

tab1 DayDeaMeSmA02S03V03P4V DayDeaLoSmA02S03V03P4V DayDeaUpSmA02S03V03P4V DayDeaMeSmA02S03V03P4D



* end date avialable (P8)

summ DayDeaMeSmA02S03V03 if date == A02DZ

gen DayDeaMeSmA02S03V03P8V = r(max) 

label var DayDeaMeSmA02S03V03P8V "DayDeaMeSmA02S03V03 End Value"

summ DayDeaLoSmA02S03V03 if date == A02DZ

gen DayDeaLoSmA02S03V03P8V = r(max) 

label var DayDeaLoSmA02S03V03P8V "DayDeaLoSmA02S03V03 End Value"

summ DayDeaUpSmA02S03V03 if date == A02DZ

gen DayDeaUpSmA02S03V03P8V = r(max) 

label var DayDeaUpSmA02S03V03P8V "DayDeaUpSmA02S03V03 End Value" 

format A02DZ %tdDDMonCCYY

tab1 DayDeaMeSmA02S03V03P8V DayDeaLoSmA02S03V03P8V DayDeaUpSmA02S03V03P8V A02DZ






*************************************

* Locate peak dates and values - cases 


* S1 Reference

* first peak

summ DayCasMeRaA02S01V03 if date > td(01mar2020) & date < td(30may2020) 

gen DayCasMeRaA02S01V03P1V = r(max)

summ date if DayCasMeRaA02S01V03 == DayCasMeRaA02S01V03P1V & date > td(01mar2020) & date < td(30may2020) 

gen DayCasMeRaA02S01V03P1D = r(max)

summ DayCasLoRaA02S01V03 if date == DayCasMeRaA02S01V03P1D

gen DayCasLoRaA02S01V03P1V = r(max)

summ DayCasUpRaA02S01V03 if date == DayCasMeRaA02S01V03P1D

gen DayCasUpRaA02S01V03P1V = r(max)

label var DayCasMeRaA02S01V03P1V "DayCasMeRaA02S01V03P1V Peak 1 Value"
label var DayCasMeRaA02S01V03P1D "DayCasMeRaA02S01V03P1D Peak 1 Date"
label var DayCasLoRaA02S01V03P1V "DayCasLoRaA02S01V03P1V Peak 1 Value"
label var DayCasUpRaA02S01V03P1V "DayCasUpRaA02S01V03P1V Peak 1 Value"
format DayCasMeRaA02S01V03P1D %tdDDMonCCYY

tab1 DayCasMeRaA02S01V03P1V DayCasLoRaA02S01V03P1V DayCasUpRaA02S01V03P1V DayCasMeRaA02S01V03P1D


* second peak 

summ DayCasMeRaA02S01V03 if date > td(01jun2020) & date < td(30aug2020)

gen DayCasMeRaA02S01V03P2V = r(max)

summ date if DayCasMeRaA02S01V03 == DayCasMeRaA02S01V03P2V & date > td(01jun2020) & date < td(30aug2020) 

gen DayCasMeRaA02S01V03P2D = r(max)

summ DayCasLoRaA02S01V03 if date == DayCasMeRaA02S01V03P2D

gen DayCasLoRaA02S01V03P2V = r(max)

summ DayCasUpRaA02S01V03 if date == DayCasMeRaA02S01V03P2D

gen DayCasUpRaA02S01V03P2V = r(max)

label var DayCasMeRaA02S01V03P2V "DayCasMeRaA02S01V03P2V Peak 2 Value"
label var DayCasMeRaA02S01V03P2D "DayCasMeRaA02S01V03P2D Peak 2 Date"
label var DayCasLoRaA02S01V03P2V "DayCasLoRaA02S01V03P2V Peak 2 Value"
label var DayCasUpRaA02S01V03P2V "DayCasUpRaA02S01V03P2V Peak 2 Value"
format DayCasMeRaA02S01V03P2D %tdDDMonCCYY

tab1 DayCasMeRaA02S01V03P2V DayCasLoRaA02S01V03P2V DayCasUpRaA02S01V03P2V DayCasMeRaA02S01V03P2D


* third peak 

summ DayCasMeRaA02S01V03 if date > td(01oct2020) & date < td(30nov2020) 

gen DayCasMeRaA02S01V03P3V = r(max)

summ date if DayCasMeRaA02S01V03 == DayCasMeRaA02S01V03P3V & date > td(01oct2020) & date < td(30nov2020) 

gen DayCasMeRaA02S01V03P3D = r(max)

summ DayCasLoRaA02S01V03 if date == DayCasMeRaA02S01V03P3D 

gen DayCasLoRaA02S01V03P3V = r(max)

summ DayCasUpRaA02S01V03 if date == DayCasMeRaA02S01V03P3D

gen DayCasUpRaA02S01V03P3V = r(max)

label var DayCasMeRaA02S01V03P3V "DayCasMeRaA02S01V03P3V Peak 3 Value"
label var DayCasMeRaA02S01V03P3D "DayCasMeRaA02S01V03P3D Peak 3 Date"
label var DayCasLoRaA02S01V03P3V "DayCasLoRaA02S01V03P3V Peak 3 Value"
label var DayCasUpRaA02S01V03P3V "DayCasUpRaA02S01V03P3V Peak 3 Value"
format DayCasMeRaA02S01V03P3D %tdDDMonCCYY

tab1 DayCasMeRaA02S01V03P3V DayCasLoRaA02S01V03P3V DayCasUpRaA02S01V03P3V DayCasMeRaA02S01V03P3D


* fourth peak

summ DayCasMeRaA02S01V03 if date > td(01mar2021) 

gen DayCasMeRaA02S01V03P4V = r(max)

summ date if DayCasMeRaA02S01V03 == DayCasMeRaA02S01V03P4V & date > td(01jan2021) 

gen DayCasMeRaA02S01V03P4D = r(max)

summ DayCasLoRaA02S01V03 if date == DayCasMeRaA02S01V03P4D

gen DayCasLoRaA02S01V03P4V = r(max)

summ DayCasUpRaA02S01V03 if date == DayCasMeRaA02S01V03P4D

gen DayCasUpRaA02S01V03P4V = r(max)

label var DayCasMeRaA02S01V03P4V "DayCasMeRaA02S01V03P4V Peak 4 Value"
label var DayCasMeRaA02S01V03P4D "DayCasMeRaA02S01V03P4D Peak 4 Date"
label var DayCasLoRaA02S01V03P4V "DayCasLoRaA02S01V03P4V Peak 4 Value"
label var DayCasUpRaA02S01V03P4V "DayCasUpRaA02S01V03P4V Peak 4 Value"
format DayCasMeRaA02S01V03P4D %tdDDMonCCYY

tab1 DayCasMeRaA02S01V03P4V DayCasLoRaA02S01V03P4V DayCasUpRaA02S01V03P4V DayCasMeRaA02S01V03P4D


* end date avialable (P8)

summ DayCasMeRaA02S01V03 if date == A02DZ

gen DayCasMeRaA02S01V03P8V = r(max)

summ DayCasLoRaA02S01V03 if date == A02DZ

gen DayCasLoRaA02S01V03P8V = r(max)

summ DayCasUpRaA02S01V03 if date == A02DZ

gen DayCasUpRaA02S01V03P8V = r(max)

label var A02DZ "A02 End date"
label var DayCasMeRaA02S01V03P8V "DayCasMeRaA02S01V03 End Value"
label var DayCasLoRaA02S01V03P8V "DayCasLoRaA02S01V03 End Value"
label var DayCasUpRaA02S01V03P8V "DayCasUpRaA02S01V03 End Value"
format A02DZ %tdDDMonCCYY

tab1 DayCasMeRaA02S01V03P8V DayCasLoRaA02S01V03P8V DayCasUpRaA02S01V03P8V A02DZ



* S2 Best


* fourth peak

summ DayCasMeRaA02S02V03 if date > td(01mar2021) 

gen DayCasMeRaA02S02V03P4V = r(max)

summ date if DayCasMeRaA02S02V03 == DayCasMeRaA02S02V03P4V & date > td(01jan2021) 

gen DayCasMeRaA02S02V03P4D = r(max)

summ DayCasLoRaA02S02V03 if date == DayCasMeRaA02S02V03P4D

gen DayCasLoRaA02S02V03P4V = r(max)

summ DayCasUpRaA02S02V03 if date == DayCasMeRaA02S02V03P4D

gen DayCasUpRaA02S02V03P4V = r(max)

label var DayCasMeRaA02S02V03P4V "DayCasMeRaA02S01V03P4V Peak 4 Value"
label var DayCasMeRaA02S02V03P4D "DayCasMeRaA02S01V03P4D Peak 4 Date"
label var DayCasLoRaA02S02V03P4V "DayCasLoRaA02S01V03P4V Peak 4 Value"
label var DayCasUpRaA02S02V03P4V "DayCasUpRaA02S01V03P4V Peak 4 Value"
format DayCasMeRaA02S02V03P4D %tdDDMonCCYY

tab1 DayCasMeRaA02S02V03P4V DayCasLoRaA02S02V03P4V DayCasUpRaA02S02V03P4V DayCasMeRaA02S02V03P4D


* end date avialable (P8)

summ DayCasMeRaA02S02V03 if date == A02DZ

gen DayCasMeRaA02S02V03P8V = r(max)

summ DayCasLoRaA02S02V03 if date == A02DZ

gen DayCasLoRaA02S02V03P8V = r(max)

summ DayCasUpRaA02S02V03 if date == A02DZ

gen DayCasUpRaA02S02V03P8V = r(max)

label var DayCasMeRaA02S02V03P8V "DayCasMeRaA02S02V03 End Value"
label var DayCasLoRaA02S02V03P8V "DayCasLoRaA02S02V03 End Value"
label var DayCasUpRaA02S02V03P8V "DayCasUpRaA02S02V03 End Value"


* S3 Worse estiamtes 


* fourth peak

summ DayCasMeRaA02S03V03 if date > td(01mar2021) 

gen DayCasMeRaA02S03V03P4V = r(max)

summ date if DayCasMeRaA02S03V03 == DayCasMeRaA02S03V03P4V & date > td(01mar2021) 

gen DayCasMeRaA02S03V03P4D = r(max)

summ DayCasLoRaA02S03V03 if date == DayCasMeRaA02S03V03P4D

gen DayCasLoRaA02S03V03P4V = r(max)

summ DayCasUpRaA02S03V03 if date == DayCasMeRaA02S03V03P4D

gen DayCasUpRaA02S03V03P4V = r(max)

label var DayCasMeRaA02S03V03P4V "DayCasMeRaA02S01V03P4V Peak 4 Value"
label var DayCasMeRaA02S03V03P4D "DayCasMeRaA02S01V03P4D Peak 4 Date"
label var DayCasLoRaA02S03V03P4V "DayCasLoRaA02S01V03P4V Peak 4 Value"
label var DayCasUpRaA02S03V03P4V "DayCasUpRaA02S01V03P4V Peak 4 Value"
format DayCasMeRaA02S03V03P4D %tdDDMonCCYY

tab1 DayCasMeRaA02S03V03P4V DayCasLoRaA02S03V03P4V DayCasUpRaA02S03V03P4V DayCasMeRaA02S03V03P4D


* end date avialable (P8)

summ DayCasMeRaA02S03V03 if date == A02DZ

gen DayCasMeRaA02S03V03P8V = r(max)

summ DayCasLoRaA02S03V03 if date == A02DZ

gen DayCasLoRaA02S03V03P8V = r(max)

summ DayCasUpRaA02S03V03 if date == A02DZ

gen DayCasUpRaA02S03V03P8V = r(max)

label var DayCasMeRaA02S03V03P8V "DayCasMeRaA02S03V03 End Value"
label var DayCasLoRaA02S03V03P8V "DayCasLoRaA02S03V03 End Value"
label var DayCasUpRaA02S03V03P8V "DayCasUpRaA02S03V03 End Value"
format A02DZ %tdDDMonCCYY

tab1 DayCasMeRaA02S03V03P8V DayCasLoRaA02S03V03P8V DayCasUpRaA02S03V03P8V A02DZ







sort date

compress

save "Iran IHME.dta", replace

*

*************

* gen peaks table

use "Iran IHME.dta", clear

keep *D *V

collapse *

foreach v in  * {
rename (`v') S`v'
}
*
 

foreach v in  * {
rename (`v') `v'j
}
*

gen i = _n

reshape long S, i(i) j(j, string)

drop i
rename j varnames
rename S varvalues

gen varnames_new = substr(varnames,1,19) 
drop varnames
rename varnames_new varnames

order varnames varvalues

* gen peakname peakvalue for outcomes
* gen peakdate datevalue for dates

gen type = substr(varnames,19,1) 

gen peakname  = varnames
gen peakvalue = varvalues

replace peakname  = "" if type == "D"
replace peakvalue = .  if type == "D"

replace peakvalue = round(peakvalue)

gen peakdate  = varnames
gen datevalue = varvalues

replace peakdate  = "" if type == "V"
replace datevalue = .  if type == "V"

format datevalue %tdDDMonCCYY

drop varvalues

replace type = "Peak date" if type == "D"
replace type = "Outcome value" if type == "V"


save "Iran IHME peaks.dta", replace

export delimited using "Iran IHME peaks.csv", replace 

view "log Iran IHME.smcl"

log close

exit, clear



