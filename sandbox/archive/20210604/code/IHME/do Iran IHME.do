

clear all

cd "$pathcovir2"

cd IHME

capture log close 

log using "log Iran IHME.smcl", replace

***************************************************************************
* This is "do Iran IHME.do"

* Project: COVID-19 Iran Review No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare IHME study estimates for Iran
***************************************************************************


clear 
 
*****************************

* get IHME estimates

copy https://ihmecovid19storage.blob.core.windows.net/archive/2021-06-04/ihme-covid19.zip ihme-covid19.zip
unzipfile ihme-covid19.zip, replace
erase ihme-covid19.zip

/* The following URL contains the latest IHME updates:
copy https://ihmecovid19storage.blob.core.windows.net/latest/ihme-covid19.zip ihme-covid19.zip
unzipfile ihme-covid19.zip, replace
erase ihme-covid19.zip */


******************************

* import csv files

import delimited using reference_hospitalization_all_locs.csv, clear varnames(1)
save Reference_hospitalization_all_locs.dta, replace
	
import delimited using best_masks_hospitalization_all_locs.csv, clear varnames(1)
save Best_masks_hospitalization_all_locs.dta, replace
	
import delimited using worse_hospitalization_all_locs.csv, clear varnames(1)
save Worse_hospitalization_all_locs.dta, replace



******************************

* read scenario files


**********************

* S1 Reference

use "Reference_hospitalization_all_locs.dta", clear

keep if strpos(location_name, "Iran")


* rename variables

* Total Deaths not smoothed
rename totdea_mean  TotDeaMeRaA02S01
rename totdea_lower TotDeaLoRaA02S01
rename totdea_upper TotDeaUpRaA02S01
label var TotDeaMeRaA02S01 "Total Deaths Mean not smoothed IHME S1"
label var TotDeaLoRaA02S01 "Total Deaths Lower not smoothed IHME S1"
label var TotDeaUpRaA02S01 "Total Deaths Upper not smoothed IHME S1"

* Daily Deaths not smoothed
rename deaths_mean  DayDeaMeRaA02S01
rename deaths_lower DayDeaLoRaA02S01
rename deaths_upper DayDeaUpRaA02S01
label var DayDeaMeRaA02S01 "Daily Deaths Mean not smoothed IHME S1"
label var DayDeaLoRaA02S01 "Daily Deaths Lower not smoothed IHME S1"
label var DayDeaUpRaA02S01 "Daily Deaths Upper not smoothed IHME S1"
	
* Total Cases not smoothed
rename inf_cuml_mean  TotCasMeRaA02S01
rename inf_cuml_lower TotCasLoRaA02S01
rename inf_cuml_upper TotCasUpRaA02S01
label var TotCasMeRaA02S01 "Total Cases Mean not smoothed IHME S1"
label var TotCasLoRaA02S01 "Total Cases Lower not smoothed IHME S1"
label var TotCasUpRaA02S01 "Total Cases Upper not smoothed IHME S1"

* Daily Cases not smoothed
rename est_infections_mean  DayCasMeRaA02S01
rename est_infections_lower DayCasLoRaA02S01
rename est_infections_upper DayCasUpRaA02S01
label var DayCasMeRaA02S01 "Daily Cases Mean not smoothed IHME S1"
label var DayCasLoRaA02S01 "Daily Cases Lower not smoothed IHME S1"
label var DayCasUpRaA02S01 "Daily Cases Upper not smoothed IHME S1"

* Total Deaths smoothed
rename totdea_mean_smoothed   TotDeaMeSmA02S01
rename totdea_lower_smoothed  TotDeaLoSmA02S01
rename totdea_upper_smoothed  TotDeaUpSmA02S01
label var TotDeaMeSmA02S01 "Total Deaths Mean smoothed IHME S1"
label var TotDeaLoSmA02S01 "Total Deaths Lower smoothed IHME S1"
label var TotDeaUpSmA02S01 "Total Deaths Upper smoothed IHME S1"

* Daily Deaths smoothed
rename deaths_mean_smoothed  DayDeaMeSmA02S01    	
rename deaths_lower_smoothed DayDeaLoSmA02S01    	
rename deaths_upper_smoothed DayDeaUpSmA02S01  
label var DayDeaMeSmA02S01 "Daily Deaths Mean smoothed IHME S1"
label var DayDeaLoSmA02S01 "Daily Deaths Lower smoothed IHME S1"
label var DayDeaUpSmA02S01 "Daily Deaths Upper smoothed IHME S1"








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


rename allbed_mean		DayBedMeSmA02S01
rename allbed_lower		DayBedLoSmA02S01
rename allbed_upper		DayBedUpSmA02S01

label var DayBedMeSmA02S01 "Daily Beds needed Mean IHME S1"
label var DayBedLoSmA02S01 "Daily Beds needed Lower IHME S1"
label var DayBedUpSmA02S01 "Daily Beds needed Upper IHME S1"



rename icubed_mean		DayIcuMeSmA02S01
rename icubed_lower		DayIcuLoSmA02S01
rename icubed_upper		DayIcuUpSmA02S01

label var DayIcuMeSmA02S01 "Daily ICU beds needed Mean IHME S1"
label var DayIcuLoSmA02S01 "Daily ICU beds needed Lower IHME S1"
label var DayIcuUpSmA02S01 "Daily ICU beds needed Upper IHME S1"


