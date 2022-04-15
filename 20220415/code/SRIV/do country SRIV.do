
clear all

cd "$pathcovir2"

cd SRIV

capture log close 

log using "log country SRIV.smcl", replace

*****************************************************************************
* This is "do country SRIV.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare SRIV data for country
*****************************************************************************


di "SRIVdate = " "$SRIVdate"



* Get SRIV estimates 

copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/$SRIVdate/global_forecasts_deaths.csv global_forecasts_deaths.csv
copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/$SRIVdate/global_forecasts_deaths_lb.csv global_forecasts_deaths_lb.csv
copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/$SRIVdate/global_forecasts_deaths_ub.csv global_forecasts_deaths_ub.csv
copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/$SRIVdate/global_forecasts_cases.csv global_forecasts_cases.csv
copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/$SRIVdate/global_forecasts_cases_lb.csv global_forecasts_cases_lb.csv
copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/$SRIVdate/global_forecasts_cases_ub.csv global_forecasts_cases_ub.csv



local list ///
global_forecasts_deaths global_forecasts_deaths_lb global_forecasts_deaths_ub ///
global_forecasts_cases global_forecasts_cases_lb global_forecasts_cases_ub

foreach l of local list {
	import delimited "`l'.csv", clear varnames(1)
	keep if regexm(country,"$country") == 1
	drop id	country
	
	destring *, replace
	
	gen i = _n
	reshape long v, i(i) j(j)
	rename v `l'
	rename j date
	drop i

	save "`l'.dta", replace 
}
*

foreach l of local list {
	merge 1:1 date using "`l'.dta"
	drop _merge
}
*

rename global_forecasts_deaths_lb TotDeaLoRaA05S00	
rename global_forecasts_deaths_ub TotDeaUpRaA05S00	
rename global_forecasts_deaths    TotDeaMeRaA05S00
rename global_forecasts_cases_lb  TotCasLoRaA05S00
rename global_forecasts_cases_ub  TotCasUpRaA05S00	
rename global_forecasts_cases	  TotCasMeRaA05S00

label var TotDeaMeRaA05S00 "Total Deaths Mean SRIV"
label var TotDeaLoRaA05S00 "Total Deaths Lower SRIV"
label var TotDeaUpRaA05S00 "Total Deaths Upper SRIV"
label var TotCasMeRaA05S00 "Total Cases Mean SRIV"
label var TotCasLoRaA05S00 "Total Cases Lower SRIV"
label var TotCasUpRaA05S00 "Total Cases Upper SRIV"


* first date in csv files is one day before the update date

rename date date_original
gen date = .
replace date = td(09jan2022) in 1
replace date = date[_n-1] + 1 in 2/l
format date %tdDDMonCCYY
codebook date
drop date_original

sort date

local list ///
DeaMeRaA05S00 DeaLoRaA05S00 DeaUpRaA05S00 ///
CasMeRaA05S00 CasLoRaA05S00 CasUpRaA05S00 

foreach l of local list {
	gen Day`l' =  Tot`l'[_n] - Tot`l'[_n-1]
}
*


label var DayDeaMeRaA05S00 "Daily Deaths Mean SRIV"
label var DayDeaLoRaA05S00 "Daily Deaths Lower SRIV"
label var DayDeaUpRaA05S00 "Daily Deaths Upper SRIV"
label var DayCasMeRaA05S00 "Daily Cases Mean SRIV"
label var DayCasLoRaA05S00 "Daily Cases Lower SRIV"
label var DayCasUpRaA05S00 "Daily Cases Upper SRIV"

gen loc_grand_name = "$country"


order date loc_grand_name

* gen cfr 

gen DayCfrMeRaA05S00 = 100 * DayDeaMeRaA05S00 / DayCasMeRaA05S00
gen DayCfrLoRaA05S00 = 100 * DayDeaLoRaA05S00 / DayCasLoRaA05S00
gen DayCfrUpRaA05S00 = 100 * DayDeaUpRaA05S00 / DayCasUpRaA05S00

label var DayCfrMeRaA05S00 "Daily CFR Mean SRIV"
label var DayCfrLoRaA05S00 "Daily CFR Lower SRIV"
label var DayCfrUpRaA05S00 "Daily CFR Upper SRIV"





* gen "Daily cases mean div by daily deaths mean SRIV  DayCbD" for visulization of temporal relation of deaths and cases peaks 


summ DayDeaMeRaA05S00 
gen DayDeMMeRaA05S00   = r(mean)
label var DayDeMMeRaA05S00   "Daily deaths mean SRIV  DayDeM"

summ DayCasMeRaA05S00   
gen DayCaMMeRaA05S00   = r(mean)
label var DayCaMMeRaA05S00   "Daily cases mean SRIV  DayCaM"
                           
gen DayCbDMeRaA05S00   = DayCaMMeRaA05S00   / DayDeMMeRaA05S00  
label var DayCbDMeRaA05S00   "Daily cases mean div by daily deaths mean SRIV  DayCbD"
summ DayCbDMeRaA05S00  
                                              
gen DayDMuMeRaA05S00   = DayDeaMeRaA05S00   * DayCbDMeRaA05S00  
label var DayDMuMeRaA05S00   "Daily deaths scaled (times means of cases by deaths) SRIV "
summ DayDMuMeRaA05S00  
	
	
	
	

******************
	
* smooth 

tsset date, daily   


tssmooth ma DayDeaMeRaA05S00_window = DayDeaMeRaA05S00 if DayDeaMeRaA05S00 >= 0, window(3 1 3) 

tssmooth ma DayDeaMeSmA05S00 = DayDeaMeRaA05S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA05S00 "Daily deaths smooth A05 SRIV"

drop DayDeaMeRaA05S00_window


tssmooth ma DayCasMeRaA05S00_window = DayCasMeRaA05S00 if DayCasMeRaA05S00 >= 0, window(3 1 3)

tssmooth ma DayCasMeSmA05S00 = DayCasMeRaA05S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasMeSmA05S00 "Daily cases smooth A05 SRIV"

drop DayCasMeRaA05S00_window


	
	
	
	

* Forecast start date 

gen epoch_SRIV = td($SRIVepoch) // update release date
label var epoch_SRIV "SRIV Forecast start date"

gen DayDeaFOREA05S00 = DayDeaMeSmA05S00
replace DayDeaFOREA05S00 = . if date < td($SRIVepoch)
label var DayDeaFOREA05S00 "Daily Forecasted Deaths Mean smoothed SRIV"

gen DayCasFOREA05S00 = DayCasMeSmA05S00
replace DayCasFOREA05S00 = . if date < td($SRIVepoch)
label var DayCasFOREA05S00 "Daily Forecasted Cases Mean smoothed SRIV"

qui compress

sort date loc_grand_name 

save "country SRIV.dta", replace
 


view "log country SRIV.smcl"

log close

exit, clear



