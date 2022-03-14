
clear all

cd "$pathCovidVisualizedCountry"

cd merge

capture log close

log using "log CovidVisualizedCountry merge.smcl", replace


***************************************************************************
* This is "do CovidVisualizedCountry merge.do"

* Project: Combine and visualize interNational periodically updating 
* estimates of COVID-19 at the country level (CovidVisualizedCountry)
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dotcom
* Time (initial): 2021-04-14
***************************************************************************




/* studies / models:
JOHN
DELP 
IHME
IMPE
LANL // The LANL COVID-19 Team made its last real-time forecast on September 27th, 2021. [for 20210926]. This is more than two weeks old and will not be used. 
SRIV

*/


clear

* JOHN

if regexm(c(os),"Mac") == 1 {

	use "$pathCovidVisualizedCountry/JOHN/CovidVisualizedCountry JOHN.dta", clear 
}
else if regexm(c(os),"Windows") == 1 use "$pathCovidVisualizedCountry\JOHN\CovidVisualizedCountry JOHN.dta", clear 



* DELP 

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date provincestate using "$pathCovidVisualizedCountry/DELP/CovidVisualizedCountry DELP.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathCovidVisualizedCountry\DELP\CovidVisualizedCountry DELP.dta"

drop _merge



* IHME

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date provincestate using "$pathCovidVisualizedCountry/IHME/CovidVisualizedCountry IHME.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathCovidVisualizedCountry\IHME\CovidVisualizedCountry IHME.dta"

drop _merge



* IMPE

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date provincestate using "$pathCovidVisualizedCountry/IMPE/CovidVisualizedCountry IMPE.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathCovidVisualizedCountry\IMPE\CovidVisualizedCountry IMPE.dta"

drop _merge



/* LANL

if regexm(c(os),"Mac") == 1 {

	merge 1:1 date provincestate using "$pathCovidVisualizedCountry/LANL/CovidVisualizedCountry LANL.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathCovidVisualizedCountry\LANL\CovidVisualizedCountry LANL.dta"

drop _merge */


* SRIV



if regexm(c(os),"Mac") == 1 {

	merge 1:1 date provincestate using "$pathCovidVisualizedCountry/SRIV/CovidVisualizedCountry SRIV.dta"
}
else if regexm(c(os),"Windows") == 1 merge 1:1 date using "$pathCovidVisualizedCountry\SRIV\CovidVisualizedCountry SRIV.dta"

drop _merge



* 

label var loc_grand_name "Location"

label var provincestate "Province"

label var date "date"




*************************************


* Cases or infections to deaths ratio


gen DayCTDMeRaA00S00 =  DayCasMeRaA00S00 / DayDeaMeRaA00S00

label var DayCTDMeRaA00S00  "Daily Cases to Deaths S0 JOHN"

gen TotCTDMeRaA00S00 =  TotCasMeRaA00S00 / TotDeaMeRaA00S00

label var TotCTDMeRaA00S00  "Total Cases to Deaths S0 JOHN"




gen DayCTDMeRaA01S00 =  DayCasMeRaA01S00 / DayDeaMeRaA01S00

label var DayCTDMeRaA01S00  "Daily Cases to Deaths S0 DELP"

gen TotCTDMeRaA01S00 =  TotCasMeRaA01S00 / TotDeaMeRaA01S00

label var TotCTDMeRaA01S00  "Total Cases to Deaths S0 DELP"  



gen DayITDMeSmA02S01  =  DayINFMeSmA02S01  / DayDeaMeSmA02S01 

label var DayITDMeSmA02S01   "Daily infections to Deaths S1 IHME"

gen TotITDMeSmA02S01  =  TotINFMeSmA02S01  / TotDeaMeSmA02S01 

label var TotITDMeSmA02S01   "Total infections to Deaths S1 IHME"




gen DayITDMeSmA02S02 = DayINFMeSmA02S02 / DayDeaMeSmA02S02  

label var DayITDMeSmA02S02 "Daily infections to Deaths S2 IHME"

gen TotITDMeSmA02S02 = TotINFMeSmA02S02 / TotDeaMeSmA02S02  

label var TotITDMeSmA02S02 "Total infections to Deaths S2 IHME"




gen DayITDMeSmA02S03  = DayINFMeSmA02S03  / DayDeaMeSmA02S03   

label var DayITDMeSmA02S03  "Daily infections to Deaths S3 IHME"

gen TotITDMeSmA02S03  = TotINFMeSmA02S03  / TotDeaMeSmA02S03   

label var TotITDMeSmA02S03  "Total infections to Deaths S3 IHME"




gen DayITDMeRaA03S01  = DayINFMeRaA03S01  / DayDeaMeRaA03S01   

label var DayITDMeRaA03S01  "Daily infections to Deaths S1 IMPE"

gen TotITDMeRaA03S01  = TotINFMeRaA03S01  / TotDeaMeRaA03S01   

label var TotITDMeRaA03S01  "Total infections to Deaths S1 IMPE"




gen DayITDMeRaA03S02  = DayINFMeRaA03S02  / DayDeaMeRaA03S02   

label var DayITDMeRaA03S02  "Daily infections to Deaths S2 IMPE"

gen TotITDMeRaA03S02  = TotINFMeRaA03S02  / TotDeaMeRaA03S02   

label var TotITDMeRaA03S02  "Total infections to Deaths S2 IMPE"




gen DayITDMeRaA03S03  = DayINFMeRaA03S03  / DayDeaMeRaA03S03   

label var DayITDMeRaA03S03  "Daily infections to Deaths S3 IMPE"

gen TotITDMeRaA03S03  = TotINFMeRaA03S03  / TotDeaMeRaA03S03   

label var TotITDMeRaA03S03  "Total infections to Deaths S3 IMPE"



gen DayCTDMeRaA05S00  = DayCasMeRaA05S00  / DayDeaMeRaA05S00   

label var DayCTDMeRaA05S00  "Daily Cases to Deaths S0 SRIV"

gen TotCTDMeRaA05S00  = TotCasMeRaA05S00  / TotDeaMeRaA05S00   

label var TotCTDMeRaA05S00  "Total Cases to Deaths S0 SRIV"









*************************************


* Estimated infections to reported cases ratio, IHME and IMPE



gen DayITCMeSmA02S01XXX =  DayINFMeSmA02S01XXX / DayCasMeRaA00S00

label var DayITCMeSmA02S01XXX  "Daily Infections IHME to cases JOHN National"


gen DayITCMeSmA02S01XAB =  DayINFMeSmA02S01XAB / DayCasMeRaA00S00

label var DayITCMeSmA02S01XAB  "Daily Infections IHME to cases JOHN Alberta"


gen DayITCMeSmA02S01XBC =  DayINFMeSmA02S01XBC / DayCasMeRaA00S00

label var DayITCMeSmA02S01XBC  "Daily Infections IHME to cases JOHN British Columbia"


gen DayITCMeSmA02S01XMB =  DayINFMeSmA02S01XMB / DayCasMeRaA00S00

label var DayITCMeSmA02S01XMB  "Daily Infections IHME to cases JOHN Manitoba"


gen DayITCMeSmA02S01XNS =  DayINFMeSmA02S01XNS / DayCasMeRaA00S00

label var DayITCMeSmA02S01XNS  "Daily Infections IHME to cases JOHN Nova Scotia"


gen DayITCMeSmA02S01XON =  DayINFMeSmA02S01XON / DayCasMeRaA00S00

label var DayITCMeSmA02S01XON  "Daily Infections IHME to cases JOHN Ontario"


gen DayITCMeSmA02S01XQC =  DayINFMeSmA02S01XQC / DayCasMeRaA00S00

label var DayITCMeSmA02S01XQC  "Daily Infections IHME to cases JOHN Quebec"


gen DayITCMeSmA02S01XSK =  DayINFMeSmA02S01XSK / DayCasMeRaA00S00

label var DayITCMeSmA02S01XSK  "Daily Infections IHME to cases JOHN Saskatchewan"



gen DayITCMeRaA03S02 =  DayINFMeRaA03S02 / DayCasMeRaA00S00

label var DayITCMeRaA03S02  "Daily Infections IMPE to cases JOHN National"
          



* smooth Infections to cases ratio of IHME and IMPE

encode provincestate, gen(provincestate_encoded)

tsset provincestate_encoded date, daily   


foreach var of varlist ///
DayITCMeSmA02S01XXX DayITCMeSmA02S01XAB DayITCMeSmA02S01XBC DayITCMeSmA02S01XMB ///
DayITCMeSmA02S01XNS DayITCMeSmA02S01XON DayITCMeSmA02S01XQC DayITCMeSmA02S01XSK ///
DayITCMeRaA03S02 {


tssmooth ma `var'_window = `var', window(3 1 3)

tssmooth ma `var'sm = `var'_window, weights( 1 2 3 <4> 3 2 1) replace

drop `var'_window

}
*
drop provincestate_encoded

tsset, clear

ssc install labutil2

labvars DayITCMeSmA02S01XXXsm DayITCMeSmA02S01XABsm DayITCMeSmA02S01XBCsm DayITCMeSmA02S01XMBsm ///
DayITCMeSmA02S01XNSsm DayITCMeSmA02S01XONsm DayITCMeSmA02S01XQCsm DayITCMeSmA02S01XSKsm ///
DayITCMeRaA03S02sm ,names

***********************

* daily deaths estimated to reported  

    
gen DayDERMeRaA00S00 = DayDeaMeRaA00S00 / DayDeaMeRaA00S00

label var DayDERMeRaA00S00 "Daily Deaths estim to reported JOHN = 1" 


gen DayDERMeRaA01S00 = DayDeaMeRaA01S00 / DayDeaMeRaA00S00

label var DayDERMeRaA01S00 "Daily Deaths estim to reported Mean DELP S0"


gen DayDERMeSmA02S01 = DayDeaMeSmA02S01 / DayDeaMeRaA00S00

label var DayDERMeSmA02S01 "Daily Deaths estim to reported Mean not smoothed IHME S1"


gen DayDERMeSmA02S02 = DayDeaMeSmA02S02 / DayDeaMeRaA00S00

label var DayDERMeSmA02S02 "Daily Deaths estim to reported Mean not smoothed IHME S2"


gen DayDERMeSmA02S03 = DayDeaMeSmA02S03 / DayDeaMeRaA00S00

label var DayDERMeSmA02S03 "Daily Deaths estim to reported Mean not smoothed IHME S3"


gen DayDERMeRaA03S01 = DayDeaMeRaA03S01 / DayDeaMeRaA00S00

label var DayDERMeRaA03S01 "Daily Deaths estim to reported Mean S1 IMPE"


gen DayDERMeRaA03S02 = DayDeaMeRaA03S02 / DayDeaMeRaA00S00

label var DayDERMeRaA03S02 "Daily Deaths estim to reported Mean S2 IMPE"


gen DayDERMeRaA03S03 = DayDeaMeRaA03S03 / DayDeaMeRaA00S00

label var DayDERMeRaA03S03 "Daily Deaths estim to reported Mean S3 IMPE"


gen DayDERMeRaA05S00  = DayDeaMeRaA05S00 / DayDeaMeRaA00S00

label var DayDERMeRaA05S00 "Daily Deaths estim to reported S0 SRIV"






* daily cases or infections estimated to reported  


gen DayCERMeRaA00S00 = DayCasMeRaA00S00 / DayCasMeRaA00S00

label var DayCERMeRaA00S00 "Daily Cases estim to reported JOHN = 1" 


gen DayCERMeRaA01S00 = DayCasMeRaA01S00 / DayCasMeRaA00S00

label var DayCERMeRaA01S00 "Daily Cases estim to reported Mean DELP S0"


gen DayIERMeSmA02S01 = DayINFMeSmA02S01 / DayCasMeRaA00S00

label var DayIERMeSmA02S01 "Daily infections estim to reported cases Mean not smoothed IHME S1"


gen DayIERMeSmA02S02 = DayINFMeSmA02S02 / DayCasMeRaA00S00

label var DayIERMeSmA02S02 "Daily infections estim to reported cases Mean not smoothed IHME S2"


gen DayIERMeSmA02S03 = DayINFMeSmA02S03 / DayCasMeRaA00S00

label var DayIERMeSmA02S03 "Daily infections estim to reported cases Mean not smoothed IHME S3"


gen DayIERMeRaA03S01 = DayINFMeRaA03S01 / DayCasMeRaA00S00

label var DayIERMeRaA03S01 "Daily infections estim to reported cases Mean S1 IMPE"


gen DayIERMeRaA03S02 = DayINFMeRaA03S02 / DayCasMeRaA00S00

label var DayIERMeRaA03S02 "Daily infections estim to reported cases Mean S2 IMPE"


gen DayIERMeRaA03S03 = DayINFMeRaA03S03 / DayCasMeRaA00S00

label var DayIERMeRaA03S03 "Daily infections estim to reported cases Mean S3 IMPE"


gen DayCERMeRaA05S00  = DayCasMeRaA05S00 / DayCasMeRaA00S00

label var DayCERMeRaA05S00 "Daily Cases estim to reported S0 SRIV"





* Total deaths estimated to reported  


gen TotDERMeRaA00S00 = TotDeaMeRaA00S00 / TotDeaMeRaA00S00

label var TotDERMeRaA00S00 "Total Deaths estim to reported JOHN = 1" 


gen TotDERMeRaA01S00 = TotDeaMeRaA01S00 / TotDeaMeRaA00S00

label var TotDERMeRaA01S00 "Total Deaths estim to reported Mean DELP S0"


gen TotDERMeSmA02S01 = TotDeaMeSmA02S01 / TotDeaMeRaA00S00

label var TotDERMeSmA02S01 "Total Deaths estim to reported Mean not smoothed IHME S1"


gen TotDERMeSmA02S02 = TotDeaMeSmA02S02 / TotDeaMeRaA00S00

label var TotDERMeSmA02S02 "Total Deaths estim to reported Mean not smoothed IHME S2"


gen TotDERMeSmA02S03 = TotDeaMeSmA02S03 / TotDeaMeRaA00S00

label var TotDERMeSmA02S03 "Total Deaths estim to reported Mean not smoothed IHME S3"


gen TotDERMeRaA03S01 = TotDeaMeRaA03S01 / TotDeaMeRaA00S00

label var TotDERMeRaA03S01 "Total Deaths estim to reported Mean S1 IMPE"


gen TotDERMeRaA03S02 = TotDeaMeRaA03S02 / TotDeaMeRaA00S00

label var TotDERMeRaA03S02 "Total Deaths estim to reported Mean S2 IMPE"


gen TotDERMeRaA03S03 = TotDeaMeRaA03S03 / TotDeaMeRaA00S00

label var TotDERMeRaA03S03 "Total Deaths estim to reported Mean S3 IMPE"


gen TotDERMeRaA05S00  = TotDeaMeRaA05S00 / TotDeaMeRaA00S00

label var TotDERMeRaA05S00 "Total Deaths estim to reported S0 SRIV"






* Total cases or infections estimated to reported  


gen TotCERMeRaA00S00 = TotCasMeRaA00S00 / TotCasMeRaA00S00

label var TotCERMeRaA00S00 "Total Cases estim to reported JOHN = 1" 


gen TotCERMeRaA01S00 = TotCasMeRaA01S00 / TotCasMeRaA00S00

label var TotCERMeRaA01S00 "Total Cases estim to reported Mean DELP S0"


gen TotIERMeSmA02S01 = TotINFMeSmA02S01 / TotCasMeRaA00S00

label var TotIERMeSmA02S01 "Total infections estim to reported cases Mean not smoothed IHME S1"


gen TotIERMeSmA02S02 = TotINFMeSmA02S02 / TotCasMeRaA00S00

label var TotIERMeSmA02S02 "Total infections estim to reported cases Mean not smoothed IHME S2"


gen TotIERMeSmA02S03 = TotINFMeSmA02S03 / TotCasMeRaA00S00

label var TotIERMeSmA02S03 "Total infections estim to reported cases Mean not smoothed IHME S3"


gen TotIERMeRaA03S01 = TotINFMeRaA03S01 / TotCasMeRaA00S00

label var TotIERMeRaA03S01 "Total infections estim to reported cases Mean S1 IMPE"


gen TotIERMeRaA03S02 = TotINFMeRaA03S02 / TotCasMeRaA00S00

label var TotIERMeRaA03S02 "Total infections estim to reported cases Mean S2 IMPE"


gen TotIERMeRaA03S03 = TotINFMeRaA03S03 / TotCasMeRaA00S00

label var TotIERMeRaA03S03 "Total infections estim to reported cases Mean S3 IMPE"


gen TotCERMeRaA05S00  = TotCasMeRaA05S00 / TotCasMeRaA00S00

label var TotCERMeRaA05S00 "Total Cases estim to reported S0 SRIV"


*


* gen provincestate without locations least attected

gen provincestate_mostaffected = provincestate

replace provincestate_mostaffected = "" if provincestate_mostaffected == "New Brunswick"

replace provincestate_mostaffected = "" if provincestate_mostaffected == "Newfoundland and Labrador"

replace provincestate_mostaffected = "" if provincestate_mostaffected == "Northwest Territories"

replace provincestate_mostaffected = "" if provincestate_mostaffected == "Nunavut"

replace provincestate_mostaffected = "" if provincestate_mostaffected == "Prince Edward Island"

replace provincestate_mostaffected = "" if provincestate_mostaffected == "Yukon"

replace provincestate_mostaffected = "" if provincestate_mostaffected == " National"



 
*

sort date

save "CovidVisualizedCountry merge.dta", replace


*


* gen calendar file


clear

di td(01jan2020) // 21915

di td(01jan2022) // 22646

di td(01jan2022) - td(01jan2020) // 731 + 1 = 732



set obs 732

gen date = .

replace date = 21915 in 1

replace date = date[_n-1] + 1 in 2/l

replace date = date[_n-1] + 1 in 2/732

format date %tdDDMonCCYY

codebook date


merge m:m date using "CovidVisualizedCountry merge.dta"

replace loc_grand_name = "$country"

sort loc_grand_name provincestate date

isid loc_grand_name provincestate date, missok

drop _merge



qui compress


save "CovidVisualizedCountry merge.dta", replace




*

di in red "********* Description of vars in this final file named CovidVisualizedCountry merge.dta *********" 


desc, fullnames
 

 
 
 
 
 
 
 
**********

* gen monthspast vars for #thicknumber of graphs


summ date

gen mergemaxdate = r(max)


gen monthspast01jan2020merge = ((mergemaxdate - td(01jan2020)) / 30) + 1

replace monthspast01jan2020merge = round(monthspast01jan2020merge)

global monthspast01jan2020merge = monthspast01jan2020merge

di $monthspast01jan2020merge



gen monthspast01jan2021merge = ((mergemaxdate - td(01jan2021)) / 30) + 1

replace monthspast01jan2021merge = round(monthspast01jan2021merge)

global monthspast01jan2021merge = monthspast01jan2021merge

di $monthspast01jan2021merge



gen monthspast01jan2022merge = ((mergemaxdate - td(01jan2022)) / 30) + 1

replace monthspast01jan2022merge = round(monthspast01jan2022merge)

global monthspast01jan2022merge = monthspast01jan2022merge

di $monthspast01jan2022merge





******************

* gen monthspast vars for #thicknumber of graphs -- JOHN

gen monthspast01jan2020JOHN = monthspast01jan2020merge - 2
global monthspast01jan2020JOHN = monthspast01jan2020JOHN

gen monthspast01jan2021JOHN = monthspast01jan2021merge - 2
global monthspast01jan2021JOHN = monthspast01jan2021JOHN

gen monthspast01jan2022JOHN = monthspast01jan2022merge - 2
global monthspast01jan2022JOHN = monthspast01jan2022JOHN



 
 
 

 
***************

***************

* graphs 


grstyle init

grstyle color background white




*****************

* daily deaths (graph numbers start with 11)



****
* daily deaths, reference scenarios, all time, National

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 4 "IHME"
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lwidth(medthick)) /// 5 "IHME excess"
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 6 "IMPE"
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 7 "SRIV"
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "DELP" 4 "IHME" 5 "IHME excess" 6 "IMPE" 7 "SRIV") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) 

qui graph export "CAN1 11aDayDeaMERGnat alltime - COVID-19 daily deaths, $country, National, reference scenarios, all time.pdf", replace



****
* daily deaths, reference scenarios, all time, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA01S00 date, sort lcolor(red*0.3) lwidth(medium) lpattern(tight_dot)) /// 3 "DELP raw"
(line DayDeaMeSmA01S00 date, sort lcolor(red) lwidth(medthick)) /// 4 "DELP smooth"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 5 "IHME"
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lwidth(medthick)) /// 6 "IHME excess"
if date >= td(01jan2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "DELP raw" 4 "DELP smooth" 5 "IHME" 6 "IHME excess") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) 

qui graph export "SUB1 11bDayDeaMERGsub alltime `l' - COVID-19 daily deaths, $country, `l', reference scenarios, all time.pdf", replace

}
*


