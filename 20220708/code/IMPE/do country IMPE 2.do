
clear all

cd "$pathcovir2"

cd IMPE

capture log close 

log using "log country IMPE 2.smcl", replace

***************************************************************************
* This is "do country IMPE 2.do"

* Project: CovidVisualized country - countries without subnational estimates                                                                       
* Person: Farshad Pourmalek
***************************************************************************


* merge update files
* input data files: "country IMPE 202?????.dta " 
* output data files: "country IMPE longit.dta"


use "IMPE 20220102.dta", clear  

local list ///
20220102 ///
20220120 ///
20220131 ///
20220315 ///
20220530 ///
20220620



foreach update of local list {

	use "IMPE `update'.dta", clear
	
	capture rename DayDeaMeSmA03S00`update' DayDeaMeSmA03`update'
	
	capture drop update_date
	
	gen update_date = date("`update'", "YMD")
	 
	capture drop DayDeaFOREA03`update'
	
	gen DayDeaFOREA03`update' = DayDeaMeSmA03`update'
	
	replace DayDeaFOREA03`update' = . if date < update_date
	
	label var DayDeaFOREA03`update' "DayDeaMeSmA03 Forecast only"
	
	save "country IMPE `update'.dta", replace

}
* 




foreach update of local list {

	di in red "This is update " `update'
	
	merge m:m date loc_grand_name using "country IMPE `update'.dta"
	
	drop _merge
	
}
*


isid date, missok

sort loc_grand_name date

save "country IMPE longit.dta", replace




* add JOHN

cd .. // /code/

cd JOHN

use "country JOHN.dta", clear 

cd ..

cd IMPE 

save "country JOHN.dta", replace

merge m:m date loc_grand_name using "country IMPE longit.dta"
 
drop _merge

duplicates report date, gen duptag


isid date, missok

sort loc_grand_name date

qui compress

save "country IMPE longit.dta", replace










view "log country IMPE 2.smcl"

log close

exit, clear
