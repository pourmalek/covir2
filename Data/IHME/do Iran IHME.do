

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

 

copy https://ihmecovid19storage.blob.core.windows.net/latest/ihme-covid19.zip ihme-covid19.zip
unzipfile ihme-covid19.zip, replace
erase ihme-covid19.zip



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

save "Reference Iran.dta", replace


* S2 Best

use "Best_masks_hospitalization_all_locs.dta", clear

keep if strpos(location_name, "Iran")


* rename variables


* Total Deaths not smoothed
rename totdea_mean  TotDeaMeRaA02S02
rename totdea_lower TotDeaLoRaA02S02
rename totdea_upper TotDeaUpRaA02S02
label var TotDeaMeRaA02S02 "Total Deaths Mean not smoothed IHME S2"
label var TotDeaLoRaA02S02 "Total Deaths Lower not smoothed IHME S2"
label var TotDeaUpRaA02S02 "Total Deaths Upper not smoothed IHME S2"

* Daily Deaths not smoothed
rename deaths_mean  DayDeaMeRaA02S02
rename deaths_lower DayDeaLoRaA02S02
rename deaths_upper DayDeaUpRaA02S02
label var DayDeaMeRaA02S02 "Daily Deaths Mean not smoothed IHME S2"
label var DayDeaLoRaA02S02 "Daily Deaths Lower not smoothed IHME S2"
label var DayDeaUpRaA02S02 "Daily Deaths Upper not smoothed IHME S2"
	
* Total Cases not smoothed
rename inf_cuml_mean  TotCasMeRaA02S02
rename inf_cuml_lower TotCasLoRaA02S02
rename inf_cuml_upper TotCasUpRaA02S02
label var TotCasMeRaA02S02 "Total Cases Mean not smoothed IHME S2"
label var TotCasLoRaA02S02 "Total Cases Lower not smoothed IHME S2"
label var TotCasUpRaA02S02 "Total Cases Upper not smoothed IHME S2"

* Daily Cases not smoothed
rename est_infections_mean  DayCasMeRaA02S02
rename est_infections_lower DayCasLoRaA02S02
rename est_infections_upper DayCasUpRaA02S02
label var DayCasMeRaA02S02 "Daily Cases Mean not smoothed IHME S2"
label var DayCasLoRaA02S02 "Daily Cases Lower not smoothed IHME S2"
label var DayCasUpRaA02S02 "Daily Cases Upper not smoothed IHME S2"

* Total Deaths smoothed
rename totdea_mean_smoothed   TotDeaMeSmA02S02
rename totdea_lower_smoothed  TotDeaLoSmA02S02
rename totdea_upper_smoothed  TotDeaUpSmA02S02
label var TotDeaMeSmA02S02 "Total Deaths Mean smoothed IHME S2"
label var TotDeaLoSmA02S02 "Total Deaths Lower smoothed IHME S2"
label var TotDeaUpSmA02S02 "Total Deaths Upper smoothed IHME S2"

* Daily Deaths smoothed
rename deaths_mean_smoothed  DayDeaMeSmA02S02    	
rename deaths_lower_smoothed DayDeaLoSmA02S02    	
rename deaths_upper_smoothed DayDeaUpSmA02S02  
label var DayDeaMeSmA02S02 "Daily Deaths Mean smoothed IHME S2"
label var DayDeaLoSmA02S02 "Daily Deaths Lower smoothed IHME S2"
label var DayDeaUpSmA02S02 "Daily Deaths Upper smoothed IHME S2"


save "Best Iran.dta", replace


* S3 Worse

use "Worse_hospitalization_all_locs.dta", clear

keep if strpos(location_name, "Iran")



* Total Deaths not smoothed
rename totdea_mean  TotDeaMeRaA02S03
rename totdea_lower TotDeaLoRaA02S03
rename totdea_upper TotDeaUpRaA02S03
label var TotDeaMeRaA02S03 "Total Deaths Mean not smoothed IHME S3"
label var TotDeaLoRaA02S03 "Total Deaths Lower not smoothed IHME S3"
label var TotDeaUpRaA02S03 "Total Deaths Upper not smoothed IHME S3"