****
* daily deaths, reference scenarios, all time, by provinces only predicted in DELP: New Brunswick

twoway ///
(line DayDeaMeRaA00S00XNB date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00XNB date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA01S00XNB date, sort lcolor(red*0.3) lwidth(medium) lpattern(tight_dot)) /// 3 "DELP raw"
(line DayDeaMeSmA01S00XNB date, sort lcolor(red) lwidth(medthick)) /// 4 "DELP smooth"
if date >= td(01jan2020) & provincestate == "New Brunswick" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, New Brunswick", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "DELP raw" 4 "DELP smooth") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) 

qui graph export "SUB1b 11bDayDeaMERGsub alltime New Brunswick - COVID-19 daily deaths, $country, New Brunswick, reference scenarios, all time.pdf", replace

*



* daily deaths, reference scenarios, all time, by provinces only predicted in DELP: Newfoundland and Labrador

twoway ///
(line DayDeaMeRaA00S00XNL date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00XNL date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA01S00XNL date, sort lcolor(red*0.3) lwidth(medium) lpattern(tight_dot)) /// 3 "DELP raw"
(line DayDeaMeSmA01S00XNL date, sort lcolor(red) lwidth(medthick)) /// 4 "DELP smooth"
if date >= td(01jan2020) & provincestate == "Newfoundland and Labrador" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, Newfoundland and Labrador", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "DELP raw" 4 "DELP smooth") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) 

qui graph export "SUB1c 11bDayDeaMERGsub alltime Newfoundland and Labrador - COVID-19 daily deaths, $country, Newfoundland and Labrador, reference scenarios, all time.pdf", replace

*




****
* daily deaths, reference scenarios, 2021, National

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 4 "IHME"
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lwidth(medthick)) /// 5 "IHME excess"
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 6 "IMPE"
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 7 "SRIV"
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "DELP" 4 "IHME" 5 "IHME excess" 6 "IMPE" 7 "SRIV") size(small) row(2)) ///
subtitle("reference scenarios, after 2021-01-01", size(small))

qui graph export "CAN2 12aDayDeaMERGnat 2021 - COVID-19 daily deaths, $country, National, reference scenarios, 2021.pdf", replace





****
* daily deaths, reference scenarios, 2021, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA01S00 date, sort lcolor(red*0.3) lwidth(medium) lpattern(tight_dot)) /// 3 "DELP raw"
(line DayDeaMeSmA01S00 date, sort lcolor(red) lwidth(medthick)) /// 4 "DELP smooth"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 5 "IHME"
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lwidth(medthick)) /// 6 "IHME excess"
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "DELP raw" 4 "DELP smooth" 5 "IHME" 6 "IHME excess") size(small) row(2)) ///
subtitle("reference scenarios, after 2021-01-01", size(small))

qui graph export "SUB2 12bDayDeaMERGsub 2021 `l' - COVID-19 daily deaths, $country, `l', reference scenarios, 2021.pdf", replace

}
*





****
* daily deaths, reference scenarios, 2021, uncertainty, National

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 3 "DELP" mean
(line DayDeaLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" lower
(line DayDeaUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 5 "DELP" upper
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 6 IHME mean
(line DayDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME lower
(line DayDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 8 IHME upper
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 9 IMPE mean
(line DayDeaLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE lower
(line DayDeaUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 11 IMPE upper
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 12 "SRIV" mean
(line DayDeaLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 13 "SRIV" lower
(line DayDeaUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 14 "SRIV" upper
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "DELP" 6 "IHME" 9 "IMPE" 12 "SRIV") size(small) row(2)) ///
subtitle("reference scenarios, after 2021-01-01, with uncertainty", size(small)) ///
note("Uncertainty limits: dashed curves") 

qui graph export "13a1DayDeaMERGnat CI 2021 - COVID-19 daily deaths, $country, National, reference scenarios, 2021, uncertainty.pdf", replace





****
* daily deaths, reference scenarios, 2021, uncertainty, National, with IHME excess

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 3 "DELP" mean
(line DayDeaLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP" lower
(line DayDeaUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 5 "DELP" upper
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 6 IHME mean
(line DayDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME lower
(line DayDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 8 IHME upper
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lwidth(medthick)) /// 9 IHME excess mean
(line DayDeXLoSmA02S01 date, sort lcolor(brown) lwidth(medthick) lpattern(dash)) /// 10 IHME excess lower
(line DayDeXUpSmA02S01 date, sort lcolor(brown) lwidth(medthick) lpattern(dash)) /// 11 IHME excess upper
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 12 IMPE mean
(line DayDeaLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 13 IMPE lower
(line DayDeaUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 14 IMPE upper
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 15 "SRIV" mean
(line DayDeaLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 16 "SRIV" lower
(line DayDeaUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 17 "SRIV" upper
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "DELP" 6 "IHME" 9 "IHME excess" 12 "IMPE" 15 "SRIV") size(small) row(2)) ///
subtitle("reference scenarios, after 2021-01-01, with uncertainty", size(small)) ///
note("Uncertainty limits: dashed curves") 

qui graph export "13a2DayDeaMERGnat CI 2021 - COVID-19 daily deaths, $country, National, reference scenarios, 2021, uncertainty.pdf", replace






****
* daily deaths, reference scenarios, 2021, uncertainty, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA01S00 date, sort lcolor(red*0.2) lwidth(medium) lpattern(tight_dot)) /// 3 "DELP mean raw"
(line DayDeaMeSmA01S00 date, sort lcolor(red) lwidth(medthick)) /// 4 "DELP mean smooth"
(line DayDeaLoSmA01S00 date, sort lcolor(red) lpattern(dash)) /// 5 "DELP" lower
(line DayDeaUpSmA01S00 date, sort lcolor(red) lpattern(dash)) /// 6 "DELP" upper
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 7 IHME mean
(line DayDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 8 IHME lower
(line DayDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 9 IHME upper
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "DELP mean raw" 4 "DELP mean smooth" 7 "IHME mean") size(small) row(2)) ///
subtitle("reference scenarios, after 2021-01-01, with uncertainty", size(small)) ///
note("Uncertainty limits: dashed curves") 

qui graph export "13b1DayDeaMERGsub CI 2021 `l' - COVID-19 daily deaths, $country, `l', reference scenarios, 2021, uncertainty.pdf", replace

}
*






****
* daily deaths, reference scenarios, 2021, uncertainty, by province, with IHME excess

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA01S00 date, sort lcolor(red*0.2) lwidth(medium) lpattern(tight_dot)) /// 3 "DELP mean raw"
(line DayDeaMeSmA01S00 date, sort lcolor(red) lwidth(medthick)) /// 4 "DELP mean smooth"
(line DayDeaLoSmA01S00 date, sort lcolor(red) lpattern(dash)) /// 5 "DELP" lower
(line DayDeaUpSmA01S00 date, sort lcolor(red) lpattern(dash)) /// 6 "DELP" upper
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 7 IHME mean
(line DayDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 8 IHME lower
(line DayDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 9 IHME upper
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lwidth(medthick)) /// 10 IHME excess mean
(line DayDeXLoSmA02S01 date, sort lcolor(brown) lwidth(medthick) lpattern(dash)) /// 11 IHME excess lower
(line DayDeXUpSmA02S01 date, sort lcolor(brown) lwidth(medthick) lpattern(dash)) /// 12 IHME excess upper
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "DELP mean raw" 4 "DELP mean smooth" 7 "IHME mean" 10 "IHME excess mean") size(small) row(2)) ///
subtitle("reference scenarios, after 2021-01-01, with uncertainty", size(small)) ///
note("Uncertainty limits: dashed curves") 

qui graph export "13b2DayDeaMERGsub CI 2021 `l' - COVID-19 daily deaths, $country, `l', reference scenarios, 2021, uncertainty.pdf", replace

}
*






****
* daily deaths, 3 scenarios, 2021, National

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 IHME mean, reference scenario
(line DayDeaMeSmA02S02 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 4 IHME mean, better scenario
(line DayDeaMeSmA02S03 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 5 IHME mean, worse scenario
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 6 IMPE mean, reference scenario
(line DayDeaMeRaA03S01 date, sort lcolor(magenta) lwidth(thick) lpattern(tight_dot)) /// 7 IMPE mean, better scenario
(line DayDeaMeRaA03S03 date, sort lcolor(magenta) lwidth(thick) lpattern(tight_dot)) /// 8 IMPE mean, worse scenario
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IHME" 6 "IMPE") size(small) row(1)) ///
subtitle("IHME AND IMPE 3 scenarios, after 2021-01-01", size(small)) ///
note("Better and worse scenarios: tight dot (|||||) curves; IHME and IMPE") 

qui graph export "CAN3 14a1DayDeaMERGnat 2021 3 scenarios - COVID-19 daily deaths, $country, National, 3 scenarios, 2021.pdf", replace





****
* daily deaths, 3 scenarios, 2021, National, with IHME excess

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 IHME mean, reference scenario
(line DayDeaMeSmA02S02 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 4 IHME mean, better scenario
(line DayDeaMeSmA02S03 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 5 IHME mean, worse scenario
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lwidth(medthick)) /// 6 IHME excess mean, reference scenario
(line DayDeXMeSmA02S02 date, sort lcolor(brown) lwidth(thick) lpattern(tight_dot)) /// 7 IHME excess mean, better scenario
(line DayDeXMeSmA02S03 date, sort lcolor(brown) lwidth(thick) lpattern(tight_dot)) /// 8 IHME excess mean, worse scenario
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 9 IMPE mean, reference scenario
(line DayDeaMeRaA03S01 date, sort lcolor(magenta) lwidth(thick) lpattern(tight_dot)) /// 10 IMPE mean, better scenario
(line DayDeaMeRaA03S03 date, sort lcolor(magenta) lwidth(thick) lpattern(tight_dot)) /// 11 IMPE mean, worse scenario
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IHME" 6 "IHME excess" 9 "IMPE") size(small) row(1)) ///
subtitle("IHME AND IMPE 3 scenarios, after 2021-01-01", size(small)) ///
note("Better and worse scenarios: tight dot (|||||) curves; IHME and IMPE") 

qui graph export "CAN3 14a2DayDeaMERGnat 2021 3 scenarios - COVID-19 daily deaths, $country, National, 3 scenarios, 2021.pdf", replace



****
* daily deaths, 3 scenarios, 2021, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 IHME mean, reference scenario
(line DayDeaMeSmA02S02 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 4 IHME mean, better scenario
(line DayDeaMeSmA02S03 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 5 IHME mean, worse scenario
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IHME") size(small) row(1)) ///
subtitle("IHME 3 scenarios, after 2021-01-01", size(small)) ///
note("Better and worse scenarios: tight dot (|||||) curves; IHME") 

qui graph export "SUB3 14b1DayDeaMERGsub 2021 3 scenarios `l' - COVID-19 daily deaths, $country, `l', 3 scenarios, 2021.pdf", replace

}
*





****
* daily deaths, 3 scenarios, 2021, by province, with IHME excess

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 IHME mean, reference scenario
(line DayDeaMeSmA02S02 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 4 IHME mean, better scenario
(line DayDeaMeSmA02S03 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 5 IHME mean, worse scenario
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lwidth(medthick)) /// 6 IHME excess mean, reference scenario
(line DayDeXMeSmA02S02 date, sort lcolor(brown) lwidth(thick) lpattern(tight_dot)) /// 7 IHME excess mean, better scenario
(line DayDeXMeSmA02S03 date, sort lcolor(brown) lwidth(thick) lpattern(tight_dot)) /// 8 IHME excess mean, worse scenario
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IHME" 6 "IHME excess") size(small) row(1)) ///
subtitle("IHME 3 scenarios, after 2021-01-01", size(small)) ///
note("Better and worse scenarios: tight dot (|||||) curves; IHME") 

qui graph export "SUB3 14b2DayDeaMERGsub 2021 3 scenarios `l' - COVID-19 daily deaths, $country, `l', 3 scenarios, 2021.pdf", replace

}
*




****
* daily deaths, reference scenario, uncertainty, 2021, IHME, National 

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 IHME reference mean
(line DayDeaLoSmA02S01 date, sort lcolor(green) lpattern(dash)) /// 4 IHME reference lower
(line DayDeaUpSmA02S01 date, sort lcolor(red) lpattern(dash)) /// 5 IHME reference upper
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IHME mean" 4 "IHME lower" ///
5 "IHME upper") size(small) row(2)) ///
subtitle("IHME reference scenario, with uncertainty, after 2021-01-01", size(small)) ///
note("Uncertainty limits: dashed (– – –) curves")

qui graph export "15a1DayDeaMERGnat 2021 IHME ref CI - COVID-19 daily deaths, $country, National, reference scenario, uncertainty, 2021, IHME.pdf", replace




****
* daily deaths, reference scenario, uncertainty, 2021, IHME, National, with IHME excess

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 IHME reference mean
(line DayDeaLoSmA02S01 date, sort lcolor(green) lpattern(dash)) /// 4 IHME reference lower
(line DayDeaUpSmA02S01 date, sort lcolor(red) lpattern(dash)) /// 5 IHME reference upper
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lwidth(medthick)) /// 6 IHME excess mean, reference scenario
(line DayDeXLoSmA02S01 date, sort lcolor(brown) lwidth(medthick) lpattern(dash)) /// 7 IHME excess lower, reference scenario
(line DayDeXUpSmA02S01 date, sort lcolor(brown) lwidth(medthick) lpattern(dash)) /// 8 IHME excess upper, reference scenario
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IHME mean" 4 "IHME lower" ///
5 "IHME upper" 6 "IHME excess mean" 7 "IHME excess lower" 8 "IHME excess upper") size(small) row(3)) ///
subtitle("IHME reference scenario, with uncertainty, after 2021-01-01", size(small)) ///
note("Uncertainty limits: dashed (– – –) curves")

qui graph export "15a2DayDeaMERGnat 2021 IHME ref CI - COVID-19 daily deaths, $country, National, reference scenario, uncertainty, 2021, IHME.pdf", replace





****
* daily deaths, reference scenario, uncertainty, 2021, IHME, by province 

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 IHME reference mean
(line DayDeaLoSmA02S01 date, sort lcolor(green) lpattern(dash)) /// 4 IHME reference lower
(line DayDeaUpSmA02S01 date, sort lcolor(red) lpattern(dash)) /// 5 IHME reference upper
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IHME mean" 4 "IHME lower" ///
5 "IHME upper") size(small) row(2)) ///
subtitle("IHME reference scenario, with uncertainty, after 2021-01-01", size(small)) ///
note("Uncertainty limits: dashed (– – –) curves")

qui graph export "15b1DayDeaMERGsub 2021 IHME ref CI `l' - COVID-19 daily deaths, $country, `l', reference scenario, uncertainty, 2021, IHME.pdf", replace

}
*




****
* daily deaths, reference scenario, uncertainty, 2021, IHME, by province, with IHME excess 

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 IHME reference mean
(line DayDeaLoSmA02S01 date, sort lcolor(green) lpattern(dash)) /// 4 IHME reference lower
(line DayDeaUpSmA02S01 date, sort lcolor(red) lpattern(dash)) /// 5 IHME reference upper
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lwidth(medthick)) /// 6 IHME excess mean, reference scenario
(line DayDeXLoSmA02S01 date, sort lcolor(brown) lwidth(medthick) lpattern(dash)) /// 7 IHME excess lower, reference scenario
(line DayDeXUpSmA02S01 date, sort lcolor(brown) lwidth(medthick) lpattern(dash)) /// 8 IHME excess upper, reference scenario
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IHME mean" 4 "IHME lower" ///
5 "IHME upper" 6 "IHME excess mean" 7 "IHME excess lower" 8 "IHME excess upper") size(small) row(3)) ///
subtitle("IHME reference scenario, with uncertainty, after 2021-01-01", size(small)) ///
note("Uncertainty limits: dashed (– – –) curves")

