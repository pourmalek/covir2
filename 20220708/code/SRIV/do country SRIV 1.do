
clear all

cd "$pathcovir2"

cd SRIV

capture log close 

log using "log country SRIV 1.smcl", replace

***************************************************************************
* This is "do country SRIV 1.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek
***************************************************************************


* download estimates files 
* input data files: csv files on web site
* output data files: "country SRIV `update'.dta" 






clear 
	
set obs 1

* updates released in 2022:
		
local list `" "2022-01-01" "2022-01-02" "2022-01-03" "2022-01-04" "2022-01-05" "2022-01-06" "2022-01-08" "2022-01-09" "2022-01-10" "2022-01-11" "2022-01-12" "2022-01-13" "2022-01-15" "2022-01-16" "2022-01-17" "2022-01-18" "2022-01-19" "2022-01-20" "2022-01-22" "2022-01-23" "2022-01-24" "2022-01-25" "2022-01-26" "2022-01-27" "2022-01-29" "2022-01-30" "2022-02-04" "2022-02-05" "2022-02-06" "2022-02-07" "2022-02-08" "2022-02-09" "2022-02-10" "2022-02-11" "2022-02-12" "2022-02-13" "2022-02-14" "2022-02-15" "2022-02-16" "2022-02-17" "2022-02-18" "2022-02-19" "2022-02-20" "2022-02-21" "2022-02-22" "2022-02-23" "2022-02-24" "2022-02-25" "2022-02-26" "2022-02-27" "2022-02-28" "2022-03-01" "2022-03-05" "2022-03-06" "2022-03-07" "2022-03-08" "2022-03-09" "2022-03-10" "2022-03-11" "2022-03-12" "2022-03-13" "2022-03-14" "2022-03-15" "2022-03-16" "2022-03-17" "2022-03-18" "2022-03-19" "2022-03-20" "2022-03-21" "2022-03-22" "2022-03-23" "2022-03-24" "2022-03-25" "2022-03-26" "2022-03-27" "2022-03-28" "2022-03-29" "2022-03-30" "2022-03-31" "2022-04-01" "2022-04-02" "2022-04-03" "2022-04-04" "2022-04-05" "2022-04-06" "2022-04-07" "2022-04-08" "2022-04-09" "2022-04-10" "2022-04-11" "2022-04-13" "2022-04-17" "2022-04-18" "2022-04-19" "2022-04-20" "2022-04-21" "2022-04-22" "2022-04-23" "2022-04-24" "2022-04-25" "2022-04-26" "2022-04-27" "2022-04-28" "2022-04-29" "2022-04-30" "2022-05-01" "2022-05-02" "2022-05-08" "2022-05-15" "2022-05-16" "2022-05-17" "2022-05-18" "2022-05-19" "2022-05-20" "2022-05-21" "2022-05-22" "2022-06-02" "2022-06-03" "2022-06-05" "2022-06-06" "2022-06-07" "2022-06-08" "2022-06-09" "2022-06-10" "2022-06-11" "2022-06-12" "2022-06-14" "2022-06-15" "2022-06-17" "2022-06-18" "2022-06-19" "2022-06-20" "2022-06-21" "2022-06-22" "2022-06-23" "2022-06-24" "2022-06-25" "2022-06-26" "2022-06-27" "2022-06-28" "2022-06-29" "2022-06-30" "2022-07-01" "2022-07-02" "2022-07-03" "2022-07-04" "2022-07-05" "2022-07-06" "2022-07-07" "2022-07-08" "'


* updates without "global_forecasts_deaths.csv":
* "2022-01-07" "2022-01-14" "2022-01-21" "2022-01-28" "2022-02-03" "2022-03-02"
* "2022-04-12" "2022-04-14" "2022-04-15" "2022-04-16" "2022-05-03" "2022-05-09"
* "2022-05-10" "2022-05-11" "2022-05-12" "2022-05-13" "2022-05-14" "2022-05-23"
* "2022-05-24" "2022-05-25" "2022-05-26" "2022-05-27" "2022-05-28" "2022-05-29"
* "2022-05-30" "2022-05-31" "2022-06-01" "2022-06-04" "2022-06-13" "2022-06-16"




	
foreach update of local list {	
	
	di in red ">>>>> This is update " "`update'"
	
	* transfrom update (2022-01-01) to updatestring (20220101)
	
	capture drop updatestring
	gen updatestring = "`update'"
	
	gen year = substr(updatestring,1,4) 
	gen month = substr(updatestring,6,2) 
	gen day = substr(updatestring,9,2) 
	capture drop updatestring2
	egen updatestring2 = concat(year month day)
	
	drop updatestring
	rename updatestring2 updatestring
	local updatestring = updatestring
	
	di ">>>>> updatestring is " `updatestring'
	
	* download "global_forecasts_deaths.csv" for each update
	
	copy https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/`update'/global_forecasts_deaths.csv global_forecasts_deaths.csv 
			
	import delimited "global_forecasts_deaths.csv", clear varnames(1) 
	
			keep if regexm(country,"$country") == 1
		
	qui destring *, replace
	
	* destring for Total Deaths that contain NaN instead of numbers
	
	qui {
		foreach v of var * {
			capture replace `v' = "" if `v' == "NaN"
		}
			*
		destring *, replace
	}	
	
	drop id
	
	* use varlables for varnames
	
	foreach v of var v* {
		local lbl : var label `v'
		local lbl = strtoname("`lbl'")
		rename `v' `lbl'					
	}		
