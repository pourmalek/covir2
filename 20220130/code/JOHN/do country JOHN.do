

clear all

cd "$pathcovir2"

cd JOHN

capture log close 

log using "log country JOHN.smcl", replace

***************************************************************************
* This is "do country JOHN.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare Johns Hopkins data for country
***************************************************************************



* get Johns Hopkins data for deaths


import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv" ///
, clear varnames(1) colrange(2:2)

save "time_series_covid19_deaths_global col 2.dta", replace


import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv" ///
, clear varnames(1) colrange(5)


save "time_series_covid19_deaths_global col 5 on.dta", replace


use "time_series_covid19_deaths_global col 2.dta", clear 

merge 1:1 _n using "time_series_covid19_deaths_global col 5 on.dta"


rename countryregion loc_grand_name

label var loc_grand_name "location grand name"

keep if regexm(loc_grand_name,"$country") == 1

order loc_grand_name, last

gen counter = _n

reshape long v, i(counter) 

drop counter 

codebook _j



gen date = date("22 Jan 2020", "DMY")

replace date = date + _j - 1

format date %td

codebook date

order date 

rename v TotDeaMeRaA00S00

label var TotDeaMeRaA00S00 "Total Deaths JOHN"

destring TotDeaMeRaA00S00, replace

list TotDeaMeRaA00S00 if date == td(19feb2020) // Shoule be 2

gen DayDeaMeRaA00S00 =  TotDeaMeRaA00S00[_n] - TotDeaMeRaA00S00[_n-1]

label var DayDeaMeRaA00S00 "Daily Deaths JOHN"

replace DayDeaMeRaA00S00 = TotDeaMeRaA00S00 if _j == 1

replace TotDeaMeRaA00S00 = . if date < td(19feb2020)

replace DayDeaMeRaA00S00 = . if date < td(19feb2020)

drop _j _merge



gen DayDeaMeRaA00S00_CF2 = DayDeaMeRaA00S00 * 2

label var DayDeaMeRaA00S00_CF2 "Daily Deaths JOHN correction factor 2"

gen DayDeaMeRaA00S00_CF5 = DayDeaMeRaA00S00 * 5

label var DayDeaMeRaA00S00_CF5 "Daily Deaths JOHN correction factor 5"

gen TotDeaMeRaA00S00_CF2 = TotDeaMeRaA00S00 * 2

label var TotDeaMeRaA00S00_CF2 "Total Deaths JOHN correction factor 2"

gen TotDeaMeRaA00S00_CF5 = TotDeaMeRaA00S00 * 5

label var TotDeaMeRaA00S00_CF5 "Total Deaths JOHN correction factor 5"



order date loc_grand_name DayDeaMeRaA00S00 TotDeaMeRaA00S00 DayDeaMeRaA00S00_CF2 DayDeaMeRaA00S00_CF5 TotDeaMeRaA00S00_CF2 TotDeaMeRaA00S00_CF5
					

sort date

save "country JOHN deaths.dta", replace









* get Johns Hopkins data for cases


import delimited using ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv" ///
, clear varnames(1) colrange(2:2)

save "time_series_covid19_confirmed_global col 2.dta", replace


import delimited using ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv" ///
, clear varnames(1) colrange(5)

save "time_series_covid19_confirmed_global col 5 on.dta", replace


use "time_series_covid19_confirmed_global col 2.dta", clear 

merge 1:1 _n using "time_series_covid19_confirmed_global col 5 on.dta"


rename countryregion loc_grand_name

keep if regexm(loc_grand_name,"$country") == 1

order loc_grand_name, last

gen counter = _n

reshape long v, i(counter) 

drop counter 

codebook _j

gen date = date("22 Jan 2020", "DMY")

replace date = date + _j - 1

format date %td

codebook date

order date 

rename v TotCasMeRaA00S00

label var TotCasMeRaA00S00 "Total Cases JOHN"

destring TotCasMeRaA00S00, replace

gen DayCasMeRaA00S00 =  TotCasMeRaA00S00[_n] - TotCasMeRaA00S00[_n-1]

label var DayCasMeRaA00S00 "Daily Cases JOHN"

replace DayCasMeRaA00S00 = TotCasMeRaA00S00 if _j == 1

replace TotCasMeRaA00S00 = . if date < td(19feb2020)

replace DayCasMeRaA00S00 = . if date < td(19feb2020)

drop _j _merge


