
clear all

cd "$pathcovir2"

cd SRIV

capture log close 

log using "log Iran SRIV win.smcl", replace

***************************************************************************
* This is "do Iran SRIV win.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time: 2021-02-10

* OBJECTIVE: Get and prepare SRIV data for Iran, Locate peak dates and values
***************************************************************************


* Get SRIV estimates 

copy https://codeload.github.com/scc-usc/ReCOVER-COVID-19/zip/master ReCOVER-COVID-19-master.zip
di in red "Wait until unzipping SRIV ReCOVER-COVID-19-master.zip below is complete."
qui unzipfile ReCOVER-COVID-19-master.zip, replace
erase ReCOVER-COVID-19-master.zip



/*

Scenarios:

Three scenarios of interventions (current, released, restricted) 
and 6 values of gamma (reciprocal of probability for 
unreported cases to be reported) make 18 total scenarios. 


S1 = current1 = current level of interventions and reciprocal of gamma is 1 = current, worse
S2 = current2 = current level of interventions and reciprocal of gamma is 2 = current, default
S3 = current5 = current level of interventions and reciprocal of gamma is 5 = current, better
S4 = current10 = current level of interventions and reciprocal of gamma is 10 (current extreme)
S5 = current20 = current level of interventions and reciprocal of gamma is 20 (current extreme)
S6 = current40 = current level of interventions and reciprocal of gamma is 40 (current extreme)

S7 = released1 = released level of interventions and reciprocal of gamma is 1 = released, worse
S8 = released2 = released level of interventions and reciprocal of gamma is 2 = released, default
S9 = released5 = released level of interventions and reciprocal of gamma is 5 = released, better
S10 = released10 = released level of interventions and reciprocal of gamma is 10 (released extreme)
S11 = released20 = released level of interventions and reciprocal of gamma is 20 (released extreme)
S12 = released40 = released level of interventions and reciprocal of gamma is 40 (released extreme)

S13 = restricted1 = restricted level of interventions and reciprocal of gamma is 1 = restricted, worse
S14 = restricted2 = restricted level of interventions and reciprocal of gamma is 2 = restricted, default
S15 = restricted5 = restricted level of interventions and reciprocal of gamma is 5 = restricted, better
S16 = restricted10 = restricted level of interventions and reciprocal of gamma is 10 (restricted extreme)
S17 = restricted20 = restricted level of interventions and reciprocal of gamma is 20 (restricted extreme)
S18 = restricted40 = restricted level of interventions and reciprocal of gamma is 40 (restricted extreme)

Q: Where are their confidence intervals? A: Nowhere. None. 

*/




* estimates files are in the follwing path:


cd ReCOVER-COVID-19-master

cd results

cd forecasts



*******************************************************************************

* read deaths csv files


* get dates 


import delimited "global_deaths_current_1.csv", clear varnames(1)

keep if strpos(country, "Iran")

codebook 


/*

dates
v3 to v16 = 14 vars (dates)

1.	v3  2021-03-06
2.	v4  2021-03-13 
3.	v5  2021-03-20
4.	v6  2021-03-27      
5.	v7  2021-04-03      
6.	v8  2021-04-10
7.	v9  2021-04-17
8.	v10 2021-04-24
9.	v11 2021-05-01
10.	v12 2021-05-08
11.	v13 2021-05-15
12.	v14 2021-05-22
13.	v15 2021-05-29
14.	v16 2021-06-05


*/

 di (13 * 7) + 1
 
 
*

import delimited "global_forecasts_restricted_40.csv", clear varnames(1)

keep if strpos(country, "Iran")

codebook 
 
 
/*

dates
v3 to v16 = 14 vars (dates)

1.	v3  2021-03-06
2.	v4  2021-03-13 
3.	v5  2021-03-20
4.	v6  2021-03-27      
5.	v7  2021-04-03      
6.	v8  2021-04-10
7.	v9  2021-04-17
8.	v10 2021-04-24
9.	v11 2021-05-01
10.	v12 2021-05-08
11.	v13 2021-05-15
12.	v14 2021-05-22
13.	v15 2021-05-29
14.	v16 2021-06-05

*/
 
 
 
  
 
 
 *
 

* Scenario group 1 is 'current'

foreach g in 1 2 5 10 20 40 {
	import delimited "global_deaths_current_`g'.csv", clear varnames(1)
	gen intervention = "1_current"
	gen rgamma = ""
	replace rgamma = "`g'"
	drop id
	save "global_deaths_current_`g'.dta", replace
}
*


* Scenario group 2 is 'released'

foreach g in 1 2 5 10 20 40 {
	import delimited "global_deaths_released_`g'.csv", clear varnames(1)
	gen intervention = "2_released"
	gen rgamma = ""
	replace rgamma = "`g'"
	drop id	
	save "global_deaths_released_`g'.dta", replace
}
*


* Scenario group 3 is 'restricted'

foreach g in 1 2 5 10 20 40 {
	import delimited "global_deaths_restricted_`g'.csv", clear varnames(1)
	gen intervention = "3_restricted"
	gen rgamma = ""
	replace rgamma = "`g'"
	drop id
	save "global_deaths_restricted_`g'.dta", replace
}
*




*******************************************************************************

* append deaths files


clear 


foreach g in 1 2 5 10 20 40 {

	append using "global_deaths_current_`g'.dta"
}
*

save "global_deaths_current.dta", replace



foreach g in 1 2 5 10 20 40 {

	append using "global_deaths_released_`g'.dta"
}
*

save "global_deaths_released.dta", replace



foreach g in 1 2 5 10 20 40 {

	append using "global_deaths_restricted_`g'.dta"
}
*

save "global_deaths_restricted.dta", replace


append using "global_deaths_current.dta"


append using "global_deaths_released.dta"



keep if strpos(country, "Iran")

save "scenario.dta", replace



replace rgamma = "01" if rgamma == "1"
replace rgamma = "02" if rgamma == "2"
replace rgamma = "05" if rgamma == "5"

	
	

gen underline = "_"
egen scenario = concat(intervention underline rgamma)

drop intervention underline rgamma

drop country 

sort scenario

duplicates drop *, force


* reshape

reshape long v, i(scenario) j(date) string 



replace date = "2021-03-06" if date == "3"
replace date = "2021-03-13" if date == "4"
replace date = "2021-03-20" if date == "5"
replace date = "2021-03-27" if date == "6"
replace date = "2021-04-03" if date == "7"
replace date = "2021-04-10" if date == "8"
replace date = "2021-04-17" if date == "9"
replace date = "2021-04-24" if date == "10"
replace date = "2021-05-01" if date == "11"
replace date = "2021-05-08" if date == "12"
replace date = "2021-05-15" if date == "13"
replace date = "2021-05-22" if date == "14"
replace date = "2021-05-29" if date == "15"
replace date = "2021-06-05" if date == "16"


   
* gen date

rename date date_original

gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date

drop year month day date2 date_original


* reshape

rename v deaths_

order date deaths scenario

reshape wide deaths_, i (date) j(scenario) string	


sort date


save "scenario_reshape.dta", replace





*******************************************************************************

* read cases csv files


foreach g in 1 2 5 10 20 40 {
	import delimited "global_forecasts_current_`g'.csv", clear varnames(1)
	gen intervention = "1_current"
	gen rgamma = ""
	replace rgamma = "`g'"
	drop id

	save "global_forecasts_current_`g'.dta", replace

}
*



foreach g in 1 2 5 10 20 40 {
	import delimited "global_forecasts_released_`g'.csv", clear varnames(1)
	gen intervention = "2_released"
	gen rgamma = ""
	replace rgamma = "`g'"
	drop id	

	save "global_forecasts_released_`g'.dta", replace
	
}
*

foreach g in 1 2 5 10 20 40 {
	import delimited "global_forecasts_restricted_`g'.csv", clear varnames(1)
	gen intervention = "3_restricted"
	gen rgamma = ""
	replace rgamma = "`g'"
	drop id

	save "global_forecasts_restricted_`g'.dta", replace
	
}
*



*******************************************************************************

* append cases files 

clear 

foreach g in 1 2 5 10 20 40 {

	append using "global_forecasts_current_`g'.dta"	
	
	append using "global_forecasts_released_`g'.dta"	
	
	append using "global_forecasts_restricted_`g'.dta"	

}
*


keep if strpos(country, "Iran")


save "cases scenario.dta", replace



replace rgamma = "01" if rgamma == "1"
replace rgamma = "02" if rgamma == "2"
replace rgamma = "05" if rgamma == "5"


	

gen underline = "_"
egen scenario = concat(intervention underline rgamma)

drop intervention underline rgamma

drop country 

sort scenario 


* reshape

reshape long v, i(scenario) j(date) string 

