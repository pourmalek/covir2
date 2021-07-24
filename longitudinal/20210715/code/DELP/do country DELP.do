
clear all
 
cd "$pathcovir2"

cd DELP

capture log close 

log using "log country DELP.smcl", replace

******************************************************************************
* This is "do country DELP.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare DELP data for country
******************************************************************************



clear

* 168 update dates starting from 20200723, to 20210719.
* update 20201119 is transition fron v2 to v4 (no v3), here v4 kept

local updatelist ///
Global_V2_since100_20200723.csv ///
Global_V2_since100_20200919.csv ///
Global_V2_since100_20200926.csv ///
Global_V2_since100_20201001.csv ///
Global_V2_since100_20201008.csv ///
Global_V2_since100_20201015.csv ///
Global_V2_since100_20201022.csv ///
Global_V2_since100_20201029.csv ///
Global_V2_since100_20201105.csv ///
Global_V2_since100_20201112.csv ///
Global_V4_since100_20201119.csv ///
Global_V4_since100_20201126.csv ///
Global_V4_since100_20201203.csv ///
Global_V4_since100_20201210.csv ///
Global_V4_since100_20201217.csv ///
Global_V4_since100_20201224.csv ///
Global_V4_since100_20201231.csv ///
Global_V4_since100_20210107.csv ///
Global_V4_since100_20210114.csv ///
Global_V4_since100_20210121.csv ///
Global_V4_since100_20210128.csv ///
Global_V4_since100_20210204.csv ///
Global_V4_since100_20210211.csv ///
Global_V4_since100_20210218.csv ///
Global_V4_since100_20210225.csv ///
Global_V4_since100_20210226.csv ///
Global_V4_since100_20210227.csv ///
Global_V4_since100_20210228.csv ///
Global_V4_since100_20210301.csv ///
Global_V4_since100_20210303.csv ///
Global_V4_since100_20210304.csv ///
Global_V4_since100_20210305.csv ///
Global_V4_since100_20210306.csv ///
Global_V4_since100_20210307.csv ///
Global_V4_since100_20210308.csv ///
Global_V4_since100_20210309.csv ///
Global_V4_since100_20210310.csv ///
Global_V4_since100_20210311.csv ///
Global_V4_since100_20210312.csv ///
Global_V4_since100_20210313.csv ///
Global_V4_since100_20210314.csv ///
Global_V4_since100_20210315.csv ///
Global_V4_since100_20210316.csv ///
Global_V4_since100_20210317.csv ///
Global_V4_since100_20210318.csv ///
Global_V4_since100_20210319.csv ///
Global_V4_since100_20210320.csv ///
Global_V4_since100_20210321.csv ///
Global_V4_since100_20210322.csv ///
Global_V4_since100_20210323.csv ///
Global_V4_since100_20210324.csv ///
Global_V4_since100_20210325.csv ///
Global_V4_since100_20210326.csv ///
Global_V4_since100_20210327.csv ///
Global_V4_since100_20210328.csv ///
Global_V4_since100_20210329.csv ///
Global_V4_since100_20210330.csv ///
Global_V4_since100_20210331.csv ///
Global_V4_since100_20210401.csv ///
Global_V4_since100_20210402.csv ///
Global_V4_since100_20210403.csv ///
Global_V4_since100_20210404.csv ///
Global_V4_since100_20210405.csv ///
Global_V4_since100_20210406.csv ///
Global_V4_since100_20210407.csv ///
Global_V4_since100_20210408.csv ///
Global_V4_since100_20210409.csv ///
Global_V4_since100_20210410.csv ///
Global_V4_since100_20210411.csv ///
Global_V4_since100_20210412.csv ///
Global_V4_since100_20210413.csv ///
Global_V4_since100_20210414.csv ///
Global_V4_since100_20210415.csv ///
Global_V4_since100_20210416.csv ///
Global_V4_since100_20210417.csv ///
Global_V4_since100_20210418.csv ///
Global_V4_since100_20210419.csv ///
Global_V4_since100_20210420.csv ///
Global_V4_since100_20210421.csv ///
Global_V4_since100_20210422.csv ///
Global_V4_since100_20210423.csv ///
Global_V4_since100_20210424.csv ///
Global_V4_since100_20210425.csv ///
Global_V4_since100_20210426.csv ///
Global_V4_since100_20210427.csv ///
Global_V4_since100_20210428.csv ///
Global_V4_since100_20210429.csv ///
Global_V4_since100_20210430.csv ///
Global_V4_since100_20210501.csv ///
Global_V4_since100_20210502.csv ///
Global_V4_since100_20210503.csv ///
Global_V4_since100_20210504.csv ///
Global_V4_since100_20210505.csv ///
Global_V4_since100_20210506.csv ///
Global_V4_since100_20210507.csv ///
Global_V4_since100_20210508.csv ///
Global_V4_since100_20210509.csv ///
Global_V4_since100_20210510.csv ///
Global_V4_since100_20210511.csv ///
Global_V4_since100_20210512.csv ///
Global_V4_since100_20210513.csv ///
Global_V4_since100_20210514.csv ///
Global_V4_since100_20210515.csv ///
Global_V4_since100_20210516.csv ///
Global_V4_since100_20210517.csv ///
Global_V4_since100_20210518.csv ///
Global_V4_since100_20210519.csv ///
Global_V4_since100_20210520.csv ///
Global_V4_since100_20210521.csv ///
Global_V4_since100_20210522.csv ///
Global_V4_since100_20210523.csv ///
Global_V4_since100_20210524.csv ///
Global_V4_since100_20210525.csv ///
Global_V4_since100_20210526.csv ///
Global_V4_since100_20210527.csv ///
Global_V4_since100_20210528.csv ///
Global_V4_since100_20210529.csv ///
Global_V4_since100_20210530.csv ///
Global_V4_since100_20210531.csv ///
Global_V4_since100_20210601.csv ///
Global_V4_since100_20210602.csv ///
Global_V4_since100_20210603.csv ///
Global_V4_since100_20210604.csv ///
Global_V4_since100_20210605.csv ///
Global_V4_since100_20210606.csv ///
Global_V4_since100_20210607.csv ///
Global_V4_since100_20210608.csv ///
Global_V4_since100_20210609.csv ///
Global_V4_since100_20210610.csv ///
Global_V4_since100_20210611.csv ///
Global_V4_since100_20210612.csv ///
Global_V4_since100_20210613.csv ///
Global_V4_since100_20210614.csv ///
Global_V4_since100_20210615.csv ///
Global_V4_since100_20210616.csv ///
Global_V4_since100_20210617.csv ///
Global_V4_since100_20210618.csv ///
Global_V4_since100_20210619.csv ///
Global_V4_since100_20210620.csv ///
Global_V4_since100_20210621.csv ///
Global_V4_since100_20210622.csv ///
Global_V4_since100_20210623.csv ///
Global_V4_since100_20210624.csv ///
Global_V4_since100_20210625.csv ///
Global_V4_since100_20210626.csv ///
Global_V4_since100_20210627.csv ///
Global_V4_since100_20210628.csv ///
Global_V4_since100_20210629.csv ///
Global_V4_since100_20210630.csv ///
Global_V4_since100_20210701.csv ///
Global_V4_since100_20210702.csv ///
Global_V4_since100_20210703.csv ///
Global_V4_since100_20210704.csv ///
Global_V4_since100_20210705.csv ///
Global_V4_since100_20210706.csv ///
Global_V4_since100_20210707.csv ///
Global_V4_since100_20210708.csv ///
Global_V4_since100_20210709.csv ///
Global_V4_since100_20210710.csv ///
Global_V4_since100_20210711.csv ///
Global_V4_since100_20210712.csv ///
Global_V4_since100_20210713.csv ///
Global_V4_since100_20210714.csv ///
Global_V4_since100_20210715.csv ///
Global_V4_since100_20210716.csv ///
Global_V4_since100_20210717.csv ///
Global_V4_since100_20210718.csv ///
Global_V4_since100_20210719.csv





foreach l of local updatelist {

qui {

copy https://raw.githubusercontent.com/COVIDAnalytics/website/master/data/predicted/`l' `l'

import delimited using "`l'", clear varnames(1)

rename country loc_grand_name

keep if regexm(loc_grand_name,"$country") == 1


* gen date

rename day date_original

gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date

drop year month day date2


* rename outcome variables


* total vars

rename totaldetecteddeaths   TotDeaMeRaA01S00
label var TotDeaMeRaA01S00 "Total Deaths Mean DELP S0"
rename totaldetected   TotCasMeRaA01S00
label var TotCasMeRaA01S00 "Total Cases Mean DELP S0"


* gen daily vars and rename

sort date

gen DayDeaMeRaA01S00 =  TotDeaMeRaA01S00[_n] - TotDeaMeRaA01S00[_n-1]
gen DayCasMeRaA01S00 =  TotCasMeRaA01S00[_n] - TotCasMeRaA01S00[_n-1]
label var DayDeaMeRaA01S00 "Daily Deaths Mean DELP S0"
label var DayCasMeRaA01S00 "Daily Cases Mean DELP S0"

keep ///
date loc_grand_name ///
DayDeaMeRaA01S00 TotDeaMeRaA01S00 DayCasMeRaA01S00 TotCasMeRaA01S00 
 
order ///
date loc_grand_name ///
DayDeaMeRaA01S00 TotDeaMeRaA01S00 DayCasMeRaA01S00 TotCasMeRaA01S00  
 
sort date loc_grand_name

compress 

 
* gen update date

local update = substr("`l'",20,8)  


* add update date to the end of varnames

local varlist ///
DayDeaMeRaA01S00 DayCasMeRaA01S00 TotDeaMeRaA01S00 TotCasMeRaA01S00

	foreach v of local varlist {
	
	rename `v' `v'U`update'

	}
	*
 

save `update', replace

* quitely running commands ...

}
}
*
	
	
	
* get JOHN	


qui {

cd "$pathcovir2" // "/Users/`usrnam'/Downloads/covir2-main/longitudinal/20210715/code"

cd JOHN 

use "country JOHN.dta", clear 

keep date loc_grand_name DayDeaMeRaA00S00 DayDeaMeSmA00S00 TotDeaMeRaA00S00 DayCasMeRaA00S00 DayCasMeSmA00S00 TotCasMeRaA00S00

sort date loc_grand_name

cd .. // code

cd DELP

save "JOHN.dta", replace

* quitely running commands ...

}
*
	
	
	
	
	
* merge DELP updates on JOHN
	
	
use "JOHN.dta", clear 


global DELPupdatelist /// 
20200723 ///
20200919 ///
20200926 ///
20201001 ///
20201008 ///
20201015 ///
20201022 ///
20201029 ///
20201105 ///
20201112 ///
20201119 ///
20201126 ///
20201203 ///
20201210 ///
20201217 ///
20201224 ///
20201231 ///
20210107 ///
20210114 ///
20210121 ///
20210128 ///
20210204 ///
20210211 ///
20210218 ///
20210225 ///
20210226 ///
20210227 ///
20210228 ///
20210301 ///
20210303 ///
20210304 ///
20210305 ///
20210306 ///
20210307 ///
20210308 ///
20210309 ///
20210310 ///
20210311 ///
20210312 ///
20210313 ///
20210314 ///
20210315 ///
20210316 ///
20210317 ///
20210318 ///
20210319 ///
20210320 ///
20210321 ///
20210322 ///
20210323 ///
20210324 ///
20210325 ///
20210326 ///
20210327 ///
20210328 ///
20210329 ///
20210330 ///
20210331 ///
20210401 ///
20210402 ///
20210403 ///
20210404 ///
20210405 ///
20210406 ///
20210407 ///
20210408 ///
20210409 ///
20210410 ///
20210411 ///
20210412 ///
20210413 ///
20210414 ///
20210415 ///
20210416 ///
20210417 ///
20210418 ///
20210419 ///
20210420 ///
20210421 ///
20210422 ///
20210423 ///
20210424 ///
20210425 ///
20210426 ///
20210427 ///
20210428 ///
20210429 ///
20210430 ///
20210501 ///
20210502 ///
20210503 ///
20210504 ///
20210505 ///
20210506 ///
20210507 ///
20210508 ///
20210509 ///
20210510 ///
20210511 ///
20210512 ///
20210513 ///
20210514 ///
20210515 ///
20210516 ///
20210517 ///
20210518 ///
20210519 ///
20210520 ///
20210521 ///
20210522 ///
20210523 ///
20210524 ///
20210525 ///
20210526 ///
20210527 ///
20210528 ///
20210529 ///
20210530 ///
20210531 ///
20210601 ///
20210602 ///
20210603 ///
20210604 ///
20210605 ///
20210606 ///
20210607 ///
20210608 ///
20210609 ///
20210610 ///
20210611 ///
20210612 ///
20210613 ///
20210614 ///
20210615 ///
20210616 ///
20210617 ///
20210618 ///
20210619 ///
20210620 ///
20210621 ///
20210622 ///
20210623 ///
20210624 ///
20210625 ///
20210626 ///
20210627 ///
20210628 ///
20210629 ///
20210630 ///
20210701 ///
20210702 ///
20210703 ///
20210704 ///
20210705 ///
20210706 ///
20210707 ///
20210708 ///
20210709 ///
20210710 ///
20210711 ///
20210712 ///
20210713 ///
20210714 ///
20210715 ///
20210716 ///
20210717 ///
20210718 ///
20210719







foreach l of global DELPupdatelist {

qui {

merge m:m date loc_grand_name using "`l'.dta"

drop _merge

* quitely running commands ...

}
}
*




* gen vars for D Difference, T Times (more or less), P Percent

foreach l of global DELPupdatelist {

qui {

gen DayDeaMeRaA01S00U`l'D = DayDeaMeRaA01S00U`l' - DayDeaMeSmA00S00 // D Difference 
gen DayDeaMeRaA01S00U`l'T = DayDeaMeRaA01S00U`l' / DayDeaMeSmA00S00 // T Times (more or less)
gen DayDeaMeRaA01S00U`l'P = 100 * (DayDeaMeRaA01S00U`l' - DayDeaMeSmA00S00) / DayDeaMeSmA00S00 // P Percent

gen DayCasMeRaA01S00U`l'D = DayCasMeRaA01S00U`l' - DayCasMeSmA00S00 // D Difference 
gen DayCasMeRaA01S00U`l'T = DayCasMeRaA01S00U`l' / DayCasMeSmA00S00 // T Times (more or less)
gen DayCasMeRaA01S00U`l'P = 100 * (DayCasMeRaA01S00U`l' - DayCasMeSmA00S00) / DayCasMeSmA00S00 // P Percent

gen TotDeaMeRaA01S00U`l'D = TotDeaMeRaA01S00U`l' - TotDeaMeRaA00S00 // D Difference 
gen TotDeaMeRaA01S00U`l'T = TotDeaMeRaA01S00U`l' / TotDeaMeRaA00S00 // T Times (more or less)
gen TotDeaMeRaA01S00U`l'P = 100 * (TotDeaMeRaA01S00U`l' - TotDeaMeRaA00S00) / TotDeaMeRaA00S00 // P Percent

gen TotCasMeRaA01S00U`l'D = TotCasMeRaA01S00U`l' - TotCasMeRaA00S00 // D Difference 
gen TotCasMeRaA01S00U`l'T = TotCasMeRaA01S00U`l' / TotCasMeRaA00S00 // T Times (more or less)
gen TotCasMeRaA01S00U`l'P = 100 * (TotCasMeRaA01S00U`l' - TotCasMeRaA00S00) / TotCasMeRaA00S00 // P Percent 

}
}
*





sort date loc_grand_name

qui compress 

save "country DELP.dta", replace










**********************************************************

* graphs


grstyle init

grstyle color background white




* daily deaths

**************************************

* daily deaths, Absolute value, individual updates


foreach l of global DELPupdatelist {

twoway  /// 
(line DayDeaMeSmA00S00 date, lcolor(cyan*1.2)) /// 
(line DayDeaMeRaA01S00U`l' date, sort lcolor(red)) /// 
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, DELP, update `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN smooth" 2 "DELP `l'") size(small) rows(1))	yscale(titlegap(2))

qui graph save "graph 11i COVID-19 daily deaths, $country, DELP update `l'.gph", replace
qui graph export "graph 11i COVID-19 daily deaths, $country, DELP update `l'.pdf", replace


}
*





* daily deaths, Absolute value, together, with extremes 168

twoway  ///
(line DayDeaMeRaA01S00U20200723 date, sort lcolor(red) lpattern(dash)) /// 1
(line DayDeaMeRaA01S00U20200919 date, sort lcolor(red) lpattern(dash)) /// 2
(line DayDeaMeRaA01S00U20200926 date, sort lcolor(red) lpattern(dash)) /// 3
(line DayDeaMeRaA01S00U20201001 date, sort lcolor(red) lpattern(dash)) /// 4
(line DayDeaMeRaA01S00U20201008 date, sort lcolor(red) lpattern(dash)) /// 5
(line DayDeaMeRaA01S00U20201015 date, sort lcolor(red) lpattern(dash)) /// 6
(line DayDeaMeRaA01S00U20201022 date, sort lcolor(red) lpattern(dash)) /// 7
(line DayDeaMeRaA01S00U20201029 date, sort lcolor(red) lpattern(dash)) /// 8
(line DayDeaMeRaA01S00U20201105 date, sort lcolor(red) lpattern(dash)) /// 9
(line DayDeaMeRaA01S00U20201112 date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line DayDeaMeRaA01S00U20201119 date, sort lcolor(red)) /// 11 v4
(line DayDeaMeRaA01S00U20201126 date, sort lcolor(red)) /// 12
(line DayDeaMeRaA01S00U20201203 date, sort lcolor(red)) /// 13
(line DayDeaMeRaA01S00U20201210 date, sort lcolor(red)) /// 14
(line DayDeaMeRaA01S00U20201217 date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20201224 date, sort lcolor(red)) /// 16
(line DayDeaMeRaA01S00U20201231 date, sort lcolor(red)) /// 17
(line DayDeaMeRaA01S00U20210107 date, sort lcolor(red)) /// 18
(line DayDeaMeRaA01S00U20210114 date, sort lcolor(red)) /// 19
(line DayDeaMeRaA01S00U20210121 date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210128 date, sort lcolor(red)) /// 21
(line DayDeaMeRaA01S00U20210204 date, sort lcolor(red)) /// 22
(line DayDeaMeRaA01S00U20210211 date, sort lcolor(red)) /// 23
(line DayDeaMeRaA01S00U20210218 date, sort lcolor(red)) /// 24
(line DayDeaMeRaA01S00U20210225 date, sort lcolor(red)) /// 25
(line DayDeaMeRaA01S00U20210226 date, sort lcolor(red)) /// 26
(line DayDeaMeRaA01S00U20210227 date, sort lcolor(red)) /// 27
(line DayDeaMeRaA01S00U20210228 date, sort lcolor(red)) /// 28
(line DayDeaMeRaA01S00U20210301 date, sort lcolor(red)) /// 29
(line DayDeaMeRaA01S00U20210303 date, sort lcolor(red)) /// 30
(line DayDeaMeRaA01S00U20210304 date, sort lcolor(red)) /// 31
(line DayDeaMeRaA01S00U20210305 date, sort lcolor(red)) /// 32
(line DayDeaMeRaA01S00U20210306 date, sort lcolor(red)) /// 33
(line DayDeaMeRaA01S00U20210307 date, sort lcolor(red)) /// 34
(line DayDeaMeRaA01S00U20210308 date, sort lcolor(red)) /// 35
(line DayDeaMeRaA01S00U20210309 date, sort lcolor(red)) /// 36
(line DayDeaMeRaA01S00U20210310 date, sort lcolor(red)) /// 37
(line DayDeaMeRaA01S00U20210311 date, sort lcolor(red)) /// 38
(line DayDeaMeRaA01S00U20210312 date, sort lcolor(red)) /// 39
(line DayDeaMeRaA01S00U20210313 date, sort lcolor(red)) /// 40
(line DayDeaMeRaA01S00U20210314 date, sort lcolor(red)) /// 41
(line DayDeaMeRaA01S00U20210315 date, sort lcolor(red)) /// 42
(line DayDeaMeRaA01S00U20210316 date, sort lcolor(red)) /// 43
(line DayDeaMeRaA01S00U20210317 date, sort lcolor(red)) /// 44
(line DayDeaMeRaA01S00U20210318 date, sort lcolor(red)) /// 45
(line DayDeaMeRaA01S00U20210319 date, sort lcolor(red)) /// 46
(line DayDeaMeRaA01S00U20210320 date, sort lcolor(red)) /// 47
(line DayDeaMeRaA01S00U20210321 date, sort lcolor(red)) /// 48
(line DayDeaMeRaA01S00U20210322 date, sort lcolor(red)) /// 49
(line DayDeaMeRaA01S00U20210323 date, sort lcolor(red)) /// 50
(line DayDeaMeRaA01S00U20210324 date, sort lcolor(red)) /// 51
(line DayDeaMeRaA01S00U20210325 date, sort lcolor(red)) /// 52
(line DayDeaMeRaA01S00U20210326 date, sort lcolor(red)) /// 53
(line DayDeaMeRaA01S00U20210327 date, sort lcolor(red)) /// 54
(line DayDeaMeRaA01S00U20210328 date, sort lcolor(red)) /// 55
(line DayDeaMeRaA01S00U20210329 date, sort lcolor(red)) /// 56
(line DayDeaMeRaA01S00U20210330 date, sort lcolor(red)) /// 57
(line DayDeaMeRaA01S00U20210331 date, sort lcolor(red)) /// 58
(line DayDeaMeRaA01S00U20210401 date, sort lcolor(red)) /// 59
(line DayDeaMeRaA01S00U20210402 date, sort lcolor(red)) /// 60
(line DayDeaMeRaA01S00U20210403 date, sort lcolor(red)) /// 61
(line DayDeaMeRaA01S00U20210404 date, sort lcolor(red)) /// 62
(line DayDeaMeRaA01S00U20210405 date, sort lcolor(red)) /// 63
(line DayDeaMeRaA01S00U20210406 date, sort lcolor(red)) /// 64
(line DayDeaMeRaA01S00U20210407 date, sort lcolor(red)) /// 65
(line DayDeaMeRaA01S00U20210408 date, sort lcolor(red)) /// 66
(line DayDeaMeRaA01S00U20210409 date, sort lcolor(red)) /// 67
(line DayDeaMeRaA01S00U20210410 date, sort lcolor(red)) /// 68
(line DayDeaMeRaA01S00U20210411 date, sort lcolor(red)) /// 69
(line DayDeaMeRaA01S00U20210412 date, sort lcolor(red)) /// 70
(line DayDeaMeRaA01S00U20210413 date, sort lcolor(red)) /// 71
(line DayDeaMeRaA01S00U20210414 date, sort lcolor(red)) /// 72
(line DayDeaMeRaA01S00U20210415 date, sort lcolor(red)) /// 73
(line DayDeaMeRaA01S00U20210416 date, sort lcolor(red)) /// 74
(line DayDeaMeRaA01S00U20210417 date, sort lcolor(red)) /// 75
(line DayDeaMeRaA01S00U20210418 date, sort lcolor(red)) /// 76
(line DayDeaMeRaA01S00U20210419 date, sort lcolor(red)) /// 77
(line DayDeaMeRaA01S00U20210420 date, sort lcolor(red)) /// 78
(line DayDeaMeRaA01S00U20210421 date, sort lcolor(red)) /// 79
(line DayDeaMeRaA01S00U20210422 date, sort lcolor(red)) /// 80
(line DayDeaMeRaA01S00U20210423 date, sort lcolor(red)) /// 81
(line DayDeaMeRaA01S00U20210424 date, sort lcolor(red)) /// 82
(line DayDeaMeRaA01S00U20210425 date, sort lcolor(red)) /// 83
(line DayDeaMeRaA01S00U20210426 date, sort lcolor(red)) /// 84
(line DayDeaMeRaA01S00U20210427 date, sort lcolor(red)) /// 85
(line DayDeaMeRaA01S00U20210428 date, sort lcolor(red)) /// 86
(line DayDeaMeRaA01S00U20210429 date, sort lcolor(red)) /// 87
(line DayDeaMeRaA01S00U20210430 date, sort lcolor(red)) /// 88
(line DayDeaMeRaA01S00U20210501 date, sort lcolor(red)) /// 89
(line DayDeaMeRaA01S00U20210502 date, sort lcolor(red)) /// 90
(line DayDeaMeRaA01S00U20210503 date, sort lcolor(red)) /// 91
(line DayDeaMeRaA01S00U20210504 date, sort lcolor(red)) /// 92
(line DayDeaMeRaA01S00U20210505 date, sort lcolor(red)) /// 93
(line DayDeaMeRaA01S00U20210506 date, sort lcolor(red)) /// 94
(line DayDeaMeRaA01S00U20210507 date, sort lcolor(red)) /// 95
(line DayDeaMeRaA01S00U20210508 date, sort lcolor(red)) /// 96
(line DayDeaMeRaA01S00U20210509 date, sort lcolor(red)) /// 97
(line DayDeaMeRaA01S00U20210510 date, sort lcolor(red)) /// 98
(line DayDeaMeRaA01S00U20210511 date, sort lcolor(red)) /// 99
(line DayDeaMeRaA01S00U20210512 date, sort lcolor(red)) /// 100
(line DayDeaMeRaA01S00U20210513 date, sort lcolor(red)) /// 101
(line DayDeaMeRaA01S00U20210514 date, sort lcolor(red)) /// 102
(line DayDeaMeRaA01S00U20210515 date, sort lcolor(red)) /// 103
(line DayDeaMeRaA01S00U20210516 date, sort lcolor(red)) /// 104
(line DayDeaMeRaA01S00U20210517 date, sort lcolor(red)) /// 105
(line DayDeaMeRaA01S00U20210518 date, sort lcolor(red)) /// 106
(line DayDeaMeRaA01S00U20210519 date, sort lcolor(red)) /// 107
(line DayDeaMeRaA01S00U20210520 date, sort lcolor(red)) /// 108
(line DayDeaMeRaA01S00U20210521 date, sort lcolor(red)) /// 109
(line DayDeaMeRaA01S00U20210522 date, sort lcolor(red)) /// 110
(line DayDeaMeRaA01S00U20210523 date, sort lcolor(red)) /// 111
(line DayDeaMeRaA01S00U20210524 date, sort lcolor(red)) /// 112
(line DayDeaMeRaA01S00U20210525 date, sort lcolor(red)) /// 113
(line DayDeaMeRaA01S00U20210526 date, sort lcolor(red)) /// 114
(line DayDeaMeRaA01S00U20210527 date, sort lcolor(red)) /// 115
(line DayDeaMeRaA01S00U20210528 date, sort lcolor(red)) /// 116
(line DayDeaMeRaA01S00U20210529 date, sort lcolor(red)) /// 117
(line DayDeaMeRaA01S00U20210530 date, sort lcolor(red)) /// 118
(line DayDeaMeRaA01S00U20210531 date, sort lcolor(red)) /// 119
(line DayDeaMeRaA01S00U20210601 date, sort lcolor(red)) /// 120
(line DayDeaMeRaA01S00U20210602 date, sort lcolor(red)) /// 121
(line DayDeaMeRaA01S00U20210603 date, sort lcolor(red)) /// 122
(line DayDeaMeRaA01S00U20210604 date, sort lcolor(red)) /// 123
(line DayDeaMeRaA01S00U20210605 date, sort lcolor(red)) /// 124
(line DayDeaMeRaA01S00U20210606 date, sort lcolor(red)) /// 125
(line DayDeaMeRaA01S00U20210607 date, sort lcolor(red)) /// 126
(line DayDeaMeRaA01S00U20210608 date, sort lcolor(red)) /// 127
(line DayDeaMeRaA01S00U20210609 date, sort lcolor(red)) /// 128
(line DayDeaMeRaA01S00U20210610 date, sort lcolor(red)) /// 129
(line DayDeaMeRaA01S00U20210611 date, sort lcolor(red)) /// 130
(line DayDeaMeRaA01S00U20210612 date, sort lcolor(red)) /// 131
(line DayDeaMeRaA01S00U20210613 date, sort lcolor(red)) /// 132
(line DayDeaMeRaA01S00U20210614 date, sort lcolor(red)) /// 133
(line DayDeaMeRaA01S00U20210615 date, sort lcolor(red)) /// 134
(line DayDeaMeRaA01S00U20210616 date, sort lcolor(red)) /// 135
(line DayDeaMeRaA01S00U20210617 date, sort lcolor(red)) /// 136
(line DayDeaMeRaA01S00U20210618 date, sort lcolor(red)) /// 137
(line DayDeaMeRaA01S00U20210619 date, sort lcolor(red)) /// 138
(line DayDeaMeRaA01S00U20210620 date, sort lcolor(red)) /// 139
(line DayDeaMeRaA01S00U20210621 date, sort lcolor(red)) /// 140
(line DayDeaMeRaA01S00U20210622 date, sort lcolor(red)) /// 141
(line DayDeaMeRaA01S00U20210623 date, sort lcolor(red)) /// 142
(line DayDeaMeRaA01S00U20210624 date, sort lcolor(red)) /// 143
(line DayDeaMeRaA01S00U20210625 date, sort lcolor(red)) /// 144
(line DayDeaMeRaA01S00U20210626 date, sort lcolor(red)) /// 145
(line DayDeaMeRaA01S00U20210627 date, sort lcolor(red)) /// 146
(line DayDeaMeRaA01S00U20210628 date, sort lcolor(red)) /// 147
(line DayDeaMeRaA01S00U20210629 date, sort lcolor(red)) /// 148
(line DayDeaMeRaA01S00U20210630 date, sort lcolor(red)) /// 149
(line DayDeaMeRaA01S00U20210701 date, sort lcolor(red)) /// 150
(line DayDeaMeRaA01S00U20210702 date, sort lcolor(red)) /// 151
(line DayDeaMeRaA01S00U20210703 date, sort lcolor(red)) /// 152
(line DayDeaMeRaA01S00U20210704 date, sort lcolor(red)) /// 153
(line DayDeaMeRaA01S00U20210705 date, sort lcolor(red)) /// 154
(line DayDeaMeRaA01S00U20210706 date, sort lcolor(red)) /// 155
(line DayDeaMeRaA01S00U20210707 date, sort lcolor(red)) /// 156
(line DayDeaMeRaA01S00U20210708 date, sort lcolor(red)) /// 157
(line DayDeaMeRaA01S00U20210709 date, sort lcolor(red)) /// 158
(line DayDeaMeRaA01S00U20210710 date, sort lcolor(red)) /// 159
(line DayDeaMeRaA01S00U20210711 date, sort lcolor(red)) /// 160
(line DayDeaMeRaA01S00U20210712 date, sort lcolor(red)) /// 161
(line DayDeaMeRaA01S00U20210713 date, sort lcolor(red)) /// 162
(line DayDeaMeRaA01S00U20210714 date, sort lcolor(red)) /// 163
(line DayDeaMeRaA01S00U20210715 date, sort lcolor(red)) /// 164
(line DayDeaMeRaA01S00U20210716 date, sort lcolor(red)) /// 165
(line DayDeaMeRaA01S00U20210717 date, sort lcolor(red)) /// 166
(line DayDeaMeRaA01S00U20210718 date, sort lcolor(red)) /// 167
(line DayDeaMeRaA01S00U20210719 date, sort lcolor(red)) /// 168
(line DayDeaMeSmA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 169
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(10 "DELP v2" 11 "DELP v4" 169 "JOHN smooth") size(small) rows(1)) yscale(titlegap(2))
  	   
qui graph save "graph 11a COVID-19 daily deaths, $country, DELP.gph", replace
qui graph export "graph 11a COVID-19 daily deaths, $country, DELP.pdf", replace



*********

* daily deaths, Absolute value, together, without extremes 151


/*

DayDeaMeRaA01S00U extremes: 

* Max reported daily deaths has been less than 500 (November 2020), therefore, 
* set bar for extreme as more than 2 times 500, i.e.,  > 1,000.

20210128
20210204
20210211
20210218
20210225
20210226
20210227
20210228
20210301
20210523
20210524
20210525
20210526
20210527
20210528
20210529
*/

twoway  ///
(line DayDeaMeRaA01S00U20200723 date, sort lcolor(red) lpattern(dash)) /// 1
(line DayDeaMeRaA01S00U20200919 date, sort lcolor(red) lpattern(dash)) /// 2
(line DayDeaMeRaA01S00U20200926 date, sort lcolor(red) lpattern(dash)) /// 3
(line DayDeaMeRaA01S00U20201001 date, sort lcolor(red) lpattern(dash)) /// 4
(line DayDeaMeRaA01S00U20201008 date, sort lcolor(red) lpattern(dash)) /// 5
(line DayDeaMeRaA01S00U20201015 date, sort lcolor(red) lpattern(dash)) /// 6
(line DayDeaMeRaA01S00U20201022 date, sort lcolor(red) lpattern(dash)) /// 7
(line DayDeaMeRaA01S00U20201029 date, sort lcolor(red) lpattern(dash)) /// 8
(line DayDeaMeRaA01S00U20201105 date, sort lcolor(red) lpattern(dash)) /// 9
(line DayDeaMeRaA01S00U20201112 date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line DayDeaMeRaA01S00U20201119 date, sort lcolor(red)) /// 11 v4
(line DayDeaMeRaA01S00U20201126 date, sort lcolor(red)) /// 12
(line DayDeaMeRaA01S00U20201203 date, sort lcolor(red)) /// 13
(line DayDeaMeRaA01S00U20201210 date, sort lcolor(red)) /// 14
(line DayDeaMeRaA01S00U20201217 date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20201224 date, sort lcolor(red)) /// 16
(line DayDeaMeRaA01S00U20201231 date, sort lcolor(red)) /// 17
(line DayDeaMeRaA01S00U20210107 date, sort lcolor(red)) /// 18
(line DayDeaMeRaA01S00U20210114 date, sort lcolor(red)) /// 19
(line DayDeaMeRaA01S00U20210121 date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210303 date, sort lcolor(red)) /// 21
(line DayDeaMeRaA01S00U20210304 date, sort lcolor(red)) /// 22
(line DayDeaMeRaA01S00U20210305 date, sort lcolor(red)) /// 23
(line DayDeaMeRaA01S00U20210306 date, sort lcolor(red)) /// 24
(line DayDeaMeRaA01S00U20210307 date, sort lcolor(red)) /// 25
(line DayDeaMeRaA01S00U20210308 date, sort lcolor(red)) /// 26
(line DayDeaMeRaA01S00U20210309 date, sort lcolor(red)) /// 27
(line DayDeaMeRaA01S00U20210310 date, sort lcolor(red)) /// 28
(line DayDeaMeRaA01S00U20210311 date, sort lcolor(red)) /// 29
(line DayDeaMeRaA01S00U20210312 date, sort lcolor(red)) /// 30
(line DayDeaMeRaA01S00U20210313 date, sort lcolor(red)) /// 31
(line DayDeaMeRaA01S00U20210314 date, sort lcolor(red)) /// 32
(line DayDeaMeRaA01S00U20210315 date, sort lcolor(red)) /// 33
(line DayDeaMeRaA01S00U20210316 date, sort lcolor(red)) /// 34
(line DayDeaMeRaA01S00U20210317 date, sort lcolor(red)) /// 35
(line DayDeaMeRaA01S00U20210318 date, sort lcolor(red)) /// 36
(line DayDeaMeRaA01S00U20210319 date, sort lcolor(red)) /// 37
(line DayDeaMeRaA01S00U20210320 date, sort lcolor(red)) /// 38
(line DayDeaMeRaA01S00U20210321 date, sort lcolor(red)) /// 39
(line DayDeaMeRaA01S00U20210322 date, sort lcolor(red)) /// 40
(line DayDeaMeRaA01S00U20210323 date, sort lcolor(red)) /// 41
(line DayDeaMeRaA01S00U20210324 date, sort lcolor(red)) /// 42
(line DayDeaMeRaA01S00U20210325 date, sort lcolor(red)) /// 43
(line DayDeaMeRaA01S00U20210326 date, sort lcolor(red)) /// 44
(line DayDeaMeRaA01S00U20210327 date, sort lcolor(red)) /// 45
(line DayDeaMeRaA01S00U20210328 date, sort lcolor(red)) /// 46
(line DayDeaMeRaA01S00U20210329 date, sort lcolor(red)) /// 47
(line DayDeaMeRaA01S00U20210330 date, sort lcolor(red)) /// 48
(line DayDeaMeRaA01S00U20210331 date, sort lcolor(red)) /// 49
(line DayDeaMeRaA01S00U20210401 date, sort lcolor(red)) /// 50
(line DayDeaMeRaA01S00U20210402 date, sort lcolor(red)) /// 51
(line DayDeaMeRaA01S00U20210403 date, sort lcolor(red)) /// 52
(line DayDeaMeRaA01S00U20210404 date, sort lcolor(red)) /// 53
(line DayDeaMeRaA01S00U20210405 date, sort lcolor(red)) /// 54
(line DayDeaMeRaA01S00U20210406 date, sort lcolor(red)) /// 55
(line DayDeaMeRaA01S00U20210407 date, sort lcolor(red)) /// 56
(line DayDeaMeRaA01S00U20210408 date, sort lcolor(red)) /// 57
(line DayDeaMeRaA01S00U20210409 date, sort lcolor(red)) /// 58
(line DayDeaMeRaA01S00U20210410 date, sort lcolor(red)) /// 59
(line DayDeaMeRaA01S00U20210411 date, sort lcolor(red)) /// 60
(line DayDeaMeRaA01S00U20210412 date, sort lcolor(red)) /// 61
(line DayDeaMeRaA01S00U20210413 date, sort lcolor(red)) /// 62
(line DayDeaMeRaA01S00U20210414 date, sort lcolor(red)) /// 63
(line DayDeaMeRaA01S00U20210415 date, sort lcolor(red)) /// 64
(line DayDeaMeRaA01S00U20210416 date, sort lcolor(red)) /// 65
(line DayDeaMeRaA01S00U20210417 date, sort lcolor(red)) /// 66
(line DayDeaMeRaA01S00U20210418 date, sort lcolor(red)) /// 67
(line DayDeaMeRaA01S00U20210419 date, sort lcolor(red)) /// 68
(line DayDeaMeRaA01S00U20210420 date, sort lcolor(red)) /// 69
(line DayDeaMeRaA01S00U20210421 date, sort lcolor(red)) /// 70
(line DayDeaMeRaA01S00U20210422 date, sort lcolor(red)) /// 71
(line DayDeaMeRaA01S00U20210423 date, sort lcolor(red)) /// 72
(line DayDeaMeRaA01S00U20210424 date, sort lcolor(red)) /// 73
(line DayDeaMeRaA01S00U20210425 date, sort lcolor(red)) /// 74
(line DayDeaMeRaA01S00U20210426 date, sort lcolor(red)) /// 75
(line DayDeaMeRaA01S00U20210427 date, sort lcolor(red)) /// 76
(line DayDeaMeRaA01S00U20210428 date, sort lcolor(red)) /// 77
(line DayDeaMeRaA01S00U20210429 date, sort lcolor(red)) /// 78
(line DayDeaMeRaA01S00U20210430 date, sort lcolor(red)) /// 79
(line DayDeaMeRaA01S00U20210501 date, sort lcolor(red)) /// 80
(line DayDeaMeRaA01S00U20210502 date, sort lcolor(red)) /// 81
(line DayDeaMeRaA01S00U20210503 date, sort lcolor(red)) /// 82
(line DayDeaMeRaA01S00U20210504 date, sort lcolor(red)) /// 83
(line DayDeaMeRaA01S00U20210505 date, sort lcolor(red)) /// 84
(line DayDeaMeRaA01S00U20210506 date, sort lcolor(red)) /// 85
(line DayDeaMeRaA01S00U20210507 date, sort lcolor(red)) /// 86
(line DayDeaMeRaA01S00U20210508 date, sort lcolor(red)) /// 87
(line DayDeaMeRaA01S00U20210509 date, sort lcolor(red)) /// 88
(line DayDeaMeRaA01S00U20210510 date, sort lcolor(red)) /// 89
(line DayDeaMeRaA01S00U20210511 date, sort lcolor(red)) /// 90
(line DayDeaMeRaA01S00U20210512 date, sort lcolor(red)) /// 91
(line DayDeaMeRaA01S00U20210513 date, sort lcolor(red)) /// 92
(line DayDeaMeRaA01S00U20210514 date, sort lcolor(red)) /// 93
(line DayDeaMeRaA01S00U20210515 date, sort lcolor(red)) /// 94
(line DayDeaMeRaA01S00U20210516 date, sort lcolor(red)) /// 95
(line DayDeaMeRaA01S00U20210517 date, sort lcolor(red)) /// 96
(line DayDeaMeRaA01S00U20210518 date, sort lcolor(red)) /// 97
(line DayDeaMeRaA01S00U20210519 date, sort lcolor(red)) /// 98
(line DayDeaMeRaA01S00U20210520 date, sort lcolor(red)) /// 99
(line DayDeaMeRaA01S00U20210521 date, sort lcolor(red)) /// 100
(line DayDeaMeRaA01S00U20210522 date, sort lcolor(red)) /// 101
(line DayDeaMeRaA01S00U20210530 date, sort lcolor(red)) /// 102
(line DayDeaMeRaA01S00U20210531 date, sort lcolor(red)) /// 103
(line DayDeaMeRaA01S00U20210601 date, sort lcolor(red)) /// 104
(line DayDeaMeRaA01S00U20210602 date, sort lcolor(red)) /// 105
(line DayDeaMeRaA01S00U20210603 date, sort lcolor(red)) /// 106
(line DayDeaMeRaA01S00U20210604 date, sort lcolor(red)) /// 107
(line DayDeaMeRaA01S00U20210605 date, sort lcolor(red)) /// 108
(line DayDeaMeRaA01S00U20210606 date, sort lcolor(red)) /// 109
(line DayDeaMeRaA01S00U20210607 date, sort lcolor(red)) /// 110
(line DayDeaMeRaA01S00U20210608 date, sort lcolor(red)) /// 111
(line DayDeaMeRaA01S00U20210609 date, sort lcolor(red)) /// 112
(line DayDeaMeRaA01S00U20210610 date, sort lcolor(red)) /// 113
(line DayDeaMeRaA01S00U20210611 date, sort lcolor(red)) /// 114
(line DayDeaMeRaA01S00U20210612 date, sort lcolor(red)) /// 115
(line DayDeaMeRaA01S00U20210613 date, sort lcolor(red)) /// 116
(line DayDeaMeRaA01S00U20210614 date, sort lcolor(red)) /// 117
(line DayDeaMeRaA01S00U20210615 date, sort lcolor(red)) /// 118
(line DayDeaMeRaA01S00U20210616 date, sort lcolor(red)) /// 119
(line DayDeaMeRaA01S00U20210617 date, sort lcolor(red)) /// 120
(line DayDeaMeRaA01S00U20210618 date, sort lcolor(red)) /// 121
(line DayDeaMeRaA01S00U20210619 date, sort lcolor(red)) /// 122
(line DayDeaMeRaA01S00U20210620 date, sort lcolor(red)) /// 123
(line DayDeaMeRaA01S00U20210621 date, sort lcolor(red)) /// 124
(line DayDeaMeRaA01S00U20210622 date, sort lcolor(red)) /// 125
(line DayDeaMeRaA01S00U20210623 date, sort lcolor(red)) /// 126
(line DayDeaMeRaA01S00U20210624 date, sort lcolor(red)) /// 127
(line DayDeaMeRaA01S00U20210625 date, sort lcolor(red)) /// 128
(line DayDeaMeRaA01S00U20210626 date, sort lcolor(red)) /// 129
(line DayDeaMeRaA01S00U20210627 date, sort lcolor(red)) /// 130
(line DayDeaMeRaA01S00U20210628 date, sort lcolor(red)) /// 131
(line DayDeaMeRaA01S00U20210629 date, sort lcolor(red)) /// 132
(line DayDeaMeRaA01S00U20210630 date, sort lcolor(red)) /// 133
(line DayDeaMeRaA01S00U20210701 date, sort lcolor(red)) /// 134
(line DayDeaMeRaA01S00U20210702 date, sort lcolor(red)) /// 135
(line DayDeaMeRaA01S00U20210703 date, sort lcolor(red)) /// 136
(line DayDeaMeRaA01S00U20210704 date, sort lcolor(red)) /// 137
(line DayDeaMeRaA01S00U20210705 date, sort lcolor(red)) /// 138
(line DayDeaMeRaA01S00U20210706 date, sort lcolor(red)) /// 139
(line DayDeaMeRaA01S00U20210707 date, sort lcolor(red)) /// 140
(line DayDeaMeRaA01S00U20210708 date, sort lcolor(red)) /// 141
(line DayDeaMeRaA01S00U20210709 date, sort lcolor(red)) /// 142
(line DayDeaMeRaA01S00U20210710 date, sort lcolor(red)) /// 143
(line DayDeaMeRaA01S00U20210711 date, sort lcolor(red)) /// 144
(line DayDeaMeRaA01S00U20210712 date, sort lcolor(red)) /// 145
(line DayDeaMeRaA01S00U20210713 date, sort lcolor(red)) /// 146
(line DayDeaMeRaA01S00U20210714 date, sort lcolor(red)) /// 147
(line DayDeaMeRaA01S00U20210715 date, sort lcolor(red)) /// 148
(line DayDeaMeRaA01S00U20210716 date, sort lcolor(red)) /// 149
(line DayDeaMeRaA01S00U20210717 date, sort lcolor(red)) /// 150
(line DayDeaMeRaA01S00U20210718 date, sort lcolor(red)) /// 151
(line DayDeaMeSmA00S00 date, lcolor(cyan*1.2) lwidth(vthick)) /// 152
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; without extremes i.e. > 2 times max reported 1,000", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(10 "DELP v2" 11 "DELP v4" 152 "JOHN smooth") size(small) rows(1)) yscale(titlegap(2))
  	   
qui graph save "graph 11b COVID-19 daily deaths, $country, DELP, wo extremes.gph", replace
qui graph export "graph 11b COVID-19 daily deaths, $country, DELP, wo extremes.pdf", replace


*



*********

* daily deaths, Difference, together, with extremes 168

twoway  ///
(line DayDeaMeRaA01S00U20200723D date, sort lcolor(red) lpattern(dash)) /// 1
(line DayDeaMeRaA01S00U20200919D date, sort lcolor(red) lpattern(dash)) /// 2
(line DayDeaMeRaA01S00U20200926D date, sort lcolor(red) lpattern(dash)) /// 3
(line DayDeaMeRaA01S00U20201001D date, sort lcolor(red) lpattern(dash)) /// 4
(line DayDeaMeRaA01S00U20201008D date, sort lcolor(red) lpattern(dash)) /// 5
(line DayDeaMeRaA01S00U20201015D date, sort lcolor(red) lpattern(dash)) /// 6
(line DayDeaMeRaA01S00U20201022D date, sort lcolor(red) lpattern(dash)) /// 7
(line DayDeaMeRaA01S00U20201029D date, sort lcolor(red) lpattern(dash)) /// 8
(line DayDeaMeRaA01S00U20201105D date, sort lcolor(red) lpattern(dash)) /// 9
(line DayDeaMeRaA01S00U20201112D date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line DayDeaMeRaA01S00U20201119D date, sort lcolor(red)) /// 11 v4
(line DayDeaMeRaA01S00U20201126D date, sort lcolor(red)) /// 12
(line DayDeaMeRaA01S00U20201203D date, sort lcolor(red)) /// 13
(line DayDeaMeRaA01S00U20201210D date, sort lcolor(red)) /// 14
(line DayDeaMeRaA01S00U20201217D date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20201224D date, sort lcolor(red)) /// 16
(line DayDeaMeRaA01S00U20201231D date, sort lcolor(red)) /// 17
(line DayDeaMeRaA01S00U20210107D date, sort lcolor(red)) /// 18
(line DayDeaMeRaA01S00U20210114D date, sort lcolor(red)) /// 19
(line DayDeaMeRaA01S00U20210121D date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210128D date, sort lcolor(red)) /// 21
(line DayDeaMeRaA01S00U20210204D date, sort lcolor(red)) /// 22
(line DayDeaMeRaA01S00U20210211D date, sort lcolor(red)) /// 23
(line DayDeaMeRaA01S00U20210218D date, sort lcolor(red)) /// 24
(line DayDeaMeRaA01S00U20210225D date, sort lcolor(red)) /// 25
(line DayDeaMeRaA01S00U20210226D date, sort lcolor(red)) /// 26
(line DayDeaMeRaA01S00U20210227D date, sort lcolor(red)) /// 27
(line DayDeaMeRaA01S00U20210228D date, sort lcolor(red)) /// 28
(line DayDeaMeRaA01S00U20210301D date, sort lcolor(red)) /// 29
(line DayDeaMeRaA01S00U20210303D date, sort lcolor(red)) /// 30
(line DayDeaMeRaA01S00U20210304D date, sort lcolor(red)) /// 31
(line DayDeaMeRaA01S00U20210305D date, sort lcolor(red)) /// 32
(line DayDeaMeRaA01S00U20210306D date, sort lcolor(red)) /// 33
(line DayDeaMeRaA01S00U20210307D date, sort lcolor(red)) /// 34
(line DayDeaMeRaA01S00U20210308D date, sort lcolor(red)) /// 35
(line DayDeaMeRaA01S00U20210309D date, sort lcolor(red)) /// 36
(line DayDeaMeRaA01S00U20210310D date, sort lcolor(red)) /// 37
(line DayDeaMeRaA01S00U20210311D date, sort lcolor(red)) /// 38
(line DayDeaMeRaA01S00U20210312D date, sort lcolor(red)) /// 39
(line DayDeaMeRaA01S00U20210313D date, sort lcolor(red)) /// 40
(line DayDeaMeRaA01S00U20210314D date, sort lcolor(red)) /// 41
(line DayDeaMeRaA01S00U20210315D date, sort lcolor(red)) /// 42
(line DayDeaMeRaA01S00U20210316D date, sort lcolor(red)) /// 43
(line DayDeaMeRaA01S00U20210317D date, sort lcolor(red)) /// 44
(line DayDeaMeRaA01S00U20210318D date, sort lcolor(red)) /// 45
(line DayDeaMeRaA01S00U20210319D date, sort lcolor(red)) /// 46
(line DayDeaMeRaA01S00U20210320D date, sort lcolor(red)) /// 47
(line DayDeaMeRaA01S00U20210321D date, sort lcolor(red)) /// 48
(line DayDeaMeRaA01S00U20210322D date, sort lcolor(red)) /// 49
(line DayDeaMeRaA01S00U20210323D date, sort lcolor(red)) /// 50
(line DayDeaMeRaA01S00U20210324D date, sort lcolor(red)) /// 51
(line DayDeaMeRaA01S00U20210325D date, sort lcolor(red)) /// 52
(line DayDeaMeRaA01S00U20210326D date, sort lcolor(red)) /// 53
(line DayDeaMeRaA01S00U20210327D date, sort lcolor(red)) /// 54
(line DayDeaMeRaA01S00U20210328D date, sort lcolor(red)) /// 55
(line DayDeaMeRaA01S00U20210329D date, sort lcolor(red)) /// 56
(line DayDeaMeRaA01S00U20210330D date, sort lcolor(red)) /// 57
(line DayDeaMeRaA01S00U20210331D date, sort lcolor(red)) /// 58
(line DayDeaMeRaA01S00U20210401D date, sort lcolor(red)) /// 59
(line DayDeaMeRaA01S00U20210402D date, sort lcolor(red)) /// 60
(line DayDeaMeRaA01S00U20210403D date, sort lcolor(red)) /// 61
(line DayDeaMeRaA01S00U20210404D date, sort lcolor(red)) /// 62
(line DayDeaMeRaA01S00U20210405D date, sort lcolor(red)) /// 63
(line DayDeaMeRaA01S00U20210406D date, sort lcolor(red)) /// 64
(line DayDeaMeRaA01S00U20210407D date, sort lcolor(red)) /// 65
(line DayDeaMeRaA01S00U20210408D date, sort lcolor(red)) /// 66
(line DayDeaMeRaA01S00U20210409D date, sort lcolor(red)) /// 67
(line DayDeaMeRaA01S00U20210410D date, sort lcolor(red)) /// 68
(line DayDeaMeRaA01S00U20210411D date, sort lcolor(red)) /// 69
(line DayDeaMeRaA01S00U20210412D date, sort lcolor(red)) /// 70
(line DayDeaMeRaA01S00U20210413D date, sort lcolor(red)) /// 71
(line DayDeaMeRaA01S00U20210414D date, sort lcolor(red)) /// 72
(line DayDeaMeRaA01S00U20210415D date, sort lcolor(red)) /// 73
(line DayDeaMeRaA01S00U20210416D date, sort lcolor(red)) /// 74
(line DayDeaMeRaA01S00U20210417D date, sort lcolor(red)) /// 75
(line DayDeaMeRaA01S00U20210418D date, sort lcolor(red)) /// 76
(line DayDeaMeRaA01S00U20210419D date, sort lcolor(red)) /// 77
(line DayDeaMeRaA01S00U20210420D date, sort lcolor(red)) /// 78
(line DayDeaMeRaA01S00U20210421D date, sort lcolor(red)) /// 79
(line DayDeaMeRaA01S00U20210422D date, sort lcolor(red)) /// 80
(line DayDeaMeRaA01S00U20210423D date, sort lcolor(red)) /// 81
(line DayDeaMeRaA01S00U20210424D date, sort lcolor(red)) /// 82
(line DayDeaMeRaA01S00U20210425D date, sort lcolor(red)) /// 83
(line DayDeaMeRaA01S00U20210426D date, sort lcolor(red)) /// 84
(line DayDeaMeRaA01S00U20210427D date, sort lcolor(red)) /// 85
(line DayDeaMeRaA01S00U20210428D date, sort lcolor(red)) /// 86
(line DayDeaMeRaA01S00U20210429D date, sort lcolor(red)) /// 87
(line DayDeaMeRaA01S00U20210430D date, sort lcolor(red)) /// 88
(line DayDeaMeRaA01S00U20210501D date, sort lcolor(red)) /// 89
(line DayDeaMeRaA01S00U20210502D date, sort lcolor(red)) /// 90
(line DayDeaMeRaA01S00U20210503D date, sort lcolor(red)) /// 91
(line DayDeaMeRaA01S00U20210504D date, sort lcolor(red)) /// 92
(line DayDeaMeRaA01S00U20210505D date, sort lcolor(red)) /// 93
(line DayDeaMeRaA01S00U20210506D date, sort lcolor(red)) /// 94
(line DayDeaMeRaA01S00U20210507D date, sort lcolor(red)) /// 95
(line DayDeaMeRaA01S00U20210508D date, sort lcolor(red)) /// 96
(line DayDeaMeRaA01S00U20210509D date, sort lcolor(red)) /// 97
(line DayDeaMeRaA01S00U20210510D date, sort lcolor(red)) /// 98
(line DayDeaMeRaA01S00U20210511D date, sort lcolor(red)) /// 99
(line DayDeaMeRaA01S00U20210512D date, sort lcolor(red)) /// 100
(line DayDeaMeRaA01S00U20210513D date, sort lcolor(red)) /// 101
(line DayDeaMeRaA01S00U20210514D date, sort lcolor(red)) /// 102
(line DayDeaMeRaA01S00U20210515D date, sort lcolor(red)) /// 103
(line DayDeaMeRaA01S00U20210516D date, sort lcolor(red)) /// 104
(line DayDeaMeRaA01S00U20210517D date, sort lcolor(red)) /// 105
(line DayDeaMeRaA01S00U20210518D date, sort lcolor(red)) /// 106
(line DayDeaMeRaA01S00U20210519D date, sort lcolor(red)) /// 107
(line DayDeaMeRaA01S00U20210520D date, sort lcolor(red)) /// 108
(line DayDeaMeRaA01S00U20210521D date, sort lcolor(red)) /// 109
(line DayDeaMeRaA01S00U20210522D date, sort lcolor(red)) /// 110
(line DayDeaMeRaA01S00U20210523D date, sort lcolor(red)) /// 111
(line DayDeaMeRaA01S00U20210524D date, sort lcolor(red)) /// 112
(line DayDeaMeRaA01S00U20210525D date, sort lcolor(red)) /// 113
(line DayDeaMeRaA01S00U20210526D date, sort lcolor(red)) /// 114
(line DayDeaMeRaA01S00U20210527D date, sort lcolor(red)) /// 115
(line DayDeaMeRaA01S00U20210528D date, sort lcolor(red)) /// 116
(line DayDeaMeRaA01S00U20210529D date, sort lcolor(red)) /// 117
(line DayDeaMeRaA01S00U20210530D date, sort lcolor(red)) /// 118
(line DayDeaMeRaA01S00U20210531D date, sort lcolor(red)) /// 119
(line DayDeaMeRaA01S00U20210601D date, sort lcolor(red)) /// 120
(line DayDeaMeRaA01S00U20210602D date, sort lcolor(red)) /// 121
(line DayDeaMeRaA01S00U20210603D date, sort lcolor(red)) /// 122
(line DayDeaMeRaA01S00U20210604D date, sort lcolor(red)) /// 123
(line DayDeaMeRaA01S00U20210605D date, sort lcolor(red)) /// 124
(line DayDeaMeRaA01S00U20210606D date, sort lcolor(red)) /// 125
(line DayDeaMeRaA01S00U20210607D date, sort lcolor(red)) /// 126
(line DayDeaMeRaA01S00U20210608D date, sort lcolor(red)) /// 127
(line DayDeaMeRaA01S00U20210609D date, sort lcolor(red)) /// 128
(line DayDeaMeRaA01S00U20210610D date, sort lcolor(red)) /// 129
(line DayDeaMeRaA01S00U20210611D date, sort lcolor(red)) /// 130
(line DayDeaMeRaA01S00U20210612D date, sort lcolor(red)) /// 131
(line DayDeaMeRaA01S00U20210613D date, sort lcolor(red)) /// 132
(line DayDeaMeRaA01S00U20210614D date, sort lcolor(red)) /// 133
(line DayDeaMeRaA01S00U20210615D date, sort lcolor(red)) /// 134
(line DayDeaMeRaA01S00U20210616D date, sort lcolor(red)) /// 135
(line DayDeaMeRaA01S00U20210617D date, sort lcolor(red)) /// 136
(line DayDeaMeRaA01S00U20210618D date, sort lcolor(red)) /// 137
(line DayDeaMeRaA01S00U20210619D date, sort lcolor(red)) /// 138
(line DayDeaMeRaA01S00U20210620D date, sort lcolor(red)) /// 139
(line DayDeaMeRaA01S00U20210621D date, sort lcolor(red)) /// 140
(line DayDeaMeRaA01S00U20210622D date, sort lcolor(red)) /// 141
(line DayDeaMeRaA01S00U20210623D date, sort lcolor(red)) /// 142
(line DayDeaMeRaA01S00U20210624D date, sort lcolor(red)) /// 143
(line DayDeaMeRaA01S00U20210625D date, sort lcolor(red)) /// 144
(line DayDeaMeRaA01S00U20210626D date, sort lcolor(red)) /// 145
(line DayDeaMeRaA01S00U20210627D date, sort lcolor(red)) /// 146
(line DayDeaMeRaA01S00U20210628D date, sort lcolor(red)) /// 147
(line DayDeaMeRaA01S00U20210629D date, sort lcolor(red)) /// 148
(line DayDeaMeRaA01S00U20210630D date, sort lcolor(red)) /// 149
(line DayDeaMeRaA01S00U20210701D date, sort lcolor(red)) /// 150
(line DayDeaMeRaA01S00U20210702D date, sort lcolor(red)) /// 151
(line DayDeaMeRaA01S00U20210703D date, sort lcolor(red)) /// 152
(line DayDeaMeRaA01S00U20210704D date, sort lcolor(red)) /// 153
(line DayDeaMeRaA01S00U20210705D date, sort lcolor(red)) /// 154
(line DayDeaMeRaA01S00U20210706D date, sort lcolor(red)) /// 155
(line DayDeaMeRaA01S00U20210707D date, sort lcolor(red)) /// 156
(line DayDeaMeRaA01S00U20210708D date, sort lcolor(red)) /// 157
(line DayDeaMeRaA01S00U20210709D date, sort lcolor(red)) /// 158
(line DayDeaMeRaA01S00U20210710D date, sort lcolor(red)) /// 159
(line DayDeaMeRaA01S00U20210711D date, sort lcolor(red)) /// 160
(line DayDeaMeRaA01S00U20210712D date, sort lcolor(red)) /// 161
(line DayDeaMeRaA01S00U20210713D date, sort lcolor(red)) /// 162
(line DayDeaMeRaA01S00U20210714D date, sort lcolor(red)) /// 163
(line DayDeaMeRaA01S00U20210715D date, sort lcolor(red)) /// 164
(line DayDeaMeRaA01S00U20210716D date, sort lcolor(red)) /// 165
(line DayDeaMeRaA01S00U20210717D date, sort lcolor(red)) /// 166
(line DayDeaMeRaA01S00U20210718D date, sort lcolor(red)) /// 167
(line DayDeaMeRaA01S00U20210719D date, sort lcolor(red)) /// 168
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths DELP minus JOHN smooth) title("COVID-19 daily deaths, $country, DELP minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) yscale(titlegap(2))
  	   
qui graph save "graph 12a COVID-19 daily deaths, $country, DELP, Difference.gph", replace
qui graph export "graph 12a COVID-19 daily deaths, $country, DELP, Difference.pdf", replace





*********

* daily deaths, Difference, together, without extremes 151

twoway  ///
(line DayDeaMeRaA01S00U20200723D date, sort lcolor(red) lpattern(dash)) /// 1
(line DayDeaMeRaA01S00U20200919D date, sort lcolor(red) lpattern(dash)) /// 2
(line DayDeaMeRaA01S00U20200926D date, sort lcolor(red) lpattern(dash)) /// 3
(line DayDeaMeRaA01S00U20201001D date, sort lcolor(red) lpattern(dash)) /// 4
(line DayDeaMeRaA01S00U20201008D date, sort lcolor(red) lpattern(dash)) /// 5
(line DayDeaMeRaA01S00U20201015D date, sort lcolor(red) lpattern(dash)) /// 6
(line DayDeaMeRaA01S00U20201022D date, sort lcolor(red) lpattern(dash)) /// 7
(line DayDeaMeRaA01S00U20201029D date, sort lcolor(red) lpattern(dash)) /// 8
(line DayDeaMeRaA01S00U20201105D date, sort lcolor(red) lpattern(dash)) /// 9
(line DayDeaMeRaA01S00U20201112D date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line DayDeaMeRaA01S00U20201119D date, sort lcolor(red)) /// 11 v4
(line DayDeaMeRaA01S00U20201126D date, sort lcolor(red)) /// 12
(line DayDeaMeRaA01S00U20201203D date, sort lcolor(red)) /// 13
(line DayDeaMeRaA01S00U20201210D date, sort lcolor(red)) /// 14
(line DayDeaMeRaA01S00U20201217D date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20201224D date, sort lcolor(red)) /// 16
(line DayDeaMeRaA01S00U20201231D date, sort lcolor(red)) /// 17
(line DayDeaMeRaA01S00U20210107D date, sort lcolor(red)) /// 18
(line DayDeaMeRaA01S00U20210114D date, sort lcolor(red)) /// 19
(line DayDeaMeRaA01S00U20210121D date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210303D date, sort lcolor(red)) /// 21
(line DayDeaMeRaA01S00U20210304D date, sort lcolor(red)) /// 22
(line DayDeaMeRaA01S00U20210305D date, sort lcolor(red)) /// 23
(line DayDeaMeRaA01S00U20210306D date, sort lcolor(red)) /// 24
(line DayDeaMeRaA01S00U20210307D date, sort lcolor(red)) /// 25
(line DayDeaMeRaA01S00U20210308D date, sort lcolor(red)) /// 26
(line DayDeaMeRaA01S00U20210309D date, sort lcolor(red)) /// 27
(line DayDeaMeRaA01S00U20210310D date, sort lcolor(red)) /// 28
(line DayDeaMeRaA01S00U20210311D date, sort lcolor(red)) /// 29
(line DayDeaMeRaA01S00U20210312D date, sort lcolor(red)) /// 30
(line DayDeaMeRaA01S00U20210313D date, sort lcolor(red)) /// 31
(line DayDeaMeRaA01S00U20210314D date, sort lcolor(red)) /// 32
(line DayDeaMeRaA01S00U20210315D date, sort lcolor(red)) /// 33
(line DayDeaMeRaA01S00U20210316D date, sort lcolor(red)) /// 34
(line DayDeaMeRaA01S00U20210317D date, sort lcolor(red)) /// 35
(line DayDeaMeRaA01S00U20210318D date, sort lcolor(red)) /// 36
(line DayDeaMeRaA01S00U20210319D date, sort lcolor(red)) /// 37
(line DayDeaMeRaA01S00U20210320D date, sort lcolor(red)) /// 38
(line DayDeaMeRaA01S00U20210321D date, sort lcolor(red)) /// 39
(line DayDeaMeRaA01S00U20210322D date, sort lcolor(red)) /// 40
(line DayDeaMeRaA01S00U20210323D date, sort lcolor(red)) /// 41
(line DayDeaMeRaA01S00U20210324D date, sort lcolor(red)) /// 42
(line DayDeaMeRaA01S00U20210325D date, sort lcolor(red)) /// 43
(line DayDeaMeRaA01S00U20210326D date, sort lcolor(red)) /// 44
(line DayDeaMeRaA01S00U20210327D date, sort lcolor(red)) /// 45
(line DayDeaMeRaA01S00U20210328D date, sort lcolor(red)) /// 46
(line DayDeaMeRaA01S00U20210329D date, sort lcolor(red)) /// 47
(line DayDeaMeRaA01S00U20210330D date, sort lcolor(red)) /// 48
(line DayDeaMeRaA01S00U20210331D date, sort lcolor(red)) /// 49
(line DayDeaMeRaA01S00U20210401D date, sort lcolor(red)) /// 50
(line DayDeaMeRaA01S00U20210402D date, sort lcolor(red)) /// 51
(line DayDeaMeRaA01S00U20210403D date, sort lcolor(red)) /// 52
(line DayDeaMeRaA01S00U20210404D date, sort lcolor(red)) /// 53
(line DayDeaMeRaA01S00U20210405D date, sort lcolor(red)) /// 54
(line DayDeaMeRaA01S00U20210406D date, sort lcolor(red)) /// 55
(line DayDeaMeRaA01S00U20210407D date, sort lcolor(red)) /// 56
(line DayDeaMeRaA01S00U20210408D date, sort lcolor(red)) /// 57
(line DayDeaMeRaA01S00U20210409D date, sort lcolor(red)) /// 58
(line DayDeaMeRaA01S00U20210410D date, sort lcolor(red)) /// 59
(line DayDeaMeRaA01S00U20210411D date, sort lcolor(red)) /// 60
(line DayDeaMeRaA01S00U20210412D date, sort lcolor(red)) /// 61
(line DayDeaMeRaA01S00U20210413D date, sort lcolor(red)) /// 62
(line DayDeaMeRaA01S00U20210414D date, sort lcolor(red)) /// 63
(line DayDeaMeRaA01S00U20210415D date, sort lcolor(red)) /// 64
(line DayDeaMeRaA01S00U20210416D date, sort lcolor(red)) /// 65
(line DayDeaMeRaA01S00U20210417D date, sort lcolor(red)) /// 66
(line DayDeaMeRaA01S00U20210418D date, sort lcolor(red)) /// 67
(line DayDeaMeRaA01S00U20210419D date, sort lcolor(red)) /// 68
(line DayDeaMeRaA01S00U20210420D date, sort lcolor(red)) /// 69
(line DayDeaMeRaA01S00U20210421D date, sort lcolor(red)) /// 70
(line DayDeaMeRaA01S00U20210422D date, sort lcolor(red)) /// 71
(line DayDeaMeRaA01S00U20210423D date, sort lcolor(red)) /// 72
(line DayDeaMeRaA01S00U20210424D date, sort lcolor(red)) /// 73
(line DayDeaMeRaA01S00U20210425D date, sort lcolor(red)) /// 74
(line DayDeaMeRaA01S00U20210426D date, sort lcolor(red)) /// 75
(line DayDeaMeRaA01S00U20210427D date, sort lcolor(red)) /// 76
(line DayDeaMeRaA01S00U20210428D date, sort lcolor(red)) /// 77
(line DayDeaMeRaA01S00U20210429D date, sort lcolor(red)) /// 78
(line DayDeaMeRaA01S00U20210430D date, sort lcolor(red)) /// 79
(line DayDeaMeRaA01S00U20210501D date, sort lcolor(red)) /// 80
(line DayDeaMeRaA01S00U20210502D date, sort lcolor(red)) /// 81
(line DayDeaMeRaA01S00U20210503D date, sort lcolor(red)) /// 82
(line DayDeaMeRaA01S00U20210504D date, sort lcolor(red)) /// 83
(line DayDeaMeRaA01S00U20210505D date, sort lcolor(red)) /// 84
(line DayDeaMeRaA01S00U20210506D date, sort lcolor(red)) /// 85
(line DayDeaMeRaA01S00U20210507D date, sort lcolor(red)) /// 86
(line DayDeaMeRaA01S00U20210508D date, sort lcolor(red)) /// 87
(line DayDeaMeRaA01S00U20210509D date, sort lcolor(red)) /// 88
(line DayDeaMeRaA01S00U20210510D date, sort lcolor(red)) /// 89
(line DayDeaMeRaA01S00U20210511D date, sort lcolor(red)) /// 90
(line DayDeaMeRaA01S00U20210512D date, sort lcolor(red)) /// 91
(line DayDeaMeRaA01S00U20210513D date, sort lcolor(red)) /// 92
(line DayDeaMeRaA01S00U20210514D date, sort lcolor(red)) /// 93
(line DayDeaMeRaA01S00U20210515D date, sort lcolor(red)) /// 94
(line DayDeaMeRaA01S00U20210516D date, sort lcolor(red)) /// 95
(line DayDeaMeRaA01S00U20210517D date, sort lcolor(red)) /// 96
(line DayDeaMeRaA01S00U20210518D date, sort lcolor(red)) /// 97
(line DayDeaMeRaA01S00U20210519D date, sort lcolor(red)) /// 98
(line DayDeaMeRaA01S00U20210520D date, sort lcolor(red)) /// 99
(line DayDeaMeRaA01S00U20210521D date, sort lcolor(red)) /// 100
(line DayDeaMeRaA01S00U20210522D date, sort lcolor(red)) /// 101
(line DayDeaMeRaA01S00U20210530D date, sort lcolor(red)) /// 102
(line DayDeaMeRaA01S00U20210531D date, sort lcolor(red)) /// 103
(line DayDeaMeRaA01S00U20210601D date, sort lcolor(red)) /// 104
(line DayDeaMeRaA01S00U20210602D date, sort lcolor(red)) /// 105
(line DayDeaMeRaA01S00U20210603D date, sort lcolor(red)) /// 106
(line DayDeaMeRaA01S00U20210604D date, sort lcolor(red)) /// 107
(line DayDeaMeRaA01S00U20210605D date, sort lcolor(red)) /// 108
(line DayDeaMeRaA01S00U20210606D date, sort lcolor(red)) /// 109
(line DayDeaMeRaA01S00U20210607D date, sort lcolor(red)) /// 110
(line DayDeaMeRaA01S00U20210608D date, sort lcolor(red)) /// 111
(line DayDeaMeRaA01S00U20210609D date, sort lcolor(red)) /// 112
(line DayDeaMeRaA01S00U20210610D date, sort lcolor(red)) /// 113
(line DayDeaMeRaA01S00U20210611D date, sort lcolor(red)) /// 114
(line DayDeaMeRaA01S00U20210612D date, sort lcolor(red)) /// 115
(line DayDeaMeRaA01S00U20210613D date, sort lcolor(red)) /// 116
(line DayDeaMeRaA01S00U20210614D date, sort lcolor(red)) /// 117
(line DayDeaMeRaA01S00U20210615D date, sort lcolor(red)) /// 118
(line DayDeaMeRaA01S00U20210616D date, sort lcolor(red)) /// 119
(line DayDeaMeRaA01S00U20210617D date, sort lcolor(red)) /// 120
(line DayDeaMeRaA01S00U20210618D date, sort lcolor(red)) /// 121
(line DayDeaMeRaA01S00U20210619D date, sort lcolor(red)) /// 122
(line DayDeaMeRaA01S00U20210620D date, sort lcolor(red)) /// 123
(line DayDeaMeRaA01S00U20210621D date, sort lcolor(red)) /// 124
(line DayDeaMeRaA01S00U20210622D date, sort lcolor(red)) /// 125
(line DayDeaMeRaA01S00U20210623D date, sort lcolor(red)) /// 126
(line DayDeaMeRaA01S00U20210624D date, sort lcolor(red)) /// 127
(line DayDeaMeRaA01S00U20210625D date, sort lcolor(red)) /// 128
(line DayDeaMeRaA01S00U20210626D date, sort lcolor(red)) /// 129
(line DayDeaMeRaA01S00U20210627D date, sort lcolor(red)) /// 130
(line DayDeaMeRaA01S00U20210628D date, sort lcolor(red)) /// 131
(line DayDeaMeRaA01S00U20210629D date, sort lcolor(red)) /// 132
(line DayDeaMeRaA01S00U20210630D date, sort lcolor(red)) /// 133
(line DayDeaMeRaA01S00U20210701D date, sort lcolor(red)) /// 134
(line DayDeaMeRaA01S00U20210702D date, sort lcolor(red)) /// 135
(line DayDeaMeRaA01S00U20210703D date, sort lcolor(red)) /// 136
(line DayDeaMeRaA01S00U20210704D date, sort lcolor(red)) /// 137
(line DayDeaMeRaA01S00U20210705D date, sort lcolor(red)) /// 138
(line DayDeaMeRaA01S00U20210706D date, sort lcolor(red)) /// 139
(line DayDeaMeRaA01S00U20210707D date, sort lcolor(red)) /// 140
(line DayDeaMeRaA01S00U20210708D date, sort lcolor(red)) /// 141
(line DayDeaMeRaA01S00U20210709D date, sort lcolor(red)) /// 142
(line DayDeaMeRaA01S00U20210710D date, sort lcolor(red)) /// 143
(line DayDeaMeRaA01S00U20210711D date, sort lcolor(red)) /// 144
(line DayDeaMeRaA01S00U20210712D date, sort lcolor(red)) /// 145
(line DayDeaMeRaA01S00U20210713D date, sort lcolor(red)) /// 146
(line DayDeaMeRaA01S00U20210714D date, sort lcolor(red)) /// 147
(line DayDeaMeRaA01S00U20210715D date, sort lcolor(red)) /// 148
(line DayDeaMeRaA01S00U20210716D date, sort lcolor(red)) /// 149
(line DayDeaMeRaA01S00U20210717D date, sort lcolor(red)) /// 150
(line DayDeaMeRaA01S00U20210718D date, sort lcolor(red)) /// 151
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths DELP minus JOHN smooth) title("COVID-19 daily deaths, $country, DELP minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
subtitle("all updates 20200723 to 20210715; single scenario; without extremes i.e., >1000 daily deaths", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) yscale(titlegap(2))
  	   
qui graph save "graph 12b COVID-19 daily deaths, $country, DELP, wo extreme, Difference.gph", replace
qui graph export "graph 12b COVID-19 daily deaths, $country, DELP, wo extreme, Difference.pdf", replace




*


*********

* daily deaths, Times, together, with extremes 168

twoway  ///
(line DayDeaMeRaA01S00U20200723T date, sort lcolor(red) lpattern(dash)) /// 1
(line DayDeaMeRaA01S00U20200919T date, sort lcolor(red) lpattern(dash)) /// 2
(line DayDeaMeRaA01S00U20200926T date, sort lcolor(red) lpattern(dash)) /// 3
(line DayDeaMeRaA01S00U20201001T date, sort lcolor(red) lpattern(dash)) /// 4
(line DayDeaMeRaA01S00U20201008T date, sort lcolor(red) lpattern(dash)) /// 5
(line DayDeaMeRaA01S00U20201015T date, sort lcolor(red) lpattern(dash)) /// 6
(line DayDeaMeRaA01S00U20201022T date, sort lcolor(red) lpattern(dash)) /// 7
(line DayDeaMeRaA01S00U20201029T date, sort lcolor(red) lpattern(dash)) /// 8
(line DayDeaMeRaA01S00U20201105T date, sort lcolor(red) lpattern(dash)) /// 9
(line DayDeaMeRaA01S00U20201112T date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line DayDeaMeRaA01S00U20201119T date, sort lcolor(red)) /// 11 v4
(line DayDeaMeRaA01S00U20201126T date, sort lcolor(red)) /// 12
(line DayDeaMeRaA01S00U20201203T date, sort lcolor(red)) /// 13
(line DayDeaMeRaA01S00U20201210T date, sort lcolor(red)) /// 14
(line DayDeaMeRaA01S00U20201217T date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20201224T date, sort lcolor(red)) /// 16
(line DayDeaMeRaA01S00U20201231T date, sort lcolor(red)) /// 17
(line DayDeaMeRaA01S00U20210107T date, sort lcolor(red)) /// 18
(line DayDeaMeRaA01S00U20210114T date, sort lcolor(red)) /// 19
(line DayDeaMeRaA01S00U20210121T date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210128T date, sort lcolor(red)) /// 21
(line DayDeaMeRaA01S00U20210204T date, sort lcolor(red)) /// 22
(line DayDeaMeRaA01S00U20210211T date, sort lcolor(red)) /// 23
(line DayDeaMeRaA01S00U20210218T date, sort lcolor(red)) /// 24
(line DayDeaMeRaA01S00U20210225T date, sort lcolor(red)) /// 25
(line DayDeaMeRaA01S00U20210226T date, sort lcolor(red)) /// 26
(line DayDeaMeRaA01S00U20210227T date, sort lcolor(red)) /// 27
(line DayDeaMeRaA01S00U20210228T date, sort lcolor(red)) /// 28
(line DayDeaMeRaA01S00U20210301T date, sort lcolor(red)) /// 29
(line DayDeaMeRaA01S00U20210303T date, sort lcolor(red)) /// 30
(line DayDeaMeRaA01S00U20210304T date, sort lcolor(red)) /// 31
(line DayDeaMeRaA01S00U20210305T date, sort lcolor(red)) /// 32
(line DayDeaMeRaA01S00U20210306T date, sort lcolor(red)) /// 33
(line DayDeaMeRaA01S00U20210307T date, sort lcolor(red)) /// 34
(line DayDeaMeRaA01S00U20210308T date, sort lcolor(red)) /// 35
(line DayDeaMeRaA01S00U20210309T date, sort lcolor(red)) /// 36
(line DayDeaMeRaA01S00U20210310T date, sort lcolor(red)) /// 37
(line DayDeaMeRaA01S00U20210311T date, sort lcolor(red)) /// 38
(line DayDeaMeRaA01S00U20210312T date, sort lcolor(red)) /// 39
(line DayDeaMeRaA01S00U20210313T date, sort lcolor(red)) /// 40
(line DayDeaMeRaA01S00U20210314T date, sort lcolor(red)) /// 41
(line DayDeaMeRaA01S00U20210315T date, sort lcolor(red)) /// 42
(line DayDeaMeRaA01S00U20210316T date, sort lcolor(red)) /// 43
(line DayDeaMeRaA01S00U20210317T date, sort lcolor(red)) /// 44
(line DayDeaMeRaA01S00U20210318T date, sort lcolor(red)) /// 45
(line DayDeaMeRaA01S00U20210319T date, sort lcolor(red)) /// 46
(line DayDeaMeRaA01S00U20210320T date, sort lcolor(red)) /// 47
(line DayDeaMeRaA01S00U20210321T date, sort lcolor(red)) /// 48
(line DayDeaMeRaA01S00U20210322T date, sort lcolor(red)) /// 49
(line DayDeaMeRaA01S00U20210323T date, sort lcolor(red)) /// 50
(line DayDeaMeRaA01S00U20210324T date, sort lcolor(red)) /// 51
(line DayDeaMeRaA01S00U20210325T date, sort lcolor(red)) /// 52
(line DayDeaMeRaA01S00U20210326T date, sort lcolor(red)) /// 53
(line DayDeaMeRaA01S00U20210327T date, sort lcolor(red)) /// 54
(line DayDeaMeRaA01S00U20210328T date, sort lcolor(red)) /// 55
(line DayDeaMeRaA01S00U20210329T date, sort lcolor(red)) /// 56
(line DayDeaMeRaA01S00U20210330T date, sort lcolor(red)) /// 57
(line DayDeaMeRaA01S00U20210331T date, sort lcolor(red)) /// 58
(line DayDeaMeRaA01S00U20210401T date, sort lcolor(red)) /// 59
(line DayDeaMeRaA01S00U20210402T date, sort lcolor(red)) /// 60
(line DayDeaMeRaA01S00U20210403T date, sort lcolor(red)) /// 61
(line DayDeaMeRaA01S00U20210404T date, sort lcolor(red)) /// 62
(line DayDeaMeRaA01S00U20210405T date, sort lcolor(red)) /// 63
(line DayDeaMeRaA01S00U20210406T date, sort lcolor(red)) /// 64
(line DayDeaMeRaA01S00U20210407T date, sort lcolor(red)) /// 65
(line DayDeaMeRaA01S00U20210408T date, sort lcolor(red)) /// 66
(line DayDeaMeRaA01S00U20210409T date, sort lcolor(red)) /// 67
(line DayDeaMeRaA01S00U20210410T date, sort lcolor(red)) /// 68
(line DayDeaMeRaA01S00U20210411T date, sort lcolor(red)) /// 69
(line DayDeaMeRaA01S00U20210412T date, sort lcolor(red)) /// 70
(line DayDeaMeRaA01S00U20210413T date, sort lcolor(red)) /// 71
(line DayDeaMeRaA01S00U20210414T date, sort lcolor(red)) /// 72
(line DayDeaMeRaA01S00U20210415T date, sort lcolor(red)) /// 73
(line DayDeaMeRaA01S00U20210416T date, sort lcolor(red)) /// 74
(line DayDeaMeRaA01S00U20210417T date, sort lcolor(red)) /// 75
(line DayDeaMeRaA01S00U20210418T date, sort lcolor(red)) /// 76
(line DayDeaMeRaA01S00U20210419T date, sort lcolor(red)) /// 77
(line DayDeaMeRaA01S00U20210420T date, sort lcolor(red)) /// 78
(line DayDeaMeRaA01S00U20210421T date, sort lcolor(red)) /// 79
(line DayDeaMeRaA01S00U20210422T date, sort lcolor(red)) /// 80
(line DayDeaMeRaA01S00U20210423T date, sort lcolor(red)) /// 81
(line DayDeaMeRaA01S00U20210424T date, sort lcolor(red)) /// 82
(line DayDeaMeRaA01S00U20210425T date, sort lcolor(red)) /// 83
(line DayDeaMeRaA01S00U20210426T date, sort lcolor(red)) /// 84
(line DayDeaMeRaA01S00U20210427T date, sort lcolor(red)) /// 85
(line DayDeaMeRaA01S00U20210428T date, sort lcolor(red)) /// 86
(line DayDeaMeRaA01S00U20210429T date, sort lcolor(red)) /// 87
(line DayDeaMeRaA01S00U20210430T date, sort lcolor(red)) /// 88
(line DayDeaMeRaA01S00U20210501T date, sort lcolor(red)) /// 89
(line DayDeaMeRaA01S00U20210502T date, sort lcolor(red)) /// 90
(line DayDeaMeRaA01S00U20210503T date, sort lcolor(red)) /// 91
(line DayDeaMeRaA01S00U20210504T date, sort lcolor(red)) /// 92
(line DayDeaMeRaA01S00U20210505T date, sort lcolor(red)) /// 93
(line DayDeaMeRaA01S00U20210506T date, sort lcolor(red)) /// 94
(line DayDeaMeRaA01S00U20210507T date, sort lcolor(red)) /// 95
(line DayDeaMeRaA01S00U20210508T date, sort lcolor(red)) /// 96
(line DayDeaMeRaA01S00U20210509T date, sort lcolor(red)) /// 97
(line DayDeaMeRaA01S00U20210510T date, sort lcolor(red)) /// 98
(line DayDeaMeRaA01S00U20210511T date, sort lcolor(red)) /// 99
(line DayDeaMeRaA01S00U20210512T date, sort lcolor(red)) /// 100
(line DayDeaMeRaA01S00U20210513T date, sort lcolor(red)) /// 101
(line DayDeaMeRaA01S00U20210514T date, sort lcolor(red)) /// 102
(line DayDeaMeRaA01S00U20210515T date, sort lcolor(red)) /// 103
(line DayDeaMeRaA01S00U20210516T date, sort lcolor(red)) /// 104
(line DayDeaMeRaA01S00U20210517T date, sort lcolor(red)) /// 105
(line DayDeaMeRaA01S00U20210518T date, sort lcolor(red)) /// 106
(line DayDeaMeRaA01S00U20210519T date, sort lcolor(red)) /// 107
(line DayDeaMeRaA01S00U20210520T date, sort lcolor(red)) /// 108
(line DayDeaMeRaA01S00U20210521T date, sort lcolor(red)) /// 109
(line DayDeaMeRaA01S00U20210522T date, sort lcolor(red)) /// 110
(line DayDeaMeRaA01S00U20210523T date, sort lcolor(red)) /// 111
(line DayDeaMeRaA01S00U20210524T date, sort lcolor(red)) /// 112
(line DayDeaMeRaA01S00U20210525T date, sort lcolor(red)) /// 113
(line DayDeaMeRaA01S00U20210526T date, sort lcolor(red)) /// 114
(line DayDeaMeRaA01S00U20210527T date, sort lcolor(red)) /// 115
(line DayDeaMeRaA01S00U20210528T date, sort lcolor(red)) /// 116
(line DayDeaMeRaA01S00U20210529T date, sort lcolor(red)) /// 117
(line DayDeaMeRaA01S00U20210530T date, sort lcolor(red)) /// 118
(line DayDeaMeRaA01S00U20210531T date, sort lcolor(red)) /// 119
(line DayDeaMeRaA01S00U20210601T date, sort lcolor(red)) /// 120
(line DayDeaMeRaA01S00U20210602T date, sort lcolor(red)) /// 121
(line DayDeaMeRaA01S00U20210603T date, sort lcolor(red)) /// 122
(line DayDeaMeRaA01S00U20210604T date, sort lcolor(red)) /// 123
(line DayDeaMeRaA01S00U20210605T date, sort lcolor(red)) /// 124
(line DayDeaMeRaA01S00U20210606T date, sort lcolor(red)) /// 125
(line DayDeaMeRaA01S00U20210607T date, sort lcolor(red)) /// 126
(line DayDeaMeRaA01S00U20210608T date, sort lcolor(red)) /// 127
(line DayDeaMeRaA01S00U20210609T date, sort lcolor(red)) /// 128
(line DayDeaMeRaA01S00U20210610T date, sort lcolor(red)) /// 129
(line DayDeaMeRaA01S00U20210611T date, sort lcolor(red)) /// 130
(line DayDeaMeRaA01S00U20210612T date, sort lcolor(red)) /// 131
(line DayDeaMeRaA01S00U20210613T date, sort lcolor(red)) /// 132
(line DayDeaMeRaA01S00U20210614T date, sort lcolor(red)) /// 133
(line DayDeaMeRaA01S00U20210615T date, sort lcolor(red)) /// 134
(line DayDeaMeRaA01S00U20210616T date, sort lcolor(red)) /// 135
(line DayDeaMeRaA01S00U20210617T date, sort lcolor(red)) /// 136
(line DayDeaMeRaA01S00U20210618T date, sort lcolor(red)) /// 137
(line DayDeaMeRaA01S00U20210619T date, sort lcolor(red)) /// 138
(line DayDeaMeRaA01S00U20210620T date, sort lcolor(red)) /// 139
(line DayDeaMeRaA01S00U20210621T date, sort lcolor(red)) /// 140
(line DayDeaMeRaA01S00U20210622T date, sort lcolor(red)) /// 141
(line DayDeaMeRaA01S00U20210623T date, sort lcolor(red)) /// 142
(line DayDeaMeRaA01S00U20210624T date, sort lcolor(red)) /// 143
(line DayDeaMeRaA01S00U20210625T date, sort lcolor(red)) /// 144
(line DayDeaMeRaA01S00U20210626T date, sort lcolor(red)) /// 145
(line DayDeaMeRaA01S00U20210627T date, sort lcolor(red)) /// 146
(line DayDeaMeRaA01S00U20210628T date, sort lcolor(red)) /// 147
(line DayDeaMeRaA01S00U20210629T date, sort lcolor(red)) /// 148
(line DayDeaMeRaA01S00U20210630T date, sort lcolor(red)) /// 149
(line DayDeaMeRaA01S00U20210701T date, sort lcolor(red)) /// 150
(line DayDeaMeRaA01S00U20210702T date, sort lcolor(red)) /// 151
(line DayDeaMeRaA01S00U20210703T date, sort lcolor(red)) /// 152
(line DayDeaMeRaA01S00U20210704T date, sort lcolor(red)) /// 153
(line DayDeaMeRaA01S00U20210705T date, sort lcolor(red)) /// 154
(line DayDeaMeRaA01S00U20210706T date, sort lcolor(red)) /// 155
(line DayDeaMeRaA01S00U20210707T date, sort lcolor(red)) /// 156
(line DayDeaMeRaA01S00U20210708T date, sort lcolor(red)) /// 157
(line DayDeaMeRaA01S00U20210709T date, sort lcolor(red)) /// 158
(line DayDeaMeRaA01S00U20210710T date, sort lcolor(red)) /// 159
(line DayDeaMeRaA01S00U20210711T date, sort lcolor(red)) /// 160
(line DayDeaMeRaA01S00U20210712T date, sort lcolor(red)) /// 161
(line DayDeaMeRaA01S00U20210713T date, sort lcolor(red)) /// 162
(line DayDeaMeRaA01S00U20210714T date, sort lcolor(red)) /// 163
(line DayDeaMeRaA01S00U20210715T date, sort lcolor(red)) /// 164
(line DayDeaMeRaA01S00U20210716T date, sort lcolor(red)) /// 165
(line DayDeaMeRaA01S00U20210717T date, sort lcolor(red)) /// 166
(line DayDeaMeRaA01S00U20210718T date, sort lcolor(red)) /// 167
(line DayDeaMeRaA01S00U20210719T date, sort lcolor(red)) /// 168
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths DELP divided by JOHN smooth) title("COVID-19 daily deaths, $country, DELP divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))	
  	   
qui graph save "graph 13a COVID-19 daily deaths, $country, DELP, Times.gph", replace
qui graph export "graph 13a COVID-19 daily deaths, $country, DELP, Times.pdf", replace





*********

* daily deaths, Times, together, without extremes 151

twoway  ///
(line DayDeaMeRaA01S00U20200723T date, sort lcolor(red) lpattern(dash)) /// 1
(line DayDeaMeRaA01S00U20200919T date, sort lcolor(red) lpattern(dash)) /// 2
(line DayDeaMeRaA01S00U20200926T date, sort lcolor(red) lpattern(dash)) /// 3
(line DayDeaMeRaA01S00U20201001T date, sort lcolor(red) lpattern(dash)) /// 4
(line DayDeaMeRaA01S00U20201008T date, sort lcolor(red) lpattern(dash)) /// 5
(line DayDeaMeRaA01S00U20201015T date, sort lcolor(red) lpattern(dash)) /// 6
(line DayDeaMeRaA01S00U20201022T date, sort lcolor(red) lpattern(dash)) /// 7
(line DayDeaMeRaA01S00U20201029T date, sort lcolor(red) lpattern(dash)) /// 8
(line DayDeaMeRaA01S00U20201105T date, sort lcolor(red) lpattern(dash)) /// 9
(line DayDeaMeRaA01S00U20201112T date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line DayDeaMeRaA01S00U20201119T date, sort lcolor(red)) /// 11 v4
(line DayDeaMeRaA01S00U20201126T date, sort lcolor(red)) /// 12
(line DayDeaMeRaA01S00U20201203T date, sort lcolor(red)) /// 13
(line DayDeaMeRaA01S00U20201210T date, sort lcolor(red)) /// 14
(line DayDeaMeRaA01S00U20201217T date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20201224T date, sort lcolor(red)) /// 16
(line DayDeaMeRaA01S00U20201231T date, sort lcolor(red)) /// 17
(line DayDeaMeRaA01S00U20210107T date, sort lcolor(red)) /// 18
(line DayDeaMeRaA01S00U20210114T date, sort lcolor(red)) /// 19
(line DayDeaMeRaA01S00U20210121T date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210303T date, sort lcolor(red)) /// 21
(line DayDeaMeRaA01S00U20210304T date, sort lcolor(red)) /// 22
(line DayDeaMeRaA01S00U20210305T date, sort lcolor(red)) /// 23
(line DayDeaMeRaA01S00U20210306T date, sort lcolor(red)) /// 24
(line DayDeaMeRaA01S00U20210307T date, sort lcolor(red)) /// 25
(line DayDeaMeRaA01S00U20210308T date, sort lcolor(red)) /// 26
(line DayDeaMeRaA01S00U20210309T date, sort lcolor(red)) /// 27
(line DayDeaMeRaA01S00U20210310T date, sort lcolor(red)) /// 28
(line DayDeaMeRaA01S00U20210311T date, sort lcolor(red)) /// 29
(line DayDeaMeRaA01S00U20210312T date, sort lcolor(red)) /// 30
(line DayDeaMeRaA01S00U20210313T date, sort lcolor(red)) /// 31
(line DayDeaMeRaA01S00U20210314T date, sort lcolor(red)) /// 32
(line DayDeaMeRaA01S00U20210315T date, sort lcolor(red)) /// 33
(line DayDeaMeRaA01S00U20210316T date, sort lcolor(red)) /// 34
(line DayDeaMeRaA01S00U20210317T date, sort lcolor(red)) /// 35
(line DayDeaMeRaA01S00U20210318T date, sort lcolor(red)) /// 36
(line DayDeaMeRaA01S00U20210319T date, sort lcolor(red)) /// 37
(line DayDeaMeRaA01S00U20210320T date, sort lcolor(red)) /// 38
(line DayDeaMeRaA01S00U20210321T date, sort lcolor(red)) /// 39
(line DayDeaMeRaA01S00U20210322T date, sort lcolor(red)) /// 40
(line DayDeaMeRaA01S00U20210323T date, sort lcolor(red)) /// 41
(line DayDeaMeRaA01S00U20210324T date, sort lcolor(red)) /// 42
(line DayDeaMeRaA01S00U20210325T date, sort lcolor(red)) /// 43
(line DayDeaMeRaA01S00U20210326T date, sort lcolor(red)) /// 44
(line DayDeaMeRaA01S00U20210327T date, sort lcolor(red)) /// 45
(line DayDeaMeRaA01S00U20210328T date, sort lcolor(red)) /// 46
(line DayDeaMeRaA01S00U20210329T date, sort lcolor(red)) /// 47
(line DayDeaMeRaA01S00U20210330T date, sort lcolor(red)) /// 48
(line DayDeaMeRaA01S00U20210331T date, sort lcolor(red)) /// 49
(line DayDeaMeRaA01S00U20210401T date, sort lcolor(red)) /// 50
(line DayDeaMeRaA01S00U20210402T date, sort lcolor(red)) /// 51
(line DayDeaMeRaA01S00U20210403T date, sort lcolor(red)) /// 52
(line DayDeaMeRaA01S00U20210404T date, sort lcolor(red)) /// 53
(line DayDeaMeRaA01S00U20210405T date, sort lcolor(red)) /// 54
(line DayDeaMeRaA01S00U20210406T date, sort lcolor(red)) /// 55
(line DayDeaMeRaA01S00U20210407T date, sort lcolor(red)) /// 56
(line DayDeaMeRaA01S00U20210408T date, sort lcolor(red)) /// 57
(line DayDeaMeRaA01S00U20210409T date, sort lcolor(red)) /// 58
(line DayDeaMeRaA01S00U20210410T date, sort lcolor(red)) /// 59
(line DayDeaMeRaA01S00U20210411T date, sort lcolor(red)) /// 60
(line DayDeaMeRaA01S00U20210412T date, sort lcolor(red)) /// 61
(line DayDeaMeRaA01S00U20210413T date, sort lcolor(red)) /// 62
(line DayDeaMeRaA01S00U20210414T date, sort lcolor(red)) /// 63
(line DayDeaMeRaA01S00U20210415T date, sort lcolor(red)) /// 64
(line DayDeaMeRaA01S00U20210416T date, sort lcolor(red)) /// 65
(line DayDeaMeRaA01S00U20210417T date, sort lcolor(red)) /// 66
(line DayDeaMeRaA01S00U20210418T date, sort lcolor(red)) /// 67
(line DayDeaMeRaA01S00U20210419T date, sort lcolor(red)) /// 68
(line DayDeaMeRaA01S00U20210420T date, sort lcolor(red)) /// 69
(line DayDeaMeRaA01S00U20210421T date, sort lcolor(red)) /// 70
(line DayDeaMeRaA01S00U20210422T date, sort lcolor(red)) /// 71
(line DayDeaMeRaA01S00U20210423T date, sort lcolor(red)) /// 72
(line DayDeaMeRaA01S00U20210424T date, sort lcolor(red)) /// 73
(line DayDeaMeRaA01S00U20210425T date, sort lcolor(red)) /// 74
(line DayDeaMeRaA01S00U20210426T date, sort lcolor(red)) /// 75
(line DayDeaMeRaA01S00U20210427T date, sort lcolor(red)) /// 76
(line DayDeaMeRaA01S00U20210428T date, sort lcolor(red)) /// 77
(line DayDeaMeRaA01S00U20210429T date, sort lcolor(red)) /// 78
(line DayDeaMeRaA01S00U20210430T date, sort lcolor(red)) /// 79
(line DayDeaMeRaA01S00U20210501T date, sort lcolor(red)) /// 80
(line DayDeaMeRaA01S00U20210502T date, sort lcolor(red)) /// 81
(line DayDeaMeRaA01S00U20210503T date, sort lcolor(red)) /// 82
(line DayDeaMeRaA01S00U20210504T date, sort lcolor(red)) /// 83
(line DayDeaMeRaA01S00U20210505T date, sort lcolor(red)) /// 84
(line DayDeaMeRaA01S00U20210506T date, sort lcolor(red)) /// 85
(line DayDeaMeRaA01S00U20210507T date, sort lcolor(red)) /// 86
(line DayDeaMeRaA01S00U20210508T date, sort lcolor(red)) /// 87
(line DayDeaMeRaA01S00U20210509T date, sort lcolor(red)) /// 88
(line DayDeaMeRaA01S00U20210510T date, sort lcolor(red)) /// 89
(line DayDeaMeRaA01S00U20210511T date, sort lcolor(red)) /// 90
(line DayDeaMeRaA01S00U20210512T date, sort lcolor(red)) /// 91
(line DayDeaMeRaA01S00U20210513T date, sort lcolor(red)) /// 92
(line DayDeaMeRaA01S00U20210514T date, sort lcolor(red)) /// 93
(line DayDeaMeRaA01S00U20210515T date, sort lcolor(red)) /// 94
(line DayDeaMeRaA01S00U20210516T date, sort lcolor(red)) /// 95
(line DayDeaMeRaA01S00U20210517T date, sort lcolor(red)) /// 96
(line DayDeaMeRaA01S00U20210518T date, sort lcolor(red)) /// 97
(line DayDeaMeRaA01S00U20210519T date, sort lcolor(red)) /// 98
(line DayDeaMeRaA01S00U20210520T date, sort lcolor(red)) /// 99
(line DayDeaMeRaA01S00U20210521T date, sort lcolor(red)) /// 100
(line DayDeaMeRaA01S00U20210522T date, sort lcolor(red)) /// 101
(line DayDeaMeRaA01S00U20210530T date, sort lcolor(red)) /// 102
(line DayDeaMeRaA01S00U20210531T date, sort lcolor(red)) /// 103
(line DayDeaMeRaA01S00U20210601T date, sort lcolor(red)) /// 104
(line DayDeaMeRaA01S00U20210602T date, sort lcolor(red)) /// 105
(line DayDeaMeRaA01S00U20210603T date, sort lcolor(red)) /// 106
(line DayDeaMeRaA01S00U20210604T date, sort lcolor(red)) /// 107
(line DayDeaMeRaA01S00U20210605T date, sort lcolor(red)) /// 108
(line DayDeaMeRaA01S00U20210606T date, sort lcolor(red)) /// 109
(line DayDeaMeRaA01S00U20210607T date, sort lcolor(red)) /// 110
(line DayDeaMeRaA01S00U20210608T date, sort lcolor(red)) /// 111
(line DayDeaMeRaA01S00U20210609T date, sort lcolor(red)) /// 112
(line DayDeaMeRaA01S00U20210610T date, sort lcolor(red)) /// 113
(line DayDeaMeRaA01S00U20210611T date, sort lcolor(red)) /// 114
(line DayDeaMeRaA01S00U20210612T date, sort lcolor(red)) /// 115
(line DayDeaMeRaA01S00U20210613T date, sort lcolor(red)) /// 116
(line DayDeaMeRaA01S00U20210614T date, sort lcolor(red)) /// 117
(line DayDeaMeRaA01S00U20210615T date, sort lcolor(red)) /// 118
(line DayDeaMeRaA01S00U20210616T date, sort lcolor(red)) /// 119
(line DayDeaMeRaA01S00U20210617T date, sort lcolor(red)) /// 120
(line DayDeaMeRaA01S00U20210618T date, sort lcolor(red)) /// 121
(line DayDeaMeRaA01S00U20210619T date, sort lcolor(red)) /// 122
(line DayDeaMeRaA01S00U20210620T date, sort lcolor(red)) /// 123
(line DayDeaMeRaA01S00U20210621T date, sort lcolor(red)) /// 124
(line DayDeaMeRaA01S00U20210622T date, sort lcolor(red)) /// 125
(line DayDeaMeRaA01S00U20210623T date, sort lcolor(red)) /// 126
(line DayDeaMeRaA01S00U20210624T date, sort lcolor(red)) /// 127
(line DayDeaMeRaA01S00U20210625T date, sort lcolor(red)) /// 128
(line DayDeaMeRaA01S00U20210626T date, sort lcolor(red)) /// 129
(line DayDeaMeRaA01S00U20210627T date, sort lcolor(red)) /// 130
(line DayDeaMeRaA01S00U20210628T date, sort lcolor(red)) /// 131
(line DayDeaMeRaA01S00U20210629T date, sort lcolor(red)) /// 132
(line DayDeaMeRaA01S00U20210630T date, sort lcolor(red)) /// 133
(line DayDeaMeRaA01S00U20210701T date, sort lcolor(red)) /// 134
(line DayDeaMeRaA01S00U20210702T date, sort lcolor(red)) /// 135
(line DayDeaMeRaA01S00U20210703T date, sort lcolor(red)) /// 136
(line DayDeaMeRaA01S00U20210704T date, sort lcolor(red)) /// 137
(line DayDeaMeRaA01S00U20210705T date, sort lcolor(red)) /// 138
(line DayDeaMeRaA01S00U20210706T date, sort lcolor(red)) /// 139
(line DayDeaMeRaA01S00U20210707T date, sort lcolor(red)) /// 140
(line DayDeaMeRaA01S00U20210708T date, sort lcolor(red)) /// 141
(line DayDeaMeRaA01S00U20210709T date, sort lcolor(red)) /// 142
(line DayDeaMeRaA01S00U20210710T date, sort lcolor(red)) /// 143
(line DayDeaMeRaA01S00U20210711T date, sort lcolor(red)) /// 144
(line DayDeaMeRaA01S00U20210712T date, sort lcolor(red)) /// 145
(line DayDeaMeRaA01S00U20210713T date, sort lcolor(red)) /// 146
(line DayDeaMeRaA01S00U20210714T date, sort lcolor(red)) /// 147
(line DayDeaMeRaA01S00U20210715T date, sort lcolor(red)) /// 148
(line DayDeaMeRaA01S00U20210716T date, sort lcolor(red)) /// 149
(line DayDeaMeRaA01S00U20210717T date, sort lcolor(red)) /// 150
(line DayDeaMeRaA01S00U20210718T date, sort lcolor(red)) /// 151
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths DELP divided by JOHN smooth) title("COVID-19 daily deaths, $country, DELP divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; without extremes i.e. > 2 times max reported 1,000", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))

qui graph save "graph 13b COVID-19 daily deaths, $country, DELP, wo extreme, Times.gph", replace
qui graph export "graph 13b COVID-19 daily deaths, $country, DELP, wo extreme, Times.pdf", replace




*


*********

* daily deaths, Percent, together, with extremes 168

twoway  ///
(line DayDeaMeRaA01S00U20200723P date, sort lcolor(red) lpattern(dash)) /// 1
(line DayDeaMeRaA01S00U20200919P date, sort lcolor(red) lpattern(dash)) /// 2
(line DayDeaMeRaA01S00U20200926P date, sort lcolor(red) lpattern(dash)) /// 3
(line DayDeaMeRaA01S00U20201001P date, sort lcolor(red) lpattern(dash)) /// 4
(line DayDeaMeRaA01S00U20201008P date, sort lcolor(red) lpattern(dash)) /// 5
(line DayDeaMeRaA01S00U20201015P date, sort lcolor(red) lpattern(dash)) /// 6
(line DayDeaMeRaA01S00U20201022P date, sort lcolor(red) lpattern(dash)) /// 7
(line DayDeaMeRaA01S00U20201029P date, sort lcolor(red) lpattern(dash)) /// 8
(line DayDeaMeRaA01S00U20201105P date, sort lcolor(red) lpattern(dash)) /// 9
(line DayDeaMeRaA01S00U20201112P date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line DayDeaMeRaA01S00U20201119P date, sort lcolor(red)) /// 11 v4
(line DayDeaMeRaA01S00U20201126P date, sort lcolor(red)) /// 12
(line DayDeaMeRaA01S00U20201203P date, sort lcolor(red)) /// 13
(line DayDeaMeRaA01S00U20201210P date, sort lcolor(red)) /// 14
(line DayDeaMeRaA01S00U20201217P date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20201224P date, sort lcolor(red)) /// 16
(line DayDeaMeRaA01S00U20201231P date, sort lcolor(red)) /// 17
(line DayDeaMeRaA01S00U20210107P date, sort lcolor(red)) /// 18
(line DayDeaMeRaA01S00U20210114P date, sort lcolor(red)) /// 19
(line DayDeaMeRaA01S00U20210121P date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210128P date, sort lcolor(red)) /// 21
(line DayDeaMeRaA01S00U20210204P date, sort lcolor(red)) /// 22
(line DayDeaMeRaA01S00U20210211P date, sort lcolor(red)) /// 23
(line DayDeaMeRaA01S00U20210218P date, sort lcolor(red)) /// 24
(line DayDeaMeRaA01S00U20210225P date, sort lcolor(red)) /// 25
(line DayDeaMeRaA01S00U20210226P date, sort lcolor(red)) /// 26
(line DayDeaMeRaA01S00U20210227P date, sort lcolor(red)) /// 27
(line DayDeaMeRaA01S00U20210228P date, sort lcolor(red)) /// 28
(line DayDeaMeRaA01S00U20210301P date, sort lcolor(red)) /// 29
(line DayDeaMeRaA01S00U20210303P date, sort lcolor(red)) /// 30
(line DayDeaMeRaA01S00U20210304P date, sort lcolor(red)) /// 31
(line DayDeaMeRaA01S00U20210305P date, sort lcolor(red)) /// 32
(line DayDeaMeRaA01S00U20210306P date, sort lcolor(red)) /// 33
(line DayDeaMeRaA01S00U20210307P date, sort lcolor(red)) /// 34
(line DayDeaMeRaA01S00U20210308P date, sort lcolor(red)) /// 35
(line DayDeaMeRaA01S00U20210309P date, sort lcolor(red)) /// 36
(line DayDeaMeRaA01S00U20210310P date, sort lcolor(red)) /// 37
(line DayDeaMeRaA01S00U20210311P date, sort lcolor(red)) /// 38
(line DayDeaMeRaA01S00U20210312P date, sort lcolor(red)) /// 39
(line DayDeaMeRaA01S00U20210313P date, sort lcolor(red)) /// 40
(line DayDeaMeRaA01S00U20210314P date, sort lcolor(red)) /// 41
(line DayDeaMeRaA01S00U20210315P date, sort lcolor(red)) /// 42
(line DayDeaMeRaA01S00U20210316P date, sort lcolor(red)) /// 43
(line DayDeaMeRaA01S00U20210317P date, sort lcolor(red)) /// 44
(line DayDeaMeRaA01S00U20210318P date, sort lcolor(red)) /// 45
(line DayDeaMeRaA01S00U20210319P date, sort lcolor(red)) /// 46
(line DayDeaMeRaA01S00U20210320P date, sort lcolor(red)) /// 47
(line DayDeaMeRaA01S00U20210321P date, sort lcolor(red)) /// 48
(line DayDeaMeRaA01S00U20210322P date, sort lcolor(red)) /// 49
(line DayDeaMeRaA01S00U20210323P date, sort lcolor(red)) /// 50
(line DayDeaMeRaA01S00U20210324P date, sort lcolor(red)) /// 51
(line DayDeaMeRaA01S00U20210325P date, sort lcolor(red)) /// 52
(line DayDeaMeRaA01S00U20210326P date, sort lcolor(red)) /// 53
(line DayDeaMeRaA01S00U20210327P date, sort lcolor(red)) /// 54
(line DayDeaMeRaA01S00U20210328P date, sort lcolor(red)) /// 55
(line DayDeaMeRaA01S00U20210329P date, sort lcolor(red)) /// 56
(line DayDeaMeRaA01S00U20210330P date, sort lcolor(red)) /// 57
(line DayDeaMeRaA01S00U20210331P date, sort lcolor(red)) /// 58
(line DayDeaMeRaA01S00U20210401P date, sort lcolor(red)) /// 59
(line DayDeaMeRaA01S00U20210402P date, sort lcolor(red)) /// 60
(line DayDeaMeRaA01S00U20210403P date, sort lcolor(red)) /// 61
(line DayDeaMeRaA01S00U20210404P date, sort lcolor(red)) /// 62
(line DayDeaMeRaA01S00U20210405P date, sort lcolor(red)) /// 63
(line DayDeaMeRaA01S00U20210406P date, sort lcolor(red)) /// 64
(line DayDeaMeRaA01S00U20210407P date, sort lcolor(red)) /// 65
(line DayDeaMeRaA01S00U20210408P date, sort lcolor(red)) /// 66
(line DayDeaMeRaA01S00U20210409P date, sort lcolor(red)) /// 67
(line DayDeaMeRaA01S00U20210410P date, sort lcolor(red)) /// 68
(line DayDeaMeRaA01S00U20210411P date, sort lcolor(red)) /// 69
(line DayDeaMeRaA01S00U20210412P date, sort lcolor(red)) /// 70
(line DayDeaMeRaA01S00U20210413P date, sort lcolor(red)) /// 71
(line DayDeaMeRaA01S00U20210414P date, sort lcolor(red)) /// 72
(line DayDeaMeRaA01S00U20210415P date, sort lcolor(red)) /// 73
(line DayDeaMeRaA01S00U20210416P date, sort lcolor(red)) /// 74
(line DayDeaMeRaA01S00U20210417P date, sort lcolor(red)) /// 75
(line DayDeaMeRaA01S00U20210418P date, sort lcolor(red)) /// 76
(line DayDeaMeRaA01S00U20210419P date, sort lcolor(red)) /// 77
(line DayDeaMeRaA01S00U20210420P date, sort lcolor(red)) /// 78
(line DayDeaMeRaA01S00U20210421P date, sort lcolor(red)) /// 79
(line DayDeaMeRaA01S00U20210422P date, sort lcolor(red)) /// 80
(line DayDeaMeRaA01S00U20210423P date, sort lcolor(red)) /// 81
(line DayDeaMeRaA01S00U20210424P date, sort lcolor(red)) /// 82
(line DayDeaMeRaA01S00U20210425P date, sort lcolor(red)) /// 83
(line DayDeaMeRaA01S00U20210426P date, sort lcolor(red)) /// 84
(line DayDeaMeRaA01S00U20210427P date, sort lcolor(red)) /// 85
(line DayDeaMeRaA01S00U20210428P date, sort lcolor(red)) /// 86
(line DayDeaMeRaA01S00U20210429P date, sort lcolor(red)) /// 87
(line DayDeaMeRaA01S00U20210430P date, sort lcolor(red)) /// 88
(line DayDeaMeRaA01S00U20210501P date, sort lcolor(red)) /// 89
(line DayDeaMeRaA01S00U20210502P date, sort lcolor(red)) /// 90
(line DayDeaMeRaA01S00U20210503P date, sort lcolor(red)) /// 91
(line DayDeaMeRaA01S00U20210504P date, sort lcolor(red)) /// 92
(line DayDeaMeRaA01S00U20210505P date, sort lcolor(red)) /// 93
(line DayDeaMeRaA01S00U20210506P date, sort lcolor(red)) /// 94
(line DayDeaMeRaA01S00U20210507P date, sort lcolor(red)) /// 95
(line DayDeaMeRaA01S00U20210508P date, sort lcolor(red)) /// 96
(line DayDeaMeRaA01S00U20210509P date, sort lcolor(red)) /// 97
(line DayDeaMeRaA01S00U20210510P date, sort lcolor(red)) /// 98
(line DayDeaMeRaA01S00U20210511P date, sort lcolor(red)) /// 99
(line DayDeaMeRaA01S00U20210512P date, sort lcolor(red)) /// 100
(line DayDeaMeRaA01S00U20210513P date, sort lcolor(red)) /// 101
(line DayDeaMeRaA01S00U20210514P date, sort lcolor(red)) /// 102
(line DayDeaMeRaA01S00U20210515P date, sort lcolor(red)) /// 103
(line DayDeaMeRaA01S00U20210516P date, sort lcolor(red)) /// 104
(line DayDeaMeRaA01S00U20210517P date, sort lcolor(red)) /// 105
(line DayDeaMeRaA01S00U20210518P date, sort lcolor(red)) /// 106
(line DayDeaMeRaA01S00U20210519P date, sort lcolor(red)) /// 107
(line DayDeaMeRaA01S00U20210520P date, sort lcolor(red)) /// 108
(line DayDeaMeRaA01S00U20210521P date, sort lcolor(red)) /// 109
(line DayDeaMeRaA01S00U20210522P date, sort lcolor(red)) /// 110
(line DayDeaMeRaA01S00U20210523P date, sort lcolor(red)) /// 111
(line DayDeaMeRaA01S00U20210524P date, sort lcolor(red)) /// 112
(line DayDeaMeRaA01S00U20210525P date, sort lcolor(red)) /// 113
(line DayDeaMeRaA01S00U20210526P date, sort lcolor(red)) /// 114
(line DayDeaMeRaA01S00U20210527P date, sort lcolor(red)) /// 115
(line DayDeaMeRaA01S00U20210528P date, sort lcolor(red)) /// 116
(line DayDeaMeRaA01S00U20210529P date, sort lcolor(red)) /// 117
(line DayDeaMeRaA01S00U20210530P date, sort lcolor(red)) /// 118
(line DayDeaMeRaA01S00U20210531P date, sort lcolor(red)) /// 119
(line DayDeaMeRaA01S00U20210601P date, sort lcolor(red)) /// 120
(line DayDeaMeRaA01S00U20210602P date, sort lcolor(red)) /// 121
(line DayDeaMeRaA01S00U20210603P date, sort lcolor(red)) /// 122
(line DayDeaMeRaA01S00U20210604P date, sort lcolor(red)) /// 123
(line DayDeaMeRaA01S00U20210605P date, sort lcolor(red)) /// 124
(line DayDeaMeRaA01S00U20210606P date, sort lcolor(red)) /// 125
(line DayDeaMeRaA01S00U20210607P date, sort lcolor(red)) /// 126
(line DayDeaMeRaA01S00U20210608P date, sort lcolor(red)) /// 127
(line DayDeaMeRaA01S00U20210609P date, sort lcolor(red)) /// 128
(line DayDeaMeRaA01S00U20210610P date, sort lcolor(red)) /// 129
(line DayDeaMeRaA01S00U20210611P date, sort lcolor(red)) /// 130
(line DayDeaMeRaA01S00U20210612P date, sort lcolor(red)) /// 131
(line DayDeaMeRaA01S00U20210613P date, sort lcolor(red)) /// 132
(line DayDeaMeRaA01S00U20210614P date, sort lcolor(red)) /// 133
(line DayDeaMeRaA01S00U20210615P date, sort lcolor(red)) /// 134
(line DayDeaMeRaA01S00U20210616P date, sort lcolor(red)) /// 135
(line DayDeaMeRaA01S00U20210617P date, sort lcolor(red)) /// 136
(line DayDeaMeRaA01S00U20210618P date, sort lcolor(red)) /// 137
(line DayDeaMeRaA01S00U20210619P date, sort lcolor(red)) /// 138
(line DayDeaMeRaA01S00U20210620P date, sort lcolor(red)) /// 139
(line DayDeaMeRaA01S00U20210621P date, sort lcolor(red)) /// 140
(line DayDeaMeRaA01S00U20210622P date, sort lcolor(red)) /// 141
(line DayDeaMeRaA01S00U20210623P date, sort lcolor(red)) /// 142
(line DayDeaMeRaA01S00U20210624P date, sort lcolor(red)) /// 143
(line DayDeaMeRaA01S00U20210625P date, sort lcolor(red)) /// 144
(line DayDeaMeRaA01S00U20210626P date, sort lcolor(red)) /// 145
(line DayDeaMeRaA01S00U20210627P date, sort lcolor(red)) /// 146
(line DayDeaMeRaA01S00U20210628P date, sort lcolor(red)) /// 147
(line DayDeaMeRaA01S00U20210629P date, sort lcolor(red)) /// 148
(line DayDeaMeRaA01S00U20210630P date, sort lcolor(red)) /// 149
(line DayDeaMeRaA01S00U20210701P date, sort lcolor(red)) /// 150
(line DayDeaMeRaA01S00U20210702P date, sort lcolor(red)) /// 151
(line DayDeaMeRaA01S00U20210703P date, sort lcolor(red)) /// 152
(line DayDeaMeRaA01S00U20210704P date, sort lcolor(red)) /// 153
(line DayDeaMeRaA01S00U20210705P date, sort lcolor(red)) /// 154
(line DayDeaMeRaA01S00U20210706P date, sort lcolor(red)) /// 155
(line DayDeaMeRaA01S00U20210707P date, sort lcolor(red)) /// 156
(line DayDeaMeRaA01S00U20210708P date, sort lcolor(red)) /// 157
(line DayDeaMeRaA01S00U20210709P date, sort lcolor(red)) /// 158
(line DayDeaMeRaA01S00U20210710P date, sort lcolor(red)) /// 159
(line DayDeaMeRaA01S00U20210711P date, sort lcolor(red)) /// 160
(line DayDeaMeRaA01S00U20210712P date, sort lcolor(red)) /// 161
(line DayDeaMeRaA01S00U20210713P date, sort lcolor(red)) /// 162
(line DayDeaMeRaA01S00U20210714P date, sort lcolor(red)) /// 163
(line DayDeaMeRaA01S00U20210715P date, sort lcolor(red)) /// 164
(line DayDeaMeRaA01S00U20210716P date, sort lcolor(red)) /// 165
(line DayDeaMeRaA01S00U20210717P date, sort lcolor(red)) /// 166
(line DayDeaMeRaA01S00U20210718P date, sort lcolor(red)) /// 167
(line DayDeaMeRaA01S00U20210719P date, sort lcolor(red)) /// 168
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths DELP percent JOHN smooth) title("COVID-19 daily deaths, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 14a COVID-19 daily deaths, $country, DELP, Percent.gph", replace
qui graph export "graph 14a COVID-19 daily deaths, $country, DELP, Percent.pdf", replace





*********

* daily deaths, Percent, together, without extremes 151

twoway  ///
(line DayDeaMeRaA01S00U20200723P date, sort lcolor(red) lpattern(dash)) /// 1
(line DayDeaMeRaA01S00U20200919P date, sort lcolor(red) lpattern(dash)) /// 2
(line DayDeaMeRaA01S00U20200926P date, sort lcolor(red) lpattern(dash)) /// 3
(line DayDeaMeRaA01S00U20201001P date, sort lcolor(red) lpattern(dash)) /// 4
(line DayDeaMeRaA01S00U20201008P date, sort lcolor(red) lpattern(dash)) /// 5
(line DayDeaMeRaA01S00U20201015P date, sort lcolor(red) lpattern(dash)) /// 6
(line DayDeaMeRaA01S00U20201022P date, sort lcolor(red) lpattern(dash)) /// 7
(line DayDeaMeRaA01S00U20201029P date, sort lcolor(red) lpattern(dash)) /// 8
(line DayDeaMeRaA01S00U20201105P date, sort lcolor(red) lpattern(dash)) /// 9
(line DayDeaMeRaA01S00U20201112P date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line DayDeaMeRaA01S00U20201119P date, sort lcolor(red)) /// 11 v4
(line DayDeaMeRaA01S00U20201126P date, sort lcolor(red)) /// 12
(line DayDeaMeRaA01S00U20201203P date, sort lcolor(red)) /// 13
(line DayDeaMeRaA01S00U20201210P date, sort lcolor(red)) /// 14
(line DayDeaMeRaA01S00U20201217P date, sort lcolor(red)) /// 15
(line DayDeaMeRaA01S00U20201224P date, sort lcolor(red)) /// 16
(line DayDeaMeRaA01S00U20201231P date, sort lcolor(red)) /// 17
(line DayDeaMeRaA01S00U20210107P date, sort lcolor(red)) /// 18
(line DayDeaMeRaA01S00U20210114P date, sort lcolor(red)) /// 19
(line DayDeaMeRaA01S00U20210121P date, sort lcolor(red)) /// 20
(line DayDeaMeRaA01S00U20210303P date, sort lcolor(red)) /// 21
(line DayDeaMeRaA01S00U20210304P date, sort lcolor(red)) /// 22
(line DayDeaMeRaA01S00U20210305P date, sort lcolor(red)) /// 23
(line DayDeaMeRaA01S00U20210306P date, sort lcolor(red)) /// 24
(line DayDeaMeRaA01S00U20210307P date, sort lcolor(red)) /// 25
(line DayDeaMeRaA01S00U20210308P date, sort lcolor(red)) /// 26
(line DayDeaMeRaA01S00U20210309P date, sort lcolor(red)) /// 27
(line DayDeaMeRaA01S00U20210310P date, sort lcolor(red)) /// 28
(line DayDeaMeRaA01S00U20210311P date, sort lcolor(red)) /// 29
(line DayDeaMeRaA01S00U20210312P date, sort lcolor(red)) /// 30
(line DayDeaMeRaA01S00U20210313P date, sort lcolor(red)) /// 31
(line DayDeaMeRaA01S00U20210314P date, sort lcolor(red)) /// 32
(line DayDeaMeRaA01S00U20210315P date, sort lcolor(red)) /// 33
(line DayDeaMeRaA01S00U20210316P date, sort lcolor(red)) /// 34
(line DayDeaMeRaA01S00U20210317P date, sort lcolor(red)) /// 35
(line DayDeaMeRaA01S00U20210318P date, sort lcolor(red)) /// 36
(line DayDeaMeRaA01S00U20210319P date, sort lcolor(red)) /// 37
(line DayDeaMeRaA01S00U20210320P date, sort lcolor(red)) /// 38
(line DayDeaMeRaA01S00U20210321P date, sort lcolor(red)) /// 39
(line DayDeaMeRaA01S00U20210322P date, sort lcolor(red)) /// 40
(line DayDeaMeRaA01S00U20210323P date, sort lcolor(red)) /// 41
(line DayDeaMeRaA01S00U20210324P date, sort lcolor(red)) /// 42
(line DayDeaMeRaA01S00U20210325P date, sort lcolor(red)) /// 43
(line DayDeaMeRaA01S00U20210326P date, sort lcolor(red)) /// 44
(line DayDeaMeRaA01S00U20210327P date, sort lcolor(red)) /// 45
(line DayDeaMeRaA01S00U20210328P date, sort lcolor(red)) /// 46
(line DayDeaMeRaA01S00U20210329P date, sort lcolor(red)) /// 47
(line DayDeaMeRaA01S00U20210330P date, sort lcolor(red)) /// 48
(line DayDeaMeRaA01S00U20210331P date, sort lcolor(red)) /// 49
(line DayDeaMeRaA01S00U20210401P date, sort lcolor(red)) /// 50
(line DayDeaMeRaA01S00U20210402P date, sort lcolor(red)) /// 51
(line DayDeaMeRaA01S00U20210403P date, sort lcolor(red)) /// 52
(line DayDeaMeRaA01S00U20210404P date, sort lcolor(red)) /// 53
(line DayDeaMeRaA01S00U20210405P date, sort lcolor(red)) /// 54
(line DayDeaMeRaA01S00U20210406P date, sort lcolor(red)) /// 55
(line DayDeaMeRaA01S00U20210407P date, sort lcolor(red)) /// 56
(line DayDeaMeRaA01S00U20210408P date, sort lcolor(red)) /// 57
(line DayDeaMeRaA01S00U20210409P date, sort lcolor(red)) /// 58
(line DayDeaMeRaA01S00U20210410P date, sort lcolor(red)) /// 59
(line DayDeaMeRaA01S00U20210411P date, sort lcolor(red)) /// 60
(line DayDeaMeRaA01S00U20210412P date, sort lcolor(red)) /// 61
(line DayDeaMeRaA01S00U20210413P date, sort lcolor(red)) /// 62
(line DayDeaMeRaA01S00U20210414P date, sort lcolor(red)) /// 63
(line DayDeaMeRaA01S00U20210415P date, sort lcolor(red)) /// 64
(line DayDeaMeRaA01S00U20210416P date, sort lcolor(red)) /// 65
(line DayDeaMeRaA01S00U20210417P date, sort lcolor(red)) /// 66
(line DayDeaMeRaA01S00U20210418P date, sort lcolor(red)) /// 67
(line DayDeaMeRaA01S00U20210419P date, sort lcolor(red)) /// 68
(line DayDeaMeRaA01S00U20210420P date, sort lcolor(red)) /// 69
(line DayDeaMeRaA01S00U20210421P date, sort lcolor(red)) /// 70
(line DayDeaMeRaA01S00U20210422P date, sort lcolor(red)) /// 71
(line DayDeaMeRaA01S00U20210423P date, sort lcolor(red)) /// 72
(line DayDeaMeRaA01S00U20210424P date, sort lcolor(red)) /// 73
(line DayDeaMeRaA01S00U20210425P date, sort lcolor(red)) /// 74
(line DayDeaMeRaA01S00U20210426P date, sort lcolor(red)) /// 75
(line DayDeaMeRaA01S00U20210427P date, sort lcolor(red)) /// 76
(line DayDeaMeRaA01S00U20210428P date, sort lcolor(red)) /// 77
(line DayDeaMeRaA01S00U20210429P date, sort lcolor(red)) /// 78
(line DayDeaMeRaA01S00U20210430P date, sort lcolor(red)) /// 79
(line DayDeaMeRaA01S00U20210501P date, sort lcolor(red)) /// 80
(line DayDeaMeRaA01S00U20210502P date, sort lcolor(red)) /// 81
(line DayDeaMeRaA01S00U20210503P date, sort lcolor(red)) /// 82
(line DayDeaMeRaA01S00U20210504P date, sort lcolor(red)) /// 83
(line DayDeaMeRaA01S00U20210505P date, sort lcolor(red)) /// 84
(line DayDeaMeRaA01S00U20210506P date, sort lcolor(red)) /// 85
(line DayDeaMeRaA01S00U20210507P date, sort lcolor(red)) /// 86
(line DayDeaMeRaA01S00U20210508P date, sort lcolor(red)) /// 87
(line DayDeaMeRaA01S00U20210509P date, sort lcolor(red)) /// 88
(line DayDeaMeRaA01S00U20210510P date, sort lcolor(red)) /// 89
(line DayDeaMeRaA01S00U20210511P date, sort lcolor(red)) /// 90
(line DayDeaMeRaA01S00U20210512P date, sort lcolor(red)) /// 91
(line DayDeaMeRaA01S00U20210513P date, sort lcolor(red)) /// 92
(line DayDeaMeRaA01S00U20210514P date, sort lcolor(red)) /// 93
(line DayDeaMeRaA01S00U20210515P date, sort lcolor(red)) /// 94
(line DayDeaMeRaA01S00U20210516P date, sort lcolor(red)) /// 95
(line DayDeaMeRaA01S00U20210517P date, sort lcolor(red)) /// 96
(line DayDeaMeRaA01S00U20210518P date, sort lcolor(red)) /// 97
(line DayDeaMeRaA01S00U20210519P date, sort lcolor(red)) /// 98
(line DayDeaMeRaA01S00U20210520P date, sort lcolor(red)) /// 99
(line DayDeaMeRaA01S00U20210521P date, sort lcolor(red)) /// 100
(line DayDeaMeRaA01S00U20210522P date, sort lcolor(red)) /// 101
(line DayDeaMeRaA01S00U20210530P date, sort lcolor(red)) /// 102
(line DayDeaMeRaA01S00U20210531P date, sort lcolor(red)) /// 103
(line DayDeaMeRaA01S00U20210601P date, sort lcolor(red)) /// 104
(line DayDeaMeRaA01S00U20210602P date, sort lcolor(red)) /// 105
(line DayDeaMeRaA01S00U20210603P date, sort lcolor(red)) /// 106
(line DayDeaMeRaA01S00U20210604P date, sort lcolor(red)) /// 107
(line DayDeaMeRaA01S00U20210605P date, sort lcolor(red)) /// 108
(line DayDeaMeRaA01S00U20210606P date, sort lcolor(red)) /// 109
(line DayDeaMeRaA01S00U20210607P date, sort lcolor(red)) /// 110
(line DayDeaMeRaA01S00U20210608P date, sort lcolor(red)) /// 111
(line DayDeaMeRaA01S00U20210609P date, sort lcolor(red)) /// 112
(line DayDeaMeRaA01S00U20210610P date, sort lcolor(red)) /// 113
(line DayDeaMeRaA01S00U20210611P date, sort lcolor(red)) /// 114
(line DayDeaMeRaA01S00U20210612P date, sort lcolor(red)) /// 115
(line DayDeaMeRaA01S00U20210613P date, sort lcolor(red)) /// 116
(line DayDeaMeRaA01S00U20210614P date, sort lcolor(red)) /// 117
(line DayDeaMeRaA01S00U20210615P date, sort lcolor(red)) /// 118
(line DayDeaMeRaA01S00U20210616P date, sort lcolor(red)) /// 119
(line DayDeaMeRaA01S00U20210617P date, sort lcolor(red)) /// 120
(line DayDeaMeRaA01S00U20210618P date, sort lcolor(red)) /// 121
(line DayDeaMeRaA01S00U20210619P date, sort lcolor(red)) /// 122
(line DayDeaMeRaA01S00U20210620P date, sort lcolor(red)) /// 123
(line DayDeaMeRaA01S00U20210621P date, sort lcolor(red)) /// 124
(line DayDeaMeRaA01S00U20210622P date, sort lcolor(red)) /// 125
(line DayDeaMeRaA01S00U20210623P date, sort lcolor(red)) /// 126
(line DayDeaMeRaA01S00U20210624P date, sort lcolor(red)) /// 127
(line DayDeaMeRaA01S00U20210625P date, sort lcolor(red)) /// 128
(line DayDeaMeRaA01S00U20210626P date, sort lcolor(red)) /// 129
(line DayDeaMeRaA01S00U20210627P date, sort lcolor(red)) /// 130
(line DayDeaMeRaA01S00U20210628P date, sort lcolor(red)) /// 131
(line DayDeaMeRaA01S00U20210629P date, sort lcolor(red)) /// 132
(line DayDeaMeRaA01S00U20210630P date, sort lcolor(red)) /// 133
(line DayDeaMeRaA01S00U20210701P date, sort lcolor(red)) /// 134
(line DayDeaMeRaA01S00U20210702P date, sort lcolor(red)) /// 135
(line DayDeaMeRaA01S00U20210703P date, sort lcolor(red)) /// 136
(line DayDeaMeRaA01S00U20210704P date, sort lcolor(red)) /// 137
(line DayDeaMeRaA01S00U20210705P date, sort lcolor(red)) /// 138
(line DayDeaMeRaA01S00U20210706P date, sort lcolor(red)) /// 139
(line DayDeaMeRaA01S00U20210707P date, sort lcolor(red)) /// 140
(line DayDeaMeRaA01S00U20210708P date, sort lcolor(red)) /// 141
(line DayDeaMeRaA01S00U20210709P date, sort lcolor(red)) /// 142
(line DayDeaMeRaA01S00U20210710P date, sort lcolor(red)) /// 143
(line DayDeaMeRaA01S00U20210711P date, sort lcolor(red)) /// 144
(line DayDeaMeRaA01S00U20210712P date, sort lcolor(red)) /// 145
(line DayDeaMeRaA01S00U20210713P date, sort lcolor(red)) /// 146
(line DayDeaMeRaA01S00U20210714P date, sort lcolor(red)) /// 147
(line DayDeaMeRaA01S00U20210715P date, sort lcolor(red)) /// 148
(line DayDeaMeRaA01S00U20210716P date, sort lcolor(red)) /// 149
(line DayDeaMeRaA01S00U20210717P date, sort lcolor(red)) /// 150
(line DayDeaMeRaA01S00U20210718P date, sort lcolor(red)) /// 151
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths DELP percent JOHN smooth) title("COVID-19 daily deaths, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; without extremes i.e. > 2 times max reported 1,000", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))	

qui graph save "graph 14b COVID-19 daily deaths, $country, DELP, wo extreme, Percent.gph", replace
qui graph export "graph 14b COVID-19 daily deaths, $country, DELP, wo extreme, Percent.pdf", replace













* daily cases

**************************************




* daily cases, Absolute value, individual updates


foreach l of global DELPupdatelist {

twoway  /// 
(line DayCasMeSmA00S00 date, lcolor(cyan*1.2)) ///  
(line DayCasMeRaA01S00U`l' date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country, DELP, update `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN smooth" 2 "DELP `l'") size(small) rows(1))	

qui graph save "graph 21i COVID-19 daily cases, $country, DELP update `l'.gph", replace
qui graph export "graph 21i COVID-19 daily cases, $country, DELP update `l'.pdf", replace

}
*



* daily cases, Absolute value, together, with extremes 168

twoway  ///
(line DayCasMeRaA01S00U20200723 date, sort lcolor(red) lpattern(dash)) /// 1
(line DayCasMeRaA01S00U20200919 date, sort lcolor(red) lpattern(dash)) /// 2
(line DayCasMeRaA01S00U20200926 date, sort lcolor(red) lpattern(dash)) /// 3
(line DayCasMeRaA01S00U20201001 date, sort lcolor(red) lpattern(dash)) /// 4
(line DayCasMeRaA01S00U20201008 date, sort lcolor(red) lpattern(dash)) /// 5
(line DayCasMeRaA01S00U20201015 date, sort lcolor(red) lpattern(dash)) /// 6
(line DayCasMeRaA01S00U20201022 date, sort lcolor(red) lpattern(dash)) /// 7
(line DayCasMeRaA01S00U20201029 date, sort lcolor(red) lpattern(dash)) /// 8
(line DayCasMeRaA01S00U20201105 date, sort lcolor(red) lpattern(dash)) /// 9
(line DayCasMeRaA01S00U20201112 date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line DayCasMeRaA01S00U20201119 date, sort lcolor(red)) /// 11 v4
(line DayCasMeRaA01S00U20201126 date, sort lcolor(red)) /// 12
(line DayCasMeRaA01S00U20201203 date, sort lcolor(red)) /// 13
(line DayCasMeRaA01S00U20201210 date, sort lcolor(red)) /// 14
(line DayCasMeRaA01S00U20201217 date, sort lcolor(red)) /// 15
(line DayCasMeRaA01S00U20201224 date, sort lcolor(red)) /// 16
(line DayCasMeRaA01S00U20201231 date, sort lcolor(red)) /// 17
(line DayCasMeRaA01S00U20210107 date, sort lcolor(red)) /// 18
(line DayCasMeRaA01S00U20210114 date, sort lcolor(red)) /// 19
(line DayCasMeRaA01S00U20210121 date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210128 date, sort lcolor(red)) /// 21
(line DayCasMeRaA01S00U20210204 date, sort lcolor(red)) /// 22
(line DayCasMeRaA01S00U20210211 date, sort lcolor(red)) /// 23
(line DayCasMeRaA01S00U20210218 date, sort lcolor(red)) /// 24
(line DayCasMeRaA01S00U20210225 date, sort lcolor(red)) /// 25
(line DayCasMeRaA01S00U20210226 date, sort lcolor(red)) /// 26
(line DayCasMeRaA01S00U20210227 date, sort lcolor(red)) /// 27
(line DayCasMeRaA01S00U20210228 date, sort lcolor(red)) /// 28
(line DayCasMeRaA01S00U20210301 date, sort lcolor(red)) /// 29
(line DayCasMeRaA01S00U20210303 date, sort lcolor(red)) /// 30
(line DayCasMeRaA01S00U20210304 date, sort lcolor(red)) /// 31
(line DayCasMeRaA01S00U20210305 date, sort lcolor(red)) /// 32
(line DayCasMeRaA01S00U20210306 date, sort lcolor(red)) /// 33
(line DayCasMeRaA01S00U20210307 date, sort lcolor(red)) /// 34
(line DayCasMeRaA01S00U20210308 date, sort lcolor(red)) /// 35
(line DayCasMeRaA01S00U20210309 date, sort lcolor(red)) /// 36
(line DayCasMeRaA01S00U20210310 date, sort lcolor(red)) /// 37
(line DayCasMeRaA01S00U20210311 date, sort lcolor(red)) /// 38
(line DayCasMeRaA01S00U20210312 date, sort lcolor(red)) /// 39
(line DayCasMeRaA01S00U20210313 date, sort lcolor(red)) /// 40
(line DayCasMeRaA01S00U20210314 date, sort lcolor(red)) /// 41
(line DayCasMeRaA01S00U20210315 date, sort lcolor(red)) /// 42
(line DayCasMeRaA01S00U20210316 date, sort lcolor(red)) /// 43
(line DayCasMeRaA01S00U20210317 date, sort lcolor(red)) /// 44
(line DayCasMeRaA01S00U20210318 date, sort lcolor(red)) /// 45
(line DayCasMeRaA01S00U20210319 date, sort lcolor(red)) /// 46
(line DayCasMeRaA01S00U20210320 date, sort lcolor(red)) /// 47
(line DayCasMeRaA01S00U20210321 date, sort lcolor(red)) /// 48
(line DayCasMeRaA01S00U20210322 date, sort lcolor(red)) /// 49
(line DayCasMeRaA01S00U20210323 date, sort lcolor(red)) /// 50
(line DayCasMeRaA01S00U20210324 date, sort lcolor(red)) /// 51
(line DayCasMeRaA01S00U20210325 date, sort lcolor(red)) /// 52
(line DayCasMeRaA01S00U20210326 date, sort lcolor(red)) /// 53
(line DayCasMeRaA01S00U20210327 date, sort lcolor(red)) /// 54
(line DayCasMeRaA01S00U20210328 date, sort lcolor(red)) /// 55
(line DayCasMeRaA01S00U20210329 date, sort lcolor(red)) /// 56
(line DayCasMeRaA01S00U20210330 date, sort lcolor(red)) /// 57
(line DayCasMeRaA01S00U20210331 date, sort lcolor(red)) /// 58
(line DayCasMeRaA01S00U20210401 date, sort lcolor(red)) /// 59
(line DayCasMeRaA01S00U20210402 date, sort lcolor(red)) /// 60
(line DayCasMeRaA01S00U20210403 date, sort lcolor(red)) /// 61
(line DayCasMeRaA01S00U20210404 date, sort lcolor(red)) /// 62
(line DayCasMeRaA01S00U20210405 date, sort lcolor(red)) /// 63
(line DayCasMeRaA01S00U20210406 date, sort lcolor(red)) /// 64
(line DayCasMeRaA01S00U20210407 date, sort lcolor(red)) /// 65
(line DayCasMeRaA01S00U20210408 date, sort lcolor(red)) /// 66
(line DayCasMeRaA01S00U20210409 date, sort lcolor(red)) /// 67
(line DayCasMeRaA01S00U20210410 date, sort lcolor(red)) /// 68
(line DayCasMeRaA01S00U20210411 date, sort lcolor(red)) /// 69
(line DayCasMeRaA01S00U20210412 date, sort lcolor(red)) /// 70
(line DayCasMeRaA01S00U20210413 date, sort lcolor(red)) /// 71
(line DayCasMeRaA01S00U20210414 date, sort lcolor(red)) /// 72
(line DayCasMeRaA01S00U20210415 date, sort lcolor(red)) /// 73
(line DayCasMeRaA01S00U20210416 date, sort lcolor(red)) /// 74
(line DayCasMeRaA01S00U20210417 date, sort lcolor(red)) /// 75
(line DayCasMeRaA01S00U20210418 date, sort lcolor(red)) /// 76
(line DayCasMeRaA01S00U20210419 date, sort lcolor(red)) /// 77
(line DayCasMeRaA01S00U20210420 date, sort lcolor(red)) /// 78
(line DayCasMeRaA01S00U20210421 date, sort lcolor(red)) /// 79
(line DayCasMeRaA01S00U20210422 date, sort lcolor(red)) /// 80
(line DayCasMeRaA01S00U20210423 date, sort lcolor(red)) /// 81
(line DayCasMeRaA01S00U20210424 date, sort lcolor(red)) /// 82
(line DayCasMeRaA01S00U20210425 date, sort lcolor(red)) /// 83
(line DayCasMeRaA01S00U20210426 date, sort lcolor(red)) /// 84
(line DayCasMeRaA01S00U20210427 date, sort lcolor(red)) /// 85
(line DayCasMeRaA01S00U20210428 date, sort lcolor(red)) /// 86
(line DayCasMeRaA01S00U20210429 date, sort lcolor(red)) /// 87
(line DayCasMeRaA01S00U20210430 date, sort lcolor(red)) /// 88
(line DayCasMeRaA01S00U20210501 date, sort lcolor(red)) /// 89
(line DayCasMeRaA01S00U20210502 date, sort lcolor(red)) /// 90
(line DayCasMeRaA01S00U20210503 date, sort lcolor(red)) /// 91
(line DayCasMeRaA01S00U20210504 date, sort lcolor(red)) /// 92
(line DayCasMeRaA01S00U20210505 date, sort lcolor(red)) /// 93
(line DayCasMeRaA01S00U20210506 date, sort lcolor(red)) /// 94
(line DayCasMeRaA01S00U20210507 date, sort lcolor(red)) /// 95
(line DayCasMeRaA01S00U20210508 date, sort lcolor(red)) /// 96
(line DayCasMeRaA01S00U20210509 date, sort lcolor(red)) /// 97
(line DayCasMeRaA01S00U20210510 date, sort lcolor(red)) /// 98
(line DayCasMeRaA01S00U20210511 date, sort lcolor(red)) /// 99
(line DayCasMeRaA01S00U20210512 date, sort lcolor(red)) /// 100
(line DayCasMeRaA01S00U20210513 date, sort lcolor(red)) /// 101
(line DayCasMeRaA01S00U20210514 date, sort lcolor(red)) /// 102
(line DayCasMeRaA01S00U20210515 date, sort lcolor(red)) /// 103
(line DayCasMeRaA01S00U20210516 date, sort lcolor(red)) /// 104
(line DayCasMeRaA01S00U20210517 date, sort lcolor(red)) /// 105
(line DayCasMeRaA01S00U20210518 date, sort lcolor(red)) /// 106
(line DayCasMeRaA01S00U20210519 date, sort lcolor(red)) /// 107
(line DayCasMeRaA01S00U20210520 date, sort lcolor(red)) /// 108
(line DayCasMeRaA01S00U20210521 date, sort lcolor(red)) /// 109
(line DayCasMeRaA01S00U20210522 date, sort lcolor(red)) /// 110
(line DayCasMeRaA01S00U20210523 date, sort lcolor(red)) /// 111
(line DayCasMeRaA01S00U20210524 date, sort lcolor(red)) /// 112
(line DayCasMeRaA01S00U20210525 date, sort lcolor(red)) /// 113
(line DayCasMeRaA01S00U20210526 date, sort lcolor(red)) /// 114
(line DayCasMeRaA01S00U20210527 date, sort lcolor(red)) /// 115
(line DayCasMeRaA01S00U20210528 date, sort lcolor(red)) /// 116
(line DayCasMeRaA01S00U20210529 date, sort lcolor(red)) /// 117
(line DayCasMeRaA01S00U20210530 date, sort lcolor(red)) /// 118
(line DayCasMeRaA01S00U20210531 date, sort lcolor(red)) /// 119
(line DayCasMeRaA01S00U20210601 date, sort lcolor(red)) /// 120
(line DayCasMeRaA01S00U20210602 date, sort lcolor(red)) /// 121
(line DayCasMeRaA01S00U20210603 date, sort lcolor(red)) /// 122
(line DayCasMeRaA01S00U20210604 date, sort lcolor(red)) /// 123
(line DayCasMeRaA01S00U20210605 date, sort lcolor(red)) /// 124
(line DayCasMeRaA01S00U20210606 date, sort lcolor(red)) /// 125
(line DayCasMeRaA01S00U20210607 date, sort lcolor(red)) /// 126
(line DayCasMeRaA01S00U20210608 date, sort lcolor(red)) /// 127
(line DayCasMeRaA01S00U20210609 date, sort lcolor(red)) /// 128
(line DayCasMeRaA01S00U20210610 date, sort lcolor(red)) /// 129
(line DayCasMeRaA01S00U20210611 date, sort lcolor(red)) /// 130
(line DayCasMeRaA01S00U20210612 date, sort lcolor(red)) /// 131
(line DayCasMeRaA01S00U20210613 date, sort lcolor(red)) /// 132
(line DayCasMeRaA01S00U20210614 date, sort lcolor(red)) /// 133
(line DayCasMeRaA01S00U20210615 date, sort lcolor(red)) /// 134
(line DayCasMeRaA01S00U20210616 date, sort lcolor(red)) /// 135
(line DayCasMeRaA01S00U20210617 date, sort lcolor(red)) /// 136
(line DayCasMeRaA01S00U20210618 date, sort lcolor(red)) /// 137
(line DayCasMeRaA01S00U20210619 date, sort lcolor(red)) /// 138
(line DayCasMeRaA01S00U20210620 date, sort lcolor(red)) /// 139
(line DayCasMeRaA01S00U20210621 date, sort lcolor(red)) /// 140
(line DayCasMeRaA01S00U20210622 date, sort lcolor(red)) /// 141
(line DayCasMeRaA01S00U20210623 date, sort lcolor(red)) /// 142
(line DayCasMeRaA01S00U20210624 date, sort lcolor(red)) /// 143
(line DayCasMeRaA01S00U20210625 date, sort lcolor(red)) /// 144
(line DayCasMeRaA01S00U20210626 date, sort lcolor(red)) /// 145
(line DayCasMeRaA01S00U20210627 date, sort lcolor(red)) /// 146
(line DayCasMeRaA01S00U20210628 date, sort lcolor(red)) /// 147
(line DayCasMeRaA01S00U20210629 date, sort lcolor(red)) /// 148
(line DayCasMeRaA01S00U20210630 date, sort lcolor(red)) /// 149
(line DayCasMeRaA01S00U20210701 date, sort lcolor(red)) /// 150
(line DayCasMeRaA01S00U20210702 date, sort lcolor(red)) /// 151
(line DayCasMeRaA01S00U20210703 date, sort lcolor(red)) /// 152
(line DayCasMeRaA01S00U20210704 date, sort lcolor(red)) /// 153
(line DayCasMeRaA01S00U20210705 date, sort lcolor(red)) /// 154
(line DayCasMeRaA01S00U20210706 date, sort lcolor(red)) /// 155
(line DayCasMeRaA01S00U20210707 date, sort lcolor(red)) /// 156
(line DayCasMeRaA01S00U20210708 date, sort lcolor(red)) /// 157
(line DayCasMeRaA01S00U20210709 date, sort lcolor(red)) /// 158
(line DayCasMeRaA01S00U20210710 date, sort lcolor(red)) /// 159
(line DayCasMeRaA01S00U20210711 date, sort lcolor(red)) /// 160
(line DayCasMeRaA01S00U20210712 date, sort lcolor(red)) /// 161
(line DayCasMeRaA01S00U20210713 date, sort lcolor(red)) /// 162
(line DayCasMeRaA01S00U20210714 date, sort lcolor(red)) /// 163
(line DayCasMeRaA01S00U20210715 date, sort lcolor(red)) /// 164
(line DayCasMeRaA01S00U20210716 date, sort lcolor(red)) /// 165
(line DayCasMeRaA01S00U20210717 date, sort lcolor(red)) /// 166
(line DayCasMeRaA01S00U20210718 date, sort lcolor(red)) /// 167
(line DayCasMeRaA01S00U20210719 date, sort lcolor(red)) /// 168
(line DayCasMeSmA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 169
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(10 "DELP v2" 11 "DELP v4" 169 "JOHN smooth") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand)	yscale(titlegap(2))
  	   
qui graph save "graph 21a COVID-19 daily cases, $country, DELP.gph", replace
qui graph export "graph 21a COVID-19 daily cases, $country, DELP.pdf", replace




*********

* daily cases, Absolute value, together, without extremes 152


/*

Max reported daily cases has been less than 25,000 (April 2021), therefore, 
set bar for extreme as more than 2 times 25,000, i.e.,  > 50,000.

*/


twoway  ///
(line DayCasMeRaA01S00U20200723 date, sort lcolor(red) lpattern(dash)) /// 1
(line DayCasMeRaA01S00U20200919 date, sort lcolor(red) lpattern(dash)) /// 2
(line DayCasMeRaA01S00U20200926 date, sort lcolor(red) lpattern(dash)) /// 3
(line DayCasMeRaA01S00U20201001 date, sort lcolor(red) lpattern(dash)) /// 4
(line DayCasMeRaA01S00U20201008 date, sort lcolor(red) lpattern(dash)) /// 5
(line DayCasMeRaA01S00U20201015 date, sort lcolor(red) lpattern(dash)) /// 6
(line DayCasMeRaA01S00U20201022 date, sort lcolor(red) lpattern(dash)) /// 7
(line DayCasMeRaA01S00U20201029 date, sort lcolor(red) lpattern(dash)) /// 8
(line DayCasMeRaA01S00U20201105 date, sort lcolor(red) lpattern(dash)) /// 9
(line DayCasMeRaA01S00U20201112 date, sort lcolor(red) lpattern(dash)) /// 10
(line DayCasMeRaA01S00U20201119 date, sort lcolor(red)) /// 11
(line DayCasMeRaA01S00U20201126 date, sort lcolor(red)) /// 12
(line DayCasMeRaA01S00U20201203 date, sort lcolor(red)) /// 13
(line DayCasMeRaA01S00U20201210 date, sort lcolor(red)) /// 14
(line DayCasMeRaA01S00U20201217 date, sort lcolor(red)) /// 15
(line DayCasMeRaA01S00U20201224 date, sort lcolor(red)) /// 16
(line DayCasMeRaA01S00U20201231 date, sort lcolor(red)) /// 17
(line DayCasMeRaA01S00U20210107 date, sort lcolor(red)) /// 18
(line DayCasMeRaA01S00U20210114 date, sort lcolor(red)) /// 19
(line DayCasMeRaA01S00U20210121 date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210303 date, sort lcolor(red)) /// 21
(line DayCasMeRaA01S00U20210304 date, sort lcolor(red)) /// 22
(line DayCasMeRaA01S00U20210305 date, sort lcolor(red)) /// 23
(line DayCasMeRaA01S00U20210306 date, sort lcolor(red)) /// 24
(line DayCasMeRaA01S00U20210307 date, sort lcolor(red)) /// 25
(line DayCasMeRaA01S00U20210308 date, sort lcolor(red)) /// 26
(line DayCasMeRaA01S00U20210309 date, sort lcolor(red)) /// 27
(line DayCasMeRaA01S00U20210310 date, sort lcolor(red)) /// 28
(line DayCasMeRaA01S00U20210311 date, sort lcolor(red)) /// 29
(line DayCasMeRaA01S00U20210312 date, sort lcolor(red)) /// 30
(line DayCasMeRaA01S00U20210313 date, sort lcolor(red)) /// 31
(line DayCasMeRaA01S00U20210314 date, sort lcolor(red)) /// 32
(line DayCasMeRaA01S00U20210315 date, sort lcolor(red)) /// 33
(line DayCasMeRaA01S00U20210316 date, sort lcolor(red)) /// 34
(line DayCasMeRaA01S00U20210317 date, sort lcolor(red)) /// 35
(line DayCasMeRaA01S00U20210318 date, sort lcolor(red)) /// 36
(line DayCasMeRaA01S00U20210319 date, sort lcolor(red)) /// 37
(line DayCasMeRaA01S00U20210320 date, sort lcolor(red)) /// 38
(line DayCasMeRaA01S00U20210321 date, sort lcolor(red)) /// 39
(line DayCasMeRaA01S00U20210322 date, sort lcolor(red)) /// 40
(line DayCasMeRaA01S00U20210323 date, sort lcolor(red)) /// 41
(line DayCasMeRaA01S00U20210324 date, sort lcolor(red)) /// 42
(line DayCasMeRaA01S00U20210325 date, sort lcolor(red)) /// 43
(line DayCasMeRaA01S00U20210326 date, sort lcolor(red)) /// 44
(line DayCasMeRaA01S00U20210327 date, sort lcolor(red)) /// 45
(line DayCasMeRaA01S00U20210328 date, sort lcolor(red)) /// 46
(line DayCasMeRaA01S00U20210329 date, sort lcolor(red)) /// 47
(line DayCasMeRaA01S00U20210330 date, sort lcolor(red)) /// 48
(line DayCasMeRaA01S00U20210331 date, sort lcolor(red)) /// 49
(line DayCasMeRaA01S00U20210401 date, sort lcolor(red)) /// 50
(line DayCasMeRaA01S00U20210402 date, sort lcolor(red)) /// 51
(line DayCasMeRaA01S00U20210403 date, sort lcolor(red)) /// 52
(line DayCasMeRaA01S00U20210404 date, sort lcolor(red)) /// 53
(line DayCasMeRaA01S00U20210405 date, sort lcolor(red)) /// 54
(line DayCasMeRaA01S00U20210406 date, sort lcolor(red)) /// 55
(line DayCasMeRaA01S00U20210407 date, sort lcolor(red)) /// 56
(line DayCasMeRaA01S00U20210408 date, sort lcolor(red)) /// 57
(line DayCasMeRaA01S00U20210409 date, sort lcolor(red)) /// 58
(line DayCasMeRaA01S00U20210410 date, sort lcolor(red)) /// 59
(line DayCasMeRaA01S00U20210411 date, sort lcolor(red)) /// 60
(line DayCasMeRaA01S00U20210412 date, sort lcolor(red)) /// 61
(line DayCasMeRaA01S00U20210413 date, sort lcolor(red)) /// 62
(line DayCasMeRaA01S00U20210414 date, sort lcolor(red)) /// 63
(line DayCasMeRaA01S00U20210415 date, sort lcolor(red)) /// 64
(line DayCasMeRaA01S00U20210416 date, sort lcolor(red)) /// 65
(line DayCasMeRaA01S00U20210417 date, sort lcolor(red)) /// 66
(line DayCasMeRaA01S00U20210418 date, sort lcolor(red)) /// 67
(line DayCasMeRaA01S00U20210419 date, sort lcolor(red)) /// 68
(line DayCasMeRaA01S00U20210420 date, sort lcolor(red)) /// 69
(line DayCasMeRaA01S00U20210421 date, sort lcolor(red)) /// 70
(line DayCasMeRaA01S00U20210422 date, sort lcolor(red)) /// 71
(line DayCasMeRaA01S00U20210423 date, sort lcolor(red)) /// 72
(line DayCasMeRaA01S00U20210424 date, sort lcolor(red)) /// 73
(line DayCasMeRaA01S00U20210425 date, sort lcolor(red)) /// 74
(line DayCasMeRaA01S00U20210426 date, sort lcolor(red)) /// 75
(line DayCasMeRaA01S00U20210427 date, sort lcolor(red)) /// 76
(line DayCasMeRaA01S00U20210428 date, sort lcolor(red)) /// 77
(line DayCasMeRaA01S00U20210429 date, sort lcolor(red)) /// 78
(line DayCasMeRaA01S00U20210430 date, sort lcolor(red)) /// 79
(line DayCasMeRaA01S00U20210501 date, sort lcolor(red)) /// 80
(line DayCasMeRaA01S00U20210502 date, sort lcolor(red)) /// 81
(line DayCasMeRaA01S00U20210503 date, sort lcolor(red)) /// 82
(line DayCasMeRaA01S00U20210504 date, sort lcolor(red)) /// 83
(line DayCasMeRaA01S00U20210505 date, sort lcolor(red)) /// 84
(line DayCasMeRaA01S00U20210506 date, sort lcolor(red)) /// 85
(line DayCasMeRaA01S00U20210507 date, sort lcolor(red)) /// 86
(line DayCasMeRaA01S00U20210508 date, sort lcolor(red)) /// 87
(line DayCasMeRaA01S00U20210509 date, sort lcolor(red)) /// 88
(line DayCasMeRaA01S00U20210510 date, sort lcolor(red)) /// 89
(line DayCasMeRaA01S00U20210511 date, sort lcolor(red)) /// 90
(line DayCasMeRaA01S00U20210512 date, sort lcolor(red)) /// 91
(line DayCasMeRaA01S00U20210513 date, sort lcolor(red)) /// 92
(line DayCasMeRaA01S00U20210514 date, sort lcolor(red)) /// 93
(line DayCasMeRaA01S00U20210515 date, sort lcolor(red)) /// 94
(line DayCasMeRaA01S00U20210516 date, sort lcolor(red)) /// 95
(line DayCasMeRaA01S00U20210517 date, sort lcolor(red)) /// 96
(line DayCasMeRaA01S00U20210518 date, sort lcolor(red)) /// 97
(line DayCasMeRaA01S00U20210519 date, sort lcolor(red)) /// 98
(line DayCasMeRaA01S00U20210520 date, sort lcolor(red)) /// 99
(line DayCasMeRaA01S00U20210521 date, sort lcolor(red)) /// 100
(line DayCasMeRaA01S00U20210522 date, sort lcolor(red)) /// 101
(line DayCasMeRaA01S00U20210530 date, sort lcolor(red)) /// 102
(line DayCasMeRaA01S00U20210531 date, sort lcolor(red)) /// 103
(line DayCasMeRaA01S00U20210601 date, sort lcolor(red)) /// 104
(line DayCasMeRaA01S00U20210602 date, sort lcolor(red)) /// 105
(line DayCasMeRaA01S00U20210603 date, sort lcolor(red)) /// 106
(line DayCasMeRaA01S00U20210604 date, sort lcolor(red)) /// 107
(line DayCasMeRaA01S00U20210605 date, sort lcolor(red)) /// 108
(line DayCasMeRaA01S00U20210606 date, sort lcolor(red)) /// 109
(line DayCasMeRaA01S00U20210607 date, sort lcolor(red)) /// 110
(line DayCasMeRaA01S00U20210608 date, sort lcolor(red)) /// 111
(line DayCasMeRaA01S00U20210609 date, sort lcolor(red)) /// 112
(line DayCasMeRaA01S00U20210610 date, sort lcolor(red)) /// 113
(line DayCasMeRaA01S00U20210611 date, sort lcolor(red)) /// 114
(line DayCasMeRaA01S00U20210612 date, sort lcolor(red)) /// 115
(line DayCasMeRaA01S00U20210613 date, sort lcolor(red)) /// 116
(line DayCasMeRaA01S00U20210614 date, sort lcolor(red)) /// 117
(line DayCasMeRaA01S00U20210615 date, sort lcolor(red)) /// 118
(line DayCasMeRaA01S00U20210616 date, sort lcolor(red)) /// 119
(line DayCasMeRaA01S00U20210617 date, sort lcolor(red)) /// 120
(line DayCasMeRaA01S00U20210618 date, sort lcolor(red)) /// 121
(line DayCasMeRaA01S00U20210619 date, sort lcolor(red)) /// 122
(line DayCasMeRaA01S00U20210620 date, sort lcolor(red)) /// 123
(line DayCasMeRaA01S00U20210621 date, sort lcolor(red)) /// 124
(line DayCasMeRaA01S00U20210622 date, sort lcolor(red)) /// 125
(line DayCasMeRaA01S00U20210623 date, sort lcolor(red)) /// 126
(line DayCasMeRaA01S00U20210624 date, sort lcolor(red)) /// 127
(line DayCasMeRaA01S00U20210625 date, sort lcolor(red)) /// 128
(line DayCasMeRaA01S00U20210626 date, sort lcolor(red)) /// 129
(line DayCasMeRaA01S00U20210627 date, sort lcolor(red)) /// 130
(line DayCasMeRaA01S00U20210628 date, sort lcolor(red)) /// 131
(line DayCasMeRaA01S00U20210629 date, sort lcolor(red)) /// 132
(line DayCasMeRaA01S00U20210630 date, sort lcolor(red)) /// 133
(line DayCasMeRaA01S00U20210701 date, sort lcolor(red)) /// 134
(line DayCasMeRaA01S00U20210702 date, sort lcolor(red)) /// 135
(line DayCasMeRaA01S00U20210703 date, sort lcolor(red)) /// 136
(line DayCasMeRaA01S00U20210704 date, sort lcolor(red)) /// 137
(line DayCasMeRaA01S00U20210705 date, sort lcolor(red)) /// 138
(line DayCasMeRaA01S00U20210706 date, sort lcolor(red)) /// 139
(line DayCasMeRaA01S00U20210707 date, sort lcolor(red)) /// 140
(line DayCasMeRaA01S00U20210708 date, sort lcolor(red)) /// 141
(line DayCasMeRaA01S00U20210709 date, sort lcolor(red)) /// 142
(line DayCasMeRaA01S00U20210710 date, sort lcolor(red)) /// 143
(line DayCasMeRaA01S00U20210711 date, sort lcolor(red)) /// 144
(line DayCasMeRaA01S00U20210712 date, sort lcolor(red)) /// 145
(line DayCasMeRaA01S00U20210713 date, sort lcolor(red)) /// 146
(line DayCasMeRaA01S00U20210714 date, sort lcolor(red)) /// 147
(line DayCasMeRaA01S00U20210715 date, sort lcolor(red)) /// 148
(line DayCasMeRaA01S00U20210716 date, sort lcolor(red)) /// 149
(line DayCasMeRaA01S00U20210717 date, sort lcolor(red)) /// 150
(line DayCasMeRaA01S00U20210718 date, sort lcolor(red)) /// 151
(line DayCasMeRaA01S00U20210719 date, sort lcolor(red)) /// 152
(line DayCasMeSmA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 153
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; without extremes i.e. > 2 times max reported 50,000", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(10 "DELP v2" 11 "DELP v4" 153 "JOHN smooth") size(small) rows(1)) yscale(titlegap(2))
  	   
qui graph save "graph 21b COVID-19 daily cases, $country, DELP, wo extreme.gph", replace
qui graph export "graph 21b COVID-19 daily cases, $country, DELP, wo extreme.pdf", replace


*


*********

* daily cases, Difference, together, with extremes 168

twoway  ///
(line DayCasMeRaA01S00U20200723D date, sort lcolor(red) lpattern(dash)) /// 1
(line DayCasMeRaA01S00U20200919D date, sort lcolor(red) lpattern(dash)) /// 2
(line DayCasMeRaA01S00U20200926D date, sort lcolor(red) lpattern(dash)) /// 3
(line DayCasMeRaA01S00U20201001D date, sort lcolor(red) lpattern(dash)) /// 4
(line DayCasMeRaA01S00U20201008D date, sort lcolor(red) lpattern(dash)) /// 5
(line DayCasMeRaA01S00U20201015D date, sort lcolor(red) lpattern(dash)) /// 6
(line DayCasMeRaA01S00U20201022D date, sort lcolor(red) lpattern(dash)) /// 7
(line DayCasMeRaA01S00U20201029D date, sort lcolor(red) lpattern(dash)) /// 8
(line DayCasMeRaA01S00U20201105D date, sort lcolor(red) lpattern(dash)) /// 9
(line DayCasMeRaA01S00U20201112D date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line DayCasMeRaA01S00U20201119D date, sort lcolor(red)) /// 11 v4
(line DayCasMeRaA01S00U20201126D date, sort lcolor(red)) /// 12
(line DayCasMeRaA01S00U20201203D date, sort lcolor(red)) /// 13
(line DayCasMeRaA01S00U20201210D date, sort lcolor(red)) /// 14
(line DayCasMeRaA01S00U20201217D date, sort lcolor(red)) /// 15
(line DayCasMeRaA01S00U20201224D date, sort lcolor(red)) /// 16
(line DayCasMeRaA01S00U20201231D date, sort lcolor(red)) /// 17
(line DayCasMeRaA01S00U20210107D date, sort lcolor(red)) /// 18
(line DayCasMeRaA01S00U20210114D date, sort lcolor(red)) /// 19
(line DayCasMeRaA01S00U20210121D date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210128D date, sort lcolor(red)) /// 21
(line DayCasMeRaA01S00U20210204D date, sort lcolor(red)) /// 22
(line DayCasMeRaA01S00U20210211D date, sort lcolor(red)) /// 23
(line DayCasMeRaA01S00U20210218D date, sort lcolor(red)) /// 24
(line DayCasMeRaA01S00U20210225D date, sort lcolor(red)) /// 25
(line DayCasMeRaA01S00U20210226D date, sort lcolor(red)) /// 26
(line DayCasMeRaA01S00U20210227D date, sort lcolor(red)) /// 27
(line DayCasMeRaA01S00U20210228D date, sort lcolor(red)) /// 28
(line DayCasMeRaA01S00U20210301D date, sort lcolor(red)) /// 29
(line DayCasMeRaA01S00U20210303D date, sort lcolor(red)) /// 30
(line DayCasMeRaA01S00U20210304D date, sort lcolor(red)) /// 31
(line DayCasMeRaA01S00U20210305D date, sort lcolor(red)) /// 32
(line DayCasMeRaA01S00U20210306D date, sort lcolor(red)) /// 33
(line DayCasMeRaA01S00U20210307D date, sort lcolor(red)) /// 34
(line DayCasMeRaA01S00U20210308D date, sort lcolor(red)) /// 35
(line DayCasMeRaA01S00U20210309D date, sort lcolor(red)) /// 36
(line DayCasMeRaA01S00U20210310D date, sort lcolor(red)) /// 37
(line DayCasMeRaA01S00U20210311D date, sort lcolor(red)) /// 38
(line DayCasMeRaA01S00U20210312D date, sort lcolor(red)) /// 39
(line DayCasMeRaA01S00U20210313D date, sort lcolor(red)) /// 40
(line DayCasMeRaA01S00U20210314D date, sort lcolor(red)) /// 41
(line DayCasMeRaA01S00U20210315D date, sort lcolor(red)) /// 42
(line DayCasMeRaA01S00U20210316D date, sort lcolor(red)) /// 43
(line DayCasMeRaA01S00U20210317D date, sort lcolor(red)) /// 44
(line DayCasMeRaA01S00U20210318D date, sort lcolor(red)) /// 45
(line DayCasMeRaA01S00U20210319D date, sort lcolor(red)) /// 46
(line DayCasMeRaA01S00U20210320D date, sort lcolor(red)) /// 47
(line DayCasMeRaA01S00U20210321D date, sort lcolor(red)) /// 48
(line DayCasMeRaA01S00U20210322D date, sort lcolor(red)) /// 49
(line DayCasMeRaA01S00U20210323D date, sort lcolor(red)) /// 50
(line DayCasMeRaA01S00U20210324D date, sort lcolor(red)) /// 51
(line DayCasMeRaA01S00U20210325D date, sort lcolor(red)) /// 52
(line DayCasMeRaA01S00U20210326D date, sort lcolor(red)) /// 53
(line DayCasMeRaA01S00U20210327D date, sort lcolor(red)) /// 54
(line DayCasMeRaA01S00U20210328D date, sort lcolor(red)) /// 55
(line DayCasMeRaA01S00U20210329D date, sort lcolor(red)) /// 56
(line DayCasMeRaA01S00U20210330D date, sort lcolor(red)) /// 57
(line DayCasMeRaA01S00U20210331D date, sort lcolor(red)) /// 58
(line DayCasMeRaA01S00U20210401D date, sort lcolor(red)) /// 59
(line DayCasMeRaA01S00U20210402D date, sort lcolor(red)) /// 60
(line DayCasMeRaA01S00U20210403D date, sort lcolor(red)) /// 61
(line DayCasMeRaA01S00U20210404D date, sort lcolor(red)) /// 62
(line DayCasMeRaA01S00U20210405D date, sort lcolor(red)) /// 63
(line DayCasMeRaA01S00U20210406D date, sort lcolor(red)) /// 64
(line DayCasMeRaA01S00U20210407D date, sort lcolor(red)) /// 65
(line DayCasMeRaA01S00U20210408D date, sort lcolor(red)) /// 66
(line DayCasMeRaA01S00U20210409D date, sort lcolor(red)) /// 67
(line DayCasMeRaA01S00U20210410D date, sort lcolor(red)) /// 68
(line DayCasMeRaA01S00U20210411D date, sort lcolor(red)) /// 69
(line DayCasMeRaA01S00U20210412D date, sort lcolor(red)) /// 70
(line DayCasMeRaA01S00U20210413D date, sort lcolor(red)) /// 71
(line DayCasMeRaA01S00U20210414D date, sort lcolor(red)) /// 72
(line DayCasMeRaA01S00U20210415D date, sort lcolor(red)) /// 73
(line DayCasMeRaA01S00U20210416D date, sort lcolor(red)) /// 74
(line DayCasMeRaA01S00U20210417D date, sort lcolor(red)) /// 75
(line DayCasMeRaA01S00U20210418D date, sort lcolor(red)) /// 76
(line DayCasMeRaA01S00U20210419D date, sort lcolor(red)) /// 77
(line DayCasMeRaA01S00U20210420D date, sort lcolor(red)) /// 78
(line DayCasMeRaA01S00U20210421D date, sort lcolor(red)) /// 79
(line DayCasMeRaA01S00U20210422D date, sort lcolor(red)) /// 80
(line DayCasMeRaA01S00U20210423D date, sort lcolor(red)) /// 81
(line DayCasMeRaA01S00U20210424D date, sort lcolor(red)) /// 82
(line DayCasMeRaA01S00U20210425D date, sort lcolor(red)) /// 83
(line DayCasMeRaA01S00U20210426D date, sort lcolor(red)) /// 84
(line DayCasMeRaA01S00U20210427D date, sort lcolor(red)) /// 85
(line DayCasMeRaA01S00U20210428D date, sort lcolor(red)) /// 86
(line DayCasMeRaA01S00U20210429D date, sort lcolor(red)) /// 87
(line DayCasMeRaA01S00U20210430D date, sort lcolor(red)) /// 88
(line DayCasMeRaA01S00U20210501D date, sort lcolor(red)) /// 89
(line DayCasMeRaA01S00U20210502D date, sort lcolor(red)) /// 90
(line DayCasMeRaA01S00U20210503D date, sort lcolor(red)) /// 91
(line DayCasMeRaA01S00U20210504D date, sort lcolor(red)) /// 92
(line DayCasMeRaA01S00U20210505D date, sort lcolor(red)) /// 93
(line DayCasMeRaA01S00U20210506D date, sort lcolor(red)) /// 94
(line DayCasMeRaA01S00U20210507D date, sort lcolor(red)) /// 95
(line DayCasMeRaA01S00U20210508D date, sort lcolor(red)) /// 96
(line DayCasMeRaA01S00U20210509D date, sort lcolor(red)) /// 97
(line DayCasMeRaA01S00U20210510D date, sort lcolor(red)) /// 98
(line DayCasMeRaA01S00U20210511D date, sort lcolor(red)) /// 99
(line DayCasMeRaA01S00U20210512D date, sort lcolor(red)) /// 100
(line DayCasMeRaA01S00U20210513D date, sort lcolor(red)) /// 101
(line DayCasMeRaA01S00U20210514D date, sort lcolor(red)) /// 102
(line DayCasMeRaA01S00U20210515D date, sort lcolor(red)) /// 103
(line DayCasMeRaA01S00U20210516D date, sort lcolor(red)) /// 104
(line DayCasMeRaA01S00U20210517D date, sort lcolor(red)) /// 105
(line DayCasMeRaA01S00U20210518D date, sort lcolor(red)) /// 106
(line DayCasMeRaA01S00U20210519D date, sort lcolor(red)) /// 107
(line DayCasMeRaA01S00U20210520D date, sort lcolor(red)) /// 108
(line DayCasMeRaA01S00U20210521D date, sort lcolor(red)) /// 109
(line DayCasMeRaA01S00U20210522D date, sort lcolor(red)) /// 110
(line DayCasMeRaA01S00U20210523D date, sort lcolor(red)) /// 111
(line DayCasMeRaA01S00U20210524D date, sort lcolor(red)) /// 112
(line DayCasMeRaA01S00U20210525D date, sort lcolor(red)) /// 113
(line DayCasMeRaA01S00U20210526D date, sort lcolor(red)) /// 114
(line DayCasMeRaA01S00U20210527D date, sort lcolor(red)) /// 115
(line DayCasMeRaA01S00U20210528D date, sort lcolor(red)) /// 116
(line DayCasMeRaA01S00U20210529D date, sort lcolor(red)) /// 117
(line DayCasMeRaA01S00U20210530D date, sort lcolor(red)) /// 118
(line DayCasMeRaA01S00U20210531D date, sort lcolor(red)) /// 119
(line DayCasMeRaA01S00U20210601D date, sort lcolor(red)) /// 120
(line DayCasMeRaA01S00U20210602D date, sort lcolor(red)) /// 121
(line DayCasMeRaA01S00U20210603D date, sort lcolor(red)) /// 122
(line DayCasMeRaA01S00U20210604D date, sort lcolor(red)) /// 123
(line DayCasMeRaA01S00U20210605D date, sort lcolor(red)) /// 124
(line DayCasMeRaA01S00U20210606D date, sort lcolor(red)) /// 125
(line DayCasMeRaA01S00U20210607D date, sort lcolor(red)) /// 126
(line DayCasMeRaA01S00U20210608D date, sort lcolor(red)) /// 127
(line DayCasMeRaA01S00U20210609D date, sort lcolor(red)) /// 128
(line DayCasMeRaA01S00U20210610D date, sort lcolor(red)) /// 129
(line DayCasMeRaA01S00U20210611D date, sort lcolor(red)) /// 130
(line DayCasMeRaA01S00U20210612D date, sort lcolor(red)) /// 131
(line DayCasMeRaA01S00U20210613D date, sort lcolor(red)) /// 132
(line DayCasMeRaA01S00U20210614D date, sort lcolor(red)) /// 133
(line DayCasMeRaA01S00U20210615D date, sort lcolor(red)) /// 134
(line DayCasMeRaA01S00U20210616D date, sort lcolor(red)) /// 135
(line DayCasMeRaA01S00U20210617D date, sort lcolor(red)) /// 136
(line DayCasMeRaA01S00U20210618D date, sort lcolor(red)) /// 137
(line DayCasMeRaA01S00U20210619D date, sort lcolor(red)) /// 138
(line DayCasMeRaA01S00U20210620D date, sort lcolor(red)) /// 139
(line DayCasMeRaA01S00U20210621D date, sort lcolor(red)) /// 140
(line DayCasMeRaA01S00U20210622D date, sort lcolor(red)) /// 141
(line DayCasMeRaA01S00U20210623D date, sort lcolor(red)) /// 142
(line DayCasMeRaA01S00U20210624D date, sort lcolor(red)) /// 143
(line DayCasMeRaA01S00U20210625D date, sort lcolor(red)) /// 144
(line DayCasMeRaA01S00U20210626D date, sort lcolor(red)) /// 145
(line DayCasMeRaA01S00U20210627D date, sort lcolor(red)) /// 146
(line DayCasMeRaA01S00U20210628D date, sort lcolor(red)) /// 147
(line DayCasMeRaA01S00U20210629D date, sort lcolor(red)) /// 148
(line DayCasMeRaA01S00U20210630D date, sort lcolor(red)) /// 149
(line DayCasMeRaA01S00U20210701D date, sort lcolor(red)) /// 150
(line DayCasMeRaA01S00U20210702D date, sort lcolor(red)) /// 151
(line DayCasMeRaA01S00U20210703D date, sort lcolor(red)) /// 152
(line DayCasMeRaA01S00U20210704D date, sort lcolor(red)) /// 153
(line DayCasMeRaA01S00U20210705D date, sort lcolor(red)) /// 154
(line DayCasMeRaA01S00U20210706D date, sort lcolor(red)) /// 155
(line DayCasMeRaA01S00U20210707D date, sort lcolor(red)) /// 156
(line DayCasMeRaA01S00U20210708D date, sort lcolor(red)) /// 157
(line DayCasMeRaA01S00U20210709D date, sort lcolor(red)) /// 158
(line DayCasMeRaA01S00U20210710D date, sort lcolor(red)) /// 159
(line DayCasMeRaA01S00U20210711D date, sort lcolor(red)) /// 160
(line DayCasMeRaA01S00U20210712D date, sort lcolor(red)) /// 161
(line DayCasMeRaA01S00U20210713D date, sort lcolor(red)) /// 162
(line DayCasMeRaA01S00U20210714D date, sort lcolor(red)) /// 163
(line DayCasMeRaA01S00U20210715D date, sort lcolor(red)) /// 164
(line DayCasMeRaA01S00U20210716D date, sort lcolor(red)) /// 165
(line DayCasMeRaA01S00U20210717D date, sort lcolor(red)) /// 166
(line DayCasMeRaA01S00U20210718D date, sort lcolor(red)) /// 167
(line DayCasMeRaA01S00U20210719D date, sort lcolor(red)) /// 168
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases DELP minus JOHN smooth) title("COVID-19 daily cases, $country, DELP minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))	
  	   
qui graph save "graph 22a COVID-19 daily cases, $country, DELP, Difference.gph", replace
qui graph export "graph 22a COVID-19 daily cases, $country, DELP, Difference.pdf", replace





*********

* daily cases, Difference, together, without extremes 152

twoway  ///
(line DayCasMeRaA01S00U20200723D date, sort lcolor(red) lpattern(dash)) /// 1
(line DayCasMeRaA01S00U20200919D date, sort lcolor(red) lpattern(dash)) /// 2
(line DayCasMeRaA01S00U20200926D date, sort lcolor(red) lpattern(dash)) /// 3
(line DayCasMeRaA01S00U20201001D date, sort lcolor(red) lpattern(dash)) /// 4
(line DayCasMeRaA01S00U20201008D date, sort lcolor(red) lpattern(dash)) /// 5
(line DayCasMeRaA01S00U20201015D date, sort lcolor(red) lpattern(dash)) /// 6
(line DayCasMeRaA01S00U20201022D date, sort lcolor(red) lpattern(dash)) /// 7
(line DayCasMeRaA01S00U20201029D date, sort lcolor(red) lpattern(dash)) /// 8
(line DayCasMeRaA01S00U20201105D date, sort lcolor(red) lpattern(dash)) /// 9
(line DayCasMeRaA01S00U20201112D date, sort lcolor(red) lpattern(dash)) /// 10
(line DayCasMeRaA01S00U20201119D date, sort lcolor(red)) /// 11
(line DayCasMeRaA01S00U20201126D date, sort lcolor(red)) /// 12
(line DayCasMeRaA01S00U20201203D date, sort lcolor(red)) /// 13
(line DayCasMeRaA01S00U20201210D date, sort lcolor(red)) /// 14
(line DayCasMeRaA01S00U20201217D date, sort lcolor(red)) /// 15
(line DayCasMeRaA01S00U20201224D date, sort lcolor(red)) /// 16
(line DayCasMeRaA01S00U20201231D date, sort lcolor(red)) /// 17
(line DayCasMeRaA01S00U20210107D date, sort lcolor(red)) /// 18
(line DayCasMeRaA01S00U20210114D date, sort lcolor(red)) /// 19
(line DayCasMeRaA01S00U20210121D date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210303D date, sort lcolor(red)) /// 21
(line DayCasMeRaA01S00U20210304D date, sort lcolor(red)) /// 22
(line DayCasMeRaA01S00U20210305D date, sort lcolor(red)) /// 23
(line DayCasMeRaA01S00U20210306D date, sort lcolor(red)) /// 24
(line DayCasMeRaA01S00U20210307D date, sort lcolor(red)) /// 25
(line DayCasMeRaA01S00U20210308D date, sort lcolor(red)) /// 26
(line DayCasMeRaA01S00U20210309D date, sort lcolor(red)) /// 27
(line DayCasMeRaA01S00U20210310D date, sort lcolor(red)) /// 28
(line DayCasMeRaA01S00U20210311D date, sort lcolor(red)) /// 29
(line DayCasMeRaA01S00U20210312D date, sort lcolor(red)) /// 30
(line DayCasMeRaA01S00U20210313D date, sort lcolor(red)) /// 31
(line DayCasMeRaA01S00U20210314D date, sort lcolor(red)) /// 32
(line DayCasMeRaA01S00U20210315D date, sort lcolor(red)) /// 33
(line DayCasMeRaA01S00U20210316D date, sort lcolor(red)) /// 34
(line DayCasMeRaA01S00U20210317D date, sort lcolor(red)) /// 35
(line DayCasMeRaA01S00U20210318D date, sort lcolor(red)) /// 36
(line DayCasMeRaA01S00U20210319D date, sort lcolor(red)) /// 37
(line DayCasMeRaA01S00U20210320D date, sort lcolor(red)) /// 38
(line DayCasMeRaA01S00U20210321D date, sort lcolor(red)) /// 39
(line DayCasMeRaA01S00U20210322D date, sort lcolor(red)) /// 40
(line DayCasMeRaA01S00U20210323D date, sort lcolor(red)) /// 41
(line DayCasMeRaA01S00U20210324D date, sort lcolor(red)) /// 42
(line DayCasMeRaA01S00U20210325D date, sort lcolor(red)) /// 43
(line DayCasMeRaA01S00U20210326D date, sort lcolor(red)) /// 44
(line DayCasMeRaA01S00U20210327D date, sort lcolor(red)) /// 45
(line DayCasMeRaA01S00U20210328D date, sort lcolor(red)) /// 46
(line DayCasMeRaA01S00U20210329D date, sort lcolor(red)) /// 47
(line DayCasMeRaA01S00U20210330D date, sort lcolor(red)) /// 48
(line DayCasMeRaA01S00U20210331D date, sort lcolor(red)) /// 49
(line DayCasMeRaA01S00U20210401D date, sort lcolor(red)) /// 50
(line DayCasMeRaA01S00U20210402D date, sort lcolor(red)) /// 51
(line DayCasMeRaA01S00U20210403D date, sort lcolor(red)) /// 52
(line DayCasMeRaA01S00U20210404D date, sort lcolor(red)) /// 53
(line DayCasMeRaA01S00U20210405D date, sort lcolor(red)) /// 54
(line DayCasMeRaA01S00U20210406D date, sort lcolor(red)) /// 55
(line DayCasMeRaA01S00U20210407D date, sort lcolor(red)) /// 56
(line DayCasMeRaA01S00U20210408D date, sort lcolor(red)) /// 57
(line DayCasMeRaA01S00U20210409D date, sort lcolor(red)) /// 58
(line DayCasMeRaA01S00U20210410D date, sort lcolor(red)) /// 59
(line DayCasMeRaA01S00U20210411D date, sort lcolor(red)) /// 60
(line DayCasMeRaA01S00U20210412D date, sort lcolor(red)) /// 61
(line DayCasMeRaA01S00U20210413D date, sort lcolor(red)) /// 62
(line DayCasMeRaA01S00U20210414D date, sort lcolor(red)) /// 63
(line DayCasMeRaA01S00U20210415D date, sort lcolor(red)) /// 64
(line DayCasMeRaA01S00U20210416D date, sort lcolor(red)) /// 65
(line DayCasMeRaA01S00U20210417D date, sort lcolor(red)) /// 66
(line DayCasMeRaA01S00U20210418D date, sort lcolor(red)) /// 67
(line DayCasMeRaA01S00U20210419D date, sort lcolor(red)) /// 68
(line DayCasMeRaA01S00U20210420D date, sort lcolor(red)) /// 69
(line DayCasMeRaA01S00U20210421D date, sort lcolor(red)) /// 70
(line DayCasMeRaA01S00U20210422D date, sort lcolor(red)) /// 71
(line DayCasMeRaA01S00U20210423D date, sort lcolor(red)) /// 72
(line DayCasMeRaA01S00U20210424D date, sort lcolor(red)) /// 73
(line DayCasMeRaA01S00U20210425D date, sort lcolor(red)) /// 74
(line DayCasMeRaA01S00U20210426D date, sort lcolor(red)) /// 75
(line DayCasMeRaA01S00U20210427D date, sort lcolor(red)) /// 76
(line DayCasMeRaA01S00U20210428D date, sort lcolor(red)) /// 77
(line DayCasMeRaA01S00U20210429D date, sort lcolor(red)) /// 78
(line DayCasMeRaA01S00U20210430D date, sort lcolor(red)) /// 79
(line DayCasMeRaA01S00U20210501D date, sort lcolor(red)) /// 80
(line DayCasMeRaA01S00U20210502D date, sort lcolor(red)) /// 81
(line DayCasMeRaA01S00U20210503D date, sort lcolor(red)) /// 82
(line DayCasMeRaA01S00U20210504D date, sort lcolor(red)) /// 83
(line DayCasMeRaA01S00U20210505D date, sort lcolor(red)) /// 84
(line DayCasMeRaA01S00U20210506D date, sort lcolor(red)) /// 85
(line DayCasMeRaA01S00U20210507D date, sort lcolor(red)) /// 86
(line DayCasMeRaA01S00U20210508D date, sort lcolor(red)) /// 87
(line DayCasMeRaA01S00U20210509D date, sort lcolor(red)) /// 88
(line DayCasMeRaA01S00U20210510D date, sort lcolor(red)) /// 89
(line DayCasMeRaA01S00U20210511D date, sort lcolor(red)) /// 90
(line DayCasMeRaA01S00U20210512D date, sort lcolor(red)) /// 91
(line DayCasMeRaA01S00U20210513D date, sort lcolor(red)) /// 92
(line DayCasMeRaA01S00U20210514D date, sort lcolor(red)) /// 93
(line DayCasMeRaA01S00U20210515D date, sort lcolor(red)) /// 94
(line DayCasMeRaA01S00U20210516D date, sort lcolor(red)) /// 95
(line DayCasMeRaA01S00U20210517D date, sort lcolor(red)) /// 96
(line DayCasMeRaA01S00U20210518D date, sort lcolor(red)) /// 97
(line DayCasMeRaA01S00U20210519D date, sort lcolor(red)) /// 98
(line DayCasMeRaA01S00U20210520D date, sort lcolor(red)) /// 99
(line DayCasMeRaA01S00U20210521D date, sort lcolor(red)) /// 100
(line DayCasMeRaA01S00U20210522D date, sort lcolor(red)) /// 101
(line DayCasMeRaA01S00U20210530D date, sort lcolor(red)) /// 102
(line DayCasMeRaA01S00U20210531D date, sort lcolor(red)) /// 103
(line DayCasMeRaA01S00U20210601D date, sort lcolor(red)) /// 104
(line DayCasMeRaA01S00U20210602D date, sort lcolor(red)) /// 105
(line DayCasMeRaA01S00U20210603D date, sort lcolor(red)) /// 106
(line DayCasMeRaA01S00U20210604D date, sort lcolor(red)) /// 107
(line DayCasMeRaA01S00U20210605D date, sort lcolor(red)) /// 108
(line DayCasMeRaA01S00U20210606D date, sort lcolor(red)) /// 109
(line DayCasMeRaA01S00U20210607D date, sort lcolor(red)) /// 110
(line DayCasMeRaA01S00U20210608D date, sort lcolor(red)) /// 111
(line DayCasMeRaA01S00U20210609D date, sort lcolor(red)) /// 112
(line DayCasMeRaA01S00U20210610D date, sort lcolor(red)) /// 113
(line DayCasMeRaA01S00U20210611D date, sort lcolor(red)) /// 114
(line DayCasMeRaA01S00U20210612D date, sort lcolor(red)) /// 115
(line DayCasMeRaA01S00U20210613D date, sort lcolor(red)) /// 116
(line DayCasMeRaA01S00U20210614D date, sort lcolor(red)) /// 117
(line DayCasMeRaA01S00U20210615D date, sort lcolor(red)) /// 118
(line DayCasMeRaA01S00U20210616D date, sort lcolor(red)) /// 119
(line DayCasMeRaA01S00U20210617D date, sort lcolor(red)) /// 120
(line DayCasMeRaA01S00U20210618D date, sort lcolor(red)) /// 121
(line DayCasMeRaA01S00U20210619D date, sort lcolor(red)) /// 122
(line DayCasMeRaA01S00U20210620D date, sort lcolor(red)) /// 123
(line DayCasMeRaA01S00U20210621D date, sort lcolor(red)) /// 124
(line DayCasMeRaA01S00U20210622D date, sort lcolor(red)) /// 125
(line DayCasMeRaA01S00U20210623D date, sort lcolor(red)) /// 126
(line DayCasMeRaA01S00U20210624D date, sort lcolor(red)) /// 127
(line DayCasMeRaA01S00U20210625D date, sort lcolor(red)) /// 128
(line DayCasMeRaA01S00U20210626D date, sort lcolor(red)) /// 129
(line DayCasMeRaA01S00U20210627D date, sort lcolor(red)) /// 130
(line DayCasMeRaA01S00U20210628D date, sort lcolor(red)) /// 131
(line DayCasMeRaA01S00U20210629D date, sort lcolor(red)) /// 132
(line DayCasMeRaA01S00U20210630D date, sort lcolor(red)) /// 133
(line DayCasMeRaA01S00U20210701D date, sort lcolor(red)) /// 134
(line DayCasMeRaA01S00U20210702D date, sort lcolor(red)) /// 135
(line DayCasMeRaA01S00U20210703D date, sort lcolor(red)) /// 136
(line DayCasMeRaA01S00U20210704D date, sort lcolor(red)) /// 137
(line DayCasMeRaA01S00U20210705D date, sort lcolor(red)) /// 138
(line DayCasMeRaA01S00U20210706D date, sort lcolor(red)) /// 139
(line DayCasMeRaA01S00U20210707D date, sort lcolor(red)) /// 140
(line DayCasMeRaA01S00U20210708D date, sort lcolor(red)) /// 141
(line DayCasMeRaA01S00U20210709D date, sort lcolor(red)) /// 142
(line DayCasMeRaA01S00U20210710D date, sort lcolor(red)) /// 143
(line DayCasMeRaA01S00U20210711D date, sort lcolor(red)) /// 144
(line DayCasMeRaA01S00U20210712D date, sort lcolor(red)) /// 145
(line DayCasMeRaA01S00U20210713D date, sort lcolor(red)) /// 146
(line DayCasMeRaA01S00U20210714D date, sort lcolor(red)) /// 147
(line DayCasMeRaA01S00U20210715D date, sort lcolor(red)) /// 148
(line DayCasMeRaA01S00U20210716D date, sort lcolor(red)) /// 149
(line DayCasMeRaA01S00U20210717D date, sort lcolor(red)) /// 150
(line DayCasMeRaA01S00U20210718D date, sort lcolor(red)) /// 151
(line DayCasMeRaA01S00U20210719D date, sort lcolor(red)) /// 152
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases DELP divided by JOHN smooth) title("COVID-19 daily cases, $country, DELP minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; without extremes i.e. > 2 times max reported 50,000", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 22b COVID-19 daily cases, $country, DELP, wo extreme, Difference.gph", replace
qui graph export "graph 22b COVID-19 daily cases, $country, DELP, wo extreme, Difference.pdf", replace




*


*********

* daily cases, Times, together, with extremes 168

twoway  ///
(line DayCasMeRaA01S00U20200723T date, sort lcolor(red) lpattern(dash)) /// 1
(line DayCasMeRaA01S00U20200919T date, sort lcolor(red) lpattern(dash)) /// 2
(line DayCasMeRaA01S00U20200926T date, sort lcolor(red) lpattern(dash)) /// 3
(line DayCasMeRaA01S00U20201001T date, sort lcolor(red) lpattern(dash)) /// 4
(line DayCasMeRaA01S00U20201008T date, sort lcolor(red) lpattern(dash)) /// 5
(line DayCasMeRaA01S00U20201015T date, sort lcolor(red) lpattern(dash)) /// 6
(line DayCasMeRaA01S00U20201022T date, sort lcolor(red) lpattern(dash)) /// 7
(line DayCasMeRaA01S00U20201029T date, sort lcolor(red) lpattern(dash)) /// 8
(line DayCasMeRaA01S00U20201105T date, sort lcolor(red) lpattern(dash)) /// 9
(line DayCasMeRaA01S00U20201112T date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line DayCasMeRaA01S00U20201119T date, sort lcolor(red)) /// 11 v4
(line DayCasMeRaA01S00U20201126T date, sort lcolor(red)) /// 12
(line DayCasMeRaA01S00U20201203T date, sort lcolor(red)) /// 13
(line DayCasMeRaA01S00U20201210T date, sort lcolor(red)) /// 14
(line DayCasMeRaA01S00U20201217T date, sort lcolor(red)) /// 15
(line DayCasMeRaA01S00U20201224T date, sort lcolor(red)) /// 16
(line DayCasMeRaA01S00U20201231T date, sort lcolor(red)) /// 17
(line DayCasMeRaA01S00U20210107T date, sort lcolor(red)) /// 18
(line DayCasMeRaA01S00U20210114T date, sort lcolor(red)) /// 19
(line DayCasMeRaA01S00U20210121T date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210128T date, sort lcolor(red)) /// 21
(line DayCasMeRaA01S00U20210204T date, sort lcolor(red)) /// 22
(line DayCasMeRaA01S00U20210211T date, sort lcolor(red)) /// 23
(line DayCasMeRaA01S00U20210218T date, sort lcolor(red)) /// 24
(line DayCasMeRaA01S00U20210225T date, sort lcolor(red)) /// 25
(line DayCasMeRaA01S00U20210226T date, sort lcolor(red)) /// 26
(line DayCasMeRaA01S00U20210227T date, sort lcolor(red)) /// 27
(line DayCasMeRaA01S00U20210228T date, sort lcolor(red)) /// 28
(line DayCasMeRaA01S00U20210301T date, sort lcolor(red)) /// 29
(line DayCasMeRaA01S00U20210303T date, sort lcolor(red)) /// 30
(line DayCasMeRaA01S00U20210304T date, sort lcolor(red)) /// 31
(line DayCasMeRaA01S00U20210305T date, sort lcolor(red)) /// 32
(line DayCasMeRaA01S00U20210306T date, sort lcolor(red)) /// 33
(line DayCasMeRaA01S00U20210307T date, sort lcolor(red)) /// 34
(line DayCasMeRaA01S00U20210308T date, sort lcolor(red)) /// 35
(line DayCasMeRaA01S00U20210309T date, sort lcolor(red)) /// 36
(line DayCasMeRaA01S00U20210310T date, sort lcolor(red)) /// 37
(line DayCasMeRaA01S00U20210311T date, sort lcolor(red)) /// 38
(line DayCasMeRaA01S00U20210312T date, sort lcolor(red)) /// 39
(line DayCasMeRaA01S00U20210313T date, sort lcolor(red)) /// 40
(line DayCasMeRaA01S00U20210314T date, sort lcolor(red)) /// 41
(line DayCasMeRaA01S00U20210315T date, sort lcolor(red)) /// 42
(line DayCasMeRaA01S00U20210316T date, sort lcolor(red)) /// 43
(line DayCasMeRaA01S00U20210317T date, sort lcolor(red)) /// 44
(line DayCasMeRaA01S00U20210318T date, sort lcolor(red)) /// 45
(line DayCasMeRaA01S00U20210319T date, sort lcolor(red)) /// 46
(line DayCasMeRaA01S00U20210320T date, sort lcolor(red)) /// 47
(line DayCasMeRaA01S00U20210321T date, sort lcolor(red)) /// 48
(line DayCasMeRaA01S00U20210322T date, sort lcolor(red)) /// 49
(line DayCasMeRaA01S00U20210323T date, sort lcolor(red)) /// 50
(line DayCasMeRaA01S00U20210324T date, sort lcolor(red)) /// 51
(line DayCasMeRaA01S00U20210325T date, sort lcolor(red)) /// 52
(line DayCasMeRaA01S00U20210326T date, sort lcolor(red)) /// 53
(line DayCasMeRaA01S00U20210327T date, sort lcolor(red)) /// 54
(line DayCasMeRaA01S00U20210328T date, sort lcolor(red)) /// 55
(line DayCasMeRaA01S00U20210329T date, sort lcolor(red)) /// 56
(line DayCasMeRaA01S00U20210330T date, sort lcolor(red)) /// 57
(line DayCasMeRaA01S00U20210331T date, sort lcolor(red)) /// 58
(line DayCasMeRaA01S00U20210401T date, sort lcolor(red)) /// 59
(line DayCasMeRaA01S00U20210402T date, sort lcolor(red)) /// 60
(line DayCasMeRaA01S00U20210403T date, sort lcolor(red)) /// 61
(line DayCasMeRaA01S00U20210404T date, sort lcolor(red)) /// 62
(line DayCasMeRaA01S00U20210405T date, sort lcolor(red)) /// 63
(line DayCasMeRaA01S00U20210406T date, sort lcolor(red)) /// 64
(line DayCasMeRaA01S00U20210407T date, sort lcolor(red)) /// 65
(line DayCasMeRaA01S00U20210408T date, sort lcolor(red)) /// 66
(line DayCasMeRaA01S00U20210409T date, sort lcolor(red)) /// 67
(line DayCasMeRaA01S00U20210410T date, sort lcolor(red)) /// 68
(line DayCasMeRaA01S00U20210411T date, sort lcolor(red)) /// 69
(line DayCasMeRaA01S00U20210412T date, sort lcolor(red)) /// 70
(line DayCasMeRaA01S00U20210413T date, sort lcolor(red)) /// 71
(line DayCasMeRaA01S00U20210414T date, sort lcolor(red)) /// 72
(line DayCasMeRaA01S00U20210415T date, sort lcolor(red)) /// 73
(line DayCasMeRaA01S00U20210416T date, sort lcolor(red)) /// 74
(line DayCasMeRaA01S00U20210417T date, sort lcolor(red)) /// 75
(line DayCasMeRaA01S00U20210418T date, sort lcolor(red)) /// 76
(line DayCasMeRaA01S00U20210419T date, sort lcolor(red)) /// 77
(line DayCasMeRaA01S00U20210420T date, sort lcolor(red)) /// 78
(line DayCasMeRaA01S00U20210421T date, sort lcolor(red)) /// 79
(line DayCasMeRaA01S00U20210422T date, sort lcolor(red)) /// 80
(line DayCasMeRaA01S00U20210423T date, sort lcolor(red)) /// 81
(line DayCasMeRaA01S00U20210424T date, sort lcolor(red)) /// 82
(line DayCasMeRaA01S00U20210425T date, sort lcolor(red)) /// 83
(line DayCasMeRaA01S00U20210426T date, sort lcolor(red)) /// 84
(line DayCasMeRaA01S00U20210427T date, sort lcolor(red)) /// 85
(line DayCasMeRaA01S00U20210428T date, sort lcolor(red)) /// 86
(line DayCasMeRaA01S00U20210429T date, sort lcolor(red)) /// 87
(line DayCasMeRaA01S00U20210430T date, sort lcolor(red)) /// 88
(line DayCasMeRaA01S00U20210501T date, sort lcolor(red)) /// 89
(line DayCasMeRaA01S00U20210502T date, sort lcolor(red)) /// 90
(line DayCasMeRaA01S00U20210503T date, sort lcolor(red)) /// 91
(line DayCasMeRaA01S00U20210504T date, sort lcolor(red)) /// 92
(line DayCasMeRaA01S00U20210505T date, sort lcolor(red)) /// 93
(line DayCasMeRaA01S00U20210506T date, sort lcolor(red)) /// 94
(line DayCasMeRaA01S00U20210507T date, sort lcolor(red)) /// 95
(line DayCasMeRaA01S00U20210508T date, sort lcolor(red)) /// 96
(line DayCasMeRaA01S00U20210509T date, sort lcolor(red)) /// 97
(line DayCasMeRaA01S00U20210510T date, sort lcolor(red)) /// 98
(line DayCasMeRaA01S00U20210511T date, sort lcolor(red)) /// 99
(line DayCasMeRaA01S00U20210512T date, sort lcolor(red)) /// 100
(line DayCasMeRaA01S00U20210513T date, sort lcolor(red)) /// 101
(line DayCasMeRaA01S00U20210514T date, sort lcolor(red)) /// 102
(line DayCasMeRaA01S00U20210515T date, sort lcolor(red)) /// 103
(line DayCasMeRaA01S00U20210516T date, sort lcolor(red)) /// 104
(line DayCasMeRaA01S00U20210517T date, sort lcolor(red)) /// 105
(line DayCasMeRaA01S00U20210518T date, sort lcolor(red)) /// 106
(line DayCasMeRaA01S00U20210519T date, sort lcolor(red)) /// 107
(line DayCasMeRaA01S00U20210520T date, sort lcolor(red)) /// 108
(line DayCasMeRaA01S00U20210521T date, sort lcolor(red)) /// 109
(line DayCasMeRaA01S00U20210522T date, sort lcolor(red)) /// 110
(line DayCasMeRaA01S00U20210523T date, sort lcolor(red)) /// 111
(line DayCasMeRaA01S00U20210524T date, sort lcolor(red)) /// 112
(line DayCasMeRaA01S00U20210525T date, sort lcolor(red)) /// 113
(line DayCasMeRaA01S00U20210526T date, sort lcolor(red)) /// 114
(line DayCasMeRaA01S00U20210527T date, sort lcolor(red)) /// 115
(line DayCasMeRaA01S00U20210528T date, sort lcolor(red)) /// 116
(line DayCasMeRaA01S00U20210529T date, sort lcolor(red)) /// 117
(line DayCasMeRaA01S00U20210530T date, sort lcolor(red)) /// 118
(line DayCasMeRaA01S00U20210531T date, sort lcolor(red)) /// 119
(line DayCasMeRaA01S00U20210601T date, sort lcolor(red)) /// 120
(line DayCasMeRaA01S00U20210602T date, sort lcolor(red)) /// 121
(line DayCasMeRaA01S00U20210603T date, sort lcolor(red)) /// 122
(line DayCasMeRaA01S00U20210604T date, sort lcolor(red)) /// 123
(line DayCasMeRaA01S00U20210605T date, sort lcolor(red)) /// 124
(line DayCasMeRaA01S00U20210606T date, sort lcolor(red)) /// 125
(line DayCasMeRaA01S00U20210607T date, sort lcolor(red)) /// 126
(line DayCasMeRaA01S00U20210608T date, sort lcolor(red)) /// 127
(line DayCasMeRaA01S00U20210609T date, sort lcolor(red)) /// 128
(line DayCasMeRaA01S00U20210610T date, sort lcolor(red)) /// 129
(line DayCasMeRaA01S00U20210611T date, sort lcolor(red)) /// 130
(line DayCasMeRaA01S00U20210612T date, sort lcolor(red)) /// 131
(line DayCasMeRaA01S00U20210613T date, sort lcolor(red)) /// 132
(line DayCasMeRaA01S00U20210614T date, sort lcolor(red)) /// 133
(line DayCasMeRaA01S00U20210615T date, sort lcolor(red)) /// 134
(line DayCasMeRaA01S00U20210616T date, sort lcolor(red)) /// 135
(line DayCasMeRaA01S00U20210617T date, sort lcolor(red)) /// 136
(line DayCasMeRaA01S00U20210618T date, sort lcolor(red)) /// 137
(line DayCasMeRaA01S00U20210619T date, sort lcolor(red)) /// 138
(line DayCasMeRaA01S00U20210620T date, sort lcolor(red)) /// 139
(line DayCasMeRaA01S00U20210621T date, sort lcolor(red)) /// 140
(line DayCasMeRaA01S00U20210622T date, sort lcolor(red)) /// 141
(line DayCasMeRaA01S00U20210623T date, sort lcolor(red)) /// 142
(line DayCasMeRaA01S00U20210624T date, sort lcolor(red)) /// 143
(line DayCasMeRaA01S00U20210625T date, sort lcolor(red)) /// 144
(line DayCasMeRaA01S00U20210626T date, sort lcolor(red)) /// 145
(line DayCasMeRaA01S00U20210627T date, sort lcolor(red)) /// 146
(line DayCasMeRaA01S00U20210628T date, sort lcolor(red)) /// 147
(line DayCasMeRaA01S00U20210629T date, sort lcolor(red)) /// 148
(line DayCasMeRaA01S00U20210630T date, sort lcolor(red)) /// 149
(line DayCasMeRaA01S00U20210701T date, sort lcolor(red)) /// 150
(line DayCasMeRaA01S00U20210702T date, sort lcolor(red)) /// 151
(line DayCasMeRaA01S00U20210703T date, sort lcolor(red)) /// 152
(line DayCasMeRaA01S00U20210704T date, sort lcolor(red)) /// 153
(line DayCasMeRaA01S00U20210705T date, sort lcolor(red)) /// 154
(line DayCasMeRaA01S00U20210706T date, sort lcolor(red)) /// 155
(line DayCasMeRaA01S00U20210707T date, sort lcolor(red)) /// 156
(line DayCasMeRaA01S00U20210708T date, sort lcolor(red)) /// 157
(line DayCasMeRaA01S00U20210709T date, sort lcolor(red)) /// 158
(line DayCasMeRaA01S00U20210710T date, sort lcolor(red)) /// 159
(line DayCasMeRaA01S00U20210711T date, sort lcolor(red)) /// 160
(line DayCasMeRaA01S00U20210712T date, sort lcolor(red)) /// 161
(line DayCasMeRaA01S00U20210713T date, sort lcolor(red)) /// 162
(line DayCasMeRaA01S00U20210714T date, sort lcolor(red)) /// 163
(line DayCasMeRaA01S00U20210715T date, sort lcolor(red)) /// 164
(line DayCasMeRaA01S00U20210716T date, sort lcolor(red)) /// 165
(line DayCasMeRaA01S00U20210717T date, sort lcolor(red)) /// 166
(line DayCasMeRaA01S00U20210718T date, sort lcolor(red)) /// 167
(line DayCasMeRaA01S00U20210719T date, sort lcolor(red)) /// 168
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases DELP divided by JOHN smooth) title("COVID-19 daily cases, $country, DELP divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 23a COVID-19 daily cases, $country, DELP, Times.gph", replace
qui graph export "graph 23a COVID-19 daily cases, $country, DELP, Times.pdf", replace





*********

* daily cases, Times, together, without extremes 152

twoway  ///
(line DayCasMeRaA01S00U20200723T date, sort lcolor(red) lpattern(dash)) /// 1
(line DayCasMeRaA01S00U20200919T date, sort lcolor(red) lpattern(dash)) /// 2
(line DayCasMeRaA01S00U20200926T date, sort lcolor(red) lpattern(dash)) /// 3
(line DayCasMeRaA01S00U20201001T date, sort lcolor(red) lpattern(dash)) /// 4
(line DayCasMeRaA01S00U20201008T date, sort lcolor(red) lpattern(dash)) /// 5
(line DayCasMeRaA01S00U20201015T date, sort lcolor(red) lpattern(dash)) /// 6
(line DayCasMeRaA01S00U20201022T date, sort lcolor(red) lpattern(dash)) /// 7
(line DayCasMeRaA01S00U20201029T date, sort lcolor(red) lpattern(dash)) /// 8
(line DayCasMeRaA01S00U20201105T date, sort lcolor(red) lpattern(dash)) /// 9
(line DayCasMeRaA01S00U20201112T date, sort lcolor(red) lpattern(dash)) /// 10
(line DayCasMeRaA01S00U20201119T date, sort lcolor(red)) /// 11
(line DayCasMeRaA01S00U20201126T date, sort lcolor(red)) /// 12
(line DayCasMeRaA01S00U20201203T date, sort lcolor(red)) /// 13
(line DayCasMeRaA01S00U20201210T date, sort lcolor(red)) /// 14
(line DayCasMeRaA01S00U20201217T date, sort lcolor(red)) /// 15
(line DayCasMeRaA01S00U20201224T date, sort lcolor(red)) /// 16
(line DayCasMeRaA01S00U20201231T date, sort lcolor(red)) /// 17
(line DayCasMeRaA01S00U20210107T date, sort lcolor(red)) /// 18
(line DayCasMeRaA01S00U20210114T date, sort lcolor(red)) /// 19
(line DayCasMeRaA01S00U20210121T date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210303T date, sort lcolor(red)) /// 21
(line DayCasMeRaA01S00U20210304T date, sort lcolor(red)) /// 22
(line DayCasMeRaA01S00U20210305T date, sort lcolor(red)) /// 23
(line DayCasMeRaA01S00U20210306T date, sort lcolor(red)) /// 24
(line DayCasMeRaA01S00U20210307T date, sort lcolor(red)) /// 25
(line DayCasMeRaA01S00U20210308T date, sort lcolor(red)) /// 26
(line DayCasMeRaA01S00U20210309T date, sort lcolor(red)) /// 27
(line DayCasMeRaA01S00U20210310T date, sort lcolor(red)) /// 28
(line DayCasMeRaA01S00U20210311T date, sort lcolor(red)) /// 29
(line DayCasMeRaA01S00U20210312T date, sort lcolor(red)) /// 30
(line DayCasMeRaA01S00U20210313T date, sort lcolor(red)) /// 31
(line DayCasMeRaA01S00U20210314T date, sort lcolor(red)) /// 32
(line DayCasMeRaA01S00U20210315T date, sort lcolor(red)) /// 33
(line DayCasMeRaA01S00U20210316T date, sort lcolor(red)) /// 34
(line DayCasMeRaA01S00U20210317T date, sort lcolor(red)) /// 35
(line DayCasMeRaA01S00U20210318T date, sort lcolor(red)) /// 36
(line DayCasMeRaA01S00U20210319T date, sort lcolor(red)) /// 37
(line DayCasMeRaA01S00U20210320T date, sort lcolor(red)) /// 38
(line DayCasMeRaA01S00U20210321T date, sort lcolor(red)) /// 39
(line DayCasMeRaA01S00U20210322T date, sort lcolor(red)) /// 40
(line DayCasMeRaA01S00U20210323T date, sort lcolor(red)) /// 41
(line DayCasMeRaA01S00U20210324T date, sort lcolor(red)) /// 42
(line DayCasMeRaA01S00U20210325T date, sort lcolor(red)) /// 43
(line DayCasMeRaA01S00U20210326T date, sort lcolor(red)) /// 44
(line DayCasMeRaA01S00U20210327T date, sort lcolor(red)) /// 45
(line DayCasMeRaA01S00U20210328T date, sort lcolor(red)) /// 46
(line DayCasMeRaA01S00U20210329T date, sort lcolor(red)) /// 47
(line DayCasMeRaA01S00U20210330T date, sort lcolor(red)) /// 48
(line DayCasMeRaA01S00U20210331T date, sort lcolor(red)) /// 49
(line DayCasMeRaA01S00U20210401T date, sort lcolor(red)) /// 50
(line DayCasMeRaA01S00U20210402T date, sort lcolor(red)) /// 51
(line DayCasMeRaA01S00U20210403T date, sort lcolor(red)) /// 52
(line DayCasMeRaA01S00U20210404T date, sort lcolor(red)) /// 53
(line DayCasMeRaA01S00U20210405T date, sort lcolor(red)) /// 54
(line DayCasMeRaA01S00U20210406T date, sort lcolor(red)) /// 55
(line DayCasMeRaA01S00U20210407T date, sort lcolor(red)) /// 56
(line DayCasMeRaA01S00U20210408T date, sort lcolor(red)) /// 57
(line DayCasMeRaA01S00U20210409T date, sort lcolor(red)) /// 58
(line DayCasMeRaA01S00U20210410T date, sort lcolor(red)) /// 59
(line DayCasMeRaA01S00U20210411T date, sort lcolor(red)) /// 60
(line DayCasMeRaA01S00U20210412T date, sort lcolor(red)) /// 61
(line DayCasMeRaA01S00U20210413T date, sort lcolor(red)) /// 62
(line DayCasMeRaA01S00U20210414T date, sort lcolor(red)) /// 63
(line DayCasMeRaA01S00U20210415T date, sort lcolor(red)) /// 64
(line DayCasMeRaA01S00U20210416T date, sort lcolor(red)) /// 65
(line DayCasMeRaA01S00U20210417T date, sort lcolor(red)) /// 66
(line DayCasMeRaA01S00U20210418T date, sort lcolor(red)) /// 67
(line DayCasMeRaA01S00U20210419T date, sort lcolor(red)) /// 68
(line DayCasMeRaA01S00U20210420T date, sort lcolor(red)) /// 69
(line DayCasMeRaA01S00U20210421T date, sort lcolor(red)) /// 70
(line DayCasMeRaA01S00U20210422T date, sort lcolor(red)) /// 71
(line DayCasMeRaA01S00U20210423T date, sort lcolor(red)) /// 72
(line DayCasMeRaA01S00U20210424T date, sort lcolor(red)) /// 73
(line DayCasMeRaA01S00U20210425T date, sort lcolor(red)) /// 74
(line DayCasMeRaA01S00U20210426T date, sort lcolor(red)) /// 75
(line DayCasMeRaA01S00U20210427T date, sort lcolor(red)) /// 76
(line DayCasMeRaA01S00U20210428T date, sort lcolor(red)) /// 77
(line DayCasMeRaA01S00U20210429T date, sort lcolor(red)) /// 78
(line DayCasMeRaA01S00U20210430T date, sort lcolor(red)) /// 79
(line DayCasMeRaA01S00U20210501T date, sort lcolor(red)) /// 80
(line DayCasMeRaA01S00U20210502T date, sort lcolor(red)) /// 81
(line DayCasMeRaA01S00U20210503T date, sort lcolor(red)) /// 82
(line DayCasMeRaA01S00U20210504T date, sort lcolor(red)) /// 83
(line DayCasMeRaA01S00U20210505T date, sort lcolor(red)) /// 84
(line DayCasMeRaA01S00U20210506T date, sort lcolor(red)) /// 85
(line DayCasMeRaA01S00U20210507T date, sort lcolor(red)) /// 86
(line DayCasMeRaA01S00U20210508T date, sort lcolor(red)) /// 87
(line DayCasMeRaA01S00U20210509T date, sort lcolor(red)) /// 88
(line DayCasMeRaA01S00U20210510T date, sort lcolor(red)) /// 89
(line DayCasMeRaA01S00U20210511T date, sort lcolor(red)) /// 90
(line DayCasMeRaA01S00U20210512T date, sort lcolor(red)) /// 91
(line DayCasMeRaA01S00U20210513T date, sort lcolor(red)) /// 92
(line DayCasMeRaA01S00U20210514T date, sort lcolor(red)) /// 93
(line DayCasMeRaA01S00U20210515T date, sort lcolor(red)) /// 94
(line DayCasMeRaA01S00U20210516T date, sort lcolor(red)) /// 95
(line DayCasMeRaA01S00U20210517T date, sort lcolor(red)) /// 96
(line DayCasMeRaA01S00U20210518T date, sort lcolor(red)) /// 97
(line DayCasMeRaA01S00U20210519T date, sort lcolor(red)) /// 98
(line DayCasMeRaA01S00U20210520T date, sort lcolor(red)) /// 99
(line DayCasMeRaA01S00U20210521T date, sort lcolor(red)) /// 100
(line DayCasMeRaA01S00U20210522T date, sort lcolor(red)) /// 101
(line DayCasMeRaA01S00U20210530T date, sort lcolor(red)) /// 102
(line DayCasMeRaA01S00U20210531T date, sort lcolor(red)) /// 103
(line DayCasMeRaA01S00U20210601T date, sort lcolor(red)) /// 104
(line DayCasMeRaA01S00U20210602T date, sort lcolor(red)) /// 105
(line DayCasMeRaA01S00U20210603T date, sort lcolor(red)) /// 106
(line DayCasMeRaA01S00U20210604T date, sort lcolor(red)) /// 107
(line DayCasMeRaA01S00U20210605T date, sort lcolor(red)) /// 108
(line DayCasMeRaA01S00U20210606T date, sort lcolor(red)) /// 109
(line DayCasMeRaA01S00U20210607T date, sort lcolor(red)) /// 110
(line DayCasMeRaA01S00U20210608T date, sort lcolor(red)) /// 111
(line DayCasMeRaA01S00U20210609T date, sort lcolor(red)) /// 112
(line DayCasMeRaA01S00U20210610T date, sort lcolor(red)) /// 113
(line DayCasMeRaA01S00U20210611T date, sort lcolor(red)) /// 114
(line DayCasMeRaA01S00U20210612T date, sort lcolor(red)) /// 115
(line DayCasMeRaA01S00U20210613T date, sort lcolor(red)) /// 116
(line DayCasMeRaA01S00U20210614T date, sort lcolor(red)) /// 117
(line DayCasMeRaA01S00U20210615T date, sort lcolor(red)) /// 118
(line DayCasMeRaA01S00U20210616T date, sort lcolor(red)) /// 119
(line DayCasMeRaA01S00U20210617T date, sort lcolor(red)) /// 120
(line DayCasMeRaA01S00U20210618T date, sort lcolor(red)) /// 121
(line DayCasMeRaA01S00U20210619T date, sort lcolor(red)) /// 122
(line DayCasMeRaA01S00U20210620T date, sort lcolor(red)) /// 123
(line DayCasMeRaA01S00U20210621T date, sort lcolor(red)) /// 124
(line DayCasMeRaA01S00U20210622T date, sort lcolor(red)) /// 125
(line DayCasMeRaA01S00U20210623T date, sort lcolor(red)) /// 126
(line DayCasMeRaA01S00U20210624T date, sort lcolor(red)) /// 127
(line DayCasMeRaA01S00U20210625T date, sort lcolor(red)) /// 128
(line DayCasMeRaA01S00U20210626T date, sort lcolor(red)) /// 129
(line DayCasMeRaA01S00U20210627T date, sort lcolor(red)) /// 130
(line DayCasMeRaA01S00U20210628T date, sort lcolor(red)) /// 131
(line DayCasMeRaA01S00U20210629T date, sort lcolor(red)) /// 132
(line DayCasMeRaA01S00U20210630T date, sort lcolor(red)) /// 133
(line DayCasMeRaA01S00U20210701T date, sort lcolor(red)) /// 134
(line DayCasMeRaA01S00U20210702T date, sort lcolor(red)) /// 135
(line DayCasMeRaA01S00U20210703T date, sort lcolor(red)) /// 136
(line DayCasMeRaA01S00U20210704T date, sort lcolor(red)) /// 137
(line DayCasMeRaA01S00U20210705T date, sort lcolor(red)) /// 138
(line DayCasMeRaA01S00U20210706T date, sort lcolor(red)) /// 139
(line DayCasMeRaA01S00U20210707T date, sort lcolor(red)) /// 140
(line DayCasMeRaA01S00U20210708T date, sort lcolor(red)) /// 141
(line DayCasMeRaA01S00U20210709T date, sort lcolor(red)) /// 142
(line DayCasMeRaA01S00U20210710T date, sort lcolor(red)) /// 143
(line DayCasMeRaA01S00U20210711T date, sort lcolor(red)) /// 144
(line DayCasMeRaA01S00U20210712T date, sort lcolor(red)) /// 145
(line DayCasMeRaA01S00U20210713T date, sort lcolor(red)) /// 146
(line DayCasMeRaA01S00U20210714T date, sort lcolor(red)) /// 147
(line DayCasMeRaA01S00U20210715T date, sort lcolor(red)) /// 148
(line DayCasMeRaA01S00U20210716T date, sort lcolor(red)) /// 149
(line DayCasMeRaA01S00U20210717T date, sort lcolor(red)) /// 150
(line DayCasMeRaA01S00U20210718T date, sort lcolor(red)) /// 151
(line DayCasMeRaA01S00U20210719T date, sort lcolor(red)) /// 152
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases DELP divided by JOHN smooth) title("COVID-19 daily cases, $country, DELP divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; without extremes i.e. > 2 times max reported 50,000", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 23b COVID-19 daily cases, $country, DELP, wo extreme, Times.gph", replace
qui graph export "graph 23b COVID-19 daily cases, $country, DELP, wo extreme, Times.pdf", replace






*********

* daily cases, Percent, together, with extremes 168

twoway  ///
(line DayCasMeRaA01S00U20200723P date, sort lcolor(red) lpattern(dash)) /// 1
(line DayCasMeRaA01S00U20200919P date, sort lcolor(red) lpattern(dash)) /// 2
(line DayCasMeRaA01S00U20200926P date, sort lcolor(red) lpattern(dash)) /// 3
(line DayCasMeRaA01S00U20201001P date, sort lcolor(red) lpattern(dash)) /// 4
(line DayCasMeRaA01S00U20201008P date, sort lcolor(red) lpattern(dash)) /// 5
(line DayCasMeRaA01S00U20201015P date, sort lcolor(red) lpattern(dash)) /// 6
(line DayCasMeRaA01S00U20201022P date, sort lcolor(red) lpattern(dash)) /// 7
(line DayCasMeRaA01S00U20201029P date, sort lcolor(red) lpattern(dash)) /// 8
(line DayCasMeRaA01S00U20201105P date, sort lcolor(red) lpattern(dash)) /// 9
(line DayCasMeRaA01S00U20201112P date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line DayCasMeRaA01S00U20201119P date, sort lcolor(red)) /// 11 v4
(line DayCasMeRaA01S00U20201126P date, sort lcolor(red)) /// 12
(line DayCasMeRaA01S00U20201203P date, sort lcolor(red)) /// 13
(line DayCasMeRaA01S00U20201210P date, sort lcolor(red)) /// 14
(line DayCasMeRaA01S00U20201217P date, sort lcolor(red)) /// 15
(line DayCasMeRaA01S00U20201224P date, sort lcolor(red)) /// 16
(line DayCasMeRaA01S00U20201231P date, sort lcolor(red)) /// 17
(line DayCasMeRaA01S00U20210107P date, sort lcolor(red)) /// 18
(line DayCasMeRaA01S00U20210114P date, sort lcolor(red)) /// 19
(line DayCasMeRaA01S00U20210121P date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210128P date, sort lcolor(red)) /// 21
(line DayCasMeRaA01S00U20210204P date, sort lcolor(red)) /// 22
(line DayCasMeRaA01S00U20210211P date, sort lcolor(red)) /// 23
(line DayCasMeRaA01S00U20210218P date, sort lcolor(red)) /// 24
(line DayCasMeRaA01S00U20210225P date, sort lcolor(red)) /// 25
(line DayCasMeRaA01S00U20210226P date, sort lcolor(red)) /// 26
(line DayCasMeRaA01S00U20210227P date, sort lcolor(red)) /// 27
(line DayCasMeRaA01S00U20210228P date, sort lcolor(red)) /// 28
(line DayCasMeRaA01S00U20210301P date, sort lcolor(red)) /// 29
(line DayCasMeRaA01S00U20210303P date, sort lcolor(red)) /// 30
(line DayCasMeRaA01S00U20210304P date, sort lcolor(red)) /// 31
(line DayCasMeRaA01S00U20210305P date, sort lcolor(red)) /// 32
(line DayCasMeRaA01S00U20210306P date, sort lcolor(red)) /// 33
(line DayCasMeRaA01S00U20210307P date, sort lcolor(red)) /// 34
(line DayCasMeRaA01S00U20210308P date, sort lcolor(red)) /// 35
(line DayCasMeRaA01S00U20210309P date, sort lcolor(red)) /// 36
(line DayCasMeRaA01S00U20210310P date, sort lcolor(red)) /// 37
(line DayCasMeRaA01S00U20210311P date, sort lcolor(red)) /// 38
(line DayCasMeRaA01S00U20210312P date, sort lcolor(red)) /// 39
(line DayCasMeRaA01S00U20210313P date, sort lcolor(red)) /// 40
(line DayCasMeRaA01S00U20210314P date, sort lcolor(red)) /// 41
(line DayCasMeRaA01S00U20210315P date, sort lcolor(red)) /// 42
(line DayCasMeRaA01S00U20210316P date, sort lcolor(red)) /// 43
(line DayCasMeRaA01S00U20210317P date, sort lcolor(red)) /// 44
(line DayCasMeRaA01S00U20210318P date, sort lcolor(red)) /// 45
(line DayCasMeRaA01S00U20210319P date, sort lcolor(red)) /// 46
(line DayCasMeRaA01S00U20210320P date, sort lcolor(red)) /// 47
(line DayCasMeRaA01S00U20210321P date, sort lcolor(red)) /// 48
(line DayCasMeRaA01S00U20210322P date, sort lcolor(red)) /// 49
(line DayCasMeRaA01S00U20210323P date, sort lcolor(red)) /// 50
(line DayCasMeRaA01S00U20210324P date, sort lcolor(red)) /// 51
(line DayCasMeRaA01S00U20210325P date, sort lcolor(red)) /// 52
(line DayCasMeRaA01S00U20210326P date, sort lcolor(red)) /// 53
(line DayCasMeRaA01S00U20210327P date, sort lcolor(red)) /// 54
(line DayCasMeRaA01S00U20210328P date, sort lcolor(red)) /// 55
(line DayCasMeRaA01S00U20210329P date, sort lcolor(red)) /// 56
(line DayCasMeRaA01S00U20210330P date, sort lcolor(red)) /// 57
(line DayCasMeRaA01S00U20210331P date, sort lcolor(red)) /// 58
(line DayCasMeRaA01S00U20210401P date, sort lcolor(red)) /// 59
(line DayCasMeRaA01S00U20210402P date, sort lcolor(red)) /// 60
(line DayCasMeRaA01S00U20210403P date, sort lcolor(red)) /// 61
(line DayCasMeRaA01S00U20210404P date, sort lcolor(red)) /// 62
(line DayCasMeRaA01S00U20210405P date, sort lcolor(red)) /// 63
(line DayCasMeRaA01S00U20210406P date, sort lcolor(red)) /// 64
(line DayCasMeRaA01S00U20210407P date, sort lcolor(red)) /// 65
(line DayCasMeRaA01S00U20210408P date, sort lcolor(red)) /// 66
(line DayCasMeRaA01S00U20210409P date, sort lcolor(red)) /// 67
(line DayCasMeRaA01S00U20210410P date, sort lcolor(red)) /// 68
(line DayCasMeRaA01S00U20210411P date, sort lcolor(red)) /// 69
(line DayCasMeRaA01S00U20210412P date, sort lcolor(red)) /// 70
(line DayCasMeRaA01S00U20210413P date, sort lcolor(red)) /// 71
(line DayCasMeRaA01S00U20210414P date, sort lcolor(red)) /// 72
(line DayCasMeRaA01S00U20210415P date, sort lcolor(red)) /// 73
(line DayCasMeRaA01S00U20210416P date, sort lcolor(red)) /// 74
(line DayCasMeRaA01S00U20210417P date, sort lcolor(red)) /// 75
(line DayCasMeRaA01S00U20210418P date, sort lcolor(red)) /// 76
(line DayCasMeRaA01S00U20210419P date, sort lcolor(red)) /// 77
(line DayCasMeRaA01S00U20210420P date, sort lcolor(red)) /// 78
(line DayCasMeRaA01S00U20210421P date, sort lcolor(red)) /// 79
(line DayCasMeRaA01S00U20210422P date, sort lcolor(red)) /// 80
(line DayCasMeRaA01S00U20210423P date, sort lcolor(red)) /// 81
(line DayCasMeRaA01S00U20210424P date, sort lcolor(red)) /// 82
(line DayCasMeRaA01S00U20210425P date, sort lcolor(red)) /// 83
(line DayCasMeRaA01S00U20210426P date, sort lcolor(red)) /// 84
(line DayCasMeRaA01S00U20210427P date, sort lcolor(red)) /// 85
(line DayCasMeRaA01S00U20210428P date, sort lcolor(red)) /// 86
(line DayCasMeRaA01S00U20210429P date, sort lcolor(red)) /// 87
(line DayCasMeRaA01S00U20210430P date, sort lcolor(red)) /// 88
(line DayCasMeRaA01S00U20210501P date, sort lcolor(red)) /// 89
(line DayCasMeRaA01S00U20210502P date, sort lcolor(red)) /// 90
(line DayCasMeRaA01S00U20210503P date, sort lcolor(red)) /// 91
(line DayCasMeRaA01S00U20210504P date, sort lcolor(red)) /// 92
(line DayCasMeRaA01S00U20210505P date, sort lcolor(red)) /// 93
(line DayCasMeRaA01S00U20210506P date, sort lcolor(red)) /// 94
(line DayCasMeRaA01S00U20210507P date, sort lcolor(red)) /// 95
(line DayCasMeRaA01S00U20210508P date, sort lcolor(red)) /// 96
(line DayCasMeRaA01S00U20210509P date, sort lcolor(red)) /// 97
(line DayCasMeRaA01S00U20210510P date, sort lcolor(red)) /// 98
(line DayCasMeRaA01S00U20210511P date, sort lcolor(red)) /// 99
(line DayCasMeRaA01S00U20210512P date, sort lcolor(red)) /// 100
(line DayCasMeRaA01S00U20210513P date, sort lcolor(red)) /// 101
(line DayCasMeRaA01S00U20210514P date, sort lcolor(red)) /// 102
(line DayCasMeRaA01S00U20210515P date, sort lcolor(red)) /// 103
(line DayCasMeRaA01S00U20210516P date, sort lcolor(red)) /// 104
(line DayCasMeRaA01S00U20210517P date, sort lcolor(red)) /// 105
(line DayCasMeRaA01S00U20210518P date, sort lcolor(red)) /// 106
(line DayCasMeRaA01S00U20210519P date, sort lcolor(red)) /// 107
(line DayCasMeRaA01S00U20210520P date, sort lcolor(red)) /// 108
(line DayCasMeRaA01S00U20210521P date, sort lcolor(red)) /// 109
(line DayCasMeRaA01S00U20210522P date, sort lcolor(red)) /// 110
(line DayCasMeRaA01S00U20210523P date, sort lcolor(red)) /// 111
(line DayCasMeRaA01S00U20210524P date, sort lcolor(red)) /// 112
(line DayCasMeRaA01S00U20210525P date, sort lcolor(red)) /// 113
(line DayCasMeRaA01S00U20210526P date, sort lcolor(red)) /// 114
(line DayCasMeRaA01S00U20210527P date, sort lcolor(red)) /// 115
(line DayCasMeRaA01S00U20210528P date, sort lcolor(red)) /// 116
(line DayCasMeRaA01S00U20210529P date, sort lcolor(red)) /// 117
(line DayCasMeRaA01S00U20210530P date, sort lcolor(red)) /// 118
(line DayCasMeRaA01S00U20210531P date, sort lcolor(red)) /// 119
(line DayCasMeRaA01S00U20210601P date, sort lcolor(red)) /// 120
(line DayCasMeRaA01S00U20210602P date, sort lcolor(red)) /// 121
(line DayCasMeRaA01S00U20210603P date, sort lcolor(red)) /// 122
(line DayCasMeRaA01S00U20210604P date, sort lcolor(red)) /// 123
(line DayCasMeRaA01S00U20210605P date, sort lcolor(red)) /// 124
(line DayCasMeRaA01S00U20210606P date, sort lcolor(red)) /// 125
(line DayCasMeRaA01S00U20210607P date, sort lcolor(red)) /// 126
(line DayCasMeRaA01S00U20210608P date, sort lcolor(red)) /// 127
(line DayCasMeRaA01S00U20210609P date, sort lcolor(red)) /// 128
(line DayCasMeRaA01S00U20210610P date, sort lcolor(red)) /// 129
(line DayCasMeRaA01S00U20210611P date, sort lcolor(red)) /// 130
(line DayCasMeRaA01S00U20210612P date, sort lcolor(red)) /// 131
(line DayCasMeRaA01S00U20210613P date, sort lcolor(red)) /// 132
(line DayCasMeRaA01S00U20210614P date, sort lcolor(red)) /// 133
(line DayCasMeRaA01S00U20210615P date, sort lcolor(red)) /// 134
(line DayCasMeRaA01S00U20210616P date, sort lcolor(red)) /// 135
(line DayCasMeRaA01S00U20210617P date, sort lcolor(red)) /// 136
(line DayCasMeRaA01S00U20210618P date, sort lcolor(red)) /// 137
(line DayCasMeRaA01S00U20210619P date, sort lcolor(red)) /// 138
(line DayCasMeRaA01S00U20210620P date, sort lcolor(red)) /// 139
(line DayCasMeRaA01S00U20210621P date, sort lcolor(red)) /// 140
(line DayCasMeRaA01S00U20210622P date, sort lcolor(red)) /// 141
(line DayCasMeRaA01S00U20210623P date, sort lcolor(red)) /// 142
(line DayCasMeRaA01S00U20210624P date, sort lcolor(red)) /// 143
(line DayCasMeRaA01S00U20210625P date, sort lcolor(red)) /// 144
(line DayCasMeRaA01S00U20210626P date, sort lcolor(red)) /// 145
(line DayCasMeRaA01S00U20210627P date, sort lcolor(red)) /// 146
(line DayCasMeRaA01S00U20210628P date, sort lcolor(red)) /// 147
(line DayCasMeRaA01S00U20210629P date, sort lcolor(red)) /// 148
(line DayCasMeRaA01S00U20210630P date, sort lcolor(red)) /// 149
(line DayCasMeRaA01S00U20210701P date, sort lcolor(red)) /// 150
(line DayCasMeRaA01S00U20210702P date, sort lcolor(red)) /// 151
(line DayCasMeRaA01S00U20210703P date, sort lcolor(red)) /// 152
(line DayCasMeRaA01S00U20210704P date, sort lcolor(red)) /// 153
(line DayCasMeRaA01S00U20210705P date, sort lcolor(red)) /// 154
(line DayCasMeRaA01S00U20210706P date, sort lcolor(red)) /// 155
(line DayCasMeRaA01S00U20210707P date, sort lcolor(red)) /// 156
(line DayCasMeRaA01S00U20210708P date, sort lcolor(red)) /// 157
(line DayCasMeRaA01S00U20210709P date, sort lcolor(red)) /// 158
(line DayCasMeRaA01S00U20210710P date, sort lcolor(red)) /// 159
(line DayCasMeRaA01S00U20210711P date, sort lcolor(red)) /// 160
(line DayCasMeRaA01S00U20210712P date, sort lcolor(red)) /// 161
(line DayCasMeRaA01S00U20210713P date, sort lcolor(red)) /// 162
(line DayCasMeRaA01S00U20210714P date, sort lcolor(red)) /// 163
(line DayCasMeRaA01S00U20210715P date, sort lcolor(red)) /// 164
(line DayCasMeRaA01S00U20210716P date, sort lcolor(red)) /// 165
(line DayCasMeRaA01S00U20210717P date, sort lcolor(red)) /// 166
(line DayCasMeRaA01S00U20210718P date, sort lcolor(red)) /// 167
(line DayCasMeRaA01S00U20210719P date, sort lcolor(red)) /// 168
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases DELP percent JOHN smooth) title("COVID-19 daily cases, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 24a COVID-19 daily cases, $country, DELP, Percent.gph", replace
qui graph export "graph 24a COVID-19 daily cases, $country, DELP, Percent.pdf", replace





*********

* daily cases, Percent, together, without extremes 152

twoway  ///
(line DayCasMeRaA01S00U20200723P date, sort lcolor(red) lpattern(dash)) /// 1
(line DayCasMeRaA01S00U20200919P date, sort lcolor(red) lpattern(dash)) /// 2
(line DayCasMeRaA01S00U20200926P date, sort lcolor(red) lpattern(dash)) /// 3
(line DayCasMeRaA01S00U20201001P date, sort lcolor(red) lpattern(dash)) /// 4
(line DayCasMeRaA01S00U20201008P date, sort lcolor(red) lpattern(dash)) /// 5
(line DayCasMeRaA01S00U20201015P date, sort lcolor(red) lpattern(dash)) /// 6
(line DayCasMeRaA01S00U20201022P date, sort lcolor(red) lpattern(dash)) /// 7
(line DayCasMeRaA01S00U20201029P date, sort lcolor(red) lpattern(dash)) /// 8
(line DayCasMeRaA01S00U20201105P date, sort lcolor(red) lpattern(dash)) /// 9
(line DayCasMeRaA01S00U20201112P date, sort lcolor(red) lpattern(dash)) /// 10
(line DayCasMeRaA01S00U20201119P date, sort lcolor(red)) /// 11
(line DayCasMeRaA01S00U20201126P date, sort lcolor(red)) /// 12
(line DayCasMeRaA01S00U20201203P date, sort lcolor(red)) /// 13
(line DayCasMeRaA01S00U20201210P date, sort lcolor(red)) /// 14
(line DayCasMeRaA01S00U20201217P date, sort lcolor(red)) /// 15
(line DayCasMeRaA01S00U20201224P date, sort lcolor(red)) /// 16
(line DayCasMeRaA01S00U20201231P date, sort lcolor(red)) /// 17
(line DayCasMeRaA01S00U20210107P date, sort lcolor(red)) /// 18
(line DayCasMeRaA01S00U20210114P date, sort lcolor(red)) /// 19
(line DayCasMeRaA01S00U20210121P date, sort lcolor(red)) /// 20
(line DayCasMeRaA01S00U20210303P date, sort lcolor(red)) /// 21
(line DayCasMeRaA01S00U20210304P date, sort lcolor(red)) /// 22
(line DayCasMeRaA01S00U20210305P date, sort lcolor(red)) /// 23
(line DayCasMeRaA01S00U20210306P date, sort lcolor(red)) /// 24
(line DayCasMeRaA01S00U20210307P date, sort lcolor(red)) /// 25
(line DayCasMeRaA01S00U20210308P date, sort lcolor(red)) /// 26
(line DayCasMeRaA01S00U20210309P date, sort lcolor(red)) /// 27
(line DayCasMeRaA01S00U20210310P date, sort lcolor(red)) /// 28
(line DayCasMeRaA01S00U20210311P date, sort lcolor(red)) /// 29
(line DayCasMeRaA01S00U20210312P date, sort lcolor(red)) /// 30
(line DayCasMeRaA01S00U20210313P date, sort lcolor(red)) /// 31
(line DayCasMeRaA01S00U20210314P date, sort lcolor(red)) /// 32
(line DayCasMeRaA01S00U20210315P date, sort lcolor(red)) /// 33
(line DayCasMeRaA01S00U20210316P date, sort lcolor(red)) /// 34
(line DayCasMeRaA01S00U20210317P date, sort lcolor(red)) /// 35
(line DayCasMeRaA01S00U20210318P date, sort lcolor(red)) /// 36
(line DayCasMeRaA01S00U20210319P date, sort lcolor(red)) /// 37
(line DayCasMeRaA01S00U20210320P date, sort lcolor(red)) /// 38
(line DayCasMeRaA01S00U20210321P date, sort lcolor(red)) /// 39
(line DayCasMeRaA01S00U20210322P date, sort lcolor(red)) /// 40
(line DayCasMeRaA01S00U20210323P date, sort lcolor(red)) /// 41
(line DayCasMeRaA01S00U20210324P date, sort lcolor(red)) /// 42
(line DayCasMeRaA01S00U20210325P date, sort lcolor(red)) /// 43
(line DayCasMeRaA01S00U20210326P date, sort lcolor(red)) /// 44
(line DayCasMeRaA01S00U20210327P date, sort lcolor(red)) /// 45
(line DayCasMeRaA01S00U20210328P date, sort lcolor(red)) /// 46
(line DayCasMeRaA01S00U20210329P date, sort lcolor(red)) /// 47
(line DayCasMeRaA01S00U20210330P date, sort lcolor(red)) /// 48
(line DayCasMeRaA01S00U20210331P date, sort lcolor(red)) /// 49
(line DayCasMeRaA01S00U20210401P date, sort lcolor(red)) /// 50
(line DayCasMeRaA01S00U20210402P date, sort lcolor(red)) /// 51
(line DayCasMeRaA01S00U20210403P date, sort lcolor(red)) /// 52
(line DayCasMeRaA01S00U20210404P date, sort lcolor(red)) /// 53
(line DayCasMeRaA01S00U20210405P date, sort lcolor(red)) /// 54
(line DayCasMeRaA01S00U20210406P date, sort lcolor(red)) /// 55
(line DayCasMeRaA01S00U20210407P date, sort lcolor(red)) /// 56
(line DayCasMeRaA01S00U20210408P date, sort lcolor(red)) /// 57
(line DayCasMeRaA01S00U20210409P date, sort lcolor(red)) /// 58
(line DayCasMeRaA01S00U20210410P date, sort lcolor(red)) /// 59
(line DayCasMeRaA01S00U20210411P date, sort lcolor(red)) /// 60
(line DayCasMeRaA01S00U20210412P date, sort lcolor(red)) /// 61
(line DayCasMeRaA01S00U20210413P date, sort lcolor(red)) /// 62
(line DayCasMeRaA01S00U20210414P date, sort lcolor(red)) /// 63
(line DayCasMeRaA01S00U20210415P date, sort lcolor(red)) /// 64
(line DayCasMeRaA01S00U20210416P date, sort lcolor(red)) /// 65
(line DayCasMeRaA01S00U20210417P date, sort lcolor(red)) /// 66
(line DayCasMeRaA01S00U20210418P date, sort lcolor(red)) /// 67
(line DayCasMeRaA01S00U20210419P date, sort lcolor(red)) /// 68
(line DayCasMeRaA01S00U20210420P date, sort lcolor(red)) /// 69
(line DayCasMeRaA01S00U20210421P date, sort lcolor(red)) /// 70
(line DayCasMeRaA01S00U20210422P date, sort lcolor(red)) /// 71
(line DayCasMeRaA01S00U20210423P date, sort lcolor(red)) /// 72
(line DayCasMeRaA01S00U20210424P date, sort lcolor(red)) /// 73
(line DayCasMeRaA01S00U20210425P date, sort lcolor(red)) /// 74
(line DayCasMeRaA01S00U20210426P date, sort lcolor(red)) /// 75
(line DayCasMeRaA01S00U20210427P date, sort lcolor(red)) /// 76
(line DayCasMeRaA01S00U20210428P date, sort lcolor(red)) /// 77
(line DayCasMeRaA01S00U20210429P date, sort lcolor(red)) /// 78
(line DayCasMeRaA01S00U20210430P date, sort lcolor(red)) /// 79
(line DayCasMeRaA01S00U20210501P date, sort lcolor(red)) /// 80
(line DayCasMeRaA01S00U20210502P date, sort lcolor(red)) /// 81
(line DayCasMeRaA01S00U20210503P date, sort lcolor(red)) /// 82
(line DayCasMeRaA01S00U20210504P date, sort lcolor(red)) /// 83
(line DayCasMeRaA01S00U20210505P date, sort lcolor(red)) /// 84
(line DayCasMeRaA01S00U20210506P date, sort lcolor(red)) /// 85
(line DayCasMeRaA01S00U20210507P date, sort lcolor(red)) /// 86
(line DayCasMeRaA01S00U20210508P date, sort lcolor(red)) /// 87
(line DayCasMeRaA01S00U20210509P date, sort lcolor(red)) /// 88
(line DayCasMeRaA01S00U20210510P date, sort lcolor(red)) /// 89
(line DayCasMeRaA01S00U20210511P date, sort lcolor(red)) /// 90
(line DayCasMeRaA01S00U20210512P date, sort lcolor(red)) /// 91
(line DayCasMeRaA01S00U20210513P date, sort lcolor(red)) /// 92
(line DayCasMeRaA01S00U20210514P date, sort lcolor(red)) /// 93
(line DayCasMeRaA01S00U20210515P date, sort lcolor(red)) /// 94
(line DayCasMeRaA01S00U20210516P date, sort lcolor(red)) /// 95
(line DayCasMeRaA01S00U20210517P date, sort lcolor(red)) /// 96
(line DayCasMeRaA01S00U20210518P date, sort lcolor(red)) /// 97
(line DayCasMeRaA01S00U20210519P date, sort lcolor(red)) /// 98
(line DayCasMeRaA01S00U20210520P date, sort lcolor(red)) /// 99
(line DayCasMeRaA01S00U20210521P date, sort lcolor(red)) /// 100
(line DayCasMeRaA01S00U20210522P date, sort lcolor(red)) /// 101
(line DayCasMeRaA01S00U20210530P date, sort lcolor(red)) /// 102
(line DayCasMeRaA01S00U20210531P date, sort lcolor(red)) /// 103
(line DayCasMeRaA01S00U20210601P date, sort lcolor(red)) /// 104
(line DayCasMeRaA01S00U20210602P date, sort lcolor(red)) /// 105
(line DayCasMeRaA01S00U20210603P date, sort lcolor(red)) /// 106
(line DayCasMeRaA01S00U20210604P date, sort lcolor(red)) /// 107
(line DayCasMeRaA01S00U20210605P date, sort lcolor(red)) /// 108
(line DayCasMeRaA01S00U20210606P date, sort lcolor(red)) /// 109
(line DayCasMeRaA01S00U20210607P date, sort lcolor(red)) /// 110
(line DayCasMeRaA01S00U20210608P date, sort lcolor(red)) /// 111
(line DayCasMeRaA01S00U20210609P date, sort lcolor(red)) /// 112
(line DayCasMeRaA01S00U20210610P date, sort lcolor(red)) /// 113
(line DayCasMeRaA01S00U20210611P date, sort lcolor(red)) /// 114
(line DayCasMeRaA01S00U20210612P date, sort lcolor(red)) /// 115
(line DayCasMeRaA01S00U20210613P date, sort lcolor(red)) /// 116
(line DayCasMeRaA01S00U20210614P date, sort lcolor(red)) /// 117
(line DayCasMeRaA01S00U20210615P date, sort lcolor(red)) /// 118
(line DayCasMeRaA01S00U20210616P date, sort lcolor(red)) /// 119
(line DayCasMeRaA01S00U20210617P date, sort lcolor(red)) /// 120
(line DayCasMeRaA01S00U20210618P date, sort lcolor(red)) /// 121
(line DayCasMeRaA01S00U20210619P date, sort lcolor(red)) /// 122
(line DayCasMeRaA01S00U20210620P date, sort lcolor(red)) /// 123
(line DayCasMeRaA01S00U20210621P date, sort lcolor(red)) /// 124
(line DayCasMeRaA01S00U20210622P date, sort lcolor(red)) /// 125
(line DayCasMeRaA01S00U20210623P date, sort lcolor(red)) /// 126
(line DayCasMeRaA01S00U20210624P date, sort lcolor(red)) /// 127
(line DayCasMeRaA01S00U20210625P date, sort lcolor(red)) /// 128
(line DayCasMeRaA01S00U20210626P date, sort lcolor(red)) /// 129
(line DayCasMeRaA01S00U20210627P date, sort lcolor(red)) /// 130
(line DayCasMeRaA01S00U20210628P date, sort lcolor(red)) /// 131
(line DayCasMeRaA01S00U20210629P date, sort lcolor(red)) /// 132
(line DayCasMeRaA01S00U20210630P date, sort lcolor(red)) /// 133
(line DayCasMeRaA01S00U20210701P date, sort lcolor(red)) /// 134
(line DayCasMeRaA01S00U20210702P date, sort lcolor(red)) /// 135
(line DayCasMeRaA01S00U20210703P date, sort lcolor(red)) /// 136
(line DayCasMeRaA01S00U20210704P date, sort lcolor(red)) /// 137
(line DayCasMeRaA01S00U20210705P date, sort lcolor(red)) /// 138
(line DayCasMeRaA01S00U20210706P date, sort lcolor(red)) /// 139
(line DayCasMeRaA01S00U20210707P date, sort lcolor(red)) /// 140
(line DayCasMeRaA01S00U20210708P date, sort lcolor(red)) /// 141
(line DayCasMeRaA01S00U20210709P date, sort lcolor(red)) /// 142
(line DayCasMeRaA01S00U20210710P date, sort lcolor(red)) /// 143
(line DayCasMeRaA01S00U20210711P date, sort lcolor(red)) /// 144
(line DayCasMeRaA01S00U20210712P date, sort lcolor(red)) /// 145
(line DayCasMeRaA01S00U20210713P date, sort lcolor(red)) /// 146
(line DayCasMeRaA01S00U20210714P date, sort lcolor(red)) /// 147
(line DayCasMeRaA01S00U20210715P date, sort lcolor(red)) /// 148
(line DayCasMeRaA01S00U20210716P date, sort lcolor(red)) /// 149
(line DayCasMeRaA01S00U20210717P date, sort lcolor(red)) /// 150
(line DayCasMeRaA01S00U20210718P date, sort lcolor(red)) /// 151
(line DayCasMeRaA01S00U20210719P date, sort lcolor(red)) /// 152
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases DELP percent JOHN smooth) title("COVID-19 daily cases, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; without extremes i.e. > 2 times max reported 50,000", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 24b COVID-19 daily cases, $country, DELP, wo extreme, Percent.gph", replace
qui graph export "graph 24b COVID-19 daily cases, $country, DELP, wo extreme, Percent.pdf", replace

















* total deaths

**************************************



* total deaths, Absolute value, individual updates


foreach l of global DELPupdatelist {

twoway  /// 
(line TotDeaMeRaA00S00 date, lcolor(cyan*1.2)) /// 
(line TotDeaMeRaA01S00U`l' date, sort lcolor(red)) /// 
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, DELP, update `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN smooth" 2 "DELP `l'") size(small) rows(1))	

qui graph save "graph 31i COVID-19 total deaths, $country, DELP update `l'.gph", replace
qui graph export "graph 31i COVID-19 total deaths, $country, DELP update `l'.pdf", replace

}
*





* total deaths, Absolute value, together, with extremes 168

twoway  ///
(line TotDeaMeRaA01S00U20200723 date, sort lcolor(red) lpattern(dash)) /// 1
(line TotDeaMeRaA01S00U20200919 date, sort lcolor(red) lpattern(dash)) /// 2
(line TotDeaMeRaA01S00U20200926 date, sort lcolor(red) lpattern(dash)) /// 3
(line TotDeaMeRaA01S00U20201001 date, sort lcolor(red) lpattern(dash)) /// 4
(line TotDeaMeRaA01S00U20201008 date, sort lcolor(red) lpattern(dash)) /// 5
(line TotDeaMeRaA01S00U20201015 date, sort lcolor(red) lpattern(dash)) /// 6
(line TotDeaMeRaA01S00U20201022 date, sort lcolor(red) lpattern(dash)) /// 7
(line TotDeaMeRaA01S00U20201029 date, sort lcolor(red) lpattern(dash)) /// 8
(line TotDeaMeRaA01S00U20201105 date, sort lcolor(red) lpattern(dash)) /// 9
(line TotDeaMeRaA01S00U20201112 date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line TotDeaMeRaA01S00U20201119 date, sort lcolor(red)) /// 11 v4
(line TotDeaMeRaA01S00U20201126 date, sort lcolor(red)) /// 12
(line TotDeaMeRaA01S00U20201203 date, sort lcolor(red)) /// 13
(line TotDeaMeRaA01S00U20201210 date, sort lcolor(red)) /// 14
(line TotDeaMeRaA01S00U20201217 date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20201224 date, sort lcolor(red)) /// 16
(line TotDeaMeRaA01S00U20201231 date, sort lcolor(red)) /// 17
(line TotDeaMeRaA01S00U20210107 date, sort lcolor(red)) /// 18
(line TotDeaMeRaA01S00U20210114 date, sort lcolor(red)) /// 19
(line TotDeaMeRaA01S00U20210121 date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210128 date, sort lcolor(red)) /// 21
(line TotDeaMeRaA01S00U20210204 date, sort lcolor(red)) /// 22
(line TotDeaMeRaA01S00U20210211 date, sort lcolor(red)) /// 23
(line TotDeaMeRaA01S00U20210218 date, sort lcolor(red)) /// 24
(line TotDeaMeRaA01S00U20210225 date, sort lcolor(red)) /// 25
(line TotDeaMeRaA01S00U20210226 date, sort lcolor(red)) /// 26
(line TotDeaMeRaA01S00U20210227 date, sort lcolor(red)) /// 27
(line TotDeaMeRaA01S00U20210228 date, sort lcolor(red)) /// 28
(line TotDeaMeRaA01S00U20210301 date, sort lcolor(red)) /// 29
(line TotDeaMeRaA01S00U20210303 date, sort lcolor(red)) /// 30
(line TotDeaMeRaA01S00U20210304 date, sort lcolor(red)) /// 31
(line TotDeaMeRaA01S00U20210305 date, sort lcolor(red)) /// 32
(line TotDeaMeRaA01S00U20210306 date, sort lcolor(red)) /// 33
(line TotDeaMeRaA01S00U20210307 date, sort lcolor(red)) /// 34
(line TotDeaMeRaA01S00U20210308 date, sort lcolor(red)) /// 35
(line TotDeaMeRaA01S00U20210309 date, sort lcolor(red)) /// 36
(line TotDeaMeRaA01S00U20210310 date, sort lcolor(red)) /// 37
(line TotDeaMeRaA01S00U20210311 date, sort lcolor(red)) /// 38
(line TotDeaMeRaA01S00U20210312 date, sort lcolor(red)) /// 39
(line TotDeaMeRaA01S00U20210313 date, sort lcolor(red)) /// 40
(line TotDeaMeRaA01S00U20210314 date, sort lcolor(red)) /// 41
(line TotDeaMeRaA01S00U20210315 date, sort lcolor(red)) /// 42
(line TotDeaMeRaA01S00U20210316 date, sort lcolor(red)) /// 43
(line TotDeaMeRaA01S00U20210317 date, sort lcolor(red)) /// 44
(line TotDeaMeRaA01S00U20210318 date, sort lcolor(red)) /// 45
(line TotDeaMeRaA01S00U20210319 date, sort lcolor(red)) /// 46
(line TotDeaMeRaA01S00U20210320 date, sort lcolor(red)) /// 47
(line TotDeaMeRaA01S00U20210321 date, sort lcolor(red)) /// 48
(line TotDeaMeRaA01S00U20210322 date, sort lcolor(red)) /// 49
(line TotDeaMeRaA01S00U20210323 date, sort lcolor(red)) /// 50
(line TotDeaMeRaA01S00U20210324 date, sort lcolor(red)) /// 51
(line TotDeaMeRaA01S00U20210325 date, sort lcolor(red)) /// 52
(line TotDeaMeRaA01S00U20210326 date, sort lcolor(red)) /// 53
(line TotDeaMeRaA01S00U20210327 date, sort lcolor(red)) /// 54
(line TotDeaMeRaA01S00U20210328 date, sort lcolor(red)) /// 55
(line TotDeaMeRaA01S00U20210329 date, sort lcolor(red)) /// 56
(line TotDeaMeRaA01S00U20210330 date, sort lcolor(red)) /// 57
(line TotDeaMeRaA01S00U20210331 date, sort lcolor(red)) /// 58
(line TotDeaMeRaA01S00U20210401 date, sort lcolor(red)) /// 59
(line TotDeaMeRaA01S00U20210402 date, sort lcolor(red)) /// 60
(line TotDeaMeRaA01S00U20210403 date, sort lcolor(red)) /// 61
(line TotDeaMeRaA01S00U20210404 date, sort lcolor(red)) /// 62
(line TotDeaMeRaA01S00U20210405 date, sort lcolor(red)) /// 63
(line TotDeaMeRaA01S00U20210406 date, sort lcolor(red)) /// 64
(line TotDeaMeRaA01S00U20210407 date, sort lcolor(red)) /// 65
(line TotDeaMeRaA01S00U20210408 date, sort lcolor(red)) /// 66
(line TotDeaMeRaA01S00U20210409 date, sort lcolor(red)) /// 67
(line TotDeaMeRaA01S00U20210410 date, sort lcolor(red)) /// 68
(line TotDeaMeRaA01S00U20210411 date, sort lcolor(red)) /// 69
(line TotDeaMeRaA01S00U20210412 date, sort lcolor(red)) /// 70
(line TotDeaMeRaA01S00U20210413 date, sort lcolor(red)) /// 71
(line TotDeaMeRaA01S00U20210414 date, sort lcolor(red)) /// 72
(line TotDeaMeRaA01S00U20210415 date, sort lcolor(red)) /// 73
(line TotDeaMeRaA01S00U20210416 date, sort lcolor(red)) /// 74
(line TotDeaMeRaA01S00U20210417 date, sort lcolor(red)) /// 75
(line TotDeaMeRaA01S00U20210418 date, sort lcolor(red)) /// 76
(line TotDeaMeRaA01S00U20210419 date, sort lcolor(red)) /// 77
(line TotDeaMeRaA01S00U20210420 date, sort lcolor(red)) /// 78
(line TotDeaMeRaA01S00U20210421 date, sort lcolor(red)) /// 79
(line TotDeaMeRaA01S00U20210422 date, sort lcolor(red)) /// 80
(line TotDeaMeRaA01S00U20210423 date, sort lcolor(red)) /// 81
(line TotDeaMeRaA01S00U20210424 date, sort lcolor(red)) /// 82
(line TotDeaMeRaA01S00U20210425 date, sort lcolor(red)) /// 83
(line TotDeaMeRaA01S00U20210426 date, sort lcolor(red)) /// 84
(line TotDeaMeRaA01S00U20210427 date, sort lcolor(red)) /// 85
(line TotDeaMeRaA01S00U20210428 date, sort lcolor(red)) /// 86
(line TotDeaMeRaA01S00U20210429 date, sort lcolor(red)) /// 87
(line TotDeaMeRaA01S00U20210430 date, sort lcolor(red)) /// 88
(line TotDeaMeRaA01S00U20210501 date, sort lcolor(red)) /// 89
(line TotDeaMeRaA01S00U20210502 date, sort lcolor(red)) /// 90
(line TotDeaMeRaA01S00U20210503 date, sort lcolor(red)) /// 91
(line TotDeaMeRaA01S00U20210504 date, sort lcolor(red)) /// 92
(line TotDeaMeRaA01S00U20210505 date, sort lcolor(red)) /// 93
(line TotDeaMeRaA01S00U20210506 date, sort lcolor(red)) /// 94
(line TotDeaMeRaA01S00U20210507 date, sort lcolor(red)) /// 95
(line TotDeaMeRaA01S00U20210508 date, sort lcolor(red)) /// 96
(line TotDeaMeRaA01S00U20210509 date, sort lcolor(red)) /// 97
(line TotDeaMeRaA01S00U20210510 date, sort lcolor(red)) /// 98
(line TotDeaMeRaA01S00U20210511 date, sort lcolor(red)) /// 99
(line TotDeaMeRaA01S00U20210512 date, sort lcolor(red)) /// 100
(line TotDeaMeRaA01S00U20210513 date, sort lcolor(red)) /// 101
(line TotDeaMeRaA01S00U20210514 date, sort lcolor(red)) /// 102
(line TotDeaMeRaA01S00U20210515 date, sort lcolor(red)) /// 103
(line TotDeaMeRaA01S00U20210516 date, sort lcolor(red)) /// 104
(line TotDeaMeRaA01S00U20210517 date, sort lcolor(red)) /// 105
(line TotDeaMeRaA01S00U20210518 date, sort lcolor(red)) /// 106
(line TotDeaMeRaA01S00U20210519 date, sort lcolor(red)) /// 107
(line TotDeaMeRaA01S00U20210520 date, sort lcolor(red)) /// 108
(line TotDeaMeRaA01S00U20210521 date, sort lcolor(red)) /// 109
(line TotDeaMeRaA01S00U20210522 date, sort lcolor(red)) /// 110
(line TotDeaMeRaA01S00U20210523 date, sort lcolor(red)) /// 111
(line TotDeaMeRaA01S00U20210524 date, sort lcolor(red)) /// 112
(line TotDeaMeRaA01S00U20210525 date, sort lcolor(red)) /// 113
(line TotDeaMeRaA01S00U20210526 date, sort lcolor(red)) /// 114
(line TotDeaMeRaA01S00U20210527 date, sort lcolor(red)) /// 115
(line TotDeaMeRaA01S00U20210528 date, sort lcolor(red)) /// 116
(line TotDeaMeRaA01S00U20210529 date, sort lcolor(red)) /// 117
(line TotDeaMeRaA01S00U20210530 date, sort lcolor(red)) /// 118
(line TotDeaMeRaA01S00U20210531 date, sort lcolor(red)) /// 119
(line TotDeaMeRaA01S00U20210601 date, sort lcolor(red)) /// 120
(line TotDeaMeRaA01S00U20210602 date, sort lcolor(red)) /// 121
(line TotDeaMeRaA01S00U20210603 date, sort lcolor(red)) /// 122
(line TotDeaMeRaA01S00U20210604 date, sort lcolor(red)) /// 123
(line TotDeaMeRaA01S00U20210605 date, sort lcolor(red)) /// 124
(line TotDeaMeRaA01S00U20210606 date, sort lcolor(red)) /// 125
(line TotDeaMeRaA01S00U20210607 date, sort lcolor(red)) /// 126
(line TotDeaMeRaA01S00U20210608 date, sort lcolor(red)) /// 127
(line TotDeaMeRaA01S00U20210609 date, sort lcolor(red)) /// 128
(line TotDeaMeRaA01S00U20210610 date, sort lcolor(red)) /// 129
(line TotDeaMeRaA01S00U20210611 date, sort lcolor(red)) /// 130
(line TotDeaMeRaA01S00U20210612 date, sort lcolor(red)) /// 131
(line TotDeaMeRaA01S00U20210613 date, sort lcolor(red)) /// 132
(line TotDeaMeRaA01S00U20210614 date, sort lcolor(red)) /// 133
(line TotDeaMeRaA01S00U20210615 date, sort lcolor(red)) /// 134
(line TotDeaMeRaA01S00U20210616 date, sort lcolor(red)) /// 135
(line TotDeaMeRaA01S00U20210617 date, sort lcolor(red)) /// 136
(line TotDeaMeRaA01S00U20210618 date, sort lcolor(red)) /// 137
(line TotDeaMeRaA01S00U20210619 date, sort lcolor(red)) /// 138
(line TotDeaMeRaA01S00U20210620 date, sort lcolor(red)) /// 139
(line TotDeaMeRaA01S00U20210621 date, sort lcolor(red)) /// 140
(line TotDeaMeRaA01S00U20210622 date, sort lcolor(red)) /// 141
(line TotDeaMeRaA01S00U20210623 date, sort lcolor(red)) /// 142
(line TotDeaMeRaA01S00U20210624 date, sort lcolor(red)) /// 143
(line TotDeaMeRaA01S00U20210625 date, sort lcolor(red)) /// 144
(line TotDeaMeRaA01S00U20210626 date, sort lcolor(red)) /// 145
(line TotDeaMeRaA01S00U20210627 date, sort lcolor(red)) /// 146
(line TotDeaMeRaA01S00U20210628 date, sort lcolor(red)) /// 147
(line TotDeaMeRaA01S00U20210629 date, sort lcolor(red)) /// 148
(line TotDeaMeRaA01S00U20210630 date, sort lcolor(red)) /// 149
(line TotDeaMeRaA01S00U20210701 date, sort lcolor(red)) /// 150
(line TotDeaMeRaA01S00U20210702 date, sort lcolor(red)) /// 151
(line TotDeaMeRaA01S00U20210703 date, sort lcolor(red)) /// 152
(line TotDeaMeRaA01S00U20210704 date, sort lcolor(red)) /// 153
(line TotDeaMeRaA01S00U20210705 date, sort lcolor(red)) /// 154
(line TotDeaMeRaA01S00U20210706 date, sort lcolor(red)) /// 155
(line TotDeaMeRaA01S00U20210707 date, sort lcolor(red)) /// 156
(line TotDeaMeRaA01S00U20210708 date, sort lcolor(red)) /// 157
(line TotDeaMeRaA01S00U20210709 date, sort lcolor(red)) /// 158
(line TotDeaMeRaA01S00U20210710 date, sort lcolor(red)) /// 159
(line TotDeaMeRaA01S00U20210711 date, sort lcolor(red)) /// 160
(line TotDeaMeRaA01S00U20210712 date, sort lcolor(red)) /// 161
(line TotDeaMeRaA01S00U20210713 date, sort lcolor(red)) /// 162
(line TotDeaMeRaA01S00U20210714 date, sort lcolor(red)) /// 163
(line TotDeaMeRaA01S00U20210715 date, sort lcolor(red)) /// 164
(line TotDeaMeRaA01S00U20210716 date, sort lcolor(red)) /// 165
(line TotDeaMeRaA01S00U20210717 date, sort lcolor(red)) /// 166
(line TotDeaMeRaA01S00U20210718 date, sort lcolor(red)) /// 167
(line TotDeaMeRaA01S00U20210719 date, sort lcolor(red)) /// 168
(line TotDeaMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 169
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(10 "DELP v2" 11 "DELP v4" 169 "JOHN") size(small) rows(1))	yscale(titlegap(2))
  	   
qui graph save "graph 31a COVID-19 total deaths, $country, DELP.gph", replace
qui graph export "graph 31a COVID-19 total deaths, $country, DELP.pdf", replace




*********

* total deaths, Absolute value, together, without extremes  

/* total deaths > 170,000, while DELP does not adjust for under-reporting 

* Max reported total deaths has been less than 85,000 (July 2021), therefore, 
* set bar for extreme as more than 2 times 85,000, i.e.,  > 170,000.

20210211
20210218
20210523
20210522
20210525
20210526
20210527
20210528
20210529

*/	 

twoway  ///
(line TotDeaMeRaA01S00U20200723 date, sort lcolor(red) lpattern(dash)) /// 1
(line TotDeaMeRaA01S00U20200919 date, sort lcolor(red) lpattern(dash)) /// 2
(line TotDeaMeRaA01S00U20200926 date, sort lcolor(red) lpattern(dash)) /// 3
(line TotDeaMeRaA01S00U20201001 date, sort lcolor(red) lpattern(dash)) /// 4
(line TotDeaMeRaA01S00U20201008 date, sort lcolor(red) lpattern(dash)) /// 5
(line TotDeaMeRaA01S00U20201015 date, sort lcolor(red) lpattern(dash)) /// 6
(line TotDeaMeRaA01S00U20201022 date, sort lcolor(red) lpattern(dash)) /// 7
(line TotDeaMeRaA01S00U20201029 date, sort lcolor(red) lpattern(dash)) /// 8
(line TotDeaMeRaA01S00U20201105 date, sort lcolor(red) lpattern(dash)) /// 9
(line TotDeaMeRaA01S00U20201112 date, sort lcolor(red) lpattern(dash)) /// 10
(line TotDeaMeRaA01S00U20201119 date, sort lcolor(red)) /// 11
(line TotDeaMeRaA01S00U20201126 date, sort lcolor(red)) /// 12
(line TotDeaMeRaA01S00U20201203 date, sort lcolor(red)) /// 13
(line TotDeaMeRaA01S00U20201210 date, sort lcolor(red)) /// 14
(line TotDeaMeRaA01S00U20201217 date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20201224 date, sort lcolor(red)) /// 16
(line TotDeaMeRaA01S00U20201231 date, sort lcolor(red)) /// 17
(line TotDeaMeRaA01S00U20210107 date, sort lcolor(red)) /// 18
(line TotDeaMeRaA01S00U20210114 date, sort lcolor(red)) /// 19
(line TotDeaMeRaA01S00U20210121 date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210128 date, sort lcolor(red)) /// 21
(line TotDeaMeRaA01S00U20210204 date, sort lcolor(red)) /// 22
(line TotDeaMeRaA01S00U20210225 date, sort lcolor(red)) /// 23
(line TotDeaMeRaA01S00U20210226 date, sort lcolor(red)) /// 24
(line TotDeaMeRaA01S00U20210227 date, sort lcolor(red)) /// 25
(line TotDeaMeRaA01S00U20210228 date, sort lcolor(red)) /// 26
(line TotDeaMeRaA01S00U20210301 date, sort lcolor(red)) /// 27
(line TotDeaMeRaA01S00U20210303 date, sort lcolor(red)) /// 28
(line TotDeaMeRaA01S00U20210304 date, sort lcolor(red)) /// 29
(line TotDeaMeRaA01S00U20210305 date, sort lcolor(red)) /// 30
(line TotDeaMeRaA01S00U20210306 date, sort lcolor(red)) /// 31
(line TotDeaMeRaA01S00U20210307 date, sort lcolor(red)) /// 32
(line TotDeaMeRaA01S00U20210308 date, sort lcolor(red)) /// 33
(line TotDeaMeRaA01S00U20210309 date, sort lcolor(red)) /// 34
(line TotDeaMeRaA01S00U20210310 date, sort lcolor(red)) /// 35
(line TotDeaMeRaA01S00U20210311 date, sort lcolor(red)) /// 36
(line TotDeaMeRaA01S00U20210312 date, sort lcolor(red)) /// 37
(line TotDeaMeRaA01S00U20210313 date, sort lcolor(red)) /// 38
(line TotDeaMeRaA01S00U20210314 date, sort lcolor(red)) /// 39
(line TotDeaMeRaA01S00U20210315 date, sort lcolor(red)) /// 40
(line TotDeaMeRaA01S00U20210316 date, sort lcolor(red)) /// 41
(line TotDeaMeRaA01S00U20210317 date, sort lcolor(red)) /// 42
(line TotDeaMeRaA01S00U20210318 date, sort lcolor(red)) /// 43
(line TotDeaMeRaA01S00U20210319 date, sort lcolor(red)) /// 44
(line TotDeaMeRaA01S00U20210320 date, sort lcolor(red)) /// 45
(line TotDeaMeRaA01S00U20210321 date, sort lcolor(red)) /// 46
(line TotDeaMeRaA01S00U20210322 date, sort lcolor(red)) /// 47
(line TotDeaMeRaA01S00U20210323 date, sort lcolor(red)) /// 48
(line TotDeaMeRaA01S00U20210324 date, sort lcolor(red)) /// 49
(line TotDeaMeRaA01S00U20210325 date, sort lcolor(red)) /// 50
(line TotDeaMeRaA01S00U20210326 date, sort lcolor(red)) /// 51
(line TotDeaMeRaA01S00U20210327 date, sort lcolor(red)) /// 52
(line TotDeaMeRaA01S00U20210328 date, sort lcolor(red)) /// 53
(line TotDeaMeRaA01S00U20210329 date, sort lcolor(red)) /// 54
(line TotDeaMeRaA01S00U20210330 date, sort lcolor(red)) /// 55
(line TotDeaMeRaA01S00U20210331 date, sort lcolor(red)) /// 56
(line TotDeaMeRaA01S00U20210401 date, sort lcolor(red)) /// 57
(line TotDeaMeRaA01S00U20210402 date, sort lcolor(red)) /// 58
(line TotDeaMeRaA01S00U20210403 date, sort lcolor(red)) /// 59
(line TotDeaMeRaA01S00U20210404 date, sort lcolor(red)) /// 60
(line TotDeaMeRaA01S00U20210405 date, sort lcolor(red)) /// 61
(line TotDeaMeRaA01S00U20210406 date, sort lcolor(red)) /// 62
(line TotDeaMeRaA01S00U20210407 date, sort lcolor(red)) /// 63
(line TotDeaMeRaA01S00U20210408 date, sort lcolor(red)) /// 64
(line TotDeaMeRaA01S00U20210409 date, sort lcolor(red)) /// 65
(line TotDeaMeRaA01S00U20210410 date, sort lcolor(red)) /// 66
(line TotDeaMeRaA01S00U20210411 date, sort lcolor(red)) /// 67
(line TotDeaMeRaA01S00U20210412 date, sort lcolor(red)) /// 68
(line TotDeaMeRaA01S00U20210413 date, sort lcolor(red)) /// 69
(line TotDeaMeRaA01S00U20210414 date, sort lcolor(red)) /// 70
(line TotDeaMeRaA01S00U20210415 date, sort lcolor(red)) /// 71
(line TotDeaMeRaA01S00U20210416 date, sort lcolor(red)) /// 72
(line TotDeaMeRaA01S00U20210417 date, sort lcolor(red)) /// 73
(line TotDeaMeRaA01S00U20210418 date, sort lcolor(red)) /// 74
(line TotDeaMeRaA01S00U20210419 date, sort lcolor(red)) /// 75
(line TotDeaMeRaA01S00U20210420 date, sort lcolor(red)) /// 76
(line TotDeaMeRaA01S00U20210421 date, sort lcolor(red)) /// 77
(line TotDeaMeRaA01S00U20210422 date, sort lcolor(red)) /// 78
(line TotDeaMeRaA01S00U20210423 date, sort lcolor(red)) /// 79
(line TotDeaMeRaA01S00U20210424 date, sort lcolor(red)) /// 80
(line TotDeaMeRaA01S00U20210425 date, sort lcolor(red)) /// 81
(line TotDeaMeRaA01S00U20210426 date, sort lcolor(red)) /// 82
(line TotDeaMeRaA01S00U20210427 date, sort lcolor(red)) /// 83
(line TotDeaMeRaA01S00U20210428 date, sort lcolor(red)) /// 84
(line TotDeaMeRaA01S00U20210429 date, sort lcolor(red)) /// 85
(line TotDeaMeRaA01S00U20210430 date, sort lcolor(red)) /// 86
(line TotDeaMeRaA01S00U20210501 date, sort lcolor(red)) /// 87
(line TotDeaMeRaA01S00U20210502 date, sort lcolor(red)) /// 88
(line TotDeaMeRaA01S00U20210503 date, sort lcolor(red)) /// 89
(line TotDeaMeRaA01S00U20210504 date, sort lcolor(red)) /// 90
(line TotDeaMeRaA01S00U20210505 date, sort lcolor(red)) /// 91
(line TotDeaMeRaA01S00U20210506 date, sort lcolor(red)) /// 92
(line TotDeaMeRaA01S00U20210507 date, sort lcolor(red)) /// 93
(line TotDeaMeRaA01S00U20210508 date, sort lcolor(red)) /// 94
(line TotDeaMeRaA01S00U20210509 date, sort lcolor(red)) /// 95
(line TotDeaMeRaA01S00U20210510 date, sort lcolor(red)) /// 96
(line TotDeaMeRaA01S00U20210511 date, sort lcolor(red)) /// 97
(line TotDeaMeRaA01S00U20210512 date, sort lcolor(red)) /// 98
(line TotDeaMeRaA01S00U20210513 date, sort lcolor(red)) /// 99
(line TotDeaMeRaA01S00U20210514 date, sort lcolor(red)) /// 100
(line TotDeaMeRaA01S00U20210515 date, sort lcolor(red)) /// 101
(line TotDeaMeRaA01S00U20210516 date, sort lcolor(red)) /// 102
(line TotDeaMeRaA01S00U20210517 date, sort lcolor(red)) /// 103
(line TotDeaMeRaA01S00U20210518 date, sort lcolor(red)) /// 104
(line TotDeaMeRaA01S00U20210519 date, sort lcolor(red)) /// 105
(line TotDeaMeRaA01S00U20210520 date, sort lcolor(red)) /// 106
(line TotDeaMeRaA01S00U20210521 date, sort lcolor(red)) /// 107
(line TotDeaMeRaA01S00U20210522 date, sort lcolor(red)) /// 108
(line TotDeaMeRaA01S00U20210530 date, sort lcolor(red)) /// 109
(line TotDeaMeRaA01S00U20210531 date, sort lcolor(red)) /// 110
(line TotDeaMeRaA01S00U20210601 date, sort lcolor(red)) /// 111
(line TotDeaMeRaA01S00U20210602 date, sort lcolor(red)) /// 112
(line TotDeaMeRaA01S00U20210603 date, sort lcolor(red)) /// 113
(line TotDeaMeRaA01S00U20210604 date, sort lcolor(red)) /// 114
(line TotDeaMeRaA01S00U20210605 date, sort lcolor(red)) /// 115
(line TotDeaMeRaA01S00U20210606 date, sort lcolor(red)) /// 116
(line TotDeaMeRaA01S00U20210607 date, sort lcolor(red)) /// 117
(line TotDeaMeRaA01S00U20210608 date, sort lcolor(red)) /// 118
(line TotDeaMeRaA01S00U20210609 date, sort lcolor(red)) /// 119
(line TotDeaMeRaA01S00U20210610 date, sort lcolor(red)) /// 120
(line TotDeaMeRaA01S00U20210611 date, sort lcolor(red)) /// 121
(line TotDeaMeRaA01S00U20210612 date, sort lcolor(red)) /// 122
(line TotDeaMeRaA01S00U20210613 date, sort lcolor(red)) /// 123
(line TotDeaMeRaA01S00U20210614 date, sort lcolor(red)) /// 124
(line TotDeaMeRaA01S00U20210615 date, sort lcolor(red)) /// 125
(line TotDeaMeRaA01S00U20210616 date, sort lcolor(red)) /// 126
(line TotDeaMeRaA01S00U20210617 date, sort lcolor(red)) /// 127
(line TotDeaMeRaA01S00U20210618 date, sort lcolor(red)) /// 128
(line TotDeaMeRaA01S00U20210619 date, sort lcolor(red)) /// 129
(line TotDeaMeRaA01S00U20210620 date, sort lcolor(red)) /// 130
(line TotDeaMeRaA01S00U20210621 date, sort lcolor(red)) /// 131
(line TotDeaMeRaA01S00U20210622 date, sort lcolor(red)) /// 132
(line TotDeaMeRaA01S00U20210623 date, sort lcolor(red)) /// 133
(line TotDeaMeRaA01S00U20210624 date, sort lcolor(red)) /// 134
(line TotDeaMeRaA01S00U20210625 date, sort lcolor(red)) /// 135
(line TotDeaMeRaA01S00U20210626 date, sort lcolor(red)) /// 136
(line TotDeaMeRaA01S00U20210627 date, sort lcolor(red)) /// 137
(line TotDeaMeRaA01S00U20210628 date, sort lcolor(red)) /// 138
(line TotDeaMeRaA01S00U20210629 date, sort lcolor(red)) /// 139
(line TotDeaMeRaA01S00U20210630 date, sort lcolor(red)) /// 140
(line TotDeaMeRaA01S00U20210701 date, sort lcolor(red)) /// 141
(line TotDeaMeRaA01S00U20210702 date, sort lcolor(red)) /// 142
(line TotDeaMeRaA01S00U20210703 date, sort lcolor(red)) /// 143
(line TotDeaMeRaA01S00U20210704 date, sort lcolor(red)) /// 144
(line TotDeaMeRaA01S00U20210705 date, sort lcolor(red)) /// 145
(line TotDeaMeRaA01S00U20210706 date, sort lcolor(red)) /// 146
(line TotDeaMeRaA01S00U20210707 date, sort lcolor(red)) /// 147
(line TotDeaMeRaA01S00U20210708 date, sort lcolor(red)) /// 148
(line TotDeaMeRaA01S00U20210709 date, sort lcolor(red)) /// 149
(line TotDeaMeRaA01S00U20210710 date, sort lcolor(red)) /// 150
(line TotDeaMeRaA01S00U20210711 date, sort lcolor(red)) /// 151
(line TotDeaMeRaA01S00U20210712 date, sort lcolor(red)) /// 152
(line TotDeaMeRaA01S00U20210713 date, sort lcolor(red)) /// 153
(line TotDeaMeRaA01S00U20210714 date, sort lcolor(red)) /// 154
(line TotDeaMeRaA01S00U20210715 date, sort lcolor(red)) /// 155
(line TotDeaMeRaA01S00U20210716 date, sort lcolor(red)) /// 156
(line TotDeaMeRaA01S00U20210717 date, sort lcolor(red)) /// 157
(line TotDeaMeRaA01S00U20210718 date, sort lcolor(red)) /// 158
(line TotDeaMeRaA01S00U20210719 date, sort lcolor(red)) /// 159
(line TotDeaMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 160
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; without extremes i.e. > 2 times max reported 170,000", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(10 "DELP v2" 11 "DELP v4" 155 "JOHN") size(small) rows(1)) yscale(titlegap(2))
  	   
qui graph save "graph 31b COVID-19 total deaths, $country, DELP, wo extreme.gph", replace
qui graph export "graph 31b COVID-19 total deaths, $country, DELP, wo extreme.pdf", replace


*


*********

* total deaths, Difference, together, without extremes 168

twoway  ///
(line TotDeaMeRaA01S00U20200723D date, sort lcolor(red) lpattern(dash)) /// 1
(line TotDeaMeRaA01S00U20200919D date, sort lcolor(red) lpattern(dash)) /// 2
(line TotDeaMeRaA01S00U20200926D date, sort lcolor(red) lpattern(dash)) /// 3
(line TotDeaMeRaA01S00U20201001D date, sort lcolor(red) lpattern(dash)) /// 4
(line TotDeaMeRaA01S00U20201008D date, sort lcolor(red) lpattern(dash)) /// 5
(line TotDeaMeRaA01S00U20201015D date, sort lcolor(red) lpattern(dash)) /// 6
(line TotDeaMeRaA01S00U20201022D date, sort lcolor(red) lpattern(dash)) /// 7
(line TotDeaMeRaA01S00U20201029D date, sort lcolor(red) lpattern(dash)) /// 8
(line TotDeaMeRaA01S00U20201105D date, sort lcolor(red) lpattern(dash)) /// 9
(line TotDeaMeRaA01S00U20201112D date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line TotDeaMeRaA01S00U20201119D date, sort lcolor(red)) /// 11 v4
(line TotDeaMeRaA01S00U20201126D date, sort lcolor(red)) /// 12
(line TotDeaMeRaA01S00U20201203D date, sort lcolor(red)) /// 13
(line TotDeaMeRaA01S00U20201210D date, sort lcolor(red)) /// 14
(line TotDeaMeRaA01S00U20201217D date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20201224D date, sort lcolor(red)) /// 16
(line TotDeaMeRaA01S00U20201231D date, sort lcolor(red)) /// 17
(line TotDeaMeRaA01S00U20210107D date, sort lcolor(red)) /// 18
(line TotDeaMeRaA01S00U20210114D date, sort lcolor(red)) /// 19
(line TotDeaMeRaA01S00U20210121D date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210128D date, sort lcolor(red)) /// 21
(line TotDeaMeRaA01S00U20210204D date, sort lcolor(red)) /// 22
(line TotDeaMeRaA01S00U20210211D date, sort lcolor(red)) /// 23
(line TotDeaMeRaA01S00U20210218D date, sort lcolor(red)) /// 24
(line TotDeaMeRaA01S00U20210225D date, sort lcolor(red)) /// 25
(line TotDeaMeRaA01S00U20210226D date, sort lcolor(red)) /// 26
(line TotDeaMeRaA01S00U20210227D date, sort lcolor(red)) /// 27
(line TotDeaMeRaA01S00U20210228D date, sort lcolor(red)) /// 28
(line TotDeaMeRaA01S00U20210301D date, sort lcolor(red)) /// 29
(line TotDeaMeRaA01S00U20210303D date, sort lcolor(red)) /// 30
(line TotDeaMeRaA01S00U20210304D date, sort lcolor(red)) /// 31
(line TotDeaMeRaA01S00U20210305D date, sort lcolor(red)) /// 32
(line TotDeaMeRaA01S00U20210306D date, sort lcolor(red)) /// 33
(line TotDeaMeRaA01S00U20210307D date, sort lcolor(red)) /// 34
(line TotDeaMeRaA01S00U20210308D date, sort lcolor(red)) /// 35
(line TotDeaMeRaA01S00U20210309D date, sort lcolor(red)) /// 36
(line TotDeaMeRaA01S00U20210310D date, sort lcolor(red)) /// 37
(line TotDeaMeRaA01S00U20210311D date, sort lcolor(red)) /// 38
(line TotDeaMeRaA01S00U20210312D date, sort lcolor(red)) /// 39
(line TotDeaMeRaA01S00U20210313D date, sort lcolor(red)) /// 40
(line TotDeaMeRaA01S00U20210314D date, sort lcolor(red)) /// 41
(line TotDeaMeRaA01S00U20210315D date, sort lcolor(red)) /// 42
(line TotDeaMeRaA01S00U20210316D date, sort lcolor(red)) /// 43
(line TotDeaMeRaA01S00U20210317D date, sort lcolor(red)) /// 44
(line TotDeaMeRaA01S00U20210318D date, sort lcolor(red)) /// 45
(line TotDeaMeRaA01S00U20210319D date, sort lcolor(red)) /// 46
(line TotDeaMeRaA01S00U20210320D date, sort lcolor(red)) /// 47
(line TotDeaMeRaA01S00U20210321D date, sort lcolor(red)) /// 48
(line TotDeaMeRaA01S00U20210322D date, sort lcolor(red)) /// 49
(line TotDeaMeRaA01S00U20210323D date, sort lcolor(red)) /// 50
(line TotDeaMeRaA01S00U20210324D date, sort lcolor(red)) /// 51
(line TotDeaMeRaA01S00U20210325D date, sort lcolor(red)) /// 52
(line TotDeaMeRaA01S00U20210326D date, sort lcolor(red)) /// 53
(line TotDeaMeRaA01S00U20210327D date, sort lcolor(red)) /// 54
(line TotDeaMeRaA01S00U20210328D date, sort lcolor(red)) /// 55
(line TotDeaMeRaA01S00U20210329D date, sort lcolor(red)) /// 56
(line TotDeaMeRaA01S00U20210330D date, sort lcolor(red)) /// 57
(line TotDeaMeRaA01S00U20210331D date, sort lcolor(red)) /// 58
(line TotDeaMeRaA01S00U20210401D date, sort lcolor(red)) /// 59
(line TotDeaMeRaA01S00U20210402D date, sort lcolor(red)) /// 60
(line TotDeaMeRaA01S00U20210403D date, sort lcolor(red)) /// 61
(line TotDeaMeRaA01S00U20210404D date, sort lcolor(red)) /// 62
(line TotDeaMeRaA01S00U20210405D date, sort lcolor(red)) /// 63
(line TotDeaMeRaA01S00U20210406D date, sort lcolor(red)) /// 64
(line TotDeaMeRaA01S00U20210407D date, sort lcolor(red)) /// 65
(line TotDeaMeRaA01S00U20210408D date, sort lcolor(red)) /// 66
(line TotDeaMeRaA01S00U20210409D date, sort lcolor(red)) /// 67
(line TotDeaMeRaA01S00U20210410D date, sort lcolor(red)) /// 68
(line TotDeaMeRaA01S00U20210411D date, sort lcolor(red)) /// 69
(line TotDeaMeRaA01S00U20210412D date, sort lcolor(red)) /// 70
(line TotDeaMeRaA01S00U20210413D date, sort lcolor(red)) /// 71
(line TotDeaMeRaA01S00U20210414D date, sort lcolor(red)) /// 72
(line TotDeaMeRaA01S00U20210415D date, sort lcolor(red)) /// 73
(line TotDeaMeRaA01S00U20210416D date, sort lcolor(red)) /// 74
(line TotDeaMeRaA01S00U20210417D date, sort lcolor(red)) /// 75
(line TotDeaMeRaA01S00U20210418D date, sort lcolor(red)) /// 76
(line TotDeaMeRaA01S00U20210419D date, sort lcolor(red)) /// 77
(line TotDeaMeRaA01S00U20210420D date, sort lcolor(red)) /// 78
(line TotDeaMeRaA01S00U20210421D date, sort lcolor(red)) /// 79
(line TotDeaMeRaA01S00U20210422D date, sort lcolor(red)) /// 80
(line TotDeaMeRaA01S00U20210423D date, sort lcolor(red)) /// 81
(line TotDeaMeRaA01S00U20210424D date, sort lcolor(red)) /// 82
(line TotDeaMeRaA01S00U20210425D date, sort lcolor(red)) /// 83
(line TotDeaMeRaA01S00U20210426D date, sort lcolor(red)) /// 84
(line TotDeaMeRaA01S00U20210427D date, sort lcolor(red)) /// 85
(line TotDeaMeRaA01S00U20210428D date, sort lcolor(red)) /// 86
(line TotDeaMeRaA01S00U20210429D date, sort lcolor(red)) /// 87
(line TotDeaMeRaA01S00U20210430D date, sort lcolor(red)) /// 88
(line TotDeaMeRaA01S00U20210501D date, sort lcolor(red)) /// 89
(line TotDeaMeRaA01S00U20210502D date, sort lcolor(red)) /// 90
(line TotDeaMeRaA01S00U20210503D date, sort lcolor(red)) /// 91
(line TotDeaMeRaA01S00U20210504D date, sort lcolor(red)) /// 92
(line TotDeaMeRaA01S00U20210505D date, sort lcolor(red)) /// 93
(line TotDeaMeRaA01S00U20210506D date, sort lcolor(red)) /// 94
(line TotDeaMeRaA01S00U20210507D date, sort lcolor(red)) /// 95
(line TotDeaMeRaA01S00U20210508D date, sort lcolor(red)) /// 96
(line TotDeaMeRaA01S00U20210509D date, sort lcolor(red)) /// 97
(line TotDeaMeRaA01S00U20210510D date, sort lcolor(red)) /// 98
(line TotDeaMeRaA01S00U20210511D date, sort lcolor(red)) /// 99
(line TotDeaMeRaA01S00U20210512D date, sort lcolor(red)) /// 100
(line TotDeaMeRaA01S00U20210513D date, sort lcolor(red)) /// 101
(line TotDeaMeRaA01S00U20210514D date, sort lcolor(red)) /// 102
(line TotDeaMeRaA01S00U20210515D date, sort lcolor(red)) /// 103
(line TotDeaMeRaA01S00U20210516D date, sort lcolor(red)) /// 104
(line TotDeaMeRaA01S00U20210517D date, sort lcolor(red)) /// 105
(line TotDeaMeRaA01S00U20210518D date, sort lcolor(red)) /// 106
(line TotDeaMeRaA01S00U20210519D date, sort lcolor(red)) /// 107
(line TotDeaMeRaA01S00U20210520D date, sort lcolor(red)) /// 108
(line TotDeaMeRaA01S00U20210521D date, sort lcolor(red)) /// 109
(line TotDeaMeRaA01S00U20210522D date, sort lcolor(red)) /// 110
(line TotDeaMeRaA01S00U20210523D date, sort lcolor(red)) /// 111
(line TotDeaMeRaA01S00U20210524D date, sort lcolor(red)) /// 112
(line TotDeaMeRaA01S00U20210525D date, sort lcolor(red)) /// 113
(line TotDeaMeRaA01S00U20210526D date, sort lcolor(red)) /// 114
(line TotDeaMeRaA01S00U20210527D date, sort lcolor(red)) /// 115
(line TotDeaMeRaA01S00U20210528D date, sort lcolor(red)) /// 116
(line TotDeaMeRaA01S00U20210529D date, sort lcolor(red)) /// 117
(line TotDeaMeRaA01S00U20210530D date, sort lcolor(red)) /// 118
(line TotDeaMeRaA01S00U20210531D date, sort lcolor(red)) /// 119
(line TotDeaMeRaA01S00U20210601D date, sort lcolor(red)) /// 120
(line TotDeaMeRaA01S00U20210602D date, sort lcolor(red)) /// 121
(line TotDeaMeRaA01S00U20210603D date, sort lcolor(red)) /// 122
(line TotDeaMeRaA01S00U20210604D date, sort lcolor(red)) /// 123
(line TotDeaMeRaA01S00U20210605D date, sort lcolor(red)) /// 124
(line TotDeaMeRaA01S00U20210606D date, sort lcolor(red)) /// 125
(line TotDeaMeRaA01S00U20210607D date, sort lcolor(red)) /// 126
(line TotDeaMeRaA01S00U20210608D date, sort lcolor(red)) /// 127
(line TotDeaMeRaA01S00U20210609D date, sort lcolor(red)) /// 128
(line TotDeaMeRaA01S00U20210610D date, sort lcolor(red)) /// 129
(line TotDeaMeRaA01S00U20210611D date, sort lcolor(red)) /// 130
(line TotDeaMeRaA01S00U20210612D date, sort lcolor(red)) /// 131
(line TotDeaMeRaA01S00U20210613D date, sort lcolor(red)) /// 132
(line TotDeaMeRaA01S00U20210614D date, sort lcolor(red)) /// 133
(line TotDeaMeRaA01S00U20210615D date, sort lcolor(red)) /// 134
(line TotDeaMeRaA01S00U20210616D date, sort lcolor(red)) /// 135
(line TotDeaMeRaA01S00U20210617D date, sort lcolor(red)) /// 136
(line TotDeaMeRaA01S00U20210618D date, sort lcolor(red)) /// 137
(line TotDeaMeRaA01S00U20210619D date, sort lcolor(red)) /// 138
(line TotDeaMeRaA01S00U20210620D date, sort lcolor(red)) /// 139
(line TotDeaMeRaA01S00U20210621D date, sort lcolor(red)) /// 140
(line TotDeaMeRaA01S00U20210622D date, sort lcolor(red)) /// 141
(line TotDeaMeRaA01S00U20210623D date, sort lcolor(red)) /// 142
(line TotDeaMeRaA01S00U20210624D date, sort lcolor(red)) /// 143
(line TotDeaMeRaA01S00U20210625D date, sort lcolor(red)) /// 144
(line TotDeaMeRaA01S00U20210626D date, sort lcolor(red)) /// 145
(line TotDeaMeRaA01S00U20210627D date, sort lcolor(red)) /// 146
(line TotDeaMeRaA01S00U20210628D date, sort lcolor(red)) /// 147
(line TotDeaMeRaA01S00U20210629D date, sort lcolor(red)) /// 148
(line TotDeaMeRaA01S00U20210630D date, sort lcolor(red)) /// 149
(line TotDeaMeRaA01S00U20210701D date, sort lcolor(red)) /// 150
(line TotDeaMeRaA01S00U20210702D date, sort lcolor(red)) /// 151
(line TotDeaMeRaA01S00U20210703D date, sort lcolor(red)) /// 152
(line TotDeaMeRaA01S00U20210704D date, sort lcolor(red)) /// 153
(line TotDeaMeRaA01S00U20210705D date, sort lcolor(red)) /// 154
(line TotDeaMeRaA01S00U20210706D date, sort lcolor(red)) /// 155
(line TotDeaMeRaA01S00U20210707D date, sort lcolor(red)) /// 156
(line TotDeaMeRaA01S00U20210708D date, sort lcolor(red)) /// 157
(line TotDeaMeRaA01S00U20210709D date, sort lcolor(red)) /// 158
(line TotDeaMeRaA01S00U20210710D date, sort lcolor(red)) /// 159
(line TotDeaMeRaA01S00U20210711D date, sort lcolor(red)) /// 160
(line TotDeaMeRaA01S00U20210712D date, sort lcolor(red)) /// 161
(line TotDeaMeRaA01S00U20210713D date, sort lcolor(red)) /// 162
(line TotDeaMeRaA01S00U20210714D date, sort lcolor(red)) /// 163
(line TotDeaMeRaA01S00U20210715D date, sort lcolor(red)) /// 164
(line TotDeaMeRaA01S00U20210716D date, sort lcolor(red)) /// 165
(line TotDeaMeRaA01S00U20210717D date, sort lcolor(red)) /// 166
(line TotDeaMeRaA01S00U20210718D date, sort lcolor(red)) /// 167
(line TotDeaMeRaA01S00U20210719D date, sort lcolor(red)) /// 168
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths DELP minus JOHN) title("COVID-19 total deaths, $country, DELP minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 32a COVID-19 total deaths, $country, DELP, Difference.gph", replace
qui graph export "graph 32a COVID-19 total deaths, $country, DELP, Difference.pdf", replace





*********

* total deaths, Difference, together, without extremes

twoway  ///
(line TotDeaMeRaA01S00U20200723D date, sort lcolor(red) lpattern(dash)) /// 1
(line TotDeaMeRaA01S00U20200919D date, sort lcolor(red) lpattern(dash)) /// 2
(line TotDeaMeRaA01S00U20200926D date, sort lcolor(red) lpattern(dash)) /// 3
(line TotDeaMeRaA01S00U20201001D date, sort lcolor(red) lpattern(dash)) /// 4
(line TotDeaMeRaA01S00U20201008D date, sort lcolor(red) lpattern(dash)) /// 5
(line TotDeaMeRaA01S00U20201015D date, sort lcolor(red) lpattern(dash)) /// 6
(line TotDeaMeRaA01S00U20201022D date, sort lcolor(red) lpattern(dash)) /// 7
(line TotDeaMeRaA01S00U20201029D date, sort lcolor(red) lpattern(dash)) /// 8
(line TotDeaMeRaA01S00U20201105D date, sort lcolor(red) lpattern(dash)) /// 9
(line TotDeaMeRaA01S00U20201112D date, sort lcolor(red) lpattern(dash)) /// 10
(line TotDeaMeRaA01S00U20201119D date, sort lcolor(red)) /// 11
(line TotDeaMeRaA01S00U20201126D date, sort lcolor(red)) /// 12
(line TotDeaMeRaA01S00U20201203D date, sort lcolor(red)) /// 13
(line TotDeaMeRaA01S00U20201210D date, sort lcolor(red)) /// 14
(line TotDeaMeRaA01S00U20201217D date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20201224D date, sort lcolor(red)) /// 16
(line TotDeaMeRaA01S00U20201231D date, sort lcolor(red)) /// 17
(line TotDeaMeRaA01S00U20210107D date, sort lcolor(red)) /// 18
(line TotDeaMeRaA01S00U20210114D date, sort lcolor(red)) /// 19
(line TotDeaMeRaA01S00U20210121D date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210128D date, sort lcolor(red)) /// 21
(line TotDeaMeRaA01S00U20210204D date, sort lcolor(red)) /// 22
(line TotDeaMeRaA01S00U20210225D date, sort lcolor(red)) /// 23
(line TotDeaMeRaA01S00U20210226D date, sort lcolor(red)) /// 24
(line TotDeaMeRaA01S00U20210227D date, sort lcolor(red)) /// 25
(line TotDeaMeRaA01S00U20210228D date, sort lcolor(red)) /// 26
(line TotDeaMeRaA01S00U20210301D date, sort lcolor(red)) /// 27
(line TotDeaMeRaA01S00U20210303D date, sort lcolor(red)) /// 28
(line TotDeaMeRaA01S00U20210304D date, sort lcolor(red)) /// 29
(line TotDeaMeRaA01S00U20210305D date, sort lcolor(red)) /// 30
(line TotDeaMeRaA01S00U20210306D date, sort lcolor(red)) /// 31
(line TotDeaMeRaA01S00U20210307D date, sort lcolor(red)) /// 32
(line TotDeaMeRaA01S00U20210308D date, sort lcolor(red)) /// 33
(line TotDeaMeRaA01S00U20210309D date, sort lcolor(red)) /// 34
(line TotDeaMeRaA01S00U20210310D date, sort lcolor(red)) /// 35
(line TotDeaMeRaA01S00U20210311D date, sort lcolor(red)) /// 36
(line TotDeaMeRaA01S00U20210312D date, sort lcolor(red)) /// 37
(line TotDeaMeRaA01S00U20210313D date, sort lcolor(red)) /// 38
(line TotDeaMeRaA01S00U20210314D date, sort lcolor(red)) /// 39
(line TotDeaMeRaA01S00U20210315D date, sort lcolor(red)) /// 40
(line TotDeaMeRaA01S00U20210316D date, sort lcolor(red)) /// 41
(line TotDeaMeRaA01S00U20210317D date, sort lcolor(red)) /// 42
(line TotDeaMeRaA01S00U20210318D date, sort lcolor(red)) /// 43
(line TotDeaMeRaA01S00U20210319D date, sort lcolor(red)) /// 44
(line TotDeaMeRaA01S00U20210320D date, sort lcolor(red)) /// 45
(line TotDeaMeRaA01S00U20210321D date, sort lcolor(red)) /// 46
(line TotDeaMeRaA01S00U20210322D date, sort lcolor(red)) /// 47
(line TotDeaMeRaA01S00U20210323D date, sort lcolor(red)) /// 48
(line TotDeaMeRaA01S00U20210324D date, sort lcolor(red)) /// 49
(line TotDeaMeRaA01S00U20210325D date, sort lcolor(red)) /// 50
(line TotDeaMeRaA01S00U20210326D date, sort lcolor(red)) /// 51
(line TotDeaMeRaA01S00U20210327D date, sort lcolor(red)) /// 52
(line TotDeaMeRaA01S00U20210328D date, sort lcolor(red)) /// 53
(line TotDeaMeRaA01S00U20210329D date, sort lcolor(red)) /// 54
(line TotDeaMeRaA01S00U20210330D date, sort lcolor(red)) /// 55
(line TotDeaMeRaA01S00U20210331D date, sort lcolor(red)) /// 56
(line TotDeaMeRaA01S00U20210401D date, sort lcolor(red)) /// 57
(line TotDeaMeRaA01S00U20210402D date, sort lcolor(red)) /// 58
(line TotDeaMeRaA01S00U20210403D date, sort lcolor(red)) /// 59
(line TotDeaMeRaA01S00U20210404D date, sort lcolor(red)) /// 60
(line TotDeaMeRaA01S00U20210405D date, sort lcolor(red)) /// 61
(line TotDeaMeRaA01S00U20210406D date, sort lcolor(red)) /// 62
(line TotDeaMeRaA01S00U20210407D date, sort lcolor(red)) /// 63
(line TotDeaMeRaA01S00U20210408D date, sort lcolor(red)) /// 64
(line TotDeaMeRaA01S00U20210409D date, sort lcolor(red)) /// 65
(line TotDeaMeRaA01S00U20210410D date, sort lcolor(red)) /// 66
(line TotDeaMeRaA01S00U20210411D date, sort lcolor(red)) /// 67
(line TotDeaMeRaA01S00U20210412D date, sort lcolor(red)) /// 68
(line TotDeaMeRaA01S00U20210413D date, sort lcolor(red)) /// 69
(line TotDeaMeRaA01S00U20210414D date, sort lcolor(red)) /// 70
(line TotDeaMeRaA01S00U20210415D date, sort lcolor(red)) /// 71
(line TotDeaMeRaA01S00U20210416D date, sort lcolor(red)) /// 72
(line TotDeaMeRaA01S00U20210417D date, sort lcolor(red)) /// 73
(line TotDeaMeRaA01S00U20210418D date, sort lcolor(red)) /// 74
(line TotDeaMeRaA01S00U20210419D date, sort lcolor(red)) /// 75
(line TotDeaMeRaA01S00U20210420D date, sort lcolor(red)) /// 76
(line TotDeaMeRaA01S00U20210421D date, sort lcolor(red)) /// 77
(line TotDeaMeRaA01S00U20210422D date, sort lcolor(red)) /// 78
(line TotDeaMeRaA01S00U20210423D date, sort lcolor(red)) /// 79
(line TotDeaMeRaA01S00U20210424D date, sort lcolor(red)) /// 80
(line TotDeaMeRaA01S00U20210425D date, sort lcolor(red)) /// 81
(line TotDeaMeRaA01S00U20210426D date, sort lcolor(red)) /// 82
(line TotDeaMeRaA01S00U20210427D date, sort lcolor(red)) /// 83
(line TotDeaMeRaA01S00U20210428D date, sort lcolor(red)) /// 84
(line TotDeaMeRaA01S00U20210429D date, sort lcolor(red)) /// 85
(line TotDeaMeRaA01S00U20210430D date, sort lcolor(red)) /// 86
(line TotDeaMeRaA01S00U20210501D date, sort lcolor(red)) /// 87
(line TotDeaMeRaA01S00U20210502D date, sort lcolor(red)) /// 88
(line TotDeaMeRaA01S00U20210503D date, sort lcolor(red)) /// 89
(line TotDeaMeRaA01S00U20210504D date, sort lcolor(red)) /// 90
(line TotDeaMeRaA01S00U20210505D date, sort lcolor(red)) /// 91
(line TotDeaMeRaA01S00U20210506D date, sort lcolor(red)) /// 92
(line TotDeaMeRaA01S00U20210507D date, sort lcolor(red)) /// 93
(line TotDeaMeRaA01S00U20210508D date, sort lcolor(red)) /// 94
(line TotDeaMeRaA01S00U20210509D date, sort lcolor(red)) /// 95
(line TotDeaMeRaA01S00U20210510D date, sort lcolor(red)) /// 96
(line TotDeaMeRaA01S00U20210511D date, sort lcolor(red)) /// 97
(line TotDeaMeRaA01S00U20210512D date, sort lcolor(red)) /// 98
(line TotDeaMeRaA01S00U20210513D date, sort lcolor(red)) /// 99
(line TotDeaMeRaA01S00U20210514D date, sort lcolor(red)) /// 100
(line TotDeaMeRaA01S00U20210515D date, sort lcolor(red)) /// 101
(line TotDeaMeRaA01S00U20210516D date, sort lcolor(red)) /// 102
(line TotDeaMeRaA01S00U20210517D date, sort lcolor(red)) /// 103
(line TotDeaMeRaA01S00U20210518D date, sort lcolor(red)) /// 104
(line TotDeaMeRaA01S00U20210519D date, sort lcolor(red)) /// 105
(line TotDeaMeRaA01S00U20210520D date, sort lcolor(red)) /// 106
(line TotDeaMeRaA01S00U20210521D date, sort lcolor(red)) /// 107
(line TotDeaMeRaA01S00U20210522D date, sort lcolor(red)) /// 108
(line TotDeaMeRaA01S00U20210530D date, sort lcolor(red)) /// 109
(line TotDeaMeRaA01S00U20210531D date, sort lcolor(red)) /// 110
(line TotDeaMeRaA01S00U20210601D date, sort lcolor(red)) /// 111
(line TotDeaMeRaA01S00U20210602D date, sort lcolor(red)) /// 112
(line TotDeaMeRaA01S00U20210603D date, sort lcolor(red)) /// 113
(line TotDeaMeRaA01S00U20210604D date, sort lcolor(red)) /// 114
(line TotDeaMeRaA01S00U20210605D date, sort lcolor(red)) /// 115
(line TotDeaMeRaA01S00U20210606D date, sort lcolor(red)) /// 116
(line TotDeaMeRaA01S00U20210607D date, sort lcolor(red)) /// 117
(line TotDeaMeRaA01S00U20210608D date, sort lcolor(red)) /// 118
(line TotDeaMeRaA01S00U20210609D date, sort lcolor(red)) /// 119
(line TotDeaMeRaA01S00U20210610D date, sort lcolor(red)) /// 120
(line TotDeaMeRaA01S00U20210611D date, sort lcolor(red)) /// 121
(line TotDeaMeRaA01S00U20210612D date, sort lcolor(red)) /// 122
(line TotDeaMeRaA01S00U20210613D date, sort lcolor(red)) /// 123
(line TotDeaMeRaA01S00U20210614D date, sort lcolor(red)) /// 124
(line TotDeaMeRaA01S00U20210615D date, sort lcolor(red)) /// 125
(line TotDeaMeRaA01S00U20210616D date, sort lcolor(red)) /// 126
(line TotDeaMeRaA01S00U20210617D date, sort lcolor(red)) /// 127
(line TotDeaMeRaA01S00U20210618D date, sort lcolor(red)) /// 128
(line TotDeaMeRaA01S00U20210619D date, sort lcolor(red)) /// 129
(line TotDeaMeRaA01S00U20210620D date, sort lcolor(red)) /// 130
(line TotDeaMeRaA01S00U20210621D date, sort lcolor(red)) /// 131
(line TotDeaMeRaA01S00U20210622D date, sort lcolor(red)) /// 132
(line TotDeaMeRaA01S00U20210623D date, sort lcolor(red)) /// 133
(line TotDeaMeRaA01S00U20210624D date, sort lcolor(red)) /// 134
(line TotDeaMeRaA01S00U20210625D date, sort lcolor(red)) /// 135
(line TotDeaMeRaA01S00U20210626D date, sort lcolor(red)) /// 136
(line TotDeaMeRaA01S00U20210627D date, sort lcolor(red)) /// 137
(line TotDeaMeRaA01S00U20210628D date, sort lcolor(red)) /// 138
(line TotDeaMeRaA01S00U20210629D date, sort lcolor(red)) /// 139
(line TotDeaMeRaA01S00U20210630D date, sort lcolor(red)) /// 140
(line TotDeaMeRaA01S00U20210701D date, sort lcolor(red)) /// 141
(line TotDeaMeRaA01S00U20210702D date, sort lcolor(red)) /// 142
(line TotDeaMeRaA01S00U20210703D date, sort lcolor(red)) /// 143
(line TotDeaMeRaA01S00U20210704D date, sort lcolor(red)) /// 144
(line TotDeaMeRaA01S00U20210705D date, sort lcolor(red)) /// 145
(line TotDeaMeRaA01S00U20210706D date, sort lcolor(red)) /// 146
(line TotDeaMeRaA01S00U20210707D date, sort lcolor(red)) /// 147
(line TotDeaMeRaA01S00U20210708D date, sort lcolor(red)) /// 148
(line TotDeaMeRaA01S00U20210709D date, sort lcolor(red)) /// 149
(line TotDeaMeRaA01S00U20210710D date, sort lcolor(red)) /// 150
(line TotDeaMeRaA01S00U20210711D date, sort lcolor(red)) /// 151
(line TotDeaMeRaA01S00U20210712D date, sort lcolor(red)) /// 152
(line TotDeaMeRaA01S00U20210713D date, sort lcolor(red)) /// 153
(line TotDeaMeRaA01S00U20210714D date, sort lcolor(red)) /// 154
(line TotDeaMeRaA01S00U20210715D date, sort lcolor(red)) /// 155
(line TotDeaMeRaA01S00U20210716D date, sort lcolor(red)) /// 156
(line TotDeaMeRaA01S00U20210717D date, sort lcolor(red)) /// 157
(line TotDeaMeRaA01S00U20210718D date, sort lcolor(red)) /// 158
(line TotDeaMeRaA01S00U20210719D date, sort lcolor(red)) /// 159
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths DELP divided by JOHN) title("COVID-19 total deaths, $country, DELP minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; without extremes i.e. > 2 times max reported 170,000", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 32b COVID-19 total deaths, $country, DELP, wo extreme, Difference.gph", replace
qui graph export "graph 32b COVID-19 total deaths, $country, DELP, wo extreme, Difference.pdf", replace




*


*********

* total deaths, Times, together, with extremes 168

twoway  ///
(line TotDeaMeRaA01S00U20200723T date, sort lcolor(red) lpattern(dash)) /// 1
(line TotDeaMeRaA01S00U20200919T date, sort lcolor(red) lpattern(dash)) /// 2
(line TotDeaMeRaA01S00U20200926T date, sort lcolor(red) lpattern(dash)) /// 3
(line TotDeaMeRaA01S00U20201001T date, sort lcolor(red) lpattern(dash)) /// 4
(line TotDeaMeRaA01S00U20201008T date, sort lcolor(red) lpattern(dash)) /// 5
(line TotDeaMeRaA01S00U20201015T date, sort lcolor(red) lpattern(dash)) /// 6
(line TotDeaMeRaA01S00U20201022T date, sort lcolor(red) lpattern(dash)) /// 7
(line TotDeaMeRaA01S00U20201029T date, sort lcolor(red) lpattern(dash)) /// 8
(line TotDeaMeRaA01S00U20201105T date, sort lcolor(red) lpattern(dash)) /// 9
(line TotDeaMeRaA01S00U20201112T date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line TotDeaMeRaA01S00U20201119T date, sort lcolor(red)) /// 11 v4
(line TotDeaMeRaA01S00U20201126T date, sort lcolor(red)) /// 12
(line TotDeaMeRaA01S00U20201203T date, sort lcolor(red)) /// 13
(line TotDeaMeRaA01S00U20201210T date, sort lcolor(red)) /// 14
(line TotDeaMeRaA01S00U20201217T date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20201224T date, sort lcolor(red)) /// 16
(line TotDeaMeRaA01S00U20201231T date, sort lcolor(red)) /// 17
(line TotDeaMeRaA01S00U20210107T date, sort lcolor(red)) /// 18
(line TotDeaMeRaA01S00U20210114T date, sort lcolor(red)) /// 19
(line TotDeaMeRaA01S00U20210121T date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210128T date, sort lcolor(red)) /// 21
(line TotDeaMeRaA01S00U20210204T date, sort lcolor(red)) /// 22
(line TotDeaMeRaA01S00U20210211T date, sort lcolor(red)) /// 23
(line TotDeaMeRaA01S00U20210218T date, sort lcolor(red)) /// 24
(line TotDeaMeRaA01S00U20210225T date, sort lcolor(red)) /// 25
(line TotDeaMeRaA01S00U20210226T date, sort lcolor(red)) /// 26
(line TotDeaMeRaA01S00U20210227T date, sort lcolor(red)) /// 27
(line TotDeaMeRaA01S00U20210228T date, sort lcolor(red)) /// 28
(line TotDeaMeRaA01S00U20210301T date, sort lcolor(red)) /// 29
(line TotDeaMeRaA01S00U20210303T date, sort lcolor(red)) /// 30
(line TotDeaMeRaA01S00U20210304T date, sort lcolor(red)) /// 31
(line TotDeaMeRaA01S00U20210305T date, sort lcolor(red)) /// 32
(line TotDeaMeRaA01S00U20210306T date, sort lcolor(red)) /// 33
(line TotDeaMeRaA01S00U20210307T date, sort lcolor(red)) /// 34
(line TotDeaMeRaA01S00U20210308T date, sort lcolor(red)) /// 35
(line TotDeaMeRaA01S00U20210309T date, sort lcolor(red)) /// 36
(line TotDeaMeRaA01S00U20210310T date, sort lcolor(red)) /// 37
(line TotDeaMeRaA01S00U20210311T date, sort lcolor(red)) /// 38
(line TotDeaMeRaA01S00U20210312T date, sort lcolor(red)) /// 39
(line TotDeaMeRaA01S00U20210313T date, sort lcolor(red)) /// 40
(line TotDeaMeRaA01S00U20210314T date, sort lcolor(red)) /// 41
(line TotDeaMeRaA01S00U20210315T date, sort lcolor(red)) /// 42
(line TotDeaMeRaA01S00U20210316T date, sort lcolor(red)) /// 43
(line TotDeaMeRaA01S00U20210317T date, sort lcolor(red)) /// 44
(line TotDeaMeRaA01S00U20210318T date, sort lcolor(red)) /// 45
(line TotDeaMeRaA01S00U20210319T date, sort lcolor(red)) /// 46
(line TotDeaMeRaA01S00U20210320T date, sort lcolor(red)) /// 47
(line TotDeaMeRaA01S00U20210321T date, sort lcolor(red)) /// 48
(line TotDeaMeRaA01S00U20210322T date, sort lcolor(red)) /// 49
(line TotDeaMeRaA01S00U20210323T date, sort lcolor(red)) /// 50
(line TotDeaMeRaA01S00U20210324T date, sort lcolor(red)) /// 51
(line TotDeaMeRaA01S00U20210325T date, sort lcolor(red)) /// 52
(line TotDeaMeRaA01S00U20210326T date, sort lcolor(red)) /// 53
(line TotDeaMeRaA01S00U20210327T date, sort lcolor(red)) /// 54
(line TotDeaMeRaA01S00U20210328T date, sort lcolor(red)) /// 55
(line TotDeaMeRaA01S00U20210329T date, sort lcolor(red)) /// 56
(line TotDeaMeRaA01S00U20210330T date, sort lcolor(red)) /// 57
(line TotDeaMeRaA01S00U20210331T date, sort lcolor(red)) /// 58
(line TotDeaMeRaA01S00U20210401T date, sort lcolor(red)) /// 59
(line TotDeaMeRaA01S00U20210402T date, sort lcolor(red)) /// 60
(line TotDeaMeRaA01S00U20210403T date, sort lcolor(red)) /// 61
(line TotDeaMeRaA01S00U20210404T date, sort lcolor(red)) /// 62
(line TotDeaMeRaA01S00U20210405T date, sort lcolor(red)) /// 63
(line TotDeaMeRaA01S00U20210406T date, sort lcolor(red)) /// 64
(line TotDeaMeRaA01S00U20210407T date, sort lcolor(red)) /// 65
(line TotDeaMeRaA01S00U20210408T date, sort lcolor(red)) /// 66
(line TotDeaMeRaA01S00U20210409T date, sort lcolor(red)) /// 67
(line TotDeaMeRaA01S00U20210410T date, sort lcolor(red)) /// 68
(line TotDeaMeRaA01S00U20210411T date, sort lcolor(red)) /// 69
(line TotDeaMeRaA01S00U20210412T date, sort lcolor(red)) /// 70
(line TotDeaMeRaA01S00U20210413T date, sort lcolor(red)) /// 71
(line TotDeaMeRaA01S00U20210414T date, sort lcolor(red)) /// 72
(line TotDeaMeRaA01S00U20210415T date, sort lcolor(red)) /// 73
(line TotDeaMeRaA01S00U20210416T date, sort lcolor(red)) /// 74
(line TotDeaMeRaA01S00U20210417T date, sort lcolor(red)) /// 75
(line TotDeaMeRaA01S00U20210418T date, sort lcolor(red)) /// 76
(line TotDeaMeRaA01S00U20210419T date, sort lcolor(red)) /// 77
(line TotDeaMeRaA01S00U20210420T date, sort lcolor(red)) /// 78
(line TotDeaMeRaA01S00U20210421T date, sort lcolor(red)) /// 79
(line TotDeaMeRaA01S00U20210422T date, sort lcolor(red)) /// 80
(line TotDeaMeRaA01S00U20210423T date, sort lcolor(red)) /// 81
(line TotDeaMeRaA01S00U20210424T date, sort lcolor(red)) /// 82
(line TotDeaMeRaA01S00U20210425T date, sort lcolor(red)) /// 83
(line TotDeaMeRaA01S00U20210426T date, sort lcolor(red)) /// 84
(line TotDeaMeRaA01S00U20210427T date, sort lcolor(red)) /// 85
(line TotDeaMeRaA01S00U20210428T date, sort lcolor(red)) /// 86
(line TotDeaMeRaA01S00U20210429T date, sort lcolor(red)) /// 87
(line TotDeaMeRaA01S00U20210430T date, sort lcolor(red)) /// 88
(line TotDeaMeRaA01S00U20210501T date, sort lcolor(red)) /// 89
(line TotDeaMeRaA01S00U20210502T date, sort lcolor(red)) /// 90
(line TotDeaMeRaA01S00U20210503T date, sort lcolor(red)) /// 91
(line TotDeaMeRaA01S00U20210504T date, sort lcolor(red)) /// 92
(line TotDeaMeRaA01S00U20210505T date, sort lcolor(red)) /// 93
(line TotDeaMeRaA01S00U20210506T date, sort lcolor(red)) /// 94
(line TotDeaMeRaA01S00U20210507T date, sort lcolor(red)) /// 95
(line TotDeaMeRaA01S00U20210508T date, sort lcolor(red)) /// 96
(line TotDeaMeRaA01S00U20210509T date, sort lcolor(red)) /// 97
(line TotDeaMeRaA01S00U20210510T date, sort lcolor(red)) /// 98
(line TotDeaMeRaA01S00U20210511T date, sort lcolor(red)) /// 99
(line TotDeaMeRaA01S00U20210512T date, sort lcolor(red)) /// 100
(line TotDeaMeRaA01S00U20210513T date, sort lcolor(red)) /// 101
(line TotDeaMeRaA01S00U20210514T date, sort lcolor(red)) /// 102
(line TotDeaMeRaA01S00U20210515T date, sort lcolor(red)) /// 103
(line TotDeaMeRaA01S00U20210516T date, sort lcolor(red)) /// 104
(line TotDeaMeRaA01S00U20210517T date, sort lcolor(red)) /// 105
(line TotDeaMeRaA01S00U20210518T date, sort lcolor(red)) /// 106
(line TotDeaMeRaA01S00U20210519T date, sort lcolor(red)) /// 107
(line TotDeaMeRaA01S00U20210520T date, sort lcolor(red)) /// 108
(line TotDeaMeRaA01S00U20210521T date, sort lcolor(red)) /// 109
(line TotDeaMeRaA01S00U20210522T date, sort lcolor(red)) /// 110
(line TotDeaMeRaA01S00U20210523T date, sort lcolor(red)) /// 111
(line TotDeaMeRaA01S00U20210524T date, sort lcolor(red)) /// 112
(line TotDeaMeRaA01S00U20210525T date, sort lcolor(red)) /// 113
(line TotDeaMeRaA01S00U20210526T date, sort lcolor(red)) /// 114
(line TotDeaMeRaA01S00U20210527T date, sort lcolor(red)) /// 115
(line TotDeaMeRaA01S00U20210528T date, sort lcolor(red)) /// 116
(line TotDeaMeRaA01S00U20210529T date, sort lcolor(red)) /// 117
(line TotDeaMeRaA01S00U20210530T date, sort lcolor(red)) /// 118
(line TotDeaMeRaA01S00U20210531T date, sort lcolor(red)) /// 119
(line TotDeaMeRaA01S00U20210601T date, sort lcolor(red)) /// 120
(line TotDeaMeRaA01S00U20210602T date, sort lcolor(red)) /// 121
(line TotDeaMeRaA01S00U20210603T date, sort lcolor(red)) /// 122
(line TotDeaMeRaA01S00U20210604T date, sort lcolor(red)) /// 123
(line TotDeaMeRaA01S00U20210605T date, sort lcolor(red)) /// 124
(line TotDeaMeRaA01S00U20210606T date, sort lcolor(red)) /// 125
(line TotDeaMeRaA01S00U20210607T date, sort lcolor(red)) /// 126
(line TotDeaMeRaA01S00U20210608T date, sort lcolor(red)) /// 127
(line TotDeaMeRaA01S00U20210609T date, sort lcolor(red)) /// 128
(line TotDeaMeRaA01S00U20210610T date, sort lcolor(red)) /// 129
(line TotDeaMeRaA01S00U20210611T date, sort lcolor(red)) /// 130
(line TotDeaMeRaA01S00U20210612T date, sort lcolor(red)) /// 131
(line TotDeaMeRaA01S00U20210613T date, sort lcolor(red)) /// 132
(line TotDeaMeRaA01S00U20210614T date, sort lcolor(red)) /// 133
(line TotDeaMeRaA01S00U20210615T date, sort lcolor(red)) /// 134
(line TotDeaMeRaA01S00U20210616T date, sort lcolor(red)) /// 135
(line TotDeaMeRaA01S00U20210617T date, sort lcolor(red)) /// 136
(line TotDeaMeRaA01S00U20210618T date, sort lcolor(red)) /// 137
(line TotDeaMeRaA01S00U20210619T date, sort lcolor(red)) /// 138
(line TotDeaMeRaA01S00U20210620T date, sort lcolor(red)) /// 139
(line TotDeaMeRaA01S00U20210621T date, sort lcolor(red)) /// 140
(line TotDeaMeRaA01S00U20210622T date, sort lcolor(red)) /// 141
(line TotDeaMeRaA01S00U20210623T date, sort lcolor(red)) /// 142
(line TotDeaMeRaA01S00U20210624T date, sort lcolor(red)) /// 143
(line TotDeaMeRaA01S00U20210625T date, sort lcolor(red)) /// 144
(line TotDeaMeRaA01S00U20210626T date, sort lcolor(red)) /// 145
(line TotDeaMeRaA01S00U20210627T date, sort lcolor(red)) /// 146
(line TotDeaMeRaA01S00U20210628T date, sort lcolor(red)) /// 147
(line TotDeaMeRaA01S00U20210629T date, sort lcolor(red)) /// 148
(line TotDeaMeRaA01S00U20210630T date, sort lcolor(red)) /// 149
(line TotDeaMeRaA01S00U20210701T date, sort lcolor(red)) /// 150
(line TotDeaMeRaA01S00U20210702T date, sort lcolor(red)) /// 151
(line TotDeaMeRaA01S00U20210703T date, sort lcolor(red)) /// 152
(line TotDeaMeRaA01S00U20210704T date, sort lcolor(red)) /// 153
(line TotDeaMeRaA01S00U20210705T date, sort lcolor(red)) /// 154
(line TotDeaMeRaA01S00U20210706T date, sort lcolor(red)) /// 155
(line TotDeaMeRaA01S00U20210707T date, sort lcolor(red)) /// 156
(line TotDeaMeRaA01S00U20210708T date, sort lcolor(red)) /// 157
(line TotDeaMeRaA01S00U20210709T date, sort lcolor(red)) /// 158
(line TotDeaMeRaA01S00U20210710T date, sort lcolor(red)) /// 159
(line TotDeaMeRaA01S00U20210711T date, sort lcolor(red)) /// 160
(line TotDeaMeRaA01S00U20210712T date, sort lcolor(red)) /// 161
(line TotDeaMeRaA01S00U20210713T date, sort lcolor(red)) /// 162
(line TotDeaMeRaA01S00U20210714T date, sort lcolor(red)) /// 163
(line TotDeaMeRaA01S00U20210715T date, sort lcolor(red)) /// 164
(line TotDeaMeRaA01S00U20210716T date, sort lcolor(red)) /// 165
(line TotDeaMeRaA01S00U20210717T date, sort lcolor(red)) /// 166
(line TotDeaMeRaA01S00U20210718T date, sort lcolor(red)) /// 167
(line TotDeaMeRaA01S00U20210719T date, sort lcolor(red)) /// 168
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths DELP divided by JOHN) title("COVID-19 total deaths, $country, DELP divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 33a COVID-19 total deaths, $country, DELP, Times.gph", replace
qui graph export "graph 33a COVID-19 total deaths, $country, DELP, Times.pdf", replace





*********

* total deaths, Times, together, without extremes 159

twoway  ///
(line TotDeaMeRaA01S00U20200723T date, sort lcolor(red) lpattern(dash)) /// 1
(line TotDeaMeRaA01S00U20200919T date, sort lcolor(red) lpattern(dash)) /// 2
(line TotDeaMeRaA01S00U20200926T date, sort lcolor(red) lpattern(dash)) /// 3
(line TotDeaMeRaA01S00U20201001T date, sort lcolor(red) lpattern(dash)) /// 4
(line TotDeaMeRaA01S00U20201008T date, sort lcolor(red) lpattern(dash)) /// 5
(line TotDeaMeRaA01S00U20201015T date, sort lcolor(red) lpattern(dash)) /// 6
(line TotDeaMeRaA01S00U20201022T date, sort lcolor(red) lpattern(dash)) /// 7
(line TotDeaMeRaA01S00U20201029T date, sort lcolor(red) lpattern(dash)) /// 8
(line TotDeaMeRaA01S00U20201105T date, sort lcolor(red) lpattern(dash)) /// 9
(line TotDeaMeRaA01S00U20201112T date, sort lcolor(red) lpattern(dash)) /// 10
(line TotDeaMeRaA01S00U20201119T date, sort lcolor(red)) /// 11
(line TotDeaMeRaA01S00U20201126T date, sort lcolor(red)) /// 12
(line TotDeaMeRaA01S00U20201203T date, sort lcolor(red)) /// 13
(line TotDeaMeRaA01S00U20201210T date, sort lcolor(red)) /// 14
(line TotDeaMeRaA01S00U20201217T date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20201224T date, sort lcolor(red)) /// 16
(line TotDeaMeRaA01S00U20201231T date, sort lcolor(red)) /// 17
(line TotDeaMeRaA01S00U20210107T date, sort lcolor(red)) /// 18
(line TotDeaMeRaA01S00U20210114T date, sort lcolor(red)) /// 19
(line TotDeaMeRaA01S00U20210121T date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210128T date, sort lcolor(red)) /// 21
(line TotDeaMeRaA01S00U20210204T date, sort lcolor(red)) /// 22
(line TotDeaMeRaA01S00U20210225T date, sort lcolor(red)) /// 23
(line TotDeaMeRaA01S00U20210226T date, sort lcolor(red)) /// 24
(line TotDeaMeRaA01S00U20210227T date, sort lcolor(red)) /// 25
(line TotDeaMeRaA01S00U20210228T date, sort lcolor(red)) /// 26
(line TotDeaMeRaA01S00U20210301T date, sort lcolor(red)) /// 27
(line TotDeaMeRaA01S00U20210303T date, sort lcolor(red)) /// 28
(line TotDeaMeRaA01S00U20210304T date, sort lcolor(red)) /// 29
(line TotDeaMeRaA01S00U20210305T date, sort lcolor(red)) /// 30
(line TotDeaMeRaA01S00U20210306T date, sort lcolor(red)) /// 31
(line TotDeaMeRaA01S00U20210307T date, sort lcolor(red)) /// 32
(line TotDeaMeRaA01S00U20210308T date, sort lcolor(red)) /// 33
(line TotDeaMeRaA01S00U20210309T date, sort lcolor(red)) /// 34
(line TotDeaMeRaA01S00U20210310T date, sort lcolor(red)) /// 35
(line TotDeaMeRaA01S00U20210311T date, sort lcolor(red)) /// 36
(line TotDeaMeRaA01S00U20210312T date, sort lcolor(red)) /// 37
(line TotDeaMeRaA01S00U20210313T date, sort lcolor(red)) /// 38
(line TotDeaMeRaA01S00U20210314T date, sort lcolor(red)) /// 39
(line TotDeaMeRaA01S00U20210315T date, sort lcolor(red)) /// 40
(line TotDeaMeRaA01S00U20210316T date, sort lcolor(red)) /// 41
(line TotDeaMeRaA01S00U20210317T date, sort lcolor(red)) /// 42
(line TotDeaMeRaA01S00U20210318T date, sort lcolor(red)) /// 43
(line TotDeaMeRaA01S00U20210319T date, sort lcolor(red)) /// 44
(line TotDeaMeRaA01S00U20210320T date, sort lcolor(red)) /// 45
(line TotDeaMeRaA01S00U20210321T date, sort lcolor(red)) /// 46
(line TotDeaMeRaA01S00U20210322T date, sort lcolor(red)) /// 47
(line TotDeaMeRaA01S00U20210323T date, sort lcolor(red)) /// 48
(line TotDeaMeRaA01S00U20210324T date, sort lcolor(red)) /// 49
(line TotDeaMeRaA01S00U20210325T date, sort lcolor(red)) /// 50
(line TotDeaMeRaA01S00U20210326T date, sort lcolor(red)) /// 51
(line TotDeaMeRaA01S00U20210327T date, sort lcolor(red)) /// 52
(line TotDeaMeRaA01S00U20210328T date, sort lcolor(red)) /// 53
(line TotDeaMeRaA01S00U20210329T date, sort lcolor(red)) /// 54
(line TotDeaMeRaA01S00U20210330T date, sort lcolor(red)) /// 55
(line TotDeaMeRaA01S00U20210331T date, sort lcolor(red)) /// 56
(line TotDeaMeRaA01S00U20210401T date, sort lcolor(red)) /// 57
(line TotDeaMeRaA01S00U20210402T date, sort lcolor(red)) /// 58
(line TotDeaMeRaA01S00U20210403T date, sort lcolor(red)) /// 59
(line TotDeaMeRaA01S00U20210404T date, sort lcolor(red)) /// 60
(line TotDeaMeRaA01S00U20210405T date, sort lcolor(red)) /// 61
(line TotDeaMeRaA01S00U20210406T date, sort lcolor(red)) /// 62
(line TotDeaMeRaA01S00U20210407T date, sort lcolor(red)) /// 63
(line TotDeaMeRaA01S00U20210408T date, sort lcolor(red)) /// 64
(line TotDeaMeRaA01S00U20210409T date, sort lcolor(red)) /// 65
(line TotDeaMeRaA01S00U20210410T date, sort lcolor(red)) /// 66
(line TotDeaMeRaA01S00U20210411T date, sort lcolor(red)) /// 67
(line TotDeaMeRaA01S00U20210412T date, sort lcolor(red)) /// 68
(line TotDeaMeRaA01S00U20210413T date, sort lcolor(red)) /// 69
(line TotDeaMeRaA01S00U20210414T date, sort lcolor(red)) /// 70
(line TotDeaMeRaA01S00U20210415T date, sort lcolor(red)) /// 71
(line TotDeaMeRaA01S00U20210416T date, sort lcolor(red)) /// 72
(line TotDeaMeRaA01S00U20210417T date, sort lcolor(red)) /// 73
(line TotDeaMeRaA01S00U20210418T date, sort lcolor(red)) /// 74
(line TotDeaMeRaA01S00U20210419T date, sort lcolor(red)) /// 75
(line TotDeaMeRaA01S00U20210420T date, sort lcolor(red)) /// 76
(line TotDeaMeRaA01S00U20210421T date, sort lcolor(red)) /// 77
(line TotDeaMeRaA01S00U20210422T date, sort lcolor(red)) /// 78
(line TotDeaMeRaA01S00U20210423T date, sort lcolor(red)) /// 79
(line TotDeaMeRaA01S00U20210424T date, sort lcolor(red)) /// 80
(line TotDeaMeRaA01S00U20210425T date, sort lcolor(red)) /// 81
(line TotDeaMeRaA01S00U20210426T date, sort lcolor(red)) /// 82
(line TotDeaMeRaA01S00U20210427T date, sort lcolor(red)) /// 83
(line TotDeaMeRaA01S00U20210428T date, sort lcolor(red)) /// 84
(line TotDeaMeRaA01S00U20210429T date, sort lcolor(red)) /// 85
(line TotDeaMeRaA01S00U20210430T date, sort lcolor(red)) /// 86
(line TotDeaMeRaA01S00U20210501T date, sort lcolor(red)) /// 87
(line TotDeaMeRaA01S00U20210502T date, sort lcolor(red)) /// 88
(line TotDeaMeRaA01S00U20210503T date, sort lcolor(red)) /// 89
(line TotDeaMeRaA01S00U20210504T date, sort lcolor(red)) /// 90
(line TotDeaMeRaA01S00U20210505T date, sort lcolor(red)) /// 91
(line TotDeaMeRaA01S00U20210506T date, sort lcolor(red)) /// 92
(line TotDeaMeRaA01S00U20210507T date, sort lcolor(red)) /// 93
(line TotDeaMeRaA01S00U20210508T date, sort lcolor(red)) /// 94
(line TotDeaMeRaA01S00U20210509T date, sort lcolor(red)) /// 95
(line TotDeaMeRaA01S00U20210510T date, sort lcolor(red)) /// 96
(line TotDeaMeRaA01S00U20210511T date, sort lcolor(red)) /// 97
(line TotDeaMeRaA01S00U20210512T date, sort lcolor(red)) /// 98
(line TotDeaMeRaA01S00U20210513T date, sort lcolor(red)) /// 99
(line TotDeaMeRaA01S00U20210514T date, sort lcolor(red)) /// 100
(line TotDeaMeRaA01S00U20210515T date, sort lcolor(red)) /// 101
(line TotDeaMeRaA01S00U20210516T date, sort lcolor(red)) /// 102
(line TotDeaMeRaA01S00U20210517T date, sort lcolor(red)) /// 103
(line TotDeaMeRaA01S00U20210518T date, sort lcolor(red)) /// 104
(line TotDeaMeRaA01S00U20210519T date, sort lcolor(red)) /// 105
(line TotDeaMeRaA01S00U20210520T date, sort lcolor(red)) /// 106
(line TotDeaMeRaA01S00U20210521T date, sort lcolor(red)) /// 107
(line TotDeaMeRaA01S00U20210522T date, sort lcolor(red)) /// 108
(line TotDeaMeRaA01S00U20210530T date, sort lcolor(red)) /// 109
(line TotDeaMeRaA01S00U20210531T date, sort lcolor(red)) /// 110
(line TotDeaMeRaA01S00U20210601T date, sort lcolor(red)) /// 111
(line TotDeaMeRaA01S00U20210602T date, sort lcolor(red)) /// 112
(line TotDeaMeRaA01S00U20210603T date, sort lcolor(red)) /// 113
(line TotDeaMeRaA01S00U20210604T date, sort lcolor(red)) /// 114
(line TotDeaMeRaA01S00U20210605T date, sort lcolor(red)) /// 115
(line TotDeaMeRaA01S00U20210606T date, sort lcolor(red)) /// 116
(line TotDeaMeRaA01S00U20210607T date, sort lcolor(red)) /// 117
(line TotDeaMeRaA01S00U20210608T date, sort lcolor(red)) /// 118
(line TotDeaMeRaA01S00U20210609T date, sort lcolor(red)) /// 119
(line TotDeaMeRaA01S00U20210610T date, sort lcolor(red)) /// 120
(line TotDeaMeRaA01S00U20210611T date, sort lcolor(red)) /// 121
(line TotDeaMeRaA01S00U20210612T date, sort lcolor(red)) /// 122
(line TotDeaMeRaA01S00U20210613T date, sort lcolor(red)) /// 123
(line TotDeaMeRaA01S00U20210614T date, sort lcolor(red)) /// 124
(line TotDeaMeRaA01S00U20210615T date, sort lcolor(red)) /// 125
(line TotDeaMeRaA01S00U20210616T date, sort lcolor(red)) /// 126
(line TotDeaMeRaA01S00U20210617T date, sort lcolor(red)) /// 127
(line TotDeaMeRaA01S00U20210618T date, sort lcolor(red)) /// 128
(line TotDeaMeRaA01S00U20210619T date, sort lcolor(red)) /// 129
(line TotDeaMeRaA01S00U20210620T date, sort lcolor(red)) /// 130
(line TotDeaMeRaA01S00U20210621T date, sort lcolor(red)) /// 131
(line TotDeaMeRaA01S00U20210622T date, sort lcolor(red)) /// 132
(line TotDeaMeRaA01S00U20210623T date, sort lcolor(red)) /// 133
(line TotDeaMeRaA01S00U20210624T date, sort lcolor(red)) /// 134
(line TotDeaMeRaA01S00U20210625T date, sort lcolor(red)) /// 135
(line TotDeaMeRaA01S00U20210626T date, sort lcolor(red)) /// 136
(line TotDeaMeRaA01S00U20210627T date, sort lcolor(red)) /// 137
(line TotDeaMeRaA01S00U20210628T date, sort lcolor(red)) /// 138
(line TotDeaMeRaA01S00U20210629T date, sort lcolor(red)) /// 139
(line TotDeaMeRaA01S00U20210630T date, sort lcolor(red)) /// 140
(line TotDeaMeRaA01S00U20210701T date, sort lcolor(red)) /// 141
(line TotDeaMeRaA01S00U20210702T date, sort lcolor(red)) /// 142
(line TotDeaMeRaA01S00U20210703T date, sort lcolor(red)) /// 143
(line TotDeaMeRaA01S00U20210704T date, sort lcolor(red)) /// 144
(line TotDeaMeRaA01S00U20210705T date, sort lcolor(red)) /// 145
(line TotDeaMeRaA01S00U20210706T date, sort lcolor(red)) /// 146
(line TotDeaMeRaA01S00U20210707T date, sort lcolor(red)) /// 147
(line TotDeaMeRaA01S00U20210708T date, sort lcolor(red)) /// 148
(line TotDeaMeRaA01S00U20210709T date, sort lcolor(red)) /// 149
(line TotDeaMeRaA01S00U20210710T date, sort lcolor(red)) /// 150
(line TotDeaMeRaA01S00U20210711T date, sort lcolor(red)) /// 151
(line TotDeaMeRaA01S00U20210712T date, sort lcolor(red)) /// 152
(line TotDeaMeRaA01S00U20210713T date, sort lcolor(red)) /// 153
(line TotDeaMeRaA01S00U20210714T date, sort lcolor(red)) /// 154
(line TotDeaMeRaA01S00U20210715T date, sort lcolor(red)) /// 155
(line TotDeaMeRaA01S00U20210716T date, sort lcolor(red)) /// 156
(line TotDeaMeRaA01S00U20210717T date, sort lcolor(red)) /// 157
(line TotDeaMeRaA01S00U20210718T date, sort lcolor(red)) /// 158
(line TotDeaMeRaA01S00U20210719T date, sort lcolor(red)) /// 159
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths DELP divided by JOHN) title("COVID-19 total deaths, $country, DELP divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario;without extremes i.e. > 2 times max reported 170,000", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 33b COVID-19 total deaths, $country, DELP, wo extreme, Times.gph", replace
qui graph export "graph 33b COVID-19 total deaths, $country, DELP, wo extreme, Times.pdf", replace


*


*********

* total deaths, Percent, together, with extremes 168

twoway  ///
(line TotDeaMeRaA01S00U20200723P date, sort lcolor(red) lpattern(dash)) /// 1
(line TotDeaMeRaA01S00U20200919P date, sort lcolor(red) lpattern(dash)) /// 2
(line TotDeaMeRaA01S00U20200926P date, sort lcolor(red) lpattern(dash)) /// 3
(line TotDeaMeRaA01S00U20201001P date, sort lcolor(red) lpattern(dash)) /// 4
(line TotDeaMeRaA01S00U20201008P date, sort lcolor(red) lpattern(dash)) /// 5
(line TotDeaMeRaA01S00U20201015P date, sort lcolor(red) lpattern(dash)) /// 6
(line TotDeaMeRaA01S00U20201022P date, sort lcolor(red) lpattern(dash)) /// 7
(line TotDeaMeRaA01S00U20201029P date, sort lcolor(red) lpattern(dash)) /// 8
(line TotDeaMeRaA01S00U20201105P date, sort lcolor(red) lpattern(dash)) /// 9
(line TotDeaMeRaA01S00U20201112P date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line TotDeaMeRaA01S00U20201119P date, sort lcolor(red)) /// 11 v4
(line TotDeaMeRaA01S00U20201126P date, sort lcolor(red)) /// 12
(line TotDeaMeRaA01S00U20201203P date, sort lcolor(red)) /// 13
(line TotDeaMeRaA01S00U20201210P date, sort lcolor(red)) /// 14
(line TotDeaMeRaA01S00U20201217P date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20201224P date, sort lcolor(red)) /// 16
(line TotDeaMeRaA01S00U20201231P date, sort lcolor(red)) /// 17
(line TotDeaMeRaA01S00U20210107P date, sort lcolor(red)) /// 18
(line TotDeaMeRaA01S00U20210114P date, sort lcolor(red)) /// 19
(line TotDeaMeRaA01S00U20210121P date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210128P date, sort lcolor(red)) /// 21
(line TotDeaMeRaA01S00U20210204P date, sort lcolor(red)) /// 22
(line TotDeaMeRaA01S00U20210211P date, sort lcolor(red)) /// 23
(line TotDeaMeRaA01S00U20210218P date, sort lcolor(red)) /// 24
(line TotDeaMeRaA01S00U20210225P date, sort lcolor(red)) /// 25
(line TotDeaMeRaA01S00U20210226P date, sort lcolor(red)) /// 26
(line TotDeaMeRaA01S00U20210227P date, sort lcolor(red)) /// 27
(line TotDeaMeRaA01S00U20210228P date, sort lcolor(red)) /// 28
(line TotDeaMeRaA01S00U20210301P date, sort lcolor(red)) /// 29
(line TotDeaMeRaA01S00U20210303P date, sort lcolor(red)) /// 30
(line TotDeaMeRaA01S00U20210304P date, sort lcolor(red)) /// 31
(line TotDeaMeRaA01S00U20210305P date, sort lcolor(red)) /// 32
(line TotDeaMeRaA01S00U20210306P date, sort lcolor(red)) /// 33
(line TotDeaMeRaA01S00U20210307P date, sort lcolor(red)) /// 34
(line TotDeaMeRaA01S00U20210308P date, sort lcolor(red)) /// 35
(line TotDeaMeRaA01S00U20210309P date, sort lcolor(red)) /// 36
(line TotDeaMeRaA01S00U20210310P date, sort lcolor(red)) /// 37
(line TotDeaMeRaA01S00U20210311P date, sort lcolor(red)) /// 38
(line TotDeaMeRaA01S00U20210312P date, sort lcolor(red)) /// 39
(line TotDeaMeRaA01S00U20210313P date, sort lcolor(red)) /// 40
(line TotDeaMeRaA01S00U20210314P date, sort lcolor(red)) /// 41
(line TotDeaMeRaA01S00U20210315P date, sort lcolor(red)) /// 42
(line TotDeaMeRaA01S00U20210316P date, sort lcolor(red)) /// 43
(line TotDeaMeRaA01S00U20210317P date, sort lcolor(red)) /// 44
(line TotDeaMeRaA01S00U20210318P date, sort lcolor(red)) /// 45
(line TotDeaMeRaA01S00U20210319P date, sort lcolor(red)) /// 46
(line TotDeaMeRaA01S00U20210320P date, sort lcolor(red)) /// 47
(line TotDeaMeRaA01S00U20210321P date, sort lcolor(red)) /// 48
(line TotDeaMeRaA01S00U20210322P date, sort lcolor(red)) /// 49
(line TotDeaMeRaA01S00U20210323P date, sort lcolor(red)) /// 50
(line TotDeaMeRaA01S00U20210324P date, sort lcolor(red)) /// 51
(line TotDeaMeRaA01S00U20210325P date, sort lcolor(red)) /// 52
(line TotDeaMeRaA01S00U20210326P date, sort lcolor(red)) /// 53
(line TotDeaMeRaA01S00U20210327P date, sort lcolor(red)) /// 54
(line TotDeaMeRaA01S00U20210328P date, sort lcolor(red)) /// 55
(line TotDeaMeRaA01S00U20210329P date, sort lcolor(red)) /// 56
(line TotDeaMeRaA01S00U20210330P date, sort lcolor(red)) /// 57
(line TotDeaMeRaA01S00U20210331P date, sort lcolor(red)) /// 58
(line TotDeaMeRaA01S00U20210401P date, sort lcolor(red)) /// 59
(line TotDeaMeRaA01S00U20210402P date, sort lcolor(red)) /// 60
(line TotDeaMeRaA01S00U20210403P date, sort lcolor(red)) /// 61
(line TotDeaMeRaA01S00U20210404P date, sort lcolor(red)) /// 62
(line TotDeaMeRaA01S00U20210405P date, sort lcolor(red)) /// 63
(line TotDeaMeRaA01S00U20210406P date, sort lcolor(red)) /// 64
(line TotDeaMeRaA01S00U20210407P date, sort lcolor(red)) /// 65
(line TotDeaMeRaA01S00U20210408P date, sort lcolor(red)) /// 66
(line TotDeaMeRaA01S00U20210409P date, sort lcolor(red)) /// 67
(line TotDeaMeRaA01S00U20210410P date, sort lcolor(red)) /// 68
(line TotDeaMeRaA01S00U20210411P date, sort lcolor(red)) /// 69
(line TotDeaMeRaA01S00U20210412P date, sort lcolor(red)) /// 70
(line TotDeaMeRaA01S00U20210413P date, sort lcolor(red)) /// 71
(line TotDeaMeRaA01S00U20210414P date, sort lcolor(red)) /// 72
(line TotDeaMeRaA01S00U20210415P date, sort lcolor(red)) /// 73
(line TotDeaMeRaA01S00U20210416P date, sort lcolor(red)) /// 74
(line TotDeaMeRaA01S00U20210417P date, sort lcolor(red)) /// 75
(line TotDeaMeRaA01S00U20210418P date, sort lcolor(red)) /// 76
(line TotDeaMeRaA01S00U20210419P date, sort lcolor(red)) /// 77
(line TotDeaMeRaA01S00U20210420P date, sort lcolor(red)) /// 78
(line TotDeaMeRaA01S00U20210421P date, sort lcolor(red)) /// 79
(line TotDeaMeRaA01S00U20210422P date, sort lcolor(red)) /// 80
(line TotDeaMeRaA01S00U20210423P date, sort lcolor(red)) /// 81
(line TotDeaMeRaA01S00U20210424P date, sort lcolor(red)) /// 82
(line TotDeaMeRaA01S00U20210425P date, sort lcolor(red)) /// 83
(line TotDeaMeRaA01S00U20210426P date, sort lcolor(red)) /// 84
(line TotDeaMeRaA01S00U20210427P date, sort lcolor(red)) /// 85
(line TotDeaMeRaA01S00U20210428P date, sort lcolor(red)) /// 86
(line TotDeaMeRaA01S00U20210429P date, sort lcolor(red)) /// 87
(line TotDeaMeRaA01S00U20210430P date, sort lcolor(red)) /// 88
(line TotDeaMeRaA01S00U20210501P date, sort lcolor(red)) /// 89
(line TotDeaMeRaA01S00U20210502P date, sort lcolor(red)) /// 90
(line TotDeaMeRaA01S00U20210503P date, sort lcolor(red)) /// 91
(line TotDeaMeRaA01S00U20210504P date, sort lcolor(red)) /// 92
(line TotDeaMeRaA01S00U20210505P date, sort lcolor(red)) /// 93
(line TotDeaMeRaA01S00U20210506P date, sort lcolor(red)) /// 94
(line TotDeaMeRaA01S00U20210507P date, sort lcolor(red)) /// 95
(line TotDeaMeRaA01S00U20210508P date, sort lcolor(red)) /// 96
(line TotDeaMeRaA01S00U20210509P date, sort lcolor(red)) /// 97
(line TotDeaMeRaA01S00U20210510P date, sort lcolor(red)) /// 98
(line TotDeaMeRaA01S00U20210511P date, sort lcolor(red)) /// 99
(line TotDeaMeRaA01S00U20210512P date, sort lcolor(red)) /// 100
(line TotDeaMeRaA01S00U20210513P date, sort lcolor(red)) /// 101
(line TotDeaMeRaA01S00U20210514P date, sort lcolor(red)) /// 102
(line TotDeaMeRaA01S00U20210515P date, sort lcolor(red)) /// 103
(line TotDeaMeRaA01S00U20210516P date, sort lcolor(red)) /// 104
(line TotDeaMeRaA01S00U20210517P date, sort lcolor(red)) /// 105
(line TotDeaMeRaA01S00U20210518P date, sort lcolor(red)) /// 106
(line TotDeaMeRaA01S00U20210519P date, sort lcolor(red)) /// 107
(line TotDeaMeRaA01S00U20210520P date, sort lcolor(red)) /// 108
(line TotDeaMeRaA01S00U20210521P date, sort lcolor(red)) /// 109
(line TotDeaMeRaA01S00U20210522P date, sort lcolor(red)) /// 110
(line TotDeaMeRaA01S00U20210523P date, sort lcolor(red)) /// 111
(line TotDeaMeRaA01S00U20210524P date, sort lcolor(red)) /// 112
(line TotDeaMeRaA01S00U20210525P date, sort lcolor(red)) /// 113
(line TotDeaMeRaA01S00U20210526P date, sort lcolor(red)) /// 114
(line TotDeaMeRaA01S00U20210527P date, sort lcolor(red)) /// 115
(line TotDeaMeRaA01S00U20210528P date, sort lcolor(red)) /// 116
(line TotDeaMeRaA01S00U20210529P date, sort lcolor(red)) /// 117
(line TotDeaMeRaA01S00U20210530P date, sort lcolor(red)) /// 118
(line TotDeaMeRaA01S00U20210531P date, sort lcolor(red)) /// 119
(line TotDeaMeRaA01S00U20210601P date, sort lcolor(red)) /// 120
(line TotDeaMeRaA01S00U20210602P date, sort lcolor(red)) /// 121
(line TotDeaMeRaA01S00U20210603P date, sort lcolor(red)) /// 122
(line TotDeaMeRaA01S00U20210604P date, sort lcolor(red)) /// 123
(line TotDeaMeRaA01S00U20210605P date, sort lcolor(red)) /// 124
(line TotDeaMeRaA01S00U20210606P date, sort lcolor(red)) /// 125
(line TotDeaMeRaA01S00U20210607P date, sort lcolor(red)) /// 126
(line TotDeaMeRaA01S00U20210608P date, sort lcolor(red)) /// 127
(line TotDeaMeRaA01S00U20210609P date, sort lcolor(red)) /// 128
(line TotDeaMeRaA01S00U20210610P date, sort lcolor(red)) /// 129
(line TotDeaMeRaA01S00U20210611P date, sort lcolor(red)) /// 130
(line TotDeaMeRaA01S00U20210612P date, sort lcolor(red)) /// 131
(line TotDeaMeRaA01S00U20210613P date, sort lcolor(red)) /// 132
(line TotDeaMeRaA01S00U20210614P date, sort lcolor(red)) /// 133
(line TotDeaMeRaA01S00U20210615P date, sort lcolor(red)) /// 134
(line TotDeaMeRaA01S00U20210616P date, sort lcolor(red)) /// 135
(line TotDeaMeRaA01S00U20210617P date, sort lcolor(red)) /// 136
(line TotDeaMeRaA01S00U20210618P date, sort lcolor(red)) /// 137
(line TotDeaMeRaA01S00U20210619P date, sort lcolor(red)) /// 138
(line TotDeaMeRaA01S00U20210620P date, sort lcolor(red)) /// 139
(line TotDeaMeRaA01S00U20210621P date, sort lcolor(red)) /// 140
(line TotDeaMeRaA01S00U20210622P date, sort lcolor(red)) /// 141
(line TotDeaMeRaA01S00U20210623P date, sort lcolor(red)) /// 142
(line TotDeaMeRaA01S00U20210624P date, sort lcolor(red)) /// 143
(line TotDeaMeRaA01S00U20210625P date, sort lcolor(red)) /// 144
(line TotDeaMeRaA01S00U20210626P date, sort lcolor(red)) /// 145
(line TotDeaMeRaA01S00U20210627P date, sort lcolor(red)) /// 146
(line TotDeaMeRaA01S00U20210628P date, sort lcolor(red)) /// 147
(line TotDeaMeRaA01S00U20210629P date, sort lcolor(red)) /// 148
(line TotDeaMeRaA01S00U20210630P date, sort lcolor(red)) /// 149
(line TotDeaMeRaA01S00U20210701P date, sort lcolor(red)) /// 150
(line TotDeaMeRaA01S00U20210702P date, sort lcolor(red)) /// 151
(line TotDeaMeRaA01S00U20210703P date, sort lcolor(red)) /// 152
(line TotDeaMeRaA01S00U20210704P date, sort lcolor(red)) /// 153
(line TotDeaMeRaA01S00U20210705P date, sort lcolor(red)) /// 154
(line TotDeaMeRaA01S00U20210706P date, sort lcolor(red)) /// 155
(line TotDeaMeRaA01S00U20210707P date, sort lcolor(red)) /// 156
(line TotDeaMeRaA01S00U20210708P date, sort lcolor(red)) /// 157
(line TotDeaMeRaA01S00U20210709P date, sort lcolor(red)) /// 158
(line TotDeaMeRaA01S00U20210710P date, sort lcolor(red)) /// 159
(line TotDeaMeRaA01S00U20210711P date, sort lcolor(red)) /// 160
(line TotDeaMeRaA01S00U20210712P date, sort lcolor(red)) /// 161
(line TotDeaMeRaA01S00U20210713P date, sort lcolor(red)) /// 162
(line TotDeaMeRaA01S00U20210714P date, sort lcolor(red)) /// 163
(line TotDeaMeRaA01S00U20210715P date, sort lcolor(red)) /// 164
(line TotDeaMeRaA01S00U20210716P date, sort lcolor(red)) /// 165
(line TotDeaMeRaA01S00U20210717P date, sort lcolor(red)) /// 166
(line TotDeaMeRaA01S00U20210718P date, sort lcolor(red)) /// 167
(line TotDeaMeRaA01S00U20210719P date, sort lcolor(red)) /// 168
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths DELP percent JOHN) title("COVID-19 total deaths, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 34a COVID-19 total deaths, $country, DELP, Percent.gph", replace
qui graph export "graph 34a COVID-19 total deaths, $country, DELP, Percent.pdf", replace





*********

* total deaths, Percent, together, without extremes 159

twoway  ///
(line TotDeaMeRaA01S00U20200723P date, sort lcolor(red) lpattern(dash)) /// 1
(line TotDeaMeRaA01S00U20200919P date, sort lcolor(red) lpattern(dash)) /// 2
(line TotDeaMeRaA01S00U20200926P date, sort lcolor(red) lpattern(dash)) /// 3
(line TotDeaMeRaA01S00U20201001P date, sort lcolor(red) lpattern(dash)) /// 4
(line TotDeaMeRaA01S00U20201008P date, sort lcolor(red) lpattern(dash)) /// 5
(line TotDeaMeRaA01S00U20201015P date, sort lcolor(red) lpattern(dash)) /// 6
(line TotDeaMeRaA01S00U20201022P date, sort lcolor(red) lpattern(dash)) /// 7
(line TotDeaMeRaA01S00U20201029P date, sort lcolor(red) lpattern(dash)) /// 8
(line TotDeaMeRaA01S00U20201105P date, sort lcolor(red) lpattern(dash)) /// 9
(line TotDeaMeRaA01S00U20201112P date, sort lcolor(red) lpattern(dash)) /// 10
(line TotDeaMeRaA01S00U20201119P date, sort lcolor(red)) /// 11
(line TotDeaMeRaA01S00U20201126P date, sort lcolor(red)) /// 12
(line TotDeaMeRaA01S00U20201203P date, sort lcolor(red)) /// 13
(line TotDeaMeRaA01S00U20201210P date, sort lcolor(red)) /// 14
(line TotDeaMeRaA01S00U20201217P date, sort lcolor(red)) /// 15
(line TotDeaMeRaA01S00U20201224P date, sort lcolor(red)) /// 16
(line TotDeaMeRaA01S00U20201231P date, sort lcolor(red)) /// 17
(line TotDeaMeRaA01S00U20210107P date, sort lcolor(red)) /// 18
(line TotDeaMeRaA01S00U20210114P date, sort lcolor(red)) /// 19
(line TotDeaMeRaA01S00U20210121P date, sort lcolor(red)) /// 20
(line TotDeaMeRaA01S00U20210128P date, sort lcolor(red)) /// 21
(line TotDeaMeRaA01S00U20210204P date, sort lcolor(red)) /// 22
(line TotDeaMeRaA01S00U20210225P date, sort lcolor(red)) /// 23
(line TotDeaMeRaA01S00U20210226P date, sort lcolor(red)) /// 24
(line TotDeaMeRaA01S00U20210227P date, sort lcolor(red)) /// 25
(line TotDeaMeRaA01S00U20210228P date, sort lcolor(red)) /// 26
(line TotDeaMeRaA01S00U20210301P date, sort lcolor(red)) /// 27
(line TotDeaMeRaA01S00U20210303P date, sort lcolor(red)) /// 28
(line TotDeaMeRaA01S00U20210304P date, sort lcolor(red)) /// 29
(line TotDeaMeRaA01S00U20210305P date, sort lcolor(red)) /// 30
(line TotDeaMeRaA01S00U20210306P date, sort lcolor(red)) /// 31
(line TotDeaMeRaA01S00U20210307P date, sort lcolor(red)) /// 32
(line TotDeaMeRaA01S00U20210308P date, sort lcolor(red)) /// 33
(line TotDeaMeRaA01S00U20210309P date, sort lcolor(red)) /// 34
(line TotDeaMeRaA01S00U20210310P date, sort lcolor(red)) /// 35
(line TotDeaMeRaA01S00U20210311P date, sort lcolor(red)) /// 36
(line TotDeaMeRaA01S00U20210312P date, sort lcolor(red)) /// 37
(line TotDeaMeRaA01S00U20210313P date, sort lcolor(red)) /// 38
(line TotDeaMeRaA01S00U20210314P date, sort lcolor(red)) /// 39
(line TotDeaMeRaA01S00U20210315P date, sort lcolor(red)) /// 40
(line TotDeaMeRaA01S00U20210316P date, sort lcolor(red)) /// 41
(line TotDeaMeRaA01S00U20210317P date, sort lcolor(red)) /// 42
(line TotDeaMeRaA01S00U20210318P date, sort lcolor(red)) /// 43
(line TotDeaMeRaA01S00U20210319P date, sort lcolor(red)) /// 44
(line TotDeaMeRaA01S00U20210320P date, sort lcolor(red)) /// 45
(line TotDeaMeRaA01S00U20210321P date, sort lcolor(red)) /// 46
(line TotDeaMeRaA01S00U20210322P date, sort lcolor(red)) /// 47
(line TotDeaMeRaA01S00U20210323P date, sort lcolor(red)) /// 48
(line TotDeaMeRaA01S00U20210324P date, sort lcolor(red)) /// 49
(line TotDeaMeRaA01S00U20210325P date, sort lcolor(red)) /// 50
(line TotDeaMeRaA01S00U20210326P date, sort lcolor(red)) /// 51
(line TotDeaMeRaA01S00U20210327P date, sort lcolor(red)) /// 52
(line TotDeaMeRaA01S00U20210328P date, sort lcolor(red)) /// 53
(line TotDeaMeRaA01S00U20210329P date, sort lcolor(red)) /// 54
(line TotDeaMeRaA01S00U20210330P date, sort lcolor(red)) /// 55
(line TotDeaMeRaA01S00U20210331P date, sort lcolor(red)) /// 56
(line TotDeaMeRaA01S00U20210401P date, sort lcolor(red)) /// 57
(line TotDeaMeRaA01S00U20210402P date, sort lcolor(red)) /// 58
(line TotDeaMeRaA01S00U20210403P date, sort lcolor(red)) /// 59
(line TotDeaMeRaA01S00U20210404P date, sort lcolor(red)) /// 60
(line TotDeaMeRaA01S00U20210405P date, sort lcolor(red)) /// 61
(line TotDeaMeRaA01S00U20210406P date, sort lcolor(red)) /// 62
(line TotDeaMeRaA01S00U20210407P date, sort lcolor(red)) /// 63
(line TotDeaMeRaA01S00U20210408P date, sort lcolor(red)) /// 64
(line TotDeaMeRaA01S00U20210409P date, sort lcolor(red)) /// 65
(line TotDeaMeRaA01S00U20210410P date, sort lcolor(red)) /// 66
(line TotDeaMeRaA01S00U20210411P date, sort lcolor(red)) /// 67
(line TotDeaMeRaA01S00U20210412P date, sort lcolor(red)) /// 68
(line TotDeaMeRaA01S00U20210413P date, sort lcolor(red)) /// 69
(line TotDeaMeRaA01S00U20210414P date, sort lcolor(red)) /// 70
(line TotDeaMeRaA01S00U20210415P date, sort lcolor(red)) /// 71
(line TotDeaMeRaA01S00U20210416P date, sort lcolor(red)) /// 72
(line TotDeaMeRaA01S00U20210417P date, sort lcolor(red)) /// 73
(line TotDeaMeRaA01S00U20210418P date, sort lcolor(red)) /// 74
(line TotDeaMeRaA01S00U20210419P date, sort lcolor(red)) /// 75
(line TotDeaMeRaA01S00U20210420P date, sort lcolor(red)) /// 76
(line TotDeaMeRaA01S00U20210421P date, sort lcolor(red)) /// 77
(line TotDeaMeRaA01S00U20210422P date, sort lcolor(red)) /// 78
(line TotDeaMeRaA01S00U20210423P date, sort lcolor(red)) /// 79
(line TotDeaMeRaA01S00U20210424P date, sort lcolor(red)) /// 80
(line TotDeaMeRaA01S00U20210425P date, sort lcolor(red)) /// 81
(line TotDeaMeRaA01S00U20210426P date, sort lcolor(red)) /// 82
(line TotDeaMeRaA01S00U20210427P date, sort lcolor(red)) /// 83
(line TotDeaMeRaA01S00U20210428P date, sort lcolor(red)) /// 84
(line TotDeaMeRaA01S00U20210429P date, sort lcolor(red)) /// 85
(line TotDeaMeRaA01S00U20210430P date, sort lcolor(red)) /// 86
(line TotDeaMeRaA01S00U20210501P date, sort lcolor(red)) /// 87
(line TotDeaMeRaA01S00U20210502P date, sort lcolor(red)) /// 88
(line TotDeaMeRaA01S00U20210503P date, sort lcolor(red)) /// 89
(line TotDeaMeRaA01S00U20210504P date, sort lcolor(red)) /// 90
(line TotDeaMeRaA01S00U20210505P date, sort lcolor(red)) /// 91
(line TotDeaMeRaA01S00U20210506P date, sort lcolor(red)) /// 92
(line TotDeaMeRaA01S00U20210507P date, sort lcolor(red)) /// 93
(line TotDeaMeRaA01S00U20210508P date, sort lcolor(red)) /// 94
(line TotDeaMeRaA01S00U20210509P date, sort lcolor(red)) /// 95
(line TotDeaMeRaA01S00U20210510P date, sort lcolor(red)) /// 96
(line TotDeaMeRaA01S00U20210511P date, sort lcolor(red)) /// 97
(line TotDeaMeRaA01S00U20210512P date, sort lcolor(red)) /// 98
(line TotDeaMeRaA01S00U20210513P date, sort lcolor(red)) /// 99
(line TotDeaMeRaA01S00U20210514P date, sort lcolor(red)) /// 100
(line TotDeaMeRaA01S00U20210515P date, sort lcolor(red)) /// 101
(line TotDeaMeRaA01S00U20210516P date, sort lcolor(red)) /// 102
(line TotDeaMeRaA01S00U20210517P date, sort lcolor(red)) /// 103
(line TotDeaMeRaA01S00U20210518P date, sort lcolor(red)) /// 104
(line TotDeaMeRaA01S00U20210519P date, sort lcolor(red)) /// 105
(line TotDeaMeRaA01S00U20210520P date, sort lcolor(red)) /// 106
(line TotDeaMeRaA01S00U20210521P date, sort lcolor(red)) /// 107
(line TotDeaMeRaA01S00U20210522P date, sort lcolor(red)) /// 108
(line TotDeaMeRaA01S00U20210530P date, sort lcolor(red)) /// 109
(line TotDeaMeRaA01S00U20210531P date, sort lcolor(red)) /// 110
(line TotDeaMeRaA01S00U20210601P date, sort lcolor(red)) /// 111
(line TotDeaMeRaA01S00U20210602P date, sort lcolor(red)) /// 112
(line TotDeaMeRaA01S00U20210603P date, sort lcolor(red)) /// 113
(line TotDeaMeRaA01S00U20210604P date, sort lcolor(red)) /// 114
(line TotDeaMeRaA01S00U20210605P date, sort lcolor(red)) /// 115
(line TotDeaMeRaA01S00U20210606P date, sort lcolor(red)) /// 116
(line TotDeaMeRaA01S00U20210607P date, sort lcolor(red)) /// 117
(line TotDeaMeRaA01S00U20210608P date, sort lcolor(red)) /// 118
(line TotDeaMeRaA01S00U20210609P date, sort lcolor(red)) /// 119
(line TotDeaMeRaA01S00U20210610P date, sort lcolor(red)) /// 120
(line TotDeaMeRaA01S00U20210611P date, sort lcolor(red)) /// 121
(line TotDeaMeRaA01S00U20210612P date, sort lcolor(red)) /// 122
(line TotDeaMeRaA01S00U20210613P date, sort lcolor(red)) /// 123
(line TotDeaMeRaA01S00U20210614P date, sort lcolor(red)) /// 124
(line TotDeaMeRaA01S00U20210615P date, sort lcolor(red)) /// 125
(line TotDeaMeRaA01S00U20210616P date, sort lcolor(red)) /// 126
(line TotDeaMeRaA01S00U20210617P date, sort lcolor(red)) /// 127
(line TotDeaMeRaA01S00U20210618P date, sort lcolor(red)) /// 128
(line TotDeaMeRaA01S00U20210619P date, sort lcolor(red)) /// 129
(line TotDeaMeRaA01S00U20210620P date, sort lcolor(red)) /// 130
(line TotDeaMeRaA01S00U20210621P date, sort lcolor(red)) /// 131
(line TotDeaMeRaA01S00U20210622P date, sort lcolor(red)) /// 132
(line TotDeaMeRaA01S00U20210623P date, sort lcolor(red)) /// 133
(line TotDeaMeRaA01S00U20210624P date, sort lcolor(red)) /// 134
(line TotDeaMeRaA01S00U20210625P date, sort lcolor(red)) /// 135
(line TotDeaMeRaA01S00U20210626P date, sort lcolor(red)) /// 136
(line TotDeaMeRaA01S00U20210627P date, sort lcolor(red)) /// 137
(line TotDeaMeRaA01S00U20210628P date, sort lcolor(red)) /// 138
(line TotDeaMeRaA01S00U20210629P date, sort lcolor(red)) /// 139
(line TotDeaMeRaA01S00U20210630P date, sort lcolor(red)) /// 140
(line TotDeaMeRaA01S00U20210701P date, sort lcolor(red)) /// 141
(line TotDeaMeRaA01S00U20210702P date, sort lcolor(red)) /// 142
(line TotDeaMeRaA01S00U20210703P date, sort lcolor(red)) /// 143
(line TotDeaMeRaA01S00U20210704P date, sort lcolor(red)) /// 144
(line TotDeaMeRaA01S00U20210705P date, sort lcolor(red)) /// 145
(line TotDeaMeRaA01S00U20210706P date, sort lcolor(red)) /// 146
(line TotDeaMeRaA01S00U20210707P date, sort lcolor(red)) /// 147
(line TotDeaMeRaA01S00U20210708P date, sort lcolor(red)) /// 148
(line TotDeaMeRaA01S00U20210709P date, sort lcolor(red)) /// 149
(line TotDeaMeRaA01S00U20210710P date, sort lcolor(red)) /// 150
(line TotDeaMeRaA01S00U20210711P date, sort lcolor(red)) /// 151
(line TotDeaMeRaA01S00U20210712P date, sort lcolor(red)) /// 152
(line TotDeaMeRaA01S00U20210713P date, sort lcolor(red)) /// 153
(line TotDeaMeRaA01S00U20210714P date, sort lcolor(red)) /// 154
(line TotDeaMeRaA01S00U20210715P date, sort lcolor(red)) /// 155
(line TotDeaMeRaA01S00U20210716P date, sort lcolor(red)) /// 156
(line TotDeaMeRaA01S00U20210717P date, sort lcolor(red)) /// 157
(line TotDeaMeRaA01S00U20210718P date, sort lcolor(red)) /// 158
(line TotDeaMeRaA01S00U20210719P date, sort lcolor(red)) /// 159
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths DELP percent JOHN) title("COVID-19 total deaths, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; without extremes i.e. > 2 times max reported 170,000", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 34b COVID-19 total deaths, $country, DELP, wo extreme, Percent.gph", replace
qui graph export "graph 34b COVID-19 total deaths, $country, DELP, wo extreme, Percent.pdf", replace
















* total cases

**************************************


* total cases, Absolute value, individual updates


foreach l of global DELPupdatelist {

twoway  /// 
(line TotCasMeRaA00S00 date, lcolor(cyan*1.2)) /// 
(line TotCasMeRaA01S00U`l' date, sort lcolor(red)) /// 
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, $country, DELP, update `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("single scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "DELP `l'" 1 "JOHN smooth") size(small) rows(1))	yscale(titlegap(2))

qui graph save "graph 41i COVID-19 total cases, $country, DELP update `l'.gph", replace
qui graph export "graph 41i COVID-19 total cases, $country, DELP update `l'.pdf", replace

}
*







* total cases, Absolute value, together, with extremes 168

twoway  ///
(line TotCasMeRaA01S00U20200723 date, sort lcolor(red) lpattern(dash)) /// 1
(line TotCasMeRaA01S00U20200919 date, sort lcolor(red) lpattern(dash)) /// 2
(line TotCasMeRaA01S00U20200926 date, sort lcolor(red) lpattern(dash)) /// 3
(line TotCasMeRaA01S00U20201001 date, sort lcolor(red) lpattern(dash)) /// 4
(line TotCasMeRaA01S00U20201008 date, sort lcolor(red) lpattern(dash)) /// 5
(line TotCasMeRaA01S00U20201015 date, sort lcolor(red) lpattern(dash)) /// 6
(line TotCasMeRaA01S00U20201022 date, sort lcolor(red) lpattern(dash)) /// 7
(line TotCasMeRaA01S00U20201029 date, sort lcolor(red) lpattern(dash)) /// 8
(line TotCasMeRaA01S00U20201105 date, sort lcolor(red) lpattern(dash)) /// 9
(line TotCasMeRaA01S00U20201112 date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line TotCasMeRaA01S00U20201119 date, sort lcolor(red)) /// 11 v4
(line TotCasMeRaA01S00U20201126 date, sort lcolor(red)) /// 12
(line TotCasMeRaA01S00U20201203 date, sort lcolor(red)) /// 13
(line TotCasMeRaA01S00U20201210 date, sort lcolor(red)) /// 14
(line TotCasMeRaA01S00U20201217 date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20201224 date, sort lcolor(red)) /// 16
(line TotCasMeRaA01S00U20201231 date, sort lcolor(red)) /// 17
(line TotCasMeRaA01S00U20210107 date, sort lcolor(red)) /// 18
(line TotCasMeRaA01S00U20210114 date, sort lcolor(red)) /// 19
(line TotCasMeRaA01S00U20210121 date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210128 date, sort lcolor(red)) /// 21
(line TotCasMeRaA01S00U20210204 date, sort lcolor(red)) /// 22
(line TotCasMeRaA01S00U20210211 date, sort lcolor(red)) /// 23
(line TotCasMeRaA01S00U20210218 date, sort lcolor(red)) /// 24
(line TotCasMeRaA01S00U20210225 date, sort lcolor(red)) /// 25
(line TotCasMeRaA01S00U20210226 date, sort lcolor(red)) /// 26
(line TotCasMeRaA01S00U20210227 date, sort lcolor(red)) /// 27
(line TotCasMeRaA01S00U20210228 date, sort lcolor(red)) /// 28
(line TotCasMeRaA01S00U20210301 date, sort lcolor(red)) /// 29
(line TotCasMeRaA01S00U20210303 date, sort lcolor(red)) /// 30
(line TotCasMeRaA01S00U20210304 date, sort lcolor(red)) /// 31
(line TotCasMeRaA01S00U20210305 date, sort lcolor(red)) /// 32
(line TotCasMeRaA01S00U20210306 date, sort lcolor(red)) /// 33
(line TotCasMeRaA01S00U20210307 date, sort lcolor(red)) /// 34
(line TotCasMeRaA01S00U20210308 date, sort lcolor(red)) /// 35
(line TotCasMeRaA01S00U20210309 date, sort lcolor(red)) /// 36
(line TotCasMeRaA01S00U20210310 date, sort lcolor(red)) /// 37
(line TotCasMeRaA01S00U20210311 date, sort lcolor(red)) /// 38
(line TotCasMeRaA01S00U20210312 date, sort lcolor(red)) /// 39
(line TotCasMeRaA01S00U20210313 date, sort lcolor(red)) /// 40
(line TotCasMeRaA01S00U20210314 date, sort lcolor(red)) /// 41
(line TotCasMeRaA01S00U20210315 date, sort lcolor(red)) /// 42
(line TotCasMeRaA01S00U20210316 date, sort lcolor(red)) /// 43
(line TotCasMeRaA01S00U20210317 date, sort lcolor(red)) /// 44
(line TotCasMeRaA01S00U20210318 date, sort lcolor(red)) /// 45
(line TotCasMeRaA01S00U20210319 date, sort lcolor(red)) /// 46
(line TotCasMeRaA01S00U20210320 date, sort lcolor(red)) /// 47
(line TotCasMeRaA01S00U20210321 date, sort lcolor(red)) /// 48
(line TotCasMeRaA01S00U20210322 date, sort lcolor(red)) /// 49
(line TotCasMeRaA01S00U20210323 date, sort lcolor(red)) /// 50
(line TotCasMeRaA01S00U20210324 date, sort lcolor(red)) /// 51
(line TotCasMeRaA01S00U20210325 date, sort lcolor(red)) /// 52
(line TotCasMeRaA01S00U20210326 date, sort lcolor(red)) /// 53
(line TotCasMeRaA01S00U20210327 date, sort lcolor(red)) /// 54
(line TotCasMeRaA01S00U20210328 date, sort lcolor(red)) /// 55
(line TotCasMeRaA01S00U20210329 date, sort lcolor(red)) /// 56
(line TotCasMeRaA01S00U20210330 date, sort lcolor(red)) /// 57
(line TotCasMeRaA01S00U20210331 date, sort lcolor(red)) /// 58
(line TotCasMeRaA01S00U20210401 date, sort lcolor(red)) /// 59
(line TotCasMeRaA01S00U20210402 date, sort lcolor(red)) /// 60
(line TotCasMeRaA01S00U20210403 date, sort lcolor(red)) /// 61
(line TotCasMeRaA01S00U20210404 date, sort lcolor(red)) /// 62
(line TotCasMeRaA01S00U20210405 date, sort lcolor(red)) /// 63
(line TotCasMeRaA01S00U20210406 date, sort lcolor(red)) /// 64
(line TotCasMeRaA01S00U20210407 date, sort lcolor(red)) /// 65
(line TotCasMeRaA01S00U20210408 date, sort lcolor(red)) /// 66
(line TotCasMeRaA01S00U20210409 date, sort lcolor(red)) /// 67
(line TotCasMeRaA01S00U20210410 date, sort lcolor(red)) /// 68
(line TotCasMeRaA01S00U20210411 date, sort lcolor(red)) /// 69
(line TotCasMeRaA01S00U20210412 date, sort lcolor(red)) /// 70
(line TotCasMeRaA01S00U20210413 date, sort lcolor(red)) /// 71
(line TotCasMeRaA01S00U20210414 date, sort lcolor(red)) /// 72
(line TotCasMeRaA01S00U20210415 date, sort lcolor(red)) /// 73
(line TotCasMeRaA01S00U20210416 date, sort lcolor(red)) /// 74
(line TotCasMeRaA01S00U20210417 date, sort lcolor(red)) /// 75
(line TotCasMeRaA01S00U20210418 date, sort lcolor(red)) /// 76
(line TotCasMeRaA01S00U20210419 date, sort lcolor(red)) /// 77
(line TotCasMeRaA01S00U20210420 date, sort lcolor(red)) /// 78
(line TotCasMeRaA01S00U20210421 date, sort lcolor(red)) /// 79
(line TotCasMeRaA01S00U20210422 date, sort lcolor(red)) /// 80
(line TotCasMeRaA01S00U20210423 date, sort lcolor(red)) /// 81
(line TotCasMeRaA01S00U20210424 date, sort lcolor(red)) /// 82
(line TotCasMeRaA01S00U20210425 date, sort lcolor(red)) /// 83
(line TotCasMeRaA01S00U20210426 date, sort lcolor(red)) /// 84
(line TotCasMeRaA01S00U20210427 date, sort lcolor(red)) /// 85
(line TotCasMeRaA01S00U20210428 date, sort lcolor(red)) /// 86
(line TotCasMeRaA01S00U20210429 date, sort lcolor(red)) /// 87
(line TotCasMeRaA01S00U20210430 date, sort lcolor(red)) /// 88
(line TotCasMeRaA01S00U20210501 date, sort lcolor(red)) /// 89
(line TotCasMeRaA01S00U20210502 date, sort lcolor(red)) /// 90
(line TotCasMeRaA01S00U20210503 date, sort lcolor(red)) /// 91
(line TotCasMeRaA01S00U20210504 date, sort lcolor(red)) /// 92
(line TotCasMeRaA01S00U20210505 date, sort lcolor(red)) /// 93
(line TotCasMeRaA01S00U20210506 date, sort lcolor(red)) /// 94
(line TotCasMeRaA01S00U20210507 date, sort lcolor(red)) /// 95
(line TotCasMeRaA01S00U20210508 date, sort lcolor(red)) /// 96
(line TotCasMeRaA01S00U20210509 date, sort lcolor(red)) /// 97
(line TotCasMeRaA01S00U20210510 date, sort lcolor(red)) /// 98
(line TotCasMeRaA01S00U20210511 date, sort lcolor(red)) /// 99
(line TotCasMeRaA01S00U20210512 date, sort lcolor(red)) /// 100
(line TotCasMeRaA01S00U20210513 date, sort lcolor(red)) /// 101
(line TotCasMeRaA01S00U20210514 date, sort lcolor(red)) /// 102
(line TotCasMeRaA01S00U20210515 date, sort lcolor(red)) /// 103
(line TotCasMeRaA01S00U20210516 date, sort lcolor(red)) /// 104
(line TotCasMeRaA01S00U20210517 date, sort lcolor(red)) /// 105
(line TotCasMeRaA01S00U20210518 date, sort lcolor(red)) /// 106
(line TotCasMeRaA01S00U20210519 date, sort lcolor(red)) /// 107
(line TotCasMeRaA01S00U20210520 date, sort lcolor(red)) /// 108
(line TotCasMeRaA01S00U20210521 date, sort lcolor(red)) /// 109
(line TotCasMeRaA01S00U20210522 date, sort lcolor(red)) /// 110
(line TotCasMeRaA01S00U20210523 date, sort lcolor(red)) /// 111
(line TotCasMeRaA01S00U20210524 date, sort lcolor(red)) /// 112
(line TotCasMeRaA01S00U20210525 date, sort lcolor(red)) /// 113
(line TotCasMeRaA01S00U20210526 date, sort lcolor(red)) /// 114
(line TotCasMeRaA01S00U20210527 date, sort lcolor(red)) /// 115
(line TotCasMeRaA01S00U20210528 date, sort lcolor(red)) /// 116
(line TotCasMeRaA01S00U20210529 date, sort lcolor(red)) /// 117
(line TotCasMeRaA01S00U20210530 date, sort lcolor(red)) /// 118
(line TotCasMeRaA01S00U20210531 date, sort lcolor(red)) /// 119
(line TotCasMeRaA01S00U20210601 date, sort lcolor(red)) /// 120
(line TotCasMeRaA01S00U20210602 date, sort lcolor(red)) /// 121
(line TotCasMeRaA01S00U20210603 date, sort lcolor(red)) /// 122
(line TotCasMeRaA01S00U20210604 date, sort lcolor(red)) /// 123
(line TotCasMeRaA01S00U20210605 date, sort lcolor(red)) /// 124
(line TotCasMeRaA01S00U20210606 date, sort lcolor(red)) /// 125
(line TotCasMeRaA01S00U20210607 date, sort lcolor(red)) /// 126
(line TotCasMeRaA01S00U20210608 date, sort lcolor(red)) /// 127
(line TotCasMeRaA01S00U20210609 date, sort lcolor(red)) /// 128
(line TotCasMeRaA01S00U20210610 date, sort lcolor(red)) /// 129
(line TotCasMeRaA01S00U20210611 date, sort lcolor(red)) /// 130
(line TotCasMeRaA01S00U20210612 date, sort lcolor(red)) /// 131
(line TotCasMeRaA01S00U20210613 date, sort lcolor(red)) /// 132
(line TotCasMeRaA01S00U20210614 date, sort lcolor(red)) /// 133
(line TotCasMeRaA01S00U20210615 date, sort lcolor(red)) /// 134
(line TotCasMeRaA01S00U20210616 date, sort lcolor(red)) /// 135
(line TotCasMeRaA01S00U20210617 date, sort lcolor(red)) /// 136
(line TotCasMeRaA01S00U20210618 date, sort lcolor(red)) /// 137
(line TotCasMeRaA01S00U20210619 date, sort lcolor(red)) /// 138
(line TotCasMeRaA01S00U20210620 date, sort lcolor(red)) /// 139
(line TotCasMeRaA01S00U20210621 date, sort lcolor(red)) /// 140
(line TotCasMeRaA01S00U20210622 date, sort lcolor(red)) /// 141
(line TotCasMeRaA01S00U20210623 date, sort lcolor(red)) /// 142
(line TotCasMeRaA01S00U20210624 date, sort lcolor(red)) /// 143
(line TotCasMeRaA01S00U20210625 date, sort lcolor(red)) /// 144
(line TotCasMeRaA01S00U20210626 date, sort lcolor(red)) /// 145
(line TotCasMeRaA01S00U20210627 date, sort lcolor(red)) /// 146
(line TotCasMeRaA01S00U20210628 date, sort lcolor(red)) /// 147
(line TotCasMeRaA01S00U20210629 date, sort lcolor(red)) /// 148
(line TotCasMeRaA01S00U20210630 date, sort lcolor(red)) /// 149
(line TotCasMeRaA01S00U20210701 date, sort lcolor(red)) /// 150
(line TotCasMeRaA01S00U20210702 date, sort lcolor(red)) /// 151
(line TotCasMeRaA01S00U20210703 date, sort lcolor(red)) /// 152
(line TotCasMeRaA01S00U20210704 date, sort lcolor(red)) /// 153
(line TotCasMeRaA01S00U20210705 date, sort lcolor(red)) /// 154
(line TotCasMeRaA01S00U20210706 date, sort lcolor(red)) /// 155
(line TotCasMeRaA01S00U20210707 date, sort lcolor(red)) /// 156
(line TotCasMeRaA01S00U20210708 date, sort lcolor(red)) /// 157
(line TotCasMeRaA01S00U20210709 date, sort lcolor(red)) /// 158
(line TotCasMeRaA01S00U20210710 date, sort lcolor(red)) /// 159
(line TotCasMeRaA01S00U20210711 date, sort lcolor(red)) /// 160
(line TotCasMeRaA01S00U20210712 date, sort lcolor(red)) /// 161
(line TotCasMeRaA01S00U20210713 date, sort lcolor(red)) /// 162
(line TotCasMeRaA01S00U20210714 date, sort lcolor(red)) /// 163
(line TotCasMeRaA01S00U20210715 date, sort lcolor(red)) /// 164
(line TotCasMeRaA01S00U20210716 date, sort lcolor(red)) /// 165
(line TotCasMeRaA01S00U20210717 date, sort lcolor(red)) /// 166
(line TotCasMeRaA01S00U20210718 date, sort lcolor(red)) /// 167
(line TotCasMeRaA01S00U20210719 date, sort lcolor(red)) /// 168
(line TotCasMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 169	   
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(10 "DELP v2" 11 "DELP v4" 169 "JOHN") size(small) rows(1))	yscale(titlegap(2))
  	   
qui graph save "graph 41a COVID-19 total cases, $country, DELP.gph", replace
qui graph export "graph 41a COVID-19 total cases, $country, DELP.pdf", replace




*********

* total cases, Absolute value, together, without extremes 152


/* total cases > 8,000,000, while DELP does not adjust for under-reporting 

* Max reported total cases has been less than 4,000,000 (July 2021), therefore, 
* set bar for extreme as more than 2 times 4,000,000, i.e.,  > 8,000,000.


20210128
20210204
20210211
20210218
20210225
20210226
20210227
20210228
20210301

20210523
20210524
20210525
20210526
20210527
20210528
20210529

clustering of extreme estimates in time suggests hypothesis about temporal changes in model performance

*/

twoway  ///
(line TotCasMeRaA01S00U20200723 date, sort lcolor(red) lpattern(dash)) /// 1
(line TotCasMeRaA01S00U20200919 date, sort lcolor(red) lpattern(dash)) /// 2
(line TotCasMeRaA01S00U20200926 date, sort lcolor(red) lpattern(dash)) /// 3
(line TotCasMeRaA01S00U20201001 date, sort lcolor(red) lpattern(dash)) /// 4
(line TotCasMeRaA01S00U20201008 date, sort lcolor(red) lpattern(dash)) /// 5
(line TotCasMeRaA01S00U20201015 date, sort lcolor(red) lpattern(dash)) /// 6
(line TotCasMeRaA01S00U20201022 date, sort lcolor(red) lpattern(dash)) /// 7
(line TotCasMeRaA01S00U20201029 date, sort lcolor(red) lpattern(dash)) /// 8
(line TotCasMeRaA01S00U20201105 date, sort lcolor(red) lpattern(dash)) /// 9
(line TotCasMeRaA01S00U20201112 date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line TotCasMeRaA01S00U20201119 date, sort lcolor(red)) /// 11 v4
(line TotCasMeRaA01S00U20201126 date, sort lcolor(red)) /// 12
(line TotCasMeRaA01S00U20201203 date, sort lcolor(red)) /// 13
(line TotCasMeRaA01S00U20201210 date, sort lcolor(red)) /// 14
(line TotCasMeRaA01S00U20201217 date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20201224 date, sort lcolor(red)) /// 16
(line TotCasMeRaA01S00U20201231 date, sort lcolor(red)) /// 17
(line TotCasMeRaA01S00U20210107 date, sort lcolor(red)) /// 18
(line TotCasMeRaA01S00U20210114 date, sort lcolor(red)) /// 19
(line TotCasMeRaA01S00U20210121 date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210303 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210304 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210305 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210306 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210307 date, sort lcolor(red)) /// 25
(line TotCasMeRaA01S00U20210308 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210309 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210310 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210311 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210312 date, sort lcolor(red)) /// 30
(line TotCasMeRaA01S00U20210313 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210314 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210315 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210316 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210317 date, sort lcolor(red)) /// 35
(line TotCasMeRaA01S00U20210318 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210319 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210320 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210321 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210322 date, sort lcolor(red)) /// 40
(line TotCasMeRaA01S00U20210323 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210324 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210325 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210326 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210327 date, sort lcolor(red)) /// 45
(line TotCasMeRaA01S00U20210328 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210329 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210330 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210331 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210401 date, sort lcolor(red)) /// 50
(line TotCasMeRaA01S00U20210402 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210403 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210404 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210405 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210406 date, sort lcolor(red)) /// 55
(line TotCasMeRaA01S00U20210407 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210408 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210409 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210410 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210411 date, sort lcolor(red)) /// 60
(line TotCasMeRaA01S00U20210412 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210413 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210414 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210415 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210416 date, sort lcolor(red)) /// 65
(line TotCasMeRaA01S00U20210417 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210418 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210419 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210420 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210421 date, sort lcolor(red)) /// 70
(line TotCasMeRaA01S00U20210422 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210423 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210424 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210425 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210426 date, sort lcolor(red)) /// 75
(line TotCasMeRaA01S00U20210427 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210428 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210429 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210430 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210501 date, sort lcolor(red)) /// 80
(line TotCasMeRaA01S00U20210502 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210503 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210504 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210505 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210506 date, sort lcolor(red)) /// 85
(line TotCasMeRaA01S00U20210507 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210508 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210509 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210510 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210511 date, sort lcolor(red)) /// 90
(line TotCasMeRaA01S00U20210512 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210513 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210514 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210515 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210516 date, sort lcolor(red)) /// 95
(line TotCasMeRaA01S00U20210517 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210518 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210519 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210520 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210521 date, sort lcolor(red)) /// 100
(line TotCasMeRaA01S00U20210522 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210530 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210531 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210601 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210602 date, sort lcolor(red)) /// 105
(line TotCasMeRaA01S00U20210603 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210604 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210605 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210606 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210607 date, sort lcolor(red)) /// 110
(line TotCasMeRaA01S00U20210608 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210609 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210610 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210611 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210612 date, sort lcolor(red)) /// 115
(line TotCasMeRaA01S00U20210613 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210614 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210615 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210616 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210617 date, sort lcolor(red)) /// 120
(line TotCasMeRaA01S00U20210618 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210619 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210620 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210621 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210622 date, sort lcolor(red)) /// 125
(line TotCasMeRaA01S00U20210623 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210624 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210625 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210626 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210627 date, sort lcolor(red)) /// 130
(line TotCasMeRaA01S00U20210628 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210629 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210630 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210701 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210702 date, sort lcolor(red)) /// 135
(line TotCasMeRaA01S00U20210703 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210704 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210705 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210706 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210707 date, sort lcolor(red)) /// 140
(line TotCasMeRaA01S00U20210708 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210709 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210710 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210711 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210712 date, sort lcolor(red)) /// 145
(line TotCasMeRaA01S00U20210713 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210714 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210715 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210716 date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210717 date, sort lcolor(red)) /// 150
(line TotCasMeRaA01S00U20210718 date, sort lcolor(red)) /// 151
(line TotCasMeRaA01S00U20210719 date, sort lcolor(red)) /// 152
(line TotCasMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 153	   
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases) title("COVID-19 total cases, $country, DELP", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; without extremes i.e. > 2 times max reported 8M", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(10 "DELP v2" 11 "DELP v4" 153 "JOHN") size(small) rows(1))	yscale(titlegap(2)) yscale(titlegap(2))
  	   
qui graph save "graph 41b COVID-19 total cases, $country, DELP, wo extreme.gph", replace
qui graph export "graph 41b COVID-19 total cases, $country, DELP, wo extreme.pdf", replace


*


*********

* total cases, Difference, together, with extremes 168

twoway  ///
(line TotCasMeRaA01S00U20200723D date, sort lcolor(red) lpattern(dash)) /// 1
(line TotCasMeRaA01S00U20200919D date, sort lcolor(red) lpattern(dash)) /// 2
(line TotCasMeRaA01S00U20200926D date, sort lcolor(red) lpattern(dash)) /// 3
(line TotCasMeRaA01S00U20201001D date, sort lcolor(red) lpattern(dash)) /// 4
(line TotCasMeRaA01S00U20201008D date, sort lcolor(red) lpattern(dash)) /// 5
(line TotCasMeRaA01S00U20201015D date, sort lcolor(red) lpattern(dash)) /// 6
(line TotCasMeRaA01S00U20201022D date, sort lcolor(red) lpattern(dash)) /// 7
(line TotCasMeRaA01S00U20201029D date, sort lcolor(red) lpattern(dash)) /// 8
(line TotCasMeRaA01S00U20201105D date, sort lcolor(red) lpattern(dash)) /// 9
(line TotCasMeRaA01S00U20201112D date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line TotCasMeRaA01S00U20201119D date, sort lcolor(red)) /// 11 v4
(line TotCasMeRaA01S00U20201126D date, sort lcolor(red)) /// 12
(line TotCasMeRaA01S00U20201203D date, sort lcolor(red)) /// 13
(line TotCasMeRaA01S00U20201210D date, sort lcolor(red)) /// 14
(line TotCasMeRaA01S00U20201217D date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20201224D date, sort lcolor(red)) /// 16
(line TotCasMeRaA01S00U20201231D date, sort lcolor(red)) /// 17
(line TotCasMeRaA01S00U20210107D date, sort lcolor(red)) /// 18
(line TotCasMeRaA01S00U20210114D date, sort lcolor(red)) /// 19
(line TotCasMeRaA01S00U20210121D date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210128D date, sort lcolor(red)) /// 21
(line TotCasMeRaA01S00U20210204D date, sort lcolor(red)) /// 22
(line TotCasMeRaA01S00U20210211D date, sort lcolor(red)) /// 23
(line TotCasMeRaA01S00U20210218D date, sort lcolor(red)) /// 24
(line TotCasMeRaA01S00U20210225D date, sort lcolor(red)) /// 25
(line TotCasMeRaA01S00U20210226D date, sort lcolor(red)) /// 26
(line TotCasMeRaA01S00U20210227D date, sort lcolor(red)) /// 27
(line TotCasMeRaA01S00U20210228D date, sort lcolor(red)) /// 28
(line TotCasMeRaA01S00U20210301D date, sort lcolor(red)) /// 29
(line TotCasMeRaA01S00U20210303D date, sort lcolor(red)) /// 30
(line TotCasMeRaA01S00U20210304D date, sort lcolor(red)) /// 31
(line TotCasMeRaA01S00U20210305D date, sort lcolor(red)) /// 32
(line TotCasMeRaA01S00U20210306D date, sort lcolor(red)) /// 33
(line TotCasMeRaA01S00U20210307D date, sort lcolor(red)) /// 34
(line TotCasMeRaA01S00U20210308D date, sort lcolor(red)) /// 35
(line TotCasMeRaA01S00U20210309D date, sort lcolor(red)) /// 36
(line TotCasMeRaA01S00U20210310D date, sort lcolor(red)) /// 37
(line TotCasMeRaA01S00U20210311D date, sort lcolor(red)) /// 38
(line TotCasMeRaA01S00U20210312D date, sort lcolor(red)) /// 39
(line TotCasMeRaA01S00U20210313D date, sort lcolor(red)) /// 40
(line TotCasMeRaA01S00U20210314D date, sort lcolor(red)) /// 41
(line TotCasMeRaA01S00U20210315D date, sort lcolor(red)) /// 42
(line TotCasMeRaA01S00U20210316D date, sort lcolor(red)) /// 43
(line TotCasMeRaA01S00U20210317D date, sort lcolor(red)) /// 44
(line TotCasMeRaA01S00U20210318D date, sort lcolor(red)) /// 45
(line TotCasMeRaA01S00U20210319D date, sort lcolor(red)) /// 46
(line TotCasMeRaA01S00U20210320D date, sort lcolor(red)) /// 47
(line TotCasMeRaA01S00U20210321D date, sort lcolor(red)) /// 48
(line TotCasMeRaA01S00U20210322D date, sort lcolor(red)) /// 49
(line TotCasMeRaA01S00U20210323D date, sort lcolor(red)) /// 50
(line TotCasMeRaA01S00U20210324D date, sort lcolor(red)) /// 51
(line TotCasMeRaA01S00U20210325D date, sort lcolor(red)) /// 52
(line TotCasMeRaA01S00U20210326D date, sort lcolor(red)) /// 53
(line TotCasMeRaA01S00U20210327D date, sort lcolor(red)) /// 54
(line TotCasMeRaA01S00U20210328D date, sort lcolor(red)) /// 55
(line TotCasMeRaA01S00U20210329D date, sort lcolor(red)) /// 56
(line TotCasMeRaA01S00U20210330D date, sort lcolor(red)) /// 57
(line TotCasMeRaA01S00U20210331D date, sort lcolor(red)) /// 58
(line TotCasMeRaA01S00U20210401D date, sort lcolor(red)) /// 59
(line TotCasMeRaA01S00U20210402D date, sort lcolor(red)) /// 60
(line TotCasMeRaA01S00U20210403D date, sort lcolor(red)) /// 61
(line TotCasMeRaA01S00U20210404D date, sort lcolor(red)) /// 62
(line TotCasMeRaA01S00U20210405D date, sort lcolor(red)) /// 63
(line TotCasMeRaA01S00U20210406D date, sort lcolor(red)) /// 64
(line TotCasMeRaA01S00U20210407D date, sort lcolor(red)) /// 65
(line TotCasMeRaA01S00U20210408D date, sort lcolor(red)) /// 66
(line TotCasMeRaA01S00U20210409D date, sort lcolor(red)) /// 67
(line TotCasMeRaA01S00U20210410D date, sort lcolor(red)) /// 68
(line TotCasMeRaA01S00U20210411D date, sort lcolor(red)) /// 69
(line TotCasMeRaA01S00U20210412D date, sort lcolor(red)) /// 70
(line TotCasMeRaA01S00U20210413D date, sort lcolor(red)) /// 71
(line TotCasMeRaA01S00U20210414D date, sort lcolor(red)) /// 72
(line TotCasMeRaA01S00U20210415D date, sort lcolor(red)) /// 73
(line TotCasMeRaA01S00U20210416D date, sort lcolor(red)) /// 74
(line TotCasMeRaA01S00U20210417D date, sort lcolor(red)) /// 75
(line TotCasMeRaA01S00U20210418D date, sort lcolor(red)) /// 76
(line TotCasMeRaA01S00U20210419D date, sort lcolor(red)) /// 77
(line TotCasMeRaA01S00U20210420D date, sort lcolor(red)) /// 78
(line TotCasMeRaA01S00U20210421D date, sort lcolor(red)) /// 79
(line TotCasMeRaA01S00U20210422D date, sort lcolor(red)) /// 80
(line TotCasMeRaA01S00U20210423D date, sort lcolor(red)) /// 81
(line TotCasMeRaA01S00U20210424D date, sort lcolor(red)) /// 82
(line TotCasMeRaA01S00U20210425D date, sort lcolor(red)) /// 83
(line TotCasMeRaA01S00U20210426D date, sort lcolor(red)) /// 84
(line TotCasMeRaA01S00U20210427D date, sort lcolor(red)) /// 85
(line TotCasMeRaA01S00U20210428D date, sort lcolor(red)) /// 86
(line TotCasMeRaA01S00U20210429D date, sort lcolor(red)) /// 87
(line TotCasMeRaA01S00U20210430D date, sort lcolor(red)) /// 88
(line TotCasMeRaA01S00U20210501D date, sort lcolor(red)) /// 89
(line TotCasMeRaA01S00U20210502D date, sort lcolor(red)) /// 90
(line TotCasMeRaA01S00U20210503D date, sort lcolor(red)) /// 91
(line TotCasMeRaA01S00U20210504D date, sort lcolor(red)) /// 92
(line TotCasMeRaA01S00U20210505D date, sort lcolor(red)) /// 93
(line TotCasMeRaA01S00U20210506D date, sort lcolor(red)) /// 94
(line TotCasMeRaA01S00U20210507D date, sort lcolor(red)) /// 95
(line TotCasMeRaA01S00U20210508D date, sort lcolor(red)) /// 96
(line TotCasMeRaA01S00U20210509D date, sort lcolor(red)) /// 97
(line TotCasMeRaA01S00U20210510D date, sort lcolor(red)) /// 98
(line TotCasMeRaA01S00U20210511D date, sort lcolor(red)) /// 99
(line TotCasMeRaA01S00U20210512D date, sort lcolor(red)) /// 100
(line TotCasMeRaA01S00U20210513D date, sort lcolor(red)) /// 101
(line TotCasMeRaA01S00U20210514D date, sort lcolor(red)) /// 102
(line TotCasMeRaA01S00U20210515D date, sort lcolor(red)) /// 103
(line TotCasMeRaA01S00U20210516D date, sort lcolor(red)) /// 104
(line TotCasMeRaA01S00U20210517D date, sort lcolor(red)) /// 105
(line TotCasMeRaA01S00U20210518D date, sort lcolor(red)) /// 106
(line TotCasMeRaA01S00U20210519D date, sort lcolor(red)) /// 107
(line TotCasMeRaA01S00U20210520D date, sort lcolor(red)) /// 108
(line TotCasMeRaA01S00U20210521D date, sort lcolor(red)) /// 109
(line TotCasMeRaA01S00U20210522D date, sort lcolor(red)) /// 110
(line TotCasMeRaA01S00U20210523D date, sort lcolor(red)) /// 111
(line TotCasMeRaA01S00U20210524D date, sort lcolor(red)) /// 112
(line TotCasMeRaA01S00U20210525D date, sort lcolor(red)) /// 113
(line TotCasMeRaA01S00U20210526D date, sort lcolor(red)) /// 114
(line TotCasMeRaA01S00U20210527D date, sort lcolor(red)) /// 115
(line TotCasMeRaA01S00U20210528D date, sort lcolor(red)) /// 116
(line TotCasMeRaA01S00U20210529D date, sort lcolor(red)) /// 117
(line TotCasMeRaA01S00U20210530D date, sort lcolor(red)) /// 118
(line TotCasMeRaA01S00U20210531D date, sort lcolor(red)) /// 119
(line TotCasMeRaA01S00U20210601D date, sort lcolor(red)) /// 120
(line TotCasMeRaA01S00U20210602D date, sort lcolor(red)) /// 121
(line TotCasMeRaA01S00U20210603D date, sort lcolor(red)) /// 122
(line TotCasMeRaA01S00U20210604D date, sort lcolor(red)) /// 123
(line TotCasMeRaA01S00U20210605D date, sort lcolor(red)) /// 124
(line TotCasMeRaA01S00U20210606D date, sort lcolor(red)) /// 125
(line TotCasMeRaA01S00U20210607D date, sort lcolor(red)) /// 126
(line TotCasMeRaA01S00U20210608D date, sort lcolor(red)) /// 127
(line TotCasMeRaA01S00U20210609D date, sort lcolor(red)) /// 128
(line TotCasMeRaA01S00U20210610D date, sort lcolor(red)) /// 129
(line TotCasMeRaA01S00U20210611D date, sort lcolor(red)) /// 130
(line TotCasMeRaA01S00U20210612D date, sort lcolor(red)) /// 131
(line TotCasMeRaA01S00U20210613D date, sort lcolor(red)) /// 132
(line TotCasMeRaA01S00U20210614D date, sort lcolor(red)) /// 133
(line TotCasMeRaA01S00U20210615D date, sort lcolor(red)) /// 134
(line TotCasMeRaA01S00U20210616D date, sort lcolor(red)) /// 135
(line TotCasMeRaA01S00U20210617D date, sort lcolor(red)) /// 136
(line TotCasMeRaA01S00U20210618D date, sort lcolor(red)) /// 137
(line TotCasMeRaA01S00U20210619D date, sort lcolor(red)) /// 138
(line TotCasMeRaA01S00U20210620D date, sort lcolor(red)) /// 139
(line TotCasMeRaA01S00U20210621D date, sort lcolor(red)) /// 140
(line TotCasMeRaA01S00U20210622D date, sort lcolor(red)) /// 141
(line TotCasMeRaA01S00U20210623D date, sort lcolor(red)) /// 142
(line TotCasMeRaA01S00U20210624D date, sort lcolor(red)) /// 143
(line TotCasMeRaA01S00U20210625D date, sort lcolor(red)) /// 144
(line TotCasMeRaA01S00U20210626D date, sort lcolor(red)) /// 145
(line TotCasMeRaA01S00U20210627D date, sort lcolor(red)) /// 146
(line TotCasMeRaA01S00U20210628D date, sort lcolor(red)) /// 147
(line TotCasMeRaA01S00U20210629D date, sort lcolor(red)) /// 148
(line TotCasMeRaA01S00U20210630D date, sort lcolor(red)) /// 149
(line TotCasMeRaA01S00U20210701D date, sort lcolor(red)) /// 150
(line TotCasMeRaA01S00U20210702D date, sort lcolor(red)) /// 151
(line TotCasMeRaA01S00U20210703D date, sort lcolor(red)) /// 152
(line TotCasMeRaA01S00U20210704D date, sort lcolor(red)) /// 153
(line TotCasMeRaA01S00U20210705D date, sort lcolor(red)) /// 154
(line TotCasMeRaA01S00U20210706D date, sort lcolor(red)) /// 155
(line TotCasMeRaA01S00U20210707D date, sort lcolor(red)) /// 156
(line TotCasMeRaA01S00U20210708D date, sort lcolor(red)) /// 157
(line TotCasMeRaA01S00U20210709D date, sort lcolor(red)) /// 158
(line TotCasMeRaA01S00U20210710D date, sort lcolor(red)) /// 159
(line TotCasMeRaA01S00U20210711D date, sort lcolor(red)) /// 160
(line TotCasMeRaA01S00U20210712D date, sort lcolor(red)) /// 161
(line TotCasMeRaA01S00U20210713D date, sort lcolor(red)) /// 162
(line TotCasMeRaA01S00U20210714D date, sort lcolor(red)) /// 163
(line TotCasMeRaA01S00U20210715D date, sort lcolor(red)) /// 164
(line TotCasMeRaA01S00U20210716D date, sort lcolor(red)) /// 165
(line TotCasMeRaA01S00U20210717D date, sort lcolor(red)) /// 166
(line TotCasMeRaA01S00U20210718D date, sort lcolor(red)) /// 167
(line TotCasMeRaA01S00U20210719D date, sort lcolor(red)) /// 168
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases DELP minus JOHN) title("COVID-19 total cases, $country, DELP minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2)) yscale(titlegap(2))
  	   
qui graph save "graph 42a COVID-19 total cases, $country, DELP, Difference.gph", replace
qui graph export "graph 42a COVID-19 total cases, $country, DELP, Difference.pdf", replace





*********

* total cases, Difference, together, without extremes 152

twoway  ///
(line TotCasMeRaA01S00U20200723D date, sort lcolor(red) lpattern(dash)) /// 1
(line TotCasMeRaA01S00U20200919D date, sort lcolor(red) lpattern(dash)) /// 2
(line TotCasMeRaA01S00U20200926D date, sort lcolor(red) lpattern(dash)) /// 3
(line TotCasMeRaA01S00U20201001D date, sort lcolor(red) lpattern(dash)) /// 4
(line TotCasMeRaA01S00U20201008D date, sort lcolor(red) lpattern(dash)) /// 5
(line TotCasMeRaA01S00U20201015D date, sort lcolor(red) lpattern(dash)) /// 6
(line TotCasMeRaA01S00U20201022D date, sort lcolor(red) lpattern(dash)) /// 7
(line TotCasMeRaA01S00U20201029D date, sort lcolor(red) lpattern(dash)) /// 8
(line TotCasMeRaA01S00U20201105D date, sort lcolor(red) lpattern(dash)) /// 9
(line TotCasMeRaA01S00U20201112D date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line TotCasMeRaA01S00U20201119D date, sort lcolor(red)) /// 11 v4
(line TotCasMeRaA01S00U20201126D date, sort lcolor(red)) /// 12
(line TotCasMeRaA01S00U20201203D date, sort lcolor(red)) /// 13
(line TotCasMeRaA01S00U20201210D date, sort lcolor(red)) /// 14
(line TotCasMeRaA01S00U20201217D date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20201224D date, sort lcolor(red)) /// 16
(line TotCasMeRaA01S00U20201231D date, sort lcolor(red)) /// 17
(line TotCasMeRaA01S00U20210107D date, sort lcolor(red)) /// 18
(line TotCasMeRaA01S00U20210114D date, sort lcolor(red)) /// 19
(line TotCasMeRaA01S00U20210121D date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210303D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210304D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210305D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210306D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210307D date, sort lcolor(red)) /// 25
(line TotCasMeRaA01S00U20210308D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210309D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210310D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210311D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210312D date, sort lcolor(red)) /// 30
(line TotCasMeRaA01S00U20210313D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210314D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210315D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210316D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210317D date, sort lcolor(red)) /// 35
(line TotCasMeRaA01S00U20210318D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210319D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210320D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210321D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210322D date, sort lcolor(red)) /// 40
(line TotCasMeRaA01S00U20210323D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210324D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210325D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210326D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210327D date, sort lcolor(red)) /// 45
(line TotCasMeRaA01S00U20210328D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210329D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210330D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210331D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210401D date, sort lcolor(red)) /// 50
(line TotCasMeRaA01S00U20210402D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210403D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210404D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210405D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210406D date, sort lcolor(red)) /// 55
(line TotCasMeRaA01S00U20210407D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210408D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210409D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210410D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210411D date, sort lcolor(red)) /// 60
(line TotCasMeRaA01S00U20210412D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210413D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210414D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210415D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210416D date, sort lcolor(red)) /// 65
(line TotCasMeRaA01S00U20210417D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210418D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210419D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210420D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210421D date, sort lcolor(red)) /// 70
(line TotCasMeRaA01S00U20210422D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210423D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210424D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210425D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210426D date, sort lcolor(red)) /// 75
(line TotCasMeRaA01S00U20210427D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210428D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210429D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210430D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210501D date, sort lcolor(red)) /// 80
(line TotCasMeRaA01S00U20210502D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210503D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210504D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210505D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210506D date, sort lcolor(red)) /// 85
(line TotCasMeRaA01S00U20210507D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210508D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210509D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210510D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210511D date, sort lcolor(red)) /// 90
(line TotCasMeRaA01S00U20210512D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210513D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210514D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210515D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210516D date, sort lcolor(red)) /// 95
(line TotCasMeRaA01S00U20210517D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210518D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210519D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210520D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210521D date, sort lcolor(red)) /// 100
(line TotCasMeRaA01S00U20210522D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210530D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210531D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210601D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210602D date, sort lcolor(red)) /// 105
(line TotCasMeRaA01S00U20210603D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210604D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210605D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210606D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210607D date, sort lcolor(red)) /// 110
(line TotCasMeRaA01S00U20210608D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210609D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210610D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210611D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210612D date, sort lcolor(red)) /// 115
(line TotCasMeRaA01S00U20210613D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210614D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210615D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210616D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210617D date, sort lcolor(red)) /// 120
(line TotCasMeRaA01S00U20210618D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210619D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210620D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210621D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210622D date, sort lcolor(red)) /// 125
(line TotCasMeRaA01S00U20210623D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210624D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210625D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210626D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210627D date, sort lcolor(red)) /// 130
(line TotCasMeRaA01S00U20210628D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210629D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210630D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210701D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210702D date, sort lcolor(red)) /// 135
(line TotCasMeRaA01S00U20210703D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210704D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210705D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210706D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210707D date, sort lcolor(red)) /// 140
(line TotCasMeRaA01S00U20210708D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210709D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210710D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210711D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210712D date, sort lcolor(red)) /// 145
(line TotCasMeRaA01S00U20210713D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210714D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210715D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210716D date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210717D date, sort lcolor(red)) /// 150
(line TotCasMeRaA01S00U20210718D date, sort lcolor(red)) /// 151
(line TotCasMeRaA01S00U20210719D date, sort lcolor(red)) /// 152
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases DELP divided by JOHN) title("COVID-19 total cases, $country, DELP minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; without extremes i.e. > 2 times max reported 8M", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 42b COVID-19 total cases, $country, DELP, wo extreme, Difference.gph", replace
qui graph export "graph 42b COVID-19 total cases, $country, DELP, wo extreme, Difference.pdf", replace



*


*********

* total cases, Times, together, with extremes 168

twoway  ///
(line TotCasMeRaA01S00U20200723T date, sort lcolor(red) lpattern(dash)) /// 1
(line TotCasMeRaA01S00U20200919T date, sort lcolor(red) lpattern(dash)) /// 2
(line TotCasMeRaA01S00U20200926T date, sort lcolor(red) lpattern(dash)) /// 3
(line TotCasMeRaA01S00U20201001T date, sort lcolor(red) lpattern(dash)) /// 4
(line TotCasMeRaA01S00U20201008T date, sort lcolor(red) lpattern(dash)) /// 5
(line TotCasMeRaA01S00U20201015T date, sort lcolor(red) lpattern(dash)) /// 6
(line TotCasMeRaA01S00U20201022T date, sort lcolor(red) lpattern(dash)) /// 7
(line TotCasMeRaA01S00U20201029T date, sort lcolor(red) lpattern(dash)) /// 8
(line TotCasMeRaA01S00U20201105T date, sort lcolor(red) lpattern(dash)) /// 9
(line TotCasMeRaA01S00U20201112T date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line TotCasMeRaA01S00U20201119T date, sort lcolor(red)) /// 11 v4
(line TotCasMeRaA01S00U20201126T date, sort lcolor(red)) /// 12
(line TotCasMeRaA01S00U20201203T date, sort lcolor(red)) /// 13
(line TotCasMeRaA01S00U20201210T date, sort lcolor(red)) /// 14
(line TotCasMeRaA01S00U20201217T date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20201224T date, sort lcolor(red)) /// 16
(line TotCasMeRaA01S00U20201231T date, sort lcolor(red)) /// 17
(line TotCasMeRaA01S00U20210107T date, sort lcolor(red)) /// 18
(line TotCasMeRaA01S00U20210114T date, sort lcolor(red)) /// 19
(line TotCasMeRaA01S00U20210121T date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210128T date, sort lcolor(red)) /// 21
(line TotCasMeRaA01S00U20210204T date, sort lcolor(red)) /// 22
(line TotCasMeRaA01S00U20210211T date, sort lcolor(red)) /// 23
(line TotCasMeRaA01S00U20210218T date, sort lcolor(red)) /// 24
(line TotCasMeRaA01S00U20210225T date, sort lcolor(red)) /// 25
(line TotCasMeRaA01S00U20210226T date, sort lcolor(red)) /// 26
(line TotCasMeRaA01S00U20210227T date, sort lcolor(red)) /// 27
(line TotCasMeRaA01S00U20210228T date, sort lcolor(red)) /// 28
(line TotCasMeRaA01S00U20210301T date, sort lcolor(red)) /// 29
(line TotCasMeRaA01S00U20210303T date, sort lcolor(red)) /// 30
(line TotCasMeRaA01S00U20210304T date, sort lcolor(red)) /// 31
(line TotCasMeRaA01S00U20210305T date, sort lcolor(red)) /// 32
(line TotCasMeRaA01S00U20210306T date, sort lcolor(red)) /// 33
(line TotCasMeRaA01S00U20210307T date, sort lcolor(red)) /// 34
(line TotCasMeRaA01S00U20210308T date, sort lcolor(red)) /// 35
(line TotCasMeRaA01S00U20210309T date, sort lcolor(red)) /// 36
(line TotCasMeRaA01S00U20210310T date, sort lcolor(red)) /// 37
(line TotCasMeRaA01S00U20210311T date, sort lcolor(red)) /// 38
(line TotCasMeRaA01S00U20210312T date, sort lcolor(red)) /// 39
(line TotCasMeRaA01S00U20210313T date, sort lcolor(red)) /// 40
(line TotCasMeRaA01S00U20210314T date, sort lcolor(red)) /// 41
(line TotCasMeRaA01S00U20210315T date, sort lcolor(red)) /// 42
(line TotCasMeRaA01S00U20210316T date, sort lcolor(red)) /// 43
(line TotCasMeRaA01S00U20210317T date, sort lcolor(red)) /// 44
(line TotCasMeRaA01S00U20210318T date, sort lcolor(red)) /// 45
(line TotCasMeRaA01S00U20210319T date, sort lcolor(red)) /// 46
(line TotCasMeRaA01S00U20210320T date, sort lcolor(red)) /// 47
(line TotCasMeRaA01S00U20210321T date, sort lcolor(red)) /// 48
(line TotCasMeRaA01S00U20210322T date, sort lcolor(red)) /// 49
(line TotCasMeRaA01S00U20210323T date, sort lcolor(red)) /// 50
(line TotCasMeRaA01S00U20210324T date, sort lcolor(red)) /// 51
(line TotCasMeRaA01S00U20210325T date, sort lcolor(red)) /// 52
(line TotCasMeRaA01S00U20210326T date, sort lcolor(red)) /// 53
(line TotCasMeRaA01S00U20210327T date, sort lcolor(red)) /// 54
(line TotCasMeRaA01S00U20210328T date, sort lcolor(red)) /// 55
(line TotCasMeRaA01S00U20210329T date, sort lcolor(red)) /// 56
(line TotCasMeRaA01S00U20210330T date, sort lcolor(red)) /// 57
(line TotCasMeRaA01S00U20210331T date, sort lcolor(red)) /// 58
(line TotCasMeRaA01S00U20210401T date, sort lcolor(red)) /// 59
(line TotCasMeRaA01S00U20210402T date, sort lcolor(red)) /// 60
(line TotCasMeRaA01S00U20210403T date, sort lcolor(red)) /// 61
(line TotCasMeRaA01S00U20210404T date, sort lcolor(red)) /// 62
(line TotCasMeRaA01S00U20210405T date, sort lcolor(red)) /// 63
(line TotCasMeRaA01S00U20210406T date, sort lcolor(red)) /// 64
(line TotCasMeRaA01S00U20210407T date, sort lcolor(red)) /// 65
(line TotCasMeRaA01S00U20210408T date, sort lcolor(red)) /// 66
(line TotCasMeRaA01S00U20210409T date, sort lcolor(red)) /// 67
(line TotCasMeRaA01S00U20210410T date, sort lcolor(red)) /// 68
(line TotCasMeRaA01S00U20210411T date, sort lcolor(red)) /// 69
(line TotCasMeRaA01S00U20210412T date, sort lcolor(red)) /// 70
(line TotCasMeRaA01S00U20210413T date, sort lcolor(red)) /// 71
(line TotCasMeRaA01S00U20210414T date, sort lcolor(red)) /// 72
(line TotCasMeRaA01S00U20210415T date, sort lcolor(red)) /// 73
(line TotCasMeRaA01S00U20210416T date, sort lcolor(red)) /// 74
(line TotCasMeRaA01S00U20210417T date, sort lcolor(red)) /// 75
(line TotCasMeRaA01S00U20210418T date, sort lcolor(red)) /// 76
(line TotCasMeRaA01S00U20210419T date, sort lcolor(red)) /// 77
(line TotCasMeRaA01S00U20210420T date, sort lcolor(red)) /// 78
(line TotCasMeRaA01S00U20210421T date, sort lcolor(red)) /// 79
(line TotCasMeRaA01S00U20210422T date, sort lcolor(red)) /// 80
(line TotCasMeRaA01S00U20210423T date, sort lcolor(red)) /// 81
(line TotCasMeRaA01S00U20210424T date, sort lcolor(red)) /// 82
(line TotCasMeRaA01S00U20210425T date, sort lcolor(red)) /// 83
(line TotCasMeRaA01S00U20210426T date, sort lcolor(red)) /// 84
(line TotCasMeRaA01S00U20210427T date, sort lcolor(red)) /// 85
(line TotCasMeRaA01S00U20210428T date, sort lcolor(red)) /// 86
(line TotCasMeRaA01S00U20210429T date, sort lcolor(red)) /// 87
(line TotCasMeRaA01S00U20210430T date, sort lcolor(red)) /// 88
(line TotCasMeRaA01S00U20210501T date, sort lcolor(red)) /// 89
(line TotCasMeRaA01S00U20210502T date, sort lcolor(red)) /// 90
(line TotCasMeRaA01S00U20210503T date, sort lcolor(red)) /// 91
(line TotCasMeRaA01S00U20210504T date, sort lcolor(red)) /// 92
(line TotCasMeRaA01S00U20210505T date, sort lcolor(red)) /// 93
(line TotCasMeRaA01S00U20210506T date, sort lcolor(red)) /// 94
(line TotCasMeRaA01S00U20210507T date, sort lcolor(red)) /// 95
(line TotCasMeRaA01S00U20210508T date, sort lcolor(red)) /// 96
(line TotCasMeRaA01S00U20210509T date, sort lcolor(red)) /// 97
(line TotCasMeRaA01S00U20210510T date, sort lcolor(red)) /// 98
(line TotCasMeRaA01S00U20210511T date, sort lcolor(red)) /// 99
(line TotCasMeRaA01S00U20210512T date, sort lcolor(red)) /// 100
(line TotCasMeRaA01S00U20210513T date, sort lcolor(red)) /// 101
(line TotCasMeRaA01S00U20210514T date, sort lcolor(red)) /// 102
(line TotCasMeRaA01S00U20210515T date, sort lcolor(red)) /// 103
(line TotCasMeRaA01S00U20210516T date, sort lcolor(red)) /// 104
(line TotCasMeRaA01S00U20210517T date, sort lcolor(red)) /// 105
(line TotCasMeRaA01S00U20210518T date, sort lcolor(red)) /// 106
(line TotCasMeRaA01S00U20210519T date, sort lcolor(red)) /// 107
(line TotCasMeRaA01S00U20210520T date, sort lcolor(red)) /// 108
(line TotCasMeRaA01S00U20210521T date, sort lcolor(red)) /// 109
(line TotCasMeRaA01S00U20210522T date, sort lcolor(red)) /// 110
(line TotCasMeRaA01S00U20210523T date, sort lcolor(red)) /// 111
(line TotCasMeRaA01S00U20210524T date, sort lcolor(red)) /// 112
(line TotCasMeRaA01S00U20210525T date, sort lcolor(red)) /// 113
(line TotCasMeRaA01S00U20210526T date, sort lcolor(red)) /// 114
(line TotCasMeRaA01S00U20210527T date, sort lcolor(red)) /// 115
(line TotCasMeRaA01S00U20210528T date, sort lcolor(red)) /// 116
(line TotCasMeRaA01S00U20210529T date, sort lcolor(red)) /// 117
(line TotCasMeRaA01S00U20210530T date, sort lcolor(red)) /// 118
(line TotCasMeRaA01S00U20210531T date, sort lcolor(red)) /// 119
(line TotCasMeRaA01S00U20210601T date, sort lcolor(red)) /// 120
(line TotCasMeRaA01S00U20210602T date, sort lcolor(red)) /// 121
(line TotCasMeRaA01S00U20210603T date, sort lcolor(red)) /// 122
(line TotCasMeRaA01S00U20210604T date, sort lcolor(red)) /// 123
(line TotCasMeRaA01S00U20210605T date, sort lcolor(red)) /// 124
(line TotCasMeRaA01S00U20210606T date, sort lcolor(red)) /// 125
(line TotCasMeRaA01S00U20210607T date, sort lcolor(red)) /// 126
(line TotCasMeRaA01S00U20210608T date, sort lcolor(red)) /// 127
(line TotCasMeRaA01S00U20210609T date, sort lcolor(red)) /// 128
(line TotCasMeRaA01S00U20210610T date, sort lcolor(red)) /// 129
(line TotCasMeRaA01S00U20210611T date, sort lcolor(red)) /// 130
(line TotCasMeRaA01S00U20210612T date, sort lcolor(red)) /// 131
(line TotCasMeRaA01S00U20210613T date, sort lcolor(red)) /// 132
(line TotCasMeRaA01S00U20210614T date, sort lcolor(red)) /// 133
(line TotCasMeRaA01S00U20210615T date, sort lcolor(red)) /// 134
(line TotCasMeRaA01S00U20210616T date, sort lcolor(red)) /// 135
(line TotCasMeRaA01S00U20210617T date, sort lcolor(red)) /// 136
(line TotCasMeRaA01S00U20210618T date, sort lcolor(red)) /// 137
(line TotCasMeRaA01S00U20210619T date, sort lcolor(red)) /// 138
(line TotCasMeRaA01S00U20210620T date, sort lcolor(red)) /// 139
(line TotCasMeRaA01S00U20210621T date, sort lcolor(red)) /// 140
(line TotCasMeRaA01S00U20210622T date, sort lcolor(red)) /// 141
(line TotCasMeRaA01S00U20210623T date, sort lcolor(red)) /// 142
(line TotCasMeRaA01S00U20210624T date, sort lcolor(red)) /// 143
(line TotCasMeRaA01S00U20210625T date, sort lcolor(red)) /// 144
(line TotCasMeRaA01S00U20210626T date, sort lcolor(red)) /// 145
(line TotCasMeRaA01S00U20210627T date, sort lcolor(red)) /// 146
(line TotCasMeRaA01S00U20210628T date, sort lcolor(red)) /// 147
(line TotCasMeRaA01S00U20210629T date, sort lcolor(red)) /// 148
(line TotCasMeRaA01S00U20210630T date, sort lcolor(red)) /// 149
(line TotCasMeRaA01S00U20210701T date, sort lcolor(red)) /// 150
(line TotCasMeRaA01S00U20210702T date, sort lcolor(red)) /// 151
(line TotCasMeRaA01S00U20210703T date, sort lcolor(red)) /// 152
(line TotCasMeRaA01S00U20210704T date, sort lcolor(red)) /// 153
(line TotCasMeRaA01S00U20210705T date, sort lcolor(red)) /// 154
(line TotCasMeRaA01S00U20210706T date, sort lcolor(red)) /// 155
(line TotCasMeRaA01S00U20210707T date, sort lcolor(red)) /// 156
(line TotCasMeRaA01S00U20210708T date, sort lcolor(red)) /// 157
(line TotCasMeRaA01S00U20210709T date, sort lcolor(red)) /// 158
(line TotCasMeRaA01S00U20210710T date, sort lcolor(red)) /// 159
(line TotCasMeRaA01S00U20210711T date, sort lcolor(red)) /// 160
(line TotCasMeRaA01S00U20210712T date, sort lcolor(red)) /// 161
(line TotCasMeRaA01S00U20210713T date, sort lcolor(red)) /// 162
(line TotCasMeRaA01S00U20210714T date, sort lcolor(red)) /// 163
(line TotCasMeRaA01S00U20210715T date, sort lcolor(red)) /// 164
(line TotCasMeRaA01S00U20210716T date, sort lcolor(red)) /// 165
(line TotCasMeRaA01S00U20210717T date, sort lcolor(red)) /// 166
(line TotCasMeRaA01S00U20210718T date, sort lcolor(red)) /// 167
(line TotCasMeRaA01S00U20210719T date, sort lcolor(red)) /// 168
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases DELP divided by JOHN) title("COVID-19 total cases, $country, DELP divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 43a COVID-19 total cases, $country, DELP, Times.gph", replace
qui graph export "graph 43a COVID-19 total cases, $country, DELP, Times.pdf", replace





*********

* total cases, Times, together, without extremes 152

twoway  ///
(line TotCasMeRaA01S00U20200723T date, sort lcolor(red) lpattern(dash)) /// 1
(line TotCasMeRaA01S00U20200919T date, sort lcolor(red) lpattern(dash)) /// 2
(line TotCasMeRaA01S00U20200926T date, sort lcolor(red) lpattern(dash)) /// 3
(line TotCasMeRaA01S00U20201001T date, sort lcolor(red) lpattern(dash)) /// 4
(line TotCasMeRaA01S00U20201008T date, sort lcolor(red) lpattern(dash)) /// 5
(line TotCasMeRaA01S00U20201015T date, sort lcolor(red) lpattern(dash)) /// 6
(line TotCasMeRaA01S00U20201022T date, sort lcolor(red) lpattern(dash)) /// 7
(line TotCasMeRaA01S00U20201029T date, sort lcolor(red) lpattern(dash)) /// 8
(line TotCasMeRaA01S00U20201105T date, sort lcolor(red) lpattern(dash)) /// 9
(line TotCasMeRaA01S00U20201112T date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line TotCasMeRaA01S00U20201119T date, sort lcolor(red)) /// 11 v4
(line TotCasMeRaA01S00U20201126T date, sort lcolor(red)) /// 12
(line TotCasMeRaA01S00U20201203T date, sort lcolor(red)) /// 13
(line TotCasMeRaA01S00U20201210T date, sort lcolor(red)) /// 14
(line TotCasMeRaA01S00U20201217T date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20201224T date, sort lcolor(red)) /// 16
(line TotCasMeRaA01S00U20201231T date, sort lcolor(red)) /// 17
(line TotCasMeRaA01S00U20210107T date, sort lcolor(red)) /// 18
(line TotCasMeRaA01S00U20210114T date, sort lcolor(red)) /// 19
(line TotCasMeRaA01S00U20210121T date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210303T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210304T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210305T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210306T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210307T date, sort lcolor(red)) /// 25
(line TotCasMeRaA01S00U20210308T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210309T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210310T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210311T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210312T date, sort lcolor(red)) /// 30
(line TotCasMeRaA01S00U20210313T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210314T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210315T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210316T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210317T date, sort lcolor(red)) /// 35
(line TotCasMeRaA01S00U20210318T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210319T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210320T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210321T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210322T date, sort lcolor(red)) /// 40
(line TotCasMeRaA01S00U20210323T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210324T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210325T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210326T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210327T date, sort lcolor(red)) /// 45
(line TotCasMeRaA01S00U20210328T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210329T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210330T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210331T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210401T date, sort lcolor(red)) /// 50
(line TotCasMeRaA01S00U20210402T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210403T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210404T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210405T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210406T date, sort lcolor(red)) /// 55
(line TotCasMeRaA01S00U20210407T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210408T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210409T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210410T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210411T date, sort lcolor(red)) /// 60
(line TotCasMeRaA01S00U20210412T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210413T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210414T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210415T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210416T date, sort lcolor(red)) /// 65
(line TotCasMeRaA01S00U20210417T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210418T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210419T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210420T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210421T date, sort lcolor(red)) /// 70
(line TotCasMeRaA01S00U20210422T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210423T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210424T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210425T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210426T date, sort lcolor(red)) /// 75
(line TotCasMeRaA01S00U20210427T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210428T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210429T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210430T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210501T date, sort lcolor(red)) /// 80
(line TotCasMeRaA01S00U20210502T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210503T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210504T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210505T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210506T date, sort lcolor(red)) /// 85
(line TotCasMeRaA01S00U20210507T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210508T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210509T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210510T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210511T date, sort lcolor(red)) /// 90
(line TotCasMeRaA01S00U20210512T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210513T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210514T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210515T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210516T date, sort lcolor(red)) /// 95
(line TotCasMeRaA01S00U20210517T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210518T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210519T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210520T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210521T date, sort lcolor(red)) /// 100
(line TotCasMeRaA01S00U20210522T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210530T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210531T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210601T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210602T date, sort lcolor(red)) /// 105
(line TotCasMeRaA01S00U20210603T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210604T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210605T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210606T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210607T date, sort lcolor(red)) /// 110
(line TotCasMeRaA01S00U20210608T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210609T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210610T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210611T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210612T date, sort lcolor(red)) /// 115
(line TotCasMeRaA01S00U20210613T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210614T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210615T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210616T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210617T date, sort lcolor(red)) /// 120
(line TotCasMeRaA01S00U20210618T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210619T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210620T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210621T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210622T date, sort lcolor(red)) /// 125
(line TotCasMeRaA01S00U20210623T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210624T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210625T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210626T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210627T date, sort lcolor(red)) /// 130
(line TotCasMeRaA01S00U20210628T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210629T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210630T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210701T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210702T date, sort lcolor(red)) /// 135
(line TotCasMeRaA01S00U20210703T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210704T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210705T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210706T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210707T date, sort lcolor(red)) /// 140
(line TotCasMeRaA01S00U20210708T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210709T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210710T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210711T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210712T date, sort lcolor(red)) /// 145
(line TotCasMeRaA01S00U20210713T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210714T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210715T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210716T date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210717T date, sort lcolor(red)) /// 150
(line TotCasMeRaA01S00U20210718T date, sort lcolor(red)) /// 151
(line TotCasMeRaA01S00U20210719T date, sort lcolor(red)) /// 152
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases DELP divided by JOHN) title("COVID-19 total cases, $country, DELP divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; without extremes i.e. > 2 times max reported 8M", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 43b COVID-19 total cases, $country, DELP, wo extreme, Times.gph", replace
qui graph export "graph 43b COVID-19 total cases, $country, DELP, wo extreme, Times.pdf", replace






*********

* total cases, Percent, together, with extremes 168

twoway  ///
(line TotCasMeRaA01S00U20200723P date, sort lcolor(red) lpattern(dash)) /// 1
(line TotCasMeRaA01S00U20200919P date, sort lcolor(red) lpattern(dash)) /// 2
(line TotCasMeRaA01S00U20200926P date, sort lcolor(red) lpattern(dash)) /// 3
(line TotCasMeRaA01S00U20201001P date, sort lcolor(red) lpattern(dash)) /// 4
(line TotCasMeRaA01S00U20201008P date, sort lcolor(red) lpattern(dash)) /// 5
(line TotCasMeRaA01S00U20201015P date, sort lcolor(red) lpattern(dash)) /// 6
(line TotCasMeRaA01S00U20201022P date, sort lcolor(red) lpattern(dash)) /// 7
(line TotCasMeRaA01S00U20201029P date, sort lcolor(red) lpattern(dash)) /// 8
(line TotCasMeRaA01S00U20201105P date, sort lcolor(red) lpattern(dash)) /// 9
(line TotCasMeRaA01S00U20201112P date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line TotCasMeRaA01S00U20201119P date, sort lcolor(red)) /// 11 v4
(line TotCasMeRaA01S00U20201126P date, sort lcolor(red)) /// 12
(line TotCasMeRaA01S00U20201203P date, sort lcolor(red)) /// 13
(line TotCasMeRaA01S00U20201210P date, sort lcolor(red)) /// 14
(line TotCasMeRaA01S00U20201217P date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20201224P date, sort lcolor(red)) /// 16
(line TotCasMeRaA01S00U20201231P date, sort lcolor(red)) /// 17
(line TotCasMeRaA01S00U20210107P date, sort lcolor(red)) /// 18
(line TotCasMeRaA01S00U20210114P date, sort lcolor(red)) /// 19
(line TotCasMeRaA01S00U20210121P date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210128P date, sort lcolor(red)) /// 21
(line TotCasMeRaA01S00U20210204P date, sort lcolor(red)) /// 22
(line TotCasMeRaA01S00U20210211P date, sort lcolor(red)) /// 23
(line TotCasMeRaA01S00U20210218P date, sort lcolor(red)) /// 24
(line TotCasMeRaA01S00U20210225P date, sort lcolor(red)) /// 25
(line TotCasMeRaA01S00U20210226P date, sort lcolor(red)) /// 26
(line TotCasMeRaA01S00U20210227P date, sort lcolor(red)) /// 27
(line TotCasMeRaA01S00U20210228P date, sort lcolor(red)) /// 28
(line TotCasMeRaA01S00U20210301P date, sort lcolor(red)) /// 29
(line TotCasMeRaA01S00U20210303P date, sort lcolor(red)) /// 30
(line TotCasMeRaA01S00U20210304P date, sort lcolor(red)) /// 31
(line TotCasMeRaA01S00U20210305P date, sort lcolor(red)) /// 32
(line TotCasMeRaA01S00U20210306P date, sort lcolor(red)) /// 33
(line TotCasMeRaA01S00U20210307P date, sort lcolor(red)) /// 34
(line TotCasMeRaA01S00U20210308P date, sort lcolor(red)) /// 35
(line TotCasMeRaA01S00U20210309P date, sort lcolor(red)) /// 36
(line TotCasMeRaA01S00U20210310P date, sort lcolor(red)) /// 37
(line TotCasMeRaA01S00U20210311P date, sort lcolor(red)) /// 38
(line TotCasMeRaA01S00U20210312P date, sort lcolor(red)) /// 39
(line TotCasMeRaA01S00U20210313P date, sort lcolor(red)) /// 40
(line TotCasMeRaA01S00U20210314P date, sort lcolor(red)) /// 41
(line TotCasMeRaA01S00U20210315P date, sort lcolor(red)) /// 42
(line TotCasMeRaA01S00U20210316P date, sort lcolor(red)) /// 43
(line TotCasMeRaA01S00U20210317P date, sort lcolor(red)) /// 44
(line TotCasMeRaA01S00U20210318P date, sort lcolor(red)) /// 45
(line TotCasMeRaA01S00U20210319P date, sort lcolor(red)) /// 46
(line TotCasMeRaA01S00U20210320P date, sort lcolor(red)) /// 47
(line TotCasMeRaA01S00U20210321P date, sort lcolor(red)) /// 48
(line TotCasMeRaA01S00U20210322P date, sort lcolor(red)) /// 49
(line TotCasMeRaA01S00U20210323P date, sort lcolor(red)) /// 50
(line TotCasMeRaA01S00U20210324P date, sort lcolor(red)) /// 51
(line TotCasMeRaA01S00U20210325P date, sort lcolor(red)) /// 52
(line TotCasMeRaA01S00U20210326P date, sort lcolor(red)) /// 53
(line TotCasMeRaA01S00U20210327P date, sort lcolor(red)) /// 54
(line TotCasMeRaA01S00U20210328P date, sort lcolor(red)) /// 55
(line TotCasMeRaA01S00U20210329P date, sort lcolor(red)) /// 56
(line TotCasMeRaA01S00U20210330P date, sort lcolor(red)) /// 57
(line TotCasMeRaA01S00U20210331P date, sort lcolor(red)) /// 58
(line TotCasMeRaA01S00U20210401P date, sort lcolor(red)) /// 59
(line TotCasMeRaA01S00U20210402P date, sort lcolor(red)) /// 60
(line TotCasMeRaA01S00U20210403P date, sort lcolor(red)) /// 61
(line TotCasMeRaA01S00U20210404P date, sort lcolor(red)) /// 62
(line TotCasMeRaA01S00U20210405P date, sort lcolor(red)) /// 63
(line TotCasMeRaA01S00U20210406P date, sort lcolor(red)) /// 64
(line TotCasMeRaA01S00U20210407P date, sort lcolor(red)) /// 65
(line TotCasMeRaA01S00U20210408P date, sort lcolor(red)) /// 66
(line TotCasMeRaA01S00U20210409P date, sort lcolor(red)) /// 67
(line TotCasMeRaA01S00U20210410P date, sort lcolor(red)) /// 68
(line TotCasMeRaA01S00U20210411P date, sort lcolor(red)) /// 69
(line TotCasMeRaA01S00U20210412P date, sort lcolor(red)) /// 70
(line TotCasMeRaA01S00U20210413P date, sort lcolor(red)) /// 71
(line TotCasMeRaA01S00U20210414P date, sort lcolor(red)) /// 72
(line TotCasMeRaA01S00U20210415P date, sort lcolor(red)) /// 73
(line TotCasMeRaA01S00U20210416P date, sort lcolor(red)) /// 74
(line TotCasMeRaA01S00U20210417P date, sort lcolor(red)) /// 75
(line TotCasMeRaA01S00U20210418P date, sort lcolor(red)) /// 76
(line TotCasMeRaA01S00U20210419P date, sort lcolor(red)) /// 77
(line TotCasMeRaA01S00U20210420P date, sort lcolor(red)) /// 78
(line TotCasMeRaA01S00U20210421P date, sort lcolor(red)) /// 79
(line TotCasMeRaA01S00U20210422P date, sort lcolor(red)) /// 80
(line TotCasMeRaA01S00U20210423P date, sort lcolor(red)) /// 81
(line TotCasMeRaA01S00U20210424P date, sort lcolor(red)) /// 82
(line TotCasMeRaA01S00U20210425P date, sort lcolor(red)) /// 83
(line TotCasMeRaA01S00U20210426P date, sort lcolor(red)) /// 84
(line TotCasMeRaA01S00U20210427P date, sort lcolor(red)) /// 85
(line TotCasMeRaA01S00U20210428P date, sort lcolor(red)) /// 86
(line TotCasMeRaA01S00U20210429P date, sort lcolor(red)) /// 87
(line TotCasMeRaA01S00U20210430P date, sort lcolor(red)) /// 88
(line TotCasMeRaA01S00U20210501P date, sort lcolor(red)) /// 89
(line TotCasMeRaA01S00U20210502P date, sort lcolor(red)) /// 90
(line TotCasMeRaA01S00U20210503P date, sort lcolor(red)) /// 91
(line TotCasMeRaA01S00U20210504P date, sort lcolor(red)) /// 92
(line TotCasMeRaA01S00U20210505P date, sort lcolor(red)) /// 93
(line TotCasMeRaA01S00U20210506P date, sort lcolor(red)) /// 94
(line TotCasMeRaA01S00U20210507P date, sort lcolor(red)) /// 95
(line TotCasMeRaA01S00U20210508P date, sort lcolor(red)) /// 96
(line TotCasMeRaA01S00U20210509P date, sort lcolor(red)) /// 97
(line TotCasMeRaA01S00U20210510P date, sort lcolor(red)) /// 98
(line TotCasMeRaA01S00U20210511P date, sort lcolor(red)) /// 99
(line TotCasMeRaA01S00U20210512P date, sort lcolor(red)) /// 100
(line TotCasMeRaA01S00U20210513P date, sort lcolor(red)) /// 101
(line TotCasMeRaA01S00U20210514P date, sort lcolor(red)) /// 102
(line TotCasMeRaA01S00U20210515P date, sort lcolor(red)) /// 103
(line TotCasMeRaA01S00U20210516P date, sort lcolor(red)) /// 104
(line TotCasMeRaA01S00U20210517P date, sort lcolor(red)) /// 105
(line TotCasMeRaA01S00U20210518P date, sort lcolor(red)) /// 106
(line TotCasMeRaA01S00U20210519P date, sort lcolor(red)) /// 107
(line TotCasMeRaA01S00U20210520P date, sort lcolor(red)) /// 108
(line TotCasMeRaA01S00U20210521P date, sort lcolor(red)) /// 109
(line TotCasMeRaA01S00U20210522P date, sort lcolor(red)) /// 110
(line TotCasMeRaA01S00U20210523P date, sort lcolor(red)) /// 111
(line TotCasMeRaA01S00U20210524P date, sort lcolor(red)) /// 112
(line TotCasMeRaA01S00U20210525P date, sort lcolor(red)) /// 113
(line TotCasMeRaA01S00U20210526P date, sort lcolor(red)) /// 114
(line TotCasMeRaA01S00U20210527P date, sort lcolor(red)) /// 115
(line TotCasMeRaA01S00U20210528P date, sort lcolor(red)) /// 116
(line TotCasMeRaA01S00U20210529P date, sort lcolor(red)) /// 117
(line TotCasMeRaA01S00U20210530P date, sort lcolor(red)) /// 118
(line TotCasMeRaA01S00U20210531P date, sort lcolor(red)) /// 119
(line TotCasMeRaA01S00U20210601P date, sort lcolor(red)) /// 120
(line TotCasMeRaA01S00U20210602P date, sort lcolor(red)) /// 121
(line TotCasMeRaA01S00U20210603P date, sort lcolor(red)) /// 122
(line TotCasMeRaA01S00U20210604P date, sort lcolor(red)) /// 123
(line TotCasMeRaA01S00U20210605P date, sort lcolor(red)) /// 124
(line TotCasMeRaA01S00U20210606P date, sort lcolor(red)) /// 125
(line TotCasMeRaA01S00U20210607P date, sort lcolor(red)) /// 126
(line TotCasMeRaA01S00U20210608P date, sort lcolor(red)) /// 127
(line TotCasMeRaA01S00U20210609P date, sort lcolor(red)) /// 128
(line TotCasMeRaA01S00U20210610P date, sort lcolor(red)) /// 129
(line TotCasMeRaA01S00U20210611P date, sort lcolor(red)) /// 130
(line TotCasMeRaA01S00U20210612P date, sort lcolor(red)) /// 131
(line TotCasMeRaA01S00U20210613P date, sort lcolor(red)) /// 132
(line TotCasMeRaA01S00U20210614P date, sort lcolor(red)) /// 133
(line TotCasMeRaA01S00U20210615P date, sort lcolor(red)) /// 134
(line TotCasMeRaA01S00U20210616P date, sort lcolor(red)) /// 135
(line TotCasMeRaA01S00U20210617P date, sort lcolor(red)) /// 136
(line TotCasMeRaA01S00U20210618P date, sort lcolor(red)) /// 137
(line TotCasMeRaA01S00U20210619P date, sort lcolor(red)) /// 138
(line TotCasMeRaA01S00U20210620P date, sort lcolor(red)) /// 139
(line TotCasMeRaA01S00U20210621P date, sort lcolor(red)) /// 140
(line TotCasMeRaA01S00U20210622P date, sort lcolor(red)) /// 141
(line TotCasMeRaA01S00U20210623P date, sort lcolor(red)) /// 142
(line TotCasMeRaA01S00U20210624P date, sort lcolor(red)) /// 143
(line TotCasMeRaA01S00U20210625P date, sort lcolor(red)) /// 144
(line TotCasMeRaA01S00U20210626P date, sort lcolor(red)) /// 145
(line TotCasMeRaA01S00U20210627P date, sort lcolor(red)) /// 146
(line TotCasMeRaA01S00U20210628P date, sort lcolor(red)) /// 147
(line TotCasMeRaA01S00U20210629P date, sort lcolor(red)) /// 148
(line TotCasMeRaA01S00U20210630P date, sort lcolor(red)) /// 149
(line TotCasMeRaA01S00U20210701P date, sort lcolor(red)) /// 150
(line TotCasMeRaA01S00U20210702P date, sort lcolor(red)) /// 151
(line TotCasMeRaA01S00U20210703P date, sort lcolor(red)) /// 152
(line TotCasMeRaA01S00U20210704P date, sort lcolor(red)) /// 153
(line TotCasMeRaA01S00U20210705P date, sort lcolor(red)) /// 154
(line TotCasMeRaA01S00U20210706P date, sort lcolor(red)) /// 155
(line TotCasMeRaA01S00U20210707P date, sort lcolor(red)) /// 156
(line TotCasMeRaA01S00U20210708P date, sort lcolor(red)) /// 157
(line TotCasMeRaA01S00U20210709P date, sort lcolor(red)) /// 158
(line TotCasMeRaA01S00U20210710P date, sort lcolor(red)) /// 159
(line TotCasMeRaA01S00U20210711P date, sort lcolor(red)) /// 160
(line TotCasMeRaA01S00U20210712P date, sort lcolor(red)) /// 161
(line TotCasMeRaA01S00U20210713P date, sort lcolor(red)) /// 162
(line TotCasMeRaA01S00U20210714P date, sort lcolor(red)) /// 163
(line TotCasMeRaA01S00U20210715P date, sort lcolor(red)) /// 164
(line TotCasMeRaA01S00U20210716P date, sort lcolor(red)) /// 165
(line TotCasMeRaA01S00U20210717P date, sort lcolor(red)) /// 166
(line TotCasMeRaA01S00U20210718P date, sort lcolor(red)) /// 167
(line TotCasMeRaA01S00U20210719P date, sort lcolor(red)) /// 168
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases DELP percent JOHN) title("COVID-19 total cases, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; with extremes", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 44a COVID-19 total cases, $country, DELP, Percent.gph", replace
qui graph export "graph 44a COVID-19 total cases, $country, DELP, Percent.pdf", replace





*********

* total cases, Percent, together, without extremes 152

twoway  ///
(line TotCasMeRaA01S00U20200723P date, sort lcolor(red) lpattern(dash)) /// 1
(line TotCasMeRaA01S00U20201029P date, sort lcolor(red) lpattern(dash)) /// 8
(line TotCasMeRaA01S00U20201105P date, sort lcolor(red) lpattern(dash)) /// 9
(line TotCasMeRaA01S00U20201112P date, sort lcolor(red) lpattern(dash)) /// 10 v2
(line TotCasMeRaA01S00U20201119P date, sort lcolor(red)) /// 11 v4
(line TotCasMeRaA01S00U20201126P date, sort lcolor(red)) /// 12
(line TotCasMeRaA01S00U20201203P date, sort lcolor(red)) /// 13
(line TotCasMeRaA01S00U20201210P date, sort lcolor(red)) /// 14
(line TotCasMeRaA01S00U20201217P date, sort lcolor(red)) /// 15
(line TotCasMeRaA01S00U20201224P date, sort lcolor(red)) /// 16
(line TotCasMeRaA01S00U20201231P date, sort lcolor(red)) /// 17
(line TotCasMeRaA01S00U20210107P date, sort lcolor(red)) /// 18
(line TotCasMeRaA01S00U20210114P date, sort lcolor(red)) /// 19
(line TotCasMeRaA01S00U20210121P date, sort lcolor(red)) /// 20
(line TotCasMeRaA01S00U20210303P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210304P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210305P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210306P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210307P date, sort lcolor(red)) /// 25
(line TotCasMeRaA01S00U20210308P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210309P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210310P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210311P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210312P date, sort lcolor(red)) /// 30
(line TotCasMeRaA01S00U20210313P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210314P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210315P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210316P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210317P date, sort lcolor(red)) /// 35
(line TotCasMeRaA01S00U20210318P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210319P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210320P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210321P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210322P date, sort lcolor(red)) /// 40
(line TotCasMeRaA01S00U20210323P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210324P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210325P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210326P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210327P date, sort lcolor(red)) /// 45
(line TotCasMeRaA01S00U20210328P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210329P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210330P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210331P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210401P date, sort lcolor(red)) /// 50
(line TotCasMeRaA01S00U20210402P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210403P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210404P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210405P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210406P date, sort lcolor(red)) /// 55
(line TotCasMeRaA01S00U20210407P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210408P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210409P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210410P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210411P date, sort lcolor(red)) /// 60
(line TotCasMeRaA01S00U20210412P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210413P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210414P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210415P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210416P date, sort lcolor(red)) /// 65
(line TotCasMeRaA01S00U20210417P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210418P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210419P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210420P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210421P date, sort lcolor(red)) /// 70
(line TotCasMeRaA01S00U20210422P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210423P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210424P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210425P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210426P date, sort lcolor(red)) /// 75
(line TotCasMeRaA01S00U20210427P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210428P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210429P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210430P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210501P date, sort lcolor(red)) /// 80
(line TotCasMeRaA01S00U20210502P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210503P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210504P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210505P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210506P date, sort lcolor(red)) /// 85
(line TotCasMeRaA01S00U20210507P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210508P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210509P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210510P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210511P date, sort lcolor(red)) /// 90
(line TotCasMeRaA01S00U20210512P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210513P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210514P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210515P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210516P date, sort lcolor(red)) /// 95
(line TotCasMeRaA01S00U20210517P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210518P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210519P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210520P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210521P date, sort lcolor(red)) /// 100
(line TotCasMeRaA01S00U20210522P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210530P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210531P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210601P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210602P date, sort lcolor(red)) /// 105
(line TotCasMeRaA01S00U20210603P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210604P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210605P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210606P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210607P date, sort lcolor(red)) /// 110
(line TotCasMeRaA01S00U20210608P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210609P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210610P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210611P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210612P date, sort lcolor(red)) /// 115
(line TotCasMeRaA01S00U20210613P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210614P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210615P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210616P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210617P date, sort lcolor(red)) /// 120
(line TotCasMeRaA01S00U20210618P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210619P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210620P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210621P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210622P date, sort lcolor(red)) /// 125
(line TotCasMeRaA01S00U20210623P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210624P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210625P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210626P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210627P date, sort lcolor(red)) /// 130
(line TotCasMeRaA01S00U20210628P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210629P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210630P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210701P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210702P date, sort lcolor(red)) /// 135
(line TotCasMeRaA01S00U20210703P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210704P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210705P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210706P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210707P date, sort lcolor(red)) /// 140
(line TotCasMeRaA01S00U20210708P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210709P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210710P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210711P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210712P date, sort lcolor(red)) /// 145
(line TotCasMeRaA01S00U20210713P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210714P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210715P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210716P date, sort lcolor(red)) /// 
(line TotCasMeRaA01S00U20210717P date, sort lcolor(red)) /// 150
(line TotCasMeRaA01S00U20210718P date, sort lcolor(red)) /// 151
(line TotCasMeRaA01S00U20210719P date, sort lcolor(red)) /// 152
, xtitle(Date) xlabel(#22, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total cases DELP percent JOHN) title("COVID-19 total cases, $country, % (DELP minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200723 to 20210715; single scenario; without extremes i.e. > 2 times max reported 8M", size(small)) ///
legend(order(10 "DELP v2" 11 "DELP v4") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 44b COVID-19 total cases, $country, DELP, wo extreme, Percent.gph", replace
qui graph export "graph 44b COVID-19 total cases, $country, DELP, wo extreme, Percent.pdf", replace







view "log country DELP.smcl"

log close

exit, clear