/* 
rename invven_mean		DayVenMeSmA02S01
rename invven_lower		DayVenLoSmA02S01
rename invven_upper		DayVenUpSmA02S01

label var DayVenMeSmA02S01 "Daily invasive Ventilation needed Mean IHME S1"
label var DayVenLoSmA02S01 "Daily invasive Ventilation needed Lower IHME S1"
label var DayVenUpSmA02S01 "Daily invasive Ventilation needed Upper IHME S1"
*/ 


rename admis_mean		DayAdmMeSmA02S01
rename admis_lower		DayAdmLoSmA02S01
rename admis_upper		DayAdmUpSmA02S01

label var DayAdmMeSmA02S01 "Daily hospital admissions Mean IHME S1"
label var DayAdmLoSmA02S01 "Daily hospital admissions Lower IHME S1"
label var DayAdmUpSmA02S01 "Daily hospital admissions Upper IHME S1"



rename newicu_mean		DayIcnMeSmA02S01
rename newicu_lower		DayIcnLoSmA02S01
rename newicu_upper		DayIcnUpSmA02S01

label var DayIcnMeSmA02S01 "Daily new people going to ICU Mean IHME S1"
label var DayIcnLoSmA02S01 "Daily new people going to ICU Lower IHME S1"
label var DayIcnUpSmA02S01 "Daily new people going to ICU Upper IHME S1"


/* vars bedover and icuover seem to have been retired?

rename bedover_mean			DayBeoMeSmA02S01
rename bedover_lower		DayBeoLoSmA02S01
rename bedover_upper		DayBeoUpSmA02S01

label var DayBeoMeSmA02S01 "Daily bedover [covid all beds needed] - ([total bed capacity] - [average all bed usage]) Mean IHME S1"
label var DayBeoLoSmA02S01 "Daily bedover [covid all beds needed] - ([total bed capacity] - [average all bed usage]) Lower IHME S1"
label var DayBeoUpSmA02S01 "Daily bedover [covid all beds needed] - ([total bed capacity] - [average all bed usage]) Upper IHME S1"



rename icuover_mean			DayIcoMeSmA02S01
rename icuover_lower		DayIcoLoSmA02S01
rename icuover_upper		DayIcoUpSmA02S01

label var DayIcoMeSmA02S01 "Daily icuover [covid ICU beds needed] - ([total ICU capacity] - [average ICU bed usage]) Mean IHME S1"
label var DayIcoLoSmA02S01 "Daily icuover [covid ICU beds needed] - ([total ICU capacity] - [average ICU bed usage]) Lower IHME S1"
label var DayIcoUpSmA02S01 "Daily icuover [covid ICU beds needed] - ([total ICU capacity] - [average ICU bed usage]) Upper IHME S1"
*/ 


rename total_tests TotTesMeSmA02S01

label var TotTesMeSmA02S01 "Total Tests Mean IHME S1"


/* starting on 2021-06-05, using IHME's seroprev_mean in covir2 codes is retired, 
after a number of on-and-offs of existence of this variable in released estimates files. 

rename seroprev_mean 		TotSerMeSmA02S01
rename seroprev_upper 		TotSerLoSmA02S01
rename seroprev_lower		TotSerUpSmA02S01

label var TotSerMeSmA02S01 "Total seroprevalence Mean IHME S1"
label var TotSerLoSmA02S01 "Total seroprevalence Lower IHME S1"
label var TotSerUpSmA02S01 "Total seroprevalence Upper IHME S1"
*/

save "Reference Iran.dta", replace







**********************

* S2 Best

use "Best_masks_hospitalization_all_locs.dta", clear

keep if strpos(location_name, "Iran")


* rename variables


* Total Deaths not smoothed
rename totdea_mean  TotDeaMeRaA02S02V04
rename totdea_lower TotDeaLoRaA02S02V04
rename totdea_upper TotDeaUpRaA02S02V04
label var TotDeaMeRaA02S02V04 "Total Deaths Mean not smoothed IHME S2"
label var TotDeaLoRaA02S02V04 "Total Deaths Lower not smoothed IHME S2"
label var TotDeaUpRaA02S02V04 "Total Deaths Upper not smoothed IHME S2"

* Daily Deaths not smoothed
rename deaths_mean  DayDeaMeRaA02S02V04
rename deaths_lower DayDeaLoRaA02S02V04
rename deaths_upper DayDeaUpRaA02S02V04
label var DayDeaMeRaA02S02V04 "Daily Deaths Mean not smoothed IHME S2"
label var DayDeaLoRaA02S02V04 "Daily Deaths Lower not smoothed IHME S2"
label var DayDeaUpRaA02S02V04 "Daily Deaths Upper not smoothed IHME S2"
	
* Total Cases not smoothed
rename inf_cuml_mean  TotCasMeRaA02S02V04
rename inf_cuml_lower TotCasLoRaA02S02V04
rename inf_cuml_upper TotCasUpRaA02S02V04
label var TotCasMeRaA02S02V04 "Total Cases Mean not smoothed IHME S2"
label var TotCasLoRaA02S02V04 "Total Cases Lower not smoothed IHME S2"
label var TotCasUpRaA02S02V04 "Total Cases Upper not smoothed IHME S2"