replace date = "2021-03-06" if date == "3"
replace date = "2021-03-13" if date == "4"
replace date = "2021-03-20" if date == "5"
replace date = "2021-03-27" if date == "6"
replace date = "2021-04-03" if date == "7"
replace date = "2021-04-10" if date == "8"
replace date = "2021-04-17" if date == "9"
replace date = "2021-04-24" if date == "10"
replace date = "2021-05-01" if date == "11"
replace date = "2021-05-08" if date == "12"
replace date = "2021-05-15" if date == "13"
replace date = "2021-05-22" if date == "14"
replace date = "2021-05-29" if date == "15"
replace date = "2021-06-05" if date == "16"


rename v forecasts_

order date forecasts scenario

* reshape

reshape wide forecasts_, i (date) j(scenario) string	



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


sort date




save "cases scenario_reshape.dta", replace





**********************

* merge deaths and cases


merge 1:1 date using "scenario_reshape.dta"



drop _merge date_original



* rename Total Deaths

rename deaths_1_current_01 TotDeaMeRaA05S01V02
rename deaths_1_current_02 TotDeaMeRaA05S02V02
rename deaths_1_current_05 TotDeaMeRaA05S03V02
rename deaths_1_current_10 TotDeaMeRaA05S04V02
rename deaths_1_current_20 TotDeaMeRaA05S05V02
rename deaths_1_current_40 TotDeaMeRaA05S06V02
rename deaths_2_released_01 TotDeaMeRaA05S07V02
rename deaths_2_released_02 TotDeaMeRaA05S08V02
rename deaths_2_released_05 TotDeaMeRaA05S09V02
rename deaths_2_released_10 TotDeaMeRaA05S10V02
rename deaths_2_released_20 TotDeaMeRaA05S11V02
rename deaths_2_released_40 TotDeaMeRaA05S12V02
rename deaths_3_restricted_01 TotDeaMeRaA05S13V02
rename deaths_3_restricted_02 TotDeaMeRaA05S14V02
rename deaths_3_restricted_05 TotDeaMeRaA05S15V02
rename deaths_3_restricted_10 TotDeaMeRaA05S16V02
rename deaths_3_restricted_20 TotDeaMeRaA05S17V02
rename deaths_3_restricted_40 TotDeaMeRaA05S18V02

label var TotDeaMeRaA05S01V02 "Total Deaths Mean SRIV S01 ie S1P1 V02"
label var TotDeaMeRaA05S02V02 "Total Deaths Mean SRIV S02 ie S1P2 V02"
label var TotDeaMeRaA05S03V02 "Total Deaths Mean SRIV S03 ie S1P3 V02"
label var TotDeaMeRaA05S04V02 "Total Deaths Mean SRIV S04 ie S1P4 V02"
label var TotDeaMeRaA05S05V02 "Total Deaths Mean SRIV S05 ie S1P5 V02"
label var TotDeaMeRaA05S06V02 "Total Deaths Mean SRIV S06 ie S1P6 V02"
label var TotDeaMeRaA05S07V02 "Total Deaths Mean SRIV S07 ie S2P1 V02"
label var TotDeaMeRaA05S08V02 "Total Deaths Mean SRIV S08 ie S2P2 V02"
label var TotDeaMeRaA05S09V02 "Total Deaths Mean SRIV S09 ie S2P3 V02"
label var TotDeaMeRaA05S10V02 "Total Deaths Mean SRIV S10 ie S2P4 V02"
label var TotDeaMeRaA05S11V02 "Total Deaths Mean SRIV S11 ie S2P5 V02"
label var TotDeaMeRaA05S12V02 "Total Deaths Mean SRIV S12 ie S2P6 V02"
label var TotDeaMeRaA05S13V02 "Total Deaths Mean SRIV S13 ie S3P1 V02"
label var TotDeaMeRaA05S14V02 "Total Deaths Mean SRIV S14 ie S3P2 V02"
label var TotDeaMeRaA05S15V02 "Total Deaths Mean SRIV S15 ie S3P3 V02"
label var TotDeaMeRaA05S16V02 "Total Deaths Mean SRIV S16 ie S3P4 V02"
label var TotDeaMeRaA05S17V02 "Total Deaths Mean SRIV S17 ie S3P5 V02"
label var TotDeaMeRaA05S18V02 "Total Deaths Mean SRIV S18 ie S3P6 V02"


*


* rename Total cases

rename forecasts_1_current_01 TotCasMeRaA05S01V02
rename forecasts_1_current_02 TotCasMeRaA05S02V02
rename forecasts_1_current_05 TotCasMeRaA05S03V02
rename forecasts_1_current_10 TotCasMeRaA05S04V02
rename forecasts_1_current_20 TotCasMeRaA05S05V02
rename forecasts_1_current_40 TotCasMeRaA05S06V02
rename forecasts_2_released_01 TotCasMeRaA05S07V02
rename forecasts_2_released_02 TotCasMeRaA05S08V02
rename forecasts_2_released_05 TotCasMeRaA05S09V02
rename forecasts_2_released_10 TotCasMeRaA05S10V02
rename forecasts_2_released_20 TotCasMeRaA05S11V02
rename forecasts_2_released_40 TotCasMeRaA05S12V02
rename forecasts_3_restricted_01 TotCasMeRaA05S13V02
rename forecasts_3_restricted_02 TotCasMeRaA05S14V02
rename forecasts_3_restricted_05 TotCasMeRaA05S15V02
rename forecasts_3_restricted_10 TotCasMeRaA05S16V02
rename forecasts_3_restricted_20 TotCasMeRaA05S17V02
rename forecasts_3_restricted_40 TotCasMeRaA05S18V02

label var TotCasMeRaA05S01V02 "Total Cases Mean SRIV S01 ie S1P1 V02"
label var TotCasMeRaA05S02V02 "Total Cases Mean SRIV S02 ie S1P2 V02"
label var TotCasMeRaA05S03V02 "Total Cases Mean SRIV S03 ie S1P3 V02"
label var TotCasMeRaA05S04V02 "Total Cases Mean SRIV S04 ie S1P4 V02"
label var TotCasMeRaA05S05V02 "Total Cases Mean SRIV S05 ie S1P5 V02"
label var TotCasMeRaA05S06V02 "Total Cases Mean SRIV S06 ie S1P6 V02"
label var TotCasMeRaA05S07V02 "Total Cases Mean SRIV S07 ie S2P1 V02"
label var TotCasMeRaA05S08V02 "Total Cases Mean SRIV S08 ie S2P2 V02"
label var TotCasMeRaA05S09V02 "Total Cases Mean SRIV S09 ie S2P3 V02"
label var TotCasMeRaA05S10V02 "Total Cases Mean SRIV S10 ie S2P4 V02"
label var TotCasMeRaA05S11V02 "Total Cases Mean SRIV S11 ie S2P5 V02"
label var TotCasMeRaA05S12V02 "Total Cases Mean SRIV S12 ie S2P6 V02"
label var TotCasMeRaA05S13V02 "Total Cases Mean SRIV S13 ie S3P1 V02"
label var TotCasMeRaA05S14V02 "Total Cases Mean SRIV S14 ie S3P2 V02"
label var TotCasMeRaA05S15V02 "Total Cases Mean SRIV S15 ie S3P3 V02"
label var TotCasMeRaA05S16V02 "Total Cases Mean SRIV S16 ie S3P4 V02"
label var TotCasMeRaA05S17V02 "Total Cases Mean SRIV S17 ie S3P5 V02"
label var TotCasMeRaA05S18V02 "Total Cases Mean SRIV S18 ie S3P6 V02"

*

order date

gen loc_grand_name = "Iran"

order date loc_grand_name



* 




* gen WEEKLY Deaths	
	
sort loc_grand_name date

bysort loc_grand_name: gen WekDeaMeRaA05S01V02 = TotDeaMeRaA05S01V02[_n] - TotDeaMeRaA05S01V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S02V02 = TotDeaMeRaA05S02V02[_n] - TotDeaMeRaA05S02V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S03V02 = TotDeaMeRaA05S03V02[_n] - TotDeaMeRaA05S03V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S04V02 = TotDeaMeRaA05S04V02[_n] - TotDeaMeRaA05S04V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S05V02 = TotDeaMeRaA05S05V02[_n] - TotDeaMeRaA05S05V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S06V02 = TotDeaMeRaA05S06V02[_n] - TotDeaMeRaA05S06V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S07V02 = TotDeaMeRaA05S07V02[_n] - TotDeaMeRaA05S07V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S08V02 = TotDeaMeRaA05S08V02[_n] - TotDeaMeRaA05S08V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S09V02 = TotDeaMeRaA05S09V02[_n] - TotDeaMeRaA05S09V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S10V02 = TotDeaMeRaA05S10V02[_n] - TotDeaMeRaA05S10V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S11V02 = TotDeaMeRaA05S11V02[_n] - TotDeaMeRaA05S11V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S12V02 = TotDeaMeRaA05S12V02[_n] - TotDeaMeRaA05S12V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S13V02 = TotDeaMeRaA05S13V02[_n] - TotDeaMeRaA05S13V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S14V02 = TotDeaMeRaA05S14V02[_n] - TotDeaMeRaA05S14V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S15V02 = TotDeaMeRaA05S15V02[_n] - TotDeaMeRaA05S15V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S16V02 = TotDeaMeRaA05S16V02[_n] - TotDeaMeRaA05S16V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S17V02 = TotDeaMeRaA05S17V02[_n] - TotDeaMeRaA05S17V02[_n-1]
bysort loc_grand_name: gen WekDeaMeRaA05S18V02 = TotDeaMeRaA05S18V02[_n] - TotDeaMeRaA05S18V02[_n-1]