* Daily Deaths not smoothed
rename deaths_mean  DayDeaMeRaA02S03
rename deaths_lower DayDeaLoRaA02S03
rename deaths_upper DayDeaUpRaA02S03
label var DayDeaMeRaA02S03 "Daily Deaths Mean not smoothed IHME S3"
label var DayDeaLoRaA02S03 "Daily Deaths Lower not smoothed IHME S3"
label var DayDeaUpRaA02S03 "Daily Deaths Upper not smoothed IHME S3"
	
* Total Cases not smoothed
rename inf_cuml_mean  TotCasMeRaA02S03
rename inf_cuml_lower TotCasLoRaA02S03
rename inf_cuml_upper TotCasUpRaA02S03
label var TotCasMeRaA02S03 "Total Cases Mean not smoothed IHME S3"
label var TotCasLoRaA02S03 "Total Cases Lower not smoothed IHME S3"
label var TotCasUpRaA02S03 "Total Cases Upper not smoothed IHME S3"

* Daily Cases not smoothed
rename est_infections_mean  DayCasMeRaA02S03
rename est_infections_lower DayCasLoRaA02S03
rename est_infections_upper DayCasUpRaA02S03
label var DayCasMeRaA02S03 "Daily Cases Mean not smoothed IHME S3"
label var DayCasLoRaA02S03 "Daily Cases Lower not smoothed IHME S3"
label var DayCasUpRaA02S03 "Daily Cases Upper not smoothed IHME S3"

* Total Deaths smoothed
rename totdea_mean_smoothed   TotDeaMeSmA02S03
rename totdea_lower_smoothed  TotDeaLoSmA02S03
rename totdea_upper_smoothed  TotDeaUpSmA02S03
label var TotDeaMeSmA02S03 "Total Deaths Mean smoothed IHME S3"
label var TotDeaLoSmA02S03 "Total Deaths Lower smoothed IHME S3"
label var TotDeaUpSmA02S03 "Total Deaths Upper smoothed IHME S3"

* Daily Deaths smoothed
rename deaths_mean_smoothed  DayDeaMeSmA02S03    	
rename deaths_lower_smoothed DayDeaLoSmA02S03    	
rename deaths_upper_smoothed DayDeaUpSmA02S03  
label var DayDeaMeSmA02S03 "Daily Deaths Mean smoothed IHME S3"
label var DayDeaLoSmA02S03 "Daily Deaths Lower smoothed IHME S3"
label var DayDeaUpSmA02S03 "Daily Deaths Upper smoothed IHME S3"

save "Worse Iran.dta", replace


 
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


keep ///
loc_grand_name date ///
TotDeaMeRaA02S01 TotDeaLoRaA02S01 TotDeaUpRaA02S01 ///
TotDeaMeRaA02S02 TotDeaLoRaA02S02 TotDeaUpRaA02S02 /// 
TotDeaMeRaA02S03 TotDeaLoRaA02S03 TotDeaUpRaA02S03 ///	
TotDeaMeSmA02S01 TotDeaLoSmA02S01 TotDeaUpSmA02S01 ///	
TotDeaMeSmA02S02 TotDeaLoSmA02S02 TotDeaUpSmA02S02 ///	
TotDeaMeSmA02S03 TotDeaLoSmA02S03 TotDeaUpSmA02S03 ///
DayDeaMeRaA02S01 DayDeaLoRaA02S01 DayDeaUpRaA02S01 ///	
DayDeaMeRaA02S02 DayDeaLoRaA02S02 DayDeaUpRaA02S02 ///	
DayDeaMeRaA02S03 DayDeaLoRaA02S03 DayDeaUpRaA02S03 ///	
DayDeaMeSmA02S01 DayDeaLoSmA02S01 DayDeaUpSmA02S01 ///	
DayDeaMeSmA02S02 DayDeaLoSmA02S02 DayDeaUpSmA02S02 ///	
DayDeaMeSmA02S03 DayDeaLoSmA02S03 DayDeaUpSmA02S03 ///	
TotCasMeRaA02S01 TotCasUpRaA02S01 TotCasLoRaA02S01 ///	
TotCasMeRaA02S02 TotCasUpRaA02S02 TotCasLoRaA02S02 ///	
TotCasMeRaA02S03 TotCasUpRaA02S03 TotCasLoRaA02S03 ///	
DayCasMeRaA02S01 DayCasLoRaA02S01 DayCasUpRaA02S01 ///	
DayCasMeRaA02S02 DayCasLoRaA02S02 DayCasUpRaA02S02 ///	
DayCasMeRaA02S03 DayCasLoRaA02S03 DayCasUpRaA02S03 ///	
total_pop ///
deaths_mean_p100k_rate deaths_lower_p100k_rate deaths_upper_p100k_rate /// 
totdea_mean_p100k_rate totdea_lower_p100k_rate totdea_upper_p100k_rate ///	
deaths_mean_smoothed_p100k_rate deaths_lower_smoothed_p100k_rate deaths_upper_smoothed_p100k_rate ///	
totdea_mean_smoothed_p100k_rate totdea_lower_smoothed_p100k_rate totdea_upper_smoothed_p100k_rate ///	
est_infections_mean_p100k_rate est_infections_lower_p100k_rate est_infections_upper_p100k_rate ///	
confirmed_infections_p100k_rate