gen DayCasMeRaA00S00_CF2 = DayCasMeRaA00S00 * 2

label var DayCasMeRaA00S00_CF2 "Daily Cases JOHN correction factor 2"

gen DayCasMeRaA00S00_CF5 = DayCasMeRaA00S00 * 5

label var DayCasMeRaA00S00_CF5 "Daily Cases JOHN correction factor 5"

gen TotCasMeRaA00S00_CF2 = TotCasMeRaA00S00 * 2

label var TotCasMeRaA00S00_CF2 "Total Cases JOHN correction factor 2"

gen TotCasMeRaA00S00_CF5 = TotCasMeRaA00S00 * 5

label var TotCasMeRaA00S00_CF5 "Total Cases JOHN correction factor 5"


order date loc_grand_name DayCasMeRaA00S00 TotCasMeRaA00S00 DayCasMeRaA00S00_CF2 DayCasMeRaA00S00_CF5 TotCasMeRaA00S00_CF2 TotCasMeRaA00S00_CF5

sort date

compress

save "country JOHN Cases.dta", replace








* get Johns Hopkins data for recovered

import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv" ///
, clear varnames(1) colrange(2:2)

save "time_series_covid19_recovered_global col 2.dta", replace


import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv" ///
, clear varnames(1) colrange(5)

save "time_series_covid19_recovered_global col 5 on.dta", replace


use "time_series_covid19_recovered_global col 2.dta", clear 

merge 1:1 _n using "time_series_covid19_recovered_global col 5 on.dta"


rename countryregion loc_grand_name

keep if regexm(loc_grand_name,"$country") == 1

order loc_grand_name, last


gen counter = _n

reshape long v, i(counter) 

drop counter 

codebook _j


gen date = date("22 Jan 2020", "DMY")

replace date = date + _j - 1

format date %td

codebook date

order date 

rename v TotRecMeRaA00S00

label var TotRecMeRaA00S00 "Total RECovered JOHN"

destring TotRecMeRaA00S00, replace

list TotRecMeRaA00S00 if date == td(19feb2020) // Shoule be 2

gen DayRecMeRaA00S00 =  TotRecMeRaA00S00[_n] - TotRecMeRaA00S00[_n-1]

label var DayRecMeRaA00S00 "Daily RECovered JOHN"

replace DayRecMeRaA00S00 = TotRecMeRaA00S00 if _j == 1

replace TotRecMeRaA00S00 = . if date < td(19feb2020)

replace DayRecMeRaA00S00 = . if date < td(19feb2020)

drop _j _merge
					

sort date

save "country JOHN recovered.dta", replace







* merge deaths and cases and recovered

use "country JOHN deaths.dta", clear 

merge 1:1 date using "country JOHN Cases.dta"

drop _merge

merge 1:1 date using "country JOHN recovered.dta"

drop _merge

*

* gen cfr

gen DayCfrMeRaA00S00 = 100 * DayDeaMeRaA00S00 / DayCasMeRaA00S00

label var DayCfrMeRaA00S00 "Daily CFR JOHN"

*


****** add obs 01 Jan 2020 to 21 Jan 2020 for better graphing


expand 22 in 1

sort date

rename date date_original 

gen date = .

replace date = td(01Jan2020) in 1

replace date = date[_n-1] + 1 in 2/l

format date %tdDDMonCCYY

codebook date

drop date_original

order date


* gen prevalent case

* Daily prevalent cases = Total Cases - (Total Deaths + Total recovered)

gen DayActMeRaA00S00 = TotCasMeRaA00S00 - TotDeaMeRaA00S00 - TotRecMeRaA00S00

label var DayActMeRaA00S00 "Daily Active JOHN"



* smooth 

tsset date, daily   


tssmooth ma DayDeaMeRaA00S00_window = DayDeaMeRaA00S00 if DayDeaMeRaA00S00 >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmA00S00 = DayDeaMeRaA00S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA00S00 "Daily deaths smooth A00 JOHN"

drop DayDeaMeRaA00S00_window


tssmooth ma DayCasMeRaA00S00_window = DayCasMeRaA00S00 if DayCasMeRaA00S00 >= 0, window(3 1 3)

tssmooth ma DayCasMeSmA00S00 = DayCasMeRaA00S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasMeSmA00S00 "Daily cases smooth A00 JOHN"

drop DayCasMeRaA00S00_window

tsset, clear



**********************

