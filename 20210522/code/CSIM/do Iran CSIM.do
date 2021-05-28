
clear all
 
cd "$pathcovir2"

cd CSIM

capture log close 

log using "log Iran CSIM.smcl", replace

***************************************************************************
* This is "do Iran CSIM.do"

* Project: COVID-19 Iran Review No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare CSIM (COVID SIMULATION, Imperial College) data for Iran
***************************************************************************

*** This do file to be executed after running "do Iran master.do"


* Get CSIM data for Iran

import delimited using "ir_g169169_c4879.csv", clear varnames(6)

/*

First three rows of the csv file:

Model parameters used			

country	#general beds	#critical beds
Iran	169169			4879


%vaccine efficacy (against infection & mild illness)
90


%vaccine efficacy (against hospitalisation & death)
96


vaccine durability (days)
1095


introduction date
2021-05-27
									

%vaccine courses available (% of population)
20


#fully vaccinated/week
2100000


prioritisation & allocation
HCW and Elderly


Vaccine uptake (% of group targeted)
80


phase start #1
2021-05-27


phase end #1
2021-11-27


Rt #1
1.527


phase start #2
2021-11-28


phase end #2
2023-01-01


Rt #2
2.4

*/

gen loc_grand_name = "Iran"


* gen date

rename date date_original

gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date

drop year month day date2


* rename outcome variables

* R: Rt(t), Ref(f)

rename rt DayRttMeRaA16S00 
label var DayRttMeRaA16S00 "Daily Rt A16 S0"

rename reff DayRefMeRaA16S00 
label var DayRefMeRaA16S00 "Daily Reff A16 S0"


* deaths: REPORTED (DeZ), estimated (Dea), COUNTERFACTUAL (DeY), AVERTED (Dex)

rename reporteddeaths DayDeZMeRaA16S00 
label var DayDeZMeRaA16S00 "Daily deaths REPORTED A16 S0"

rename deaths DayDeaMeRaA16S00 
label var DayDeaMeRaA16S00 "Daily deaths estimated A16 S0"

rename deathsconterfactual DayDeYMeRaA16S00 
label var DayDeYMeRaA16S00 "Daily deaths COUNTERFACTUAL A16 S0"

rename deathsaverted DayDexMeRaA16S00 
label var DayDexMeRaA16S00 "Daily deaths AVERTED A16 S0"


* cases: estimated (Cas), COUNTERFACTUAL (CaY), AVERTED (Cax)

rename infections DayCasMeRaA16S00 
label var DayCasMeRaA16S00 "Daily cases estimated A16 S0"

rename infectionscounterfactual DayCaYMeRaA16S00 
label var DayCaYMeRaA16S00 "Daily cases COUNTERFACTUAL A16 S0"

rename infectionsaverted DayCaxMeRaA16S00 
label var DayCaxMeRaA16S00 "Daily cases AVERTED A16 S0"


* hospital: hospitalisations (Hos), critical care (Ici)

rename hospitalisations DayHosMeRaA16S00 
label var DayHosMeRaA16S00 "Daily hospitalisations A16 S0"

rename criticalcare DayIciMeRaA16S00 
label var DayIciMeRaA16S00 "Daily critical care A16 S0"


* vaccine: fully vaccinated persons (Vax)

rename fullyvaccinatedpersonscumulative TotVaxMeRaA16S00 
label var TotVaxMeRaA16S00 "Total fully vaccinated persons cumulative A16 S0"



* gen total vars and rename

sort date

bysort loc_grand_name (date):  generate TotCasMeRaA16S00 = sum(DayCasMeRaA16S00) 
format TotCasMeRaA16S00 %15.0f
replace TotCasMeRaA16S00 = . if DayCasMeRaA16S00 == .


bysort loc_grand_name (date):  generate TotCaYMeRaA16S00 = sum(DayCaYMeRaA16S00) 
format TotCaYMeRaA16S00 %15.0f
replace TotCaYMeRaA16S00 = . if DayCaYMeRaA16S00 == .


bysort loc_grand_name (date):  generate TotCaxMeRaA16S00 = sum(DayCaxMeRaA16S00) 
format TotCaxMeRaA16S00 %15.0f
replace TotCaxMeRaA16S00 = . if DayCaxMeRaA16S00 == .