label var WekDeaMeRaA05S01V02 "WEEKLY Deaths SRIV S01 ie S1P1"
label var WekDeaMeRaA05S02V02 "WEEKLY Deaths SRIV S02 ie S1P2"
label var WekDeaMeRaA05S03V02 "WEEKLY Deaths SRIV S03 ie S1P3"
label var WekDeaMeRaA05S04V02 "WEEKLY Deaths SRIV S04 ie S1P4"
label var WekDeaMeRaA05S05V02 "WEEKLY Deaths SRIV S05 ie S1P5"
label var WekDeaMeRaA05S06V02 "WEEKLY Deaths SRIV S06 ie S1P6"
label var WekDeaMeRaA05S07V02 "WEEKLY Deaths SRIV S07 ie S2P1"
label var WekDeaMeRaA05S08V02 "WEEKLY Deaths SRIV S08 ie S2P2"
label var WekDeaMeRaA05S09V02 "WEEKLY Deaths SRIV S09 ie S2P3"
label var WekDeaMeRaA05S10V02 "WEEKLY Deaths SRIV S10 ie S2P4"
label var WekDeaMeRaA05S11V02 "WEEKLY Deaths SRIV S11 ie S2P5"
label var WekDeaMeRaA05S12V02 "WEEKLY Deaths SRIV S12 ie S2P6"
label var WekDeaMeRaA05S13V02 "WEEKLY Deaths SRIV S13 ie S3P1"
label var WekDeaMeRaA05S14V02 "WEEKLY Deaths SRIV S14 ie S3P2"
label var WekDeaMeRaA05S15V02 "WEEKLY Deaths SRIV S15 ie S3P3"
label var WekDeaMeRaA05S16V02 "WEEKLY Deaths SRIV S16 ie S3P4"
label var WekDeaMeRaA05S17V02 "WEEKLY Deaths SRIV S17 ie S3P5"
label var WekDeaMeRaA05S18V02 "WEEKLY Deaths SRIV S18 ie S3P6"



* gen WEEKLY Cases	
	
sort loc_grand_name date

bysort loc_grand_name: gen WekCasMeRaA05S01V02 = TotCasMeRaA05S01V02[_n] - TotCasMeRaA05S01V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S02V02 = TotCasMeRaA05S02V02[_n] - TotCasMeRaA05S02V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S03V02 = TotCasMeRaA05S03V02[_n] - TotCasMeRaA05S03V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S04V02 = TotCasMeRaA05S04V02[_n] - TotCasMeRaA05S04V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S05V02 = TotCasMeRaA05S05V02[_n] - TotCasMeRaA05S05V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S06V02 = TotCasMeRaA05S06V02[_n] - TotCasMeRaA05S06V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S07V02 = TotCasMeRaA05S07V02[_n] - TotCasMeRaA05S07V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S08V02 = TotCasMeRaA05S08V02[_n] - TotCasMeRaA05S08V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S09V02 = TotCasMeRaA05S09V02[_n] - TotCasMeRaA05S09V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S10V02 = TotCasMeRaA05S10V02[_n] - TotCasMeRaA05S10V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S11V02 = TotCasMeRaA05S11V02[_n] - TotCasMeRaA05S11V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S12V02 = TotCasMeRaA05S12V02[_n] - TotCasMeRaA05S12V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S13V02 = TotCasMeRaA05S13V02[_n] - TotCasMeRaA05S13V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S14V02 = TotCasMeRaA05S14V02[_n] - TotCasMeRaA05S14V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S15V02 = TotCasMeRaA05S15V02[_n] - TotCasMeRaA05S15V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S16V02 = TotCasMeRaA05S16V02[_n] - TotCasMeRaA05S16V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S17V02 = TotCasMeRaA05S17V02[_n] - TotCasMeRaA05S17V02[_n-1]
bysort loc_grand_name: gen WekCasMeRaA05S18V02 = TotCasMeRaA05S18V02[_n] - TotCasMeRaA05S18V02[_n-1]

label var WekCasMeRaA05S01V02 "WEEKLY Cases SRIV S01 ie S1P1"
label var WekCasMeRaA05S02V02 "WEEKLY Cases SRIV S02 ie S1P2"
label var WekCasMeRaA05S03V02 "WEEKLY Cases SRIV S03 ie S1P3"
label var WekCasMeRaA05S04V02 "WEEKLY Cases SRIV S04 ie S1P4"
label var WekCasMeRaA05S05V02 "WEEKLY Cases SRIV S05 ie S1P5"
label var WekCasMeRaA05S06V02 "WEEKLY Cases SRIV S06 ie S1P6"
label var WekCasMeRaA05S07V02 "WEEKLY Cases SRIV S07 ie S2P1"
label var WekCasMeRaA05S08V02 "WEEKLY Cases SRIV S08 ie S2P2"
label var WekCasMeRaA05S09V02 "WEEKLY Cases SRIV S09 ie S2P3"
label var WekCasMeRaA05S10V02 "WEEKLY Cases SRIV S10 ie S2P4"
label var WekCasMeRaA05S11V02 "WEEKLY Cases SRIV S11 ie S2P5"
label var WekCasMeRaA05S12V02 "WEEKLY Cases SRIV S12 ie S2P6"
label var WekCasMeRaA05S13V02 "WEEKLY Cases SRIV S13 ie S3P1"
label var WekCasMeRaA05S14V02 "WEEKLY Cases SRIV S14 ie S3P2"
label var WekCasMeRaA05S15V02 "WEEKLY Cases SRIV S15 ie S3P3"
label var WekCasMeRaA05S16V02 "WEEKLY Cases SRIV S16 ie S3P4"
label var WekCasMeRaA05S17V02 "WEEKLY Cases SRIV S17 ie S3P5"
label var WekCasMeRaA05S18V02 "WEEKLY Cases SRIV S18 ie S3P6"

*

egen week = group(date)


save "Iran SRIV weekly.dta", replace





***************************

* gen date series


* 2021-03-06 to 2021-06-05 or 
* 06mar2021 to 05jun2021 or 
* 22345 to 22436

* range:  [22345,22436]                          units:  1
* or equivalently:  [06mar2021,05jun2021]        units:  days
* unique values:  14                             missing .:  0/14


codebook date


* 13 weeks + one day
di (13 * 7) + 1
* 92
 
* 14 weeks and one day 

* [22345,22436]  or equivalently:  [06mar2021,05jun2021]

di 22436 - 22345 + 1
* 92

di td(05jun2021) - td(06mar2021) + 1 
* 92

clear 

set obs 92

egen dayinweek = seq(), from(1) to(7) 

egen week = seq(), block(7)

gen n = _n

gen date = 22345 + [_n] - 1

codebook date 
* [22345,22436]

format date %tdDDMonCCYY
codebook date
* [06mar2021,05jun2021]

drop n

gen loc_grand_name = "Iran"





save "Iran SRIV dates.dta", replace





* merge


merge m:1 loc_grand_name date using "Iran SRIV weekly.dta"



drop _merge


* gen daily vars assuming weekly vars were equally distributed over seven days


local stublist ///
DeaMeRaA05S01V02 DeaMeRaA05S02V02 DeaMeRaA05S03V02 DeaMeRaA05S04V02 DeaMeRaA05S05V02 DeaMeRaA05S06V02 ///
DeaMeRaA05S07V02 DeaMeRaA05S08V02 DeaMeRaA05S09V02 DeaMeRaA05S10V02 DeaMeRaA05S11V02 DeaMeRaA05S12V02 ///
DeaMeRaA05S13V02 DeaMeRaA05S14V02 DeaMeRaA05S15V02 DeaMeRaA05S16V02 DeaMeRaA05S17V02 DeaMeRaA05S18V02 ///
CasMeRaA05S01V02 CasMeRaA05S02V02 CasMeRaA05S03V02 CasMeRaA05S04V02 CasMeRaA05S05V02 CasMeRaA05S06V02 ///
CasMeRaA05S07V02 CasMeRaA05S08V02 CasMeRaA05S09V02 CasMeRaA05S10V02 CasMeRaA05S11V02 CasMeRaA05S12V02 ///
CasMeRaA05S13V02 CasMeRaA05S14V02 CasMeRaA05S15V02 CasMeRaA05S16V02 CasMeRaA05S17V02 CasMeRaA05S18V02 ///





foreach v of local stublist {

	gen Day`v' = Wek`v' / 7

	bysort week : replace Day`v' = Day`v'[1] if missing(Day`v') 

	replace Day`v' = Day`v'[_n+7]
	
	quietly summ Wek`v' if date == td(05Jun2021) // last day
	
	replace Day`v' = `r(mean)' / 7 if week == 13 

}
*





* label daily vars