order ///
loc_grand_name date ///
TotDeaMeRaA02S01 TotDeaLoRaA02S01 TotDeaUpRaA02S01 ///
TotDeaMeRaA02S02 TotDeaLoRaA02S02 TotDeaUpRaA02S02 /// 
TotDeaMeRaA02S03 TotDeaLoRaA02S03 TotDeaUpRaA02S03 ///	
TotDeaMeSmA02S01 TotDeaLoSmA02S01 TotDeaUpSmA02S01 ///	
TotDeaMeSmA02S02 TotDeaLoSmA02S02 TotDeaUpSmA02S02 ///	
TotDeaMeSmA02S03 TotDeaLoSmA02S03 TotDeaUpSmA02S03 ///
DayDeaMeRaA02S01 DayDeaLoRaA02S01 DayDeaUpRaA02S01 ///	
DayDeaMeRaA02S02 DayDeaLoRaA02S02 DayDeaUpRaA02S02 ///	
DayDeaMeRaA02S03 DayDeaLoRaA02S03 DayDeaUpRaA02S03 ///	
DayDeaMeSmA02S01 DayDeaLoSmA02S01 DayDeaUpSmA02S01 ///	
DayDeaMeSmA02S02 DayDeaLoSmA02S02 DayDeaUpSmA02S02 ///	
DayDeaMeSmA02S03 DayDeaLoSmA02S03 DayDeaUpSmA02S03 ///	
TotCasMeRaA02S01 TotCasUpRaA02S01 TotCasLoRaA02S01 ///	
TotCasMeRaA02S02 TotCasUpRaA02S02 TotCasLoRaA02S02 ///	
TotCasMeRaA02S03 TotCasUpRaA02S03 TotCasLoRaA02S03 ///	
DayCasMeRaA02S01 DayCasLoRaA02S01 DayCasUpRaA02S01 ///	
DayCasMeRaA02S02 DayCasLoRaA02S02 DayCasUpRaA02S02 ///	
DayCasMeRaA02S03 DayCasLoRaA02S03 DayCasUpRaA02S03 ///	
total_pop ///
deaths_mean_p100k_rate deaths_lower_p100k_rate deaths_upper_p100k_rate /// 
totdea_mean_p100k_rate totdea_lower_p100k_rate totdea_upper_p100k_rate ///	
deaths_mean_smoothed_p100k_rate deaths_lower_smoothed_p100k_rate deaths_upper_smoothed_p100k_rate ///	
totdea_mean_smoothed_p100k_rate totdea_lower_smoothed_p100k_rate totdea_upper_smoothed_p100k_rate ///	
est_infections_mean_p100k_rate est_infections_lower_p100k_rate est_infections_upper_p100k_rate ///	
confirmed_infections_p100k_rate


sort date

compress



* gen cfr

gen DayCfrMeRaA02S01 = 100 * DayDeaMeRaA02S01 / DayCasMeRaA02S01
gen DayCfrLoRaA02S01 = 100 * DayDeaLoRaA02S01 / DayCasLoRaA02S01
gen DayCfrUpRaA02S01 = 100 * DayDeaUpRaA02S01 / DayCasUpRaA02S01
gen DayCfrMeRaA02S02 = 100 * DayDeaMeRaA02S02 / DayCasMeRaA02S02
gen DayCfrLoRaA02S02 = 100 * DayDeaLoRaA02S02 / DayCasLoRaA02S02
gen DayCfrUpRaA02S02 = 100 * DayDeaUpRaA02S02 / DayCasUpRaA02S02
gen DayCfrMeRaA02S03 = 100 * DayDeaMeRaA02S03 / DayCasMeRaA02S03
gen DayCfrLoRaA02S03 = 100 * DayDeaLoRaA02S03 / DayCasLoRaA02S03
gen DayCfrUpRaA02S03 = 100 * DayDeaUpRaA02S03 / DayCasUpRaA02S03

