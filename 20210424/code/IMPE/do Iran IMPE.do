
clear all

cd "$pathcovir2"

cd IMPE

capture log close 

log using "log Iran IMPE.smcl", replace

***************************************************************************
* This is "do Iran IMPE.do"

* Project: COVID-19 Iran Review No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare IMPErial study estimates for Iran
***************************************************************************

clear all


*****************************

* get IMPE estimates

copy https://raw.githubusercontent.com/mrc-ide/global-lmic-reports/master/data/2021-04-06_v7.csv.zip 2021-04-06_v7.csv.zip
unzipfile 2021-04-06_v7.csv.zip, replace
erase 2021-04-06_v7.csv.zip

 
******************************

* import csv file


import delimited "2021-04-06_v7.csv", clear varnames(1)
keep if country == "Iran"



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
*/


gen scenario_snail = ""
replace scenario_snail = "S1" if scenario == "Additional 50% Reduction"
replace scenario_snail = "S2" if scenario == "Maintain Status Quo"
replace scenario_snail = "S3" if scenario == "Relax Interventions 50%"
replace scenario_snail = "S4" if scenario == "Surged Additional 50% Reduction"
replace scenario_snail = "S5" if scenario == "Surged Maintain Status Quo"
replace scenario_snail = "S6" if scenario == "Surged Relax Interventions 50%"


gen underline = "_"
egen scenario_snail_dateblock = concat(scenario_snail underline dateblock)

drop date_original scenario

drop scenario_snail_dateblock 
  
drop y_250_ y_med_ y_750_
 

* Primary outcomes Total Deaths, Total Cases, Daily Deaths, and Daily Cases

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
	
    qui renvars, presub(cumul_infec_y_025_ TotCasLoRa)
    qui renvars, presub(cumul_infec_y_975_ TotCasUpRa)
    qui renvars, presub(cumul_infec_y_mea_ TotCasMeRa)
	
	qui renvars, presub(daily_infec_y_025_ DayCasLoRa)
	qui renvars, presub(daily_infec_y_975_ DayCasUpRa)
	qui renvars, presub(daily_infec_y_mea_ DayCasMeRa)
	
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
	
	qui renvars, postsub(S1 A03S01V07) 
	qui renvars, postsub(S2 A03S02V07) 
	qui renvars, postsub(S3 A03S03V07) 
	qui renvars, postsub(S4 A03S04V07) 
	qui renvars, postsub(S5 A03S05V07) 
	qui renvars, postsub(S6 A03S06V07) 
	
	* "Wait Note: renvars are working ..."
	
} 
*   



*

drop iso3c report_date version death_calibrated year month day date2 dateblock

order date  