label var DayDeaMeRaA05S01V02 "Daily Deaths SRIV S01 ie S1P1"
label var DayDeaMeRaA05S02V02 "Daily Deaths SRIV S02 ie S1P2"
label var DayDeaMeRaA05S03V02 "Daily Deaths SRIV S03 ie S1P3"
label var DayDeaMeRaA05S04V02 "Daily Deaths SRIV S04 ie S1P4"
label var DayDeaMeRaA05S05V02 "Daily Deaths SRIV S05 ie S1P5"
label var DayDeaMeRaA05S06V02 "Daily Deaths SRIV S06 ie S1P6"
label var DayDeaMeRaA05S07V02 "Daily Deaths SRIV S07 ie S2P1"
label var DayDeaMeRaA05S08V02 "Daily Deaths SRIV S08 ie S2P2"
label var DayDeaMeRaA05S09V02 "Daily Deaths SRIV S09 ie S2P3"
label var DayDeaMeRaA05S10V02 "Daily Deaths SRIV S10 ie S2P4"
label var DayDeaMeRaA05S11V02 "Daily Deaths SRIV S11 ie S2P5"
label var DayDeaMeRaA05S12V02 "Daily Deaths SRIV S12 ie S2P6"
label var DayDeaMeRaA05S13V02 "Daily Deaths SRIV S13 ie S3P1"
label var DayDeaMeRaA05S14V02 "Daily Deaths SRIV S14 ie S3P2"
label var DayDeaMeRaA05S15V02 "Daily Deaths SRIV S15 ie S3P3"
label var DayDeaMeRaA05S16V02 "Daily Deaths SRIV S16 ie S3P4"
label var DayDeaMeRaA05S17V02 "Daily Deaths SRIV S17 ie S3P5"
label var DayDeaMeRaA05S18V02 "Daily Deaths SRIV S18 ie S3P6"


label var DayCasMeRaA05S01V02 "Daily Cases SRIV S01 ie S1P1"
label var DayCasMeRaA05S02V02 "Daily Cases SRIV S02 ie S1P2"
label var DayCasMeRaA05S03V02 "Daily Cases SRIV S03 ie S1P3"
label var DayCasMeRaA05S04V02 "Daily Cases SRIV S04 ie S1P4"
label var DayCasMeRaA05S05V02 "Daily Cases SRIV S05 ie S1P5"
label var DayCasMeRaA05S06V02 "Daily Cases SRIV S06 ie S1P6"
label var DayCasMeRaA05S07V02 "Daily Cases SRIV S07 ie S2P1"
label var DayCasMeRaA05S08V02 "Daily Cases SRIV S08 ie S2P2"
label var DayCasMeRaA05S09V02 "Daily Cases SRIV S09 ie S2P3"
label var DayCasMeRaA05S10V02 "Daily Cases SRIV S10 ie S2P4"
label var DayCasMeRaA05S11V02 "Daily Cases SRIV S11 ie S2P5"
label var DayCasMeRaA05S12V02 "Daily Cases SRIV S12 ie S2P6"
label var DayCasMeRaA05S13V02 "Daily Cases SRIV S13 ie S3P1"
label var DayCasMeRaA05S14V02 "Daily Cases SRIV S14 ie S3P2"
label var DayCasMeRaA05S15V02 "Daily Cases SRIV S15 ie S3P3"
label var DayCasMeRaA05S16V02 "Daily Cases SRIV S16 ie S3P4"
label var DayCasMeRaA05S17V02 "Daily Cases SRIV S17 ie S3P5"
label var DayCasMeRaA05S18V02 "Daily Cases SRIV S18 ie S3P6"


* go back to main path


cd ..

cd ..

cd ..




* smooth daily vars

tsset date, daily   


local varlist ///
DayDeaMeRaA05S01V02	DayDeaMeRaA05S02V02	DayDeaMeRaA05S03V02	DayDeaMeRaA05S04V02	DayDeaMeRaA05S05V02	DayDeaMeRaA05S06V02	///
DayDeaMeRaA05S07V02	DayDeaMeRaA05S08V02	DayDeaMeRaA05S09V02	DayDeaMeRaA05S10V02	DayDeaMeRaA05S11V02	DayDeaMeRaA05S12V02	///
DayDeaMeRaA05S13V02	DayDeaMeRaA05S14V02	DayDeaMeRaA05S15V02	DayDeaMeRaA05S16V02	DayDeaMeRaA05S17V02	DayDeaMeRaA05S18V02	///
DayCasMeRaA05S01V02	DayCasMeRaA05S02V02	DayCasMeRaA05S03V02	DayCasMeRaA05S04V02	DayCasMeRaA05S05V02	DayCasMeRaA05S06V02	///
DayCasMeRaA05S07V02	DayCasMeRaA05S08V02	DayCasMeRaA05S09V02	DayCasMeRaA05S10V02	DayCasMeRaA05S11V02	DayCasMeRaA05S12V02	///
DayCasMeRaA05S13V02	DayCasMeRaA05S14V02	DayCasMeRaA05S15V02	DayCasMeRaA05S16V02	DayCasMeRaA05S17V02	DayCasMeRaA05S18V02



foreach v of local varlist {
	   
	tssmooth ma `v'_window = `v', window(3 1 3)

	tssmooth ma `v'_smoothed = `v'_window, weights( 1 2 3 <4> 3 2 1) replace
	
	replace `v'_smoothed = . if date < td(09mar2021) || date > td(31may2021) // remove short denaturization	

	line `v' `v'_smoothed date if `v' != . 
	graph export G_`v'.pdf, replace

	drop *_window

}
*

tsset, clear 



* rename smoothed vars


foreach var of varlist *_smoothed {

   	local first = substr("`var'", 1, 8)
	
   	local second = substr("`var'", 11, 9)

   	local Sm = "Sm"
	
	local all = "`first'`Sm'`second'"
	
   	rename `var' `all'
}
*


* label smoothed daily vars




label var DayDeaMeSmA05S01V02 "Daily Deaths Smoothed SRIV S01 ie S1P1"
label var DayDeaMeSmA05S02V02 "Daily Deaths Smoothed SRIV S02 ie S1P2"
label var DayDeaMeSmA05S03V02 "Daily Deaths Smoothed SRIV S03 ie S1P3"
label var DayDeaMeSmA05S04V02 "Daily Deaths Smoothed SRIV S04 ie S1P4"
label var DayDeaMeSmA05S05V02 "Daily Deaths Smoothed SRIV S05 ie S1P5"
label var DayDeaMeSmA05S06V02 "Daily Deaths Smoothed SRIV S06 ie S1P6"
label var DayDeaMeSmA05S07V02 "Daily Deaths Smoothed SRIV S07 ie S2P1"
label var DayDeaMeSmA05S08V02 "Daily Deaths Smoothed SRIV S08 ie S2P2"
label var DayDeaMeSmA05S09V02 "Daily Deaths Smoothed SRIV S09 ie S2P3"
label var DayDeaMeSmA05S10V02 "Daily Deaths Smoothed SRIV S10 ie S2P4"
label var DayDeaMeSmA05S11V02 "Daily Deaths Smoothed SRIV S11 ie S2P5"
label var DayDeaMeSmA05S12V02 "Daily Deaths Smoothed SRIV S12 ie S2P6"
label var DayDeaMeSmA05S13V02 "Daily Deaths Smoothed SRIV S13 ie S3P1"
label var DayDeaMeSmA05S14V02 "Daily Deaths Smoothed SRIV S14 ie S3P2"
label var DayDeaMeSmA05S15V02 "Daily Deaths Smoothed SRIV S15 ie S3P3"
label var DayDeaMeSmA05S16V02 "Daily Deaths Smoothed SRIV S16 ie S3P4"
label var DayDeaMeSmA05S17V02 "Daily Deaths Smoothed SRIV S17 ie S3P5"
label var DayDeaMeSmA05S18V02 "Daily Deaths Smoothed SRIV S18 ie S3P6"


label var DayCasMeSmA05S01V02 "Daily Cases Smoothed SRIV S01 ie S1P1"
label var DayCasMeSmA05S02V02 "Daily Cases Smoothed SRIV S02 ie S1P2"
label var DayCasMeSmA05S03V02 "Daily Cases Smoothed SRIV S03 ie S1P3"
label var DayCasMeSmA05S04V02 "Daily Cases Smoothed SRIV S04 ie S1P4"
label var DayCasMeSmA05S05V02 "Daily Cases Smoothed SRIV S05 ie S1P5"
label var DayCasMeSmA05S06V02 "Daily Cases Smoothed SRIV S06 ie S1P6"
label var DayCasMeSmA05S07V02 "Daily Cases Smoothed SRIV S07 ie S2P1"
label var DayCasMeSmA05S08V02 "Daily Cases Smoothed SRIV S08 ie S2P2"
label var DayCasMeSmA05S09V02 "Daily Cases Smoothed SRIV S09 ie S2P3"
label var DayCasMeSmA05S10V02 "Daily Cases Smoothed SRIV S10 ie S2P4"
label var DayCasMeSmA05S11V02 "Daily Cases Smoothed SRIV S11 ie S2P5"
label var DayCasMeSmA05S12V02 "Daily Cases Smoothed SRIV S12 ie S2P6"
label var DayCasMeSmA05S13V02 "Daily Cases Smoothed SRIV S13 ie S3P1"
label var DayCasMeSmA05S14V02 "Daily Cases Smoothed SRIV S14 ie S3P2"
label var DayCasMeSmA05S15V02 "Daily Cases Smoothed SRIV S15 ie S3P3"
label var DayCasMeSmA05S16V02 "Daily Cases Smoothed SRIV S16 ie S3P4"
label var DayCasMeSmA05S17V02 "Daily Cases Smoothed SRIV S17 ie S3P5"
label var DayCasMeSmA05S18V02 "Daily Cases Smoothed SRIV S18 ie S3P6"