label var DayCfrMeRaA02S01 "Daily CFR Mean Raw IHME S1" 
label var DayCfrLoRaA02S01 "Daily CFR Lower Raw IHME S1" 
label var DayCfrUpRaA02S01 "Daily CFR Upper Raw IHME S1" 
label var DayCfrMeRaA02S02 "Daily CFR Mean Raw IHME S2" 
label var DayCfrLoRaA02S02 "Daily CFR Lower Raw IHME S2" 
label var DayCfrUpRaA02S02 "Daily CFR Upper Raw IHME S2" 
label var DayCfrMeRaA02S03 "Daily CFR Mean Raw IHME S3" 
label var DayCfrLoRaA02S03 "Daily CFR Lower Raw IHME S3" 
label var DayCfrUpRaA02S03 "Daily CFR Upper Raw IHME S3" 



* graphs


grstyle init

grstyle color background white



* daily deaths, medain scenario = S1 	   
	   
	   
twoway (rarea DayDeaLoSmA02S01 DayDeaUpSmA02S01 date, sort color(black*.2)) ///
(line DayDeaMeSmA02S01 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 1 COVID-19 daily deaths, reference scenario, Iran, IHME.gph", replace
// graph export "graph 1 COVID-19 daily deaths, reference scenario, Iran, IHME.pdf", replace



* daily deaths, 3 scenarios  
  
  
twoway ///
(line DayDeaMeSmA02S01 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line DayDeaMeSmA02S02 date, sort lcolor(green)) ///
(line DayDeaMeSmA02S03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))


graph save "graph 2 COVID-19 daily deaths, Iran 3 scenarios, IHME.gph", replace
// graph export "graph 2 COVID-19 daily deaths, Iran 3 scenarios, IHME.pdf", replace




* daily cases, medain scenario = S1 	   
	   
	   
twoway (rarea DayCasLoRaA02S01 DayCasUpRaA02S01 date, sort color(black*.2)) ///
(line DayCasMeRaA02S01 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph 3 COVID-19 daily cases, reference scenario, Iran, IHME.gph", replace
// graph export "graph 3 COVID-19 daily cases, reference scenario, Iran, IHME.pdf", replace



* daily cases, 3 scenarios  
  
  
twoway ///
(line DayCasMeRaA02S01 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line DayCasMeRaA02S02 date, sort lcolor(green)) ///
(line DayCasMeRaA02S03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))


graph save "graph 4 COVID-19 daily cases, Iran 3 scenarios, IHME.gph", replace
// graph export "graph 4 COVID-19 daily cases, Iran 3 scenarios, IHME.pdf", replace




* daily cfr, 3 scenarios  
  
  
twoway ///
(line DayCfrMeRaA02S01 date, sort lcolor(black) lwidth(vthick) lpattern(tight_dot)) ///
(line DayCfrMeRaA02S02 date, sort lcolor(green)) ///
(line DayCfrMeRaA02S03 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "S1" 2 "S2" 3 "S3") rows(1))


graph save "graph 5 COVID-19 daily CFR, Iran 3 scenarios, IHME.gph", replace
// graph export "graph 5 COVID-19 daily CFR, Iran 3 scenarios, IHME.pdf", replace








*************************************

* Locate peak dates and values - deaths 


* S1 Reference



* first peak

summ DayDeaMeRaA02S01 if date > td(01mar2020) & date < td(30may2020) 

gen DayDeaMeRaA02S01P1V = r(max)

summ date if DayDeaMeRaA02S01 == DayDeaMeRaA02S01P1V & date > td(01mar2020) & date < td(30may2020)

gen DayDeaMeRaA02S01P1D = r(max)

summ DayDeaLoRaA02S01 if date == DayDeaMeRaA02S01P1D

gen DayDeaLoRaA02S01P1V = r(max)

summ DayDeaUpRaA02S01 if date == DayDeaMeRaA02S01P1D

gen DayDeaUpRaA02S01P1V = r(max)

