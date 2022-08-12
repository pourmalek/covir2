
clear all
 
cd "$pathcovir2"

cd DELP

capture log close 

log using "log country DELP.smcl", replace

******************************************************************************
* This is "do country DELP.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek
******************************************************************************



di "DELPdate = " "$DELPdate"

* latest update used in this uptake
* input data files: csv files on web site
* output data files: "country DELP.dta"

* Get DELPHI data for country


capture shell rm -r "Global_V4_since100_$DELPdate.csv"


clear

copy https://raw.githubusercontent.com/COVIDAnalytics/website/master/data/predicted/Global_V4_since100_$DELPdate.csv Global_V4_since100_$DELPdate.csv

import delimited using "Global_V4_since100_$DELPdate.csv", clear varnames(1)

rename country loc_grand_name

keep if regexm(loc_grand_name,"$country") == 1


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

sort date

gen DayDeaMeRaA01S00 =  TotDeaMeRaA01S00[_n] - TotDeaMeRaA01S00[_n-1]

gen DayDeaLoRaA01S00 =  TotDeaLoRaA01S00[_n] - TotDeaLoRaA01S00[_n-1]

gen DayDeaUpRaA01S00 =  TotDeaUpRaA01S00[_n] - TotDeaUpRaA01S00[_n-1]

gen DayCasMeRaA01S00 =  TotCasMeRaA01S00[_n] - TotCasMeRaA01S00[_n-1]

gen DayCasLoRaA01S00 =  TotCasLoRaA01S00[_n] - TotCasLoRaA01S00[_n-1]

gen DayCasUpRaA01S00 =  TotCasUpRaA01S00[_n] - TotCasUpRaA01S00[_n-1]


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



rename active DayActMeRaA01S00

rename activehospitalized DayHosMeRaA01S00

rename activeventilated DayVenMeRaA01S00

rename cumulativehospitalized TotHosMeRaA01S00

label var DayActMeRaA01S00 "Daily Cases Active Mean DELP S0"

label var DayHosMeRaA01S00 "Daily Cases Active Hospitalized Mean DELP S0"

label var DayVenMeRaA01S00 "Daily Cases Active Ventilated Mean DELP S0"

label var TotHosMeRaA01S00 "Total Cases Active Mean DELP S0"

 

keep ///
loc_grand_name date ///
TotDeaMeRaA01S00 TotDeaLoRaA01S00 TotDeaUpRaA01S00 ///
DayDeaMeRaA01S00 DayDeaLoRaA01S00 DayDeaUpRaA01S00 ///
TotCasMeRaA01S00 TotCasLoRaA01S00 TotCasUpRaA01S00 ///
DayCasMeRaA01S00 DayCasLoRaA01S00 DayCasUpRaA01S00 ///
DayActMeRaA01S00 DayHosMeRaA01S00 DayVenMeRaA01S00 TotHosMeRaA01S00


order ///
loc_grand_name date ///
TotDeaMeRaA01S00 TotDeaLoRaA01S00 TotDeaUpRaA01S00 ///
DayDeaMeRaA01S00 DayDeaLoRaA01S00 DayDeaUpRaA01S00 ///
TotCasMeRaA01S00 TotCasLoRaA01S00 TotCasUpRaA01S00 ///
DayCasMeRaA01S00 DayCasLoRaA01S00 DayCasUpRaA01S00 ///
DayActMeRaA01S00 DayHosMeRaA01S00 DayVenMeRaA01S00 TotHosMeRaA01S00



* gen cfr

gen DayCfrMeRaA01S00 = 100 * DayDeaMeRaA01S00 / DayCasMeRaA01S00
gen DayCfrLoRaA01S00 = 100 * DayDeaLoRaA01S00 / DayCasLoRaA01S00
gen DayCfrUpRaA01S00 = 100 * DayDeaUpRaA01S00 / DayCasUpRaA01S00

label var DayCfrMeRaA01S00 "Daily CFR Mean DELP S0 V4"
label var DayCfrLoRaA01S00 "Daily CFR Lower DELP S0 V4"
label var DayCfrUpRaA01S00 "Daily CFR Upper DELP S0 V4"




*





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






* smooth 

tsset date, daily   


tssmooth ma DayDeaMeRaA01S00_window = DayDeaMeRaA01S00 if DayDeaMeRaA01S00 >= 0, window(3 1 3) 

tssmooth ma DayDeaMeSmA01S00 = DayDeaMeRaA01S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA01S00 "Daily deaths smooth mean DELP"

drop DayDeaMeRaA01S00_window


tssmooth ma DayCasMeRaA01S00_window = DayCasMeRaA01S00 if DayCasMeRaA01S00 >= 0, window(3 1 3)

tssmooth ma DayCasMeSmA01S00 = DayCasMeRaA01S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasMeSmA01S00 "Daily cases smooth mean DELP"

drop DayCasMeRaA01S00_window



tssmooth ma DayDeaLoRaA01S00_window = DayDeaLoRaA01S00 if DayDeaLoRaA01S00 >= 0, window(3 1 3) 

tssmooth ma DayDeaLoSmA01S00 = DayDeaLoRaA01S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaLoSmA01S00 "Daily deaths smooth lower DELP"

drop DayDeaLoRaA01S00_window


tssmooth ma DayCasLoRaA01S00_window = DayCasLoRaA01S00 if DayCasLoRaA01S00 >= 0, window(3 1 3)

tssmooth ma DayCasLoSmA01S00 = DayCasLoRaA01S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasLoSmA01S00 "Daily cases smooth lower DELP"

drop DayCasLoRaA01S00_window



tssmooth ma DayDeaUpRaA01S00_window = DayDeaUpRaA01S00 if DayDeaUpRaA01S00 >= 0, window(3 1 3) 

tssmooth ma DayDeaUpSmA01S00 = DayDeaUpRaA01S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaUpSmA01S00 "Daily deaths smooth upper DELP"

drop DayDeaUpRaA01S00_window


tssmooth ma DayCasUpRaA01S00_window = DayCasUpRaA01S00 if DayCasUpRaA01S00 >= 0, window(3 1 3)

tssmooth ma DayCasUpSmA01S00 = DayCasUpRaA01S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasUpSmA01S00 "Daily cases smooth upper DELP"

drop DayCasUpRaA01S00_window




* Forecast start date 

gen epoch_DELP = td($DELPepoch) // update release date
label var epoch_DELP "DELP Forecast start date"

gen DayDeaFOREA01S00 = DayDeaMeSmA01S00
replace DayDeaFOREA01S00 = . if date < td($DELPepoch)
label var DayDeaFOREA01S00 "Daily Forecasted Deaths Mean smooth DELP"

gen DayCasFOREA01S00 = DayCasMeSmA01S00
replace DayCasFOREA01S00 = . if date < td($DELPepoch)
label var DayCasFOREA01S00 "Daily Forecasted Cases Mean smooth DELP"


sort date loc_grand_name


qui compress

save "country DELP.dta", replace





view "log country DELP.smcl"

log close

exit, clear