drop dayinweek week	

order ///
date loc_grand_name	///
TotDeaMeRaA05S01V02	TotDeaMeRaA05S02V02	TotDeaMeRaA05S03V02	TotDeaMeRaA05S04V02	TotDeaMeRaA05S05V02	TotDeaMeRaA05S06V02	///
TotDeaMeRaA05S07V02	TotDeaMeRaA05S08V02	TotDeaMeRaA05S09V02	TotDeaMeRaA05S10V02	TotDeaMeRaA05S11V02	TotDeaMeRaA05S12V02	///
TotDeaMeRaA05S13V02	TotDeaMeRaA05S14V02	TotDeaMeRaA05S15V02	TotDeaMeRaA05S16V02	TotDeaMeRaA05S17V02	TotDeaMeRaA05S18V02	///
DayDeaMeRaA05S01V02	DayDeaMeRaA05S02V02	DayDeaMeRaA05S03V02	DayDeaMeRaA05S04V02	DayDeaMeRaA05S05V02	DayDeaMeRaA05S06V02	///
DayDeaMeRaA05S07V02	DayDeaMeRaA05S08V02	DayDeaMeRaA05S09V02	DayDeaMeRaA05S10V02	DayDeaMeRaA05S11V02	DayDeaMeRaA05S12V02	///
DayDeaMeRaA05S13V02	DayDeaMeRaA05S14V02	DayDeaMeRaA05S15V02	DayDeaMeRaA05S16V02	DayDeaMeRaA05S17V02	DayDeaMeRaA05S18V02	///
DayDeaMeSmA05S01V02	DayDeaMeSmA05S02V02	DayDeaMeSmA05S03V02	DayDeaMeSmA05S04V02	DayDeaMeSmA05S05V02	DayDeaMeSmA05S06V02	///
DayDeaMeSmA05S07V02	DayDeaMeSmA05S08V02	DayDeaMeSmA05S09V02	DayDeaMeSmA05S10V02	DayDeaMeSmA05S11V02	DayDeaMeSmA05S12V02	///
DayDeaMeSmA05S13V02	DayDeaMeSmA05S14V02	DayDeaMeSmA05S15V02	DayDeaMeSmA05S16V02	DayDeaMeSmA05S17V02	DayDeaMeSmA05S18V02	///
WekDeaMeRaA05S01V02	WekDeaMeRaA05S02V02	WekDeaMeRaA05S03V02	WekDeaMeRaA05S04V02	WekDeaMeRaA05S05V02	WekDeaMeRaA05S06V02	///
WekDeaMeRaA05S07V02	WekDeaMeRaA05S08V02	WekDeaMeRaA05S09V02	WekDeaMeRaA05S10V02	WekDeaMeRaA05S11V02	WekDeaMeRaA05S12V02	///
WekDeaMeRaA05S13V02	WekDeaMeRaA05S14V02	WekDeaMeRaA05S15V02	WekDeaMeRaA05S16V02	WekDeaMeRaA05S17V02	WekDeaMeRaA05S18V02	///
TotCasMeRaA05S01V02	TotCasMeRaA05S02V02	TotCasMeRaA05S03V02	TotCasMeRaA05S04V02	TotCasMeRaA05S05V02	TotCasMeRaA05S06V02	///
TotCasMeRaA05S07V02	TotCasMeRaA05S08V02	TotCasMeRaA05S09V02	TotCasMeRaA05S10V02	TotCasMeRaA05S11V02	TotCasMeRaA05S12V02	///
TotCasMeRaA05S13V02	TotCasMeRaA05S14V02	TotCasMeRaA05S15V02	TotCasMeRaA05S16V02	TotCasMeRaA05S17V02	TotCasMeRaA05S18V02	///
DayCasMeRaA05S01V02	DayCasMeRaA05S02V02	DayCasMeRaA05S03V02	DayCasMeRaA05S04V02	DayCasMeRaA05S05V02	DayCasMeRaA05S06V02	///
DayCasMeRaA05S07V02	DayCasMeRaA05S08V02	DayCasMeRaA05S09V02	DayCasMeRaA05S10V02	DayCasMeRaA05S11V02	DayCasMeRaA05S12V02	///
DayCasMeRaA05S13V02	DayCasMeRaA05S14V02	DayCasMeRaA05S15V02	DayCasMeRaA05S16V02	DayCasMeRaA05S17V02	DayCasMeRaA05S18V02	///
DayCasMeSmA05S01V02	DayCasMeSmA05S02V02	DayCasMeSmA05S03V02	DayCasMeSmA05S04V02	DayCasMeSmA05S05V02	DayCasMeSmA05S06V02	///
DayCasMeSmA05S07V02	DayCasMeSmA05S08V02	DayCasMeSmA05S09V02	DayCasMeSmA05S10V02	DayCasMeSmA05S11V02	DayCasMeSmA05S12V02	///
DayCasMeSmA05S13V02	DayCasMeSmA05S14V02	DayCasMeSmA05S15V02	DayCasMeSmA05S16V02	DayCasMeSmA05S17V02	DayCasMeSmA05S18V02 ///
WekCasMeRaA05S01V02	WekCasMeRaA05S02V02	WekCasMeRaA05S03V02	WekCasMeRaA05S04V02	WekCasMeRaA05S05V02	WekCasMeRaA05S06V02	///
WekCasMeRaA05S07V02	WekCasMeRaA05S08V02	WekCasMeRaA05S09V02	WekCasMeRaA05S10V02	WekCasMeRaA05S11V02	WekCasMeRaA05S12V02	///
WekCasMeRaA05S13V02	WekCasMeRaA05S14V02	WekCasMeRaA05S15V02	WekCasMeRaA05S16V02	WekCasMeRaA05S17V02	WekCasMeRaA05S18V02	





*



****************************

* graphs 

grstyle init

grstyle color background white


* deaths 

* S2 = current2 = current level of interventions and reciprocal of gamma is 2


* total deaths