*
 
	rename (_*) (v_*)
	
	* reshape long
		
	gen i = _n
	qui reshape long v, i(i) j(j, string)
	rename v TotDeaMeRaA05
	rename j date_original
	drop i
	
	* gen date
	
	gen year = substr(date_original,2,4) 
	gen month = substr(date_original,7,2) 
	gen day = substr(date_original,10,2) 
	egen date2 = concat(day month year)
	gen date = date(date2, "DMY", 2050)
	format date %tdDDMonCCYY
	codebook date
	drop year month day date2 date_original

	* add update date to the end of Total Deaths

	rename TotDeaMeRaA05 TotDeaMeRaA05`updatestring'
	
	* gen update date for this update
	
	gen update = "`updatestring'"
	gen update_date = date(update, "YMD")
	format update_date %tdDDMonCCYY
	codebook update_date
	
	destring update, replace
	local update = update
	
	
	
	
	* gen daily deaths
	
	sort date 
		    
	gen DayDeaMeRaA05`update' =  TotDeaMeRaA05`update'[_n] - TotDeaMeRaA05`update'[_n-1]
	
	drop TotDeaMeRaA05`update'
	
	
	
	* smooth
	
	tsset date, daily   
	
	qui {
		tssmooth ma DayDeaMeRaA05`update'_window = DayDeaMeRaA05`update' if DayDeaMeRaA05`update' >= 0, window(3 1 3) 
		
		tssmooth ma DayDeaMeSmA05`update' = DayDeaMeRaA05`update'_window, weights( 1 2 3 <4> 3 2 1) replace
		
		label var DayDeaMeSmA05`update' "Daily deaths smooth mean SRIV"
		
		drop DayDeaMeRaA05`update'_window DayDeaMeRaA05`update'
		
	}	
	*	
	
	
	
	local update_date = update_date
		
		
	* gen FORE, that is forecast only 
		
	gen DayDeaFOREA05`update' = DayDeaMeSmA05`update'
	
	label var DayDeaFOREA05`update' "Daily deaths smooth mean forecast only SRIV"
	
	di ">>>>> update_date is " `update_date'
	
	replace DayDeaFOREA05`update' = . if date < `update_date'
	
	rename country loc_grand_name	
		
	qui compress
	
	save "country SRIV `updatestring'.dta", replace

	 
	shell rm -r "global_forecasts_deaths.csv" 

}
*


view "log country SRIV 1.smcl"

log close

exit, clear