* Peak Dates (P?D) and Peak Values (P?V), and Post-peaks (PP?), smoothed values


* deaths


* peak 1 - deaths P1 20-03-01 20-05-01 - 22009 04Apr2020 137.6071 

summ DayDeaMeSmA00S00 if date > td(01mar2020) & date < td(01may2020)
gen DayDeaMeSmA00S00P1V = r(max)
label var DayDeaMeSmA00S00P1V "Daily deaths smooth JOHN Peak 1 Value"

summ date if DayDeaMeSmA00S00 == DayDeaMeSmA00S00P1V & date > td(01mar2020) & date < td(01may2020)
gen DayDeaMeSmA00S00P1D = r(mean)
label var DayDeaMeSmA00S00P1D "Daily deaths smooth JOHN Peak 1 Date"
format DayDeaMeSmA00S00P1D %tdDDMonCCYY 



* peak 2 - deaths P2 20-07-01 20-09-01 - 22120 24Jul2020 215.0536

summ DayDeaMeSmA00S00 if date > td(01jul2020) & date < td(01sep2020)

gen DayDeaMeSmA00S00P2V = r(max)
label var DayDeaMeSmA00S00P2V "Daily deaths smooth JOHN Peak 2 Value"

summ date if DayDeaMeSmA00S00 == DayDeaMeSmA00S00P2V & date > td(01jul2020) & date < td(01sep2020)
gen DayDeaMeSmA00S00P2D = r(mean)
label var DayDeaMeSmA00S00P2D "Daily deaths smooth JOHN Peak 2 Date"
format DayDeaMeSmA00S00P2D %tdDDMonCCYY 



* peak 3 - deaths P3 20-11-01 20-12-01 - 22237 18Nov2020 470.8839

summ DayDeaMeSmA00S00 if date > td(01nov2020) & date < td(01dec2020)

gen DayDeaMeSmA00S00P3V = r(max)
label var DayDeaMeSmA00S00P3V "Daily deaths smooth JOHN Peak 3 Value"

summ date if DayDeaMeSmA00S00 == DayDeaMeSmA00S00P3V & date > td(01nov2020) & date < td(01dec2020)
gen DayDeaMeSmA00S00P3D = r(mean)
label var DayDeaMeSmA00S00P3D "Daily deaths smooth JOHN Peak 3 Date"
format DayDeaMeSmA00S00P3D %tdDDMonCCYY 



* peak 4 - deaths P4 21-04-01 21-06-01 - 22396 26Apr2021 428.0268

summ DayDeaMeSmA00S00 if date > td(01apr2021) & date < td(01jun2021)

gen DayDeaMeSmA00S00P4V = r(max)
label var DayDeaMeSmA00S00P4V "Daily deaths smooth JOHN Peak 4 Value"

summ date if DayDeaMeSmA00S00 == DayDeaMeSmA00S00P4V & date > td(01apr2021) & date < td(01jun2021)
gen DayDeaMeSmA00S00P4D = r(mean)
label var DayDeaMeSmA00S00P4D "Daily deaths smooth JOHN Peak 4 Date"
format DayDeaMeSmA00S00P4D %tdDDMonCCYY 



* peak 5 - deaths P5 21-08-01 21-09-01 - 22517 25Aug2021 639.7053

summ DayDeaMeSmA00S00 if date > td(01aug2021) & date < td(01sep2021)

gen DayDeaMeSmA00S00P5V = r(max)
label var DayDeaMeSmA00S00P5V "Daily deaths smooth JOHN Peak 5 Value"

summ date if DayDeaMeSmA00S00 == DayDeaMeSmA00S00P5V & date > td(01aug2021) & date < td(01sep2021)
gen DayDeaMeSmA00S00P5D = r(mean)
label var DayDeaMeSmA00S00P5D "Daily deaths smooth JOHN Peak 5 Date"
format DayDeaMeSmA00S00P5D %tdDDMonCCYY 






* POST Peak 1 - deaths PP1 20-05-01 20-06-01 - 22037 02May2020 67.01786

summ DayDeaMeSmA00S00 if date > td(01may2020) & date < td(01jun2020)
gen DayDeaMeSmA00S00PP1V = r(min)
label var DayDeaMeSmA00S00PP1V "Daily deaths smooth JOHN POST Peak 1 Value"