label var DayCasLoRaA03S01V07 "Daily Cases Lower A03 S01 V07"
label var DayCasLoRaA03S02V07 "Daily Cases Lower A03 S02 V07"
label var DayCasLoRaA03S03V07 "Daily Cases Lower A03 S03 V07"
label var DayCasLoRaA03S04V07 "Daily Cases Lower A03 S04 V07"
label var DayCasLoRaA03S05V07 "Daily Cases Lower A03 S05 V07"
label var DayCasLoRaA03S06V07 "Daily Cases Lower A03 S06 V07"
label var DayCasMeRaA03S01V07 "Daily Cases Mean A03 S01 V07"
label var DayCasMeRaA03S02V07 "Daily Cases Mean A03 S02 V07"
label var DayCasMeRaA03S03V07 "Daily Cases Mean A03 S03 V07"
label var DayCasMeRaA03S04V07 "Daily Cases Mean A03 S04 V07"
label var DayCasMeRaA03S05V07 "Daily Cases Mean A03 S05 V07"
label var DayCasMeRaA03S06V07 "Daily Cases Mean A03 S06 V07"
label var DayCasUpRaA03S01V07 "Daily Cases Upper A03 S01 V07"
label var DayCasUpRaA03S02V07 "Daily Cases Upper A03 S02 V07"
label var DayCasUpRaA03S03V07 "Daily Cases Upper A03 S03 V07"
label var DayCasUpRaA03S04V07 "Daily Cases Upper A03 S04 V07"
label var DayCasUpRaA03S05V07 "Daily Cases Upper A03 S05 V07"
label var DayCasUpRaA03S06V07 "Daily Cases Upper A03 S06 V07"
label var DayDeaLoRaA03S01V07 "Daily Deaths Lower A03 S01 V07"
label var DayDeaLoRaA03S02V07 "Daily Deaths Lower A03 S02 V07"
label var DayDeaLoRaA03S03V07 "Daily Deaths Lower A03 S03 V07"
label var DayDeaLoRaA03S04V07 "Daily Deaths Lower A03 S04 V07"
label var DayDeaLoRaA03S05V07 "Daily Deaths Lower A03 S05 V07"
label var DayDeaLoRaA03S06V07 "Daily Deaths Lower A03 S06 V07"
label var DayDeaMeRaA03S01V07 "Daily Deaths Mean A03 S01 V07"
label var DayDeaMeRaA03S02V07 "Daily Deaths Mean A03 S02 V07"
label var DayDeaMeRaA03S03V07 "Daily Deaths Mean A03 S03 V07"
label var DayDeaMeRaA03S04V07 "Daily Deaths Mean A03 S04 V07"
label var DayDeaMeRaA03S05V07 "Daily Deaths Mean A03 S05 V07"
label var DayDeaMeRaA03S06V07 "Daily Deaths Mean A03 S06 V07"
label var DayDeaUpRaA03S01V07 "Daily Deaths Upper A03 S01 V07"
label var DayDeaUpRaA03S02V07 "Daily Deaths Upper A03 S02 V07"
label var DayDeaUpRaA03S03V07 "Daily Deaths Upper A03 S03 V07"
label var DayDeaUpRaA03S04V07 "Daily Deaths Upper A03 S04 V07"
label var DayDeaUpRaA03S05V07 "Daily Deaths Upper A03 S05 V07"
label var DayDeaUpRaA03S06V07 "Daily Deaths Upper A03 S06 V07"
label var TotCasLoRaA03S01V07 "Total Cases Lower A03 S01 V07"
label var TotCasLoRaA03S02V07 "Total Cases Lower A03 S02 V07"
label var TotCasLoRaA03S03V07 "Total Cases Lower A03 S03 V07"
label var TotCasLoRaA03S04V07 "Total Cases Lower A03 S04 V07"
label var TotCasLoRaA03S05V07 "Total Cases Lower A03 S05 V07"
label var TotCasLoRaA03S06V07 "Total Cases Lower A03 S06 V07"
label var TotCasMeRaA03S01V07 "Total Cases Mean A03 S01 V07"
label var TotCasMeRaA03S02V07 "Total Cases Mean A03 S02 V07"
label var TotCasMeRaA03S03V07 "Total Cases Mean A03 S03 V07"
label var TotCasMeRaA03S04V07 "Total Cases Mean A03 S04 V07"
label var TotCasMeRaA03S05V07 "Total Cases Mean A03 S05 V07"
label var TotCasMeRaA03S06V07 "Total Cases Mean A03 S06 V07"
label var TotCasUpRaA03S01V07 "Total Cases Upper A03 S01 V07"
label var TotCasUpRaA03S02V07 "Total Cases Upper A03 S02 V07"
label var TotCasUpRaA03S03V07 "Total Cases Upper A03 S03 V07"
label var TotCasUpRaA03S04V07 "Total Cases Upper A03 S04 V07"
label var TotCasUpRaA03S05V07 "Total Cases Upper A03 S05 V07"
label var TotCasUpRaA03S06V07 "Total Cases Upper A03 S06 V07"
label var TotDeaLoRaA03S01V07 "Total Deaths Lower A03 S01 V07"
label var TotDeaLoRaA03S02V07 "Total Deaths Lower A03 S02 V07"
label var TotDeaLoRaA03S03V07 "Total Deaths Lower A03 S03 V07"
label var TotDeaLoRaA03S04V07 "Total Deaths Lower A03 S04 V07"
label var TotDeaLoRaA03S05V07 "Total Deaths Lower A03 S05 V07"
label var TotDeaLoRaA03S06V07 "Total Deaths Lower A03 S06 V07"
label var TotDeaMeRaA03S01V07 "Total Deaths Mean A03 S01 V07"
label var TotDeaMeRaA03S02V07 "Total Deaths Mean A03 S02 V07"
label var TotDeaMeRaA03S03V07 "Total Deaths Mean A03 S03 V07"
label var TotDeaMeRaA03S04V07 "Total Deaths Mean A03 S04 V07"
label var TotDeaMeRaA03S05V07 "Total Deaths Mean A03 S05 V07"
label var TotDeaMeRaA03S06V07 "Total Deaths Mean A03 S06 V07"
label var TotDeaUpRaA03S01V07 "Total Deaths Upper A03 S01 V07"
label var TotDeaUpRaA03S02V07 "Total Deaths Upper A03 S02 V07"
label var TotDeaUpRaA03S03V07 "Total Deaths Upper A03 S03 V07"
label var TotDeaUpRaA03S04V07 "Total Deaths Upper A03 S04 V07"
label var TotDeaUpRaA03S05V07 "Total Deaths Upper A03 S05 V07"
label var TotDeaUpRaA03S06V07 "Total Deaths Upper A03 S06 V07"


* other outcomes

label var DayHodMeRaA03S01V07 "Daily hospital demand Mean A03 S01 V07"
label var DayHodLoRaA03S01V07 "Daily hospital demand Lower A03 S01 V07"
label var DayHodUpRaA03S01V07 "Daily hospital demand Upper A03 S01 V07"
label var DayHodMeRaA03S02V07 "Daily hospital demand Mean A03 S02 V07"
label var DayHodLoRaA03S02V07 "Daily hospital demand Lower A03 S02 V07"
label var DayHodUpRaA03S02V07 "Daily hospital demand Upper A03 S02 V07"
label var DayHodMeRaA03S03V07 "Daily hospital demand Mean A03 S03 V07"
label var DayHodLoRaA03S03V07 "Daily hospital demand Lower A03 S03 V07"
label var DayHodUpRaA03S03V07 "Daily hospital demand Upper A03 S03 V07"
label var DayHodMeRaA03S04V07 "Daily hospital demand Mean A03 S04 V07"
label var DayHodLoRaA03S04V07 "Daily hospital demand Lower A03 S04 V07"
label var DayHodUpRaA03S04V07 "Daily hospital demand Upper A03 S04 V07" 
label var DayHodMeRaA03S05V07 "Daily hospital demand Mean A03 S05 V07"
label var DayHodLoRaA03S05V07 "Daily hospital demand Lower A03 S05 V07"
label var DayHodUpRaA03S05V07 "Daily hospital demand Upper A03 S05 V07"
label var DayHodMeRaA03S06V07 "Daily hospital demand Mean A03 S06 V07"
label var DayHodLoRaA03S06V07 "Daily hospital demand Lower A03 S06 V07"
label var DayHodUpRaA03S06V07 "Daily hospital demand Upper A03 S06 V07"

