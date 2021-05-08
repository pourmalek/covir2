

clear all

dis "`c(username)'"

local usrnam = "`c(username)'"

di "`usrnam'"

****** set path based on local operating system ******

if regexm(c(os),"Mac") == 1 {
	global pathcovir2 "/Users/`usrnam'/Downloads/covir2-main/" 
}
else if regexm(c(os),"Windows") {
	global pathcovir2 = "C:\Users\\`usrnam'\Downloads\covir2-main\"
}
*


cd "$pathcovir2"
 
cd setup

capture log close

log using "log Studies models update dates Iran.smcl", replace


***************************************************************************
* This is "do Studies models update dates Iran.do"
                                                                                                          
* Project: COVID-19 Iran Review No 2                                              
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com                                                  
* Time (initial): 2021-04-13 

* OBJECTIVE: Get and prepare component studies' estimates for Iran
***************************************************************************



import excel using "Studies models update dates Iran.xlsx", clear firstrow sheet(Iran)

codebook date

drop if date == . 

label var date	"date calendar"

label var IHME_no "IHME update number"
label var IMPE_no "IMPE update number"
label var LANL_no "LANL update number"
label var SRIV_no "SRIV update number"

label var uptake_date "uptake date"
label var uptake_no   "uptake number"

label var IHME_uptake_no "IHME update number this uptake"
label var IMPE_uptake_no "IMPE update number this uptake"
label var LANL_uptake_no "LANL update number this uptake"
label var SRIV_uptake_no "SRIV update number this uptake"

label var IHME_uptake_date "IHME update date this uptake"
label var IMPE_uptake_date "IMPE update date this uptake"
label var LANL_uptake_date "LANL update date this uptake"
label var SRIV_uptake_date "SRIV update date this uptake"


												

/*

Every day, 
(1) Check for new updates by IHME. 
(2) If a new update by IHME is available, start a new uptake with today's date, and use this new update by IHME. 
(3) Look for latest available update by IMPE, and include that in this uptake. 
(4) Look for the latest available update by LANL, and include that in this uptake. 
(5) Look for update by SRIV for which the date is equal to date for IHME. 

(6) If no new update by IHME is available (from step 1), check for new updates by IMPE. 
(7) If a new update by IMPE is available, start a new uptake with today's date, and use this new update by IMPE. 
(8) Look for the latest available update by LANL, and include that in this uptake. 
(9) Look for update by SRIV for which the date is equal to date for IMPE. 

(10) If no new update by IMPE is available (from step 6), this is the end of search for a new uptake for today. 
There is not an uptake for today, even though LANL might have a new or recent update, and SRIV does have a new update everyday. 
The rationale for not creating an uptake for every new update of LANL and SRIV is that their frequency of releasing updates are about every 3-4 days and every single day respectively. Daily or every 3-4 days uptakes (here) would create more noise than insight. 
*/



levelsof date, local(levels) 

foreach l of local levels {

* Every day, 
* (1) Check for new updates by IHME. 

di %td `l'

list IHME_no if date == `l'

* (2) If a new update by IHME is available, start a new uptake with today's date, and use this new update by IHME. 

replace uptake_date        = `l' if date == `l' & IHME_no != . 
 
replace IHME_uptake_date   = `l' if uptake_date == `l'

replace IHME_uptake_no = IHME_no           if uptake_date == `l'


* (3) Look for latest available update by IMPE, and include that in this uptake. 

summ IMPE_no if date <= `l'

replace IMPE_uptake_no = r(max)            if uptake_date == `l'

summ date    if IMPE_no == r(max) & IMPE_uptake_no != . 
// last piece / & IMPE_uptake_no != . / prevents assigning a IMPE_uptake_date before date 2-Jul-20 with no IMPE_no

replace IMPE_uptake_date = r(max)          if uptake_date == `l'


* (4) Look for the latest available update by LANL, and include that in this uptake. 

summ LANL_no if date <= `l'

replace LANL_uptake_no = r(max)            if uptake_date == `l'

summ date    if LANL_no == r(max) 

replace LANL_uptake_date = r(max)          if uptake_date == `l'


* (5) Look for update by SRIV for which the date is equal to date for IHME. 

summ SRIV_no                               if uptake_date == `l'

replace SRIV_uptake_no = r(max)            if uptake_date == `l'

summ date    if SRIV_no == r(max) 

replace SRIV_uptake_date = r(max)          if uptake_date == `l'




* (6) If no new update by IHME is available (from step 1), check for new updates by IMPE. 
*     If a new update by IMPE is available, start a new uptake with today's date, and use this new update by IMPE. 

list IMPE_no if date == `l'

replace uptake_date        = `l' if date == `l' & IMPE_no != . & IHME_no == . 

replace IMPE_uptake_date   = `l' if date == `l' & IMPE_no != . & IHME_no == . 

replace IMPE_uptake_no = IMPE_no if date == `l' & IMPE_no != . & IHME_no == .  


* (7) Look for the latest available update by IHME, and include that in this uptake. 

summ IHME_no if date <= `l'

replace IHME_uptake_no = r(max)            if uptake_date == `l'

summ date    if IHME_no == r(max) 

replace IHME_uptake_date = r(max)          if uptake_date == `l'


* (8) Look for the latest available update by LANL, and include that in this uptake. 

summ LANL_no if date <= `l'

replace LANL_uptake_no = r(max)            if uptake_date == `l'

summ date    if LANL_no == r(max) 

replace LANL_uptake_date = r(max)          if uptake_date == `l'


* (9) Look for update by SRIV for which the date is equal to date for IMPE. 

summ SRIV_no                               if uptake_date == `l'

replace SRIV_uptake_no = r(max)            if uptake_date == `l'

summ date    if SRIV_no == r(max) 

replace SRIV_uptake_date = r(max)          if uptake_date == `l'


}
*


gen sdate = string(date, "%tdCCYYNNDD") 


save "Studies models update dates with rules Iran.dta", replace

* 

drop IHME_no IMPE_no LANL_no SRIV_no

drop if uptake_date == . 

replace uptake_no = _n 

save "Uptakes table Iran.dta", replace 

export delimited "Uptakes table Iran.csv", replace

di in red uptake_no[_N] // number of latest uptake

di in red sdate[_N] // date of latest uptake


view "log Studies models update dates Iran.smcl"

capture log close 