bysort loc_grand_name (date):  generate TotDeaMeRaA16S00 = sum(DayDeaMeRaA16S00) 
format TotDeaMeRaA16S00 %15.0f
replace TotDeaMeRaA16S00 = . if DayDeaMeRaA16S00 == .


bysort loc_grand_name (date):  generate TotDexMeRaA16S00 = sum(DayDexMeRaA16S00) 
format TotDexMeRaA16S00 %15.0f
replace TotDexMeRaA16S00 = . if DayDexMeRaA16S00 == .


bysort loc_grand_name (date):  generate TotDeYMeRaA16S00 = sum(DayDeYMeRaA16S00) 
format TotDeYMeRaA16S00 %15.0f
replace TotDeYMeRaA16S00 = . if DayDeYMeRaA16S00 == .



* gen daily 

sort loc_grand_name date

bysort loc_grand_name: gen DayVaxMeRaA16S00 =  TotVaxMeRaA16S00[_n] - TotVaxMeRaA16S00[_n-1]


label var TotCasMeRaA16S00 "Total cases A16 S0"

label var TotCaYMeRaA16S00 "Total cases COUNTERFACTUAL A16 S0"

label var TotCaxMeRaA16S00 "Total cases AVERTED A16 S0"

label var TotDeaMeRaA16S00 "Total deaths A16 S0"

label var TotDeYMeRaA16S00 "Total deaths COUNTERFACTUAL A16 S0"

label var TotDexMeRaA16S00 "Total deaths AVERTED A16 S0"

label var DayVaxMeRaA16S00 "Daily fully vaccinated persons A16 S0"




* gen cfr

gen DayCfrMeRaA16S00 = 100 * DayDeaMeRaA16S00 / DayCasMeRaA16S00

label var DayCfrMeRaA16S00 "Daily CFR Mean CSIM S0"




***********************

* graphs

* name CSIM graphs files starting with 0 to diff them from graphs from do merge, to which CSIM are to be added below. 

grstyle init

grstyle color background white


* daily deaths

* daily deaths (estimated)