label var DayDeaMeRaA02S01P1V "DayDeaMeRaA02S01P1V Peak 1 Value"
label var DayDeaMeRaA02S01P1D "DayDeaMeRaA02S01P1D Peak 1 Date"
label var DayDeaLoRaA02S01P1V "DayDeaLoRaA02S01P1V Peak 1 Value"
label var DayDeaUpRaA02S01P1V "DayDeaUpRaA02S01P1V Peak 1 Value"
format DayDeaMeRaA02S01P1D %tdDDMonCCYY


* second peak 

summ DayDeaMeRaA02S01 if date > td(01jul2020) & date < td(30jul2020) 

gen DayDeaMeRaA02S01P2V = r(max)

summ date if DayDeaMeRaA02S01 == DayDeaMeRaA02S01P2V & date > td(01jul2020) & date < td(30jul2020) 

gen DayDeaMeRaA02S01P2D = r(max)

summ DayDeaLoRaA02S01 if date == DayDeaMeRaA02S01P2D

gen DayDeaLoRaA02S01P2V = r(max)

summ DayDeaUpRaA02S01 if date == DayDeaMeRaA02S01P2D

gen DayDeaUpRaA02S01P2V = r(max)

label var DayDeaMeRaA02S01P2V "DayDeaMeRaA02S01P2V Peak 2 Value"
label var DayDeaMeRaA02S01P2D "DayDeaMeRaA02S01P2D Peak 2 Date"
label var DayDeaLoRaA02S01P2V "DayDeaLoRaA02S01P2V Peak 2 Value"
label var DayDeaUpRaA02S01P2V "DayDeaUpRaA02S01P2V Peak 2 Value"
format DayDeaMeRaA02S01P2D %tdDDMonCCYY


* third peak 

summ DayDeaMeRaA02S01 if date > td(01nov2020) & date < td(30nov2020) 

gen DayDeaMeRaA02S01P3V = r(max)

summ date if DayDeaMeRaA02S01 == DayDeaMeRaA02S01P3V & date > td(01nov2020) & date < td(30nov2020) 

gen DayDeaMeRaA02S01P3D = r(max)

summ DayDeaLoRaA02S01 if date == DayDeaMeRaA02S01P3D

gen DayDeaLoRaA02S01P3V = r(max)

summ DayDeaUpRaA02S01 if date == DayDeaMeRaA02S01P3D

gen DayDeaUpRaA02S01P3V = r(max)

label var DayDeaMeRaA02S01P3V "DayDeaMeRaA02S01P2V Peak 3 Value"
label var DayDeaMeRaA02S01P3D "DayDeaMeRaA02S01P3D Peak 3 Date"
label var DayDeaLoRaA02S01P3V "DayDeaLoRaA02S01P3V Peak 3 Value"
label var DayDeaUpRaA02S01P3V "DayDeaUpRaA02S01P3V Peak 3 Value"
format DayDeaMeRaA02S01P3D %tdDDMonCCYY


* fourth peak

summ DayDeaMeRaA02S01 if date > td(01feb2021) & date < td(30may2021) 

gen DayDeaMeRaA02S01P4V = r(max)

summ date if DayDeaMeRaA02S01 == DayDeaMeRaA02S01P4V & date > td(01feb2021) & date < td(30may2021) 

gen DayDeaMeRaA02S01P4D = r(max)

summ DayDeaLoRaA02S01 if date == DayDeaMeRaA02S01P4D

gen DayDeaLoRaA02S01P4V = r(max)

summ DayDeaUpRaA02S01 if date == DayDeaMeRaA02S01P4D

gen DayDeaUpRaA02S01P4V = r(max)

label var DayDeaMeRaA02S01P4V "DayDeaMeRaA02S01P4V Peak 4 Value"
label var DayDeaMeRaA02S01P4D "DayDeaMeRaA02S01P4D Peak 4 Date"
label var DayDeaLoRaA02S01P4V "DayDeaLoRaA02S01P4V Peak 4 Value"
label var DayDeaUpRaA02S01P4V "DayDeaUpRaA02S01P4V Peak 4 Value"
format DayDeaMeRaA02S01P4D %tdDDMonCCYY


* end date avialable 

summ date if DayDeaMeRaA02S01 != . 

gen A02DZ = r(max) 

summ DayDeaMeRaA02S01 if date == A02DZ

