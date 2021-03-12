
clear all
 
cd "$pathcovir2"

cd DELP

capture log close 

log using "log Iran DELP.smcl", replace

***************************************************************************
* This is "do Iran DELP.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time: 2021-02-10

* OBJECTIVE: Get and prepare DELPHI data for Iran, Locate peak dates and values
***************************************************************************


* Get DELPHI data for Iran

/* Their latest estimations file “covid_analytics_projections.csv” is located on web page (https://www.covidanalytics.io/projections), 
linked via “Download Most Recent Predictions” located all the way down the page. 
Trying to extract the "web address" of this file (like what is doable for all other studies) leads to the actual data in raw format. 
The file can be downlaoded, and moved to "$pathcovir2/DELP"  */


import delimited using "covid_analytics_projections.csv", clear varnames(1)

rename country loc_grand_name

keep if loc_grand_name == "Iran"


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

rename totaldetecteddeaths   TotDeaMeRaA01S00V03
rename totaldetecteddeathslb TotDeaLoRaA01S00V03
rename totaldetecteddeathsub TotDeaUpRaA01S00V03

label var TotDeaMeRaA01S00V03 "Total Deaths Mean DELP S0 V3"
label var TotDeaMeRaA01S00V03 "Total Deaths Lower DELP S0 V3"
label var TotDeaMeRaA01S00V03 "Total Deaths Upper DELP S0 V3"

rename totaldetected   TotCasMeRaA01S00V03
rename totaldetectedlb TotCasLoRaA01S00V03
rename totaldetectedub TotCasUpRaA01S00V03

label var TotCasMeRaA01S00V03 "Total Cases Mean DELP S0 V3"
label var TotCasMeRaA01S00V03 "Total Cases Lower DELP S0 V3"
label var TotCasMeRaA01S00V03 "Total Cases Upper DELP S0 V3"


* gen daily vars and rename

sort date

gen DayDeaMeRaA01S00V03 =  TotDeaMeRaA01S00V03[_n] - TotDeaMeRaA01S00V03[_n-1]

gen DayDeaLoRaA01S00V03 =  TotDeaLoRaA01S00V03[_n] - TotDeaLoRaA01S00V03[_n-1]

gen DayDeaUpRaA01S00V03 =  TotDeaUpRaA01S00V03[_n] - TotDeaUpRaA01S00V03[_n-1]

gen DayCasMeRaA01S00V03 =  TotCasMeRaA01S00V03[_n] - TotCasMeRaA01S00V03[_n-1]

gen DayCasLoRaA01S00V03 =  TotCasLoRaA01S00V03[_n] - TotCasLoRaA01S00V03[_n-1]

gen DayCasUpRaA01S00V03 =  TotCasUpRaA01S00V03[_n] - TotCasUpRaA01S00V03[_n-1]


label var DayDeaMeRaA01S00V03 "Daily Deaths Mean DELP S0 V3"
label var DayDeaLoRaA01S00V03 "Daily Deaths Lower DELP S0 V3"
label var DayDeaUpRaA01S00V03 "Daily Deaths Upper DELP S0 V3"

label var DayCasMeRaA01S00V03 "Daily Cases Mean DELP S0 V3"
label var DayCasLoRaA01S00V03 "Daily Cases Lower DELP S0 V3"
label var DayCasUpRaA01S00V03 "Daily Cases Upper DELP S0 V3"

label var TotDeaMeRaA01S00V03 "Total Deaths Mean DELP S0 V3"
label var TotDeaLoRaA01S00V03 "Total Deaths Lower DELP S0 V3"
label var TotDeaUpRaA01S00V03 "Total Deaths Upper DELP S0 V3"

label var TotCasMeRaA01S00V03 "Total Cases Mean DELP S0 V3"
label var TotCasLoRaA01S00V03 "Total Cases Lower DELP S0 V3"
label var TotCasUpRaA01S00V03 "Total Cases Upper DELP S0 V3"

 

keep ///
loc_grand_name date ///
TotDeaMeRaA01S00V03 TotDeaLoRaA01S00V03 TotDeaUpRaA01S00V03 ///
DayDeaMeRaA01S00V03 DayDeaLoRaA01S00V03 DayDeaUpRaA01S00V03 ///
TotCasMeRaA01S00V03 TotCasLoRaA01S00V03 TotCasUpRaA01S00V03 ///
DayCasMeRaA01S00V03 DayCasLoRaA01S00V03 DayCasUpRaA01S00V03


