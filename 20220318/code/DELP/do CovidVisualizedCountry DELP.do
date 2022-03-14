
clear all

cd "$pathCovidVisualizedCountry"

cd DELP

capture log close 

log using "log CovidVisualizedCountry DELP.smcl", replace

***************************************************************************
* This is "do CovidVisualizedCountry DELP.do"

* Project: Combine and visualize international periodically updating 
* estimates of COVID-19 at the country level (CovidVisualizedCountry)
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dotcom
* Time (initial): 2021-04-14
***************************************************************************




clear

copy https://raw.githubusercontent.com/COVIDAnalytics/website/master/data/predicted/Global_V4_since100_$DELPdate.csv Global_V4_since100_$DELPdate.csv

import delimited using "Global_V4_since100_$DELPdate.csv", clear varnames(1)

rename country loc_grand_name

keep if loc_grand_name == "$country"

drop continent

rename province provincestate

replace provincestate = " National" if provincestate == "None"



* gen date

rename day date_original

gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date

drop year month day date2


* rename outcome variables


* total vars

rename totaldetecteddeaths   TotDeaMeRaA01S00
rename totaldetecteddeathslb TotDeaLoRaA01S00
rename totaldetecteddeathsub TotDeaUpRaA01S00

label var TotDeaMeRaA01S00 "Total Deaths Mean DELP S0"
label var TotDeaMeRaA01S00 "Total Deaths Lower DELP S0"
label var TotDeaMeRaA01S00 "Total Deaths Upper DELP S0"

rename totaldetected   TotCasMeRaA01S00
rename totaldetectedlb TotCasLoRaA01S00
rename totaldetectedub TotCasUpRaA01S00

label var TotCasMeRaA01S00 "Total Cases Mean DELP S0"
label var TotCasMeRaA01S00 "Total Cases Lower DELP S0"
label var TotCasMeRaA01S00 "Total Cases Upper DELP S0"


* gen daily vars and rename

sort provincestate date

bysort provincestate (date): gen DayDeaMeRaA01S00 =  TotDeaMeRaA01S00[_n] - TotDeaMeRaA01S00[_n-1]

bysort provincestate (date): gen DayDeaLoRaA01S00 =  TotDeaLoRaA01S00[_n] - TotDeaLoRaA01S00[_n-1]

bysort provincestate (date): gen DayDeaUpRaA01S00 =  TotDeaUpRaA01S00[_n] - TotDeaUpRaA01S00[_n-1]

bysort provincestate (date): gen DayCasMeRaA01S00 =  TotCasMeRaA01S00[_n] - TotCasMeRaA01S00[_n-1]

bysort provincestate (date): gen DayCasLoRaA01S00 =  TotCasLoRaA01S00[_n] - TotCasLoRaA01S00[_n-1]

bysort provincestate (date): gen DayCasUpRaA01S00 =  TotCasUpRaA01S00[_n] - TotCasUpRaA01S00[_n-1]


label var DayDeaMeRaA01S00 "Daily Deaths Mean DELP S0"
label var DayDeaLoRaA01S00 "Daily Deaths Lower DELP S0"
label var DayDeaUpRaA01S00 "Daily Deaths Upper DELP S0"

label var DayCasMeRaA01S00 "Daily Cases Mean DELP S0"
label var DayCasLoRaA01S00 "Daily Cases Lower DELP S0"
label var DayCasUpRaA01S00 "Daily Cases Upper DELP S0"

label var TotDeaMeRaA01S00 "Total Deaths Mean DELP S0"
label var TotDeaLoRaA01S00 "Total Deaths Lower DELP S0"
label var TotDeaUpRaA01S00 "Total Deaths Upper DELP S0"

label var TotCasMeRaA01S00 "Total Cases Mean DELP S0"
label var TotCasLoRaA01S00 "Total Cases Lower DELP S0"
label var TotCasUpRaA01S00 "Total Cases Upper DELP S0"


* 

* other outcomes

* active activehospitalized activeventilated cumulativehospitalized

/*
***********************
* rename convention

active					Act

activehospitalized		Hos

activeventilated 		Ven

cumulativehospitalized 	Hos

*/


rename active DayActMeRaA01S00

rename activehospitalized DayHosMeRaA01S00

rename activeventilated DayVenMeRaA01S00

rename cumulativehospitalized TotHosMeRaA01S00

label var DayActMeRaA01S00 "Daily Cases Active Mean DELP S0"

label var DayHosMeRaA01S00 "Daily Cases Active Hospitalized Mean DELP S0"

label var DayVenMeRaA01S00 "Daily Cases Active Ventilated Mean DELP S0"

label var TotHosMeRaA01S00 "Total Cases Active Mean DELP S0"

 

