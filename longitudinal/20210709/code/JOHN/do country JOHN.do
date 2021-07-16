

clear all

cd "$pathcovir2"

cd JOHN

capture log close 

log using "log country JOHN.smcl", replace

***************************************************************************
* This is "do country JOHN.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare Johns Hopkins data for country
***************************************************************************








local uptakedatelist ///
20210401 20210406 20210409 20210416 20210417 ///
20210423 20210424 20210506 20210514 20210515 ///
20210516 20210521 20210522 20210528 20210603 ///
20210604 20210605 20210610 20210611 20210618 ///
20210624 20210625 20210703 20210704 20210709


foreach l of local uptakedatelist {

qui {

cd "$pathcovir2" // "/Users/`usrnam'/Downloads/covir2-main/longitudinal/20210709/code"

cd .. // 20210709

cd .. // longitudinal

cd .. //  covir2-main

cd `l'

cd output

cd merge

use "country.dta", clear 

keep date loc_grand_name DayDeaMeRaA00S00 DayDeaMeSmA00S00 TotDeaMeRaA00S00 DayCasMeRaA00S00 DayCasMeSmA00S00 TotCasMeRaA00S00


local varlist DayDeaMeRaA00S00 DayDeaMeSmA00S00 TotDeaMeRaA00S00 DayCasMeRaA00S00 DayCasMeSmA00S00 TotCasMeRaA00S00

	foreach v of local varlist {
	
	rename `v' `v'U`l'

	}
	*

  

qui compress

cd .. // merge

cd .. // output

cd .. // `l'

cd longitudinal 

cd 20210709

cd code

cd JOHN

save "`l'.dta", replace

}

}
*




local uptakedatelist ///
20210401 20210406 20210409 20210416 20210417 ///
20210423 20210424 20210506 20210514 20210515 ///
20210516 20210521 20210522 20210528 20210603 ///
20210604 20210605 20210610 20210611 20210618 ///
20210624 20210625 20210703 20210704 20210709


foreach l of local uptakedatelist {

merge 1:1 date loc_grand_name using "`l'.dta"

drop _merge

}
*








view "log country JOHN.smcl"

log close

exit, clear