summ date if DayDeaMeSmA00S00 == DayDeaMeSmA00S00PP1V & date > td(01may2020) & date < td(01jun2020)
gen DayDeaMeSmA00S00PP1D = r(mean)
label var DayDeaMeSmA00S00PP1D "Daily deaths smooth JOHN POST Peak 1 Date"
format DayDeaMeSmA00S00PP1D %tdDDMonCCYY 



* POST Peak 2 - deaths PP2 20-08-01 20-10-01 - 22129 02Aug2020 204.9732

summ DayDeaMeSmA00S00 if date > td(01aug2020) & date < td(01oct2020)

gen DayDeaMeSmA00S00PP2V = r(min)
label var DayDeaMeSmA00S00PP2V "Daily deaths smooth JOHN POST Peak 2 Value"

summ date if DayDeaMeSmA00S00 == DayDeaMeSmA00S00PP2V & date > td(01aug2020) & date < td(01oct2020)
gen DayDeaMeSmA00S00PP2D = r(mean)
label var DayDeaMeSmA00S00PP2D "Daily deaths smooth JOHN POST Peak 2 Date"
format DayDeaMeSmA00S00PP2D %tdDDMonCCYY 



* POST Peak 3 - deaths PP3 21-01-01 21-04-01 - 22282 02Jan2021 112.3214 

summ DayDeaMeSmA00S00 if date > td(01jan2021) & date < td(01apr2021)

gen DayDeaMeSmA00S00PP3V = r(min)
label var DayDeaMeSmA00S00PP3V "Daily deaths smooth JOHN POST Peak 3 Value"

summ date if DayDeaMeSmA00S00 == DayDeaMeSmA00S00PP3V & date > td(01jan2021) & date < td(01apr2021)
gen DayDeaMeSmA00S00PP3D = r(mean)
label var DayDeaMeSmA00S00PP3D "Daily deaths smooth JOHN POST Peak 3 Date"
format DayDeaMeSmA00S00PP3D %tdDDMonCCYY 




* POST peak 4 - deaths PP4 21-06-01 21-07-01 - 22433 02Jun2021 167.9732

summ DayDeaMeSmA00S00 if date > td(01jun2021) & date < td(01jul2021)

gen DayDeaMeSmA00S00PP4V = r(min)
label var DayDeaMeSmA00S00PP4V "Daily deaths smooth JOHN POST Peak 4 Value"

summ date if DayDeaMeSmA00S00 == DayDeaMeSmA00S00PP4V & date > td(01jun2021) & date < td(01jul2021)
gen DayDeaMeSmA00S00PP4D = r(mean)
label var DayDeaMeSmA00S00PP4D "Daily deaths smooth JOHN POST Peak 4 Date"
format DayDeaMeSmA00S00PP4D %tdDDMonCCYY 




* POST peak 5 - deaths PP5 21-10-01 22-02-30 - 22663 02Oct2021 22.02679

summ DayDeaMeSmA00S00 if date > td(01oct2021) & date < td(30jan2022)

gen DayDeaMeSmA00S00PP5V = r(min)
label var DayDeaMeSmA00S00PP5V "Daily deaths smooth JOHN Peak 5 Value"

summ date if DayDeaMeSmA00S00 == DayDeaMeSmA00S00PP5V & date > td(01oct2021) & date < td(30jan2022)
gen DayDeaMeSmA00S00PP5D = r(mean)
label var DayDeaMeSmA00S00PP5D "Daily deaths smooth JOHN Peak 5 Date"
format DayDeaMeSmA00S00PP5D %tdDDMonCCYY 



* peak 1 - deaths P1 20-03-01 20-05-01 - 22009 04Apr2020 137.6071 
* peak 2 - deaths P2 20-07-01 20-09-01 - 22120 24Jul2020 215.0536
* peak 3 - deaths P3 20-11-01 20-12-01 - 22237 18Nov2020 470.8839
* peak 4 - deaths P4 21-04-01 21-06-01 - 22396 26Apr2021 428.0268
* peak 5 - deaths P5 21-08-01 21-09-01 - 22517 25Aug2021 639.7053

* POST Peak 1 - deaths PP1 20-05-01 20-06-01 - 22048 13May2020 51.33929
* POST Peak 2 - deaths PP2 20-08-01 20-10-01 - 22157 30Aug2020 112.3393
* POST Peak 3 - deaths PP3 21-01-01 21-04-01 - 22321 10Feb2021 68.69643 
* POST peak 4 - deaths PP4 21-06-01 21-07-01 - 22452 21Jun2021 122.3125
* POST peak 5 - deaths PP5 21-10-01 22-02-30 - 22663 18jan2022 22.02679