keep ///
loc_grand_name provincestate date ///
TotDeaMeRaA01S00 TotDeaLoRaA01S00 TotDeaUpRaA01S00 ///
DayDeaMeRaA01S00 DayDeaLoRaA01S00 DayDeaUpRaA01S00 ///
TotCasMeRaA01S00 TotCasLoRaA01S00 TotCasUpRaA01S00 ///
DayCasMeRaA01S00 DayCasLoRaA01S00 DayCasUpRaA01S00 ///
DayActMeRaA01S00 DayHosMeRaA01S00 DayVenMeRaA01S00 TotHosMeRaA01S00


order ///
loc_grand_name provincestate date ///
TotDeaMeRaA01S00 TotDeaLoRaA01S00 TotDeaUpRaA01S00 ///
DayDeaMeRaA01S00 DayDeaLoRaA01S00 DayDeaUpRaA01S00 ///
TotCasMeRaA01S00 TotCasLoRaA01S00 TotCasUpRaA01S00 ///
DayCasMeRaA01S00 DayCasLoRaA01S00 DayCasUpRaA01S00 ///
DayActMeRaA01S00 DayHosMeRaA01S00 DayVenMeRaA01S00 TotHosMeRaA01S00



* gen cfr

gen DayCfrMeRaA01S00 = 100 * DayDeaMeRaA01S00 / DayCasMeRaA01S00
gen DayCfrLoRaA01S00 = 100 * DayDeaLoRaA01S00 / DayCasLoRaA01S00
gen DayCfrUpRaA01S00 = 100 * DayDeaUpRaA01S00 / DayCasUpRaA01S00

label var DayCfrMeRaA01S00 "Daily CFR Mean DELP S0"
label var DayCfrLoRaA01S00 "Daily CFR Lower DELP S0"
label var DayCfrUpRaA01S00 "Daily CFR Upper DELP S0"

*

* smooth daily deaths and daily cases

encode provincestate, gen(provincestate_encoded)

tsset provincestate_encoded date, daily   


tssmooth ma DayDeaMeRaA01S00_window = DayDeaMeRaA01S00 if DayDeaMeRaA01S00 >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmA01S00 = DayDeaMeRaA01S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA01S00 "Daily deaths mean smooth DELP"


tssmooth ma DayDeaLoRaA01S00_window = DayDeaLoRaA01S00 if DayDeaLoRaA01S00 >= 0, window(3 1 3)

tssmooth ma DayDeaLoSmA01S00 = DayDeaLoRaA01S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaLoSmA01S00 "Daily deaths lower smooth DELP"


tssmooth ma DayDeaUpRaA01S00_window = DayDeaUpRaA01S00 if DayDeaUpRaA01S00 >= 0, window(3 1 3)

tssmooth ma DayDeaUpSmA01S00 = DayDeaUpRaA01S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaUpSmA01S00 "Daily deaths upper smooth DELP"



tssmooth ma DayCasMeRaA01S00_window = DayCasMeRaA01S00 if DayCasMeRaA01S00 >= 0, window(3 1 3)

tssmooth ma DayCasMeSmA01S00 = DayCasMeRaA01S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasMeSmA01S00 "Daily cases mean smooth DELP"


tssmooth ma DayCasLoRaA01S00_window = DayCasLoRaA01S00 if DayCasLoRaA01S00 >= 0, window(3 1 3)

tssmooth ma DayCasLoSmA01S00 = DayCasLoRaA01S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasLoSmA01S00 "Daily cases lower smooth DELP"


tssmooth ma DayCasUpRaA01S00_window = DayCasUpRaA01S00 if DayCasUpRaA01S00 >= 0, window(3 1 3)

tssmooth ma DayCasUpSmA01S00 = DayCasUpRaA01S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasUpSmA01S00 "Daily cases upper smooth DELP"


drop *_window

drop provincestate_encoded

tsset, clear





* gen "Daily cases mean div by daily deaths mean DELP DayCbD" for visulization of temporal relation of deaths and cases peaks 


summ DayDeaMeRaA01S00 
gen DayDeMMeRaA01S00 = r(mean)
label var DayDeMMeRaA01S00 "Daily deaths mean DELP DayDeM"

summ DayCasMeRaA01S00 
gen DayCaMMeRaA01S00 = r(mean)
label var DayCaMMeRaA01S00 "Daily cases mean DELP DayCaM"
                              
gen DayCbDMeRaA01S00 = DayCaMMeRaA01S00 / DayDeaMeRaA01S00
label var DayCbDMeRaA01S00 "Daily cases mean div by daily deaths mean DELP DayCbD"
summ DayCbDMeRaA01S00
	
gen DayDMuMeRaA01S00 = DayDeaMeRaA01S00 * DayCbDMeRaA01S00
label var DayDMuMeRaA01S00 "Daily deaths scaled (times means of cases by deaths) only for visualization DELP"
summ DayDMuMeRaA01S00	






* gen vars by provincestate 