qui graph export "15b2DayDeaMERGsub 2021 IHME ref CI `l' - COVID-19 daily deaths, $country, `l', reference scenario, uncertainty, 2021, IHME.pdf", replace

}
*



****
* daily deaths, 3 scenarios, uncertainty, 2021, IHME, National 

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 IHME reference mean
(line DayDeaMeSmA02S02 date, sort lcolor(green) lwidth(thick) lpattern(tight_dot)) /// 4 IHME better mean
(line DayDeaMeSmA02S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 5 IHME worse mean
(line DayDeaUpSmA02S03 date, sort lcolor(red) lpattern(dash)) /// 6 IHME worse upper
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IHME reference scenario, mean" 4 "IHME better scenario, mean" ///
5 "IHME worse scenario, mean" 6 "IHME worse scenario, upper") size(small) row(3)) ///
subtitle("IHME 3 scenarios, after 2021-01-01", size(small)) ///
note("Better and worse scenarios: tight dot (|||||) curves; Uncertainty limits: dashed (– – –) curves") 

qui graph export "16a1DayDeaMERGnat 2021 IHME 3scen CI - COVID-19 daily deaths, $country, National, 3 scenarios, uncertainty, 2021, IHME.pdf", replace




****
* daily deaths, 2 scenarios, uncertainty, 2021, IHME, National, with IHME excess  

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 IHME reference mean
(line DayDeaMeSmA02S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 4 IHME worse mean
(line DayDeaUpSmA02S03 date, sort lcolor(red) lpattern(dash)) /// 5 IHME worse upper
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lwidth(medthick)) /// 6 IHME excess mean, reference scenario
(line DayDeXMeSmA02S03 date, sort lcolor(brown) lwidth(thick) lpattern(tight_dot)) /// 7 IHME excess mean, worse scenario
(line DayDeXUpSmA02S03 date, sort lcolor(brown) lwidth(medthick) lpattern(dash)) /// 8 IHME excess upper, worse scenario
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IHME reference" ///
4 "IHME worse" 5 "IHME worse, upper" ///
6 "IHME excess, reference" ///
7 "IHME excess, worse" 8 "IHME excess, worse upper") size(small) row(4)) ///
subtitle("IHME 3 scenarios, after 2021-01-01", size(small)) ///
note("Worse scenarios: tight dot (|||||) curves; Uncertainty limits: dashed (– – –) curves") 

qui graph export "16a2DayDeaMERGnat 2021 IHME 3scen CI - COVID-19 daily deaths, $country, National, 3 scenarios, uncertainty, 2021, IHME.pdf", replace




****
* daily deaths, 3 scenarios, uncertainty, 2021, IHME, by province 

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 IHME reference mean
(line DayDeaMeSmA02S02 date, sort lcolor(green) lwidth(thick) lpattern(tight_dot)) /// 4 IHME better mean
(line DayDeaMeSmA02S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 5 IHME worse mean
(line DayDeaUpSmA02S03 date, sort lcolor(red) lpattern(dash)) /// 6 IHME worse upper
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IHME reference scenario, mean" 4 "IHME better scenario, mean" ///
5 "IHME worse scenario, mean" 6 "IHME worse scenario, upper") size(small) row(3)) ///
subtitle("IHME 3 scenarios, after 2021-01-01", size(small)) ///
note("Better and worse scenarios: tight dot (|||||) curves; Uncertainty limits: dashed (– – –) curves") 

qui graph export "16b1DayDeaMERGsub 2021 IHME 3scen CI `l' - COVID-19 daily deaths, $country, `l', 3 scenarios, uncertainty, 2021, IHME.pdf", replace

}
*




****
* daily deaths, 3 scenarios, uncertainty, 2021, IHME, by province, with IHME excess  

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 IHME reference mean
(line DayDeaMeSmA02S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 4 IHME worse mean
(line DayDeaUpSmA02S03 date, sort lcolor(red) lpattern(dash)) /// 5 IHME worse upper
(line DayDeXMeSmA02S01 date, sort lcolor(brown) lwidth(medthick)) /// 6 IHME excess mean, reference scenario
(line DayDeXMeSmA02S03 date, sort lcolor(brown) lwidth(thick) lpattern(tight_dot)) /// 7 IHME excess mean, worse scenario
(line DayDeXUpSmA02S03 date, sort lcolor(brown) lwidth(medthick) lpattern(dash)) /// 8 IHME excess upper, worse scenario
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IHME reference" ///
4 "IHME worse" 5 "IHME worse, upper" ///
6 "IHME excess, reference" ///
7 "IHME excess, worse" 8 "IHME excess, worse upper") size(small) row(4)) ///
subtitle("IHME 3 scenarios, after 2021-01-01", size(small)) ///
note("Worse scenarios: tight dot (|||||) curves; Uncertainty limits: dashed (– – –) curves") 

qui graph export "16b2DayDeaMERGsub 2021 IHME 3scen CI `l' - COVID-19 daily deaths, $country, `l', 3 scenarios, uncertainty, 2021, IHME.pdf", replace

}
*





****
* daily deaths, reference scenario, uncertainty, 2021, IMPE, National 

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA03S02 date, sort lcolor(black)) /// 3 IMPE reference mean
(line DayDeaLoRaA03S02 date, sort lcolor(green) lpattern(dash)) /// 4 IMPE reference lower
(line DayDeaUpRaA03S02 date, sort lcolor(red) lpattern(dash)) /// 5 IMPE reference upper
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IMPE mean" 4 "IMPE lower" ///
5 "IMPE upper") size(small) row(2)) ///
subtitle("IMPE reference scenario, with uncertainty, after 2021-01-01", size(small)) ///
note("Uncertainty limits: dashed (– – –) curves") 

qui graph export "17a1DayDeaMERGnat 2021 IMPE ref CI - COVID-19 daily deaths, $country, National, reference scenario, uncertainty, 2021, IMPE.pdf", replace





****
* daily deaths, reference scenario, uncertainty, 2021, IMPE, by province ==> no subNational by IMPE







****
* daily deaths, 3 scenarios, uncertainty, 2021, IMPE, National 

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayDeaMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(vthick)) /// 2 "JOHN smooth"
(line DayDeaMeRaA03S02 date, sort lcolor(black)) /// 3 IMPE reference mean
(line DayDeaMeRaA03S01 date, sort lcolor(green) lwidth(thick) lpattern(tight_dot)) /// 4 IMPE better mean
(line DayDeaMeRaA03S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 5 IMPE worse mean
(line DayDeaUpRaA03S03 date, sort lcolor(red) lpattern(dash)) /// 6 IMPE worse upper
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "IMPE reference scenario, mean" 4 "IMPE better scenario, mean" ///
5 "IMPE worse scenario, mean" 6 "IMPE worse scenario, upper") size(small) row(3)) ///
subtitle("IMPE 3 scenarios, after 2021-01-01", size(small)) ///
note("Better and worse scenarios: tight dot (|||||) curves; Uncertainty limits: dashed (– – –) curves") 

qui graph export "18aDayDeaMERGnat 2021 IMPE 3sce CI - COVID-19 daily deaths, $country, National, 3 scenarios, uncertainty, 2021, IMPE.pdf", replace





****
* daily deaths, 3 scenarios, uncertainty, 2021, IMPE, by province ==> no subNational by IMPE















***********************

* Daily cases or infections (graph numbers start with 31)



****
* daily cases or infections, reference scenarios, all time, National

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 4 "IHME"
(line DayINFMeRaA03S02 date, sort lcolor(magenta)) /// 5 "IMPE"
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases raw" 2 "JOHN cases smooth" 3 "DELP cases" ///
4 "IHME infections" 5 "IMPE infections" 6 "SRIV cases") size(small) row(3)) ///
subtitle("reference scenarios", size(small)) 

qui graph export "CAN4 31aDayCasMERGnat alltime - COVID-19 daily cases, $country, National, reference scenarios.pdf", replace




****
* daily estimated infections to reported cases IHME, IMPE, all time, National

twoway ///
(line DayITCMeSmA02S01XXX date, sort lcolor(black)) /// 1 "IHME"
(line DayITCMeRaA03S02 date, sort lcolor(magenta)) /// 2 "IMPE"
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily estimated infections to reported cases) title("COVID-19 daily estimated infections to reported cases, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME" 2 "IMPE" 3) size(small) row(1)) ///
subtitle("reference scenarios", size(small)) 

qui graph export "CAN4 - 1 daily estimated infections to reported cases, $country, National, reference scenarios.pdf", replace




****
* daily estimated infections to reported cases IHME, IMPE, 2021, National

qui summ DayITCMeSmA02S01XXXsm if date >= td(01jan2021) , detail

gen DayITCMeSmA02S01XXXsm_median = r(p50)

replace DayITCMeSmA02S01XXXsm_median = round(DayITCMeSmA02S01XXXsm_median)

local DayITCMeSmA02S01XXXsm_median = DayITCMeSmA02S01XXXsm_median


qui summ DayITCMeRaA03S02sm if date >= td(01jan2021) , detail

gen DayITCMeRaA03S02sm_median = r(p50)

replace DayITCMeRaA03S02sm_median = round(DayITCMeRaA03S02sm_median)

local DayITCMeRaA03S02sm_median = DayITCMeRaA03S02sm_median

twoway ///
(line DayITCMeSmA02S01XXX date, sort lcolor(black*0.2)) /// 1 "IHME"
(line DayITCMeRaA03S02 date, sort lcolor(magenta*0.2)) /// 2 "IMPE"
(line DayITCMeSmA02S01XXXsm date, sort lcolor(black) lwidth(thick)) /// 3 "IHME"
(line DayITCMeRaA03S02sm date, sort lcolor(magenta) lwidth(thick)) /// 4 "IMPE"
(line DayITCMeSmA02S01XXXsm_median date, sort lcolor(black) lwidth(thin) lpattern(dash)) /// 5 "IHME"
(line DayITCMeRaA03S02sm_median date, sort lcolor(magenta) lwidth(thin) lpattern(dash)) /// 6 "IMPE"
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily estimated infections to reported cases) title("COVID-19 daily estimated infections to reported cases, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME" 2 "IMPE" 3 "IHME smooth" 4 "IMPE smooth" 5 "IHME smooth meadian" 6 "IMPE smooth meadian") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) ///
note("IHME smooth median in 2021 = `DayITCMeSmA02S01XXXsm_median'; IMPE smooth median in 2021 = `DayITCMeRaA03S02sm_median'")

qui graph export "CAN4 - 2 daily estimated infections to reported cases, $country, National, reference scenarios 2021.pdf", replace



****
* daily estimated infections to reported cases IHME, 2021, provinces

* Alberta

qui summ DayITCMeSmA02S01XABsm if date >= td(01jan2021) , detail

gen DayITCMeSmA02S01XABsm_median = r(p50)

replace DayITCMeSmA02S01XABsm_median = round(DayITCMeSmA02S01XABsm_median)

local DayITCMeSmA02S01XABsm_median = DayITCMeSmA02S01XABsm_median

