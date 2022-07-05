
clear all

cd "$pathcovir2"

cd IMPE

capture log close 

log using "log country IMPE.smcl", replace

*****************************************************************************
* This is "do country IMPE.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare IMPErial study estimates for country
*****************************************************************************


																 

clear 

*****************************

* get IMPE estimates

di "$IMPEdate"

copy https://raw.githubusercontent.com/mrc-ide/global-lmic-reports/master/data/$IMPEdate.csv.zip $IMPEdate.csv.zip
unzipfile $IMPEdate.csv.zip, replace
erase $IMPEdate.csv.zip


 
******************************

* import csv file


import delimited "$IMPEdate.csv", clear varnames(1)

keep if regexm(country,"$country") == 1




* gen date 

rename date date_original

gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2)
egen dateblock = concat(year month day)
drop year month day


* rename uncertainty limits

rename y_025	y_025_
rename y_25 	y_250_
rename y_median y_med_
rename y_mean 	y_mea_
rename y_75 	y_750_
rename y_975	y_975_


foreach var of varlist y_025-y_975 {
	ds `var'
	label variable `var' `r(varlist)'
}
*



* rename scenarios 

tab scenario 


/*
Scenarios:

S1  "Additional 50% Reduction"			"S1_Add_Half_Reduction"
S2  "Maintain Status Quo"				"S2_Maintain_Staus_Quo"
S3  "Relax Interventions 50%" 			"S3_Relax_Half_Intervention"

S4  "Surged Additional 50% Reduction"	"S4_Surged_Add_Half_Reduction"
S5  "Surged Maintain Status Quo"		"S5_Surged_Maintain_Staus_Quo"
S6  "Surged Relax Interventions 50%"	"S6_Surged_Relax_Half_Intervention"

With IMPE update 20211103 (2021-12-13_v9.csv.zip) released on 20211110., IMPE has new terms for their scenarios:

S1	Optimistic
S2	Maintain Status Quo
S3	Pessimistic

S4	Surged Optimistic
S5	Surged Maintain Status Quo
S6	Surged Pessimistic
*/



gen scenario_snail = ""
replace scenario_snail = "S1" if scenario == "Optimistic"
replace scenario_snail = "S2" if scenario == "Maintain Status Quo"
replace scenario_snail = "S3" if scenario == "Pessimistic"
replace scenario_snail = "S4" if scenario == "Surged Optimistic"
replace scenario_snail = "S5" if scenario == "Surged Maintain Status Quo"
replace scenario_snail = "S6" if scenario == "Surged Pessimistic"



gen underline = "_"
egen scenario_snail_dateblock = concat(scenario_snail underline dateblock)

drop date_original scenario

drop scenario_snail_dateblock 
  
drop y_250_ y_med_ y_750_
 

* Primary outcomes Total Deaths, Total infections, Daily Deaths, and Daily infections

replace compartment = "cumul_death" if compartment == "cumulative_deaths"
replace compartment = "cumul_infec" if compartment == "cumulative_infections"
replace compartment = "daily_death" if compartment == "deaths"
replace compartment = "daily_infec" if compartment == "infections"


* other outcomes

replace compartment = "icu___deman" if compartment == "ICU_demand" 			// Icd
replace compartment = "icu___incid" if compartment == "ICU_incidence"		// Ici
replace compartment = "reff_______" if compartment == "Reff"				// Ref
replace compartment = "rt_________" if compartment == "Rt"					// Rtt
replace compartment = "hospi_deman" if compartment == "hospital_demand"		// Hod
replace compartment = "hospi_incid" if compartment == "hospital_incidence"  // Hoi
replace compartment = "preval_____" if compartment == "prevalence"			// Pre


duplicates drop date compartment scenario, force



* reshape


egen compartment_scenario_snail = concat(compartment underline scenario_snail)	

drop compartment underline scenario_snail

tab compartment_scenario_snail



reshape wide y_025_   y_mea_  y_975_, i(country dateblock) j(compartment_scenario_snail) string


*



foreach v of varlist y_025_cumul_death_S1-y_975_rt__________S6 { 

	local first = substr("`v'", 7, 11) 
	local second = substr("`v'", 6, 1)
	local third  = substr("`v'", 1, 5)
	local fourth = substr("`v'", 19, 2)
	label var `v' "`first'`second'`third'`second'`fourth'"
} 
*



foreach v of varlist y_025_cumul_death_S1-y_975_rt__________S6 { 
	di `"`: var label `v''"' 
	local fifth `"`: var label `v''"'
	rename `v'   `fifth'
}
*


* gen date

