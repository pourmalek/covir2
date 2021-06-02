
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
 
cd uptake
 

capture log close 

log using "log Iran uptake `c(current_date)'.smcl", replace

***************************************************************************
* This is "do Iran uptake.do"

* Project: COVID-19 Iran Review No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: process uptakes for Iran
***************************************************************************


* run get_ihme.R and get_impe.R to get their latest updates' dates

ssc install rsource, replace


if "`c(os)'"=="MacOSX" | "`c(os)'"=="UNIX" {
    rsource using get_ihme.R, rpath("/usr/local/bin/R") roptions(`"--vanilla"')
    rsource using get_impe.R, rpath("/usr/local/bin/R") roptions(`"--vanilla"')
	
}
else {  // windows
    rsource using get_ihme.R, rpath(`"c:\r\R-3.5.1\bin\Rterm.exe"') roptions(`"--vanilla"')  // change version number, if necessary
    rsource using get_impe.R, rpath(`"c:\r\R-3.5.1\bin\Rterm.exe"') roptions(`"--vanilla"')  // change version number, if necessary	
}
*


* read latest IHME update

import delimited using "get_ihme.csv", clear varnames(1)

keep in l

keep x

* https://ihmecovid19storage.blob.core.windows.net/archive/2021-05-21/ihme-covid19.zip                                                   

gen ihme_date_web = substr(x,58,10) 

list ihme_date_web

drop x

save ihme_date_web, replace 



* get avilable uptakes data

import delimited using "uptake_table.csv", clear varnames(1)

keep in l

keep ihme_date

rename ihme_date ihme_date_covir2

save ihme_date_covir2, replace 



* compare ihme_date_covir2 and ihme_date_web

use ihme_date_covir2, clear 

merge 1:1 _n using ihme_date_web

gen uptake_trigger_by_IHME = "yes"

replace uptake_trigger_by_IHME = "no" if _merge == 3 

di uptake_trigger_by_IHME
 
 
 
 

* read latest IMPE update

import delimited using "get_impe.csv", clear varnames(1)

keep in l

keep x

* /mrc-ide/global-lmic-reports/blob/master/data/2021-05-22_v8.csv.zip

gen impe_date_web = substr(x,47,10) 

list impe_date_web

drop x

save impe_date_web, replace 



* get avilable uptakes data

import delimited using "uptake_table.csv", clear varnames(1)

keep in l

keep impe_date

rename impe_date impe_date_covir2

save impe_date_covir2, replace 



* compare impe_date_covir2 and impe_date_web

use impe_date_covir2, clear 

merge 1:1 _n using impe_date_web

gen uptake_trigger_by_IMPE = "yes"

replace uptake_trigger_by_IMPE = "no" if _merge == 3 

di uptake_trigger_by_IMPE

 

 

view "log Iran uptake `c(current_date)'.smcl"

log close

exit, clear