twoway ///
(line DayITCMeSmA02S01XAB date, sort lcolor(black*0.2)) /// 
(line DayITCMeSmA02S01XABsm date, sort lcolor(black) lwidth(thick)) /// 
(line DayITCMeSmA02S01XABsm_median date, sort lcolor(black) lwidth(thin) lpattern(dash)) /// 
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily estimated infections to reported cases) title("COVID-19 daily estimated infections to reported cases, $country, Alberta", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME raw" 2 "IHME smooth" 3 "IHME smooth median") size(small) row(1)) ///
subtitle("reference scenarios", size(small)) ///
note("IHME smooth median in 2021 = `DayITCMeSmA02S01XABsm_median'")

qui graph export "CAN4 - 1 daily estimated infections to reported cases, $country, Alberta, reference scenarios 2021.pdf", replace



* British Columbia

qui summ DayITCMeSmA02S01XBCsm if date >= td(01jan2021) , detail

gen DayITCMeSmA02S01XBCsm_median = r(p50)

replace DayITCMeSmA02S01XBCsm_median = round(DayITCMeSmA02S01XBCsm_median)

local DayITCMeSmA02S01XBCsm_median = DayITCMeSmA02S01XBCsm_median

twoway ///
(line DayITCMeSmA02S01XBC date, sort lcolor(black*0.2)) /// 
(line DayITCMeSmA02S01XBCsm date, sort lcolor(black) lwidth(thick)) /// 
(line DayITCMeSmA02S01XBCsm_median date, sort lcolor(black) lwidth(thin) lpattern(dash)) /// 
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily estimated infections to reported cases) title("COVID-19 daily estimated infections to reported cases, $country, British Columbia", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME raw" 2 "IHME smooth" 3 "IHME smooth median") size(small) row(1)) ///
subtitle("reference scenarios", size(small)) ///
note("IHME smooth median in 2021 = `DayITCMeSmA02S01XBCsm_median'")

qui graph export "CAN4 - 1 daily estimated infections to reported cases, $country, British Columbia, reference scenarios 2021.pdf", replace



* Manitoba

qui summ DayITCMeSmA02S01XMBsm if date >= td(01jan2021) , detail

gen DayITCMeSmA02S01XMBsm_median = r(p50)

replace DayITCMeSmA02S01XMBsm_median = round(DayITCMeSmA02S01XMBsm_median)

local DayITCMeSmA02S01XMBsm_median = DayITCMeSmA02S01XMBsm_median

twoway ///
(line DayITCMeSmA02S01XMB date, sort lcolor(black*0.2)) /// 
(line DayITCMeSmA02S01XMBsm date, sort lcolor(black) lwidth(thick)) /// 
(line DayITCMeSmA02S01XMBsm_median date, sort lcolor(black) lwidth(thin) lpattern(dash)) /// 
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily estimated infections to reported cases) title("COVID-19 daily estimated infections to reported cases, $country, Manitoba", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME raw" 2 "IHME smooth" 3 "IHME smooth median") size(small) row(1)) ///
subtitle("reference scenarios", size(small)) ///
note("IHME smooth median in 2021 = `DayITCMeSmA02S01XMBsm_median'")

qui graph export "CAN4 - 1 daily estimated infections to reported cases, $country, Manitoba, reference scenarios.pdf", replace



* Nova Scotia

qui summ DayITCMeSmA02S01XNSsm if date >= td(01jan2021) , detail

gen DayITCMeSmA02S01XNSsm_median = r(p50)

replace DayITCMeSmA02S01XNSsm_median = round(DayITCMeSmA02S01XNSsm_median)

local DayITCMeSmA02S01XNSsm_median = DayITCMeSmA02S01XNSsm_median

twoway ///
(line DayITCMeSmA02S01XNS date, sort lcolor(black*0.2)) /// 
(line DayITCMeSmA02S01XNSsm date, sort lcolor(black) lwidth(thick)) /// 
(line DayITCMeSmA02S01XNSsm_median date, sort lcolor(black) lwidth(thin) lpattern(dash)) /// 
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily estimated infections to reported cases) title("COVID-19 daily estimated infections to reported cases, $country, Nova Scotia", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME raw" 2 "IHME smooth" 3 "IHME smooth median") size(small) row(1)) ///
subtitle("reference scenarios", size(small)) ///
note("IHME smooth median in 2021 = `DayITCMeSmA02S01XNSsm_median'")

qui graph export "CAN4 - 1 daily estimated infections to reported cases, $country, Nova Scotia, reference scenarios.pdf", replace



* Ontario


qui summ DayITCMeSmA02S01XONsm if date >= td(01jan2021) , detail

gen DayITCMeSmA02S01XONsm_median = r(p50)

replace DayITCMeSmA02S01XONsm_median = round(DayITCMeSmA02S01XONsm_median)

local DayITCMeSmA02S01XONsm_median = DayITCMeSmA02S01XONsm_median

twoway ///
(line DayITCMeSmA02S01XON date, sort lcolor(black*0.2)) /// 
(line DayITCMeSmA02S01XONsm date, sort lcolor(black) lwidth(thick)) /// 
(line DayITCMeSmA02S01XONsm_median date, sort lcolor(black) lwidth(thin) lpattern(dash)) /// 
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily estimated infections to reported cases) title("COVID-19 daily estimated infections to reported cases, $country, Ontario", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME raw" 2 "IHME smooth" 3 "IHME smooth median") size(small) row(1)) ///
subtitle("reference scenarios", size(small)) ///
note("IHME smooth median in 2021 = `DayITCMeSmA02S01XONsm_median'")

qui graph export "CAN4 - 1 daily estimated infections to reported cases, $country, Ontario, reference scenarios.pdf", replace



* Quebec

qui summ DayITCMeSmA02S01XQCsm if date >= td(01jan2021) , detail

gen DayITCMeSmA02S01XQCsm_median = r(p50)

replace DayITCMeSmA02S01XQCsm_median = round(DayITCMeSmA02S01XQCsm_median)

local DayITCMeSmA02S01XQCsm_median = DayITCMeSmA02S01XQCsm_median

twoway ///
(line DayITCMeSmA02S01XQC date, sort lcolor(black*0.2)) /// 
(line DayITCMeSmA02S01XQCsm date, sort lcolor(black) lwidth(thick)) /// 
(line DayITCMeSmA02S01XQCsm_median date, sort lcolor(black) lwidth(thin) lpattern(dash)) /// 
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily estimated infections to reported cases) title("COVID-19 daily estimated infections to reported cases, $country, Quebec", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME raw" 2 "IHME smooth" 3 "IHME smooth median") size(small) row(1)) ///
subtitle("reference scenarios", size(small)) ///
note("IHME smooth median in 2021 = `DayITCMeSmA02S01XQCsm_median'")

qui graph export "CAN4 - 1 daily estimated infections to reported cases, $country, Quebec, reference scenarios.pdf", replace



* Saskatchewan

qui summ DayITCMeSmA02S01XSKsm if date >= td(01jan2021) , detail

gen DayITCMeSmA02S01XSKsm_median = r(p50)

replace DayITCMeSmA02S01XSKsm_median = round(DayITCMeSmA02S01XSKsm_median)

local DayITCMeSmA02S01XSKsm_median = DayITCMeSmA02S01XSKsm_median

twoway ///
(line DayITCMeSmA02S01XSK date, sort lcolor(black*0.2)) /// 
(line DayITCMeSmA02S01XSKsm date, sort lcolor(black) lwidth(thick)) /// 
(line DayITCMeSmA02S01XSKsm_median date, sort lcolor(black) lwidth(thin) lpattern(dash)) /// 
if date >= td(01jan2021) ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily estimated infections to reported cases) title("COVID-19 daily estimated infections to reported cases, $country, Saskatchewan", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "IHME raw" 2 "IHME smooth" 3 "IHME smooth median") size(small) row(1)) ///
subtitle("reference scenarios", size(small)) ///
note("IHME smooth median in 2021 = `DayITCMeSmA02S01XSKsm_median'")

qui graph export "CAN4 - 1 daily estimated infections to reported cases, $country, Saskatchewan, reference scenarios.pdf", replace





****
* daily cases or infections, reference scenarios, all time, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
(line DayCasMeRaA01S00 date, sort lcolor(red*0.8) lwidth(medium) lpattern(tight_dot)) /// 3 "DELP raw"
(line DayCasMeSmA01S00 date, sort lcolor(red) lwidth(medthick)) /// 4 "DELP smooth"
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 5 "IHME"
if date >= td(01jan2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases raw" 2 "JOHN cases smooth" 3 "DELP cases raw" 4 "DELP cases smooth" 5 "IHME infections") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) 

qui graph export "SUB4 31bDayCasMERGsub alltime `l' - COVID-19 daily cases, $country, `l', reference scenarios.pdf", replace

}
*



****
* daily cases, reference scenarios, all time, by provinces only predicted in DELP: New Brunswick

twoway ///
(line DayCasMeRaA00S00XNB date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayCasMeSmA00S00XNB date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
(line DayCasMeRaA01S00XNB date, sort lcolor(red*0.3) lwidth(medium) lpattern(tight_dot)) /// 3 "DELP raw"
(line DayCasMeSmA01S00XNB date, sort lcolor(red) lwidth(medthick)) /// 4 "DELP smooth"
if date >= td(01jan2020) & provincestate == "New Brunswick" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country, New Brunswick", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "DELP raw" 4 "DELP smooth") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) 

qui graph export "SUB1b 11bDayCasMERGsub alltime New Brunswick - COVID-19 daily cases, $country, New Brunswick, reference scenarios, all time.pdf", replace

*


****
* daily cases, reference scenarios, all time, by provinces only predicted in DELP: Newfoundland and Labrador

twoway ///
(line DayCasMeRaA00S00XNL date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayCasMeSmA00S00XNL date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
(line DayCasMeRaA01S00XNL date, sort lcolor(red*0.3) lwidth(medium) lpattern(tight_dot)) /// 3 "DELP raw"
(line DayCasMeSmA01S00XNL date, sort lcolor(red) lwidth(medthick)) /// 4 "DELP smooth"
if date >= td(01jan2020) & provincestate == "Newfoundland and Labrador" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country, Newfoundland and Labrador", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN raw" 2 "JOHN smooth" 3 "DELP raw" 4 "DELP smooth") size(small) row(2)) ///
subtitle("reference scenarios", size(small)) 

qui graph export "SUB1c 11bDayCasMERGsub alltime Newfoundland and Labrador - COVID-19 daily cases, $country, Newfoundland and Labrador, reference scenarios, all time.pdf", replace

*






****
* daily cases or infections, reference scenarios, 2021, National

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 4 "IHME"
(line DayINFMeRaA03S02 date, sort lcolor(magenta)) /// 5 "IMPE"
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases raw" 2 "JOHN cases smooth" 3 "DELP cases" ///
4 "IHME infections" 5 "IMPE infections" 6 "SRIV cases") size(small) row(3)) ///
subtitle("reference scenarios, after 2021-01-01", size(small)) 

qui graph export "CAN5 32aDayCasMERGnat 2021 - COVID-19 daily cases, $country, National, reference scenarios, 2021.pdf", replace




****
* daily cases or infections, reference scenarios, 2021, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 3 "DELP"
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 4 "IHME"
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases raw" 2 "JOHN cases smooth" 3 "DELP cases" 4 "IHME infections") size(small) row(2)) ///
subtitle("reference scenarios, after 2021-01-01", size(small)) 

qui graph export "SUB5 32bDayCasMERGsub 2021 `l' - COVID-19 daily cases, $country, `l', reference scenarios, 2021.pdf", replace

}
*





****
* daily cases or infections, reference scenario, 2021, uncertainty, National

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 3 DELP mean
(line DayCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 DELP lower
(line DayCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 5 DELP upper
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 6 IHME mean
(line DayINFLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME lower
(line DayINFUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 8 IHME upper
(line DayINFMeRaA03S02 date, sort lcolor(magenta)) /// 9 IMPE mean
(line DayINFLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE lower
(line DayINFUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 11 IMPE upper
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 12 "SRIV" mean
(line DayCasLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 13 "SRIV" lower
(line DayCasUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 14 "SRIV" upper
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases raw" 2 "JOHN cases smooth" 3 "DELP cases" ///
6 "IHME infections" 9 "IMPE infections" 12 "SRIV cases") size(small) row(3)) ///
note("reference scenarios, uncertainty limits: dashed curves") ///
subtitle("after 2021-01-01, with uncertainty", size(small))

qui graph export "33aDayCasMERGnat 2021 CI - COVID-19 daily cases, $country, National, reference scenarios, 2021, uncertainty.pdf", replace





****
* daily cases or infections, reference scenario, 2021, uncertainty, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 3 DELP mean
(line DayCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 DELP lower
(line DayCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 5 DELP upper
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 6 IHME mean
(line DayINFLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME lower
(line DayINFUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 8 IHME upper
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country, `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases raw" 2 "JOHN cases smooth" 3 "DELP cases" 6 "IHME infections") size(small) row(2)) ///
note("Uncertainty limits: dashed curves") ///
subtitle("reference scenarios, after 2021-01-01, with uncertainty", size(small))

qui graph export "33bDayCasMERGsub 2021 CI `l' - COVID-19 daily cases, $country, `l', reference scenarios, 2021, uncertainty.pdf", replace

}
*





****
* daily cases or infections, 3 scenarios, 2021, National

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 3 IHME mean, reference scenario
(line DayINFMeSmA02S02 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 4 IHME mean, better scenario
(line DayINFMeSmA02S03 date, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 5 IHME mean, worse scenario
(line DayINFMeRaA03S02 date, sort lcolor(magenta)) /// 6 IMPE mean, reference scenario
(line DayINFMeRaA03S01 date, sort lcolor(magenta) lwidth(thick) lpattern(tight_dot)) /// 7 IMPE mean, better scenario
(line DayINFMeRaA03S03 date, sort lcolor(magenta) lwidth(thick) lpattern(tight_dot)) /// 8 IMPE mean, worse scenario
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases raw" 2 "JOHN cases smooth" 3 "IHME infections" 6 "IMPE infections") size(small) row(2)) ///
subtitle("IHME and IMPE 3 scenarios, after 2021-01-01", size(small)) ///
note("Better and worse scenarios: tight dot (|||||) curves; IHME and IMPE") 

qui graph export "CAN6 34aDayCasMERGnat 2021 3scen - COVID-19 daily cases, $country, National, 3 scenarios, 2021, uncertainty.pdf", replace






****
* daily cases or infections, 3 scenarios, 2021, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(medium) lpattern(tight_dot)) /// 1 "JOHN raw"
(line DayCasMeSmA00S00 date, sort lcolor(cyan*1.2) lwidth(thick)) /// 2 "JOHN smooth"
(line DayINFMeSmA02S01 date, sort lcolor(black)) /// 3 IHME mean, reference scenario
(line DayINFMeSmA02S02 date, sort lcolor(green) lwidth(thick) lpattern(tight_dot)) /// 4 IHME mean, better scenario
(line DayINFMeSmA02S03 date, sort lcolor(red) lwidth(thick) lpattern(tight_dot)) /// 5 IHME mean, worse scenario
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections) title("COVID-19 daily cases or infections, $country, `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases raw" 2 "JOHN casessmooth" 3 "IHME infections reference" ///
4 "IHME infections better" 5 "IHME infections worse") size(small) row(3)) ///
subtitle("IHME 3 scenarios, after 2021-01-01", size(small)) ///
note("Better and worse scenarios: tight dot (|||||) curves for IHME") 

qui graph export "SUB6 34bDayCasMERGsub 2021 3scen `l' - COVID-19 daily cases, $country, `l', 3 scenarios, 2021, uncertainty.pdf", replace

}
*














*****************

* total deaths (graph numbers start with 41)


****
* total deaths, reference scenarios, all time, National

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

qui graph export "41aTotDeaMERGnat alltime ref - COVID-19 total deaths, $country, National, reference scenarios, all time.pdf", replace





****
* total deaths, reference scenarios, all time, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

qui graph export "41bTotDeaMERGsub alltime ref `l' - COVID-19 total deaths, $country, `l', reference scenarios, all time.pdf", replace

}
*





****
* total deaths, reference scenarios, 2021, National

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios, after 2021-01-01", size(small))

qui graph export "42aTotDeaMERGnat 2021 ref - COVID-19 total deaths, $country, National, reference scenarios, 2021.pdf", replace





****
* total deaths, reference scenarios, 2021, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME") size(small) row(1)) ///
subtitle("reference scenarios, after 2021-01-01", size(small))

qui graph export "42bTotDeaMERGsub 2021 ref `l' - COVID-19 total deaths, $country, `l', reference scenarios, 2021.pdf", replace

}
*





****
* total deaths, reference scenarios, 2021, uncertainty, National 

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 JOHN
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 DELP mean
(line TotDeaLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 DELP lower
(line TotDeaUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 DELP upper
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line TotDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line TotDeaLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line TotDeaUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 11 "SRIV" mean
(line TotDeaLoRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 12 "SRIV" lower
(line TotDeaUpRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 13 "SRIV" upper
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME" 8 "IMPE" 11 "SRIV") size(small) row(1)) ///
note("reference scenarios, uncertainty limits: dashed curves") ///
subtitle("after 2021-01-01, with uncertainty", size(small))

qui graph export "43aTotDeaMERGnat 2021 ref CI - COVID-19 total deaths, $country, National, reference scenarios, 2021, uncertainty.pdf", replace





****
* total deaths, reference scenarios, 2021, uncertainty, by province 

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 JOHN
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 DELP mean
(line TotDeaLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 DELP lower
(line TotDeaUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 DELP upper
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line TotDeaLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotDeaUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 5 "IHME") size(small) row(1)) ///
note("reference scenarios, uncertainty limits: dashed curves") ///
subtitle("after 2021-01-01, with uncertainty", size(small))

qui graph export "43bTotDeaMERGsub 2021 ref CI `l' - COVID-19 total deaths, $country, `l', reference scenarios, 2021, uncertainty.pdf", replace

}
*





*****************

* total cases or infections (graph numbers start with 51)



****
* total cases, reference scenarios, all time, National

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotINFMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotINFMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME or infections" 4 ///
"IMPE or infections" 5 "SRIV cases") size(small) row(3)) ///
subtitle("reference scenarios", size(small))

qui graph export "51aTotCasMERGnat alltime ref - COVID-19 total cases, $country, National, reference scenarios, all time.pdf", replace






****
* total cases or infections, reference scenarios, all time, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotINFMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

qui graph export "51bTotCasMERGsub alltime ref `l' - COVID-19 total cases, $country, `l', reference scenarios, all time.pdf", replace

}
*





****
* total cases or infections, reference scenarios, 2021, National

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotINFMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotINFMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 ///
"IMPE infections" 5 "SRIV cases") size(small) row(1)) ///
subtitle("reference scenarios, after 2021-01-01", size(small))

qui graph export "52aTotCasMERGnat 2021 ref - COVID-19 total cases, $country, National, reference scenarios, 2021.pdf", replace





****
* total cases or infections, reference scenarios, 2021, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotINFMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections") size(small) row(1)) ///
subtitle("reference scenarios, after 2021-01-01", size(small))

qui graph export "52bTotCasMERGsub 2021 ref `l' - COVID-19 total cases, $country, `l', reference scenarios, 2021.pdf", replace

}
*





****
* total cases or infections, reference scenarios, 2021, uncertainty, National

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 JOHN
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP"
(line TotCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP"
(line TotINFMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line TotINFLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotINFUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
(line TotINFMeRaA03S02 date, sort lcolor(magenta)) /// 8 IMPE mean
(line TotINFLoRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 9 IMPE lower
(line TotINFUpRaA03S02 date, sort lcolor(magenta) lpattern(dash)) /// 10 IMPE upper
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 11 "SRIV" mean
(line TotCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 12 "SRIV" lower
(line TotCasMeRaA05S00 date, sort lcolor(green) lpattern(dash)) /// 13 "SRIV" upper
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 5 "IHME infections" ///
8 "IMPE infections" 11 "SRIV cases") size(small) row(3)) ///
note("reference scenarios, uncertainty limits: dashed curves") ///
subtitle("after 2021-01-01, with uncertainty", size(small))

qui graph export "53aTotCasMERGnat 2021 ref CI - COVID-19 total cases, $country, National, reference scenarios, 2021, uncertainty.pdf", replace





****
* total cases or infections, reference scenarios, 2021, uncertainty, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 JOHN
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasLoRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 3 "DELP"
(line TotCasUpRaA01S00 date, sort lcolor(red) lpattern(dash)) /// 4 "DELP"
(line TotINFMeSmA02S01 date, sort lcolor(black)) /// 5 IHME mean
(line TotINFLoSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 6 IHME lower
(line TotINFUpSmA02S01 date, sort lcolor(black) lpattern(dash)) /// 7 IHME upper
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections) title("COVID-19 total cases or infections, $country, `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 5 "IHME infections") size(small) row(1)) ///
note("reference scenarios, uncertainty limits: dashed curves") ///
subtitle("after 2021-01-01, with uncertainty", size(small))

qui graph export "53bTotCasMERGsub 2021 ref CI `l' - COVID-19 total cases, $country, `l', reference scenarios, 2021, uncertainty.pdf", replace

}
*





*****************

* daily CFR or IFR (graph numbers start with 61)

****
* CFR or IFR all studies, reference scenarios, all time, National

twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCfrMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line infection_fatality_A02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayIFRMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCfrMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) & provincestate == " National" & DayCfrMeRaA00S00 >= 0 ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR or IFR) title("COVID-19 daily CFR or IFR, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN CFR" 2 "DELP CFR" 3 "IHME IFR" 4 "IMPE IFR" 5 "SRIV CFR") size(small) row(2)) ///
subtitle("reference scenarios", size(small))

qui graph export "61aDayCfrMERGnat ref alltime - COVID-19 daily CFR, $country, National, reference scenarios, all time.pdf", replace





****
* CFR or IFR all studies, reference scenarios, all time, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(cyan) lwidth(vthin)) /// 1 "JOHN"
(line DayCfrMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line infection_fatality_A02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2020) & provincestate == "`l'" & DayCfrMeRaA00S00 >= 0 ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR or IFR) title("COVID-19 daily CFR or IFR, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN CFR" 2 "DELP CFR" 3 "IHME IFR") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