* Daily Cases not smoothed
rename est_infections_mean  DayCasMeRaA02S02V04
rename est_infections_lower DayCasLoRaA02S02V04
rename est_infections_upper DayCasUpRaA02S02V04
label var DayCasMeRaA02S02V04 "Daily Cases Mean not smoothed IHME S2"
label var DayCasLoRaA02S02V04 "Daily Cases Lower not smoothed IHME S2"
label var DayCasUpRaA02S02V04 "Daily Cases Upper not smoothed IHME S2"

* Total Deaths smoothed
rename totdea_mean_smoothed   TotDeaMeSmA02S02V04
rename totdea_lower_smoothed  TotDeaLoSmA02S02V04
rename totdea_upper_smoothed  TotDeaUpSmA02S02V04
label var TotDeaMeSmA02S02V04 "Total Deaths Mean smoothed IHME S2"
label var TotDeaLoSmA02S02V04 "Total Deaths Lower smoothed IHME S2"
label var TotDeaUpSmA02S02V04 "Total Deaths Upper smoothed IHME S2"

* Daily Deaths smoothed
rename deaths_mean_smoothed  DayDeaMeSmA02S02V04    	
rename deaths_lower_smoothed DayDeaLoSmA02S02V04    	
rename deaths_upper_smoothed DayDeaUpSmA02S02V04  
label var DayDeaMeSmA02S02V04 "Daily Deaths Mean smoothed IHME S2"
label var DayDeaLoSmA02S02V04 "Daily Deaths Lower smoothed IHME S2"
label var DayDeaUpSmA02S02V04 "Daily Deaths Upper smoothed IHME S2"




* other outcomes


rename total_tests TotTesMeSmA02S02V04

label var TotTesMeSmA02S02V04 "Total Tests Mean IHME S2"


/* starting on 2021-06-05, using IHME's seroprev_mean in covir2 codes is retired, 
after a number of on-and-offs of existence of this variable in released estimates files. 

rename seroprev_mean 		TotSerMeSmA02S02V04
rename seroprev_upper 		TotSerLoSmA02S02V04
rename seroprev_lower		TotSerUpSmA02S02V04

label var TotSerMeSmA02S02V04 "Total seroprevalence Mean IHME S2"
label var TotSerLoSmA02S02V04 "Total seroprevalence Lower IHME S2"
label var TotSerUpSmA02S02V04 "Total seroprevalence Upper IHME S2"
*/

save "Best Iran.dta", replace








**********************

* S3 Worse

use "Worse_hospitalization_all_locs.dta", clear

keep if strpos(location_name, "Iran")



* Total Deaths not smoothed
rename totdea_mean  TotDeaMeRaA02S03V04
rename totdea_lower TotDeaLoRaA02S03V04
rename totdea_upper TotDeaUpRaA02S03V04
label var TotDeaMeRaA02S03V04 "Total Deaths Mean not smoothed IHME S3"
label var TotDeaLoRaA02S03V04 "Total Deaths Lower not smoothed IHME S3"
label var TotDeaUpRaA02S03V04 "Total Deaths Upper not smoothed IHME S3"

* Daily Deaths not smoothed
rename deaths_mean  DayDeaMeRaA02S03V04
rename deaths_lower DayDeaLoRaA02S03V04
rename deaths_upper DayDeaUpRaA02S03V04
label var DayDeaMeRaA02S03V04 "Daily Deaths Mean not smoothed IHME S3"
label var DayDeaLoRaA02S03V04 "Daily Deaths Lower not smoothed IHME S3"
label var DayDeaUpRaA02S03V04 "Daily Deaths Upper not smoothed IHME S3"
	
* Total Cases not smoothed
rename inf_cuml_mean  TotCasMeRaA02S03V04
rename inf_cuml_lower TotCasLoRaA02S03V04
rename inf_cuml_upper TotCasUpRaA02S03V04
label var TotCasMeRaA02S03V04 "Total Cases Mean not smoothed IHME S3"
label var TotCasLoRaA02S03V04 "Total Cases Lower not smoothed IHME S3"
label var TotCasUpRaA02S03V04 "Total Cases Upper not smoothed IHME S3"

* Daily Cases not smoothed
rename est_infections_mean  DayCasMeRaA02S03V04
rename est_infections_lower DayCasLoRaA02S03V04
rename est_infections_upper DayCasUpRaA02S03V04
label var DayCasMeRaA02S03V04 "Daily Cases Mean not smoothed IHME S3"
label var DayCasLoRaA02S03V04 "Daily Cases Lower not smoothed IHME S3"
label var DayCasUpRaA02S03V04 "Daily Cases Upper not smoothed IHME S3"

* Total Deaths smoothed
rename totdea_mean_smoothed   TotDeaMeSmA02S03V04
rename totdea_lower_smoothed  TotDeaLoSmA02S03V04
rename totdea_upper_smoothed  TotDeaUpSmA02S03V04
label var TotDeaMeSmA02S03V04 "Total Deaths Mean smoothed IHME S3"
label var TotDeaLoSmA02S03V04 "Total Deaths Lower smoothed IHME S3"
label var TotDeaUpSmA02S03V04 "Total Deaths Upper smoothed IHME S3"