label var DayHoiMeRaA03S01V07 "Daily hospital incidence Mean A03 S01 V07"
label var DayHoiLoRaA03S01V07 "Daily hospital incidence Lower A03 S01 V07"
label var DayHoiUpRaA03S01V07 "Daily hospital incidence Upper A03 S01 V07"
label var DayHoiMeRaA03S02V07 "Daily hospital incidence Mean A03 S02 V07"
label var DayHoiLoRaA03S02V07 "Daily hospital incidence Lower A03 S02 V07"
label var DayHoiUpRaA03S02V07 "Daily hospital incidence Upper A03 S02 V07"
label var DayHoiMeRaA03S03V07 "Daily hospital incidence Mean A03 S03 V07"
label var DayHoiLoRaA03S03V07 "Daily hospital incidence Lower A03 S03 V07"
label var DayHoiUpRaA03S03V07 "Daily hospital incidence Upper A03 S03 V07"
label var DayHoiMeRaA03S04V07 "Daily hospital incidence Mean A03 S04 V07"
label var DayHoiLoRaA03S04V07 "Daily hospital incidence Lower A03 S04 V07"
label var DayHoiUpRaA03S04V07 "Daily hospital incidence Upper A03 S04 V07"
label var DayHoiMeRaA03S05V07 "Daily hospital incidence Mean A03 S05 V07"
label var DayHoiLoRaA03S05V07 "Daily hospital incidence Lower A03 S05 V07"
label var DayHoiUpRaA03S05V07 "Daily hospital incidence Upper A03 S05 V07"
label var DayHoiMeRaA03S06V07 "Daily hospital incidence Mean A03 S06 V07"
label var DayHoiLoRaA03S06V07 "Daily hospital incidence Lower A03 S06 V07"
label var DayHoiUpRaA03S06V07 "Daily hospital incidence Upper A03 S06 V07"

label var DayIcdMeRaA03S01V07 "Daily ICU demand Mean A03 S01 V07"
label var DayIcdLoRaA03S01V07 "Daily ICU demand Lower A03 S01 V07"
label var DayIcdUpRaA03S01V07 "Daily ICU demand Upper A03 S01 V07"
label var DayIcdMeRaA03S02V07 "Daily ICU demand Mean A03 S02 V07"
label var DayIcdLoRaA03S02V07 "Daily ICU demand Lower A03 S02 V07"
label var DayIcdUpRaA03S02V07 "Daily ICU demand Upper A03 S02 V07"
label var DayIcdMeRaA03S03V07 "Daily ICU demand Mean A03 S03 V07"
label var DayIcdLoRaA03S03V07 "Daily ICU demand Lower A03 S03 V07"
label var DayIcdUpRaA03S03V07 "Daily ICU demand Upper A03 S03 V07"
label var DayIcdMeRaA03S04V07 "Daily ICU demand Mean A03 S04 V07"
label var DayIcdLoRaA03S04V07 "Daily ICU demand Lower A03 S04 V07"
label var DayIcdUpRaA03S04V07 "Daily ICU demand Upper A03 S04 V07"
label var DayIcdMeRaA03S05V07 "Daily ICU demand Mean A03 S05 V07"
label var DayIcdLoRaA03S05V07 "Daily ICU demand Lower A03 S05 V07"
label var DayIcdUpRaA03S05V07 "Daily ICU demand Upper A03 S05 V07"
label var DayIcdMeRaA03S06V07 "Daily ICU demand Mean A03 S06 V07"
label var DayIcdLoRaA03S06V07 "Daily ICU demand Lower A03 S06 V07"
label var DayIcdUpRaA03S06V07 "Daily ICU demand Upper A03 S06 V07"

label var DayIciMeRaA03S01V07 "Daily ICU incidence Mean A03 S01 V07"
label var DayIciLoRaA03S01V07 "Daily ICU incidence Lower A03 S01 V07"
label var DayIciUpRaA03S01V07 "Daily ICU incidence Upper A03 S01 V07"
label var DayIciMeRaA03S02V07 "Daily ICU incidence Mean A03 S02 V07"
label var DayIciLoRaA03S02V07 "Daily ICU incidence Lower A03 S02 V07"
label var DayIciUpRaA03S02V07 "Daily ICU incidence Upper A03 S02 V07"
label var DayIciMeRaA03S03V07 "Daily ICU incidence Mean A03 S03 V07"
label var DayIciLoRaA03S03V07 "Daily ICU incidence Lower A03 S03 V07"
label var DayIciUpRaA03S03V07 "Daily ICU incidence Upper A03 S03 V07"
label var DayIciMeRaA03S04V07 "Daily ICU incidence Mean A03 S04 V07"
label var DayIciLoRaA03S04V07 "Daily ICU incidence Lower A03 S04 V07"
label var DayIciUpRaA03S04V07 "Daily ICU incidence Upper A03 S04 V07"
label var DayIciMeRaA03S05V07 "Daily ICU incidence Mean A03 S05 V07"
label var DayIciLoRaA03S05V07 "Daily ICU incidence Lower A03 S05 V07"
label var DayIciUpRaA03S05V07 "Daily ICU incidence Upper A03 S05 V07"
label var DayIciMeRaA03S06V07 "Daily ICU incidence Mean A03 S06 V07"
label var DayIciLoRaA03S06V07 "Daily ICU incidence Lower A03 S06 V07"
label var DayIciUpRaA03S06V07 "Daily ICU incidence Upper A03 S06 V07"

label var DayPreMeRaA03S01V07 "Daily prevalence Mean A03 S01 V07"
label var DayPreLoRaA03S01V07 "Daily prevalence Lower A03 S01 V07"
label var DayPreUpRaA03S01V07 "Daily prevalence Upper A03 S01 V07"
label var DayPreMeRaA03S02V07 "Daily prevalence Mean A03 S02 V07"
label var DayPreLoRaA03S02V07 "Daily prevalence Lower A03 S02 V07"
label var DayPreUpRaA03S02V07 "Daily prevalence Upper A03 S02 V07"
label var DayPreMeRaA03S03V07 "Daily prevalence Mean A03 S03 V07"
label var DayPreLoRaA03S03V07 "Daily prevalence Lower A03 S03 V07"
label var DayPreUpRaA03S03V07 "Daily prevalence Upper A03 S03 V07"
label var DayPreMeRaA03S04V07 "Daily prevalence Mean A03 S04 V07"
label var DayPreLoRaA03S04V07 "Daily prevalence Lower A03 S04 V07"
label var DayPreUpRaA03S04V07 "Daily prevalence Upper A03 S04 V07"
label var DayPreMeRaA03S05V07 "Daily prevalence Mean A03 S05 V07"
label var DayPreLoRaA03S05V07 "Daily prevalence Lower A03 S05 V07"
label var DayPreUpRaA03S05V07 "Daily prevalence Upper A03 S05 V07"
label var DayPreMeRaA03S06V07 "Daily prevalence Mean A03 S06 V07"
label var DayPreLoRaA03S06V07 "Daily prevalence Lower A03 S06 V07"
label var DayPreUpRaA03S06V07 "Daily prevalence Upper A03 S06 V07"