gen DayDeaMeRaA02S01PzV = r(max)

summ DayDeaLoRaA02S01 if date == A02DZ

gen DayDeaLoRaA02S01PzV = r(max)

summ DayDeaUpRaA02S01 if date == A02DZ

gen DayDeaUpRaA02S01PzV = r(max)

label var DayDeaMeRaA02S01PzV "DayDeaMeRaA02S01PzV End date Value"
label var DayDeaLoRaA02S01PzV "DayDeaLoRaA02S01PzV End date Value"
label var DayDeaUpRaA02S01PzV "DayDeaUpRaA02S01PzV End date Value"


* S2 Best

* the first three peaks show same values for S1 and S2 

* forth peak

summ DayDeaMeSmA02S02 if date > td(01feb2021) & date < td(30may2021) 

gen DayDeaMeSmA02S02P4V = r(max)

summ date if DayDeaMeSmA02S02 == DayDeaMeSmA02S02P4V & date > td(01feb2021) & date < td(30may2021) 

gen DayDeaMeSmA02S02P4D = r(max)

summ DayDeaLoSmA02S02 if date == DayDeaMeSmA02S02P4D

gen DayDeaLoSmA02S02P4V = r(max)

summ DayDeaUpSmA02S02 if date == DayDeaMeSmA02S02P4D

gen DayDeaUpSmA02S02P4V = r(max)

label var DayDeaMeSmA02S02P4V "DayDeaMeSmA02S02P4V Peak 4 Value"
label var DayDeaMeSmA02S02P4D "DayDeaMeSmA02S02P4D Peak 4 Date"
label var DayDeaLoSmA02S02P4V "DayDeaLoSmA02S02P4V Peak 4 Value"
label var DayDeaUpSmA02S02P4V "DayDeaUpSmA02S02P4V Peak 4 Value"
format DayDeaMeSmA02S02P4D %tdDDMonCCYY

* end date avialable 

summ DayDeaMeSmA02S02 if date == A02DZ

gen DayDeaMeSmA02S02PzV = r(max)

summ DayDeaLoSmA02S02 if date == A02DZ

gen DayDeaLoSmA02S02PzV = r(max)

summ DayDeaUpSmA02S02 if date == A02DZ

gen DayDeaUpSmA02S02PzV = r(max)

label var DayDeaMeSmA02S02PzV "DayDeaMeSmA02S02PzV End date Value"
label var DayDeaLoSmA02S02PzV "DayDeaLoSmA02S02PzV End date Value"
label var DayDeaUpSmA02S02PzV "DayDeaUpSmA02S02PzV End date Value"

* S3 Worse estiamtes are equal to S1 Reference 








*************************************

* Locate peak dates and values - cases 


* S1 Reference

* first peak

summ DayCasMeRaA02S01 if date > td(01mar2020) & date < td(30may2020) 

gen DayCasMeRaA02S01P1V = r(max)

summ date if DayCasMeRaA02S01 == DayCasMeRaA02S01P1V & date > td(01mar2020) & date < td(30may2020) 

gen DayCasMeRaA02S01P1D = r(max)

summ DayCasLoRaA02S01 if date == DayCasMeRaA02S01P1D

gen DayCasLoRaA02S01P1V = r(max)

summ DayCasUpRaA02S01 if date == DayCasMeRaA02S01P1D

gen DayCasUpRaA02S01P1V = r(max)

label var DayCasMeRaA02S01P1V "DayCasMeRaA02S01P1V Peak 1 Value"
label var DayCasMeRaA02S01P1D "DayCasMeRaA02S01P1D Peak 1 Date"
label var DayCasLoRaA02S01P1V "DayCasLoRaA02S01P1V Peak 1 Value"
label var DayCasUpRaA02S01P1V "DayCasUpRaA02S01P1V Peak 1 Value"
format DayCasMeRaA02S01P1D %tdDDMonCCYY

* second peak 

summ DayCasMeRaA02S01 if date > td(01jun2020) & date < td(30aug2020)

gen DayCasMeRaA02S01P2V = r(max)

summ date if DayCasMeRaA02S01 == DayCasMeRaA02S01P2V & date > td(01jun2020) & date < td(30aug2020) 

gen DayCasMeRaA02S01P2D = r(max)

summ DayCasLoRaA02S01 if date == DayCasMeRaA02S01P2D

