

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


import delimited using "$pathcovir2/IHME/2021_02_25/reference_hospitalization_all_locs.csv", clear varnames(1)
save "$pathcovir2/IHME/Reference_hospitalization_all_locs.dta", replace
	
import delimited using "$pathcovir2/IHME/2021_02_25/best_masks_hospitalization_all_locs.csv", clear varnames(1)
save "$pathcovir2/IHME/Best_masks_hospitalization_all_locs.dta", replace
		
import delimited using "$pathcovir2/IHME/2021_02_25/worse_hospitalization_all_locs.csv", clear varnames(1)
save "$pathcovir2/IHME/Worse_hospitalization_all_locs.dta", replace

	
	
/* Note on scenario changes in IHME COVID-19 model updates:

Since December 2020, IHME COVID-19 model has had three versions of their set of scenarios. 
The very first version had 3 scenarios, a next version had 6 scenarios and included vaccines, 
another version modified vaccine scenarios and added new variants, 
and as of update 2021 02 25, scenarios are back to the very first version with 3 scenarios. 
The following code works for update 2021 02 25.
*/



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



save "Iran IHME.dta", replace




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
	   
graph save "graph COVID-19 daily deaths, reference scenario, Iran, IHME.gph", replace
graph export "graph COVID-19 daily deaths, reference scenario, Iran, IHME.pdf", replace



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


graph save "graph COVID-19 daily deaths, Iran 3 scenarios, IHME.gph", replace
graph export "graph COVID-19 daily deaths, Iran 3 scenarios, IHME.pdf", replace




