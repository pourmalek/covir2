
clear all

cd "$pathcovir2"

cd SRIV

capture log close 

log using "log Iran SRIV win.smcl", replace

***************************************************************************
* This is "do Iran SRIV win.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare SRIV data for Iran, Locate peak dates and values
***************************************************************************


* Get SRIV estimates 

copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/2021-03-15/global_forecasts_deaths.csv global_forecasts_deaths.csv
copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/2021-03-15/global_forecasts_deaths_lb.csv global_forecasts_deaths_lb.csv
copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/2021-03-15/global_forecasts_deaths_ub.csv global_forecasts_deaths_ub.csv
copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/2021-03-15/global_forecasts_cases.csv global_forecasts_cases.csv
copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/2021-03-15/global_forecasts_cases_lb.csv global_forecasts_cases_lb.csv
copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/2021-03-15/global_forecasts_cases_ub.csv global_forecasts_cases_ub.csv



local list ///
global_forecasts_deaths global_forecasts_deaths_lb global_forecasts_deaths_ub ///
global_forecasts_cases global_forecasts_cases_lb global_forecasts_cases_ub

foreach l of local list {
	import delimited "`l'.csv", clear varnames(1)
	keep if strpos(country, "Iran")
	drop id	country
	
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

rename global_forecasts_deaths_lb TotDeaLoRaA05S00V02	
rename global_forecasts_deaths_ub TotDeaUpRaA05S00V02	
rename global_forecasts_deaths    TotDeaMeRaA05S00V02
rename global_forecasts_cases_lb  TotCasLoRaA05S00V02
rename global_forecasts_cases_ub  TotCasUpRaA05S00V02	
rename global_forecasts_cases	  TotCasMeRaA05S00V02

label var TotDeaMeRaA05S00V02 "Total Deaths Mean SRIV"
label var TotDeaLoRaA05S00V02 "Total Deaths Lower SRIV"
label var TotDeaUpRaA05S00V02 "Total Deaths Upper SRIV"
label var TotCasMeRaA05S00V02 "Total Cases Mean SRIV"
label var TotCasLoRaA05S00V02 "Total Cases Lower SRIV"
label var TotCasUpRaA05S00V02 "Total Cases Upper SRIV"


* first date in csv files 2021-03-14

rename date date_original
gen date = .
replace date = td(14mar2021) in 1
replace date = date[_n-1] + 1 in 2/l
format date %tdDDMonCCYY
codebook date
drop date_original

sort date

local list ///
DeaMeRaA05S00V02 DeaLoRaA05S00V02 DeaUpRaA05S00V02 ///
CasMeRaA05S00V02 CasLoRaA05S00V02 CasUpRaA05S00V02 

foreach l of local list {
	gen Day`l' =  Tot`l'[_n] - Tot`l'[_n-1]
}
*


label var DayDeaMeRaA05S00V02 "Daily Deaths Mean SRIV"
label var DayDeaLoRaA05S00V02 "Daily Deaths Lower SRIV"
label var DayDeaUpRaA05S00V02 "Daily Deaths Upper SRIV"
label var DayCasMeRaA05S00V02 "Daily Cases Mean SRIV"
label var DayCasLoRaA05S00V02 "Daily Cases Lower SRIV"
label var DayCasUpRaA05S00V02 "Daily Cases Upper SRIV"

gen loc_grand_name = "Iran"

order date loc_grand_name

* gen cfr 

gen DayCfrMeRaA05S00V02 = 100 * DayDeaMeRaA05S00V02 / DayCasMeRaA05S00V02
gen DayCfrLoRaA05S00V02 = 100 * DayDeaLoRaA05S00V02 / DayCasLoRaA05S00V02
gen DayCfrUpRaA05S00V02 = 100 * DayDeaUpRaA05S00V02 / DayCasUpRaA05S00V02

label var DayCfrMeRaA05S00V02 "Daily CFR Mean SRIV"
label var DayCfrLoRaA05S00V02 "Daily CFR Lower SRIV"
label var DayCfrUpRaA05S00V02 "Daily CFR Upper SRIV"








****************************

* graphs 

grstyle init

grstyle color background white



* daily deaths 

twoway ///
(line DayDeaMeRaA05S00V02 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 1 COVID-19 daily deaths, default scenario, Iran, SRIV.gph", replace
graph export "graph 1 COVID-19 daily deaths, default scenario, Iran, SRIV.pdf", replace


* daily deaths CI

twoway ///
(rarea DayDeaLoRaA05S00V02 DayDeaUpRaA05S00V02 date, sort color(black*.2)) ///
(line DayDeaMeRaA05S00V02 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 2 COVID-19 daily deaths, default scenario, Iran, SRIV.gph", replace
graph export "graph 2 COVID-19 daily deaths, default scenario, Iran, SRIV.pdf", replace




* daily cases 

twoway ///
(line DayCasMeRaA05S00V02 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 3 COVID-19 daily cases, default scenario, Iran, SRIV.gph", replace
graph export "graph 3 COVID-19 daily cases, default scenario, Iran, SRIV.pdf", replace



* daily cases CI

twoway ///
(rarea DayCasLoRaA05S00V02 DayCasUpRaA05S00V02 date, sort color(black*.2)) ///
(line DayCasMeRaA05S00V02 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 4 COVID-19 daily cases, default scenario, Iran, SRIV.gph", replace
graph export "graph 4 COVID-19 daily cases, default scenario, Iran, SRIV.pdf", replace





* total deaths 

twoway ///
(line TotDeaMeRaA05S00V02 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 5 COVID-19 total deaths, default scenario, Iran, SRIV.gph", replace
graph export "graph 5 COVID-19 total deaths, default scenario, Iran, SRIV.pdf", replace


* total deaths CI

twoway ///
(rarea TotDeaLoRaA05S00V02 TotDeaUpRaA05S00V02 date, sort color(black*.2)) ///
(line TotDeaMeRaA05S00V02 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 6 COVID-19 total deaths, default scenario, Iran, SRIV.gph", replace
graph export "graph 6 COVID-19 total deaths, default scenario, Iran, SRIV.pdf", replace




* total cases 

twoway ///
(line TotCasMeRaA05S00V02 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 7 COVID-19 total cases, default scenario, Iran, SRIV.gph", replace
graph export "graph 7 COVID-19 total cases, default scenario, Iran, SRIV.pdf", replace


* total cases CI

twoway ///
(rarea TotCasLoRaA05S00V02 TotCasUpRaA05S00V02 date, sort color(black*.2)) ///
(line TotCasMeRaA05S00V02 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 8 COVID-19 total cases, default scenario, Iran, SRIV.gph", replace
graph export "graph 8 COVID-19 total cases, default scenario, Iran, SRIV.pdf", replace






* daily CFR 

twoway ///
(line DayCfrMeRaA05S00V02 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph 9 COVID-19 daily CFR, default scenario, Iran, SRIV.gph", replace
graph export "graph 9 COVID-19 daily CFR, default scenario, Iran, SRIV.pdf", replace


* daily CFR CI

twoway ///
(rarea DayCfrLoRaA05S00V02 DayCfrUpRaA05S00V02 date, sort color(black*.2)) ///
(line DayCfrMeRaA05S00V02 date, sort lcolor(black)) ///
, xtitle(Date) xlabel(#5, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(off) ///
subtitle("with confidence limits", size(small))

graph save "graph 10 COVID-19 daily CFR, default scenario, Iran, SRIV.gph", replace
graph export "graph 10 COVID-19 daily CFR, default scenario, Iran, SRIV.pdf", replace




*************************************************************************

* Locate peak dates and values - deaths 


* peak


summ DayDeaMeRaA05S00V02

gen DayDeaMeRaA05S00V02P0V = r(max)

label var DayDeaMeRaA05S00V02P0V "DayDeaMeRaA05S00V02 One peak Value"

summ date if DayDeaMeRaA05S00V02 == DayDeaMeRaA05S00V02P0V 

gen DayDeaMeRaA05S00V02P0D = r(min)

label var DayDeaMeRaA05S00V02P0D "DayDeaMeRaA05S00V02 One peak Date"

format DayDeaMeRaA05S00V02P0D %tdDDMonCCYY

summ DayDeaLoRaA05S00V02 if date == DayDeaMeRaA05S00V02P0D

gen DayDeaLoRaA05S00V02P0V = r(max)

label var DayDeaLoRaA05S00V02P0V "DayDeaLoRaA05S00V02 One peak Value"

summ DayDeaUpRaA05S00V02 if date == DayDeaMeRaA05S00V02P0D

gen DayDeaUpRaA05S00V02P0V = r(max)

label var DayDeaUpRaA05S00V02P0V "DayDeaUpRaA05S00V02 One peak Value"

format DayDeaMeRaA05S00V02P0D %tdDDMonCCYY

tab1 DayDeaMeRaA05S00V02P0V DayDeaLoRaA05S00V02P0V DayDeaUpRaA05S00V02P0V DayDeaMeRaA05S00V02P0D




*************************************************************************

* Locate peak dates and values - cases

* peak

summ DayCasMeRaA05S00V02

gen DayCasMeRaA05S00V02P0V = r(max)

label var DayCasMeRaA05S00V02P0V "DayCasMeRaA05S00V02 One peak Value"

summ date if DayCasMeRaA05S00V02 == DayCasMeRaA05S00V02P0V 

gen DayCasMeRaA05S00V02P0D = r(min)

label var DayCasMeRaA05S00V02P0D "DayCasMeRaA05S00V02 One peak Date"

format DayCasMeRaA05S00V02P0D %tdDDMonCCYY

summ DayCasLoRaA05S00V02 if date == DayCasMeRaA05S00V02P0D

gen DayCasLoRaA05S00V02P0V = r(max)

label var DayCasLoRaA05S00V02P0V "DayCasLoRaA05S00V02 One peak Value"

summ DayCasUpRaA05S00V02 if date == DayCasMeRaA05S00V02P0D

gen DayCasUpRaA05S00V02P0V = r(max)

label var DayCasUpRaA05S00V02P0V "DayCasUpRaA05S00V02 One peak Value"

format DayCasMeRaA05S00V02P0D %tdDDMonCCYY

tab1 DayCasMeRaA05S00V02P0V DayCasLoRaA05S00V02P0V DayCasUpRaA05S00V02P0V DayCasMeRaA05S00V02P0D


compress



save "Iran SRIV.dta", replace
 





********************

* tab the peaks


use "Iran SRIV.dta", clear 


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


save "Iran SRIV peaks.dta", replace

export delimited using "Iran SRIV peaks.csv", replace 


shell mv -f "ReCOVER-COVID-19-master" ~/.Trash





view "log Iran SRIV win.smcl"

log close

exit, clear