* Daily Deaths smoothed
rename deaths_mean_smoothed  DayDeaMeSmA02S03V04    	
rename deaths_lower_smoothed DayDeaLoSmA02S03V04    	
rename deaths_upper_smoothed DayDeaUpSmA02S03V04  
label var DayDeaMeSmA02S03V04 "Daily Deaths Mean smoothed IHME S3"
label var DayDeaLoSmA02S03V04 "Daily Deaths Lower smoothed IHME S3"
label var DayDeaUpSmA02S03V04 "Daily Deaths Upper smoothed IHME S3"


* other outcomes

rename total_tests TotTesMeSmA02S03V04

label var TotTesMeSmA02S03V04 "Total Tests Mean IHME S3"


/* starting on 2021-06-05, using IHME's seroprev_mean in covir2 codes is retired, 
after a number of on-and-offs of existence of this variable in released estimates files. 

rename seroprev_mean 		TotSerMeSmA02S03V04
rename seroprev_upper 		TotSerLoSmA02S03V04
rename seroprev_lower		TotSerUpSmA02S03V04

label var TotSerMeSmA02S03V04 "Total seroprevalence Mean IHME S3"
label var TotSerLoSmA02S03V04 "Total seroprevalence Lower IHME S3"
label var TotSerUpSmA02S03V04 "Total seroprevalence Upper IHME S3"
*/


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
total_pop // seroprev_data_type

order deaths_mean_p100k_rate-est_infections_upper_p100k_rate, last


sort date

compress



* gen cfr

gen DayCfrMeRaA02S01 = 100 * DayDeaMeRaA02S01 / DayCasMeRaA02S01
gen DayCfrLoRaA02S01 = 100 * DayDeaLoRaA02S01 / DayCasLoRaA02S01
gen DayCfrUpRaA02S01 = 100 * DayDeaUpRaA02S01 / DayCasUpRaA02S01
gen DayCfrMeRaA02S02V04 = 100 * DayDeaMeRaA02S02V04 / DayCasMeRaA02S02V04
gen DayCfrLoRaA02S02V04 = 100 * DayDeaLoRaA02S02V04 / DayCasLoRaA02S02V04
gen DayCfrUpRaA02S02V04 = 100 * DayDeaUpRaA02S02V04 / DayCasUpRaA02S02V04
gen DayCfrMeRaA02S03V04 = 100 * DayDeaMeRaA02S03V04 / DayCasMeRaA02S03V04
gen DayCfrLoRaA02S03V04 = 100 * DayDeaLoRaA02S03V04 / DayCasLoRaA02S03V04
gen DayCfrUpRaA02S03V04 = 100 * DayDeaUpRaA02S03V04 / DayCasUpRaA02S03V04

label var DayCfrMeRaA02S01 "Daily CFR Mean Raw IHME S1" 
label var DayCfrLoRaA02S01 "Daily CFR Lower Raw IHME S1" 
label var DayCfrUpRaA02S01 "Daily CFR Upper Raw IHME S1" 
label var DayCfrMeRaA02S02V04 "Daily CFR Mean Raw IHME S2" 
label var DayCfrLoRaA02S02V04 "Daily CFR Lower Raw IHME S2" 
label var DayCfrUpRaA02S02V04 "Daily CFR Upper Raw IHME S2" 
label var DayCfrMeRaA02S03V04 "Daily CFR Mean Raw IHME S3" 
label var DayCfrLoRaA02S03V04 "Daily CFR Lower Raw IHME S3" 
label var DayCfrUpRaA02S03V04 "Daily CFR Upper Raw IHME S3" 







label var deaths_mean_p100k_rate "Daily deaths mean raw per 100k rate IHME"

label var deaths_lower_p100k_rate "Daily deaths lower raw per 100k rate IHME"

label var deaths_upper_p100k_rate "Daily deaths upper raw per 100k rate IHME"

label var totdea_mean_p100k_rate "Total deaths mean per raw 100k rate IHME"

label var totdea_lower_p100k_rate "Total deaths mean per raw 100k rate IHME"

label var totdea_upper_p100k_rate "Total deaths upper per raw 100k rate IHME"

label var deaths_mean_smoothed_p100k_rate "Daily deaths mean smoothed per 100k rate IHME"

label var deaths_lower_smoothed_p100k_rate "Daily deaths lower smoothed per 100k rate IHME"

label var deaths_upper_smoothed_p100k_rate "Daily deaths upper smoothed per 100k rate IHME"

label var totdea_mean_smoothed_p100k_rate "Total deaths mean smoothed per 100k rate IHME"

label var totdea_lower_smoothed_p100k_rate "Total deaths lower smoothed per 100k rate IHME"

label var totdea_upper_smoothed_p100k_rate "Total deaths upper smoothed per 100k rate IHME"

label var confirmed_infections_p100k_rate  "confirmed infections per 100k rate IHME"

label var est_infections_mean_p100k_rate "estimated infections mean per 100k rate IHME"

label var est_infections_lower_p100k_rate "estimated infections lower per 100k rate IHME"

label var est_infections_upper_p100k_rate "estimated infections upper per 100k rate IHME"




*