twoway  ///
(line DayDeaMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths estimated) title("COVID-19 daily deaths, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
  	   
graph save "graph 01 COVID-19 daily deaths, Iran, CSIM.gph", replace
graph export "graph 01 COVID-19 daily deaths, Iran, CSIM.pdf", replace



* daily deaths, COUNTERFACTUAL

twoway  ///
(line DayDeYMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths COUNTERFACTUAL) title("COVID-19 daily deaths COUNTERFACTUAL, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
  	   
graph save "graph 02 COVID-19 daily deaths COUNTERFACTUAL, Iran, CSIM.gph", replace
graph export "graph 02 COVID-19 daily deaths COUNTERFACTUAL, Iran, CSIM.pdf", replace



* daily deaths, AVERTED

twoway  ///
(line DayDexMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths AVERTED) title("COVID-19 daily deaths AVERTED, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
  	   
graph save "graph 03 COVID-19 daily deaths AVERTED, Iran, CSIM.gph", replace
graph export "graph 03 COVID-19 daily deaths AVERTED, Iran, CSIM.pdf", replace



* daily deaths, (estimated), COUNTERFACTUAL, AVERTED (3 types)

twoway  ///
(line DayDeaMeRaA16S00 date, sort lcolor(black)) /// (estimated)
(line DayDexMeRaA16S00 date, sort lcolor(green)) /// AVERTED
(line DayDeYMeRaA16S00 date, sort lcolor(red)) /// COUNTERFACTUAL
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Estimated" 2 "Averted" 3 "Counterfactual") size(small) rows(1))	
  	   
graph save "graph 04 COVID-19 daily deaths, 3 types, Iran, CSIM.gph", replace
graph export "graph 04 COVID-19 daily deaths, 3 types, Iran, CSIM.pdf", replace



* total deaths 

* total deaths (estimated)

twoway  ///
(line TotDeaMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths estimated) title("COVID-19 total deaths, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
  	   
graph save "graph 05 COVID-19 total deaths, Iran, CSIM.gph", replace
graph export "graph 05 COVID-19 total deaths, Iran, CSIM.pdf", replace



* total deaths, COUNTERFACTUAL

twoway  ///
(line TotDeYMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths COUNTERFACTUAL) title("COVID-19 total deaths COUNTERFACTUAL, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
  	   
graph save "graph 06 COVID-19 total deaths COUNTERFACTUAL, Iran, CSIM.gph", replace
graph export "graph 06 COVID-19 total deaths COUNTERFACTUAL, Iran, CSIM.pdf", replace



* total deaths, AVERTED

twoway  ///
(line TotDexMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths AVERTED) title("COVID-19 total deaths AVERTED, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
  	   
graph save "graph 07 COVID-19 total deaths AVERTED, Iran, CSIM.gph", replace
graph export "graph 07 COVID-19 total deaths AVERTED, Iran, CSIM.pdf", replace



* total deaths, (estimated), COUNTERFACTUAL, AVERTED (3 types)

twoway  ///
(line TotDeaMeRaA16S00 date, sort lcolor(black)) /// (estimated)
(line TotDexMeRaA16S00 date, sort lcolor(green)) /// AVERTED
(line TotDeYMeRaA16S00 date, sort lcolor(red)) /// COUNTERFACTUAL
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Estimated" 2 "Averted" 3 "Counterfactual") size(small) rows(1))	
  	   
graph save "graph 08 COVID-19 total deaths, 3 types, Iran, CSIM.gph", replace
graph export "graph 08 COVID-19 total deaths, 3 types, Iran, CSIM.pdf", replace








* daily cases

* daily cases (estimated)

twoway  ///
(line DayCasMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases estimated) title("COVID-19 daily cases, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
  	   
graph save "graph 011 COVID-19 daily cases, Iran, CSIM.gph", replace
graph export "graph 011 COVID-19 daily cases, Iran, CSIM.pdf", replace



* daily cases, COUNTERFACTUAL

twoway  ///
(line DayCaYMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases COUNTERFACTUAL) title("COVID-19 daily cases COUNTERFACTUAL, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
  	   
graph save "graph 012 COVID-19 daily cases COUNTERFACTUAL, Iran, CSIM.gph", replace
graph export "graph 012 COVID-19 daily cases COUNTERFACTUAL, Iran, CSIM.pdf", replace



* daily cases, AVERTED

twoway  ///
(line DayCaxMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases AVERTED) title("COVID-19 daily cases AVERTED, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
  	   
graph save "graph 013 COVID-19 daily cases AVERTED, Iran, CSIM.gph", replace
graph export "graph 013 COVID-19 daily cases AVERTED, Iran, CSIM.pdf", replace



* daily cases, (estimated), COUNTERFACTUAL, AVERTED (3 types)

twoway  ///
(line DayCasMeRaA16S00 date, sort lcolor(black)) /// (estimated)
(line DayCaxMeRaA16S00 date, sort lcolor(green)) /// AVERTED
(line DayCaYMeRaA16S00 date, sort lcolor(red)) /// COUNTERFACTUAL
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Estimated" 2 "Averted" 3 "Counterfactual") size(small) rows(1))	
  	   
graph save "graph 014 COVID-19 daily cases, 3 types, Iran, CSIM.gph", replace
graph export "graph 014 COVID-19 daily cases, 3 types, Iran, CSIM.pdf", replace



* total cases 

* total cases (estimated)

twoway  ///
(line TotCasMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases estimated) title("COVID-19 total cases, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
  	   
graph save "graph 015 COVID-19 total cases, Iran, CSIM.gph", replace
graph export "graph 015 COVID-19 total cases, Iran, CSIM.pdf", replace



* total cases, COUNTERFACTUAL

twoway  ///
(line TotCaYMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases COUNTERFACTUAL) title("COVID-19 total cases COUNTERFACTUAL, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
  	   
graph save "graph 016 COVID-19 total cases COUNTERFACTUAL, Iran, CSIM.gph", replace
graph export "graph 016 COVID-19 total cases COUNTERFACTUAL, Iran, CSIM.pdf", replace



* total cases, AVERTED

twoway  ///
(line TotCaxMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases AVERTED) title("COVID-19 total cases AVERTED, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	
  	   
graph save "graph 017 COVID-19 total cases AVERTED, Iran, CSIM.gph", replace
graph export "graph 017 COVID-19 total cases AVERTED, Iran, CSIM.pdf", replace



* total cases, (estimated), COUNTERFACTUAL, AVERTED (3 types)

twoway  ///
(line TotCasMeRaA16S00 date, sort lcolor(black)) /// (estimated)
(line TotCaxMeRaA16S00 date, sort lcolor(green)) /// AVERTED
(line TotCaYMeRaA16S00 date, sort lcolor(red)) /// COUNTERFACTUAL
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Estimated" 2 "Averted" 3 "Counterfactual") size(small) rows(1))	
  	   
graph save "graph 018 COVID-19 total cases, 3 types, Iran, CSIM.gph", replace
graph export "graph 018 COVID-19 total cases, 3 types, Iran, CSIM.pdf", replace







* cfr and R

* daily cfr 

twoway  ///
(line DayCfrMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	

graph save "graph 021 COVID-19 daily CFR, Iran, CSIM.gph", replace
graph export "graph 021 COVID-19 daily CFR, Iran, CSIM.pdf", replace



* daily Rt

twoway  ///
(line DayRttMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily Rt) title("COVID-19 daily Rt, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	

graph save "graph 022 COVID-19 daily Rt, Iran, CSIM.gph", replace
graph export "graph 022 COVID-19 daily Rt, Iran, CSIM.pdf", replace



* daily Reff

twoway  ///
(line DayRefMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily Reff) title("COVID-19 daily Reff, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand)	

graph save "graph 023 COVID-19 daily Reff, Iran, CSIM.gph", replace
graph export "graph 023 COVID-19 daily Reff, Iran, CSIM.pdf", replace





* hospital: daily hospitalisations, critical care

twoway ///
(line DayHosMeRaA16S00 date, sort lcolor(green)) ///
(line DayIciMeRaA16S00 date, sort lcolor(black)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcome) title("COVID-19 daily cases, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Hospitalisations" 2 "Critical care") rows(1)) 
	   
graph save "graph 031 COVID-19 hospital, Iran, CSIM.gph", replace
graph export "graph 031 COVID-19 hospital, Iran, CSIM.pdf", replace





* vaccine: fully vaccinated persons (Vax)

twoway  ///
(line TotVaxMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total fully vaccinated persons) title("COVID-19 daily Total fully vaccinated persons, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
yscale(titlegap(7) outergap(3))	ylabel(, angle(forty_five))

graph save "graph 041 COVID-19 Total fully vaccinated persons, Iran, CSIM.gph", replace
graph export "graph 041 COVID-19 Total fully vaccinated persons, Iran, CSIM.pdf", replace



twoway  ///
(line DayVaxMeRaA16S00 date, sort lcolor(green)) ///
if loc_grand_name == "Iran" & date >= td(01jan2020) & date <= td(31dec2022), legend(off) ///	   
xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily fully vaccinated persons) title("COVID-19 Daily Total fully vaccinated persons, Iran, CSIM, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
yscale(titlegap(7) outergap(3))	ylabel(, angle(forty_five))

graph save "graph 042 COVID-19 Daily fully vaccinated persons, Iran, CSIM.gph", replace
graph export "graph 042 COVID-19 Daily fully vaccinated persons, Iran, CSIM.pdf", replace




sort date loc_grand_name

qui compress

save "Iran CSIM.dta", replace



*********************************************************************************************************

* Here is the end of curation of CSIM (COVID SIMULATION, Imperial College) default model for Iran.


* Add curated CSIM to other models:


* use "Iran.dta" from code|merge|Iran.dta and avoid / or \


cd ..

cd merge

use "Iran.dta", clear 

cd ..

cd CSIM

save "Iran.dta", replace

merge m:m date using "Iran CSIM.dta"

drop _merge

save "Iran with CSIM.dta", replace


* use do merge graphs template and add CSIM estimates, name graph files starting with 9




* daily deaths, median or reference scenario

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDeaMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
(line DayDeaMeRaA16S00 date, sort lcolor(brown)) /// 7 CSIM (estimated)
(line DayDexMeRaA16S00 date, sort lcolor(brown) lpattern(dash)) /// 8 CSIM AVERTED
(line DayDeYMeRaA16S00 date, sort lcolor(brown) lpattern(tight_dot) lwidth(thick)) /// 9 CSIM COUNTERFACTUAL
if date >= td(01jan2020) & date <= td(31dec2022) ///
, xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV" ///
7 "CSIM Estimated" 8 "CSIM Averted" 9 "CSIM Counterfactual") size(small) row(2)) ///
subtitle("  .", size(small) color(white)) 

graph save "graph 911 COVID-19 daily deaths, Iran, reference scenarios.gph", replace
graph export "graph 911 COVID-19 daily deaths, Iran, reference scenarios.pdf", replace



* daily deaths, median or reference scenario, 2020-12-01 on

twoway ///
(line DayDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDeaMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
(line DayDeaMeRaA16S00 date, sort lcolor(brown)) /// 7 CSIM (estimated)
(line DayDexMeRaA16S00 date, sort lcolor(brown) lpattern(dash)) /// 8 CSIM AVERTED
(line DayDeYMeRaA16S00 date, sort lcolor(brown) lpattern(tight_dot) lwidth(thick)) /// 9 CSIM COUNTERFACTUAL
if date >= td(20dec2020) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22270 22300 22330 22360 22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV" ///
7 "CSIM Estimated" 8 "CSIM Averted" 9 "CSIM Counterfactual") size(small) row(2)) ///
subtitle("after 2020-12-01", size(small)) 

graph save "graph 913 COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on.gph", replace
graph export "graph 913 COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on.pdf", replace




* daily cases, median or reference scenario

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCasMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCasMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
(line DayCasMeRaA16S00 date, sort lcolor(brown)) /// 7 CSIM (estimated)
(line DayCaxMeRaA16S00 date, sort lcolor(brown) lpattern(dash)) /// 8 CSIM AVERTED
(line DayCaYMeRaA16S00 date, sort lcolor(brown) lpattern(tight_dot) lwidth(thick)) /// 9 CSIM COUNTERFACTUAL
if date >= td(01jan2020) & date <= td(31dec2022) ///
, xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV" ///
7 "CSIM Estimated" 8 "CSIM Averted" 9 "CSIM Counterfactual") size(small) row(2)) ///
subtitle("  .", size(small) color(white)) 

graph save "graph 921 COVID-19 daily cases, Iran, reference scenarios.gph", replace
graph export "graph 921 COVID-19 daily cases, Iran, reference scenarios.pdf", replace




* daily cases, median or reference scenario, 2020-12-01 on

twoway ///
(line DayCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCasMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCasMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCasMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCasMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
(line DayCasMeRaA16S00 date, sort lcolor(brown)) /// 7 CSIM (estimated)
(line DayCaxMeRaA16S00 date, sort lcolor(brown) lpattern(dash)) /// 8 CSIM AVERTED
(line DayCaYMeRaA16S00 date, sort lcolor(brown) lpattern(tight_dot) lwidth(thick)) /// 9 CSIM COUNTERFACTUAL
if date >= td(20dec2020) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(22270 22300 22330 22360 22391 22422 22453 22484 22515 22546, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV" ///
7 "CSIM Estimated" 8 "CSIM Averted" 9 "CSIM Counterfactual") size(small) row(2)) ///
subtitle("after 2020-12-01", size(small)) ///
ttext(0 21dec2020  "Dey"  0 20jan2021  "Bah" 0 19feb2021  "Esf" ///
0 21mar2021  "00"   0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir"  0 23jul2021  "Mor" 0 23Aug2021  "Sha" ///
0 23Sep2021  "Meh"  , size(small) color(black) placement(south))

graph save "graph 923 COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on.gph", replace
graph export "graph 923 COVID-19 daily cases, Iran, reference scenarios, 2020-12-01 on.pdf", replace



* total deaths, median or reference scenario

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDeaMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
(line TotDeaMeRaA16S00 date, sort lcolor(brown)) /// 7 CSIM (estimated)
(line TotDexMeRaA16S00 date, sort lcolor(brown) lpattern(dash)) /// 8 CSIM AVERTED
(line TotDeYMeRaA16S00 date, sort lcolor(brown) lpattern(tight_dot) lwidth(thick)) /// 9 CSIM COUNTERFACTUAL
if date >= td(01jan2020) & date <= td(31dec2022) ///
, xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV" ///
7 "CSIM Estimated" 8 "CSIM Averted" 9 "CSIM Counterfactual") size(small) row(2)) ///
subtitle("  .", size(small) color(white))

graph save "graph 931 COVID-19 total deaths, Iran, reference scenarios.gph", replace
graph export "graph 931 COVID-19 total deaths, Iran, reference scenarios.pdf", replace




* total deaths, median or reference scenario, 2020-12-01 on

twoway ///
(line TotDeaMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotDeaMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotDeaMeSmA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotDeaMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotDeaMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotDeaMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
(line TotDeaMeRaA16S00 date, sort lcolor(brown)) /// 7 CSIM (estimated)
(line TotDexMeRaA16S00 date, sort lcolor(brown) lpattern(dash)) /// 8 CSIM AVERTED
(line TotDeYMeRaA16S00 date, sort lcolor(brown) lpattern(tight_dot) lwidth(thick)) /// 9 CSIM COUNTERFACTUAL
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV" ///
7 "CSIM Estimated" 8 "CSIM Averted" 9 "CSIM Counterfactual") size(small) row(2)) ///
subtitle("after 2020-12-01", size(small))

graph save "graph 933 COVID-19 total deaths, Iran, reference scenarios, 2020-12-01 on.gph", replace
graph export "graph 933 COVID-19 total deaths, Iran, reference scenarios, 2020-12-01 on.pdf", replace




* total cases, median or reference scenario

twoway ///
(line TotCasMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line TotCasMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line TotCasMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line TotCasMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line TotCasMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line TotCasMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
(line TotCasMeRaA16S00 date, sort lcolor(brown)) /// 7 CSIM (estimated)
(line TotCaxMeRaA16S00 date, sort lcolor(brown) lpattern(dash)) /// 8 CSIM AVERTED
(line TotCaYMeRaA16S00 date, sort lcolor(brown) lpattern(tight_dot) lwidth(thick)) /// 9 CSIM COUNTERFACTUAL
if date >= td(01jan2020) & date <= td(31dec2022) ///
, xtitle(Date) xlabel(#36, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV" ///
7 "CSIM Estimated" 8 "CSIM Averted" 9 "CSIM Counterfactual") size(small) row(2)) ///
subtitle("  .", size(small) color(white))

graph save "graph 941 COVID-19 total cases, Iran, reference scenarios.gph", replace
graph export "graph 941 COVID-19 total cases, Iran, reference scenarios.pdf", replace





* cfr all studies, all time, reference scenarios

twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCfrMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCfrMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCfrMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCfrMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCfrMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
(line DayCfrMeRaA16S00 date, sort lcolor(brown)) /// 7 "CSIM"
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV" ///
7 "CSIM") size(small) row(1)) ///
subtitle("  .", size(small) color(white))

graph save "graph 951 COVID-19 daily CFR, Iran, reference scenarios.gph", replace
graph export "graph 951 COVID-19 daily CFR, Iran, reference scenarios.pdf", replace



* cfr all studies, 2021-01-01 on, reference scenarios

twoway ///
(line DayCfrMeRaA00S00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCfrMeRaA01S00 date, sort lcolor(red)) /// 2 "DELP"
(line DayCfrMeRaA02S01 date, sort lcolor(black)) /// 3 "IHME"
(line DayCfrMeRaA03S02 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCfrMeRaA04S00 date, sort lcolor(gold)) /// 5 "LANL"
(line DayCfrMeRaA05S00 date, sort lcolor(green)) /// 6 "SRIV"
(line DayCfrMeRaA16S00 date, sort lcolor(brown)) /// 7 "CSIM"
if date >= td(01jan2021) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#12, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily CFR) title("COVID-19 daily CFR, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV" ///
7 "CSIM") size(small) row(1)) ///
subtitle("after 2021-01-01", size(small))

graph save "graph 952 COVID-19 daily CFR, Iran, reference scenarios, 2021-01-01 on.gph", replace
graph export "graph 952 COVID-19 daily CFR, Iran, reference scenarios,2021-01-01 on.pdf", replace




* base codes with IHME and IMPE, all hospital-related outcomes + CSIM

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red)  lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayBedMeSmA02S01 date, sort lcolor(black)) /// 3 IHME Bed need (Daily Beds needed Mean IHME S1)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 4 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 5 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayIcnMeSmA02S01 date, sort lcolor(blue)) /// 6 IHME ICU new (Daily new people going to ICU Mean IHME S1)
(line DayHodMeRaA03S01 date, sort lcolor(magenta)) /// 7 IMPE Hosp demand (Daily hospital demand Mean A03 S01 )
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 8 IMPE ICU demand (Daily ICU demand Mean A03 S01)
(line DayHosMeRaA16S00 date, sort lcolor(brown)) /// 9 CSIM Hospitalisations
(line DayIciMeRaA16S00 date, sort lcolor(brown) lpattern(dash_dot)) /// 10 CSIM Critical care
if date >= td(01jan2020) & date <= td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, median scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME Bed need" 4 "IHME ICU need" ///
5 "IHME Admissions" 6 "IHME ICU new" 7 "IMPE Hosp demand" ///
8 "IMPE ICU demand" 9 "CSIM Hospitalisations" 10 "CSIM Critical care") rows(4) size(small)) ///
subtitle("  .", size(small) color(white))