gen DayDeaMeSmA00S00PD = . 
label var DayDeaMeSmA00S00PD "Daily deaths smooth JOHN Peak Dates"
replace DayDeaMeSmA00S00PD = DayDeaMeSmA00S00P1D if date == DayDeaMeSmA00S00P1D
replace DayDeaMeSmA00S00PD = DayDeaMeSmA00S00P2D if date == DayDeaMeSmA00S00P2D
replace DayDeaMeSmA00S00PD = DayDeaMeSmA00S00P3D if date == DayDeaMeSmA00S00P3D
replace DayDeaMeSmA00S00PD = DayDeaMeSmA00S00P4D if date == DayDeaMeSmA00S00P4D
replace DayDeaMeSmA00S00PD = DayDeaMeSmA00S00P5D if date == DayDeaMeSmA00S00P5D

gen DayDeaMeSmA00S00PV = . 
label var DayDeaMeSmA00S00PV "Daily deaths smooth JOHN Peak Values"
replace DayDeaMeSmA00S00PV = DayDeaMeSmA00S00P1V if date == DayDeaMeSmA00S00P1D
replace DayDeaMeSmA00S00PV = DayDeaMeSmA00S00P2V if date == DayDeaMeSmA00S00P2D
replace DayDeaMeSmA00S00PV = DayDeaMeSmA00S00P3V if date == DayDeaMeSmA00S00P3D
replace DayDeaMeSmA00S00PV = DayDeaMeSmA00S00P4V if date == DayDeaMeSmA00S00P4D
replace DayDeaMeSmA00S00PV = DayDeaMeSmA00S00P5V if date == DayDeaMeSmA00S00P5D



gen DayDeaMeSmA00S00PPD = . 
label var DayDeaMeSmA00S00PPD "Daily deaths smooth JOHN POST Peak Dates"
replace DayDeaMeSmA00S00PPD = DayDeaMeSmA00S00PP1D if date == DayDeaMeSmA00S00PP1D
replace DayDeaMeSmA00S00PPD = DayDeaMeSmA00S00PP2D if date == DayDeaMeSmA00S00PP2D
replace DayDeaMeSmA00S00PPD = DayDeaMeSmA00S00PP3D if date == DayDeaMeSmA00S00PP3D
replace DayDeaMeSmA00S00PPD = DayDeaMeSmA00S00PP4D if date == DayDeaMeSmA00S00PP4D
replace DayDeaMeSmA00S00PPD = DayDeaMeSmA00S00PP5D if date == DayDeaMeSmA00S00PP5D

gen DayDeaMeSmA00S00PPV = . 
label var DayDeaMeSmA00S00PPV "Daily deaths smooth JOHN POST Peak Values"
replace DayDeaMeSmA00S00PPV = DayDeaMeSmA00S00PP1V if date == DayDeaMeSmA00S00PP1D
replace DayDeaMeSmA00S00PPV = DayDeaMeSmA00S00PP2V if date == DayDeaMeSmA00S00PP2D
replace DayDeaMeSmA00S00PPV = DayDeaMeSmA00S00PP3V if date == DayDeaMeSmA00S00PP3D
replace DayDeaMeSmA00S00PPV = DayDeaMeSmA00S00PP4V if date == DayDeaMeSmA00S00PP4D
replace DayDeaMeSmA00S00PPV = DayDeaMeSmA00S00PP5V if date == DayDeaMeSmA00S00PP5D











* cases


* peak 1 - cases P1 20-03-01 20-05-01 - 22005 31Mar2020 2923.036

summ DayCasMeSmA00S00 if date > td(01mar2020) & date < td(01may2020)
gen DayCasMeSmA00S00P1V = r(max)
label var DayCasMeSmA00S00P1V "Daily cases smooth JOHN Peak 1 Value"

summ date if DayCasMeSmA00S00 == DayCasMeSmA00S00P1V & date > td(01mar2020) & date < td(01may2020)
gen DayCasMeSmA00S00P1D = r(mean)
label var DayCasMeSmA00S00P1D "Daily cases smooth JOHN Peak 1 Date"
format DayCasMeSmA00S00P1D %tdDDMonCCYY 



* peak 2 - cases P2 20-03-01 20-09-01 - 22069 03Jun2020 2869.813