* gen "Daily cases mean div by daily deaths mean IHME DayCbD" for visulization of temporal relation of deaths and cases peaks 


summ DayDeaMeSmA02S01 
gen DayDeMMeSmA02S01 = r(mean)
label var DayDeMMeSmA02S01 "Daily deaths mean IHME DayDeM"

summ DayCasMeRaA02S01 
gen DayCaMMeRaA02S01 = r(mean)
label var DayCaMMeRaA02S01 "Daily cases mean IHME DayCaM"
                           
gen DayCbDMeRaA02S01 = DayCaMMeRaA02S01 / DayDeMMeSmA02S01
label var DayCbDMeRaA02S01 "Daily cases mean div by daily deaths mean IHME DayCbD"
summ DayCbDMeRaA02S01
                                              
gen DayDMuMeRaA02S01 = DayDeaMeRaA02S01 * DayCbDMeRaA02S01
label var DayDMuMeRaA02S01 "Daily deaths scaled (times means of cases by deaths) IHME"
summ DayDMuMeRaA02S01






***********************


* graphs


grstyle init

grstyle color background white


summ date

local xticks = ceil( ( r(max) - r(min) ) / 30 )

di `xticks'



* daily deaths


* daily deaths, medain scenario = S1 	   
	   
twoway (rarea DayDeaLoSmA02S01 DayDeaUpSmA02S01 date, sort color(black*.2)) ///
(line DayDeaMeSmA02S01 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 1 COVID-19 daily deaths, reference scenario, Iran, IHME.gph", replace
graph export "graph 1 COVID-19 daily deaths, reference scenario, Iran, IHME.pdf", replace




* daily deaths, 3 scenarios  
  
twoway ///
(line DayDeaMeSmA02S01 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line DayDeaMeSmA02S02V04 date, sort lcolor(green)) ///
(line DayDeaMeSmA02S03V04 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))

graph save "graph 2 COVID-19 daily deaths, Iran 3 scenarios, IHME.gph", replace
graph export "graph 2 COVID-19 daily deaths, Iran 3 scenarios, IHME.pdf", replace




* daily deaths, medain scenario = S1, CI
  
twoway ///
(line DayDeaMeSmA02S01 date, sort lcolor(black)) ///
(line DayDeaLoSmA02S01 date, sort lcolor(green)) ///
(line DayDeaUpSmA02S01 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IHME, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 3 COVID-19 daily deaths, Iran median scenario CI, IHME.gph", replace
graph export "graph 3 COVID-19 daily deaths, Iran median scenario CI, IHME.pdf", replace




* daily deaths, best scenario = S2, CI
  
twoway ///
(line DayDeaMeSmA02S02V04 date, sort lcolor(black)) ///
(line DayDeaLoSmA02S02V04 date, sort lcolor(green)) ///
(line DayDeaUpSmA02S02V04 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IHME, best scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 4 COVID-19 daily deaths, Iran best scenario CI, IHME.gph", replace
graph export "graph 4 COVID-19 daily deaths, Iran best scenario CI, IHME.pdf", replace




* daily deaths, worst scenario = S3, CI
  
twoway ///
(line DayDeaMeSmA02S03V04 date, sort lcolor(black)) ///
(line DayDeaLoSmA02S03V04 date, sort lcolor(green)) ///
(line DayDeaUpSmA02S03V04 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IHME, worst scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 5 COVID-19 daily deaths, Iran worst scenario CI, IHME.gph", replace
graph export "graph 5 COVID-19 daily deaths, Iran worst scenario CI, IHME.pdf", replace




* daily cases


* daily cases, medain scenario = S1 	   
	   
twoway (rarea DayCasLoRaA02S01 DayCasUpRaA02S01 date, sort color(black*.2)) ///
(line DayCasMeRaA02S01 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 6 COVID-19 daily cases, reference scenario, Iran, IHME.gph", replace
graph export "graph 6 COVID-19 daily cases, reference scenario, Iran, IHME.pdf", replace




* daily cases, 3 scenarios  
  
twoway ///
(line DayCasMeRaA02S01 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line DayCasMeRaA02S02V04 date, sort lcolor(green)) ///
(line DayCasMeRaA02S03V04 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))

graph save "graph 7 COVID-19 daily cases, Iran 3 scenarios, IHME.gph", replace
graph export "graph 7 COVID-19 daily cases, Iran 3 scenarios, IHME.pdf", replace




* daily cases, medain scenario = S1, CI
  
twoway ///
(line DayCasMeRaA02S01 date, sort lcolor(black)) ///
(line DayCasLoRaA02S01 date, sort lcolor(green)) ///
(line DayCasUpRaA02S01 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IHME, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 8 COVID-19 daily cases, Iran median scenario CI, IHME.gph", replace
graph export "graph 8 COVID-19 daily cases, Iran median scenario CI, IHME.pdf", replace




* daily cases, best scenario = S2, CI
  
twoway ///
(line DayCasMeRaA02S02V04 date, sort lcolor(black)) ///
(line DayCasLoRaA02S02V04 date, sort lcolor(green)) ///
(line DayCasUpRaA02S02V04 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IHME, best scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 9 COVID-19 daily cases, Iran best scenario CI, IHME.gph", replace
graph export "graph 9 COVID-19 daily cases, Iran best scenario CI, IHME.pdf", replace




* daily cases, worst scenario = S3, CI
  
twoway ///
(line DayCasMeRaA02S03V04 date, sort lcolor(black)) ///
(line DayCasLoRaA02S03V04 date, sort lcolor(green)) ///
(line DayCasUpRaA02S03V04 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IHME, worst scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 10 COVID-19 daily cases, Iran worst scenario CI, IHME.gph", replace
graph export "graph 10 COVID-19 daily cases, Iran worst scenario CI, IHME.pdf", replace




* total deaths


* total deaths, medain scenario = S1 	   
	   
twoway (rarea TotDeaLoSmA02S01 TotDeaUpSmA02S01 date, sort color(black*.2)) ///
(line TotDeaMeSmA02S01 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 11 COVID-19 total deaths, reference scenario, Iran, IHME.gph", replace
graph export "graph 11 COVID-19 total deaths, reference scenario, Iran, IHME.pdf", replace




* total deaths, 3 scenarios  
  
twoway ///
(line TotDeaMeSmA02S01 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line TotDeaMeSmA02S02V04 date, sort lcolor(green)) ///
(line TotDeaMeSmA02S03V04 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))

graph save "graph 12 COVID-19 total deaths, Iran 3 scenarios, IHME.gph", replace
graph export "graph 12 COVID-19 total deaths, Iran 3 scenarios, IHME.pdf", replace




* total deaths, medain scenario = S1, CI
  
twoway ///
(line TotDeaMeSmA02S01 date, sort lcolor(black)) ///
(line TotDeaLoSmA02S01 date, sort lcolor(green)) ///
(line TotDeaUpSmA02S01 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, IHME, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 13 COVID-19 total deaths, Iran median scenario CI, IHME.gph", replace
graph export "graph 13 COVID-19 total deaths, Iran median scenario CI, IHME.pdf", replace




* total deaths, best scenario = S2, CI
  
twoway ///
(line TotDeaMeSmA02S02V04 date, sort lcolor(black)) ///
(line TotDeaLoSmA02S02V04 date, sort lcolor(green)) ///
(line TotDeaUpSmA02S02V04 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, IHME, best scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 14 COVID-19 total deaths, Iran best scenario CI, IHME.gph", replace
graph export "graph 14 COVID-19 total deaths, Iran best scenario CI, IHME.pdf", replace




* total deaths, worst scenario = S3, CI
  
twoway ///
(line TotDeaMeSmA02S03V04 date, sort lcolor(black)) ///
(line TotDeaLoSmA02S03V04 date, sort lcolor(green)) ///
(line TotDeaUpSmA02S03V04 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, IHME, worst scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 15 COVID-19 total deaths, Iran worst scenario CI, IHME.gph", replace
graph export "graph 15 COVID-19 total deaths, Iran worst scenario CI, IHME.pdf", replace




* total cases


* total cases, medain scenario = S1 	   
	   
twoway (rarea TotCasLoRaA02S01 TotCasUpRaA02S01 date, sort color(black*.2)) ///
(line TotCasMeRaA02S01 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 16 COVID-19 total cases, reference scenario, Iran, IHME.gph", replace
graph export "graph 16 COVID-19 total cases, reference scenario, Iran, IHME.pdf", replace





* total cases, medain scenario = S1, CI
  
twoway ///
(line TotCasMeRaA02S01 date, sort lcolor(black)) ///
(line TotCasLoRaA02S01 date, sort lcolor(green)) ///
(line TotCasUpRaA02S01 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
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
(line DayCfrMeRaA02S01 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line DayCfrMeRaA02S02V04 date, sort lcolor(green)) ///
(line DayCfrMeRaA02S03V04 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))

graph save "graph 21 COVID-19 daily CFR, Iran 3 scenarios, IHME.gph", replace
graph export "graph 21 COVID-19 daily CFR, Iran 3 scenarios, IHME.pdf", replace




* other outcomes 


* daily beds needed, only in S1

twoway (rarea DayBedLoSmA02S01 DayBedUpSmA02S01 date, sort color(black*.2)) ///
(line DayBedMeSmA02S01 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily beds needed) title("COVID-19 daily beds needed, Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	

graph save "graph 22 COVID-19 daily beds needed, Iran 3 scenarios, IHME.gph", replace
graph export "graph 22 COVID-19 daily beds needed, Iran 3 scenarios, IHME.pdf", replace




* ICU beds needed, only in S1

twoway (rarea DayIcuLoSmA02S01 DayIcuUpSmA02S01 date, sort color(black*.2)) ///
(line DayIcuMeSmA02S01 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(ICU beds needed) title("COVID-19 daily ICU beds needed, Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 23 COVID-19 daily ICU beds needed, Iran 3 scenarios, IHME.gph", replace
graph export "graph 23 COVID-19 daily ICU beds needed, Iran 3 scenarios, IHME.pdf", replace



/*
* daily invasive ventilation needed, only in S1

twoway (rarea DayVenLoSmA02S01 DayVenUpSmA02S01 date, sort color(black*.2)) ///
(line DayVenMeSmA02S01 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily invasive ventilation needed) title("COVID-19 daily invasive ventilation Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	  
graph save "graph 24 COVID-19 daily invasive ventilation needed, Iran 3 scenarios, IHME.gph", replace
graph export "graph 24 COVID-19 daily invasive ventilation needed, Iran 3 scenarios, IHME.pdf", replace
*/



* daily hospital admissions, only in S1

twoway (rarea DayAdmLoSmA02S01 DayAdmUpSmA02S01 date, sort color(black*.2)) ///
(line DayAdmMeSmA02S01 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily hospital admissions) title("COVID-19 daily hospital admissions Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 25 COVID-19 daily hospital admissions, Iran 3 scenarios, IHME.gph", replace
graph export "graph 26 COVID-19 daily hospital admissions, Iran 3 scenarios, IHME.pdf", replace




* daily new people going to ICU

twoway (rarea DayIcnLoSmA02S01 DayIcnUpSmA02S01 date, sort color(black*.2)) ///
(line DayIcnMeSmA02S01 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily new people going to ICU) title("COVID-19 daily new people going to ICU Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 26 COVID-19 daily new people going to ICU, Iran 3 scenarios, IHME.gph", replace
graph export "graph 26 COVID-19 daily new people going to ICU, Iran 3 scenarios, IHME.pdf", replace





/*
* daily bed over 


twoway (rarea DayBeoLoSmA02S01 DayBeoUpSmA02S01 date, sort color(black*.2)) ///
(line DayBeoMeSmA02S01 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily bed over) title("COVID-19 daily bed over, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   


graph save "graph 27 COVID-19 daily bed over, Iran 3 scenarios, IHME.gph", replace
graph export "graph 27 COVID-19 daily bed over, Iran 3 scenarios, IHME.pdf", replace




* daily ICU over (has same values as bed over)


twoway (rarea DayIcoLoSmA02S01 DayIcoUpSmA02S01 date, sort color(black*.2)) ///
(line DayIcoMeSmA02S01 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily ICU over) title("COVID-19 daily ICU over, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   

graph save "graph 28 COVID-19 ICU over, Iran 3 scenarios, IHME.gph", replace
graph export "graph 28 COVID-19 ICU over Iran 3 scenarios, IHME.pdf", replace
*/



* total tests

twoway ///
(line TotTesMeSmA02S01 date, sort lcolor(black)) ///
(line TotTesMeSmA02S02V04 date, sort lcolor(green)) ///
(line TotTesMeSmA02S03V04 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.4fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total tests) title("COVID-19 total tests, Iran, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))

graph save "graph 29 COVID-19 total tests, Iran 3 scenarios, IHME.gph", replace
graph export "graph 29 COVID-19 total tests, Iran 3 scenarios, IHME.pdf", replace


/* starting on 2021-06-05, using IHME's seroprev_mean in covir2 codes is retired, 
after a number of on-and-offs of existence of this variable in released estimates files. 

* seroprevalence

twoway ///
(line TotSerMeSmA02S01 date, sort lcolor(black)) ///
(line TotSerMeSmA02S02V04 date, sort lcolor(green)) ///
(line TotSerMeSmA02S03V04 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.5fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total seroprevalence) title("COVID-19 total seroprevalence, Iran, IHME, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))

graph save "graph 30 COVID-19 total seroprevalence, Iran 3 scenarios, IHME.gph", replace
graph export "graph 30 COVID-19 total seroprevalence, Iran 3 scenarios, IHME.pdf", replace
*/




* daily hospital-related outcomes

/*
twoway ///
(line DayBedMeSmA02S01 date, sort lcolor(black)) /// 1 "Bed"
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 2 "ICU"
(line DayVenMeSmA02S01 date, sort lcolor(red)) /// 3 "Vent"
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 4 "Adm"
(line DayIcnMeSmA02S01 date, sort lcolor(blue)) /// 5 "ICU new"
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, IHME, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Bed" 2 "ICU" 3 "Vent" 4 "Adm" 5 "ICU new") rows(2))

graph save "graph 31 COVID-19 daily hospital-related outcomes, Iran median scenario, IHME.gph", replace
graph export "graph 31 COVID-19 daily hospital-related outcomes, Iran median scenario, IHME.pdf", replace
*/


twoway ///
(line DayBedMeSmA02S01 date, sort lcolor(black)) /// 1 "Bed"
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 2 "ICU"
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 3 "Adm"
(line DayIcnMeSmA02S01 date, sort lcolor(blue)) /// 4 "ICU new"
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, IHME, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Bed" 2 "ICU" 3 "Adm" 4 "ICU new") rows(2))

graph save "graph 31 COVID-19 daily hospital-related outcomes, Iran median scenario, IHME.gph", replace
graph export "graph 31 COVID-19 daily hospital-related outcomes, Iran median scenario, IHME.pdf", replace




* daily hospital-related outcomes, wo beds needed 
/*
twoway ///
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 1 "ICU"
(line DayVenMeSmA02S01 date, sort lcolor(red)) /// 2 Vent"
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 3 "Adm"
(line DayIcnMeSmA02S01 date, sort lcolor(blue)) /// 4 "ICU new"
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, IHME, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "ICU" 2 "Vent" 3 "Adm" 4 "ICU new") rows(1)) ///
subtitle("without beds needed", size(small))

graph save "graph 32 COVID-19 daily hospital-related outcomes, Iran median scenario, IHME, wo beds needed.gph", replace
graph export "graph 32 COVID-19 daily hospital-related outcomes, Iran median scenario, IHME, wo beds needed.pdf", replace
*/


twoway ///
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 1 "ICU"
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 2 "Adm"
(line DayIcnMeSmA02S01 date, sort lcolor(blue)) /// 3 "ICU new"
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, IHME, median scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "ICU" 2 "Adm" 3 "ICU new") rows(1)) ///
subtitle("without beds needed", size(small))

graph save "graph 32 COVID-19 daily hospital-related outcomes, Iran median scenario, IHME, wo beds needed.gph", replace
graph export "graph 32 COVID-19 daily hospital-related outcomes, Iran median scenario, IHME, wo beds needed.pdf", replace



* rates

* daily deaths raw per 100k rate

twoway ///
(line deaths_mean_p100k_rate date, sort lcolor(black)) ///
(line deaths_lower_p100k_rate date, sort lcolor(green)) ///
(line deaths_upper_p100k_rate date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths per 100k rate) title("COVID-19 daily deaths raw per 100k rate, Iran, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 40 COVID-19 daily deaths raw per 100k rate, Iran, IHME.gph", replace
graph export "graph 40 COVID-19 daily deaths raw per 100k rate, Iran, IHME.pdf", replace




* daily deaths smoothed per 100k rate

twoway ///
(line deaths_mean_smoothed_p100k_rate date, sort lcolor(black)) ///
(line deaths_lower_smoothed_p100k_rate date, sort lcolor(green)) ///
(line deaths_upper_smoothed_p100k_rate date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths per 100k rate) title("COVID-19 daily deaths smoothed per 100k rate, Iran, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 41 COVID-19 daily deaths smoothed per 100k rate, Iran, IHME.gph", replace
graph export "graph 41 COVID-19 daily deaths smoothed per 100k rate, Iran, IHME.pdf", replace





* total deaths raw per 100k rate

twoway ///
(line totdea_mean_p100k_rate date, sort lcolor(black)) ///
(line totdea_lower_p100k_rate date, sort lcolor(green)) ///
(line totdea_upper_p100k_rate date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths per 100k rate) title("COVID-19 total deaths raw per 100k rate, Iran, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 42 COVID-19 total deaths raw per 100k rate, Iran, IHME.gph", replace
graph export "graph 42 COVID-19 total deaths raw per 100k rate, Iran, IHME.pdf", replace





* total deaths smoothed per 100k rate

twoway ///
(line totdea_mean_smoothed_p100k_rate date, sort lcolor(black)) ///
(line totdea_lower_smoothed_p100k_rate date, sort lcolor(green)) ///
(line totdea_upper_smoothed_p100k_rate date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths per 100k rate) title("COVID-19 total deaths smoothed per 100k rate, Iran, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 43 COVID-19 total deaths smoothed per 100k rate, Iran, IHME.gph", replace
graph export "graph 43 COVID-19 total deaths smoothed per 100k rate, Iran, IHME.pdf", replace




* estimated infections per 100k rate

twoway ///
(line est_infections_mean_p100k_rate date, sort lcolor(black)) ///
(line est_infections_lower_p100k_rate date, sort lcolor(green)) ///
(line est_infections_upper_p100k_rate date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Estimated infections per 100k rate) title("COVID-19 estimated infections per 100k rate, Iran, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Mean" 2 "Lower" 3 "Upper") rows(1))

graph save "graph 44 COVID-19 estimated infections per 100k rate, Iran, IHME.gph", replace
graph export "graph 44 COVID-19 estimated infections per 100k rate, Iran, IHME.pdf", replace





* confirmed infections per 100k rate

twoway ///
(line confirmed_infections_p100k_rate date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Confirmed infections per 100k rate) title("COVID-19 confirmed infections per 100k rate, Iran, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(off)

graph save "graph 44 COVID-19 confirmed per 100k rate, Iran, IHME.gph", replace
graph export "graph 44 COVID-19 confirmed per 100k rate, Iran, IHME.pdf", replace





* DayCas Day Dea_multip

twoway ///
(line DayCasMeRaA02S01 date, sort lcolor(blue)) ///
(line DayDeaMeRaA02S01 date, sort lcolor(red)) ///
(line DayDMuMeRaA02S01 date, sort lpattern(dot) lcolor(red)) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases and deaths) title("COVID-19 daily cases and deaths, Iran, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) yscale(titlegap(4)) legend(region(lcolor(none)))  ///
legend(order(1 "Daily cases" 2 "Daily deaths" 3 "Daily deaths scaled for visualization") size(small)) ///
subtitle("Daily deaths, scaled = times (means of cases divided by deaths) for visualization only", size(small)) ///
note("Current scenario, mean estimate")

qui graph save "graph 45 COVID-19 daily deaths and cases Iran, IHME.gph", replace
qui graph export "graph 45 COVID-19 daily deaths and cases Iran, IHME.pdf", replace

***


drop location_id total_tests_data_type



sort date loc_grand_name

qui compress

// cd ..

save "Iran IHME.dta", replace




view "log Iran IHME.smcl"

log close

exit, clear