graph save "graph 971 COVID-19 hospital-related outcomes.gph", replace
graph export "graph 971 COVID-19 hospital-related outcomes.pdf", replace




* daily hospital-related outcomes, DELP, IHME, IMPE, wo IHME Bed need, IMPE Hosp demand, 2020-12-01 on + CSIM

twoway ///
(line DayHosMeRaA01S00 date, sort lcolor(red)  lwidth(thick)) /// 1 DELP Hospitalized (Daily Cases Active Hospitalized Mean DELP S0)
(line DayVenMeRaA01S00 date, sort lcolor(red) lpattern(dash)  lwidth(thick)) /// 2 DELP Ventilated (Daily Cases Active Ventilated Mean DELP S0)
(line DayIcuMeSmA02S01 date, sort lcolor(green)) /// 3 IHME ICU need (Daily ICU beds needed Mean IHME S1)
(line DayAdmMeSmA02S01 date, sort lcolor(yellow)) /// 4 IHME Admissions (Daily hospital admissions Mean IHME S1)
(line DayIcnMeSmA02S01 date, sort lcolor(blue)) /// 5 IHME ICU new (Daily new people going to ICU Mean IHME S1)
(line DayIcdMeRaA03S01 date, sort lcolor(magenta) lpattern(dash_dot)) /// 6 IMPE ICU demand (Daily ICU demand Mean A03 S01)
(line DayHosMeRaA16S00 date, sort lcolor(brown)) /// 7 CSIM Hospitalisations
(line DayIciMeRaA16S00 date, sort lcolor(brown) lpattern(dash_dot)) /// 8 CSIM Critical care
if date >= td(21apr2021) & date <= td(23Sep2021) ///
, xtitle(Date) xlabel(#8, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily outcomes) title("COVID-19 daily hospital-related outcomes Iran, median scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP Hospitalized" 2 "DELP Ventilated" 3 "IHME ICU need" ///
4 "IHME Admissions" 5 "IHME ICU new" 6 "IMPE ICU demand" 7 "CSIM Hospitalisations" 8 "CSIM Critical care") rows(3) size(small)) ///
subtitle("after Ordibehesht 1400, without IHME Bed need, IMPE Hosp demand", size(small))

graph save "graph 974 COVID-19 hospital-related outcomes, wo extremes, Ordibehesht 1400 on.gph", replace
graph export "graph 974 COVID-19 hospital-related outcomes, wo extremes, Ordibehesht 1400 on.pdf", replace





view "log Iran CSIM.smcl"

log close

exit, clear