label var DayRefMeRaA03S01V07 "Daily R effective Mean A03 S01 V07"
label var DayRefLoRaA03S01V07 "Daily R effective Lower A03 S01 V07"
label var DayRefUpRaA03S01V07 "Daily R effective Upper A03 S01 V07"
label var DayRefMeRaA03S02V07 "Daily R effective Mean A03 S02 V07"
label var DayRefLoRaA03S02V07 "Daily R effective Lower A03 S02 V07"
label var DayRefUpRaA03S02V07 "Daily R effective Upper A03 S02 V07"
label var DayRefMeRaA03S03V07 "Daily R effective Mean A03 S03 V07"
label var DayRefLoRaA03S03V07 "Daily R effective Lower A03 S03 V07"
label var DayRefUpRaA03S03V07 "Daily R effective Upper A03 S03 V07"
label var DayRefMeRaA03S04V07 "Daily R effective Mean A03 S04 V07"
label var DayRefLoRaA03S04V07 "Daily R effective Lower A03 S04 V07"
label var DayRefUpRaA03S04V07 "Daily R effective Upper A03 S04 V07"
label var DayRefMeRaA03S05V07 "Daily R effective Mean A03 S05 V07"
label var DayRefLoRaA03S05V07 "Daily R effective Lower A03 S05 V07"
label var DayRefUpRaA03S05V07 "Daily R effective Upper A03 S05 V07"
label var DayRefMeRaA03S06V07 "Daily R effective Mean A03 S06 V07"
label var DayRefLoRaA03S06V07 "Daily R effective Lower A03 S06 V07"
label var DayRefUpRaA03S06V07 "Daily R effective Upper A03 S06 V07"

label var DayRttMeRaA03S01V07 "Daily R t Mean A03 S01 V07"
label var DayRttLoRaA03S01V07 "Daily R t Lower A03 S01 V07"
label var DayRttUpRaA03S01V07 "Daily R t Upper A03 S01 V07"
label var DayRttMeRaA03S02V07 "Daily R t Mean A03 S02 V07"
label var DayRttLoRaA03S02V07 "Daily R t Lower A03 S02 V07"
label var DayRttUpRaA03S02V07 "Daily R t Upper A03 S02 V07"
label var DayRttMeRaA03S03V07 "Daily R t Mean A03 S03 V07"
label var DayRttLoRaA03S03V07 "Daily R t Lower A03 S03 V07"
label var DayRttUpRaA03S03V07 "Daily R t Upper A03 S03 V07"
label var DayRttMeRaA03S04V07 "Daily R t Mean A03 S04 V07"
label var DayRttLoRaA03S04V07 "Daily R t Lower A03 S04 V07"
label var DayRttUpRaA03S04V07 "Daily R t Upper A03 S04 V07"
label var DayRttMeRaA03S05V07 "Daily R t Mean A03 S05 V07"
label var DayRttLoRaA03S05V07 "Daily R t Lower A03 S05 V07"
label var DayRttUpRaA03S05V07 "Daily R t Upper A03 S05 V07"
label var DayRttMeRaA03S06V07 "Daily R t Mean A03 S06 V07"
label var DayRttLoRaA03S06V07 "Daily R t Lower A03 S06 V07"
label var DayRttUpRaA03S06V07 "Daily R t Upper A03 S06 V07"


rename country loc_grand_name



order ///
loc_grand_name date	///
TotDeaMeRaA03S01V07	TotDeaLoRaA03S01V07	TotDeaUpRaA03S01V07	///
TotDeaMeRaA03S02V07	TotDeaLoRaA03S02V07	TotDeaUpRaA03S02V07	///
TotDeaMeRaA03S03V07	TotDeaLoRaA03S03V07	TotDeaUpRaA03S03V07	///
TotDeaMeRaA03S04V07	TotDeaLoRaA03S04V07	TotDeaUpRaA03S04V07	///
TotDeaMeRaA03S05V07	TotDeaLoRaA03S05V07	TotDeaUpRaA03S05V07	///
TotDeaMeRaA03S06V07	TotDeaLoRaA03S06V07	TotDeaUpRaA03S06V07	///
DayDeaMeRaA03S01V07	DayDeaLoRaA03S01V07	DayDeaUpRaA03S01V07	///
DayDeaMeRaA03S02V07	DayDeaLoRaA03S02V07	DayDeaUpRaA03S02V07	///
DayDeaMeRaA03S03V07	DayDeaLoRaA03S03V07	DayDeaUpRaA03S03V07	///
DayDeaMeRaA03S04V07	DayDeaLoRaA03S04V07	DayDeaUpRaA03S04V07	///
DayDeaMeRaA03S05V07	DayDeaLoRaA03S05V07	DayDeaUpRaA03S05V07	///
DayDeaMeRaA03S06V07	DayDeaLoRaA03S06V07	DayDeaUpRaA03S06V07	///
TotCasMeRaA03S01V07	TotCasLoRaA03S01V07	TotCasUpRaA03S01V07	///
TotCasMeRaA03S02V07	TotCasLoRaA03S02V07	TotCasUpRaA03S02V07	///
TotCasMeRaA03S03V07	TotCasLoRaA03S03V07	TotCasUpRaA03S03V07	///
TotCasMeRaA03S04V07	TotCasLoRaA03S04V07	TotCasUpRaA03S04V07	///
TotCasMeRaA03S05V07	TotCasLoRaA03S05V07	TotCasUpRaA03S05V07	///
TotCasMeRaA03S06V07	TotCasLoRaA03S06V07	TotCasUpRaA03S06V07	///
DayCasMeRaA03S01V07	DayCasLoRaA03S01V07	DayCasUpRaA03S01V07	///
DayCasMeRaA03S02V07	DayCasLoRaA03S02V07	DayCasUpRaA03S02V07	///
DayCasMeRaA03S03V07	DayCasLoRaA03S03V07	DayCasUpRaA03S03V07	///
DayCasMeRaA03S04V07	DayCasLoRaA03S04V07	DayCasUpRaA03S04V07	///
DayCasMeRaA03S05V07	DayCasLoRaA03S05V07	DayCasUpRaA03S05V07	///
DayCasMeRaA03S06V07	DayCasLoRaA03S06V07	DayCasUpRaA03S06V07


 *
 
 