gen DayCasLoRaA02S01P2V = r(max)

summ DayCasUpRaA02S01 if date == DayCasMeRaA02S01P2D

gen DayCasUpRaA02S01P2V = r(max)

label var DayCasMeRaA02S01P2V "DayCasMeRaA02S01P2V Peak 2 Value"
label var DayCasMeRaA02S01P2D "DayCasMeRaA02S01P2D Peak 2 Date"
label var DayCasLoRaA02S01P2V "DayCasLoRaA02S01P2V Peak 2 Value"
label var DayCasUpRaA02S01P2V "DayCasUpRaA02S01P2V Peak 2 Value"
format DayCasMeRaA02S01P2D %tdDDMonCCYY

* third peak 

summ DayCasMeRaA02S01 if date > td(01oct2020) & date < td(30nov2020) 

gen DayCasMeRaA02S01P3V = r(max)

summ date if DayCasMeRaA02S01 == DayCasMeRaA02S01P3V & date > td(01oct2020) & date < td(30nov2020) 

gen DayCasMeRaA02S01P3D = r(max)

summ DayCasLoRaA02S01 if date == DayCasMeRaA02S01P3D 

gen DayCasLoRaA02S01P3V = r(max)

summ DayCasUpRaA02S01 if date == DayCasMeRaA02S01P3D

gen DayCasUpRaA02S01P3V = r(max)

label var DayCasMeRaA02S01P3V "DayCasMeRaA02S01P3V Peak 3 Value"
label var DayCasMeRaA02S01P3D "DayCasMeRaA02S01P3D Peak 3 Date"
label var DayCasLoRaA02S01P3V "DayCasLoRaA02S01P3V Peak 3 Value"
label var DayCasUpRaA02S01P3V "DayCasUpRaA02S01P3V Peak 3 Value"
format DayCasMeRaA02S01P3D %tdDDMonCCYY

* forth peak

summ DayCasMeRaA02S01 if date > td(01feb2021) & date < td(30may2021) 

gen DayCasMeRaA02S01P4V = r(max)

summ date if DayCasMeRaA02S01 == DayCasMeRaA02S01P4V & date > td(01feb2021) & date < td(30may2021) 

gen DayCasMeRaA02S01P4D = r(max)

summ DayCasLoRaA02S01 if date == DayCasMeRaA02S01P4D

gen DayCasLoRaA02S01P4V = r(max)

summ DayCasUpRaA02S01 if date == DayCasMeRaA02S01P4D

gen DayCasUpRaA02S01P4V = r(max)

label var DayCasMeRaA02S01P4V "DayCasMeRaA02S01P4V Peak 4 Value"
label var DayCasMeRaA02S01P4D "DayCasMeRaA02S01P4D Peak 4 Date"
label var DayCasLoRaA02S01P4V "DayCasLoRaA02S01P4V Peak 4 Value"
label var DayCasUpRaA02S01P4V "DayCasUpRaA02S01P4V Peak 4 Value"
format DayCasMeRaA02S01P4D %tdDDMonCCYY

* end date avialable 

summ DayCasMeRaA02S01 if date == A02DZ

gen DayCasMeRaA02S01PzV = r(max)

summ DayCasLoRaA02S01 if date == A02DZ

gen DayCasLoRaA02S01PzV = r(max)

summ DayCasUpRaA02S01 if date == A02DZ

gen DayCasUpRaA02S01PzV = r(max)

label var A02DZ "A02 End date"
label var DayCasMeRaA02S01PzV "DayCasMeRaA02S01PzV End date Value"
label var DayCasLoRaA02S01PzV "DayCasLoRaA02S01PzV End date Value"
label var DayCasUpRaA02S01PzV "DayCasUpRaA02S01PzV End date Value"
format A02DZ %tdDDMonCCYY


* S2 Best


* forth peak

line DayCasMeRaA02S02 date 

summ DayCasMeRaA02S02 if date > td(01feb2021) & date < td(30may2021) & DayCasMeRaA02S02 != . 

gen DayCasMeRaA02S02P4V = r(max)

summ date if DayCasMeRaA02S02 == DayCasMeRaA02S02P4V & date > td(01feb2021) & date < td(30may2021) 

gen DayCasMeRaA02S02P4D = r(max)