qui graph export "61bDayCfrMERGsub ref alltime `l' - COVID-19 daily CFR, $country, `l', reference scenarios, all time.pdf", replace

}
*





****
* CFR or IFR  all studies, reference scenarios, 2021, National

twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCfrMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line infection_fatality_A02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayIFRMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCfrMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) & provincestate == " National" & DayCfrMeRaA00S00 >= 0 ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR or IFR) title("COVID-19 daily CFR or IFR , $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN CFR" 2 "DELP CFR" 3 "IHME IFR" 4 "IMPE IFR" 5 "SRIV CFR") size(small) row(1)) ///
subtitle("reference scenarios, after 2021-01-01", size(small))

qui graph export "62aDayCfrMERGnat ref 2021 - COVID-19 daily CFR, $country, National, reference scenarios, 2021.pdf", replace




****
* CFR or IFR all studies, reference scenarios, 2021, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(cyan) lwidth(vthin)) /// 1 "JOHN"
(line DayCfrMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line infection_fatality_A02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2021) & provincestate == "`l'" & DayCfrMeRaA00S00 >= 0 ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR or IFR) title("COVID-19 daily CFR or IFR, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN CFR" 2 "DELP CFR" 3 "IHME IFR") size(small) row(1)) ///
subtitle("reference scenarios, after 2021-01-01", size(small))

qui graph export "62bDayCfrMERGsub ref 2021 `l' - COVID-19 daily CFR, $country, `l', reference scenarios, 2021.pdf", replace

}
*




************************

* other outcomes (graph numbers start with 71)


* daily hospital-related outcomes, National

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red) lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayBedMeSmA02S01 date, sort lcolor(black)) /// 3 IHME Bed need (Daily Beds needed Mean IHME S1)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 4 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 5 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayHodMeRaA03S01 date, sort lcolor(magenta)) /// 6 IMPE Hosp demand (Daily hospital demand Mean A03 S01 )
(line DayHoiMeRaA03S01 date, sort lcolor(magenta) lpattern(dash)) /// 7 IMPE Hosp incidence (Daily hospital incidence Mean A03 S01 )
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 8 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
(line DayIciMeRaA03S01 date, sort lcolor(magenta) lpattern(longdash_shortdash)) /// 9 IMPE ICU incidence (Daily ICU incidence Mean A03 S01 )
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME Bed need" 4 "IHME ICU need" ///
5 "IHME Admissions" 6 "IMPE Hosp demand" ///
7 "IMPE Hosp incidence" 8 "IMPE ICU demand" 9 "IMPE ICU incidence") rows(4) size(small)) ///
subtitle("reference scenarios", size(small))

qui graph export "CAN7 71a1DayHosMERGnat  alltime - COVID-19 hospital-related outcomes, $country, National.pdf", replace





* daily hospital-related outcomes, National, with IHME bed capcity

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red) lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayBedMeSmA02S01 date, sort lcolor(black)) /// 3 IHME Bed need (Daily Beds needed Mean IHME S1)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 4 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 5 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayHodMeRaA03S01 date, sort lcolor(magenta)) /// 6 IMPE Hosp demand (Daily hospital demand Mean A03 S01 )
(line DayHoiMeRaA03S01 date, sort lcolor(magenta) lpattern(dash)) /// 7 IMPE Hosp incidence (Daily hospital incidence Mean A03 S01 )
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 8 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
(line DayIciMeRaA03S01 date, sort lcolor(magenta) lpattern(longdash_shortdash)) /// 9 IMPE ICU incidence (Daily ICU incidence Mean A03 S01 )
(line DayBEDMeSmA02    date, sort lcolor(black) lpattern(dash)) /// 10 "IHME All bed capcity"
(line DayICUMeSmA02    date, sort lcolor(cyan) lpattern(dash)) /// 11 "IHME ICU bed capacity"
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME Bed need" 4 "IHME ICU need" ///
5 "IHME Admissions" 6 "IMPE Hosp demand" ///
7 "IMPE Hosp incidence" 8 "IMPE ICU demand" 9 "IMPE ICU incidence" ///
10 "IHME All bed capcity" 11 "IHME ICU bed capacity") rows(5) size(small)) ///
subtitle("reference scenarios", size(small))

qui graph export "CAN7 71a2DayHosMERGnat  alltime - COVID-19 hospital-related outcomes, $country, National.pdf", replace






* daily hospital-related outcomes, National

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red) lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayBedMeSmA02S01 date, sort lcolor(black)) /// 3 IHME Bed need (Daily Beds needed Mean IHME S1)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 4 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 5 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayHodMeRaA03S01 date, sort lcolor(magenta)) /// 6 IMPE Hosp demand (Daily hospital demand Mean A03 S01 )
(line DayHoiMeRaA03S01 date, sort lcolor(magenta) lpattern(dash)) /// 7 IMPE Hosp incidence (Daily hospital incidence Mean A03 S01 )
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 8 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
(line DayIciMeRaA03S01 date, sort lcolor(magenta) lpattern(longdash_shortdash)) /// 9 IMPE ICU incidence (Daily ICU incidence Mean A03 S01 )
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME Bed need" 4 "IHME ICU need" ///
5 "IHME Admissions" 6 "IMPE Hosp demand" 7 "IMPE Hosp incidence" 8 "IMPE ICU demand" 9 "IMPE ICU incidence") rows(5) size(small)) ///
subtitle("reference scenarios", size(small))

qui graph export "CAN7 71a12DayHosMERGnat  alltime - COVID-19 hospital-related outcomes, $country, National.pdf", replace





* daily hospital-related outcomes, National, with IHME bed capcity

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red) lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayBedMeSmA02S01 date, sort lcolor(black)) /// 3 IHME Bed need (Daily Beds needed Mean IHME S1)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 4 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 5 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayHodMeRaA03S01 date, sort lcolor(magenta)) /// 6 IMPE Hosp demand (Daily hospital demand Mean A03 S01 )
(line DayHoiMeRaA03S01 date, sort lcolor(magenta) lpattern(dash)) /// 7 IMPE Hosp incidence (Daily hospital incidence Mean A03 S01 )
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 8 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
(line DayIciMeRaA03S01 date, sort lcolor(magenta) lpattern(longdash_shortdash)) /// 9 IMPE ICU incidence (Daily ICU incidence Mean A03 S01 )
(line DayBEDMeSmA02    date, sort lcolor(black) lpattern(dash)) /// 13 "IHME All bed capcity"
(line DayICUMeSmA02    date, sort lcolor(cyan) lpattern(dash)) /// 14 "IHME ICU bed capacity"
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME Bed need" 4 "IHME ICU need" ///
5 "IHME Admissions" 6 "IMPE Hosp demand" 7 "IMPE Hosp incidence" 8 "IMPE ICU demand" 9 "IMPE ICU incidence") rows(5) size(small)) ///
subtitle("reference scenarios", size(small))

qui graph export "CAN7 71a22DayHosMERGnat  alltime - COVID-19 hospital-related outcomes, $country, National.pdf", replace








* daily hospital-related outcomes, by province

* base codes with IHME

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red) lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayBedMeSmA02S01 date, sort lcolor(black)) /// 3 IHME Bed need (Daily Beds needed Mean IHME S1)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 4 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 5 IHME Admissions (Daily hospital admissions Mean IHME S1)
if date >= td(01jan2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country, `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME Bed need" 4 "IHME ICU need" ///
5 "IHME Admissions") rows(3) size(small)) ///
subtitle("reference scenarios", size(small))

qui graph export "SUB7 71bDayHosMERGsub alltime `l' - COVID-19 hospital-related outcomes, $country, `l'.pdf", replace

}
*





****
* daily hospital-related outcomes, DELP, IHME, IMPE, wo IHME Bed need, IMPE Hosp demand, National

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red)  lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 3 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 4 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayHoiMeRaA03S01 date, sort lcolor(magenta) lpattern(dash)) /// 5 IMPE Hosp incidence (Daily hospital incidence Mean A03 S01)
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 6 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
(line DayIciMeRaA03S01 date, sort lcolor(magenta) lpattern(longdash_shortdash)) /// 7 IMPE ICU incidence (Daily ICU incidence Mean A03 S01)
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME ICU need" ///
4 "IHME Admissions" 5 "IMPE Hosp incidence" 6 "IMPE ICU demand" 7 "IMPE ICU incidence") rows(3) size(small)) ///
subtitle("reference scenarios, without IHME Bed need, IMPE Hosp demand", size(small))

qui graph export "72aDayHosMERGnat  alltime woextremes - COVID-19 hospital-related outcomes, $country, National, wo extremes.pdf", replace






****
* daily hospital-related outcomes, DELP, IHME, IMPE, wo IHME Bed need, IMPE Hosp demand, National

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red)  lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 3 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 4 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayHoiMeRaA03S01 date, sort lcolor(magenta) lpattern(dash)) /// 5 IMPE Hosp incidence (Daily hospital incidence Mean A03 S01)
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 6 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
(line DayIciMeRaA03S01 date, sort lcolor(magenta) lpattern(longdash_shortdash)) /// 7 IMPE ICU incidence (Daily ICU incidence Mean A03 S01)
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME ICU need" 4 "IHME Admissions" 5 "IMPE Hosp incidence" 6 "IMPE ICU demand" 7 "IMPE ICU incidence") rows(4) size(small)) ///
subtitle("reference scenarios, without IHME Bed need, IMPE Hosp demand", size(small))

qui graph export "72a2DayHosMERGnat  alltime woextremes - COVID-19 hospital-related outcomes, $country, National, wo extremes.pdf", replace






****
* daily hospital-related outcomes, DELP, IHME, wo IHME Bed need, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red)  lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 3 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 4 IHME Admissions (Daily hospital admissions Mean IHME S1)
if date >= td(01jan2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country, `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME ICU need" ///
4 "IHME Admissions") rows(2) size(small)) ///
subtitle("reference scenarios, without IHME Bed need", size(small))

qui graph export "72bDayHosMERGsub  alltime `l' - COVID-19 hospital-related outcomes, $country, `l',, wo extremes.pdf", replace

}
*





****
* daily hospital-related outcomes, DELP, IHME, IMPE, wo IHME Bed need, IMPE Hosp demand, 2021, National

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red)  lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 3 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 4 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayHoiMeRaA03S01 date, sort lcolor(magenta) lpattern(dash)) /// 5 IMPE Hosp incidence (Daily hospital incidence Mean A03 S01 )
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 6 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
(line DayIciMeRaA03S01 date, sort lcolor(magenta) lpattern(longdash_shortdash)) /// 7 IMPE ICU incidence (Daily ICU incidence Mean A03 S01 )
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME ICU need" ///
4 "IHME Admissions" 5 "IMPE Hosp incidence" 6 "IMPE ICU demand" 7 "IMPE ICU incidence") rows(3) size(small)) ///
subtitle("reference scenarios, after 2021-01-01, without IHME Bed need, IMPE Hosp demand", size(small))

qui graph export "CAN8 73aDayHosMERGnat 2021 - COVID-19 hospital-related outcomes, $country, National, wo extremes, 2021.pdf", replace