order ///
loc_grand_name date ///
TotDeaMeRaA01S00V03 TotDeaLoRaA01S00V03 TotDeaUpRaA01S00V03 ///
DayDeaMeRaA01S00V03 DayDeaLoRaA01S00V03 DayDeaUpRaA01S00V03 ///
TotCasMeRaA01S00V03 TotCasLoRaA01S00V03 TotCasUpRaA01S00V03 ///
DayCasMeRaA01S00V03 DayCasLoRaA01S00V03 DayCasUpRaA01S00V03




* gen cfr

gen DayCfrMeRaA01S00V03 = 100 * DayDeaMeRaA01S00V03 / DayCasMeRaA01S00V03
gen DayCfrLoRaA01S00V03 = 100 * DayDeaLoRaA01S00V03 / DayCasLoRaA01S00V03
gen DayCfrUpRaA01S00V03 = 100 * DayDeaUpRaA01S00V03 / DayCasUpRaA01S00V03

label var DayCfrMeRaA01S00V03 "Daily CFR Mean DELP S0 V3"
label var DayCfrMeRaA01S00V03 "Daily CFR Lower DELP S0 V3"
label var DayCfrMeRaA01S00V03 "Daily CFR Upper DELP S0 V3"






* graphs


grstyle init

grstyle color background white


* daily deaths 	   

codebook date
	   