* daily cases, medain scenario = S1 	   
	   
	   
twoway (rarea DayCasLoRaA02S01 DayCasUpRaA02S01 date, sort color(black*.2)) ///
(line DayCasMeRaA02S01 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#17, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, IHME, reference scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off)	
	   
graph save "graph COVID-19 daily cases, reference scenario, Iran, IHME.gph", replace
graph export "graph COVID-19 daily cases, reference scenario, Iran, IHME.pdf", replace



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


graph save "graph COVID-19 daily cases, Iran 3 scenarios, IHME.gph", replace
graph export "graph COVID-19 daily cases, Iran 3 scenarios, IHME.pdf", replace





*************************************

* Locate peak dates and values - deaths 


* S1 Reference

* first peak

summ DayDeaMeRaA02S01 if date > td(01mar2020) & date < td(30may2020) // 158 = 158 

list date if DayDeaMeRaA02S01 > 157.9 & date > td(01mar2020) & date < td(30may2020) // 04Apr2020 

list DayDeaLoRaA02S01 if date == td(04Apr2020) // 158 
list DayDeaUpRaA02S01 if date == td(04Apr2020) // 158

* second peak 

summ DayDeaMeRaA02S01 if date > td(01jul2020) & date < td(30jul2020) // 235

list date if DayDeaMeRaA02S01 > 234.9 & date > td(01jul2020) & date < td(30jul2020) // 28Jul2020 

list DayDeaLoRaA02S01 if date == td(28Jul2020) // 235 
list DayDeaUpRaA02S01 if date == td(28Jul2020) // 235

* third peak 

summ DayDeaMeRaA02S01 if date > td(01nov2020) & date < td(30nov2020) // 486

list date if DayDeaMeRaA02S01 > 485.9 & date > td(01nov2020) & date < td(30nov2020) // 16Nov2020 

list DayDeaLoRaA02S01 if date == td(16Nov2020) // 486 
list DayDeaUpRaA02S01 if date == td(16Nov2020) // 486


* forth peak

summ DayDeaMeRaA02S01 if date > td(01mar2021) & date < td(01may2021) // 106.8422 = 107

list date if DayDeaMeRaA02S01 > 106.8421 & date > td(01mar2021) & date < td(01may2021) // 30Mar2021 

list DayDeaLoRaA02S01 if date == td(30Mar2021) // 56 
list DayDeaUpRaA02S01 if date == td(30Mar2021) // 190


* end date avialable 

list DayDeaMeRaA02S01 if date == td(01Jun2021) // 49
list DayDeaLoRaA02S01 if date == td(01Jun2021) // 28
list DayDeaUpRaA02S01 if date == td(01Jun2021) // 82



* S2 Best


* forth peak

summ DayDeaMeSmA02S02 if date > td(01mar2021) & date < td(01may2021) // 103.7995 = 104

list date if DayDeaMeSmA02S02 > 103.79 & date > td(01mar2021) & date < td(01may2021) // 19Mar2021 

list DayDeaLoSmA02S02 if date == td(19Mar2021) // 57 
list DayDeaUpSmA02S02 if date == td(19Mar2021) // 173


* end date avialable 

list DayDeaMeSmA02S02 if date == td(01Jun2021) // 10
list DayDeaLoSmA02S02 if date == td(01Jun2021) // 4
list DayDeaUpSmA02S02 if date == td(01Jun2021) // 19


* S3 Worse estiamtes are equal to S1 Reference 


*************************************

* Locate peak dates and values - cases 


* S1 Reference

* first peak

summ DayCasMeRaA02S01 if date > td(01mar2020) & date < td(30may2020) // 28344.6 = 28345 

list date if DayCasMeRaA02S01 > 28344 & date > td(01mar2020) & date < td(30may2020) // 12Mar2020 

list DayCasLoRaA02S01 if date == td(12Mar2020) // 21472 
list DayCasUpRaA02S01 if date == td(12Mar2020) // 35030

* second peak 

summ DayCasMeRaA02S01 if date > td(01jun2020) & date < td(30aug2020) // 34377.84 = 34378

list date if DayCasMeRaA02S01 > 34377 & date > td(01jun2020) & date < td(30aug2020) // 27Jun2020 

list DayCasLoRaA02S01 if date == td(27Jun2020) // 27927 
list DayCasUpRaA02S01 if date == td(27Jun2020) // 41859

* third peak 

summ DayCasMeRaA02S01 if date > td(01oct2020) & date < td(30nov2020) // 87911.03 = 87911

list date if DayCasMeRaA02S01 > 87911 & date > td(01oct2020) & date < td(30nov2020) // 30Oct2020 

list DayCasLoRaA02S01 if date == td(30Oct2020) // 73532 
list DayCasUpRaA02S01 if date == td(30Oct2020) // 106902


* forth peak

summ DayCasMeRaA02S01 if date > td(01feb2021) & date < td(01apr2021) // 33734.67 = 33735

list date if DayCasMeRaA02S01 >33734 & date > td(01feb2021) & date < td(01apr2021) // 06Mar2021 

list DayCasLoRaA02S01 if date == td(06Mar2021) // 18761 
list DayCasUpRaA02S01 if date == td(06Mar2021) // 61096


* end date avialable 

list DayCasMeRaA02S01 if date == td(01Jun2021) // 8744
list DayCasLoRaA02S01 if date == td(01Jun2021) // 4550
list DayCasUpRaA02S01 if date == td(01Jun2021) // 14555



* S2 Best


* forth peak

line DayCasMeRaA02S02 date 

summ DayCasMeRaA02S02 if date > td(01feb2021) & date < td(30apr2021) & date != . // 32884.37 = 32884

list date DayCasMeRaA02S02 if DayCasMeRaA02S02 > 32884 & date > td(01feb2021) & date < td(30apr2021) & DayCasMeRaA02S02 != . // 23Feb2021

list DayCasLoRaA02S02 if date == td(23Feb2021) // 19059 
list DayCasUpRaA02S02 if date == td(23Feb2021) // 56087


* end date avialable 

list DayCasMeRaA02S02 if date == td(01Jun2021) // 1401
list DayCasLoRaA02S02 if date == td(01Jun2021) // 313
list DayCasUpRaA02S02 if date == td(01Jun2021) // 3030


* S3 Worse estiamtes are equal to S1 Reference 




view "log Iran IHME.smcl"

log close

exit, clear