summ DayCasMeSmA00S00 if date > td(01may2020) & date < td(01sep2020)

gen DayCasMeSmA00S00P2V = r(max)
label var DayCasMeSmA00S00P2V "Daily cases smooth JOHN Peak 2 Value"

summ date if DayCasMeSmA00S00 == DayCasMeSmA00S00P2V & date > td(01may2020) & date < td(01sep2020)
gen DayCasMeSmA00S00P2D = r(mean)
label var DayCasMeSmA00S00P2D "Daily cases smooth JOHN Peak 2 Date"
format DayCasMeSmA00S00P2D %tdDDMonCCYY 



* peak 3 - cases P3 20-11-01 21-01-01 - 22247 28Nov2020 13579.87

summ DayCasMeSmA00S00 if date > td(01nov2020) & date < td(01jan2021)

gen DayCasMeSmA00S00P3V = r(max)
label var DayCasMeSmA00S00P3V "Daily cases smooth JOHN Peak 3 Value"

summ date if DayCasMeSmA00S00 == DayCasMeSmA00S00P3V & date > td(01nov2020) & date < td(01jan2021)
gen DayCasMeSmA00S00P3D = r(mean)
label var DayCasMeSmA00S00P3D "Daily cases smooth JOHN Peak 3 Date"
format DayCasMeSmA00S00P3D %tdDDMonCCYY 



* peak 4 - cases P4 21-04-01 21-06-01 - 22387 17Apr2021 23945.28

summ DayCasMeSmA00S00 if date > td(01apr2021) & date < td(01jun2021)

gen DayCasMeSmA00S00P4V = r(max)
label var DayCasMeSmA00S00P4V "Daily cases smooth JOHN Peak 4 Value"

summ date if DayCasMeSmA00S00 == DayCasMeSmA00S00P4V & date > td(01apr2021) & date < td(01jun2021)
gen DayCasMeSmA00S00P4D = r(mean)
label var DayCasMeSmA00S00P4D "Daily cases smooth JOHN Peak 4 Date"
format DayCasMeSmA00S00P4D %tdDDMonCCYY 



* peak 5 - cases P5 21-08-01 21-09-01 - 22506 14Aug2021 38735.95

summ DayCasMeSmA00S00 if date > td(01aug2021) & date < td(01sep2021)

gen DayCasMeSmA00S00P5V = r(max)
label var DayCasMeSmA00S00P5V "Daily cases smooth JOHN Peak 5 Value"

summ date if DayCasMeSmA00S00 == DayCasMeSmA00S00P5V & date > td(01aug2021) & date < td(01sep2021)
gen DayCasMeSmA00S00P5D = r(mean)
label var DayCasMeSmA00S00P5D "Daily cases smooth JOHN Peak 5 Date"
format DayCasMeSmA00S00P5D %tdDDMonCCYY 






* POST Peak 1 - cases PP1 20-04-01 20-06-01 - 22035 30Apr2020 1035.179

summ DayCasMeSmA00S00 if date > td(01apr2020) & date < td(01jun2020)
gen DayCasMeSmA00S00PP1V = r(min)
label var DayCasMeSmA00S00PP1V "Daily cases smooth JOHN POST Peak 1 Value"

summ date if DayCasMeSmA00S00 == DayCasMeSmA00S00PP1V & date > td(01apr2020) & date < td(01jun2020)
gen DayCasMeSmA00S00PP1D = r(mean)
label var DayCasMeSmA00S00PP1D "Daily cases smooth JOHN POST Peak 1 Date"
format DayCasMeSmA00S00PP1D %tdDDMonCCYY 



* POST Peak 2 - cases PP2 20-06-01 20-10-01 - 22159 01Sep2020 1861.08

summ DayCasMeSmA00S00 if date > td(01jun2020) & date < td(01oct2020)

gen DayCasMeSmA00S00PP2V = r(min)
label var DayCasMeSmA00S00PP2V "Daily cases smooth JOHN POST Peak 2 Value"

summ date if DayCasMeSmA00S00 == DayCasMeSmA00S00PP2V & date > td(01jun2020) & date < td(01oct2020)
gen DayCasMeSmA00S00PP2D = r(mean)
label var DayCasMeSmA00S00PP2D "Daily cases smooth JOHN POST Peak 2 Date"
format DayCasMeSmA00S00PP2D %tdDDMonCCYY 