gen year = substr(dateblock,1,4) 
gen month = substr(dateblock,5,2) 
gen day = substr(dateblock,7,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date



* 


* get renvars



/*

* After 
net from  http://www.stata-journal.com/software/sj5-4
Stata might return the following:

host not found
http://www.stata-journal.com/software/sj5-4/ either
  1)  is not a valid URL, or
  2)  could not be contacted, or
  3)  is not a Stata download site (has no stata.toc file).

current site is still http://fmwww.bc.edu/repec/bocode/g/

* Bad internet connetion is the issue. Try again / later. 


*/

net from  http://www.stata-journal.com/software/sj5-4

net describe dm88_1

net install dm88_1




* 

* -renvars- somanyvars rather time consuming

foreach v of varlist cumul_death_y_025_S1-rt__________y_975_S6 { 

    qui renvars, presub(cumul_death_y_025_ TotDeaLoRa)
    qui renvars, presub(cumul_death_y_975_ TotDeaUpRa)
    qui renvars, presub(cumul_death_y_mea_ TotDeaMeRa)

	qui renvars, presub(daily_death_y_025_ DayDeaLoRa)
	qui renvars, presub(daily_death_y_975_ DayDeaUpRa)
	qui renvars, presub(daily_death_y_mea_ DayDeaMeRa)
	
    qui renvars, presub(cumul_infec_y_025_ TotINFLoRa)
    qui renvars, presub(cumul_infec_y_975_ TotINFUpRa)
    qui renvars, presub(cumul_infec_y_mea_ TotINFMeRa)
	
	qui renvars, presub(daily_infec_y_025_ DayINFLoRa)
	qui renvars, presub(daily_infec_y_975_ DayINFUpRa)
	qui renvars, presub(daily_infec_y_mea_ DayINFMeRa)
	
	* other outcomes
	
	qui renvars, presub(icu___deman_y_025_ DayIcdLoRa) // "ICU_demand" 
	qui renvars, presub(icu___deman_y_975_ DayIcdUpRa)
	qui renvars, presub(icu___deman_y_mea_ DayIcdMeRa)
	
	qui renvars, presub(icu___incid_y_025_ DayIciLoRa) // "ICU_incidence"
	qui renvars, presub(icu___incid_y_975_ DayIciUpRa)
	qui renvars, presub(icu___incid_y_mea_ DayIciMeRa)
	
	qui renvars, presub(reff________y_025_ DayRefLoRa) // "Reff"
	qui renvars, presub(reff________y_975_ DayRefUpRa)
	qui renvars, presub(reff________y_mea_ DayRefMeRa)
	
	qui renvars, presub(rt__________y_025_ DayRttLoRa) // "Rt"
	qui renvars, presub(rt__________y_975_ DayRttUpRa)
	qui renvars, presub(rt__________y_mea_ DayRttMeRa)
	
	qui renvars, presub(hospi_deman_y_025_ DayHodLoRa) // "hospital_demand"
	qui renvars, presub(hospi_deman_y_975_ DayHodUpRa)
	qui renvars, presub(hospi_deman_y_mea_ DayHodMeRa)
	
	qui renvars, presub(hospi_incid_y_025_ DayHoiLoRa) // "hospital_incidence"
	qui renvars, presub(hospi_incid_y_975_ DayHoiUpRa)
	qui renvars, presub(hospi_incid_y_mea_ DayHoiMeRa)
	
	qui renvars, presub(preval______y_025_ DayPreLoRa) // "prevalence"
	qui renvars, presub(preval______y_975_ DayPreUpRa)
	qui renvars, presub(preval______y_mea_ DayPreMeRa)
	
	qui renvars, postsub(S1 A03S01) 
	qui renvars, postsub(S2 A03S02) 
	qui renvars, postsub(S3 A03S03) 
	qui renvars, postsub(S4 A03S04) 
	qui renvars, postsub(S5 A03S05) 
	qui renvars, postsub(S6 A03S06) 
	
	* "Wait Note: renvars are working ..."
	
} 
*   



*

drop iso3c report_date version death_calibrated year month day date2 dateblock

order date  

label var DayINFLoRaA03S01 "Daily infections Lower A03 S01 "
label var DayINFLoRaA03S02 "Daily infections Lower A03 S02 "
label var DayINFLoRaA03S03 "Daily infections Lower A03 S03 "
label var DayINFLoRaA03S04 "Daily infections Lower A03 S04 "
label var DayINFLoRaA03S05 "Daily infections Lower A03 S05 "
label var DayINFLoRaA03S06 "Daily infections Lower A03 S06 "
label var DayINFMeRaA03S01 "Daily infections Mean A03 S01 "
label var DayINFMeRaA03S02 "Daily infections Mean A03 S02 "
label var DayINFMeRaA03S03 "Daily infections Mean A03 S03 "
label var DayINFMeRaA03S04 "Daily infections Mean A03 S04 "
label var DayINFMeRaA03S05 "Daily infections Mean A03 S05 "
label var DayINFMeRaA03S06 "Daily infections Mean A03 S06 "
label var DayINFUpRaA03S01 "Daily infections Upper A03 S01 "
label var DayINFUpRaA03S02 "Daily infections Upper A03 S02 "
label var DayINFUpRaA03S03 "Daily infections Upper A03 S03 "
label var DayINFUpRaA03S04 "Daily infections Upper A03 S04 "
label var DayINFUpRaA03S05 "Daily infections Upper A03 S05 "
label var DayINFUpRaA03S06 "Daily infections Upper A03 S06 "
label var DayDeaLoRaA03S01 "Daily Deaths Lower A03 S01 "
label var DayDeaLoRaA03S02 "Daily Deaths Lower A03 S02 "
label var DayDeaLoRaA03S03 "Daily Deaths Lower A03 S03 "
label var DayDeaLoRaA03S04 "Daily Deaths Lower A03 S04 "
label var DayDeaLoRaA03S05 "Daily Deaths Lower A03 S05 "
label var DayDeaLoRaA03S06 "Daily Deaths Lower A03 S06 "
label var DayDeaMeRaA03S01 "Daily Deaths Mean A03 S01 "
label var DayDeaMeRaA03S02 "Daily Deaths Mean A03 S02 "
label var DayDeaMeRaA03S03 "Daily Deaths Mean A03 S03 "
label var DayDeaMeRaA03S04 "Daily Deaths Mean A03 S04 "
label var DayDeaMeRaA03S05 "Daily Deaths Mean A03 S05 "
label var DayDeaMeRaA03S06 "Daily Deaths Mean A03 S06 "
label var DayDeaUpRaA03S01 "Daily Deaths Upper A03 S01 "
label var DayDeaUpRaA03S02 "Daily Deaths Upper A03 S02 "
label var DayDeaUpRaA03S03 "Daily Deaths Upper A03 S03 "
label var DayDeaUpRaA03S04 "Daily Deaths Upper A03 S04 "
label var DayDeaUpRaA03S05 "Daily Deaths Upper A03 S05 "
label var DayDeaUpRaA03S06 "Daily Deaths Upper A03 S06 "
label var TotINFLoRaA03S01 "Total infections Lower A03 S01 "
label var TotINFLoRaA03S02 "Total infections Lower A03 S02 " 
label var TotINFLoRaA03S03 "Total infections Lower A03 S03 " 
label var TotINFLoRaA03S04 "Total infections Lower A03 S04 "
label var TotINFLoRaA03S05 "Total infections Lower A03 S05 "
label var TotINFLoRaA03S06 "Total infections Lower A03 S06 "
label var TotINFMeRaA03S01 "Total infections Mean A03 S01 " 
label var TotINFMeRaA03S02 "Total infections Mean A03 S02 " 
label var TotINFMeRaA03S03 "Total infections Mean A03 S03 "
label var TotINFMeRaA03S04 "Total infections Mean A03 S04 "
label var TotINFMeRaA03S05 "Total infections Mean A03 S05 "
label var TotINFMeRaA03S06 "Total infections Mean A03 S06 "
label var TotINFUpRaA03S01 "Total infections Upper A03 S01 "
label var TotINFUpRaA03S02 "Total infections Upper A03 S02 "
label var TotINFUpRaA03S03 "Total infections Upper A03 S03 "
label var TotINFUpRaA03S04 "Total infections Upper A03 S04 "
label var TotINFUpRaA03S05 "Total infections Upper A03 S05 "
label var TotINFUpRaA03S06 "Total infections Upper A03 S06 "
label var TotDeaLoRaA03S01 "Total Deaths Lower A03 S01 "
label var TotDeaLoRaA03S02 "Total Deaths Lower A03 S02 " 
label var TotDeaLoRaA03S03 "Total Deaths Lower A03 S03 "
label var TotDeaLoRaA03S04 "Total Deaths Lower A03 S04 "
label var TotDeaLoRaA03S05 "Total Deaths Lower A03 S05 "
label var TotDeaLoRaA03S06 "Total Deaths Lower A03 S06 "
label var TotDeaMeRaA03S01 "Total Deaths Mean A03 S01 "
label var TotDeaMeRaA03S02 "Total Deaths Mean A03 S02 "
label var TotDeaMeRaA03S03 "Total Deaths Mean A03 S03 "
label var TotDeaMeRaA03S04 "Total Deaths Mean A03 S04 "
label var TotDeaMeRaA03S05 "Total Deaths Mean A03 S05 "
label var TotDeaMeRaA03S06 "Total Deaths Mean A03 S06 "
label var TotDeaUpRaA03S01 "Total Deaths Upper A03 S01 "
label var TotDeaUpRaA03S02 "Total Deaths Upper A03 S02 "
label var TotDeaUpRaA03S03 "Total Deaths Upper A03 S03 "
label var TotDeaUpRaA03S04 "Total Deaths Upper A03 S04 "
label var TotDeaUpRaA03S05 "Total Deaths Upper A03 S05 "
label var TotDeaUpRaA03S06 "Total Deaths Upper A03 S06 "


* other outcomes

label var DayHodMeRaA03S01 "Daily hospital demand Mean A03 S01 "
label var DayHodLoRaA03S01 "Daily hospital demand Lower A03 S01 "
label var DayHodUpRaA03S01 "Daily hospital demand Upper A03 S01 "
label var DayHodMeRaA03S02 "Daily hospital demand Mean A03 S02 "
label var DayHodLoRaA03S02 "Daily hospital demand Lower A03 S02 "
label var DayHodUpRaA03S02 "Daily hospital demand Upper A03 S02 "
label var DayHodMeRaA03S03 "Daily hospital demand Mean A03 S03 "
label var DayHodLoRaA03S03 "Daily hospital demand Lower A03 S03 "
label var DayHodUpRaA03S03 "Daily hospital demand Upper A03 S03 "
label var DayHodMeRaA03S04 "Daily hospital demand Mean A03 S04 "
label var DayHodLoRaA03S04 "Daily hospital demand Lower A03 S04 "
label var DayHodUpRaA03S04 "Daily hospital demand Upper A03 S04 " 
label var DayHodMeRaA03S05 "Daily hospital demand Mean A03 S05 "
label var DayHodLoRaA03S05 "Daily hospital demand Lower A03 S05 "
label var DayHodUpRaA03S05 "Daily hospital demand Upper A03 S05 "
label var DayHodMeRaA03S06 "Daily hospital demand Mean A03 S06 "
label var DayHodLoRaA03S06 "Daily hospital demand Lower A03 S06 "
label var DayHodUpRaA03S06 "Daily hospital demand Upper A03 S06 "


label var DayHoiMeRaA03S01 "Daily hospital incidence Mean A03 S01 "
label var DayHoiLoRaA03S01 "Daily hospital incidence Lower A03 S01 "
label var DayHoiUpRaA03S01 "Daily hospital incidence Upper A03 S01 "
label var DayHoiMeRaA03S02 "Daily hospital incidence Mean A03 S02 "
label var DayHoiLoRaA03S02 "Daily hospital incidence Lower A03 S02 "
label var DayHoiUpRaA03S02 "Daily hospital incidence Upper A03 S02 "
label var DayHoiMeRaA03S03 "Daily hospital incidence Mean A03 S03 "
label var DayHoiLoRaA03S03 "Daily hospital incidence Lower A03 S03 "
label var DayHoiUpRaA03S03 "Daily hospital incidence Upper A03 S03 "
label var DayHoiMeRaA03S04 "Daily hospital incidence Mean A03 S04 "
label var DayHoiLoRaA03S04 "Daily hospital incidence Lower A03 S04 "
label var DayHoiUpRaA03S04 "Daily hospital incidence Upper A03 S04 "
label var DayHoiMeRaA03S05 "Daily hospital incidence Mean A03 S05 "
label var DayHoiLoRaA03S05 "Daily hospital incidence Lower A03 S05 "
label var DayHoiUpRaA03S05 "Daily hospital incidence Upper A03 S05 "
label var DayHoiMeRaA03S06 "Daily hospital incidence Mean A03 S06 "
label var DayHoiLoRaA03S06 "Daily hospital incidence Lower A03 S06 "
label var DayHoiUpRaA03S06 "Daily hospital incidence Upper A03 S06 "


label var DayIcdMeRaA03S01 "Daily ICU demand Mean A03 S01 "
label var DayIcdLoRaA03S01 "Daily ICU demand Lower A03 S01 "
label var DayIcdUpRaA03S01 "Daily ICU demand Upper A03 S01 "
label var DayIcdMeRaA03S02 "Daily ICU demand Mean A03 S02 "
label var DayIcdLoRaA03S02 "Daily ICU demand Lower A03 S02 "
label var DayIcdUpRaA03S02 "Daily ICU demand Upper A03 S02 "
label var DayIcdMeRaA03S03 "Daily ICU demand Mean A03 S03 "
label var DayIcdLoRaA03S03 "Daily ICU demand Lower A03 S03 "
label var DayIcdUpRaA03S03 "Daily ICU demand Upper A03 S03 "
label var DayIcdMeRaA03S04 "Daily ICU demand Mean A03 S04 "
label var DayIcdLoRaA03S04 "Daily ICU demand Lower A03 S04 "
label var DayIcdUpRaA03S04 "Daily ICU demand Upper A03 S04 "
label var DayIcdMeRaA03S05 "Daily ICU demand Mean A03 S05 "
label var DayIcdLoRaA03S05 "Daily ICU demand Lower A03 S05 "
label var DayIcdUpRaA03S05 "Daily ICU demand Upper A03 S05 "
label var DayIcdMeRaA03S06 "Daily ICU demand Mean A03 S06 "
label var DayIcdLoRaA03S06 "Daily ICU demand Lower A03 S06 "
label var DayIcdUpRaA03S06 "Daily ICU demand Upper A03 S06 "


label var DayIciMeRaA03S01 "Daily ICU incidence Mean A03 S01 "
label var DayIciLoRaA03S01 "Daily ICU incidence Lower A03 S01 "
label var DayIciUpRaA03S01 "Daily ICU incidence Upper A03 S01 "
label var DayIciMeRaA03S02 "Daily ICU incidence Mean A03 S02 "
label var DayIciLoRaA03S02 "Daily ICU incidence Lower A03 S02 "
label var DayIciUpRaA03S02 "Daily ICU incidence Upper A03 S02 "
label var DayIciMeRaA03S03 "Daily ICU incidence Mean A03 S03 "
label var DayIciLoRaA03S03 "Daily ICU incidence Lower A03 S03 "
label var DayIciUpRaA03S03 "Daily ICU incidence Upper A03 S03 "
label var DayIciMeRaA03S04 "Daily ICU incidence Mean A03 S04 "
label var DayIciLoRaA03S04 "Daily ICU incidence Lower A03 S04 "
label var DayIciUpRaA03S04 "Daily ICU incidence Upper A03 S04 "
label var DayIciMeRaA03S05 "Daily ICU incidence Mean A03 S05 "
label var DayIciLoRaA03S05 "Daily ICU incidence Lower A03 S05 "
label var DayIciUpRaA03S05 "Daily ICU incidence Upper A03 S05 "
label var DayIciMeRaA03S06 "Daily ICU incidence Mean A03 S06 "
label var DayIciLoRaA03S06 "Daily ICU incidence Lower A03 S06 "
label var DayIciUpRaA03S06 "Daily ICU incidence Upper A03 S06 "


label var DayPreMeRaA03S01 "Daily prevalence Mean A03 S01 "
label var DayPreLoRaA03S01 "Daily prevalence Lower A03 S01 "
label var DayPreUpRaA03S01 "Daily prevalence Upper A03 S01 "
label var DayPreMeRaA03S02 "Daily prevalence Mean A03 S02 "
label var DayPreLoRaA03S02 "Daily prevalence Lower A03 S02 "
label var DayPreUpRaA03S02 "Daily prevalence Upper A03 S02 "
label var DayPreMeRaA03S03 "Daily prevalence Mean A03 S03 "
label var DayPreLoRaA03S03 "Daily prevalence Lower A03 S03 "
label var DayPreUpRaA03S03 "Daily prevalence Upper A03 S03 "
label var DayPreMeRaA03S04 "Daily prevalence Mean A03 S04 "
label var DayPreLoRaA03S04 "Daily prevalence Lower A03 S04 "
label var DayPreUpRaA03S04 "Daily prevalence Upper A03 S04 "
label var DayPreMeRaA03S05 "Daily prevalence Mean A03 S05 "
label var DayPreLoRaA03S05 "Daily prevalence Lower A03 S05 "
label var DayPreUpRaA03S05 "Daily prevalence Upper A03 S05 "
label var DayPreMeRaA03S06 "Daily prevalence Mean A03 S06 "
label var DayPreLoRaA03S06 "Daily prevalence Lower A03 S06 "
label var DayPreUpRaA03S06 "Daily prevalence Upper A03 S06 "

label var DayRefMeRaA03S01 "Daily R effective Mean A03 S01 "
label var DayRefLoRaA03S01 "Daily R effective Lower A03 S01 "
label var DayRefUpRaA03S01 "Daily R effective Upper A03 S01 "
label var DayRefMeRaA03S02 "Daily R effective Mean A03 S02 "
label var DayRefLoRaA03S02 "Daily R effective Lower A03 S02 "
label var DayRefUpRaA03S02 "Daily R effective Upper A03 S02 "
label var DayRefMeRaA03S03 "Daily R effective Mean A03 S03 "
label var DayRefLoRaA03S03 "Daily R effective Lower A03 S03 "
label var DayRefUpRaA03S03 "Daily R effective Upper A03 S03 "
label var DayRefMeRaA03S04 "Daily R effective Mean A03 S04 "
label var DayRefLoRaA03S04 "Daily R effective Lower A03 S04 "
label var DayRefUpRaA03S04 "Daily R effective Upper A03 S04 "
label var DayRefMeRaA03S05 "Daily R effective Mean A03 S05 "
label var DayRefLoRaA03S05 "Daily R effective Lower A03 S05 "
label var DayRefUpRaA03S05 "Daily R effective Upper A03 S05 "
label var DayRefMeRaA03S06 "Daily R effective Mean A03 S06 "
label var DayRefLoRaA03S06 "Daily R effective Lower A03 S06 "
label var DayRefUpRaA03S06 "Daily R effective Upper A03 S06 "

label var DayRttMeRaA03S01 "Daily R t Mean A03 S01 "
label var DayRttLoRaA03S01 "Daily R t Lower A03 S01 "
label var DayRttUpRaA03S01 "Daily R t Upper A03 S01 "
label var DayRttMeRaA03S02 "Daily R t Mean A03 S02 "
label var DayRttLoRaA03S02 "Daily R t Lower A03 S02 "
label var DayRttUpRaA03S02 "Daily R t Upper A03 S02 "
label var DayRttMeRaA03S03 "Daily R t Mean A03 S03 "
label var DayRttLoRaA03S03 "Daily R t Lower A03 S03 "
label var DayRttUpRaA03S03 "Daily R t Upper A03 S03 "
label var DayRttMeRaA03S04 "Daily R t Mean A03 S04 "
label var DayRttLoRaA03S04 "Daily R t Lower A03 S04 "
label var DayRttUpRaA03S04 "Daily R t Upper A03 S04 "
label var DayRttMeRaA03S05 "Daily R t Mean A03 S05 "
label var DayRttLoRaA03S05 "Daily R t Lower A03 S05 "
label var DayRttUpRaA03S05 "Daily R t Upper A03 S05 "
label var DayRttMeRaA03S06 "Daily R t Mean A03 S06 "
label var DayRttLoRaA03S06 "Daily R t Lower A03 S06 "
label var DayRttUpRaA03S06 "Daily R t Upper A03 S06 "


rename country loc_grand_name



order ///
loc_grand_name date	///
TotDeaMeRaA03S01	TotDeaLoRaA03S01	TotDeaUpRaA03S01	///
TotDeaMeRaA03S02	TotDeaLoRaA03S02	TotDeaUpRaA03S02	///
TotDeaMeRaA03S03	TotDeaLoRaA03S03	TotDeaUpRaA03S03	///
TotDeaMeRaA03S04	TotDeaLoRaA03S04	TotDeaUpRaA03S04	///
TotDeaMeRaA03S05	TotDeaLoRaA03S05	TotDeaUpRaA03S05	///
TotDeaMeRaA03S06	TotDeaLoRaA03S06	TotDeaUpRaA03S06	///
DayDeaMeRaA03S01	DayDeaLoRaA03S01	DayDeaUpRaA03S01	///
DayDeaMeRaA03S02	DayDeaLoRaA03S02	DayDeaUpRaA03S02	///
DayDeaMeRaA03S03	DayDeaLoRaA03S03	DayDeaUpRaA03S03	///
DayDeaMeRaA03S04	DayDeaLoRaA03S04	DayDeaUpRaA03S04	///
DayDeaMeRaA03S05	DayDeaLoRaA03S05	DayDeaUpRaA03S05	///
DayDeaMeRaA03S06	DayDeaLoRaA03S06	DayDeaUpRaA03S06	///
TotINFMeRaA03S01	TotINFLoRaA03S01	TotINFUpRaA03S01	///
TotINFMeRaA03S02	TotINFLoRaA03S02	TotINFUpRaA03S02	///
TotINFMeRaA03S03	TotINFLoRaA03S03	TotINFUpRaA03S03	///
TotINFMeRaA03S04	TotINFLoRaA03S04	TotINFUpRaA03S04	///
TotINFMeRaA03S05	TotINFLoRaA03S05	TotINFUpRaA03S05	///
TotINFMeRaA03S06	TotINFLoRaA03S06	TotINFUpRaA03S06	///
DayINFMeRaA03S01	DayINFLoRaA03S01	DayINFUpRaA03S01	///
DayINFMeRaA03S02	DayINFLoRaA03S02	DayINFUpRaA03S02	///
DayINFMeRaA03S03	DayINFLoRaA03S03	DayINFUpRaA03S03	///
DayINFMeRaA03S04	DayINFLoRaA03S04	DayINFUpRaA03S04	///
DayINFMeRaA03S05	DayINFLoRaA03S05	DayINFUpRaA03S05	///
DayINFMeRaA03S06	DayINFLoRaA03S06	DayINFUpRaA03S06




 *
 
 
* gen IFR

gen DayIFRMeRaA03S01 = 100 * DayDeaMeRaA03S01 / DayINFMeRaA03S01 
gen DayIFRLoRaA03S01 = 100 * DayDeaLoRaA03S01 / DayINFLoRaA03S01 
gen DayIFRUpRaA03S01 = 100 * DayDeaUpRaA03S01 / DayINFUpRaA03S01 
gen DayIFRMeRaA03S02 = 100 * DayDeaMeRaA03S02 / DayINFMeRaA03S02 
gen DayIFRLoRaA03S02 = 100 * DayDeaLoRaA03S02 / DayINFLoRaA03S02 
gen DayIFRUpRaA03S02 = 100 * DayDeaUpRaA03S02 / DayINFUpRaA03S02 
gen DayIFRMeRaA03S03 = 100 * DayDeaMeRaA03S03 / DayINFMeRaA03S03 
gen DayIFRLoRaA03S03 = 100 * DayDeaLoRaA03S03 / DayINFLoRaA03S03 
gen DayIFRUpRaA03S03 = 100 * DayDeaUpRaA03S03 / DayINFUpRaA03S03 
gen DayIFRMeRaA03S04 = 100 * DayDeaMeRaA03S04 / DayINFMeRaA03S04 
gen DayIFRLoRaA03S04 = 100 * DayDeaLoRaA03S04 / DayINFLoRaA03S04 
gen DayIFRUpRaA03S04 = 100 * DayDeaUpRaA03S04 / DayINFUpRaA03S04 
gen DayIFRMeRaA03S05 = 100 * DayDeaMeRaA03S05 / DayINFMeRaA03S05 
gen DayIFRLoRaA03S05 = 100 * DayDeaLoRaA03S05 / DayINFLoRaA03S05 
gen DayIFRUpRaA03S05 = 100 * DayDeaUpRaA03S05 / DayINFUpRaA03S05 
gen DayIFRMeRaA03S06 = 100 * DayDeaMeRaA03S06 / DayINFMeRaA03S06 
gen DayIFRLoRaA03S06 = 100 * DayDeaLoRaA03S06 / DayINFLoRaA03S06 
gen DayIFRUpRaA03S06 = 100 * DayDeaUpRaA03S06 / DayINFUpRaA03S06 

label var DayIFRMeRaA03S01 "Daily IFR Mean A03 S01 "
label var DayIFRLoRaA03S01 "Daily IFR Lower A03 S01 "
label var DayIFRUpRaA03S01 "Daily IFR Upper A03 S01 "
label var DayIFRMeRaA03S02 "Daily IFR Mean A03 S02 "
label var DayIFRLoRaA03S02 "Daily IFR Lower A03 S02 "
label var DayIFRUpRaA03S02 "Daily IFR Upper A03 S02 "
label var DayIFRMeRaA03S03 "Daily IFR Mean A03 S03 "
label var DayIFRLoRaA03S03 "Daily IFR Lower A03 S03 "
label var DayIFRUpRaA03S03 "Daily IFR Upper A03 S03 "
label var DayIFRMeRaA03S04 "Daily IFR Mean A03 S04 "
label var DayIFRLoRaA03S04 "Daily IFR Lower A03 S04 "
label var DayIFRUpRaA03S04 "Daily IFR Upper A03 S04 "
label var DayIFRMeRaA03S05 "Daily IFR Mean A03 S05 "
label var DayIFRLoRaA03S05 "Daily IFR Lower A03 S05 "
label var DayIFRUpRaA03S05 "Daily IFR Upper A03 S05 "
label var DayIFRMeRaA03S06 "Daily IFR Mean A03 S06 "
label var DayIFRLoRaA03S06 "Daily IFR Lower A03 S06 "
label var DayIFRUpRaA03S06 "Daily IFR Upper A03 S06 "





* gen "Daily infections mean div by daily deaths mean IMPE DayIbD" for visulization of temporal relation of deaths and infections peaks 


summ DayDeaMeRaA03S02 
gen DayDeMMeRaA03S02 = r(mean)
label var DayDeMMeRaA03S02 "Daily deaths mean IMPE DayDeM"

summ DayINFMeRaA03S02 
gen DayCaMMeRaA03S02 = r(mean)
label var DayCaMMeRaA03S02 "Daily infections mean IMPE DayCaM"
                           
gen DayIbDMeRaA03S02 = DayCaMMeRaA03S02 / DayDeMMeRaA03S02
label var DayIbDMeRaA03S02 "Daily infections mean div by daily deaths mean IMPE DayIbD"
summ DayIbDMeRaA03S02
                                              
gen DayDMuMeRaA03S02 = DayDeaMeRaA03S02 * DayIbDMeRaA03S02
label var DayDMuMeRaA03S02 "Daily deaths scaled (times means of infections by deaths) IMPE"
summ DayDMuMeRaA03S02



* gen forecast only

di "$IMPEepoch"

*

gen DayDeaFOREA03S02 = DayDeaMeRaA03S02
replace DayDeaFOREA03S02 = . if date < td("$IMPEepoch")
label var DayDeaFOREA03S02 "Daily Forecasted Deaths Mean smoothed IMPE S2"

gen DayINFFOREA03S02 = DayINFMeRaA03S02
replace DayINFFOREA03S02 = . if date < td("$IMPEepoch")
label var DayINFFOREA03S02 "Daily Forecasted Infections Mean smoothed IMPE S2"




* smooth

tsset date, daily   



tssmooth ma DayDeaMeRaA03S02_window = DayDeaMeRaA03S02 if DayDeaMeRaA03S02 >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmA03S02 = DayDeaMeRaA03S02_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA03S02 "Daily deaths mean smooth IMPE S2"


tssmooth ma DayDeaMeRaA03S01_window = DayDeaMeRaA03S01 if DayDeaMeRaA03S01 >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmA03S01 = DayDeaMeRaA03S01_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA03S01 "Daily deaths mean smooth IMPE S1"


tssmooth ma DayDeaMeRaA03S03_window = DayDeaMeRaA03S03 if DayDeaMeRaA03S03 >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmA03S03 = DayDeaMeRaA03S03_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA03S03 "Daily deaths mean smooth IMPE S3"


tssmooth ma DayDeaLoRaA03S03_window = DayDeaLoRaA03S03 if DayDeaLoRaA03S03 >= 0, window(3 1 3)

tssmooth ma DayDeaLoSmA03S03 = DayDeaLoRaA03S03_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaLoSmA03S03 "Daily deaths lower smooth IMPE S3"


tssmooth ma DayDeaUpRaA03S03_window = DayDeaUpRaA03S03 if DayDeaUpRaA03S03 >= 0, window(3 1 3)

tssmooth ma DayDeaUpSmA03S03 = DayDeaUpRaA03S03_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaUpSmA03S03 "Daily deaths upper smooth IMPE S3"


rename DayDeaFOREA03 DayDeaFOREA03S02_raw

tssmooth ma DayDeaFOREA03S02_window = DayDeaFOREA03S02_raw if DayDeaFOREA03S02_raw >= 0, window(3 1 3)

tssmooth ma DayDeaFOREA03S02 = DayDeaFOREA03S02_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaFOREA03S02 "Daily deaths mean smooth IMPE"



tssmooth ma DayINFMeRaA03S02_window = DayINFMeRaA03S02 if DayINFMeRaA03S02 >= 0, window(3 1 3)

tssmooth ma DayINFMeSmA03S02 = DayINFMeRaA03S02_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayINFMeSmA03S02 "Daily infections mean smooth IMPE"



rename DayINFFOREA03S02 DayINFFOREA03S02_raw

tssmooth ma DayINFFOREA03S02_window = DayINFFOREA03S02_raw if DayINFFOREA03S02_raw >= 0, window(3 1 3)

tssmooth ma DayINFFOREA03S02 = DayINFFOREA03S02_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayINFFOREA03S02 "Daily infections mean smooth IMPE"






tssmooth ma DayDeaLoRaA03S02_window = DayDeaLoRaA03S02 if DayDeaLoRaA03S02 >= 0, window(3 1 3)

tssmooth ma DayDeaLoSmA03S02 = DayDeaLoRaA03S02_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaLoSmA03S02 "Daily deaths lower smooth IMPE"









tssmooth ma DayINFLoRaA03S02_window = DayINFLoRaA03S02 if DayINFLoRaA03S02 >= 0, window(3 1 3)

tssmooth ma DayINFLoSmA03S02 = DayINFLoRaA03S02_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayINFLoSmA03S02 "Daily infections lower smooth IMPE"





tssmooth ma DayDeaUpRaA03S02_window = DayDeaUpRaA03S02 if DayDeaUpRaA03S02 >= 0, window(3 1 3)

tssmooth ma DayDeaUpSmA03S02 = DayDeaUpRaA03S02_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaUpSmA03S02 "Daily deaths upper smooth IMPE"






tssmooth ma DayINFUpRaA03S02_window = DayINFUpRaA03S02 if DayINFUpRaA03S02 >= 0, window(3 1 3)

tssmooth ma DayINFUpSmA03S02 = DayINFUpRaA03S02_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayINFUpSmA03S02 "Daily infections upper smooth IMPE S2"



tssmooth ma DayINFUpRaA03S03_window = DayINFUpRaA03S03 if DayINFUpRaA03S03 >= 0, window(3 1 3)

tssmooth ma DayINFUpSmA03S03 = DayINFUpRaA03S03_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayINFUpSmA03S03 "Daily infections upper smooth IMPE S3"



drop *_window

tsset, clear
	



sort date loc_grand_name

qui compress

save "country IMPE.dta", replace





view "log country IMPE.smcl"

log close

exit, clear



