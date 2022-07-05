
clear all

cd "$pathcovir2"

cd MEDRIVA

capture log close 

log using "log country MEDRIVA.smcl", replace

*****************************************************************************
* This is "do country MEDRIVA.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare MEDRIVA data for country
*****************************************************************************


																 

clear 

*****************************

* get MEDRIVA estimates

di "$MEDRIVAdate"

* Source web page:
* https://charts.medriva.com/country/IR

* "MEDRIVA $MEDRIVAdate.csv" is scraped from https://charts.medriva.com/country/IR

 
 
 
******************************

* import data file - "basic data"

import excel "MEDRIVA $MEDRIVAdate.xlsx", clear sheet("basic data") firstrow case(lower) 


* gen date

drop if date == "Date"

gen row = _n

gsort -row

gen grow = _n 

gen year = ""

replace year = "2020" if grow <= 302

replace year = "2021" if grow >= 303 & grow <= 667

replace year = "2022" if grow >= 668 

sort row

drop row grow

gen day = substr(date,1,2)

gen month = substr(date,4,3)

rename date date_original

gen date2 = day + month + year

gen date = date(date2, "DMY", 2050)

format date %tdDDMonCCYY

drop date_original	year	day	month	date2

codebook date




* omit incomplete data lines

drop if date == td(05Mar2020) // missing newcases newdeaths newtests

drop if totaltests == "-" // tests data is the added value of this "basic data"

drop if date == td(03Jul2022) // incomplete data






* destring vars
		
destring totalcases totaldeaths totaltests, replace

replace newcases = "." if newcases == "-"
replace newdeaths = "." if newdeaths == "-"
replace newtests = "." if newtests == "-"

destring newcases newdeaths newtests, replace


replace newdeaths = 0 if newdeaths == . // zero daily deaths are recoded as "-" in this data



qui compress

save "MEDRIVA basic data $MEDRIVAdate.dta", replace

*









******************************

* import data file - "hospital data"

import excel "MEDRIVA $MEDRIVAdate.xlsx", clear sheet("hospital data") firstrow case(lower) 



* rename vars

rename currentlyinhospital inhospitalnow

rename change inhospitalchange

rename currentlyinicu inicunow

rename e inicuchange





* gen date

drop if date == "Date"

gen row = _n

gsort -row

gen grow = _n 

gen year = ""

replace year = "2020" if grow <= 302

replace year = "2021" if grow >= 303 & grow <= 667

replace year = "2022" if grow >= 668 

sort row

drop row grow

gen day = substr(date,1,2)

gen month = substr(date,4,3)

rename date date_original

gen date2 = day + month + year

gen date = date(date2, "DMY", 2050)

format date %tdDDMonCCYY

drop date_original	year	day	month	date2

codebook date




* omit incomplete data lines

drop if date == td(03Jul2022) // incomplete data

replace inicuchange = "." if date == td(13Jun2022) // zero is recorded as "-"

drop if inicuchange == "-" // incomplete data




* destring vars
		
destring inicunow inicuchange, replace

replace inhospitalnow = "." if inhospitalnow == "-"
replace inhospitalchange = "." if inhospitalchange == "-"

destring inhospitalnow inhospitalchange, replace

qui compress

save "MEDRIVA hospital data $MEDRIVAdate.dta", replace

*










******************************

* import data file - "percent positive"

import delimited using "percent positive $MEDRIVAdate.txt", clear delimiters(",")


* percentpositive7dayaverage
* Inspect element, lookfor 14.6
* First 14.6 is 4 July 2021 
* Last 4.2 is 1 July 2022

gen id = _n 

reshape long v, i(id) j(j) 




* gen date

gen date = .

replace date = td(04Jul2021) in 1

replace date = date[_n-1] + 1 in 2/l

format date %tdDDMonCCYY

codebook date

* 

rename v percentpositive7dayaverage

label var percentpositive7dayaverage "% positive 7-day average"

drop id j


qui compress

save "MEDRIVA percent positive data $MEDRIVAdate.dta", replace






*************

* merge data files


use "MEDRIVA basic data $MEDRIVAdate.dta", clear

merge m:m date using "MEDRIVA hospital data $MEDRIVAdate.dta"

drop _merge

merge m:m date using "MEDRIVA percent positive data $MEDRIVAdate.dta"

drop _merge

sort date

qui compress

save "country MEDRIVA.dta", replace






************

* graphs 

grstyle init

grstyle color background white



****************************

* daily tests, MEDRIVA, 2020 on

twoway ///
(line newtests date, sort lcolor(blue) lwidth(medium) yaxis(1)) /// 
(line percentpositive7dayaverage date, sort lcolor(red) lwidth(medium) yaxis(2)) /// 
if date >= td(01jan2020) ///
, xtitle(Date) xlabel(, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ///
ylabel(, format(%9.0fc) labsize(small) axis(1))  ylabel(, labsize(small) angle(horizontal) axis(1)) ///
ylabel(, format(%9.0fc) labsize(small) axis(2))  ylabel(, labsize(small) angle(horizontal) axis(2)) ///
ytitle("Daily tests", axis(1)) ytitle("% positive 7-day average", axis(2)) ///
title("COVID-19 daily tests, $country, MEDRIVA", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) ytitle(, color(blue) axis(1)) ytitle(, color(red) axis(2)) ///
yscale(lwidth(vthin) lcolor(gray*.2) axis(1)) yscale(lwidth(vthin) lcolor(gray*.2) axis(2)) ///
legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "Daily tests" 2 "% positive 7-day average") size(small) row(1))

 

graph export "graph 1 COVID-19 daily tests, $country, MEDRIVA.pdf", replace







view "log country MEDRIVA.smcl"

log close

exit, clear