* POST Peak 3 - cases PP3 21-01-01 21-04-01 - 22299 19Jan2021 6103

summ DayCasMeSmA00S00 if date > td(01jan2021) & date < td(01apr2021)

gen DayCasMeSmA00S00PP3V = r(min)
label var DayCasMeSmA00S00PP3V "Daily cases smooth JOHN POST Peak 3 Value"

summ date if DayCasMeSmA00S00 == DayCasMeSmA00S00PP3V & date > td(01jan2021) & date < td(01apr2021)
gen DayCasMeSmA00S00PP3D = r(mean)
label var DayCasMeSmA00S00PP3D "Daily cases smooth JOHN POST Peak 3 Date"
format DayCasMeSmA00S00PP3D %tdDDMonCCYY 




* POST peak 4 - cases PP4 21-05-01 21-07-01 - 22437 06Jun2021 8230.759

summ DayCasMeSmA00S00 if date > td(01may2021) & date < td(01jul2021)

gen DayCasMeSmA00S00PP4V = r(min)
label var DayCasMeSmA00S00PP4V "Daily cases smooth JOHN POST Peak 4 Value"

summ date if DayCasMeSmA00S00 == DayCasMeSmA00S00PP4V & date > td(01may2021) & date < td(01jul2021)
gen DayCasMeSmA00S00PP4D = r(mean)
label var DayCasMeSmA00S00PP4D "Daily cases smooth JOHN POST Peak 4 Date"
format DayCasMeSmA00S00PP4D %tdDDMonCCYY 




* POST peak 5 - cases PP5 21-10-01 22-02-30 - 22645 31dec2021 1399.045

summ DayCasMeSmA00S00 if date > td(01oct2021) & date < td(30jan2022)

gen DayCasMeSmA00S00PP5V = r(min)
label var DayCasMeSmA00S00PP5V "Daily cases smooth JOHN Peak 5 Value"

summ date if DayCasMeSmA00S00 == DayCasMeSmA00S00PP5V & date > td(01oct2021) & date < td(30jan2022)
gen DayCasMeSmA00S00PP5D = r(mean)
label var DayCasMeSmA00S00PP5D "Daily cases smooth JOHN Peak 5 Date"
format DayCasMeSmA00S00PP5D %tdDDMonCCYY 



gen DayCasMeSmA00S00PD = . 
label var DayCasMeSmA00S00PD "Daily cases smooth JOHN Peak Dates"
replace DayCasMeSmA00S00PD = DayCasMeSmA00S00P1D if date == DayCasMeSmA00S00P1D
replace DayCasMeSmA00S00PD = DayCasMeSmA00S00P2D if date == DayCasMeSmA00S00P2D
replace DayCasMeSmA00S00PD = DayCasMeSmA00S00P3D if date == DayCasMeSmA00S00P3D
replace DayCasMeSmA00S00PD = DayCasMeSmA00S00P4D if date == DayCasMeSmA00S00P4D
replace DayCasMeSmA00S00PD = DayCasMeSmA00S00P5D if date == DayCasMeSmA00S00P5D

gen DayCasMeSmA00S00PV = . 
label var DayCasMeSmA00S00PV "Daily cases smooth JOHN Peak Values"
replace DayCasMeSmA00S00PV = DayCasMeSmA00S00P1V if date == DayCasMeSmA00S00P1D
replace DayCasMeSmA00S00PV = DayCasMeSmA00S00P2V if date == DayCasMeSmA00S00P2D
replace DayCasMeSmA00S00PV = DayCasMeSmA00S00P3V if date == DayCasMeSmA00S00P3D
replace DayCasMeSmA00S00PV = DayCasMeSmA00S00P4V if date == DayCasMeSmA00S00P4D
replace DayCasMeSmA00S00PV = DayCasMeSmA00S00P5V if date == DayCasMeSmA00S00P5D



gen DayCasMeSmA00S00PPD = . 
label var DayCasMeSmA00S00PPD "Daily cases smooth JOHN POST Peak Dates"
replace DayCasMeSmA00S00PPD = DayCasMeSmA00S00PP1D if date == DayCasMeSmA00S00PP1D
replace DayCasMeSmA00S00PPD = DayCasMeSmA00S00PP2D if date == DayCasMeSmA00S00PP2D
replace DayCasMeSmA00S00PPD = DayCasMeSmA00S00PP3D if date == DayCasMeSmA00S00PP3D
replace DayCasMeSmA00S00PPD = DayCasMeSmA00S00PP4D if date == DayCasMeSmA00S00PP4D
replace DayCasMeSmA00S00PPD = DayCasMeSmA00S00PP5D if date == DayCasMeSmA00S00PP5D