twoway (rarea DayDeaLoRaA01S00V03 DayDeaUpRaA01S00V03 date, sort color(green*.2)) ///
(line DayDeaMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran", legend(off) ///	   
xtitle(Date) xlabel(#3, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
   
  	   
graph save "graph COVID-19 daily deaths, Iran, DELP.gph", replace
// graph export "graph COVID-19 daily deaths, Iran, DELP.pdf", replace




* daily cases 

twoway (rarea DayCasLoRaA01S00V03 DayCasUpRaA01S00V03 date, sort color(green*.2)) ///
(line DayCasMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran", legend(off) ///	   
xtitle(Date) xlabel(#3, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
	   

graph save "graph COVID-19 daily cases, Iran, DELP.gph", replace
// graph export "graph COVID-19 daily cases, Iran, DELP.pdf", replace





* daily cfr 

twoway (rarea DayCfrLoRaA01S00V03 DayCfrUpRaA01S00V03 date, sort color(green*.2)) ///
(line DayCfrMeRaA01S00V03 date, sort lcolor(green)) ///
if loc_grand_name == "Iran", legend(off) ///	   
xtitle(Date) xlabel(#3, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily CFR, Iran, DELP, single scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
	   

graph save "graph COVID-19 daily CFR, Iran, DELP.gph", replace
// graph export "graph COVID-19 daily CFR, Iran, DELP.pdf", replace










*************************************

* Locate peak dates and values - deaths 




* one peak 

summ DayDeaMeRaA01S00V03 

gen DayDeaMeRaA01S00V03P0V = r(max)

summ date if DayDeaMeRaA01S00V03 == DayDeaMeRaA01S00V03P0V 

gen DayDeaMeRaA01S00V03P0D = r(max)

summ DayDeaLoRaA01S00V03 if date == DayDeaMeRaA01S00V03P0D

gen DayDeaLoRaA01S00V03P0V = r(max)  

summ DayDeaUpRaA01S00V03 if date == DayDeaMeRaA01S00V03P0D

gen DayDeaUpRaA01S00V03P0V = r(max)  

label var DayDeaMeRaA01S00V03P0V "DayDeaMeRaA01S00V03 Peak 0 Value"
label var DayDeaMeRaA01S00V03P0D "DayDeaMeRaA01S00V03 Peak 0 Date"
label var DayDeaLoRaA01S00V03P0V "DayDeaLoRaA01S00V03 Peak 0 Value"
label var DayDeaUpRaA01S00V03P0V "DayDeaUpRaA01S00V03 Peak 0 Value"
format DayDeaMeRaA01S00V03P0D %tdDDMonCCYY


* lowest point in start (P7)

summ DayDeaMeRaA01S00V03 if date < DayDeaMeRaA01S00V03P0D

gen DayDeaMeRaA01S00V03P7V = r(min)

label var DayDeaMeRaA01S00V03P7V "DayDeaMeRaA01S00V03 Min at start Value"

summ DayDeaLoRaA01S00V03 if date < DayDeaMeRaA01S00V03P0D

gen DayDeaLoRaA01S00V03P7V = r(min)

label var DayDeaLoRaA01S00V03P7V "DayDeaLoRaA01S00V03 Min at start Value"

summ DayDeaUpRaA01S00V03 if date < DayDeaMeRaA01S00V03P0D

gen DayDeaUpRaA01S00V03P7V = r(min)

label var DayDeaUpRaA01S00V03P7V "DayDeaUpRaA01S00V03 Min at start Value"



* lowest point at the end start (P8)

summ DayDeaMeRaA01S00V03 if date > DayDeaMeRaA01S00V03P0D

gen DayDeaMeRaA01S00V03P8V = r(min)

label var DayDeaMeRaA01S00V03P8V "DayDeaMeRaA01S00V03 Min at end Value"

summ DayDeaLoRaA01S00V03 if date > DayDeaMeRaA01S00V03P0D

gen DayDeaLoRaA01S00V03P8V = r(min)

label var DayDeaLoRaA01S00V03P8V "DayDeaLoRaA01S00V03 Min at end Value"

summ DayDeaUpRaA01S00V03 if date > DayDeaMeRaA01S00V03P0D

gen DayDeaUpRaA01S00V03P8V = r(min)

label var DayDeaUpRaA01S00V03P8V "DayDeaUpRaA01S00V03 Min at end Value"




*************************************************

* Locate peak dates and values - cases 



* one peak 

summ DayCasMeRaA01S00V03 

gen DayCasMeRaA01S00V03P0V = r(max)

summ date if DayCasMeRaA01S00V03 == DayCasMeRaA01S00V03P0V 

gen DayCasMeRaA01S00V03P0D = r(max)

summ DayCasLoRaA01S00V03 if date == DayCasMeRaA01S00V03P0D

gen DayCasLoRaA01S00V03P0V = r(max)  

summ DayCasUpRaA01S00V03 if date == DayCasMeRaA01S00V03P0D

gen DayCasUpRaA01S00V03P0V = r(max)  

label var DayCasMeRaA01S00V03P0V "DayCasMeRaA01S00V03 Peak 0 Value"
label var DayCasMeRaA01S00V03P0D "DayCasMeRaA01S00V03 Peak 0 Date"
label var DayCasLoRaA01S00V03P0V "DayCasLoRaA01S00V03 Peak 0 Value"
label var DayCasUpRaA01S00V03P0V "DayCasUpRaA01S00V03 Peak 0 Value"
format DayCasMeRaA01S00V03P0D %tdDDMonCCYY


* lowest point in start (P7)

summ DayCasMeRaA01S00V03 if date < DayCasMeRaA01S00V03P0D

gen DayCasMeRaA01S00V03P7V = r(min)

label var DayCasMeRaA01S00V03P7V "DayCasMeRaA01S00V03 Min at start Value"

summ DayCasLoRaA01S00V03 if date < DayCasMeRaA01S00V03P0D

gen DayCasLoRaA01S00V03P7V = r(min)

label var DayCasLoRaA01S00V03P7V "DayCasLoRaA01S00V03 Min at start Value"

summ DayCasUpRaA01S00V03 if date < DayCasMeRaA01S00V03P0D

gen DayCasUpRaA01S00V03P7V = r(min)

label var DayCasUpRaA01S00V03P7V "DayCasUpRaA01S00V03 Min at start Value"



* lowest point at the end start (P8)

summ date if DayCasMeRaA01S00V03 != . 

gen A01DZ = r(max)

label var A01DZ "A01 End date"

summ DayCasMeRaA01S00V03 if date > DayCasMeRaA01S00V03P0D

gen DayCasMeRaA01S00V03P8V = r(min)

label var DayCasMeRaA01S00V03P8V "DayCasMeRaA01S00V03 Min at end Value"

summ DayCasLoRaA01S00V03 if date > DayCasMeRaA01S00V03P0D

gen DayCasLoRaA01S00V03P8V = r(min)

label var DayCasLoRaA01S00V03P8V "DayCasLoRaA01S00V03 Min at end Value"

summ DayCasUpRaA01S00V03 if date > DayCasMeRaA01S00V03P0D

gen DayCasUpRaA01S00V03P8V = r(min)

label var DayCasUpRaA01S00V03P8V "DayCasUpRaA01S00V03 Min at end Value"


sort date

compress

save "Iran DELP.dta", replace



********************

* tab the peaks


use "Iran DELP.dta", clear 


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


save "Iran DELP peaks.dta", replace

export delimite using "Iran DELP peaks.csv", replace 










view "log Iran DELP.smcl"

log close

exit, clear