twoway ///
(line TotDeaMeRaA05S02V02 date, sort lcolor(green)) ///
, xtitle(Date) xlabel(#4, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph COVID-19 total deaths, default scenario, Iran, SRIV.gph", replace
graph export "graph COVID-19 total deaths, default scenario, Iran, SRIV.pdf", replace



* daily deaths raw

twoway ///
(line DayDeaMeRaA05S02V02 date, sort lcolor(green)) ///
, xtitle(Date) xlabel(#4, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths raw, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph COVID-19 daily deaths raw, default scenario, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily deaths raw, default scenario, Iran, SRIV.pdf", replace



* daily deaths smoothed

twoway ///
(line DayDeaMeSmA05S02V02 date, sort lcolor(green)) ///
, xtitle(Date) xlabel(#4, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths smoothed, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph COVID-19 daily deaths smoothed, default scenario, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily deaths smoothed, default scenario, Iran, SRIV.pdf", replace



* weekly deaths

twoway ///
(line WekDeaMeRaA05S02V02 date, sort lcolor(green)) ///
, xtitle(Date) xlabel(#4, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Weekly deaths) title("COVID-19 weekly deaths, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph COVID-19 weekly deaths, default scenario, Iran, SRIV.gph", replace
graph export "graph COVID-19 weekly deaths, default scenario, Iran, SRIV.pdf", replace






* other scenarios




* daily deaths smoothed, 6 current scenarios

twoway ///
(line DayDeaMeSmA05S01V02 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S02V02 date, sort lcolor(black)) ///
(line DayDeaMeSmA05S03V02 date, sort lcolor(red)) ///
(line DayDeaMeSmA05S04V02 date, sort lcolor(green) lpattern(dash)) ///
(line DayDeaMeSmA05S05V02 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA05S06V02 date, sort lcolor(red) lpattern(dash)) ///
, xtitle(Date) xlabel(#4, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, SRIV, 6 current scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(2))
  	   
graph save "graph COVID-19 daily deaths, 6 current scenarios, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily deaths, 6 current scenarios, Iran, SRIV.pdf", replace



* daily deaths raw, 6 current scenarios

twoway ///
(line DayDeaMeRaA05S01V02 date, sort lcolor(green)) ///
(line DayDeaMeRaA05S02V02 date, sort lcolor(black)) ///
(line DayDeaMeRaA05S03V02 date, sort lcolor(red)) ///
(line DayDeaMeRaA05S04V02 date, sort lcolor(green) lpattern(dash)) ///
(line DayDeaMeRaA05S05V02 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeRaA05S06V02 date, sort lcolor(red) lpattern(dash)) ///
, xtitle(Date) xlabel(#4, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, SRIV, 6 current scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(2))
  	   
graph save "graph COVID-19 daily deaths, 6 current scenarios, raw, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily deaths, 6 current scenarios, raw, Iran, SRIV.pdf", replace






* daily deaths smoothed, 6 released scenarios

twoway ///
(line DayDeaMeSmA05S07V02 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S08V02 date, sort lcolor(black)) ///
(line DayDeaMeSmA05S09V02 date, sort lcolor(red)) ///
(line DayDeaMeSmA05S10V02 date, sort lcolor(green) lpattern(dash)) ///
(line DayDeaMeSmA05S11V02 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA05S12V02 date, sort lcolor(red) lpattern(dash)) ///
, xtitle(Date) xlabel(#4, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, SRIV, 6 released scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S7" 2 "S8" 3 "S9" 4 "S10" 5 "S11" 6 "S12") rows(2))
  	   
graph save "graph COVID-19 daily deaths, 6 released scenarios, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily deaths, 6 released scenarios, Iran, SRIV.pdf", replace



* daily deaths raw, 6 released scenarios

twoway ///
(line DayDeaMeRaA05S07V02 date, sort lcolor(green)) ///
(line DayDeaMeRaA05S08V02 date, sort lcolor(black)) ///
(line DayDeaMeRaA05S09V02 date, sort lcolor(red)) ///
(line DayDeaMeRaA05S10V02 date, sort lcolor(green) lpattern(dash)) ///
(line DayDeaMeRaA05S11V02 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeRaA05S12V02 date, sort lcolor(red) lpattern(dash)) ///
, xtitle(Date) xlabel(#4, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, SRIV, 6 released scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S7" 2 "S8" 3 "S9" 4 "S10" 5 "S11" 6 "S12") rows(2))
  	   
graph save "graph COVID-19 daily deaths, 6 released scenarios, raw, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily deaths, 6 released scenarios, raw, Iran, SRIV.pdf", replace









* daily deaths smoothed, 6 restricted scenarios

twoway ///
(line DayDeaMeSmA05S13V02 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S14V02 date, sort lcolor(black)) ///
(line DayDeaMeSmA05S15V02 date, sort lcolor(red)) ///
(line DayDeaMeSmA05S16V02 date, sort lcolor(green) lpattern(dash)) ///
(line DayDeaMeSmA05S17V02 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeSmA05S18V02 date, sort lcolor(red) lpattern(dash)) ///
, xtitle(Date) xlabel(#4, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, SRIV, 6 restricted scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S13" 2 "S14" 3 "S15" 4 "S16" 5 "S17" 6 "S18") rows(2))
  	   
graph save "graph COVID-19 daily deaths, 6 restricted scenarios, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily deaths, 6 restricted scenarios, Iran, SRIV.pdf", replace



* daily deaths raw, 6 restricted scenarios

twoway ///
(line DayDeaMeRaA05S13V02 date, sort lcolor(green)) ///
(line DayDeaMeRaA05S14V02 date, sort lcolor(black)) ///
(line DayDeaMeRaA05S15V02 date, sort lcolor(red)) ///
(line DayDeaMeRaA05S16V02 date, sort lcolor(green) lpattern(dash)) ///
(line DayDeaMeRaA05S17V02 date, sort lcolor(black) lpattern(dash)) ///
(line DayDeaMeRaA05S18V02 date, sort lcolor(red) lpattern(dash)) ///
, xtitle(Date) xlabel(#4, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, SRIV, 6 restricted scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S13" 2 "S14" 3 "S15" 4 "S16" 5 "S17" 6 "S18") rows(2))
  	   
graph save "graph COVID-19 daily deaths, 6 restricted scenarios, raw, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily deaths, 6 restricted scenarios, raw, Iran, SRIV.pdf", replace







* daily deaths smoothed, default (i.e., reciprocal of gamma = 2) of 3 scenario groups


twoway ///
(line DayDeaMeSmA05S02V02 date, sort lcolor(green)) ///
(line DayDeaMeSmA05S08V02 date, sort lcolor(black)) ///
(line DayDeaMeSmA05S14V02 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#4, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, SRIV, default of 3 scenario groups", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S2" 2 "S8" 3 "S14") rows(1))

graph save "graph COVID-19 daily deaths, default of 3 scenario groups, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily deaths, default of 3 scenario groups, Iran, SRIV.pdf", replace




* daily deaths raw, default (i.e., reciprocal of gamma = 2) of 3 scenario groups


twoway ///
(line DayDeaMeRaA05S02V02 date, sort lcolor(green)) ///
(line DayDeaMeRaA05S08V02 date, sort lcolor(black)) ///
(line DayDeaMeRaA05S14V02 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#4, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, SRIV, default of 3 scenario groups", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S2" 2 "S8" 3 "S14") rows(1))

graph save "graph COVID-19 daily deaths, default of 3 scenario groups, raw, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily deaths, default of 3 scenario groups, raw, Iran, SRIV.pdf", replace









* cases 

* S2 = current2 = current level of interventions and reciprocal of gamma is 2


* total cases

twoway ///
(line TotCasMeRaA05S02V02 date, sort lcolor(green)) ///
, xtitle(Date) xlabel(#15, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph COVID-19 total cases, default scenario, Iran, SRIV.gph", replace
graph export "graph COVID-19 total cases, default scenario, Iran, SRIV.pdf", replace



* daily cases raw

twoway ///
(line DayCasMeRaA05S02V02 date, sort lcolor(green)) ///
, xtitle(Date) xlabel(#15, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases raw, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph COVID-19 daily cases raw, default scenario, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily cases raw, default scenario, Iran, SRIV.pdf", replace



* daily cases smoothed

twoway ///
(line DayCasMeSmA05S02V02 date, sort lcolor(green)) ///
, xtitle(Date) xlabel(#15, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases smoothed, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph COVID-19 daily cases smoothed, default scenario, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily cases smoothed, default scenario, Iran, SRIV.pdf", replace



* weekly cases

twoway ///
(line WekCasMeRaA05S02V02 date, sort lcolor(green)) ///
, xtitle(Date) xlabel(#15, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Weekly cases) title("COVID-19 weekly cases, Iran, SRIV, default scenario", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) 

graph save "graph COVID-19 weekly cases, default scenario, Iran, SRIV.gph", replace
graph export "graph COVID-19 weekly cases, default scenario, Iran, SRIV.pdf", replace






* other scenarios




* daily cases smoothed, 6 current scenarios

twoway ///
(line DayCasMeSmA05S01V02 date, sort lcolor(green)) ///
(line DayCasMeSmA05S02V02 date, sort lcolor(black)) ///
(line DayCasMeSmA05S03V02 date, sort lcolor(red)) ///
(line DayCasMeSmA05S04V02 date, sort lcolor(green) lpattern(dash)) ///
(line DayCasMeSmA05S05V02 date, sort lcolor(black) lpattern(dash)) ///
(line DayCasMeSmA05S06V02 date, sort lcolor(red) lpattern(dash)) ///
, xtitle(Date) xlabel(#15, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, SRIV, 6 current scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(2))
  	   
graph save "graph COVID-19 daily cases, 6 current scenarios, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily cases, 6 current scenarios, Iran, SRIV.pdf", replace




* daily cases raw, 6 current scenarios


twoway ///
(line DayCasMeRaA05S01V02 date, sort lcolor(green)) ///
(line DayCasMeRaA05S02V02 date, sort lcolor(black)) ///
(line DayCasMeRaA05S03V02 date, sort lcolor(red)) ///
(line DayCasMeRaA05S04V02 date, sort lcolor(green) lpattern(dash)) ///
(line DayCasMeRaA05S05V02 date, sort lcolor(black) lpattern(dash)) ///
(line DayCasMeRaA05S06V02 date, sort lcolor(red) lpattern(dash)) ///
, xtitle(Date) xlabel(#15, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, SRIV, 6 current scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S1" 2 "S2" 3 "S3" 4 "S4" 5 "S5" 6 "S6") rows(2))
  	   
graph save "graph COVID-19 daily cases, 6 current scenarios, raw, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily cases, 6 current scenarios, raw, Iran, SRIV.pdf", replace





* daily cases smoothed, 6 released scenarios

twoway ///
(line DayCasMeSmA05S07V02 date, sort lcolor(green)) ///
(line DayCasMeSmA05S08V02 date, sort lcolor(black)) ///
(line DayCasMeSmA05S09V02 date, sort lcolor(red)) ///
(line DayCasMeSmA05S10V02 date, sort lcolor(green) lpattern(dash)) ///
(line DayCasMeSmA05S11V02 date, sort lcolor(black) lpattern(dash)) ///
(line DayCasMeSmA05S12V02 date, sort lcolor(red) lpattern(dash)) ///
, xtitle(Date) xlabel(#15, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, SRIV, 6 released scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S7" 2 "S8" 3 "S9" 4 "S10" 5 "S11" 6 "S12") rows(2))
  	   
graph save "graph COVID-19 daily cases, 6 released scenarios, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily cases, 6 released scenarios, Iran, SRIV.pdf", replace




* daily cases raw, 6 released scenarios

twoway ///
(line DayCasMeRaA05S07V02 date, sort lcolor(green)) ///
(line DayCasMeRaA05S08V02 date, sort lcolor(black)) ///
(line DayCasMeRaA05S09V02 date, sort lcolor(red)) ///
(line DayCasMeRaA05S10V02 date, sort lcolor(green) lpattern(dash)) ///
(line DayCasMeRaA05S11V02 date, sort lcolor(black) lpattern(dash)) ///
(line DayCasMeRaA05S12V02 date, sort lcolor(red) lpattern(dash)) ///
, xtitle(Date) xlabel(#15, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, SRIV, 6 released scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S7" 2 "S8" 3 "S9" 4 "S10" 5 "S11" 6 "S12") rows(2))
  	   
graph save "graph COVID-19 daily cases, 6 released scenarios, raw, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily cases, 6 released scenarios, raw, Iran, SRIV.pdf", replace








* daily cases smoothed, 6 restricted scenarios

twoway ///
(line DayCasMeSmA05S13V02 date, sort lcolor(green)) ///
(line DayCasMeSmA05S14V02 date, sort lcolor(black)) ///
(line DayCasMeSmA05S15V02 date, sort lcolor(red)) ///
(line DayCasMeSmA05S16V02 date, sort lcolor(green) lpattern(dash)) ///
(line DayCasMeSmA05S17V02 date, sort lcolor(black) lpattern(dash)) ///
(line DayCasMeSmA05S18V02 date, sort lcolor(red) lpattern(dash)) ///
, xtitle(Date) xlabel(#15, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, SRIV, 6 restricted scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S13" 2 "S14" 3 "S15" 4 "S16" 5 "S17" 6 "S18") rows(2))
  	   
graph save "graph COVID-19 daily cases, 6 restricted scenarios, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily cases, 6 restricted scenarios, Iran, SRIV.pdf", replace




* daily cases raw, 6 restricted scenarios

twoway ///
(line DayCasMeRaA05S13V02 date, sort lcolor(green)) ///
(line DayCasMeRaA05S14V02 date, sort lcolor(black)) ///
(line DayCasMeRaA05S15V02 date, sort lcolor(red)) ///
(line DayCasMeRaA05S16V02 date, sort lcolor(green) lpattern(dash)) ///
(line DayCasMeRaA05S17V02 date, sort lcolor(black) lpattern(dash)) ///
(line DayCasMeRaA05S18V02 date, sort lcolor(red) lpattern(dash)) ///
, xtitle(Date) xlabel(#15, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, SRIV, 6 restricted scenarios", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S13" 2 "S14" 3 "S15" 4 "S16" 5 "S17" 6 "S18") rows(2))
  	   
graph save "graph COVID-19 daily cases, 6 restricted scenarios, raw, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily cases, 6 restricted scenarios, raw, Iran, SRIV.pdf", replace








* daily cases smoothed, default (i.e., reciprocal of gamma = 2) of 3 scenario groups


twoway ///
(line DayCasMeSmA05S02V02 date, sort lcolor(green)) ///
(line DayCasMeSmA05S08V02 date, sort lcolor(black)) ///
(line DayCasMeSmA05S14V02 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#15, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, SRIV, default of 3 scenario groups", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S2" 2 "S8" 3 "S14") rows(1))

graph save "graph COVID-19 daily cases, default of 3 scenario groups, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily cases, default of 3 scenario groups, Iran, SRIV.pdf", replace





* daily cases raw, default (i.e., reciprocal of gamma = 2) of 3 scenario groups


twoway ///
(line DayCasMeRaA05S02V02 date, sort lcolor(green)) ///
(line DayCasMeRaA05S08V02 date, sort lcolor(black)) ///
(line DayCasMeRaA05S14V02 date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#15, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, SRIV, default of 3 scenario groups", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
legend(region(lcolor(none))) legend(bexpand) legend(order(1 "S2" 2 "S8" 3 "S14") rows(1))

graph save "graph COVID-19 daily cases, default of 3 scenario groups, raw, Iran, SRIV.gph", replace
graph export "graph COVID-19 daily cases, default of 3 scenario groups, raw, Iran, SRIV.pdf", replace










*



*************************************************************************


/*

Scenarios:

Three scenarios of interventions (current, released, restricted) 
and 6 values of gamma (reciprocal of probability for 
unreported cases to be reported) make 18 total scenarios. 


S1 = current1 = current level of interventions and reciprocal of gamma is 1 = current, worse
S2 = current2 = current level of interventions and reciprocal of gamma is 2 = current, default
S3 = current5 = current level of interventions and reciprocal of gamma is 5 = current, better
S4 = current10 = current level of interventions and reciprocal of gamma is 10 (current extreme)
S5 = current20 = current level of interventions and reciprocal of gamma is 20 (current extreme)
S6 = current40 = current level of interventions and reciprocal of gamma is 40 (current extreme)

S7 = released1 = released level of interventions and reciprocal of gamma is 1 = released, worse
S8 = released2 = released level of interventions and reciprocal of gamma is 2 = released, default
S9 = released5 = released level of interventions and reciprocal of gamma is 5 = released, better
S10 = released10 = released level of interventions and reciprocal of gamma is 10 (released extreme)
S11 = released20 = released level of interventions and reciprocal of gamma is 20 (released extreme)
S12 = released40 = released level of interventions and reciprocal of gamma is 40 (released extreme)

S13 = restricted1 = restricted level of interventions and reciprocal of gamma is 1 = restricted, worse
S14 = restricted2 = restricted level of interventions and reciprocal of gamma is 2 = restricted, default
S15 = restricted5 = restricted level of interventions and reciprocal of gamma is 5 = restricted, better
S16 = restricted10 = restricted level of interventions and reciprocal of gamma is 10 (restricted extreme)
S17 = restricted20 = restricted level of interventions and reciprocal of gamma is 20 (restricted extreme)
S18 = restricted40 = restricted level of interventions and reciprocal of gamma is 40 (restricted extreme)

Q: Where are their confidence intervals? A: Nowhere. None. 

*/





*************************************************************************

* Locate peak dates and values

/* SRIV reports outcome values on weekly (not daily) basis. 
As such, the reported calendar dates for daily outcomes are accurate as the reported date plus seven days. */



*************************************************************************

* Locate peak dates and values - deaths 


* peak


* current level of interventions

* S2 = current level of interventions and reciprocal of gamma is 2 = current, default

summ DayDeaMeRaA05S02V02

gen DayDeaMeRaA05S02V02P0V = r(max)

label var DayDeaMeRaA05S02V02P0V "DayDeaMeRaA05S02V02 One peak Value"

summ date if DayDeaMeRaA05S02V02 == DayDeaMeRaA05S02V02P0V & DayDeaMeRaA05S02V02 != . 

gen DayDeaMeRaA05S02V02P0D = r(max)

label var DayDeaMeRaA05S02V02P0D "DayDeaMeRaA05S02V02 One peak Date"


* S3 current level of interventions and reciprocal of gamma is 5 = current, better

summ DayDeaMeRaA05S03V02 

gen DayDeaMeRaA05S03V02P0V = r(max)

label var DayDeaMeRaA05S03V02P0V "DayDeaMeRaA05S03V02 One peak Value"

summ date if DayDeaMeRaA05S03V02 == DayDeaMeRaA05S03V02P0V & DayDeaMeRaA05S03V02 != .

gen DayDeaMeRaA05S03V02P0D = r(max)

label var DayDeaMeRaA05S03V02P0D "DayDeaMeRaA05S03V02 One peak Date"


* S1 current level of interventions and reciprocal of gamma is 1 = current, worse

summ DayDeaMeRaA05S01V02 

gen DayDeaMeRaA05S01V02P0V = r(max)

label var DayDeaMeRaA05S01V02P0V "DayDeaMeRaA05S01V02 One peak Value"

summ date DayDeaMeRaA05S01V02 if DayDeaMeRaA05S01V02 == DayDeaMeRaA05S01V02P0V & DayDeaMeRaA05S01V02 != . 

gen DayDeaMeRaA05S01V02P0D = r(max)

label var DayDeaMeRaA05S01V02P0D "DayDeaMeRaA05S01V02P0D One peak Date"



* restricted interventions


* S14 = restricted interventions and reciprocal of gamma is 2 = restricted, default

summ DayDeaMeRaA05S14V02 

gen DayDeaMeRaA05S14V02P0V = r(max)

label var DayDeaMeRaA05S14V02P0V "DayDeaMeRaA05S14V02 One peak Value"

summ date if DayDeaMeRaA05S14V02 == DayDeaMeRaA05S14V02P0V & DayDeaMeRaA05S14V02 != . 

gen DayDeaMeRaA05S14V02P0D = r(max)
 
label var DayDeaMeRaA05S14V02P0D "DayDeaMeRaA05S14V02 One peak Date"


* S15 = restricted interventions and reciprocal of gamma is 5 = restricted, better

summ DayDeaMeRaA05S15V02 

gen DayDeaMeRaA05S15V02P0V = r(max)

label var DayDeaMeRaA05S15V02P0V "DayDeaMeRaA05S15V02 One peak Value"

summ date if DayDeaMeRaA05S15V02 == DayDeaMeRaA05S15V02P0V & DayDeaMeRaA05S15V02 != . 

gen DayDeaMeRaA05S15V02P0D = r(max)

label var DayDeaMeRaA05S15V02P0D "DayDeaMeRaA05S15V02 One peak Date"



* S13 = restricted interventions and reciprocal of gamma is 1 = restricted, worse

summ DayDeaMeRaA05S13V02 

gen DayDeaMeRaA05S13V02P0V = r(max)

label var DayDeaMeRaA05S13V02P0V "DayDeaMeRaA05S13V02 One peak Value"

summ date if DayDeaMeRaA05S13V02 == DayDeaMeRaA05S13V02P0V & DayDeaMeRaA05S13V02 != . 

gen DayDeaMeRaA05S13V02P0D = r(max)

label var DayDeaMeRaA05S13V02P0D "DayDeaMeRaA05S13V02 One peak Date"



                           ************************************************************************
* released interventions : do not peak during time shown, reach max at last days of time shown (P8)
                           ************************************************************************


* S8 = released interventions and reciprocal of gamma is 2 = released, default

summ DayDeaMeRaA05S08V02 

gen DayDeaMeRaA05S08V02P8V = r(max)

label var DayDeaMeRaA05S08V02P8V "DayDeaMeRaA05S08V02 Highest at end Value"

summ date if DayDeaMeRaA05S08V02 == DayDeaMeRaA05S08V02P8V

gen DayDeaMeRaA05S08V02P8D = r(max)

label var DayDeaMeRaA05S08V02P8D "DayDeaMeRaA05S08V02 Highest at end Date"


* S9 = released interventions and reciprocal of gamma is 5 = released, better

summ DayDeaMeRaA05S09V02 

gen DayDeaMeRaA05S09V02P8V = r(max)

label var DayDeaMeRaA05S09V02P8V "DayDeaMeRaA05S09V02 Highest at end Value"

summ date if DayDeaMeRaA05S09V02 == DayDeaMeRaA05S09V02P8V 

gen DayDeaMeRaA05S09V02P8D = r(max)

label var DayDeaMeRaA05S09V02P8D "DayDeaMeRaA05S09V02 Highest at end Date"

 
* S7 = released interventions and reciprocal of gamma is 1 = released, worse

summ DayDeaMeRaA05S07V02 

gen DayDeaMeRaA05S07V02P8V = r(max)

label var DayDeaMeRaA05S07V02P8V "DayDeaMeRaA05S07V02 Highest at end Value"

summ date if DayDeaMeRaA05S07V02 == DayDeaMeRaA05S07V02P8V
 
gen DayDeaMeRaA05S07V02P8D = r(max)

label var DayDeaMeRaA05S07V02P8D "DayDeaMeRaA05S07V02 Highest at end Date"



*************************************************************************

* Locate peak dates and values - cases 


* peak


* current level of interventions

* S2 = current level of interventions and reciprocal of gamma is 2 = current, default 

summ DayCasMeRaA05S02V02 

gen DayCasMeRaA05S02V02P0V = r(max) 

label var DayCasMeRaA05S02V02P0V "DayCasMeRaA05S02V02 One peak Value"

summ date if DayCasMeRaA05S02V02 == DayCasMeRaA05S02V02P0V

gen DayCasMeRaA05S02V02P0D = r(max) 

label var DayCasMeRaA05S02V02P0D "DayCasMeRaA05S02V02 One peak Date"


* S3 current level of interventions and reciprocal of gamma is 5 = current, better

summ DayCasMeRaA05S03V02 

gen DayCasMeRaA05S03V02P0V = r(max) 

label var DayCasMeRaA05S03V02P0V "DayCasMeRaA05S03V02 One peak Value"

summ date if DayCasMeRaA05S03V02 == DayCasMeRaA05S03V02P0V 

gen DayCasMeRaA05S03V02P0D = r(max) 

label var DayCasMeRaA05S03V02P0D "DayCasMeRaA05S03V02 One peak Date"


* S1 current level of interventions and reciprocal of gamma is 1 = current, worse

summ DayCasMeRaA05S01V02

gen DayCasMeRaA05S01V02P0V = r(max) 

label var DayCasMeRaA05S01V02P0V "DayCasMeRaA05S01V02 One peak Value"

summ date if DayCasMeRaA05S01V02 == DayCasMeRaA05S01V02P0V

gen DayCasMeRaA05S01V02P0D = r(max) 

label var DayCasMeRaA05S01V02P0D "DayCasMeRaA05S01V02 One peak Date"



                            ****************************************************************************************
* restricted interventions, do not peak, but decrease consistenetly, with highest values at start of time shown (P7)
                            ****************************************************************************************


* S14 = restricted interventions and reciprocal of gamma is 2

summ DayCasMeRaA05S14V02 

gen DayCasMeRaA05S14V02P7V = r(max)

label var DayCasMeRaA05S14V02P7V "DayCasMeRaA05S14V02 Highest at start Value"

summ date if DayCasMeRaA05S14V02 == DayCasMeRaA05S14V02P7V

gen DayCasMeRaA05S14V02P7D = r(max)

label var DayCasMeRaA05S14V02P7D "DayCasMeRaA05S14V02 Highest at start Date"


* S15 = restricted interventions and reciprocal of gamma is 5 = restricted, better

summ DayCasMeRaA05S15V02 

gen DayCasMeRaA05S15V02P7V = r(max)

label var DayCasMeRaA05S15V02P7V "DayCasMeRaA05S15V02 Highest at start Value"

summ date if DayCasMeRaA05S15V02 == DayCasMeRaA05S15V02P7V & DayCasMeRaA05S15V02 != . 

gen DayCasMeRaA05S15V02P7D = r(max)

label var DayCasMeRaA05S15V02P7D "DayCasMeRaA05S15V02 Highest at start Date"


* S13 = restricted interventions and reciprocal of gamma is 1 = restricted, worse

summ DayCasMeRaA05S13V02 

gen DayCasMeRaA05S13V02P7V = r(max)

label var DayCasMeRaA05S13V02P7V "DayCasMeRaA05S13V02 Highest at start Value"

summ date if DayCasMeRaA05S13V02 == DayCasMeRaA05S13V02P7V & DayCasMeRaA05S13V02 != . 

gen DayCasMeRaA05S13V02P7D = r(max)

label var DayCasMeRaA05S13V02P7D "DayCasMeRaA05S13V02P7D Highest at start Date"



                           *****************************************************************************************
* released interventions : do not peak during time shown, reach max at last days of time shown, except S9 that peaks
                           *****************************************************************************************
						   
						   
* S8 = released interventions and reciprocal of gamma is 2 = released, default

summ DayCasMeRaA05S08V02 

gen DayCasMeRaA05S08V02P8V = r(max)

label var DayCasMeRaA05S08V02P8V "DayCasMeRaA05S08V02 Highest at end Value"

summ date if DayCasMeRaA05S08V02 == DayCasMeRaA05S08V02P8V

gen DayCasMeRaA05S08V02P8D = r(max)

label var DayCasMeRaA05S08V02P8D "DayCasMeRaA05S08V02 Highest at end Date"


* S9 = released interventions and reciprocal of gamma is 5 = released, better

summ DayCasMeRaA05S09V02 

gen DayCasMeRaA05S09V02P0V = r(max)

label var DayCasMeRaA05S09V02P0V "DayCasMeRaA05S09V02 one peak Value"

summ date if DayCasMeRaA05S09V02 == DayCasMeRaA05S09V02P0V 

gen DayCasMeRaA05S09V02P0D = r(max)

label var DayCasMeRaA05S09V02P0D "DayCasMeRaA05S09V02 one peak Date"


* S7 = released interventions and reciprocal of gamma is 1 = released, worse

summ DayCasMeRaA05S07V02 

gen DayCasMeRaA05S07V02P8V = r(max)

label var DayCasMeRaA05S07V02P8V "DayCasMeRaA05S07V02 Highest at end Value"

summ DayCasMeRaA05S07V02 if DayCasMeRaA05S07V02 == DayCasMeRaA05S07V02P8V

gen DayCasMeRaA05S07V02P8D = r(max)

label var DayCasMeRaA05S07V02P8D "DayCasMeRaA05S07V02 Highest at end Date"

*


sort date

compress






save "Iran SRIV.dta", replace

*




















*

use "Iran SRIV.dta", clear 








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




