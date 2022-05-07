
clear all
 
cd "$pathcovir2"

cd WHO

capture log close 

log using "log country WHO.smcl", replace

******************************************************************************
* This is "do country WHO.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare WHO data for country
******************************************************************************




* Global excess deaths associated with COVID-19 (modelled estimates) 
* Most recent update: 5 May 2022
* Temporal coverage	1 January 2020 - 31 December 2021
* Source web page:
* https://www.who.int/data/sets/global-excess-deaths-associated-with-covid-19-modelled-estimates




* Get WHO data for country


clear

copy https://cdn.who.int/media/docs/default-source/world-health-data-platform/covid-19-excessmortality/2022-03-25_covid-19_gem.zip 2022-03-25_covid-19_gem.zip

unzipfile 2022-03-25_covid-19_gem.zip

import excel using "WHO_COVID_Excess_Deaths_EstimatesByCountry.xlsx", clear sheet("Country by year and month") cellrange(A13:K4669) firstrow

rename country loc_grand_name

keep if regexm(loc_grand_name,"$country") == 1

replace loc_grand_name = "Iran" if loc_grand_name == "Iran (Islamic Republic of)"

label var expectedmean "Expected deaths from all-causes by location, year and month (mean)"
label var acmmean "Estimated deaths from all-causes by location, year and month (mean)"
label var excessmean "Excess deaths associated with COVID-19 pandemic from all-causes by location, year and month (mean)"
label var cumulexcessmean "Cumulative excess deaths associated with COVID-19 pandemic (mean)"  
label var cumulexcesslow "Cumulative excess deaths associated with COVID-19 pandemic (lower 95% confidence interval)"
label var cumulexcesshigh "Cumulative excess deaths associated with COVID-19 pandemic (upper 95% confidence interval)"


gen DayDeXMeRaA06S00 = excessmean / 31
replace DayDeXMeRaA06S00 = excessmean / 30 if month == 4 | month == 6 | month == 9 | month == 11
replace DayDeXMeRaA06S00 = excessmean / 29 if month == 2 & year == 2020
replace DayDeXMeRaA06S00 = excessmean / 28 if month == 2 & year == 2021
label var DayDeXMeRaA06S00 "Daily Excess Deaths Raw Mean WHO S0"



* gen date

egen eom = eom(month year), f(%tdDDMonCCYY)
label var eom eomdate

expand 31 if month == 1 | month == 3 | month == 5 | month == 7 | month == 8 | month == 10 | month == 12
expand 30 if month == 4 | month == 6 | month == 9 | month == 11
expand 29 if month == 2 & year == 2020
expand 28 if month == 2 & year == 2021

sort eom

egen yearmonth = group(year month), label lname(name) 

bysort yearmonth: gen day = [_n]

gen yearnew = year
tostring yearnew, replace

gen monthnew = month
tostring monthnew, replace
replace monthnew = "01" if monthnew == "1"
replace monthnew = "02" if monthnew == "2"
replace monthnew = "03" if monthnew == "3"
replace monthnew = "04" if monthnew == "4"
replace monthnew = "05" if monthnew == "5"
replace monthnew = "06" if monthnew == "6"
replace monthnew = "07" if monthnew == "7"
replace monthnew = "08" if monthnew == "8"
replace monthnew = "09" if monthnew == "9"

gen daynew = day
tostring daynew, replace
replace daynew = "01" if daynew == "1"
replace daynew = "02" if daynew == "2"
replace daynew = "03" if daynew == "3"
replace daynew = "04" if daynew == "4"
replace daynew = "05" if daynew == "5"
replace daynew = "06" if daynew == "6"
replace daynew = "07" if daynew == "7"
replace daynew = "08" if daynew == "8"
replace daynew = "09" if daynew == "9"

egen date2 = concat(daynew monthnew yearnew)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date


* smooth

tsset date, daily   

tssmooth ma DayDeXMeRaA06S00_window = DayDeXMeRaA06S00, window(3 1 3)

tssmooth ma DayDeXMeSmA06S00 = DayDeXMeRaA06S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeXMeSmA06S00 "Daily Excess Deaths Smooth Mean WHO S0"
          
drop DayDeXMeRaA06S00_window

tsset, clear

keep loc_grand_name DayDeXMeRaA06S00 DayDeXMeSmA06S00 date


qui compress

save "country WHO.dta", replace





view "log country WHO.smcl"

log close

exit, clear