foreach var of varlist ///
DayDeaMeRaA01S00 DayDeaLoRaA01S00 DayDeaUpRaA01S00 DayCasMeRaA01S00 DayCasLoRaA01S00 DayCasUpRaA01S00 /// 
TotDeaMeRaA01S00 TotDeaLoRaA01S00 TotDeaUpRaA01S00 TotCasMeRaA01S00 TotCasLoRaA01S00 TotCasUpRaA01S00 ///
DayActMeRaA01S00 DayHosMeRaA01S00 DayVenMeRaA01S00 TotHosMeRaA01S00 ///
DayCfrMeRaA01S00 DayCfrLoRaA01S00 DayCfrUpRaA01S00 ///
DayDeMMeRaA01S00 DayCaMMeRaA01S00 DayCbDMeRaA01S00 DayDMuMeRaA01S00 {

*
			 
qui gen `var'XAB = `var' 
qui replace `var'XAB = . if provincestate != "Alberta"

qui gen `var'XBC = `var'
qui replace `var'XBC = . if provincestate != "British Columbia"

qui gen `var'XMB = `var'
qui replace `var'XMB = . if provincestate != "Manitoba"

qui gen `var'XXX = `var'
qui replace `var'XXX = . if provincestate != " National"

qui gen `var'XNB = `var'
qui replace `var'XNB = . if provincestate != "New Brunswick"

qui gen `var'XNL = `var'
qui replace `var'XNL = . if provincestate != "Newfoundland and Labrador"

qui gen `var'XNS = `var'
qui replace `var'XNS = . if provincestate != "Nova Scotia"

qui gen `var'XON = `var'
qui replace `var'XON = . if provincestate != "Ontario"

qui gen `var'XQC = `var'
qui replace `var'XQC = . if provincestate != "Quebec"

qui gen `var'XSK = `var'
qui replace `var'XSK = . if provincestate != "Saskatchewan"


label var `var'XAB "`var' Alberta"
label var `var'XBC "`var' British Columbia"
label var `var'XMB "`var' Manitoba"
label var `var'XXX "`var' National"
label var `var'XNB "`var' New Brunswick"
label var `var'XNL "`var' Newfoundland and Labrador"
label var `var'XNS "`var' Nova Scotia"
label var `var'XON "`var' Ontario"
label var `var'XQC "`var' Quebec"
label var `var'XSK "`var' Saskatchewan"


                
}
*




* smooth daily deaths and daily cases

encode provincestate, gen(provincestate_encoded)

tsset provincestate_encoded date, daily   


	foreach var of varlist ///
	DayDeaMeRaA01S00XAB-DayCasMeRaA01S00XSK {


qui tssmooth ma `var'_window = `var' if `var' >= 0, window(3 1 3)

qui tssmooth ma `var'_sm = `var'_window, weights( 1 2 3 <4> 3 2 1) replace


	}
*

drop *_window

drop provincestate_encoded

tsset, clear


rename ///
(DayDeaMeRaA01S00XAB_sm	DayDeaMeRaA01S00XBC_sm	DayDeaMeRaA01S00XMB_sm	DayDeaMeRaA01S00XXX_sm	DayDeaMeRaA01S00XNB_sm	DayDeaMeRaA01S00XNL_sm	DayDeaMeRaA01S00XNS_sm	DayDeaMeRaA01S00XON_sm	DayDeaMeRaA01S00XQC_sm	DayDeaMeRaA01S00XSK_sm	DayCasMeRaA01S00XAB_sm	DayCasMeRaA01S00XBC_sm	DayCasMeRaA01S00XMB_sm	DayCasMeRaA01S00XXX_sm	DayCasMeRaA01S00XNB_sm	DayCasMeRaA01S00XNL_sm	DayCasMeRaA01S00XNS_sm	DayCasMeRaA01S00XON_sm	DayCasMeRaA01S00XQC_sm	DayCasMeRaA01S00XSK_sm) ///
(DayDeaMeSmA01S00XAB   	DayDeaMeSmA01S00XBC   	DayDeaMeSmA01S00XMB   	DayDeaMeSmA01S00XXX   	DayDeaMeSmA01S00XNB   	DayDeaMeSmA01S00XNL   	DayDeaMeSmA01S00XNS   	DayDeaMeSmA01S00XON   	DayDeaMeSmA01S00XQC   	DayDeaMeSmA01S00XSK   	DayCasMeSmA01S00XAB   	DayCasMeSmA01S00XBC   	DayCasMeSmA01S00XMB   	DayCasMeSmA01S00XXX   	DayCasMeSmA01S00XNB   	DayCasMeSmA01S00XNL   	DayCasMeSmA01S00XNS   	DayCasMeSmA01S00XON   	DayCasMeSmA01S00XQC   	DayCasMeSmA01S00XSK   )


labvars DayDeaMeSmA01S00XAB-DayCasMeSmA01S00XSK ,names
	   
*

sort loc_grand_name provincestate date

order loc_grand_name provincestate date

qui compress

save "CovidVisualizedCountry DELP.dta", replace






view "log CovidVisualizedCountry DELP.smcl"

log close

exit, clear