****
* daily hospital-related outcomes, DELP, IHME, IMPE, wo IHME Bed need, IMPE Hosp demand, 2021, National

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red)  lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 3 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 4 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayHoiMeRaA03S01 date, sort lcolor(magenta) lpattern(dash)) /// 5 IMPE Hosp incidence (Daily hospital incidence Mean A03 S01 )
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 6 IMPE ICU demand (Daily ICU demand Mean A03 S01 )
(line DayIciMeRaA03S01 date, sort lcolor(magenta) lpattern(longdash_shortdash)) /// 7 IMPE ICU incidence (Daily ICU incidence Mean A03 S01 )
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country, National", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME ICU need" ///
4 "IHME Admissions" 5 "IMPE Hosp incidence" 6 "IMPE ICU demand" 7 "IMPE ICU incidence") rows(3) size(small)) ///
subtitle("reference scenarios, after 2021-01-01, without IHME Bed need, IMPE Hosp demand", size(small))

qui graph export "CAN8 73a2DayHosMERGnat 2021 - COVID-19 hospital-related outcomes, $country, National, wo extremes, 2021.pdf", replace




****
* daily hospital-related outcomes, DELP, IHME, wo IHME Bed need, 2021, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red)  lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 3 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 4 IHME Admissions (Daily hospital admissions Mean IHME S1)
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes $country, `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME ICU need" ///
4 "IHME Admissions") rows(2) size(small)) ///
subtitle("reference scenarios, after 2021-01-01, without IHME Bed need", size(small))

qui graph export "SUB8 73bDayHosMERGsub 2021 woextremes `l' - COVID-19 hospital-related outcomes, $country, `l', wo extremes, 2021.pdf", replace

}
*





*******************************

* daily cases or infections to deaths (CTD) 



****
* Daily cases or infections to deaths (CTD) all studies, reference scenarios, all time, National

twoway ///
(line DayCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayITDMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayITDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCTDMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections to deaths) title("COVID-19 daily cases or infections to deaths, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV cases") size(small) row(3)) ///
subtitle("reference scenarios", size(small))

qui graph export "81aDayCTDMERGnat alltime - COVID-19 daily cases to deaths, $country, National, reference scenarios, all time.pdf", replace



****
* Daily cases or infections to deaths (CTD) all studies, reference scenarios, all time, National, without IHME

twoway ///
(line DayCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayITDMeRaA03S02 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayCTDMeRaA05S00 date, sort lcolor(green)) /// 4 "SRIV"
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections to deaths) title("COVID-19 daily cases or infections to deaths, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IMPE infections" 4 "SRIV cases") size(small) row(1)) ///
subtitle("reference scenarios, without IHME", size(small) color(white))

qui graph export "81a2DayCTDMERGnat alltime woIHME - COVID-19 daily cases to deaths, $country, National, reference scenarios, all time.pdf", replace





****
* Daily cases or infections to deaths (CTD) all studies, reference scenarios, all time, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthin)) /// 1 "JOHN"
(line DayCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayITDMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections to deaths) title("COVID-19 daily cases or infections to deaths, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

qui graph export "81bDayCTDMERGsub alltime `l' - COVID-19 daily cases to deaths, $country, `l', reference scenarios, all time.pdf", replace

}
*




****
* Daily cases or infections to deaths (CTD) all studies, reference scenarios, 2021, National

twoway ///
(line DayCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayITDMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayITDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCTDMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections to deaths) title("COVID-19 daily cases or infections to deaths, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV cases") size(small) row(2)) ///
subtitle("reference scenarios, after 2021-01-01", size(small))

qui graph export "82aDayCTDMERGnat 2021 - COVID-19 daily cases to deaths, $country, National, reference scenarios, 2021.pdf", replace




****
* Daily cases or infections to deaths (CTD) all studies, reference scenarios, 2021, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthin)) /// 1 "JOHN"
(line DayCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayITDMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases or infections to deaths) title("COVID-19 daily cases or infections to deaths, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections") size(small) row(1)) ///
subtitle("reference scenarios, after 2021-01-01", size(small))

qui graph export "82bDayCTDMERGsub 2021 `l' - COVID-19 daily cases to deaths, $country, `l', reference scenarios, 2021.pdf", replace

}
*





****
* Total cases or infections to deaths (CTD) all studies, reference scenarios, all time, National

twoway ///
(line TotCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotITDMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotITDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCTDMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections to deaths) title("COVID-19 total cases or infections to deaths, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV cases") size(small) row(3)) ///
subtitle("reference scenarios", size(small))

qui graph export "83aTotCTDMERGnat alltime - COVID-19 total cases to deaths, $country, National, reference scenarios, all time.pdf", replace





****
* Total cases or infections to deaths (CTD) all studies, reference scenarios, all time, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line TotCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthin)) /// 1 "JOHN"
(line TotCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotITDMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections to deaths) title("COVID-19 total cases or infections to deaths, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

qui graph export "83bTotCTDMERGnat alltime - COVID-19 total cases to deaths, $country, `l', reference scenarios, all time.pdf", replace

}
*





****
* Total cases or infections to deaths (CTD) all studies, reference scenarios, 2021, National

twoway ///
(line TotCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotITDMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotITDMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCTDMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections to deaths) title("COVID-19 total cases or infections to deaths, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV cases") size(small) row(3)) ///
subtitle("reference scenarios, after 2021-01-01", size(small))

qui graph export "84aTotCTDMERGnat 2021 - COVID-19 total cases to deaths, $country, National, reference scenarios, 2021.pdf", replace





****
* Total cases or infections to deaths (CTD) all studies, reference scenarios, 2021, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line TotCTDMeRaA00S00 date, sort lcolor(cyan) lwidth(vthin)) /// 1 "JOHN"
(line TotCTDMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotITDMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases or infections to deaths) title("COVID-19 total cases or infections to deaths, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases" 2 "DELP cases" 3 "IHME infections") size(small) row(1)) ///
subtitle("reference scenarios, after 2021-01-01", size(small))

qui graph export "84bTotCTDMERGsub 2021 `l' - COVID-19 total cases to deaths, $country, `l', reference scenarios, 2021.pdf", replace

}
*




*******************************

*  estimated to reported (graph numbers start with 91)


* daily deaths estimated to reported  



****
* daily deaths estimated to reported (DER) all studies, reference scenarios, all time, National

twoway ///
(line DayDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayIERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths estimated to reported) title("COVID-19 daily deaths estimated to reported, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

qui graph export "91aDayDERMERGnat alltime - COVID-19 daily deaths estimated to reported, $country, National, reference scenarios, all time.pdf", replace




****
* daily deaths estimated to reported (DER) all studies, reference scenarios, all time, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths estimated to reported) title("COVID-19 daily deaths estimated to reported, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

qui graph export "91bDayDERMERGsub alltime `l' - COVID-19 daily deaths estimated to reported, $country, `l', reference scenarios, all time.pdf", replace

}
*





****
* daily deaths estimated to reported (DER) all studies, reference scenarios, 2021, National

twoway ///
(line DayDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths estimated to reported) title("COVID-19 daily deaths estimated to reported, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

qui graph export "CAN9 92aDayDERMERGnat 2021 - COVID-19 daily deaths estimated to reported, $country, National, reference scenarios, 2021.pdf", replace




****
* daily deaths estimated to reported (DER) all studies, reference scenarios, 2021, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths estimated to reported) title("COVID-19 daily deaths estimated to reported, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

qui graph export "SUB9 92bDayDERMERGsub 2021 `l' - COVID-19 daily deaths estimated to reported, $country, `l', reference scenarios, 2021.pdf", replace

}
*





* daily cases or infections estimated to reported  



****
* daily cases or infections estimated to reported (CER) all studies, reference scenarios, all time, National

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayIERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases estimated to reported) title("COVID-19 daily cases estimated to reported, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV") size(small) row(2)) ///
subtitle("daily cases or infections estimated, to reported cases; reference scenarios", size(small))

qui graph export "93aDayCERMERGnat alltime - COVID-19 daily cases estimated to reported, $country, National, reference scenarios, all time.pdf", replace






****
* daily cases or infections estimated to reported (CER) all studies, reference scenarios, all time, National

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayIERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases estimated to reported) title("COVID-19 daily cases estimated to reported, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV") size(small) row(2)) ///
subtitle("daily cases or infections estimated, to reported cases; reference scenarios", size(small))

qui graph export "93a2DayCERMERGnat alltime - COVID-19 daily cases estimated to reported, $country, National, reference scenarios, all time.pdf", replace


 






****
* daily cases or infections estimated to reported (CER) all studies, reference scenarios, all time, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases estimated to reported) title("COVID-19 daily cases estimated to reported, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME infections") size(small) row(1)) ///
subtitle("daily cases or infections estimated, to reported cases; reference scenarios", size(small))

qui graph export "93bDayCERMERGsub alltime `l' - COVID-19 daily cases estimated to reported, $country, `l', reference scenarios, all time.pdf", replace

}
*





****
* daily cases or infections estimated to reported (CER) all studies, reference scenarios, all time, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases estimated to reported) title("COVID-19 daily cases estimated to reported, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME infections") size(small) row(1)) ///
subtitle("daily cases or infections estimated, to reported cases; reference scenarios", size(small))

qui graph export "93b2DayCERMERGsub alltime `l' - COVID-19 daily cases estimated to reported, $country, `l', reference scenarios, all time.pdf", replace

}
*





****
* daily cases or infections estimated to reported (CER) all studies, reference scenarios, 2021, National

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayIERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases estimated to reported) title("COVID-19 daily cases estimated to reported, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV") size(small) row(2)) ///
subtitle("daily cases or infections estimated, to reported cases; reference scenarios", size(small))

qui graph export "CAN10 94aDayCERMERGnat 2021 - COVID-19 daily cases estimated to reported, $country, National, reference scenarios, 2021.pdf", replace





****
* daily cases or infections estimated to reported (CER) all studies, reference scenarios, 2021, National

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayIERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases estimated to reported) title("COVID-19 daily cases estimated to reported, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV") size(small) row(2)) ///
subtitle("daily cases or infections estimated, to reported cases; reference scenarios", size(small))

qui graph export "CAN10 94a2DayCERMERGnat 2021 - COVID-19 daily cases estimated to reported, $country, National, reference scenarios, 2021.pdf", replace






****
* daily cases or infections estimated to reported (CER) all studies, reference scenarios, 2021, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases estimated to reported) title("COVID-19 daily cases estimated to reported, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME infections") size(small) row(1)) ///
subtitle("daily cases or infections estimated, to reported cases; reference scenarios", size(small))

qui graph export "SUB10 94bDayCERMERGsub 2021 `l' - COVID-19 daily cases estimated to reported, $country, `l', reference scenarios, 2021.pdf", replace

}
*






****
* daily cases or infections estimated to reported (CER) all studies, reference scenarios, 2021, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line DayCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line DayCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayIERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases estimated to reported) title("COVID-19 daily cases estimated to reported, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME infections") size(small) row(1)) ///
subtitle("daily cases or infections estimated, to reported cases; reference scenarios", size(small))

qui graph export "SUB10 94b2DayCERMERGsub 2021 `l' - COVID-19 daily cases estimated to reported, $country, `l', reference scenarios, 2021.pdf", replace

}
*






****
* total deaths estimated to reported (DER) all studies, reference scenarios, all time, National

twoway ///
(line TotDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN
(line TotDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths estimated to reported) title("COVID-19 total deaths estimated to reported, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "SRIV") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

qui graph export "95aTotDERMERGnat alltime - COVID-19 total deaths estimated to reported, $country, National, reference scenarios, all time.pdf", replace




****
* total deaths estimated to reported (DER) all studies, reference scenarios, all time, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line TotDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN
(line TotDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths estimated to reported) title("COVID-19 total deaths estimated to reported, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

qui graph export "95bTotDERMERGsub alltime `l' - COVID-19 total deaths estimated to reported, $country, `l', reference scenarios, all time.pdf", replace

}
*





****
* total deaths estimated to reported (DER) all studies, reference scenarios, 2021, National

twoway ///
(line TotDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN
(line TotDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths estimated to reported) title("COVID-19 total deaths estimated to reported, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "SRIV") size(small) row(1)) ///
subtitle("total cases or infections, estimated to reported cases; reference scenarios", size(small))

qui graph export "96aTotDERMERGnat 2021 - COVID-19 total deaths estimated to reported, $country, National, reference scenarios, 2021.pdf", replace




****
* total deaths estimated to reported (DER) all studies, reference scenarios, 2021, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line TotDERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN
(line TotDERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths estimated to reported) title("COVID-19 total deaths estimated to reported, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME") size(small) row(1)) ///
subtitle("reference scenarios", size(small))

qui graph export "96bTotDERMERGsub 2021 `l' - COVID-19 total deaths estimated to reported,$country, `l', reference scenarios, 2021.pdf", replace

}
*






****
* total cases or infections estimated to reported (CER) all studies, reference scenarios, all time, National

twoway ///
(line TotCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotIERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotIERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases estimated to reported) title("COVID-19 total cases estimated to reported, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV") size(small) row(2)) ///
subtitle("total cases or infections, estimated to reported cases; reference scenarios", size(small))

qui graph export "97aTotCERMERGnat alltime - COVID-19 total cases estimated to reported, $country, National, reference scenarios, all time.pdf", replace






****
* total cases or infections estimated to reported (CER) all studies, reference scenarios, all time, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line TotCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotIERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases estimated to reported) title("COVID-19 total cases estimated to reported, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME infections") size(small) row(1)) ///
subtitle("total cases or infections, estimated to reported cases; reference scenarios", size(small))

qui graph export "97bTotCERMERGsub alltime `l' - COVID-19 total cases estimated to reported, $country, `l', reference scenarios, all time.pdf", replace

}
*





****
* total cases or infections estimated to reported (CER) all studies, reference scenarios, 2021, National

twoway ///
(line TotCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotIERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotIERMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCERMeRaA05S00 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(01jan2021) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases estimated to reported) title("COVID-19 total cases estimated to reported, $country, National", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME infections" 4 "IMPE infections" 5 "SRIV") size(small) row(2)) ///
subtitle("total cases or infections, estimated to reported cases; reference scenarios", size(small))

qui graph export "98aTotCERMERGnat 2021 - COVID-19 total cases estimated to reported, $country, National, reference scenarios, 2021.pdf", replace





****
* total cases or infections estimated to reported (CER) all studies, reference scenarios, 2021, by province

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line TotCERMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick)) /// 1 "JOHN"
(line TotCERMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotIERMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
if date >= td(01jan2021) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases estimated to reported) title("COVID-19 total cases estimated to reported, $country, `l'", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME infections") size(small) row(1)) ///
subtitle("total cases or infections, estimated to reported cases; reference scenarios", size(small))

qui graph export "98bTotCERMERGnat 2021 `l' - COVID-19 total cases estimated to reported, $country, `l', reference scenarios, 2021.pdf", replace

}
*




*****************

* IHME graphs






* daily Infection outcomes ratios, 3 scenarios, national, 2021

twoway ///
(line infection_detection_A02S01 date, sort lcolor(green)) ///
(line inf_hosp_A02S01 date, sort lcolor(black)) ///
(line infection_fatality_A02S01 date, sort lcolor(red)) ///
(line infection_detection_A02S02 date, sort lcolor(green) lpattern(dash)) ///
(line inf_hosp_A02S02 date, sort lcolor(black) lpattern(dash)) ///
(line infection_fatality_A02S02 date, sort lcolor(red) lpattern(dash)) ///
(line infection_detection_A02S03 date, sort lcolor(green) lpattern(dash)) ///
(line inf_hosp_A02S03 date, sort lcolor(black) lpattern(dash)) ///
(line infection_fatality_A02S03 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2021) & provincestate == " National"  ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infection-outcome ratios) title("C-19 daily infection-outcome ratios, $country, National, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Infection detection ratio" 2 "Infection hospitalization ratio" 3 "Infection fatality ratio") rows(2)) ///
note("Better and worse scenarios: dashed curves") ///
subtitle(3 scenarios)

qui graph export "graph 91a COVID-19 daily Infection outcomes ratios, $country, National 3 scenarios, IHME.pdf", replace






* daily Infection hospitalization and fatality ratios, 3 scenarios, national, 2021