* gen cfr

gen DayCfrMeRaA03S01V07 = 100 * DayDeaMeRaA03S01V07 / DayCasMeRaA03S01V07 
gen DayCfrLoRaA03S01V07 = 100 * DayDeaLoRaA03S01V07 / DayCasLoRaA03S01V07 
gen DayCfrUpRaA03S01V07 = 100 * DayDeaUpRaA03S01V07 / DayCasUpRaA03S01V07 
gen DayCfrMeRaA03S02V07 = 100 * DayDeaMeRaA03S02V07 / DayCasMeRaA03S02V07 
gen DayCfrLoRaA03S02V07 = 100 * DayDeaLoRaA03S02V07 / DayCasLoRaA03S02V07 
gen DayCfrUpRaA03S02V07 = 100 * DayDeaUpRaA03S02V07 / DayCasUpRaA03S02V07 
gen DayCfrMeRaA03S03V07 = 100 * DayDeaMeRaA03S03V07 / DayCasMeRaA03S03V07 
gen DayCfrLoRaA03S03V07 = 100 * DayDeaLoRaA03S03V07 / DayCasLoRaA03S03V07 
gen DayCfrUpRaA03S03V07 = 100 * DayDeaUpRaA03S03V07 / DayCasUpRaA03S03V07 
gen DayCfrMeRaA03S04V07 = 100 * DayDeaMeRaA03S04V07 / DayCasMeRaA03S04V07 
gen DayCfrLoRaA03S04V07 = 100 * DayDeaLoRaA03S04V07 / DayCasLoRaA03S04V07 
gen DayCfrUpRaA03S04V07 = 100 * DayDeaUpRaA03S04V07 / DayCasUpRaA03S04V07 
gen DayCfrMeRaA03S05V07 = 100 * DayDeaMeRaA03S05V07 / DayCasMeRaA03S05V07 
gen DayCfrLoRaA03S05V07 = 100 * DayDeaLoRaA03S05V07 / DayCasLoRaA03S05V07 
gen DayCfrUpRaA03S05V07 = 100 * DayDeaUpRaA03S05V07 / DayCasUpRaA03S05V07 
gen DayCfrMeRaA03S06V07 = 100 * DayDeaMeRaA03S06V07 / DayCasMeRaA03S06V07 
gen DayCfrLoRaA03S06V07 = 100 * DayDeaLoRaA03S06V07 / DayCasLoRaA03S06V07 
gen DayCfrUpRaA03S06V07 = 100 * DayDeaUpRaA03S06V07 / DayCasUpRaA03S06V07 

label var DayCfrMeRaA03S01V07 "Daily CFR Mean A03 S01 V07"
label var DayCfrLoRaA03S01V07 "Daily CFR Lower A03 S01 V07"
label var DayCfrUpRaA03S01V07 "Daily CFR Upper A03 S01 V07"
label var DayCfrMeRaA03S02V07 "Daily CFR Mean A03 S02 V07"
label var DayCfrLoRaA03S02V07 "Daily CFR Lower A03 S02 V07"
label var DayCfrUpRaA03S02V07 "Daily CFR Upper A03 S02 V07"
label var DayCfrMeRaA03S03V07 "Daily CFR Mean A03 S03 V07"
label var DayCfrLoRaA03S03V07 "Daily CFR Lower A03 S03 V07"
label var DayCfrUpRaA03S03V07 "Daily CFR Upper A03 S03 V07"
label var DayCfrMeRaA03S04V07 "Daily CFR Mean A03 S04 V07"
label var DayCfrLoRaA03S04V07 "Daily CFR Lower A03 S04 V07"
label var DayCfrUpRaA03S04V07 "Daily CFR Upper A03 S04 V07"
label var DayCfrMeRaA03S05V07 "Daily CFR Mean A03 S05 V07"
label var DayCfrLoRaA03S05V07 "Daily CFR Lower A03 S05 V07"
label var DayCfrUpRaA03S05V07 "Daily CFR Upper A03 S05 V07"
label var DayCfrMeRaA03S06V07 "Daily CFR Mean A03 S06 V07"
label var DayCfrLoRaA03S06V07 "Daily CFR Lower A03 S06 V07"
label var DayCfrUpRaA03S06V07 "Daily CFR Upper A03 S06 V07"





* gen "Daily cases mean div by daily deaths mean IMPE DayCbD" for visulization of temporal relation of deaths and cases peaks 


summ DayDeaMeRaA03S02V07 
gen DayDeMMeRaA03S02V07 = r(mean)
label var DayDeMMeRaA03S02V07 "Daily deaths mean IMPE DayDeM"

summ DayCasMeRaA03S02V07 
gen DayCaMMeRaA03S02V07 = r(mean)
label var DayCaMMeRaA03S02V07 "Daily cases mean IMPE DayCaM"
                           
gen DayCbDMeRaA03S02V07 = DayCaMMeRaA03S02V07 / DayDeMMeRaA03S02V07
label var DayCbDMeRaA03S02V07 "Daily cases mean div by daily deaths mean IMPE DayCbD"
summ DayCbDMeRaA03S02V07
                                              
gen DayDMuMeRaA03S02V07 = DayDeaMeRaA03S02V07 * DayCbDMeRaA03S02V07
label var DayDMuMeRaA03S02V07 "Daily deaths scaled (times means of cases by deaths) IMPE"
summ DayDMuMeRaA03S02V07