summ DayCasLoRaA02S02 if date == DayCasMeRaA02S02P4D

gen DayCasLoRaA02S02P4V = r(max)

summ DayCasUpRaA02S02 if date == DayCasMeRaA02S02P4D

gen DayCasUpRaA02S02P4V = r(max)

label var DayCasMeRaA02S02P4V "DayCasMeRaA02S01P4V Peak 4 Value"
label var DayCasMeRaA02S02P4D "DayCasMeRaA02S01P4D Peak 4 Date"
label var DayCasLoRaA02S02P4V "DayCasLoRaA02S01P4V Peak 4 Value"
label var DayCasUpRaA02S02P4V "DayCasUpRaA02S01P4V Peak 4 Value"
format DayCasMeRaA02S02P4D %tdDDMonCCYY

* end date avialable 

summ DayCasMeRaA02S02 if date == A02DZ

gen DayCasMeRaA02S02PzV = r(max)

summ DayCasLoRaA02S02 if date == A02DZ

gen DayCasLoRaA02S02PzV = r(max)

summ DayCasUpRaA02S02 if date == A02DZ

gen DayCasUpRaA02S02PzV = r(max)

label var DayCasMeRaA02S02PzV "DayCasMeRaA02S02PzV End date Value"
label var DayCasLoRaA02S02PzV "DayCasLoRaA02S02PzV End date Value"
label var DayCasUpRaA02S02PzV "DayCasUpRaA02S02PzV End date Value"

* S3 Worse estiamtes are equal to S1 Reference 







********************

* tab the peaks

* Value (height) and Date for P1, P2, and P3, in S2 and S3 are the same as those in S1



* Daily deaths

* S1 Reference

* S1 Reference Peak 1

tab1 DayDeaMeRaA02S01P1D DayDeaMeRaA02S01P1V DayDeaLoRaA02S01P1V DayDeaUpRaA02S01P1V

* S1 Reference Peak 2

tab1 DayDeaMeRaA02S01P2D DayDeaMeRaA02S01P2V DayDeaLoRaA02S01P2V DayDeaUpRaA02S01P2V

* S1 Reference Peak 3

tab1 DayDeaMeRaA02S01P3D DayDeaMeRaA02S01P3V DayDeaLoRaA02S01P3V DayDeaUpRaA02S01P3V 

* S1 Reference Peak 4

tab1 DayDeaMeRaA02S01P4D DayDeaMeRaA02S01P4V DayDeaLoRaA02S01P4V DayDeaUpRaA02S01P4V

* S1 Reference End date

tab1 A02DZ DayDeaMeRaA02S01PzV DayDeaLoRaA02S01PzV DayDeaUpRaA02S01PzV

* S2 Best

* S2 Best Peak 4

tab1 DayDeaMeSmA02S02P4D DayDeaMeSmA02S02P4V DayDeaLoSmA02S02P4V DayDeaUpSmA02S02P4V

* S2 Best End date

tab1 DayDeaMeSmA02S02PzV DayDeaLoSmA02S02PzV DayDeaUpSmA02S02PzV




* Daily cases

* S1 Reference

* S1 Reference Peak 1

tab1 DayCasMeRaA02S01P1D DayCasMeRaA02S01P1V DayCasLoRaA02S01P1V 

* S1 Reference Peak 2 

tab1 DayCasMeRaA02S01P2D DayCasMeRaA02S01P2V DayCasLoRaA02S01P2V DayCasUpRaA02S01P2V

* S1 Reference Pake 3

tab1 DayCasMeRaA02S01P3D DayCasMeRaA02S01P3V DayCasLoRaA02S01P3V DayCasUpRaA02S01P3V

* S1 Reference Peak 4 

tab1 DayCasMeRaA02S01P4D DayCasMeRaA02S01P4V DayCasLoRaA02S01P4V DayCasUpRaA02S01P4V

* S1 Reference End date

tab1 DayCasMeRaA02S01PzV DayCasLoRaA02S01PzV DayCasUpRaA02S01PzV

* S2 Best

* S2 Best Peak 4

tab1 DayCasMeRaA02S02P4D DayCasMeRaA02S02P4V DayCasLoRaA02S02P4V DayCasUpRaA02S02P4V

* S2 Best End date

tab1 DayCasMeRaA02S02PzV DayCasLoRaA02S02PzV DayCasUpRaA02S02PzV



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