twoway ///
(line inf_hosp_A02S01 date, sort lcolor(black)) ///
(line infection_fatality_A02S01 date, sort lcolor(red)) ///
(line inf_hosp_A02S02 date, sort lcolor(black) lpattern(dash)) ///
(line infection_fatality_A02S02 date, sort lcolor(red) lpattern(dash)) ///
(line inf_hosp_A02S03 date, sort lcolor(black) lpattern(dash)) ///
(line infection_fatality_A02S03 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2021) & provincestate == " National"  ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.3fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infection-outcome ratios) title("C-19 daily infection hospitalization & fatality ratios, $country, National, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Infection hospitalization ratio" 2 "Infection fatality ratio") rows(1)) ///
note("Better and worse scenarios: dashed curves") ///
subtitle(3 scenarios) yscale(titlegap(2))

qui graph export "graph 91a2 COVID-19 daily Infection outcomes ratios, $country, National 3 scenarios, IHME.pdf", replace





* daily Infection outcomes ratios, 3 scenarios, provinces, 2021

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {
  
twoway ///
(line infection_detection_A02S01 date, sort lcolor(green)) ///
(line inf_hosp_A02S01 date, sort lcolor(black)) ///
(line infection_fatality_A02S01 date, sort lcolor(red)) ///
(line infection_detection_A02S02 date, sort lcolor(green) lpattern(dash)) ///
(line inf_hosp_A02S02 date, sort lcolor(black) lpattern(dash)) ///
(line infection_fatality_A02S02 date, sort lcolor(red) lpattern(dash)) ///
(line infection_detection_A02S03 date, sort lcolor(green) lpattern(dash)) ///
(line inf_hosp_A02S03 date, sort lcolor(black) lpattern(dash)) ///
(line infection_fatality_A02S03 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2021) & provincestate == "`l'"  ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infection-outcome ratios) title("C-19 daily infection-outcome ratios, $country, `l', IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Infection detection ratio" 2 "Infection hospitalization ratio" 3 "Infection fatality ratio") rows(2)) ///
note("Better and worse scenarios: dashed curves") ///
subtitle(3 scenarios) yscale(titlegap(2))

qui graph export "graph 91b COVID-19 daily Infection outcomes ratios, $country, `l' 3 scenarios, IHME.pdf", replace

}
*





* daily Infection hospitalization and fatality ratios, 3 scenarios, provinces, 2021

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {
  
twoway ///
(line inf_hosp_A02S01 date, sort lcolor(black)) ///
(line infection_fatality_A02S01 date, sort lcolor(red)) ///
(line inf_hosp_A02S02 date, sort lcolor(black) lpattern(dash)) ///
(line infection_fatality_A02S02 date, sort lcolor(red) lpattern(dash)) ///
(line inf_hosp_A02S03 date, sort lcolor(black) lpattern(dash)) ///
(line infection_fatality_A02S03 date, sort lcolor(red) lpattern(dash)) ///
if date >= td(01jan2021) & provincestate == "`l'"  ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.3fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infection-outcome ratios) title("C-19 daily infection hospitalization & fatality ratios, $country, `l', IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Infection hospitalization ratio" 2 "Infection fatality ratio") rows(2)) ///
note("Better and worse scenarios: dashed curves") ///
subtitle(3 scenarios) yscale(titlegap(3))

qui graph export "graph 91b2 COVID-19 daily Infection outcomes ratios, $country, `l' 3 scenarios, IHME.pdf", replace

}
*








* daily % change in mobility, CI, National

twoway ///
(line mobility_mean_A02S02 date, sort lcolor(lime) lpattern(tight_dot) lwidth(vthick)) ///
(line mobility_mean_A02S03 date, sort lcolor(red)) ///
(line mobility_mean_A02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily % change in mobility from baseline) title("C-19 daily % change in mobility, $country, National, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Better" 2 "Worse" 3 "Reference") rows(1)) ///
subtitle(3 scenarios)

qui graph export "graph 92a COVID-19 daily mobility, $country, National, 3 scenarios.pdf", replace





* daily % change in mobility, CI, Provinces

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line mobility_mean_A02S02 date, sort lcolor(lime) lpattern(tight_dot) lwidth(vthick)) ///
(line mobility_mean_A02S03 date, sort lcolor(red)) ///
(line mobility_mean_A02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020)  & provincestate == "`l'"  ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily % change in mobility from baseline) title("C-19 daily % change in mobility, $country, `l', IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Better" 2 "Worse" 3 "Reference") rows(1)) ///
subtitle(3 scenarios)

qui graph export "graph 92a COVID-19 daily mobility, $country, `l', 3 scenarios.pdf", replace

}
*





* daily mask_use Percent of population reporting always wearing a mask when leaving home, National 

twoway ///
(line mask_use_mean_A02S02 date, sort lcolor(lime) lpattern(tight_dot) lwidth(vthick)) ///
(line mask_use_mean_A02S03 date, sort lcolor(red)) ///
(line mask_use_mean_A02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily mask use) title("C-19 daily mask use, $country, National, IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Better" 2 "Worse" 3 "Reference") rows(1)) ///
subtitle(Proportion of population reporting always wearing a mask when leaving home, size(small))

qui graph export "graph 93a COVID-19 daily mask_use, $country, National, 3 scenarios.pdf", replace






* daily mask_use Percent of population reporting always wearing a mask when leaving home, Provinces 

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line mask_use_mean_A02S02 date, sort lcolor(lime) lpattern(tight_dot) lwidth(vthick)) ///
(line mask_use_mean_A02S03 date, sort lcolor(red)) ///
(line mask_use_mean_A02S01 date, sort lcolor(black)) ///
if date >= td(01jan2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily mask use) title("C-19 daily mask use, $country, `l', IHME, 3 scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Better" 2 "Worse" 3 "Reference") rows(1)) ///
subtitle(Proportion of population reporting always wearing a mask when leaving home, size(small))

qui graph export "graph 93b COVID-19 daily mask_use, $country, `l', 3 scenarios.pdf", replace

}
*





* percent cumulative vaccinated, National

twoway ///
(line cumul_vax_pct date, sort lcolor(black)) ///
(line cumul_effective_vax_pct date, sort lcolor(blue)) ///
(line cumul_fully_vax_pct date, sort lcolor(green) lwidth(thick)) ///
if date >= td(01dec2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Cumulative vaccinated percent) title("C-19 cumulative vaccinated %, $country, National, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Vaccinated" 2 "Effectively vaccinated" 3 "Fully vaccinated") rows(1)) ///
note("Vaccinated: Initially vaccinated (one dose of two doses)" ///
"Effectively vaccinated: one and two dose with efficacy" ///
"Fully vaccinated: one of one and two of two doses", size(small)) 

qui graph export "graph 94a COVID-19 percent cumulative vaccinated, $country, National.pdf", replace





* percent cumulative vaccinated, Provinces

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line cumul_vax_pct date, sort lcolor(black)) ///
(line cumul_effective_vax_pct date, sort lcolor(blue)) ///
(line cumul_fully_vax_pct date, sort lcolor(green) lwidth(thick)) ///
if date >= td(01dec2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Cumulative vaccinated percent) title("C-19 cumulative vaccinated %, $country, `l', IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Vaccinated" 2 "Effectively vaccinated" 3 "Fully vaccinated") rows(1)) ///
note("Vaccinated: Initially vaccinated (one dose of two doses)" ///
"Effectively vaccinated: one and two dose with efficacy" ///
"Fully vaccinated: one of one and two of two doses", size(small)) 

qui graph export "graph 94b COVID-19 percent cumulative vaccinated, $country, `l'.pdf", replace

}
*




* number cumulative vaccinated, National

twoway ///
(line cumul_vax date, sort lcolor(black)) ///
(line cumul_effective_vax date, sort lcolor(blue)) ///
(line cumul_fully_vax date, sort lcolor(green) lwidth(thick)) ///
if date >= td(01dec2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Cumulative vaccinated number) title("C-19 cumulative vaccinated number, $country, National, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Vaccinated" 2 "Effectively vaccinated" 3 "Fully vaccinated") rows(1)) ///
note("Vaccinated: Initially vaccinated (one dose of two doses)" ///
"Effectively vaccinated: one and two dose with efficacy" ///
"Fully vaccinated: one of one and two of two doses", size(small)) 

qui graph export "graph 94c COVID-19 number cumulative vaccinated, $country, National.pdf", replace





* number cumulative vaccinated, Provinces

levelsof provincestate_mostaffected, local(levels)

foreach l of local levels {

twoway ///
(line cumul_vax date, sort lcolor(black)) ///
(line cumul_effective_vax date, sort lcolor(blue)) ///
(line cumul_fully_vax date, sort lcolor(green) lwidth(thick)) ///
if date >= td(01dec2020) & provincestate == "`l'" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Cumulative vaccinated number) title("C-19 cumulative vaccinated number, $country, `l', IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Vaccinated" 2 "Effectively vaccinated" 3 "Fully vaccinated") rows(1)) ///
note("Vaccinated: Initially vaccinated (one dose of two doses)" ///
"Effectively vaccinated: one and two dose with efficacy" ///
"Fully vaccinated: one of one and two of two doses", size(small)) 

qui graph export "graph 94d COVID-19 number cumulative vaccinated, $country, `l'.pdf", replace

}
*







* number cumulative vaccinated, National