*************************

* graphs 


grstyle init

grstyle color background white


summ date

local xticks = ceil( ( r(max) - r(min) ) / 30 )

di `xticks'



* daily deaths, 6 scenarios

twoway ///
(line DayDeaMeRaA03S01V07 date, sort lcolor(green)) ///
(line DayDeaMeRaA03S02V07 date, sort lcolor(black)) ///
(line DayDeaMeRaA03S03V07 date, sort lcolor(red)) ///
(line DayDeaMeRaA03S04V07 date, sort lcolor(green) lpattern(dash)) ///
(line DayDeaMeRaA03S05V07 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeRaA03S06V07 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IMPE, 6 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(1))
  	   
graph save "graph 1 COVID-19 daily deaths, 6 scenarios, Iran, IMPE.gph", replace
graph export "graph 1 COVID-19 daily deaths, 6 scenarios, Iran, IMPE.pdf", replace





* daily deaths, S2 = median scenario 

twoway ///
(rarea DayDeaLoRaA03S02V07 DayDeaUpRaA03S02V07 date, sort color(green*0.2)) ///
(line DayDeaMeRaA03S02V07 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IMPE, median scenario", size(medium)) legend(off)

graph save "graph 2 COVID-19 daily deaths, median scenario, Iran, IMPE.gph", replace
graph export "graph 2 COVID-19 daily deaths, median scenario, Iran, IMPE.pdf", replace





* total deaths, 6 scenarios

twoway ///
(line TotDeaMeRaA03S01V07 date, sort lcolor(green)) ///
(line TotDeaMeRaA03S02V07 date, sort lcolor(black)) ///
(line TotDeaMeRaA03S03V07 date, sort lcolor(red)) ///
(line TotDeaMeRaA03S04V07 date, sort lcolor(green) lpattern(dash)) ///
(line TotDeaMeRaA03S05V07 date, sort lcolor(black) lpattern(dash)) ///
(line TotDeaMeRaA03S06V07 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, IMPE, 6 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(1))
  	   
graph save "graph 3 COVID-19 total deaths, 6 scenarios, Iran, IMPE.gph", replace
graph export "graph 3 COVID-19 total deaths, 6 scenarios, Iran, IMPE.pdf", replace





* total deaths, S2 = median scenario 

twoway ///
(rarea TotDeaLoRaA03S02V07 TotDeaUpRaA03S02V07 date, sort color(green*0.2)) ///
(line TotDeaMeRaA03S02V07 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, IMPE, median scenario", size(medium)) legend(off)

graph save "graph 4 COVID-19 total deaths, median scenario, Iran, IMPE.gph", replace
graph export "graph 4 COVID-19 total deaths, median scenario, Iran, IMPE.pdf", replace





* daily cases, 6 scenarios


twoway ///
(line DayCasMeRaA03S01V07 date, sort lcolor(green)) ///
(line DayCasMeRaA03S02V07 date, sort lcolor(black)) ///
(line DayCasMeRaA03S03V07 date, sort lcolor(red)) ///
(line DayCasMeRaA03S04V07 date, sort lcolor(green) lpattern(dash)) ///
(line DayCasMeRaA03S05V07 date, sort lcolor(black) lpattern(dash)) ///
(line DayCasMeRaA03S06V07 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IMPE, 6 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(1))
  	   
graph save "graph 5 COVID-19 daily cases, 6 scenarios, Iran, IMPE.gph", replace
graph export "graph 5 COVID-19 daily cases, 6 scenarios, Iran, IMPE.pdf", replace





* daily cases, S2 = median scenario 

twoway ///
(rarea DayCasLoRaA03S02V07 DayCasUpRaA03S02V07 date, sort color(green*0.2)) ///
(line DayCasMeRaA03S02V07 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IMPE, median scenario", size(medium)) legend(off)

graph save "graph 6 COVID-19 daily cases, median scenario, Iran, IMPE.gph", replace
graph export "graph 6 COVID-19 daily cases, median scenario, Iran, IMPE.pdf", replace





* total cases, 6 scenarios


twoway ///
(line TotCasMeRaA03S01V07 date, sort lcolor(green)) ///
(line TotCasMeRaA03S02V07 date, sort lcolor(black)) ///
(line TotCasMeRaA03S03V07 date, sort lcolor(red)) ///
(line TotCasMeRaA03S04V07 date, sort lcolor(green) lpattern(dash)) ///
(line TotCasMeRaA03S05V07 date, sort lcolor(black) lpattern(dash)) ///
(line TotCasMeRaA03S06V07 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, IMPE, 6 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(1))
  	   
graph save "graph 7 COVID-19 total cases, 6 scenarios, Iran, IMPE.gph", replace
graph export "graph 7 COVID-19 total cases, 6 scenarios, Iran, IMPE.pdf", replace





* total cases, S2 = median scenario 

twoway ///
(rarea TotCasLoRaA03S02V07 TotCasUpRaA03S02V07 date, sort color(green*0.2)) ///
(line TotCasMeRaA03S02V07 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, IMPE, median scenario", size(medium)) legend(off)

graph save "graph 8 COVID-19 total cases, median scenario, Iran, IMPE.gph", replace
graph export "graph 8 COVID-19 total cases, median scenario, Iran, IMPE.pdf", replace





* daily cfr, 6 scenarios

twoway ///
(line DayCfrMeRaA03S01V07 date, sort lcolor(green)) ///
(line DayCfrMeRaA03S02V07 date, sort lcolor(black)) ///
(line DayCfrMeRaA03S03V07 date, sort lcolor(red)) ///
(line DayCfrMeRaA03S04V07 date, sort lcolor(green) lpattern(dash)) ///
(line DayCfrMeRaA03S05V07 date, sort lcolor(black) lpattern(dash)) ///
(line DayCfrMeRaA03S06V07 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, IMPE, 6 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(1))
  	   
graph save "graph 9 COVID-19 daily CFR, 6 scenarios, Iran, IMPE.gph", replace
graph export "graph 9 COVID-19 daily CFR, 6 scenarios, Iran, IMPE.pdf", replace





* daily cfr, S2 = median scenario 

twoway ///
(rarea DayCfrLoRaA03S02V07 DayCfrUpRaA03S02V07 date, sort color(green*0.2)) ///
(line DayCfrMeRaA03S02V07 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, IMPE, median scenario", size(medium)) legend(off)

graph save "graph 10 COVID-19 daily CFR, median scenario, Iran, IMPE.gph", replace
graph export "graph 10 COVID-19 daily CFR, median scenario, Iran, IMPE.pdf", replace





* other outcomes


* daily hospital demand, median scenario

twoway ///
(rarea DayHodLoRaA03S01V07 DayHodUpRaA03S01V07 date, sort color(green*0.2)) ///
(line DayHodMeRaA03S01V07 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
ytitle(Daily outcome) title("COVID-19 daily hospital demand, Iran, IMPE, median scenario", size(medium)) legend(off)

graph save "graph 11 COVID-19 daily hospital demand, median scenario, Iran, IMPE.gph", replace
graph export "graph 11 COVID-19 daily hospital demand, median scenario, Iran, IMPE.pdf", replace





* daily hospital demand, 6 scenarios

twoway ///
(line DayHodMeRaA03S01V07 date, sort lcolor(green)) ///
(line DayHodMeRaA03S02V07 date, sort lcolor(black)) ///
(line DayHodMeRaA03S03V07 date, sort lcolor(red)) ///
(line DayHodMeRaA03S04V07 date, sort lcolor(green) lpattern(dash)) ///
(line DayHodMeRaA03S05V07 date, sort lcolor(black) lpattern(dash)) ///
(line DayHodMeRaA03S06V07 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcome) title("COVID-19 daily hospital demand, Iran, IMPE, 6 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(1))
  	   
graph save "graph 12 COVID-19 daily hospital demand, 6 scenarios, Iran, IMPE.gph", replace
graph export "graph 12 COVID-19 daily hospital demand, 6 scenarios, Iran, IMPE.pdf", replace





* daily hospital incidence, median scenario

twoway ///
(rarea DayHoiLoRaA03S01V07 DayHoiUpRaA03S01V07 date, sort color(green*0.2)) ///
(line DayHoiMeRaA03S01V07 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
ytitle(Daily outcome) title("COVID-19 daily hospital incidence, Iran, IMPE, median scenario", size(medium)) legend(off)

graph save "graph 13 COVID-19 daily hospital incidence, median scenario, Iran, IMPE.gph", replace
graph export "graph 13 COVID-19 daily hospital incidence, median scenario, Iran, IMPE.pdf", replace




* daily hospital incidence, 6 scenarios

twoway ///
(line DayHoiMeRaA03S01V07 date, sort lcolor(green)) ///
(line DayHoiMeRaA03S02V07 date, sort lcolor(black)) ///
(line DayHoiMeRaA03S03V07 date, sort lcolor(red)) ///
(line DayHoiMeRaA03S04V07 date, sort lcolor(green) lpattern(dash)) ///
(line DayHoiMeRaA03S05V07 date, sort lcolor(black) lpattern(dash)) ///
(line DayHoiMeRaA03S06V07 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcome) title("COVID-19 daily hospital incidence, Iran, IMPE, 6 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(1))
  	   
graph save "graph 14 COVID-19 daily hospital incidence, 6 scenarios, Iran, IMPE.gph", replace
graph export "graph 14 COVID-19 daily hospital incidence, 6 scenarios, Iran, IMPE.pdf", replace





* daily ICU demand, median scenario

twoway ///
(rarea DayIcdLoRaA03S01V07 DayIcdUpRaA03S01V07 date, sort color(green*0.2)) ///
(line DayIcdMeRaA03S01V07 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
ytitle(Daily outcome) title("COVID-19 daily ICU demand, Iran, IMPE, median scenario", size(medium)) legend(off)

graph save "graph 15 COVID-19 daily ICU demand, median scenario, Iran, IMPE.gph", replace
graph export "graph 15 COVID-19 daily ICU demand, median scenario, Iran, IMPE.pdf", replace





* daily ICU demand, 6 scenarios

twoway ///
(line DayIcdMeRaA03S01V07 date, sort lcolor(green)) ///
(line DayIcdMeRaA03S02V07 date, sort lcolor(black)) ///
(line DayIcdMeRaA03S03V07 date, sort lcolor(red)) ///
(line DayIcdMeRaA03S04V07 date, sort lcolor(green) lpattern(dash)) ///
(line DayIcdMeRaA03S05V07 date, sort lcolor(black) lpattern(dash)) ///
(line DayIcdMeRaA03S06V07 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcome) title("COVID-19 daily ICU demand, Iran, IMPE, 6 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(1))
  	   
graph save "graph 16 COVID-19 daily ICU demand, 6 scenarios, Iran, IMPE.gph", replace
graph export "graph 16 COVID-19 daily ICU demand, 6 scenarios, Iran, IMPE.pdf", replace





* daily ICU incidence, median scenario

twoway ///
(rarea DayIciLoRaA03S01V07 DayIciUpRaA03S01V07 date, sort color(green*0.2)) ///
(line DayIciMeRaA03S01V07 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
ytitle(Daily outcome) title("COVID-19 daily ICU incidence, Iran, IMPE, median scenario", size(medium)) legend(off)

graph save "graph 17 COVID-19 daily ICU incidence, median scenario, Iran, IMPE.gph", replace
graph export "graph 17 COVID-19 daily ICU incidence, median scenario, Iran, IMPE.pdf", replace





* daily ICU incidence, 6 scenarios

twoway ///
(line DayIciMeRaA03S01V07 date, sort lcolor(green)) ///
(line DayIciMeRaA03S02V07 date, sort lcolor(black)) ///
(line DayIciMeRaA03S03V07 date, sort lcolor(red)) ///
(line DayIciMeRaA03S04V07 date, sort lcolor(green) lpattern(dash)) ///
(line DayIciMeRaA03S05V07 date, sort lcolor(black) lpattern(dash)) ///
(line DayIciMeRaA03S06V07 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcome) title("COVID-19 daily ICU incidence, Iran, IMPE, 6 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(1))
  	   
graph save "graph 18 COVID-19 daily ICU incidence, 6 scenarios, Iran, IMPE.gph", replace
graph export "graph 18 COVID-19 daily ICU incidence, 6 scenarios, Iran, IMPE.pdf", replace





* daily R effective, median scenario Reff

twoway ///
(rarea DayRefLoRaA03S01V07 DayRefUpRaA03S01V07 date, sort color(green*0.2)) ///
(line DayRefMeRaA03S01V07 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
ytitle(Daily outcome) title("COVID-19 daily R effective, Iran, IMPE, median scenario", size(medium)) legend(off)

graph save "graph 19 COVID-19 daily R effective, median scenario, Iran, IMPE.gph", replace
graph export "graph 19 COVID-19 daily R effective, median scenario, Iran, IMPE.pdf", replace





* daily R effective, 6 scenarioss

twoway ///
(line DayRefMeRaA03S01V07 date, sort lcolor(green)) ///
(line DayRefMeRaA03S02V07 date, sort lcolor(black)) ///
(line DayRefMeRaA03S03V07 date, sort lcolor(red)) ///
(line DayRefMeRaA03S04V07 date, sort lcolor(green) lpattern(dash)) ///
(line DayRefMeRaA03S05V07 date, sort lcolor(black) lpattern(dash)) ///
(line DayRefMeRaA03S06V07 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcome) title("COVID-19 daily R effective, Iran, IMPE, 6 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(1))
  	   
graph save "graph 20 COVID-19 daily R effective, 6 scenarios, Iran, IMPE.gph", replace
graph export "graph 20 COVID-19 daily R effective, 6 scenarios, Iran, IMPE.pdf", replace





* daily R t, median scenario 

twoway ///
(rarea DayRttLoRaA03S01V07 DayRttUpRaA03S01V07 date, sort color(green*0.2)) ///
(line DayRttMeRaA03S01V07 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
ytitle(Daily outcome) title("COVID-19 daily R t, Iran, IMPE, median scenario", size(medium)) legend(off)

graph save "graph 21 COVID-19 daily R t, median scenario, Iran, IMPE.gph", replace
graph export "graph 21 COVID-19 daily R t, median scenario, Iran, IMPE.pdf", replace





* daily R t, 6 scenarios

twoway ///
(line DayRttMeRaA03S01V07 date, sort lcolor(green)) ///
(line DayRttMeRaA03S02V07 date, sort lcolor(black)) ///
(line DayRttMeRaA03S03V07 date, sort lcolor(red)) ///
(line DayRttMeRaA03S04V07 date, sort lcolor(green) lpattern(dash)) ///
(line DayRttMeRaA03S05V07 date, sort lcolor(black) lpattern(dash)) ///
(line DayRttMeRaA03S06V07 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcome) title("COVID-19 daily R t, Iran, IMPE, 6 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(1))
  	   
graph save "graph 22 COVID-19 daily R t, 6 scenarios, Iran, IMPE.gph", replace
graph export "graph 22 COVID-19 daily R t, 6 scenarios, Iran, IMPE.pdf", replace





* daily prevalence, median scenario s

twoway ///
(rarea DayPreLoRaA03S01V07 DayPreUpRaA03S01V07 date, sort color(green*0.2)) ///
(line DayPreMeRaA03S01V07 date, sort lcolor(black)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
ytitle(Daily outcome) title("COVID-19 daily prevalence, Iran, IMPE, median scenario", size(medium)) legend(off)

graph save "graph 23 COVID-19 daily prevalence, median scenario, Iran, IMPE.gph", replace
graph export "graph 23 COVID-19 daily prevalence, median scenario, Iran, IMPE.pdf", replace





* daily prevalence, 6 scenarios

twoway ///
(line DayPreMeRaA03S01V07 date, sort lcolor(green)) ///
(line DayPreMeRaA03S02V07 date, sort lcolor(black)) ///
(line DayPreMeRaA03S03V07 date, sort lcolor(red)) ///
(line DayPreMeRaA03S04V07 date, sort lcolor(green) lpattern(dash)) ///
(line DayPreMeRaA03S05V07 date, sort lcolor(black) lpattern(dash)) ///
(line DayPreMeRaA03S06V07 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcome) title("COVID-19 daily prevalence, Iran, IMPE, 6 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(1))
  	   
graph save "graph 24 COVID-19 daily prevalence, 6 scenarios, Iran, IMPE.gph", replace
graph export "graph 24 COVID-19 daily prevalence, 6 scenarios, Iran, IMPE.pdf", replace





* DayCas DayDea Dea_multip

twoway ///
(line DayCasMeRaA03S02V07 date, sort lcolor(blue)) ///
(line DayDeaMeRaA03S02V07 date, sort lcolor(red)) ///
(line DayDMuMeRaA03S02V07 date, sort lpattern(dot) lcolor(red)) ///
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(#`xticks', format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases and deaths) title("COVID-19 daily cases and deaths, Iran, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) yscale(titlegap(4)) legend(region(lcolor(none)))  ///
legend(order(1 "Daily cases" 2 "Daily deaths" 3 "Daily deaths scaled for visualization") size(small)) ///
subtitle("Daily deaths, scaled = times (means of cases divided by deaths) for visualization only", size(small)) ///
note("Current scenario, mean estimate")

qui graph save "graph 25 COVID-19 daily deaths and cases Iran, IMPE.gph", replace
qui graph export "graph 25 COVID-19 daily deaths and cases Iran, IMPE.pdf", replace


***




sort date loc_grand_name

qui compress

save "Iran IMPE.dta", replace





view "log Iran IMPE.smcl"

log close

exit, clear