gen DayCasMeSmA00S00PPV = . 
label var DayCasMeSmA00S00PPV "Daily cases smooth JOHN POST Peak Values"
replace DayCasMeSmA00S00PPV = DayCasMeSmA00S00PP1V if date == DayCasMeSmA00S00PP1D
replace DayCasMeSmA00S00PPV = DayCasMeSmA00S00PP2V if date == DayCasMeSmA00S00PP2D
replace DayCasMeSmA00S00PPV = DayCasMeSmA00S00PP3V if date == DayCasMeSmA00S00PP3D
replace DayCasMeSmA00S00PPV = DayCasMeSmA00S00PP4V if date == DayCasMeSmA00S00PP4D
replace DayCasMeSmA00S00PPV = DayCasMeSmA00S00PP5V if date == DayCasMeSmA00S00PP5D



* peak 1 - cases P1 20-03-01 20-05-01 - 22005 31Mar2020 2923.036
* peak 2 - cases P2 20-03-01 20-09-01 - 22069 03Jun2020 2869.813
* peak 3 - cases P3 20-11-01 21-01-01 - 22247 28Nov2020 13579.87
* peak 4 - cases P4 21-04-01 21-06-01 - 22387 17Apr2021 23945.28
* peak 5 - cases P5 21-08-01 21-09-01 - 22506 14Aug2021 38735.95

* POST Peak 1 - cases PP1 20-04-01 20-06-01 - 22035 30Apr2020 1035.179
* POST Peak 2 - cases PP2 20-06-01 20-10-01 - 22159 01Sep2020 1861.08
* POST Peak 3 - cases PP3 21-01-01 21-04-01 - 22299 19Jan2021 6103
* POST peak 4 - cases PP4 21-05-01 21-07-01 - 22437 06Jun2021 8230.759
* POST peak 5 - cases PP5 21-10-01 21-11-01 - 22645 31dec2021 1399.045




**************

*** compare wave 6 (Omicron) and wave 5 (Delta)

* POST peak 5 = day 1 of peak 6 = 31dec2021

* gen day1 based on daily cases that precede daily deaths

// gen wave6day1 = 22645 // 31dec2021
// gen wave5day1 = 22437 // 06jun2021
// di 22645 - 22437 + 1 // = 209 duration in days of 5th wave

gen wave5day = 1
label var wave5day "Days from 5th wave start"
replace wave5day = . if date < 22437
replace wave5day = . if date > 22645

sort wave5day date
replace wave5day = wave5day[_n-1] + 1 in 2/l
replace wave5day = . if wave5day > 209

gen DayCasMeSmA00S00wave5 = DayCasMeSmA00S00
label var DayCasMeSmA00S00wave5 "DayCasMeSmA00S00 from 5th wave start"
replace DayCasMeSmA00S00wave5 = . if date < 22437
replace DayCasMeSmA00S00wave5 = . if date > 22645


gen DayCasMeSmA00S00wave6 = DayCasMeSmA00S00
label var DayCasMeSmA00S00wave6 "DayCasMeSmA00S00 from 6th wave start"
sort date  
replace DayCasMeSmA00S00wave6 = DayCasMeSmA00S00[_n+214] in 2/l
replace DayCasMeSmA00S00wave6 = . if date < td(06Jun2021)





gen DayDeaMeSmA00S00wave5 = DayDeaMeSmA00S00
label var DayDeaMeSmA00S00wave5 "DayDeaMeSmA00S00 from 5th wave start"
replace DayDeaMeSmA00S00wave5 = . if date < 22437
replace DayDeaMeSmA00S00wave5 = . if date > 22645


gen DayDeaMeSmA00S00wave6 = DayDeaMeSmA00S00
label var DayDeaMeSmA00S00wave6 "DayDeaMeSmA00S00 from 6th wave start"
sort date  
replace DayDeaMeSmA00S00wave6 = DayDeaMeSmA00S00[_n+214] in 2/l
replace DayDeaMeSmA00S00wave6 = . if date < td(06Jun2021)









qui compress

sort date loc_grand_name


save "country JOHN.dta", replace



view "log country JOHN.smcl"

log close

exit, clear




