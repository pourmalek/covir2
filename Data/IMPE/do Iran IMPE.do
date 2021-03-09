
clear all

cd "$pathcovir2"

cd IMPE

capture log close 

log using "log Iran IMPE.smcl", replace

***************************************************************************
* This is "do Iran IMPE.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time: 2021-02-10

* OBJECTIVE: Get and prepare IMPErial study estimates for Iran, Locate peak dates and values
***************************************************************************

clear all


*****************************

* get IMPE estimates

 

copy https://raw.githubusercontent.com/mrc-ide/global-lmic-reports/master/data/2021-02-17_v7.csv.zip 2021-02-17_v7.csv.zip
unzipfile 2021-02-17_v7.csv.zip, replace
erase 2021-02-17_v7.csv.zip




******************************

* import csv file


import delimited "2021-02-17_v7.csv", clear varnames(1)

save "2021-02-17_v7.dta", replace




use "2021-02-17_v7.dta", clear 

keep if strpos(country, "Iran")


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
  

* keep Total Deaths, Total Cases, Daily Deaths, and Daily Cases

  
keep if compartment == "cumulative_deaths" | ///
	    compartment == "cumulative_infections" | ///
	    compartment == "deaths" | ///
	    compartment == "infections"   
		
replace compartment = "cumul_death" if compartment == "cumulative_deaths"
replace compartment = "cumul_infec" if compartment == "cumulative_infections"
replace compartment = "daily_death" if compartment == "deaths"
replace compartment = "daily_infec" if compartment == "infections"


* reshape

egen compartment_scenario_snail = concat(compartment underline scenario_snail)	

drop compartment underline scenario_snail

tab compartment_scenario_snail


reshape wide y_025_ y_250_ y_med_ y_mea_ y_750_ y_975_, i(country dateblock) j(compartment_scenario_snail) string


*


foreach v of varlist y_025_cumul_death_S1-y_975_daily_infec_S6 { 

	local first = substr("`v'", 7, 11) 
	//di "`first'"
	local second = substr("`v'", 6, 1)
	//di "`second'"
	local third  = substr("`v'", 1, 5)
	//di "`third'"
	//di "`first' `second' `third'" 
	local fourth = substr("`v'", 19, 2)
	//di "`fourth'"
	label var `v' "`first'`second'`third'`second'`fourth'"
} 
*