twoway ///
(line cumul_vax date, sort lcolor(black)) ///
(line cumul_effective_vax date, sort lcolor(blue)) ///
(line cumul_fully_vax date, sort lcolor(green) lwidth(thick)) ///
if date >= td(01dec2020) & provincestate == " National" ///
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Cumulative vaccinated number) title("C-19 cumulative vaccinated number, $country, National, IHME", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Vaccinated" 2 "Effectively vaccinated" 3 "Fully vaccinated") rows(1)) ///
note("Vaccinated: Initially vaccinated (one dose of two doses)" ///
"Effectively vaccinated: one and two dose with efficacy" ///
"Fully vaccinated: one of one and two of two doses", size(small)) 

qui graph export "graph 94c COVID-19 number cumulative vaccinated, $country, National.pdf", replace


*********************************








*******************************************************



* Selected graphs - Canada, provinces --- JOHN



*******************************************************
* 1 daily deaths, provinces, 2020 on

twoway ///
(line DayDeaMeSmA00S00XXX date, sort lwidth(medthick) lcolor(gray)) /// 1 "CAN" 
(line DayDeaMeSmA00S00XAB date, sort lwidth(medium) lcolor(cyan)) /// 2 "AB" cyan
(line DayDeaMeSmA00S00XBC date, sort lwidth(medium) lcolor(blue)) /// 3 "BC" blue
(line DayDeaMeSmA00S00XMB date, sort lwidth(medium) lcolor(lime)) /// 4 "MB" lime
(line DayDeaMeSmA00S00XNL date, sort lwidth(medium) lcolor(gold)) /// 5 "NL" gold
(line DayDeaMeSmA00S00XNS date, sort lwidth(medium) lcolor(magenta)) /// 6 "NS" magenta
(line DayDeaMeSmA00S00XON date, sort lwidth(medium) lcolor(red)) /// 7 "ON" red
(line DayDeaMeSmA00S00XQC date, sort lwidth(medium) lcolor(black)) /// 9 "QC" black
(line DayDeaMeSmA00S00XSK date, sort lwidth(medium) lcolor(brown)) /// 8 "SK" orange
if date >= td(01jan2020) & date <= td(01apr2022) ///
, xtitle(Date) xlabel(#$monthspast01jan2020JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, smooth, $country provinces, JOHN, 2020 on", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "CAN" 2 "AB" 3 "BC" 4 "MB" 5 "NL" 6 "NS" 7 "ON" 8 "QC" 9 "SK" ) rows(2) size(small))  

qui graph export "graph 01 provinces C-19 daily deaths, $country, JOHN 2020.pdf", replace





*******************************************************
* 2 daily deaths, provinces, 2021 on

twoway ///
(line DayDeaMeSmA00S00XXX date, sort lwidth(medthick) lcolor(gray)) /// 1 "CAN" 
(line DayDeaMeSmA00S00XAB date, sort lwidth(medium) lcolor(cyan)) /// 2 "AB" cyan
(line DayDeaMeSmA00S00XBC date, sort lwidth(medium) lcolor(blue)) /// 3 "BC" blue
(line DayDeaMeSmA00S00XMB date, sort lwidth(medium) lcolor(lime)) /// 4 "MB" lime
(line DayDeaMeSmA00S00XNL date, sort lwidth(medium) lcolor(gold)) /// 5 "NL" gold
(line DayDeaMeSmA00S00XNS date, sort lwidth(medium) lcolor(magenta)) /// 6 "NS" magenta
(line DayDeaMeSmA00S00XON date, sort lwidth(medium) lcolor(red)) /// 7 "ON" red
(line DayDeaMeSmA00S00XQC date, sort lwidth(medium) lcolor(black)) /// 9 "QC" black
(line DayDeaMeSmA00S00XSK date, sort lwidth(medium) lcolor(brown)) /// 8 "SK" orange
if date >= td(01jan2021) & date <= td(01apr2022) ///
, xtitle(Date) xlabel(#$monthspast01jan2021JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, smooth, $country provinces, JOHN, 2021 on", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "CAN" 2 "AB" 3 "BC" 4 "MB" 5 "NL" 6 "NS" 7 "ON" 8 "QC" 9 "SK" ) rows(2) size(small))  

qui graph export "graph 02 provinces C-19 daily deaths, $country, JOHN 2021.pdf", replace






*******************************************************
* 3 daily deaths, provinces, 2022 on

twoway ///
(line DayDeaMeSmA00S00XXX date, sort lwidth(medthick) lcolor(gray)) /// 1 "CAN" 
(line DayDeaMeSmA00S00XAB date, sort lwidth(medium) lcolor(cyan)) /// 2 "AB" cyan
(line DayDeaMeSmA00S00XBC date, sort lwidth(medium) lcolor(blue)) /// 3 "BC" blue
(line DayDeaMeSmA00S00XMB date, sort lwidth(medium) lcolor(lime)) /// 4 "MB" lime
(line DayDeaMeSmA00S00XNL date, sort lwidth(medium) lcolor(gold)) /// 5 "NL" gold
(line DayDeaMeSmA00S00XNS date, sort lwidth(medium) lcolor(magenta)) /// 6 "NS" magenta
(line DayDeaMeSmA00S00XON date, sort lwidth(medium) lcolor(red)) /// 7 "ON" red
(line DayDeaMeSmA00S00XQC date, sort lwidth(medium) lcolor(black)) /// 9 "QC" black
(line DayDeaMeSmA00S00XSK date, sort lwidth(medium) lcolor(brown)) /// 8 "SK" orange
if date >= td(01jan2022) & date <= td(01apr2022) ///
, xtitle(Date) xlabel(#$monthspast01jan2022JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, smooth, $country provinces, JOHN, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "CAN" 2 "AB" 3 "BC" 4 "MB" 5 "NL" 6 "NS" 7 "ON" 8 "QC" 9 "SK" ) rows(2) size(small))  

qui graph export "graph 03 provinces C-19 daily deaths, $country, JOHN 2022.pdf", replace






*******************************************************
* 4 daily deaths, provinces, 2022 on, Without National, Ontario, and Quebec

twoway ///
(line DayDeaMeSmA00S00XAB date, sort lwidth(medium) lcolor(cyan)) /// 1 "AB" cyan
(line DayDeaMeSmA00S00XBC date, sort lwidth(medium) lcolor(blue)) /// 2 "BC" blue
(line DayDeaMeSmA00S00XMB date, sort lwidth(medium) lcolor(lime)) /// 3 "MB" lime
(line DayDeaMeSmA00S00XNL date, sort lwidth(medium) lcolor(gold)) /// 4 "NL" gold
(line DayDeaMeSmA00S00XNS date, sort lwidth(medium) lcolor(magenta)) /// 5 "NS" magenta
(line DayDeaMeSmA00S00XSK date, sort lwidth(medium) lcolor(brown)) /// 6 "SK" orange
if date >= td(01jan2022) & date <= td(01apr2022) ///
, xtitle(Date) xlabel(#$monthspast01jan2022JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, smooth, $country provinces, JOHN, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "AB" 2 "BC" 3 "MB" 4 "NL" 5 "NS" 6 "SK" ) rows(1) size(small)) ///
subtitle("Without National, Ontario, and Quebec", size(small))

qui graph export "graph 04 provinces C-19 daily deaths, $country, JOHN 2022.pdf", replace





*******************************************************
* 5 daily cases, provinces, 2020 on

twoway ///
(line DayCasMeSmA00S00XXX date, sort lwidth(medthick) lcolor(gray)) /// 1 "CAN" 
(line DayCasMeSmA00S00XAB date, sort lwidth(medium) lcolor(cyan)) /// 2 "AB" cyan
(line DayCasMeSmA00S00XBC date, sort lwidth(medium) lcolor(blue)) /// 3 "BC" blue
(line DayCasMeSmA00S00XMB date, sort lwidth(medium) lcolor(lime)) /// 4 "MB" lime
(line DayCasMeSmA00S00XNL date, sort lwidth(medium) lcolor(gold)) /// 5 "NL" gold
(line DayCasMeSmA00S00XNS date, sort lwidth(medium) lcolor(magenta)) /// 6 "NS" magenta
(line DayCasMeSmA00S00XON date, sort lwidth(medium) lcolor(red)) /// 7 "ON" red
(line DayCasMeSmA00S00XQC date, sort lwidth(medium) lcolor(black)) /// 8 "QC" black
(line DayCasMeSmA00S00XSK date, sort lwidth(medium) lcolor(brown)) /// 9 "SK" orange
if date >= td(01jan2020) & date <= td(01apr2022) ///
, xtitle(Date) xlabel(#$monthspast01jan2020JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily cases) title("C-19 daily cases, smooth, $country provinces, JOHN, 2020 on", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "CAN" 2 "AB" 3 "BC" 4 "MB" 5 "NL" 6 "NS" 7 "ON" 8 "QC" 9 "SK" ) rows(2) size(small)) 

qui graph export "graph 05 provinces C-19 daily cases, $country, JOHN 2020.pdf", replace





*******************************************************
* 6 daily cases, provinces, 2021 on

twoway ///
(line DayCasMeSmA00S00XXX date, sort lwidth(medthick) lcolor(gray)) /// 1 "CAN" 
(line DayCasMeSmA00S00XAB date, sort lwidth(medium) lcolor(cyan)) /// 2 "AB" cyan
(line DayCasMeSmA00S00XBC date, sort lwidth(medium) lcolor(blue)) /// 3 "BC" blue
(line DayCasMeSmA00S00XMB date, sort lwidth(medium) lcolor(lime)) /// 4 "MB" lime
(line DayCasMeSmA00S00XNL date, sort lwidth(medium) lcolor(gold)) /// 5 "NL" gold
(line DayCasMeSmA00S00XNS date, sort lwidth(medium) lcolor(magenta)) /// 6 "NS" magenta
(line DayCasMeSmA00S00XON date, sort lwidth(medium) lcolor(red)) /// 7 "ON" red
(line DayCasMeSmA00S00XQC date, sort lwidth(medium) lcolor(black)) /// 8 "QC" black
(line DayCasMeSmA00S00XSK date, sort lwidth(medium) lcolor(brown)) /// 9 "SK" orange
if date >= td(01jan2021) & date <= td(01apr2022) ///
, xtitle(Date) xlabel(#$monthspast01jan2021JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily cases) title("C-19 daily cases, smooth, $country provinces, JOHN, 2021 on", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "CAN" 2 "AB" 3 "BC" 4 "MB" 5 "NL" 6 "NS" 7 "ON" 8 "QC" 9 "SK" ) rows(2) size(small)) 

qui graph export "graph 06 provinces C-19 daily cases, $country, JOHN 2021.pdf", replace






*******************************************************
* 7 daily cases, provinces, 2022 on

twoway ///
(line DayCasMeSmA00S00XXX date, sort lwidth(medthick) lcolor(gray)) /// 1 "CAN" 
(line DayCasMeSmA00S00XAB date, sort lwidth(medium) lcolor(cyan)) /// 2 "AB" cyan
(line DayCasMeSmA00S00XBC date, sort lwidth(medium) lcolor(blue)) /// 3 "BC" blue
(line DayCasMeSmA00S00XMB date, sort lwidth(medium) lcolor(lime)) /// 4 "MB" lime
(line DayCasMeSmA00S00XNL date, sort lwidth(medium) lcolor(gold)) /// 5 "NL" gold
(line DayCasMeSmA00S00XNS date, sort lwidth(medium) lcolor(magenta)) /// 6 "NS" magenta
(line DayCasMeSmA00S00XON date, sort lwidth(medium) lcolor(red)) /// 7 "ON" red
(line DayCasMeSmA00S00XQC date, sort lwidth(medium) lcolor(black)) /// 8 "QC" black
(line DayCasMeSmA00S00XSK date, sort lwidth(medium) lcolor(brown)) /// 9 "SK" orange
if date >= td(01jan2022) & date <= td(01apr2022) ///
, xtitle(Date) xlabel(#$monthspast01jan2022JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily cases) title("C-19 daily cases, smooth, $country provinces, JOHN, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "CAN" 2 "AB" 3 "BC" 4 "MB" 5 "NL" 6 "NS" 7 "ON" 8 "QC" 9 "SK" ) rows(2) size(small)) 

qui graph export "graph 07 provinces C-19 daily cases, $country, JOHN 2022.pdf", replace






*******************************************************
* 8 daily cases, provinces, 2022 on, Without National, Ontario, and Quebec

twoway ///
(line DayCasMeSmA00S00XAB date, sort lwidth(medium) lcolor(cyan)) /// 1 "AB" cyan
(line DayCasMeSmA00S00XBC date, sort lwidth(medium) lcolor(blue)) /// 2 "BC" blue
(line DayCasMeSmA00S00XMB date, sort lwidth(medium) lcolor(lime)) /// 3 "MB" lime
(line DayCasMeSmA00S00XNL date, sort lwidth(medium) lcolor(gold)) /// 4 "NL" gold
(line DayCasMeSmA00S00XNS date, sort lwidth(medium) lcolor(magenta)) /// 5 "NS" magenta
(line DayCasMeSmA00S00XSK date, sort lwidth(medium) lcolor(brown)) /// 6 "SK" orange
if date >= td(01jan2022) & date <= td(01apr2022) ///
, xtitle(Date) xlabel(#$monthspast01jan2022JOHN, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily cases) title("C-19 daily cases, smooth, $country provinces, JOHN, 2022", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "AB" 2 "BC" 3 "MB" 4 "NL" 5 "NS" 6 "SK" ) rows(1) size(small)) ///
subtitle("Without National, Ontario, and Quebec", size(small))

qui graph export "graph 08 provinces C-19 daily cases, $country, JOHN 2022.pdf", replace


*******************************************************






* Selected graphs - Canada, provinces --- IHME



*******************************************************
* 22 daily deaths, reference scenario, 2020 on

twoway ///
(line DayDeaMeSmA02S01XXX date, sort lwidth(medthick) lcolor(gray)) /// 1 "CAN" 
(line DayDeaMeSmA02S01XAB date, sort lwidth(medium) lcolor(cyan)) /// 2 "AB" cyan
(line DayDeaMeSmA02S01XBC date, sort lwidth(medium) lcolor(blue)) /// 3 "BC" blue
(line DayDeaMeSmA02S01XMB date, sort lwidth(medium) lcolor(lime)) /// 4 "MB" lime
(line DayDeaMeSmA02S01XNL date, sort lwidth(medium) lcolor(gold)) /// 5 "NL" gold
(line DayDeaMeSmA02S01XNS date, sort lwidth(medium) lcolor(magenta)) /// 6 "NS" magenta
(line DayDeaMeSmA02S01XON date, sort lwidth(medium) lcolor(red)) /// 7 "ON" red
(line DayDeaMeSmA02S01XQC date, sort lwidth(medium) lcolor(black)) /// 8 "QC" black
(line DayDeaMeSmA02S01XSK date, sort lwidth(medium) lcolor(orange)) /// 9 "SK" orange
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, $country provinces, IHME, 2020 on", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "CAN" 2 "AB" 3 "BC" 4 "MB" 5 "NL" 6 "NS" 7 "ON" 8 "QC" 9 "SK" ) rows(2) size(small)) ///
note("Reference scenario")

qui graph export "graph 22 provinces C-19 daily deaths, $country, IHME, 2020 on.pdf", replace






*******************************************************
* 23 daily deaths, reference scenario, 2021 on

twoway ///
(line DayDeaMeSmA02S01XXX date, sort lwidth(medthick) lcolor(gray)) /// 1 "CAN" 
(line DayDeaMeSmA02S01XAB date, sort lwidth(medium) lcolor(cyan)) /// 2 "AB" cyan
(line DayDeaMeSmA02S01XBC date, sort lwidth(medium) lcolor(blue)) /// 3 "BC" blue
(line DayDeaMeSmA02S01XMB date, sort lwidth(medium) lcolor(lime)) /// 4 "MB" lime
(line DayDeaMeSmA02S01XNL date, sort lwidth(medium) lcolor(gold)) /// 5 "NL" gold
(line DayDeaMeSmA02S01XNS date, sort lwidth(medium) lcolor(magenta)) /// 6 "NS" magenta
(line DayDeaMeSmA02S01XON date, sort lwidth(medium) lcolor(red)) /// 7 "ON" red
(line DayDeaMeSmA02S01XQC date, sort lwidth(medium) lcolor(black)) /// 8 "QC" black
(line DayDeaMeSmA02S01XSK date, sort lwidth(medium) lcolor(orange)) /// 9 "SK" orange
if date >= td(01jan2021) /// 
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, $country provinces, IHME, 2021 on", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "CAN" 2 "AB" 3 "BC" 4 "MB" 5 "NL" 6 "NS" 7 "ON" 8 "QC" 9 "SK" ) rows(2) size(small)) ///
note("Reference scenario")

qui graph export "graph 23 provinces C-19 daily deaths, $country, IHME, 2021 on.pdf", replace





*******************************************************
* 24 daily deaths, reference scenario, 2022 on

twoway ///
(line DayDeaMeSmA02S01XXX date, sort lwidth(medthick) lcolor(gray)) /// 1 "CAN" 
(line DayDeaMeSmA02S01XAB date, sort lwidth(medium) lcolor(cyan)) /// 2 "AB" cyan
(line DayDeaMeSmA02S01XBC date, sort lwidth(medium) lcolor(blue)) /// 3 "BC" blue
(line DayDeaMeSmA02S01XMB date, sort lwidth(medium) lcolor(lime)) /// 4 "MB" lime
(line DayDeaMeSmA02S01XNL date, sort lwidth(medium) lcolor(gold)) /// 5 "NL" gold
(line DayDeaMeSmA02S01XNS date, sort lwidth(medium) lcolor(magenta)) /// 6 "NS" magenta
(line DayDeaMeSmA02S01XON date, sort lwidth(medium) lcolor(red)) /// 7 "ON" red
(line DayDeaMeSmA02S01XQC date, sort lwidth(medium) lcolor(black)) /// 8 "QC" black
(line DayDeaMeSmA02S01XSK date, sort lwidth(medium) lcolor(orange)) /// 9 "SK" orange
if date >= td(01jan2022) /// 
, xtitle(Date) xlabel(#$monthspast01jan2022merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily deaths) title("C-19 daily deaths, $country provinces, IHME, 2022 on", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "CAN" 2 "AB" 3 "BC" 4 "MB" 5 "NL" 6 "NS" 7 "ON" 8 "QC" 9 "SK" ) rows(2) size(small)) ///
note("Reference scenario")

qui graph export "graph 24 provinces C-19 daily deaths, $country, IHME, 2022 on.pdf", replace






*******************************************************
* 25 daily infections, reference scenario, 2020 on

twoway ///
(line DayINFMeSmA02S01XXX date, sort lwidth(medthick) lcolor(gray)) /// 1 "CAN" 
(line DayINFMeSmA02S01XAB date, sort lwidth(medium) lcolor(cyan)) /// 2 "AB" cyan
(line DayINFMeSmA02S01XBC date, sort lwidth(medium) lcolor(blue)) /// 3 "BC" blue
(line DayINFMeSmA02S01XMB date, sort lwidth(medium) lcolor(lime)) /// 4 "MB" lime
(line DayINFMeSmA02S01XNL date, sort lwidth(medium) lcolor(gold)) /// 5 "NL" gold
(line DayINFMeSmA02S01XNS date, sort lwidth(medium) lcolor(magenta)) /// 6 "NS" magenta
(line DayINFMeSmA02S01XON date, sort lwidth(medium) lcolor(red)) /// 7 "ON" red
(line DayINFMeSmA02S01XQC date, sort lwidth(medium) lcolor(black)) /// 8 "QC" black
(line DayINFMeSmA02S01XSK date, sort lwidth(medium) lcolor(orange)) /// 9 "SK" orange
, xtitle(Date) xlabel(#$monthspast01jan2020merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily infections) title("C-19 daily infections, $country provinces, IHME, 2020 on", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "CAN" 2 "AB" 3 "BC" 4 "MB" 5 "NL" 6 "NS" 7 "ON" 8 "QC" 9 "SK" ) rows(2) size(small)) ///
note("Reference scenario")

qui graph export "graph 25 provinces C-19 daily infections, $country, IHME, 2020 on.pdf", replace






*******************************************************
* 26 daily infections, reference scenario, 2021 on

twoway ///
(line DayINFMeSmA02S01XXX date, sort lwidth(medthick) lcolor(gray)) /// 1 "CAN" 
(line DayINFMeSmA02S01XAB date, sort lwidth(medium) lcolor(cyan)) /// 2 "AB" cyan
(line DayINFMeSmA02S01XBC date, sort lwidth(medium) lcolor(blue)) /// 3 "BC" blue
(line DayINFMeSmA02S01XMB date, sort lwidth(medium) lcolor(lime)) /// 4 "MB" lime
(line DayINFMeSmA02S01XNL date, sort lwidth(medium) lcolor(gold)) /// 5 "NL" gold
(line DayINFMeSmA02S01XNS date, sort lwidth(medium) lcolor(magenta)) /// 6 "NS" magenta
(line DayINFMeSmA02S01XON date, sort lwidth(medium) lcolor(red)) /// 7 "ON" red
(line DayINFMeSmA02S01XQC date, sort lwidth(medium) lcolor(black)) /// 8 "QC" black
(line DayINFMeSmA02S01XSK date, sort lwidth(medium) lcolor(orange)) /// 9 "SK" orange
if date >= td(01jan2021) /// 
, xtitle(Date) xlabel(#$monthspast01jan2021merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily infections) title("C-19 daily infections, $country provinces, IHME, 2021 on", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "CAN" 2 "AB" 3 "BC" 4 "MB" 5 "NL" 6 "NS" 7 "ON" 8 "QC" 9 "SK" ) rows(2) size(small)) ///
note("Reference scenario")

qui graph export "graph 26 provinces C-19 daily infections, $country, IHME, 2021 on.pdf", replace





*******************************************************
* 27 daily infections, reference scenario, 2021 on

twoway ///
(line DayINFMeSmA02S01XXX date, sort lwidth(medthick) lcolor(gray)) /// 1 "CAN" 
(line DayINFMeSmA02S01XAB date, sort lwidth(medium) lcolor(cyan)) /// 2 "AB" cyan
(line DayINFMeSmA02S01XBC date, sort lwidth(medium) lcolor(blue)) /// 3 "BC" blue
(line DayINFMeSmA02S01XMB date, sort lwidth(medium) lcolor(lime)) /// 4 "MB" lime
(line DayINFMeSmA02S01XNL date, sort lwidth(medium) lcolor(gold)) /// 5 "NL" gold
(line DayINFMeSmA02S01XNS date, sort lwidth(medium) lcolor(magenta)) /// 6 "NS" magenta
(line DayINFMeSmA02S01XON date, sort lwidth(medium) lcolor(red)) /// 7 "ON" red
(line DayINFMeSmA02S01XQC date, sort lwidth(medium) lcolor(black)) /// 8 "QC" black
(line DayINFMeSmA02S01XSK date, sort lwidth(medium) lcolor(orange)) /// 9 "SK" orange
if date >= td(01jan2022) /// 
, xtitle(Date) xlabel(#$monthspast01jan2022merge, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(Daily infections) title("C-19 daily infections, $country provinces, IHME, 2022 on", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "CAN" 2 "AB" 3 "BC" 4 "MB" 5 "NL" 6 "NS" 7 "ON" 8 "QC" 9 "SK" ) rows(2) size(small)) ///
note("Reference scenario")

qui graph export "graph 27 provinces C-19 daily infections, $country, IHME, 2022 on.pdf", replace









************
************

* restore native scheme (of the local machine)

set scheme $nativescheme

di c(scheme)


view "log CovidVisualizedCountry merge.smcl"

log close

exit, clear