foreach v of varlist y_025_cumul_death_S1-y_975_daily_infec_S6 { 
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



foreach v of varlist cumul_death_y_025_S1-daily_infec_y_975_S6 { 

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
	
	qui renvars, postsub(S1 A03S01V07) 
	qui renvars, postsub(S2 A03S02V07) 
	qui renvars, postsub(S3 A03S03V07) 
	qui renvars, postsub(S4 A03S04V07) 
	qui renvars, postsub(S5 A03S05V07) 
	qui renvars, postsub(S6 A03S06V07) 
	
} 
*   

drop daily*

drop cumul*

drop report_date version death_calibrated

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

rename country loc_grand_name

drop dateblock iso3c year month day date2


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


 

*************************

* graphs 


grstyle init

grstyle color background white



* daily deaths, 6 scenarios


twoway ///
(line DayDeaMeRaA03S01V07 date, sort lcolor(green)) ///
(line DayDeaMeRaA03S02V07 date, sort lcolor(black)) ///
(line DayDeaMeRaA03S03V07 date, sort lcolor(red)) ///
(line DayDeaMeRaA03S04V07 date, sort lcolor(green) lpattern(dash)) ///
(line DayDeaMeRaA03S05V07 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeRaA03S06V07 date, sort lcolor(red) lpattern(dash)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IMPE, 6 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(2))
  	   
graph save "graph COVID-19 daily deaths, 6 scenarios, Iran, IMPE.gph", replace
// // graph export "graph COVID-19 daily deaths, 6 scenarios, Iran, IMPE.pdf", replace




* daily deaths, S2 = median scenario 

twoway ///
(rarea DayDeaLoRaA03S02V07 DayDeaUpRaA03S02V07 date, sort color(green*0.2)) ///
(line DayDeaMeRaA03S02V07 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IMPE, median scenario", size(medium)) legend(off)

graph save "graph COVID-19 daily deaths, median scenario, Iran, IMPE.gph", replace
// // graph export "graph COVID-19 daily deaths, median scenario, Iran, IMPE.pdf", replace







* daily cases, 6 scenarios


twoway ///
(line DayCasMeRaA03S01V07 date, sort lcolor(green)) ///
(line DayCasMeRaA03S02V07 date, sort lcolor(black)) ///
(line DayCasMeRaA03S03V07 date, sort lcolor(red)) ///
(line DayCasMeRaA03S04V07 date, sort lcolor(green) lpattern(dash)) ///
(line DayCasMeRaA03S05V07 date, sort lcolor(black) lpattern(dash)) ///
(line DayCasMeRaA03S06V07 date, sort lcolor(red) lpattern(dash)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IMPE, 6 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(2))
  	   
graph save "graph COVID-19 daily cases, 6 scenarios, Iran, IMPE.gph", replace
// // graph export "graph COVID-19 daily cases, 6 scenarios, Iran, IMPE.pdf", replace




* daily cases, S2 = median scenario 

twoway ///
(rarea DayCasLoRaA03S02V07 DayCasUpRaA03S02V07 date, sort color(green*0.2)) ///
(line DayCasMeRaA03S02V07 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IMPE, median scenario", size(medium)) legend(off)

graph save "graph COVID-19 daily cases, median scenario, Iran, IMPE.gph", replace
// // graph export "graph COVID-19 daily cases, median scenario, Iran, IMPE.pdf", replace







*************************************

* Locate peak dates and values - deaths 


* S2 = median scenario 


* first peak

summ DayDeaMeRaA03S02V07 if date > td(15mar2020) & date < td(15apr2020) 

gen DayDeaMeRaA03S02V07P1V = r(max)
 
summ date if DayDeaMeRaA03S02V07 == DayDeaMeRaA03S02V07P1V & date > td(15mar2020) & date < td(15apr2020) 

gen DayDeaMeRaA03S02V07P1D = r(max)

summ DayDeaLoRaA03S02V07 if date == DayDeaMeRaA03S02V07P1D

gen DayDeaLoRaA03S02V07P1V = r(max)

summ DayDeaUpRaA03S02V07 if date == DayDeaMeRaA03S02V07P1D 

gen DayDeaUpRaA03S02V07P1V = r(max)

label var DayDeaMeRaA03S02V07P1V "DayDeaMeRaA03S02V07 Peak 1 Value"
label var DayDeaMeRaA03S02V07P1D "DayDeaMeRaA03S02V07 Peak 1 Date"
label var DayDeaLoRaA03S02V07P1V "DayDeaLoRaA03S02V07 Peak 1 Value"
label var DayDeaUpRaA03S02V07P1V "DayDeaUpRaA03S02V07 Peak 1 Value"
format DayDeaMeRaA03S02V07P1D %tdDDMonCCYY

* second peak 

summ DayDeaMeRaA03S02V07 if date > td(01jul2020) & date < td(30jul2020) 

gen DayDeaMeRaA03S02V07P2V = r(max)

summ date if DayDeaMeRaA03S02V07 == DayDeaMeRaA03S02V07P2V & date > td(01jul2020) & date < td(30jul2020) 

gen DayDeaMeRaA03S02V07P2D = r(max)

summ DayDeaLoRaA03S02V07 if date == DayDeaMeRaA03S02V07P2D

gen DayDeaLoRaA03S02V07P2V = r(max)

summ DayDeaUpRaA03S02V07 if date == DayDeaMeRaA03S02V07P2D

gen DayDeaUpRaA03S02V07P2V = r(max)

label var DayDeaMeRaA03S02V07P2V "DayDeaMeRaA03S02V07 Peak 2 Value"
label var DayDeaMeRaA03S02V07P2D "DayDeaMeRaA03S02V07 Peak 2 Date"
label var DayDeaLoRaA03S02V07P2V "DayDeaLoRaA03S02V07 Peak 2 Value"
label var DayDeaUpRaA03S02V07P2V "DayDeaUpRaA03S02V07 Peak 2 Value"
format DayDeaMeRaA03S02V07P2D %tdDDMonCCYY


* third peak 

summ DayDeaMeRaA03S02V07 if date > td(01oct2020) & date < td(30nov2020) 

gen DayDeaMeRaA03S02V07P3V = r(max)

summ date if DayDeaMeRaA03S02V07 == DayDeaMeRaA03S02V07P3V & date > td(01nov2020) & date < td(30nov2020) 

gen DayDeaMeRaA03S02V07P3D = r(max)

summ DayDeaLoRaA03S02V07 if date == DayDeaMeRaA03S02V07P3D

gen DayDeaLoRaA03S02V07P3V = r(max)

summ DayDeaUpRaA03S02V07 if date == DayDeaMeRaA03S02V07P3D

gen DayDeaUpRaA03S02V07P3V = r(max)

label var DayDeaMeRaA03S02V07P3V "DayDeaMeRaA03S02V07 Peak 3 Value"
label var DayDeaMeRaA03S02V07P3D "DayDeaMeRaA03S02V07 Peak 3 Date"
label var DayDeaLoRaA03S02V07P3V "DayDeaLoRaA03S02V07 Peak 3 Value"
label var DayDeaUpRaA03S02V07P3V "DayDeaUpRaA03S02V07 Peak 3 Value"
format DayDeaMeRaA03S02V07P3D %tdDDMonCCYY

* fourth peak 

summ DayDeaMeRaA03S02V07 if date > td(01apr2021) & date < td(30jun2021) 

gen DayDeaMeRaA03S02V07P4V = r(max)

summ date if DayDeaMeRaA03S02V07 == DayDeaMeRaA03S02V07P4V & date > td(01apr2021) & date < td(30jun2021) // 05May2021 

gen DayDeaMeRaA03S02V07P4D = r(max)

summ DayDeaLoRaA03S02V07 if date == DayDeaMeRaA03S02V07P4D

gen DayDeaLoRaA03S02V07P4V = r(max)

summ DayDeaUpRaA03S02V07 if date == DayDeaMeRaA03S02V07P4D

gen DayDeaUpRaA03S02V07P4V = r(max)

label var DayDeaMeRaA03S02V07P4V "DayDeaMeRaA03S02V07 Peak 4 Value"
label var DayDeaMeRaA03S02V07P4D "DayDeaMeRaA03S02V07 Peak 4 Date"
label var DayDeaLoRaA03S02V07P4V "DayDeaLoRaA03S02V07 Peak 4 Value"
label var DayDeaUpRaA03S02V07P4V "DayDeaUpRaA03S02V07 Peak 4 Value"
format DayDeaMeRaA03S02V07P4D %tdDDMonCCYY

* end date avialable 

summ date if DayDeaMeRaA03S02V07 != . 

gen A03DZ = r(max)

label var A03DZ "A03 End date"

summ DayDeaMeRaA03S02V07 if date == A03DZ

gen DayDeaMeRaA03S02V07P8V = r(max)

summ DayDeaLoRaA03S02V07 if date == A03DZ

gen DayDeaLoRaA03S02V07P8V = r(max)

summ DayDeaUpRaA03S02V07 if date == A03DZ

gen DayDeaUpRaA03S02V07P8V = r(max)

label var DayDeaMeRaA03S02V07P8V "DayDeaMeRaA03S02V07 End date Value"
label var DayDeaLoRaA03S02V07P8V "DayDeaLoRaA03S02V07 End date Value"
label var DayDeaUpRaA03S02V07P8V "DayDeaUpRaA03S02V07 End date Value"





* S1 = best scenario





* first peak

summ DayDeaMeRaA03S01V07 if date > td(15mar2020) & date < td(15apr2020) 

gen DayDeaMeRaA03S01V07P1V = r(max)

summ date if DayDeaMeRaA03S01V07 == DayDeaMeRaA03S01V07P1V & date > td(15mar2020) & date < td(15apr2020) 

gen DayDeaMeRaA03S01V07P1D = r(max)

summ DayDeaLoRaA03S01V07 if date == DayDeaMeRaA03S01V07P1D

gen DayDeaLoRaA03S01V07P1V = r(max)

summ DayDeaUpRaA03S01V07 if date == DayDeaMeRaA03S01V07P1D

gen DayDeaUpRaA03S01V07P1V = r(max)

label var DayDeaMeRaA03S01V07P1V "DayDeaMeRaA03S01V07 Peak 1 Value"
label var DayDeaMeRaA03S01V07P1D "DayDeaMeRaA03S01V07 Peak 1 Date"
label var DayDeaLoRaA03S01V07P1V "DayDeaLoRaA03S01V07 Peak 1 Value"
label var DayDeaUpRaA03S01V07P1V "DayDeaUpRaA03S01V07 Peak 1 Value"
format DayDeaMeRaA03S01V07P1D %tdDDMonCCYY


* second peak 

summ DayDeaMeRaA03S01V07 if date > td(01jul2020) & date < td(30jul2020) 

gen DayDeaMeRaA03S01V07P2V = r(max)

summ date if DayDeaMeRaA03S01V07 == DayDeaMeRaA03S01V07P2V & date > td(01jul2020) & date < td(30jul2020) 

gen DayDeaMeRaA03S01V07P2D = r(max)

summ DayDeaLoRaA03S01V07 if date == DayDeaMeRaA03S01V07P2D

gen DayDeaLoRaA03S01V07P2V = r(max)

summ DayDeaUpRaA03S01V07 if date == DayDeaMeRaA03S01V07P2D

gen DayDeaUpRaA03S01V07P2V = r(max)

label var DayDeaMeRaA03S01V07P2V "DayDeaMeRaA03S01V07 Peak 2 Value"
label var DayDeaMeRaA03S01V07P2D "DayDeaMeRaA03S01V07 Peak 2 Date"
label var DayDeaLoRaA03S01V07P2V "DayDeaLoRaA03S01V07 Peak 2 Value"
label var DayDeaUpRaA03S01V07P2V "DayDeaUpRaA03S01V07 Peak 2 Value"
format DayDeaMeRaA03S01V07P2D %tdDDMonCCYY


* third peak 

summ DayDeaMeRaA03S01V07 if date > td(01oct2020) & date < td(30nov2020) 

gen DayDeaMeRaA03S01V07P3V = r(max)

summ date if DayDeaMeRaA03S01V07 == DayDeaMeRaA03S01V07P3V & date > td(01nov2020) & date < td(30nov2020) 

gen DayDeaMeRaA03S01V07P3D = r(max)

summ DayDeaLoRaA03S01V07 if date == DayDeaMeRaA03S01V07P3D

gen DayDeaLoRaA03S01V07P3V = r(max)

summ DayDeaUpRaA03S01V07 if date == DayDeaMeRaA03S01V07P3D

gen DayDeaUpRaA03S01V07P3V = r(max)

label var DayDeaMeRaA03S01V07P3V "DayDeaMeRaA03S01V07 Peak 3 Value"
label var DayDeaMeRaA03S01V07P3D "DayDeaMeRaA03S01V07 Peak 3 Date"
label var DayDeaLoRaA03S01V07P3V "DayDeaLoRaA03S01V07 Peak 3 Value"
label var DayDeaUpRaA03S01V07P3V "DayDeaUpRaA03S01V07 Peak 3 Value"
format DayDeaMeRaA03S01V07P3D %tdDDMonCCYY


* fourth peak 

* S1 = best scenario does not have a fourth peak 

* end date avialable 

summ DayDeaMeRaA03S01V07 if date == A03DZ

gen DayDeaMeRaA03S01V07P8 = r(max)

summ DayDeaLoRaA03S01V07 if date == A03DZ

gen DayDeaLoRaA03S01V07P8 = r(max)

summ DayDeaUpRaA03S01V07 if date == A03DZ

gen DayDeaUpRaA03S01V07P8 = r(max)

label var DayDeaMeRaA03S01V07P8 "DayDeaMeRaA03S01V07 End date Value"
label var DayDeaLoRaA03S01V07P8 "DayDeaLoRaA03S01V07 End date Value"
label var DayDeaUpRaA03S01V07P8 "DayDeaUpRaA03S01V07 End date Value"




* S3 = worst scenario


* first peak

summ DayDeaMeRaA03S03V07 if date > td(15mar2020) & date < td(15apr2020)

gen DayDeaMeRaA03S03V07P1V = r(max)

summ date if DayDeaMeRaA03S03V07 == DayDeaMeRaA03S03V07P1V & date > td(15mar2020) & date < td(15apr2020) 

gen DayDeaMeRaA03S03V07P1D = r(max)

summ DayDeaLoRaA03S03V07 if date == DayDeaMeRaA03S03V07P1D

gen DayDeaLoRaA03S03V07P1V = r(max)

summ DayDeaUpRaA03S03V07 if date == DayDeaMeRaA03S03V07P1D

gen DayDeaUpRaA03S03V07P1V = r(max)

label var DayDeaMeRaA03S03V07P1V "DayDeaMeRaA03S03V07 Peak 1 Value"
label var DayDeaMeRaA03S03V07P1D "DayDeaMeRaA03S03V07 Peak 1 Date"
label var DayDeaLoRaA03S03V07P1V "DayDeaLoRaA03S03V07 Peak 1 Value"
label var DayDeaUpRaA03S03V07P1V "DayDeaUpRaA03S03V07 Peak 1 Value"
format DayDeaMeRaA03S03V07P1D %tdDDMonCCYY


* second peak 

summ DayDeaMeRaA03S03V07 if date > td(01jul2020) & date < td(30jul2020) 

gen DayDeaMeRaA03S03V07P2V = r(max)

summ date if DayDeaMeRaA03S03V07 == DayDeaMeRaA03S03V07P2V & date > td(01jul2020) & date < td(30jul2020) 

gen DayDeaMeRaA03S03V07P2D = r(max)

summ DayDeaLoRaA03S03V07 if date == DayDeaMeRaA03S03V07P2D

gen DayDeaLoRaA03S03V07P2V = r(max)

summ DayDeaUpRaA03S03V07 if date == DayDeaMeRaA03S03V07P2D

gen DayDeaUpRaA03S03V07P2V = r(max)

label var DayDeaMeRaA03S03V07P2V "DayDeaMeRaA03S03V07 Peak 2 Value"
label var DayDeaMeRaA03S03V07P2D "DayDeaMeRaA03S03V07 Peak 2 Date"
label var DayDeaLoRaA03S03V07P2V "DayDeaLoRaA03S03V07 Peak 2 Value"
label var DayDeaUpRaA03S03V07P2V "DayDeaUpRaA03S03V07 Peak 2 Value"
format DayDeaMeRaA03S03V07P2D %tdDDMonCCYY


* third peak 

summ DayDeaMeRaA03S03V07 if date > td(01oct2020) & date < td(30nov2020) 

gen DayDeaMeRaA03S03V07P3V = r(max)

summ date if DayDeaMeRaA03S03V07 == DayDeaMeRaA03S03V07P3V & date > td(01nov2020) & date < td(30nov2020) 

gen DayDeaMeRaA03S03V07P3D = r(max)

summ DayDeaLoRaA03S03V07 if date == DayDeaMeRaA03S03V07P3D

gen DayDeaLoRaA03S03V07P3V = r(max)

summ DayDeaUpRaA03S03V07 if date == DayDeaMeRaA03S03V07P3D

gen DayDeaUpRaA03S03V07P3V = r(max)

label var DayDeaMeRaA03S03V07P3V "DayDeaMeRaA03S03V07 Peak 3 Value"
label var DayDeaMeRaA03S03V07P3D "DayDeaMeRaA03S03V07 Peak 3 Date"
label var DayDeaLoRaA03S03V07P3V "DayDeaLoRaA03S03V07 Peak 3 Value"
label var DayDeaUpRaA03S03V07P3V "DayDeaUpRaA03S03V07 Peak 3 Value"
format DayDeaMeRaA03S03V07P3D %tdDDMonCCYY

* fourth peak 

summ DayDeaMeRaA03S03V07 if date > td(01apr2021) & date < td(30jun2021) 

gen DayDeaMeRaA03S03V07P4V = r(max) 

summ date if DayDeaMeRaA03S03V07 == DayDeaMeRaA03S03V07P4V & date > td(01apr2021) & date < td(30jun2021) 

gen DayDeaMeRaA03S03V07P4D = r(max) 

summ DayDeaLoRaA03S03V07 if date == DayDeaMeRaA03S03V07P4D

gen DayDeaLoRaA03S03V07P4V = r(max)

summ DayDeaUpRaA03S03V07 if date == DayDeaMeRaA03S03V07P4D

gen DayDeaUpRaA03S03V07P4V = r(max)

label var DayDeaMeRaA03S03V07P4V "DayDeaMeRaA03S03V07 Peak 4 Value"
label var DayDeaMeRaA03S03V07P4D "DayDeaMeRaA03S03V07 Peak 4 Date"
label var DayDeaLoRaA03S03V07P4V "DayDeaLoRaA03S03V07 Peak 4 Value"
label var DayDeaUpRaA03S03V07P4V "DayDeaUpRaA03S03V07 Peak 4 Value"
format DayDeaMeRaA03S03V07P4D %tdDDMonCCYY


* end date avialable 

summ DayDeaMeRaA03S03V07 if date == A03DZ 

gen DayDeaMeRaA03S03V07P8 = r(max)

summ DayDeaLoRaA03S03V07 if date == A03DZ

gen DayDeaLoRaA03S03V07P8 = r(max)

summ DayDeaUpRaA03S03V07 if date == A03DZ

gen DayDeaUpRaA03S03V07P8 = r(max)

label var DayDeaMeRaA03S03V07P8 "DayDeaMeRaA03S03V07 End date Value"
label var DayDeaLoRaA03S03V07P8 "DayDeaLoRaA03S03V07 End date Value"
label var DayDeaUpRaA03S03V07P8 "DayDeaUpRaA03S03V07 End date Value"



****************
  
  
* Locate peak dates and values - cases 


* S2 = median scenario 


* first peak

summ DayCasMeRaA03S02V07 if date > td(01mar2020) & date < td(30mar2020) 

gen DayCasMeRaA03S02V07P1V = r(max)

summ date if DayCasMeRaA03S02V07 == DayCasMeRaA03S02V07P1V & date > td(01mar2020) & date < td(30mar2020) 

gen DayCasMeRaA03S02V07P1D = r(max)

summ DayCasLoRaA03S02V07 if date == DayCasMeRaA03S02V07P1D

gen DayCasLoRaA03S02V07P1V = r(max)

summ DayCasUpRaA03S02V07 if date == DayCasMeRaA03S02V07P1D

gen DayCasUpRaA03S02V07P1V = r(max)

label var DayCasMeRaA03S02V07P1V "DayCasMeRaA03S02V07 Peak 1 Value"
label var DayCasMeRaA03S02V07P1D "DayCasMeRaA03S02V07 Peak 1 Date"
label var DayCasLoRaA03S02V07P1V "DayCasLoRaA03S02V07 Peak 1 Value"
label var DayCasUpRaA03S02V07P1V "DayCasUpRaA03S02V07 Peak 1 Value"
format DayCasMeRaA03S02V07P1D %tdDDMonCCYY



* second peak

summ DayCasMeRaA03S02V07 if date > td(01jul2020) & date < td(30jul2020) 

gen DayCasMeRaA03S02V07P2V = r(max)

summ date if DayCasMeRaA03S02V07 == DayCasMeRaA03S02V07P2V & date > td(01jul2020) & date < td(30jul2020) 

gen DayCasMeRaA03S02V07P2D = r(max)

summ DayCasLoRaA03S02V07 if date == DayCasMeRaA03S02V07P2D

gen DayCasLoRaA03S02V07P2V = r(max)

summ DayCasUpRaA03S02V07 if date == DayCasMeRaA03S02V07P2D

gen DayCasUpRaA03S02V07P2V = r(max)

label var DayCasMeRaA03S02V07P2V "DayCasMeRaA03S02V07 Peak 2 Value"
label var DayCasMeRaA03S02V07P2D "DayCasMeRaA03S02V07 Peak 2 Date"
label var DayCasLoRaA03S02V07P2V "DayCasLoRaA03S02V07 Peak 2 Value"
label var DayCasUpRaA03S02V07P2V "DayCasUpRaA03S02V07 Peak 2 Value"
format DayCasMeRaA03S02V07P2D %tdDDMonCCYY



* third peak

summ DayCasMeRaA03S02V07 if date > td(01oct2020) & date < td(30oct2020) 

gen DayCasMeRaA03S02V07P3V = r(max)

summ date if DayCasMeRaA03S02V07 == DayCasMeRaA03S02V07P3V & date > td(01oct2020) & date < td(30oct2020) 

gen DayCasMeRaA03S02V07P3D = r(max)

summ DayCasLoRaA03S02V07 if date == DayCasMeRaA03S02V07P3D

gen DayCasLoRaA03S02V07P3V = r(max)

summ DayCasUpRaA03S02V07 if date == DayCasMeRaA03S02V07P3D

gen DayCasUpRaA03S02V07P3V = r(max)

label var DayCasMeRaA03S02V07P3V "DayCasMeRaA03S02V07 Peak 3 Value"
label var DayCasMeRaA03S02V07P3D "DayCasMeRaA03S02V07 Peak 3 Date"
label var DayCasLoRaA03S02V07P3V "DayCasLoRaA03S02V07 Peak 3 Value"
label var DayCasUpRaA03S02V07P3V "DayCasUpRaA03S02V07 Peak 3 Value"
format DayCasMeRaA03S02V07P3D %tdDDMonCCYY

* fourth peak

summ DayCasMeRaA03S02V07 if date > td(01apr2021) & date < td(30jun2021) 

gen DayCasMeRaA03S02V07P4V = r(max)

summ date if DayCasMeRaA03S02V07 == DayCasMeRaA03S02V07P4V & date > td(01apr2021) & date < td(30jun2021) 

gen DayCasMeRaA03S02V07P4D = r(max)

summ DayCasLoRaA03S02V07 if date == DayCasMeRaA03S02V07P4D

gen DayCasLoRaA03S02V07P4V = r(max)

summ DayCasUpRaA03S02V07 if date == DayCasMeRaA03S02V07P4D

gen DayCasUpRaA03S02V07P4V = r(max)

label var DayCasMeRaA03S02V07P4V "DayCasMeRaA03S02V07 Peak 4 Value"
label var DayCasMeRaA03S02V07P4D "DayCasMeRaA03S02V07 Peak 4 Date"
label var DayCasLoRaA03S02V07P4V "DayCasLoRaA03S02V07 Peak 4 Value"
label var DayCasUpRaA03S02V07P4V "DayCasUpRaA03S02V07 Peak 4 Value"
format DayCasMeRaA03S02V07P4D %tdDDMonCCYY


* end date avialable 

summ DayCasMeRaA03S02V07 if date == A03DZ

gen DayCasMeRaA03S02V07P8V = r(max)

summ DayCasLoRaA03S02V07 if date == A03DZ

gen DayCasLoRaA03S02V07P8V = r(max)

summ DayCasUpRaA03S02V07 if date == A03DZ

gen DayCasUpRaA03S02V07P8V = r(max)


label var DayCasMeRaA03S02V07P8V "DayCasMeRaA03S02V07 End date Value"
label var DayCasLoRaA03S02V07P8V "DayCasLoRaA03S02V07 End date Value"
label var DayCasUpRaA03S02V07P8V "DayCasUpRaA03S02V07 End date Value"





* S1 = best scenario

* first peak

summ DayCasMeRaA03S01V07 if date > td(01mar2020) & date < td(30mar2020) 

gen DayCasMeRaA03S01V07P1V = r(max)

summ date if DayCasMeRaA03S01V07 == DayCasMeRaA03S01V07P1V & date > td(01mar2020) & date < td(30mar2020) 

gen DayCasMeRaA03S01V07P1D = r(max)

summ DayCasLoRaA03S01V07 if date == DayCasMeRaA03S01V07P1D

gen DayCasLoRaA03S01V07P1V = r(max)

summ DayCasUpRaA03S01V07 if date == DayCasMeRaA03S01V07P1D

gen DayCasUpRaA03S01V07P1V = r(max)

label var DayCasMeRaA03S01V07P1V "DayCasMeRaA03S01V07 Peak 1 Value"
label var DayCasMeRaA03S01V07P1D "DayCasMeRaA03S01V07 Peak 1 Date"
label var DayCasLoRaA03S01V07P1V "DayCasLoRaA03S01V07 Peak 1 Value"
label var DayCasUpRaA03S01V07P1V "DayCasUpRaA03S01V07 Peak 1 Value"
format DayCasMeRaA03S01V07P1D %tdDDMonCCYY


* second peak

summ DayCasMeRaA03S01V07 if date > td(01jul2020) & date < td(30jul2020) 

gen DayCasMeRaA03S01V07P2V = r(max)

summ date if DayCasMeRaA03S01V07 == DayCasMeRaA03S01V07P2V & date > td(01jul2020) & date < td(30jul2020) 

gen DayCasMeRaA03S01V07P2D = r(max)

summ DayCasLoRaA03S01V07 if date == DayCasMeRaA03S01V07P2D

gen DayCasLoRaA03S01V07P2V = r(max)

summ DayCasUpRaA03S01V07 if date == DayCasMeRaA03S01V07P2D

gen DayCasUpRaA03S01V07P2V = r(max)

label var DayCasMeRaA03S01V07P2V "DayCasMeRaA03S01V07 Peak 2 Value"
label var DayCasMeRaA03S01V07P2D "DayCasMeRaA03S01V07 Peak 2 Date"
label var DayCasLoRaA03S01V07P2V "DayCasLoRaA03S01V07 Peak 2 Value"
label var DayCasUpRaA03S01V07P2V "DayCasUpRaA03S01V07 Peak 2 Value"
format DayCasMeRaA03S01V07P2D %tdDDMonCCYY

* third peak

summ DayCasMeRaA03S01V07 if date > td(01oct2020) & date < td(30oct2020) 

gen DayCasMeRaA03S01V07P3V = r(max)

summ date if DayCasMeRaA03S01V07 == DayCasMeRaA03S01V07P3V & date > td(01oct2020) & date < td(30oct2020) 

gen DayCasMeRaA03S01V07P3D = r(max)

summ DayCasLoRaA03S01V07 if date == DayCasMeRaA03S01V07P3D

gen DayCasLoRaA03S01V07P3V = r(max)

summ DayCasUpRaA03S01V07 if date == DayCasMeRaA03S01V07P3D

gen DayCasUpRaA03S01V07P3V = r(max)

label var DayCasMeRaA03S01V07P3V "DayCasMeRaA03S01V07 Peak 3 Value"
label var DayCasMeRaA03S01V07P3D "DayCasMeRaA03S01V07 Peak 3 Date"
label var DayCasLoRaA03S01V07P3V "DayCasLoRaA03S01V07 Peak 3 Value"
label var DayCasUpRaA03S01V07P3V "DayCasUpRaA03S01V07 Peak 3 Value"
format DayCasMeRaA03S01V07P3D %tdDDMonCCYY

* fourth peak

* S1 = best scenario does not have a fourth peak 



* end date avialable 

summ DayCasMeRaA03S01V07 if date == A03DZ

gen DayCasMeRaA03S01V07P8V = r(max)

summ DayCasLoRaA03S01V07 if date == A03DZ

gen DayCasLoRaA03S01V07P8V = r(max)

summ DayCasUpRaA03S01V07 if date == A03DZ

gen DayCasUpRaA03S01V07P8V = r(max)


label var DayCasMeRaA03S01V07P8V "DayCasMeRaA03S01V07 End date Value"
label var DayCasLoRaA03S01V07P8V "DayCasLoRaA03S01V07 End date Value"
label var DayCasUpRaA03S01V07P8V "DayCasUpRaA03S01V07 End date Value"




* S3 = worst scenario


* first peak

summ DayCasMeRaA03S03V07 if date > td(01mar2020) & date < td(30mar2020) 

gen DayCasMeRaA03S03V07P1V = r(max)

summ date if DayCasMeRaA03S03V07 == DayCasMeRaA03S03V07P1V & date > td(01mar2020) & date < td(30mar2020) 

gen DayCasMeRaA03S03V07P1D = r(max)

summ DayCasLoRaA03S03V07 if date == DayCasMeRaA03S03V07P1D

gen DayCasLoRaA03S03V07P1V = r(max)

summ DayCasUpRaA03S03V07 if date == DayCasMeRaA03S03V07P1D

gen DayCasUpRaA03S03V07P1V = r(max)

label var DayCasMeRaA03S03V07P1V "DayCasMeRaA03S03V07 Peak 1 Value"
label var DayCasMeRaA03S03V07P1D "DayCasMeRaA03S03V07 Peak 1 Date"
label var DayCasLoRaA03S03V07P1V "DayCasLoRaA03S03V07 Peak 1 Value"
label var DayCasUpRaA03S03V07P1V "DayCasUpRaA03S03V07 Peak 1 Value"
format DayCasMeRaA03S03V07P1D %tdDDMonCCYY


* second peak

summ DayCasMeRaA03S03V07 if date > td(01jul2020) & date < td(30jul2020) 

gen DayCasMeRaA03S03V07P2V = r(max)

summ date if DayCasMeRaA03S03V07 == DayCasMeRaA03S03V07P2V & date > td(01jul2020) & date < td(30jul2020) 

gen DayCasMeRaA03S03V07P2D = r(max)

summ DayCasLoRaA03S03V07 if date == DayCasMeRaA03S03V07P2D 

gen DayCasLoRaA03S03V07P2V = r(max)

summ DayCasUpRaA03S03V07 if date == DayCasMeRaA03S03V07P2D

gen DayCasUpRaA03S03V07P2V = r(max)

label var DayCasMeRaA03S03V07P2V "DayCasMeRaA03S03V07 Peak 2 Value"
label var DayCasMeRaA03S03V07P2D "DayCasMeRaA03S03V07 Peak 2 Date"
label var DayCasLoRaA03S03V07P2V "DayCasLoRaA03S03V07 Peak 2 Value"
label var DayCasUpRaA03S03V07P2V "DayCasUpRaA03S03V07 Peak 2 Value"
format DayCasMeRaA03S03V07P2D %tdDDMonCCYY

* third peak

summ DayCasMeRaA03S03V07 if date > td(01oct2020) & date < td(30oct2020) 

gen DayCasMeRaA03S03V07P3V = r(max)

summ date if DayCasMeRaA03S03V07 == DayCasMeRaA03S03V07P3V & date > td(01oct2020) & date < td(30oct2020) 

gen DayCasMeRaA03S03V07P3D = r(max)

summ DayCasLoRaA03S03V07 if date == DayCasMeRaA03S03V07P3D

gen DayCasLoRaA03S03V07P3V = r(max)

summ DayCasUpRaA03S03V07 if date == DayCasMeRaA03S03V07P3D

gen DayCasUpRaA03S03V07P3V = r(max)

label var DayCasMeRaA03S03V07P3V "DayCasMeRaA03S03V07 Peak 3 Value"
label var DayCasMeRaA03S03V07P3D "DayCasMeRaA03S03V07 Peak 3 Date"
label var DayCasLoRaA03S03V07P3V "DayCasLoRaA03S03V07 Peak 3 Value"
label var DayCasUpRaA03S03V07P3V "DayCasUpRaA03S03V07 Peak 3 Value"
format DayCasMeRaA03S03V07P3D %tdDDMonCCYY

* fourth peak

summ DayCasMeRaA03S03V07 if date > td(01apr2021) & date < td(30jun2021) 

gen DayCasMeRaA03S03V07P4V = r(max)

summ date if DayCasMeRaA03S03V07 == DayCasMeRaA03S03V07P4V & date > td(01apr2021) & date < td(30jun2021) 

gen DayCasMeRaA03S03V07P4D = r(max)

summ DayCasLoRaA03S03V07 if date == DayCasMeRaA03S03V07P4D

gen DayCasLoRaA03S03V07P4V = r(max)

summ DayCasUpRaA03S03V07 if date == DayCasMeRaA03S03V07P4D

gen DayCasUpRaA03S03V07P4V = r(max)

label var DayCasMeRaA03S03V07P4V "DayCasMeRaA03S03V07 Peak 3 Value"
label var DayCasMeRaA03S03V07P4D "DayCasMeRaA03S03V07 Peak 3 Date"
label var DayCasLoRaA03S03V07P4V "DayCasLoRaA03S03V07 Peak 3 Value"
label var DayCasUpRaA03S03V07P4V "DayCasUpRaA03S03V07 Peak 3 Value"
format DayCasMeRaA03S03V07P4D %tdDDMonCCYY

* end date avialable 

summ DayCasMeRaA03S03V07 if date == A03DZ

gen DayCasMeRaA03S03V07P8V = r(max)

summ DayCasLoRaA03S03V07 if date == A03DZ

gen DayCasLoRaA03S03V07P8V = r(max)

summ DayCasUpRaA03S03V07 if date == A03DZ

gen DayCasUpRaA03S03V07P8V = r(max)


label var DayCasMeRaA03S03V07P8V "DayCasMeRaA03S03V07 End date Value"
label var DayCasLoRaA03S03V07P8V "DayCasLoRaA03S03V07 End date Value"
label var DayCasUpRaA03S03V07P8V "DayCasUpRaA03S03V07 End date Value"



sort date

compress

save "Iran IMPE.dta", replace



********************

* tab the peaks


use "Iran IMPE.dta", clear 


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

gen varnames_new = substr(varnames,1,22) 
drop varnames
rename varnames_new varnames 

order varnames varvalues

* gen peakname peakvalue for outcomes
* gen peakdate datevalue for dates

gen type = substr(varnames,22,1) 

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


save "Iran IMPE peaks.dta", replace

export excel using "Iran IMPE peaks.xlsx", replace firstrow(variables) 





view "log Iran IMPE.smcl"

log close

exit, clear




