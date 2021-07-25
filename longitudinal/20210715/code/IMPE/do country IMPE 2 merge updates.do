

clear all

cd "$pathcovir2"

cd IMPE

capture log close

log using "log country IMPE 2 merge updates.smcl", replace


*****************************************************************************
* This is "do country IMPE 2 merge updates.do"

* Project: CovidVisualized country - countries without subnational estimates
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare IMPE study estimates for country
*****************************************************************************




* IMPE model versions, Iran

* IMPE V4 20200619 to 20200731
* IMPE V5 20200808 to 20201101
* IMPE V6 20201110 to 20210112
* IMPE V7 20210118 to 20210424
* IMPE V8 20210510 to when specified otherwise





* get Johns Hopkins	


qui {


* get Johns Hopkins data for deaths


import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv" ///
, clear varnames(1) colrange(2:2)

save "time_series_covid19_deaths_global col 2.dta", replace


import delimited ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv" ///
, clear varnames(1) colrange(5)


save "time_series_covid19_deaths_global col 5 on.dta", replace


use "time_series_covid19_deaths_global col 2.dta", clear 

merge 1:1 _n using "time_series_covid19_deaths_global col 5 on.dta"


rename countryregion loc_grand_name

label var loc_grand_name "location grand name"

keep if regexm(loc_grand_name,"$country") == 1

order loc_grand_name, last

gen counter = _n

reshape long v, i(counter) 

drop counter 

codebook _j

// replace _j = _j - 4 // compensate for first vars in the original file

gen date = date("22 Jan 2020", "DMY")

replace date = date + _j - 1

format date %td

codebook date

order date 

rename v TotDeaMeRaA00S00

label var TotDeaMeRaA00S00 "Total Deaths JOHN"

destring TotDeaMeRaA00S00, replace

list TotDeaMeRaA00S00 if date == td(19feb2020) // Shoule be 2

gen DayDeaMeRaA00S00 =  TotDeaMeRaA00S00[_n] - TotDeaMeRaA00S00[_n-1]

label var DayDeaMeRaA00S00 "Daily Deaths JOHN"

replace DayDeaMeRaA00S00 = TotDeaMeRaA00S00 if _j == 1

replace TotDeaMeRaA00S00 = . if date < td(19feb2020)

replace DayDeaMeRaA00S00 = . if date < td(19feb2020)

drop _j _merge






order date loc_grand_name DayDeaMeRaA00S00 TotDeaMeRaA00S00    
					

sort date

save "country JOHN deaths.dta", replace









* get Johns Hopkins data for cases


import delimited using ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv" ///
, clear varnames(1) colrange(2:2)

save "time_series_covid19_confirmed_global col 2.dta", replace


import delimited using ///
"https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv" ///
, clear varnames(1) colrange(5)

save "time_series_covid19_confirmed_global col 5 on.dta", replace


use "time_series_covid19_confirmed_global col 2.dta", clear 

merge 1:1 _n using "time_series_covid19_confirmed_global col 5 on.dta"


rename countryregion loc_grand_name

keep if regexm(loc_grand_name,"$country") == 1

order loc_grand_name, last

gen counter = _n

reshape long v, i(counter) 

drop counter 

codebook _j

gen date = date("22 Jan 2020", "DMY")

replace date = date + _j - 1

format date %td

codebook date

order date 

rename v TotCasMeRaA00S00

label var TotCasMeRaA00S00 "Total Cases JOHN"

destring TotCasMeRaA00S00, replace

gen DayCasMeRaA00S00 =  TotCasMeRaA00S00[_n] - TotCasMeRaA00S00[_n-1]

label var DayCasMeRaA00S00 "Daily Cases JOHN"

replace DayCasMeRaA00S00 = TotCasMeRaA00S00 if _j == 1

replace TotCasMeRaA00S00 = . if date < td(19feb2020)

replace DayCasMeRaA00S00 = . if date < td(19feb2020)

drop _j _merge




order date loc_grand_name DayCasMeRaA00S00 TotCasMeRaA00S00    

sort date

compress

save "country JOHN Cases.dta", replace









* merge deaths and cases 

use "country JOHN deaths.dta", clear 

merge 1:1 date using "country JOHN Cases.dta"

drop _merge



****** add obs 01 Jan 2020 to 21 Jan 2020 for better graphing


expand 22 in 1

sort date

rename date date_original 

gen date = .

replace date = td(01Jan2020) in 1

replace date = date[_n-1] + 1 in 2/l

format date %tdDDMonCCYY

codebook date

drop date_original

order date



* smooth 

tsset date, daily   


tssmooth ma DayDeaMeRaA00S00_window = DayDeaMeRaA00S00 if DayDeaMeRaA00S00 >= 0, window(3 1 3)

tssmooth ma DayDeaMeSmA00S00 = DayDeaMeRaA00S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayDeaMeSmA00S00 "Daily deaths smooth A00 JOHN"

drop DayDeaMeRaA00S00_window


tssmooth ma DayCasMeRaA00S00_window = DayCasMeRaA00S00 if DayCasMeRaA00S00 >= 0, window(3 1 3)

tssmooth ma DayCasMeSmA00S00 = DayCasMeRaA00S00_window, weights( 1 2 3 <4> 3 2 1) replace

label var DayCasMeSmA00S00 "Daily cases smooth A00 JOHN"

drop DayCasMeRaA00S00_window

tsset, clear



**************


}
*
	
	


global IMPEupdatelist ///
20200619 /// v4 /// 1
20200623 /// v4 /// 2
20200702 /// v4 /// 3
20200703 /// v4 /// 4
20200704 /// v4 /// 5
20200707 /// v4 /// 6
20200711 /// v4 /// 7
20200714 /// v4 /// 8
20200715 /// v4 /// 9
20200718 /// v4 /// 10
20200720 /// v4 /// 11
20200722 /// v4 /// 12
20200725 /// v4 /// 13
20200727 /// v4 /// 14
20200731 /// v4 /// 15
20200808 /// v5 /// 16
20200810 /// v5 /// 17
20200811 /// v5 /// 18
20200813 /// v5 /// 19
20200814 /// v5 /// 20
20200817 /// v5 /// 21
20200823 /// v5 /// 22
20200825 /// v5 /// 23
20200827 /// v5 /// 24
20200831 /// v5 /// 25
20200902 /// v5 /// 26
20200906 /// v5 /// 27
20200908 /// v5 /// 28
20200912 /// v5 /// 29
20200915 /// v5 /// 30
20200919 /// v5 /// 31
20200923 /// v5 /// 32
20200925 /// v5 /// 33
20201003 /// v5 /// 34
20201006 /// v5 /// 35
20201012 /// v5 /// 36
20201019 /// v5 /// 37
20201025 /// v5 /// 38
20201028 /// v5 /// 39
20201101 /// v5 /// 40
20201110 /// v6 /// 41
20201114 /// v6 /// 42
20201118 /// v6 /// 43
20201123 /// v6 /// 44
20201129 /// v6 /// 45
20201204 /// v6 /// 46
20201212 /// v6 /// 47
20201220 /// v6 /// 48
20201226 /// v6 /// 49
20210104 /// v6 /// 50
20210110 /// v6 /// 51
20210112 /// v6 /// 52
20210118 /// v7 /// 53
20210124 /// v7 /// 54
20210130 /// v7 /// 55
20210203 /// v7 /// 56
20210210 /// v7 /// 57
20210217 /// v7 /// 58
20210226 /// v7 /// 59
20210305 /// v7 /// 60
20210312 /// v7 /// 61
20210319 /// v7 /// 62
20210329 /// v7 /// 63
20210406 /// v7 /// 64
20210417 /// v7 /// 65
20210424 /// v7 /// 66
20210510 /// v8 /// 67
20210516 /// v8 /// 68
20210522 /// v8 /// 69
20210527 /// v8 /// 70
20210604 /// v8 /// 71
20210611 /// v8 /// 72
20210618 /// v8 /// 73
20210626 /// v8 /// 74
20210702 /// v8 /// 75
20210709 //  v8 /// 76






foreach l of global IMPEupdatelist {

qui {

merge m:m date loc_grand_name using "IMPE `l' country.dta"

drop _merge

* quitely running commands ...

}
}
*



* gen vars for D Difference, T Times (more or less), P Percent

/* 
DayDeaMeRaA03S02
TotDeaMeRaA03S02
DayINFMeRaA03S02
TotINFMeRaA03S02
*/




foreach l of global IMPEupdatelist { 

qui { 
    
gen DayDeaMeRaA03S02U`l'D = DayDeaMeRaA03S02U`l' - DayDeaMeSmA00S00 // D Difference 
gen DayDeaMeRaA03S02U`l'T = DayDeaMeRaA03S02U`l' / DayDeaMeSmA00S00 // T Times (more or less)
gen DayDeaMeRaA03S02U`l'P = 100 * (DayDeaMeRaA03S02U`l' - DayDeaMeSmA00S00) / DayDeaMeSmA00S00 // P Percent

gen DayINFMeRaA03S02U`l'D = DayINFMeRaA03S02U`l' - DayCasMeSmA00S00 // D Difference 
gen DayINFMeRaA03S02U`l'T = DayINFMeRaA03S02U`l' / DayCasMeSmA00S00 // T Times (more or less)
gen DayINFMeRaA03S02U`l'P = 100 * (DayINFMeRaA03S02U`l' - DayCasMeSmA00S00) / DayCasMeSmA00S00 // P Percent

gen TotDeaMeRaA03S02U`l'D = TotDeaMeRaA03S02U`l' - TotDeaMeRaA00S00 // D Difference 
gen TotDeaMeRaA03S02U`l'T = TotDeaMeRaA03S02U`l' / TotDeaMeRaA00S00 // T Times (more or less)
gen TotDeaMeRaA03S02U`l'P = 100 * (TotDeaMeRaA03S02U`l' - TotDeaMeRaA00S00) / TotDeaMeRaA00S00 // P Percent

gen TotINFMeRaA03S02U`l'D = TotINFMeRaA03S02U`l' - TotCasMeRaA00S00 // D Difference 
gen TotINFMeRaA03S02U`l'T = TotINFMeRaA03S02U`l' / TotCasMeRaA00S00 // T Times (more or less)
gen TotINFMeRaA03S02U`l'P = 100 * (TotINFMeRaA03S02U`l' - TotCasMeRaA00S00) / TotCasMeRaA00S00 // P Percent 

}
}
*




sort date loc_grand_name

qui compress 

save "country IMPE.dta", replace







**********************************************************

* graphs


grstyle init

grstyle color background white



* daily deaths

**************************************

* daily deaths, Absolute value, individual updates

foreach l of global IMPEupdatelist {

twoway  /// 
(line DayDeaMeSmA00S00 date, lcolor(cyan*1.2)) /// 
(line DayDeaMeRaA03S02U`l' date, sort lcolor(black)) /// 
, xtitle(Date) xlabel(#21, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, IMPE, update `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(2 "IMPE `l'" 1 "JOHN smooth") size(small) rows(1)) yscale(titlegap(2))

qui graph save "graph 11i COVID-19 daily deaths, $country, IMPE update `l'.gph", replace
qui graph export "graph 11i COVID-19 daily deaths, $country, IMPE update `l'.pdf", replace

}
*




* daily deaths, Absolute value, together

twoway  ///
(line DayDeaMeRaA03S02U20200619 date, sort lcolor(gray)) /// 1 v4
(line DayDeaMeRaA03S02U20200623 date, sort lcolor(gray)) /// 2
(line DayDeaMeRaA03S02U20200702 date, sort lcolor(gray)) /// 3
(line DayDeaMeRaA03S02U20200703 date, sort lcolor(gray)) /// 4
(line DayDeaMeRaA03S02U20200704 date, sort lcolor(gray)) /// 5
(line DayDeaMeRaA03S02U20200707 date, sort lcolor(gray)) /// 6
(line DayDeaMeRaA03S02U20200711 date, sort lcolor(gray)) /// 7
(line DayDeaMeRaA03S02U20200714 date, sort lcolor(gray)) /// 8
(line DayDeaMeRaA03S02U20200715 date, sort lcolor(gray)) /// 9
(line DayDeaMeRaA03S02U20200718 date, sort lcolor(gray)) /// 10
(line DayDeaMeRaA03S02U20200720 date, sort lcolor(gray)) /// 11
(line DayDeaMeRaA03S02U20200722 date, sort lcolor(gray)) /// 12
(line DayDeaMeRaA03S02U20200725 date, sort lcolor(gray)) /// 13
(line DayDeaMeRaA03S02U20200727 date, sort lcolor(gray)) /// 14
(line DayDeaMeRaA03S02U20200731 date, sort lcolor(gray)) /// 15 
(line DayDeaMeRaA03S02U20200808 date, sort lcolor(gold)) /// 16 v5
(line DayDeaMeRaA03S02U20200810 date, sort lcolor(gold)) /// 17
(line DayDeaMeRaA03S02U20200811 date, sort lcolor(gold)) /// 18
(line DayDeaMeRaA03S02U20200813 date, sort lcolor(gold)) /// 19
(line DayDeaMeRaA03S02U20200814 date, sort lcolor(gold)) /// 20
(line DayDeaMeRaA03S02U20200817 date, sort lcolor(gold)) /// 21
(line DayDeaMeRaA03S02U20200823 date, sort lcolor(gold)) /// 22
(line DayDeaMeRaA03S02U20200825 date, sort lcolor(gold)) /// 23
(line DayDeaMeRaA03S02U20200827 date, sort lcolor(gold)) /// 24
(line DayDeaMeRaA03S02U20200831 date, sort lcolor(gold)) /// 25
(line DayDeaMeRaA03S02U20200902 date, sort lcolor(gold)) /// 26
(line DayDeaMeRaA03S02U20200906 date, sort lcolor(gold)) /// 27
(line DayDeaMeRaA03S02U20200908 date, sort lcolor(gold)) /// 28
(line DayDeaMeRaA03S02U20200912 date, sort lcolor(gold)) /// 29
(line DayDeaMeRaA03S02U20200915 date, sort lcolor(gold)) /// 30
(line DayDeaMeRaA03S02U20200919 date, sort lcolor(gold)) /// 31
(line DayDeaMeRaA03S02U20200923 date, sort lcolor(gold)) /// 32
(line DayDeaMeRaA03S02U20200925 date, sort lcolor(gold)) /// 33
(line DayDeaMeRaA03S02U20201003 date, sort lcolor(gold)) /// 34
(line DayDeaMeRaA03S02U20201006 date, sort lcolor(gold)) /// 35
(line DayDeaMeRaA03S02U20201012 date, sort lcolor(gold)) /// 36
(line DayDeaMeRaA03S02U20201019 date, sort lcolor(gold)) /// 37
(line DayDeaMeRaA03S02U20201025 date, sort lcolor(gold)) /// 38
(line DayDeaMeRaA03S02U20201028 date, sort lcolor(gold)) /// 39
(line DayDeaMeRaA03S02U20201101 date, sort lcolor(gold)) /// 40 
(line DayDeaMeRaA03S02U20201110 date, sort lcolor(blue)) /// 41 v6
(line DayDeaMeRaA03S02U20201114 date, sort lcolor(blue)) /// 42
(line DayDeaMeRaA03S02U20201118 date, sort lcolor(blue)) /// 43
(line DayDeaMeRaA03S02U20201123 date, sort lcolor(blue)) /// 44
(line DayDeaMeRaA03S02U20201129 date, sort lcolor(blue)) /// 45
(line DayDeaMeRaA03S02U20201204 date, sort lcolor(blue)) /// 46
(line DayDeaMeRaA03S02U20201212 date, sort lcolor(blue)) /// 47
(line DayDeaMeRaA03S02U20201220 date, sort lcolor(blue)) /// 48
(line DayDeaMeRaA03S02U20201226 date, sort lcolor(blue)) /// 49
(line DayDeaMeRaA03S02U20210104 date, sort lcolor(blue)) /// 50
(line DayDeaMeRaA03S02U20210110 date, sort lcolor(blue)) /// 51
(line DayDeaMeRaA03S02U20210112 date, sort lcolor(blue)) /// 52 
(line DayDeaMeRaA03S02U20210118 date, sort lcolor(green)) /// 53 v7
(line DayDeaMeRaA03S02U20210124 date, sort lcolor(green)) /// 54
(line DayDeaMeRaA03S02U20210130 date, sort lcolor(green)) /// 55
(line DayDeaMeRaA03S02U20210203 date, sort lcolor(green)) /// 56
(line DayDeaMeRaA03S02U20210210 date, sort lcolor(green)) /// 57
(line DayDeaMeRaA03S02U20210217 date, sort lcolor(green)) /// 58
(line DayDeaMeRaA03S02U20210226 date, sort lcolor(green)) /// 59
(line DayDeaMeRaA03S02U20210305 date, sort lcolor(green)) /// 60
(line DayDeaMeRaA03S02U20210312 date, sort lcolor(green)) /// 61
(line DayDeaMeRaA03S02U20210319 date, sort lcolor(green)) /// 62
(line DayDeaMeRaA03S02U20210329 date, sort lcolor(green)) /// 63
(line DayDeaMeRaA03S02U20210406 date, sort lcolor(green)) /// 64
(line DayDeaMeRaA03S02U20210417 date, sort lcolor(green)) /// 65
(line DayDeaMeRaA03S02U20210424 date, sort lcolor(green)) /// 66 
(line DayDeaMeRaA03S02U20210510 date, sort lcolor(red)) /// 67 v8
(line DayDeaMeRaA03S02U20210516 date, sort lcolor(red)) /// 68
(line DayDeaMeRaA03S02U20210522 date, sort lcolor(red)) /// 69
(line DayDeaMeRaA03S02U20210527 date, sort lcolor(red)) /// 70
(line DayDeaMeRaA03S02U20210604 date, sort lcolor(red)) /// 71
(line DayDeaMeRaA03S02U20210611 date, sort lcolor(red)) /// 72
(line DayDeaMeRaA03S02U20210618 date, sort lcolor(red)) /// 73
(line DayDeaMeRaA03S02U20210626 date, sort lcolor(red)) /// 74
(line DayDeaMeRaA03S02U20210702 date, sort lcolor(red)) /// 75
(line DayDeaMeRaA03S02U20210709 date, sort lcolor(red)) /// 76 
(line DayDeaMeSmA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 77
, xtitle(Date) xlabel(#21, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small)) ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, $country, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200619 to 20210709; reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "v4" 16 "v5" 41 "v6" 53 "v7" 67 "v8" 77 "JOHN") size(small) rows(1)) yscale(titlegap(2))
	   	   
qui graph save "graph 11a COVID-19 daily deaths, $country, IMPE.gph", replace
qui graph export "graph 11a COVID-19 daily deaths, $country, IMPE.pdf", replace




*********

* daily deaths, Difference, together

twoway  ///
(line DayDeaMeRaA03S02U20200619D date, sort lcolor(gray)) /// 1 v4
(line DayDeaMeRaA03S02U20200623D date, sort lcolor(gray)) /// 2
(line DayDeaMeRaA03S02U20200702D date, sort lcolor(gray)) /// 3
(line DayDeaMeRaA03S02U20200703D date, sort lcolor(gray)) /// 4
(line DayDeaMeRaA03S02U20200704D date, sort lcolor(gray)) /// 5
(line DayDeaMeRaA03S02U20200707D date, sort lcolor(gray)) /// 6
(line DayDeaMeRaA03S02U20200711D date, sort lcolor(gray)) /// 7
(line DayDeaMeRaA03S02U20200714D date, sort lcolor(gray)) /// 8
(line DayDeaMeRaA03S02U20200715D date, sort lcolor(gray)) /// 9
(line DayDeaMeRaA03S02U20200718D date, sort lcolor(gray)) /// 10
(line DayDeaMeRaA03S02U20200720D date, sort lcolor(gray)) /// 11
(line DayDeaMeRaA03S02U20200722D date, sort lcolor(gray)) /// 12
(line DayDeaMeRaA03S02U20200725D date, sort lcolor(gray)) /// 13
(line DayDeaMeRaA03S02U20200727D date, sort lcolor(gray)) /// 14
(line DayDeaMeRaA03S02U20200731D date, sort lcolor(gray)) /// 15 
(line DayDeaMeRaA03S02U20200808D date, sort lcolor(gold)) /// 16 v5
(line DayDeaMeRaA03S02U20200810D date, sort lcolor(gold)) /// 17
(line DayDeaMeRaA03S02U20200811D date, sort lcolor(gold)) /// 18
(line DayDeaMeRaA03S02U20200813D date, sort lcolor(gold)) /// 19
(line DayDeaMeRaA03S02U20200814D date, sort lcolor(gold)) /// 20
(line DayDeaMeRaA03S02U20200817D date, sort lcolor(gold)) /// 21
(line DayDeaMeRaA03S02U20200823D date, sort lcolor(gold)) /// 22
(line DayDeaMeRaA03S02U20200825D date, sort lcolor(gold)) /// 23
(line DayDeaMeRaA03S02U20200827D date, sort lcolor(gold)) /// 24
(line DayDeaMeRaA03S02U20200831D date, sort lcolor(gold)) /// 25
(line DayDeaMeRaA03S02U20200902D date, sort lcolor(gold)) /// 26
(line DayDeaMeRaA03S02U20200906D date, sort lcolor(gold)) /// 27
(line DayDeaMeRaA03S02U20200908D date, sort lcolor(gold)) /// 28
(line DayDeaMeRaA03S02U20200912D date, sort lcolor(gold)) /// 29
(line DayDeaMeRaA03S02U20200915D date, sort lcolor(gold)) /// 30
(line DayDeaMeRaA03S02U20200919D date, sort lcolor(gold)) /// 31
(line DayDeaMeRaA03S02U20200923D date, sort lcolor(gold)) /// 32
(line DayDeaMeRaA03S02U20200925D date, sort lcolor(gold)) /// 33
(line DayDeaMeRaA03S02U20201003D date, sort lcolor(gold)) /// 34
(line DayDeaMeRaA03S02U20201006D date, sort lcolor(gold)) /// 35
(line DayDeaMeRaA03S02U20201012D date, sort lcolor(gold)) /// 36
(line DayDeaMeRaA03S02U20201019D date, sort lcolor(gold)) /// 37
(line DayDeaMeRaA03S02U20201025D date, sort lcolor(gold)) /// 38
(line DayDeaMeRaA03S02U20201028D date, sort lcolor(gold)) /// 39
(line DayDeaMeRaA03S02U20201101D date, sort lcolor(gold)) /// 40 
(line DayDeaMeRaA03S02U20201110D date, sort lcolor(blue)) /// 41 v6
(line DayDeaMeRaA03S02U20201114D date, sort lcolor(blue)) /// 42
(line DayDeaMeRaA03S02U20201118D date, sort lcolor(blue)) /// 43
(line DayDeaMeRaA03S02U20201123D date, sort lcolor(blue)) /// 44
(line DayDeaMeRaA03S02U20201129D date, sort lcolor(blue)) /// 45
(line DayDeaMeRaA03S02U20201204D date, sort lcolor(blue)) /// 46
(line DayDeaMeRaA03S02U20201212D date, sort lcolor(blue)) /// 47
(line DayDeaMeRaA03S02U20201220D date, sort lcolor(blue)) /// 48
(line DayDeaMeRaA03S02U20201226D date, sort lcolor(blue)) /// 49
(line DayDeaMeRaA03S02U20210104D date, sort lcolor(blue)) /// 50
(line DayDeaMeRaA03S02U20210110D date, sort lcolor(blue)) /// 51
(line DayDeaMeRaA03S02U20210112D date, sort lcolor(blue)) /// 52 
(line DayDeaMeRaA03S02U20210118D date, sort lcolor(green)) /// 53 v7
(line DayDeaMeRaA03S02U20210124D date, sort lcolor(green)) /// 54
(line DayDeaMeRaA03S02U20210130D date, sort lcolor(green)) /// 55
(line DayDeaMeRaA03S02U20210203D date, sort lcolor(green)) /// 56
(line DayDeaMeRaA03S02U20210210D date, sort lcolor(green)) /// 57
(line DayDeaMeRaA03S02U20210217D date, sort lcolor(green)) /// 58
(line DayDeaMeRaA03S02U20210226D date, sort lcolor(green)) /// 59
(line DayDeaMeRaA03S02U20210305D date, sort lcolor(green)) /// 60
(line DayDeaMeRaA03S02U20210312D date, sort lcolor(green)) /// 61
(line DayDeaMeRaA03S02U20210319D date, sort lcolor(green)) /// 62
(line DayDeaMeRaA03S02U20210329D date, sort lcolor(green)) /// 63
(line DayDeaMeRaA03S02U20210406D date, sort lcolor(green)) /// 64
(line DayDeaMeRaA03S02U20210417D date, sort lcolor(green)) /// 65
(line DayDeaMeRaA03S02U20210424D date, sort lcolor(green)) /// 66 
(line DayDeaMeRaA03S02U20210510D date, sort lcolor(red)) /// 67 v8
(line DayDeaMeRaA03S02U20210516D date, sort lcolor(red)) /// 68
(line DayDeaMeRaA03S02U20210522D date, sort lcolor(red)) /// 69
(line DayDeaMeRaA03S02U20210527D date, sort lcolor(red)) /// 70
(line DayDeaMeRaA03S02U20210604D date, sort lcolor(red)) /// 71
(line DayDeaMeRaA03S02U20210611D date, sort lcolor(red)) /// 72
(line DayDeaMeRaA03S02U20210618D date, sort lcolor(red)) /// 73
(line DayDeaMeRaA03S02U20210626D date, sort lcolor(red)) /// 74
(line DayDeaMeRaA03S02U20210702D date, sort lcolor(red)) /// 75
(line DayDeaMeRaA03S02U20210709D date, sort lcolor(red)) /// 76 
, xtitle(Date) xlabel(#21, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths IMPE minus JOHN smooth) title("COVID-19 daily deaths, $country, IMPE minus JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
subtitle("all updates 20200619 to 20210709; reference scenario", size(small)) ///
legend(order(1 "v4" 16 "v5" 41 "v6" 53 "v7" 67 "v8") size(small) rows(1)) yscale(titlegap(2))
  	   
qui graph save "graph 12a COVID-19 daily deaths, $country, IMPE, Difference.gph", replace
qui graph export "graph 12a COVID-19 daily deaths, $country, IMPE, Difference.pdf", replace



*********

* daily deaths, Times, together 

twoway  ///
(line DayDeaMeRaA03S02U20200619T date, sort lcolor(gray)) /// 1 v4
(line DayDeaMeRaA03S02U20200623T date, sort lcolor(gray)) /// 2
(line DayDeaMeRaA03S02U20200702T date, sort lcolor(gray)) /// 3
(line DayDeaMeRaA03S02U20200703T date, sort lcolor(gray)) /// 4
(line DayDeaMeRaA03S02U20200704T date, sort lcolor(gray)) /// 5
(line DayDeaMeRaA03S02U20200707T date, sort lcolor(gray)) /// 6
(line DayDeaMeRaA03S02U20200711T date, sort lcolor(gray)) /// 7
(line DayDeaMeRaA03S02U20200714T date, sort lcolor(gray)) /// 8
(line DayDeaMeRaA03S02U20200715T date, sort lcolor(gray)) /// 9
(line DayDeaMeRaA03S02U20200718T date, sort lcolor(gray)) /// 10
(line DayDeaMeRaA03S02U20200720T date, sort lcolor(gray)) /// 11
(line DayDeaMeRaA03S02U20200722T date, sort lcolor(gray)) /// 12
(line DayDeaMeRaA03S02U20200725T date, sort lcolor(gray)) /// 13
(line DayDeaMeRaA03S02U20200727T date, sort lcolor(gray)) /// 14
(line DayDeaMeRaA03S02U20200731T date, sort lcolor(gray)) /// 15 
(line DayDeaMeRaA03S02U20200808T date, sort lcolor(gold)) /// 16 v5
(line DayDeaMeRaA03S02U20200810T date, sort lcolor(gold)) /// 17
(line DayDeaMeRaA03S02U20200811T date, sort lcolor(gold)) /// 18
(line DayDeaMeRaA03S02U20200813T date, sort lcolor(gold)) /// 19
(line DayDeaMeRaA03S02U20200814T date, sort lcolor(gold)) /// 20
(line DayDeaMeRaA03S02U20200817T date, sort lcolor(gold)) /// 21
(line DayDeaMeRaA03S02U20200823T date, sort lcolor(gold)) /// 22
(line DayDeaMeRaA03S02U20200825T date, sort lcolor(gold)) /// 23
(line DayDeaMeRaA03S02U20200827T date, sort lcolor(gold)) /// 24
(line DayDeaMeRaA03S02U20200831T date, sort lcolor(gold)) /// 25
(line DayDeaMeRaA03S02U20200902T date, sort lcolor(gold)) /// 26
(line DayDeaMeRaA03S02U20200906T date, sort lcolor(gold)) /// 27
(line DayDeaMeRaA03S02U20200908T date, sort lcolor(gold)) /// 28
(line DayDeaMeRaA03S02U20200912T date, sort lcolor(gold)) /// 29
(line DayDeaMeRaA03S02U20200915T date, sort lcolor(gold)) /// 30
(line DayDeaMeRaA03S02U20200919T date, sort lcolor(gold)) /// 31
(line DayDeaMeRaA03S02U20200923T date, sort lcolor(gold)) /// 32
(line DayDeaMeRaA03S02U20200925T date, sort lcolor(gold)) /// 33
(line DayDeaMeRaA03S02U20201003T date, sort lcolor(gold)) /// 34
(line DayDeaMeRaA03S02U20201006T date, sort lcolor(gold)) /// 35
(line DayDeaMeRaA03S02U20201012T date, sort lcolor(gold)) /// 36
(line DayDeaMeRaA03S02U20201019T date, sort lcolor(gold)) /// 37
(line DayDeaMeRaA03S02U20201025T date, sort lcolor(gold)) /// 38
(line DayDeaMeRaA03S02U20201028T date, sort lcolor(gold)) /// 39
(line DayDeaMeRaA03S02U20201101T date, sort lcolor(gold)) /// 40 
(line DayDeaMeRaA03S02U20201110T date, sort lcolor(blue)) /// 41 v6
(line DayDeaMeRaA03S02U20201114T date, sort lcolor(blue)) /// 42
(line DayDeaMeRaA03S02U20201118T date, sort lcolor(blue)) /// 43
(line DayDeaMeRaA03S02U20201123T date, sort lcolor(blue)) /// 44
(line DayDeaMeRaA03S02U20201129T date, sort lcolor(blue)) /// 45
(line DayDeaMeRaA03S02U20201204T date, sort lcolor(blue)) /// 46
(line DayDeaMeRaA03S02U20201212T date, sort lcolor(blue)) /// 47
(line DayDeaMeRaA03S02U20201220T date, sort lcolor(blue)) /// 48
(line DayDeaMeRaA03S02U20201226T date, sort lcolor(blue)) /// 49
(line DayDeaMeRaA03S02U20210104T date, sort lcolor(blue)) /// 50
(line DayDeaMeRaA03S02U20210110T date, sort lcolor(blue)) /// 51
(line DayDeaMeRaA03S02U20210112T date, sort lcolor(blue)) /// 52 
(line DayDeaMeRaA03S02U20210118T date, sort lcolor(green)) /// 53 v7
(line DayDeaMeRaA03S02U20210124T date, sort lcolor(green)) /// 54
(line DayDeaMeRaA03S02U20210130T date, sort lcolor(green)) /// 55
(line DayDeaMeRaA03S02U20210203T date, sort lcolor(green)) /// 56
(line DayDeaMeRaA03S02U20210210T date, sort lcolor(green)) /// 57
(line DayDeaMeRaA03S02U20210217T date, sort lcolor(green)) /// 58
(line DayDeaMeRaA03S02U20210226T date, sort lcolor(green)) /// 59
(line DayDeaMeRaA03S02U20210305T date, sort lcolor(green)) /// 60
(line DayDeaMeRaA03S02U20210312T date, sort lcolor(green)) /// 61
(line DayDeaMeRaA03S02U20210319T date, sort lcolor(green)) /// 62
(line DayDeaMeRaA03S02U20210329T date, sort lcolor(green)) /// 63
(line DayDeaMeRaA03S02U20210406T date, sort lcolor(green)) /// 64
(line DayDeaMeRaA03S02U20210417T date, sort lcolor(green)) /// 65
(line DayDeaMeRaA03S02U20210424T date, sort lcolor(green)) /// 66 
(line DayDeaMeRaA03S02U20210510T date, sort lcolor(red)) /// 67 v8
(line DayDeaMeRaA03S02U20210516T date, sort lcolor(red)) /// 68
(line DayDeaMeRaA03S02U20210522T date, sort lcolor(red)) /// 69
(line DayDeaMeRaA03S02U20210527T date, sort lcolor(red)) /// 70
(line DayDeaMeRaA03S02U20210604T date, sort lcolor(red)) /// 71
(line DayDeaMeRaA03S02U20210611T date, sort lcolor(red)) /// 72
(line DayDeaMeRaA03S02U20210618T date, sort lcolor(red)) /// 73
(line DayDeaMeRaA03S02U20210626T date, sort lcolor(red)) /// 74
(line DayDeaMeRaA03S02U20210702T date, sort lcolor(red)) /// 75
(line DayDeaMeRaA03S02U20210709T date, sort lcolor(red)) /// 76 
, xtitle(Date) xlabel(#21, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths IMPE divided by JOHN smooth) title("COVID-19 daily deaths, $country, IMPE divided by JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2))  legend(region(lcolor(none))) legend(bexpand) ///
subtitle("all updates 20200619 to 20210709; reference scenario", size(small)) ///
legend(order(1 "v4" 16 "v5" 41 "v6" 53 "v7" 67 "v8") size(small) rows(1)) yscale(titlegap(2))
  	   
qui graph save "graph 13a COVID-19 daily deaths, $country, IMPE, Times.gph", replace
qui graph export "graph 13a COVID-19 daily deaths, $country, IMPE, Times.pdf", replace




*********

* daily deaths, Percent, together

twoway  ///
(line DayDeaMeRaA03S02U20200619P date, sort lcolor(gray)) /// 1 v4
(line DayDeaMeRaA03S02U20200623P date, sort lcolor(gray)) /// 2
(line DayDeaMeRaA03S02U20200702P date, sort lcolor(gray)) /// 3
(line DayDeaMeRaA03S02U20200703P date, sort lcolor(gray)) /// 4
(line DayDeaMeRaA03S02U20200704P date, sort lcolor(gray)) /// 5
(line DayDeaMeRaA03S02U20200707P date, sort lcolor(gray)) /// 6
(line DayDeaMeRaA03S02U20200711P date, sort lcolor(gray)) /// 7
(line DayDeaMeRaA03S02U20200714P date, sort lcolor(gray)) /// 8
(line DayDeaMeRaA03S02U20200715P date, sort lcolor(gray)) /// 9
(line DayDeaMeRaA03S02U20200718P date, sort lcolor(gray)) /// 10
(line DayDeaMeRaA03S02U20200720P date, sort lcolor(gray)) /// 11
(line DayDeaMeRaA03S02U20200722P date, sort lcolor(gray)) /// 12
(line DayDeaMeRaA03S02U20200725P date, sort lcolor(gray)) /// 13
(line DayDeaMeRaA03S02U20200727P date, sort lcolor(gray)) /// 14
(line DayDeaMeRaA03S02U20200731P date, sort lcolor(gray)) /// 15 
(line DayDeaMeRaA03S02U20200808P date, sort lcolor(gold)) /// 16 v5
(line DayDeaMeRaA03S02U20200810P date, sort lcolor(gold)) /// 17
(line DayDeaMeRaA03S02U20200811P date, sort lcolor(gold)) /// 18
(line DayDeaMeRaA03S02U20200813P date, sort lcolor(gold)) /// 19
(line DayDeaMeRaA03S02U20200814P date, sort lcolor(gold)) /// 20
(line DayDeaMeRaA03S02U20200817P date, sort lcolor(gold)) /// 21
(line DayDeaMeRaA03S02U20200823P date, sort lcolor(gold)) /// 22
(line DayDeaMeRaA03S02U20200825P date, sort lcolor(gold)) /// 23
(line DayDeaMeRaA03S02U20200827P date, sort lcolor(gold)) /// 24
(line DayDeaMeRaA03S02U20200831P date, sort lcolor(gold)) /// 25
(line DayDeaMeRaA03S02U20200902P date, sort lcolor(gold)) /// 26
(line DayDeaMeRaA03S02U20200906P date, sort lcolor(gold)) /// 27
(line DayDeaMeRaA03S02U20200908P date, sort lcolor(gold)) /// 28
(line DayDeaMeRaA03S02U20200912P date, sort lcolor(gold)) /// 29
(line DayDeaMeRaA03S02U20200915P date, sort lcolor(gold)) /// 30
(line DayDeaMeRaA03S02U20200919P date, sort lcolor(gold)) /// 31
(line DayDeaMeRaA03S02U20200923P date, sort lcolor(gold)) /// 32
(line DayDeaMeRaA03S02U20200925P date, sort lcolor(gold)) /// 33
(line DayDeaMeRaA03S02U20201003P date, sort lcolor(gold)) /// 34
(line DayDeaMeRaA03S02U20201006P date, sort lcolor(gold)) /// 35
(line DayDeaMeRaA03S02U20201012P date, sort lcolor(gold)) /// 36
(line DayDeaMeRaA03S02U20201019P date, sort lcolor(gold)) /// 37
(line DayDeaMeRaA03S02U20201025P date, sort lcolor(gold)) /// 38
(line DayDeaMeRaA03S02U20201028P date, sort lcolor(gold)) /// 39
(line DayDeaMeRaA03S02U20201101P date, sort lcolor(gold)) /// 40 
(line DayDeaMeRaA03S02U20201110P date, sort lcolor(blue)) /// 41 v6
(line DayDeaMeRaA03S02U20201114P date, sort lcolor(blue)) /// 42
(line DayDeaMeRaA03S02U20201118P date, sort lcolor(blue)) /// 43
(line DayDeaMeRaA03S02U20201123P date, sort lcolor(blue)) /// 44
(line DayDeaMeRaA03S02U20201129P date, sort lcolor(blue)) /// 45
(line DayDeaMeRaA03S02U20201204P date, sort lcolor(blue)) /// 46
(line DayDeaMeRaA03S02U20201212P date, sort lcolor(blue)) /// 47
(line DayDeaMeRaA03S02U20201220P date, sort lcolor(blue)) /// 48
(line DayDeaMeRaA03S02U20201226P date, sort lcolor(blue)) /// 49
(line DayDeaMeRaA03S02U20210104P date, sort lcolor(blue)) /// 50
(line DayDeaMeRaA03S02U20210110P date, sort lcolor(blue)) /// 51
(line DayDeaMeRaA03S02U20210112P date, sort lcolor(blue)) /// 52 
(line DayDeaMeRaA03S02U20210118P date, sort lcolor(green)) /// 53 v7
(line DayDeaMeRaA03S02U20210124P date, sort lcolor(green)) /// 54
(line DayDeaMeRaA03S02U20210130P date, sort lcolor(green)) /// 55
(line DayDeaMeRaA03S02U20210203P date, sort lcolor(green)) /// 56
(line DayDeaMeRaA03S02U20210210P date, sort lcolor(green)) /// 57
(line DayDeaMeRaA03S02U20210217P date, sort lcolor(green)) /// 58
(line DayDeaMeRaA03S02U20210226P date, sort lcolor(green)) /// 59
(line DayDeaMeRaA03S02U20210305P date, sort lcolor(green)) /// 60
(line DayDeaMeRaA03S02U20210312P date, sort lcolor(green)) /// 61
(line DayDeaMeRaA03S02U20210319P date, sort lcolor(green)) /// 62
(line DayDeaMeRaA03S02U20210329P date, sort lcolor(green)) /// 63
(line DayDeaMeRaA03S02U20210406P date, sort lcolor(green)) /// 64
(line DayDeaMeRaA03S02U20210417P date, sort lcolor(green)) /// 65
(line DayDeaMeRaA03S02U20210424P date, sort lcolor(green)) /// 66 
(line DayDeaMeRaA03S02U20210510P date, sort lcolor(red)) /// 67 v8
(line DayDeaMeRaA03S02U20210516P date, sort lcolor(red)) /// 68
(line DayDeaMeRaA03S02U20210522P date, sort lcolor(red)) /// 69
(line DayDeaMeRaA03S02U20210527P date, sort lcolor(red)) /// 70
(line DayDeaMeRaA03S02U20210604P date, sort lcolor(red)) /// 71
(line DayDeaMeRaA03S02U20210611P date, sort lcolor(red)) /// 72
(line DayDeaMeRaA03S02U20210618P date, sort lcolor(red)) /// 73
(line DayDeaMeRaA03S02U20210626P date, sort lcolor(red)) /// 74
(line DayDeaMeRaA03S02U20210702P date, sort lcolor(red)) /// 75
(line DayDeaMeRaA03S02U20210709P date, sort lcolor(red)) /// 76 
, xtitle(Date) xlabel(#21, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths IMPE percent JOHN smooth) title("COVID-19 daily deaths, $country, % (IMPE minus JOHN smooth) / JOHN smooth", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2)) ///
subtitle("all updates 20200619 to 20210709; reference scenario", size(small)) ///
legend(order(1 "v4" 16 "v5" 41 "v6" 53 "v7" 67 "v8") size(small) rows(1)) yscale(titlegap(2))
  	   
qui graph save "graph 14a COVID-19 daily deaths, $country, IMPE, Percent.gph", replace
qui graph export "graph 14a COVID-19 daily deaths, $country, IMPE, Percent.pdf", replace









* daily infections

**************************************



* daily infections, Absolute value, individual updates


foreach l of global IMPEupdatelist {

twoway  /// 
(line DayCasMeRaA00S00 date, lcolor(cyan*1.2)) ///  
(line DayINFMeRaA03S02U`l' date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#21, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(daily infections) title("COVID-19 daily infections, $country, IMPE, update `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases smooth" 2 "IMPE infections `l'") size(small) rows(1))	

qui graph save "graph 21i COVID-19 daily infections, $country, IMPE update `l'.gph", replace
qui graph export "graph 21i COVID-19 daily infections, $country, IMPE update `l'.pdf", replace

}
*



* daily infections, Absolute value, together
       
twoway  ///
(line DayINFMeRaA03S02U20200619 date, sort lcolor(gray)) /// 1 v4
(line DayINFMeRaA03S02U20200623 date, sort lcolor(gray)) /// 2
(line DayINFMeRaA03S02U20200702 date, sort lcolor(gray)) /// 3
(line DayINFMeRaA03S02U20200703 date, sort lcolor(gray)) /// 4
(line DayINFMeRaA03S02U20200704 date, sort lcolor(gray)) /// 5
(line DayINFMeRaA03S02U20200707 date, sort lcolor(gray)) /// 6
(line DayINFMeRaA03S02U20200711 date, sort lcolor(gray)) /// 7
(line DayINFMeRaA03S02U20200714 date, sort lcolor(gray)) /// 8
(line DayINFMeRaA03S02U20200715 date, sort lcolor(gray)) /// 9
(line DayINFMeRaA03S02U20200718 date, sort lcolor(gray)) /// 10
(line DayINFMeRaA03S02U20200720 date, sort lcolor(gray)) /// 11
(line DayINFMeRaA03S02U20200722 date, sort lcolor(gray)) /// 12
(line DayINFMeRaA03S02U20200725 date, sort lcolor(gray)) /// 13
(line DayINFMeRaA03S02U20200727 date, sort lcolor(gray)) /// 14
(line DayINFMeRaA03S02U20200731 date, sort lcolor(gray)) /// 15 
(line DayINFMeRaA03S02U20200808 date, sort lcolor(gold)) /// 16 v5
(line DayINFMeRaA03S02U20200810 date, sort lcolor(gold)) /// 17
(line DayINFMeRaA03S02U20200811 date, sort lcolor(gold)) /// 18
(line DayINFMeRaA03S02U20200813 date, sort lcolor(gold)) /// 19
(line DayINFMeRaA03S02U20200814 date, sort lcolor(gold)) /// 20
(line DayINFMeRaA03S02U20200817 date, sort lcolor(gold)) /// 21
(line DayINFMeRaA03S02U20200823 date, sort lcolor(gold)) /// 22
(line DayINFMeRaA03S02U20200825 date, sort lcolor(gold)) /// 23
(line DayINFMeRaA03S02U20200827 date, sort lcolor(gold)) /// 24
(line DayINFMeRaA03S02U20200831 date, sort lcolor(gold)) /// 25
(line DayINFMeRaA03S02U20200902 date, sort lcolor(gold)) /// 26
(line DayINFMeRaA03S02U20200906 date, sort lcolor(gold)) /// 27
(line DayINFMeRaA03S02U20200908 date, sort lcolor(gold)) /// 28
(line DayINFMeRaA03S02U20200912 date, sort lcolor(gold)) /// 29
(line DayINFMeRaA03S02U20200915 date, sort lcolor(gold)) /// 30
(line DayINFMeRaA03S02U20200919 date, sort lcolor(gold)) /// 31
(line DayINFMeRaA03S02U20200923 date, sort lcolor(gold)) /// 32
(line DayINFMeRaA03S02U20200925 date, sort lcolor(gold)) /// 33
(line DayINFMeRaA03S02U20201003 date, sort lcolor(gold)) /// 34
(line DayINFMeRaA03S02U20201006 date, sort lcolor(gold)) /// 35
(line DayINFMeRaA03S02U20201012 date, sort lcolor(gold)) /// 36
(line DayINFMeRaA03S02U20201019 date, sort lcolor(gold)) /// 37
(line DayINFMeRaA03S02U20201025 date, sort lcolor(gold)) /// 38
(line DayINFMeRaA03S02U20201028 date, sort lcolor(gold)) /// 39
(line DayINFMeRaA03S02U20201101 date, sort lcolor(gold)) /// 40 
(line DayINFMeRaA03S02U20201110 date, sort lcolor(blue)) /// 41 v6
(line DayINFMeRaA03S02U20201114 date, sort lcolor(blue)) /// 42
(line DayINFMeRaA03S02U20201118 date, sort lcolor(blue)) /// 43
(line DayINFMeRaA03S02U20201123 date, sort lcolor(blue)) /// 44
(line DayINFMeRaA03S02U20201129 date, sort lcolor(blue)) /// 45
(line DayINFMeRaA03S02U20201204 date, sort lcolor(blue)) /// 46
(line DayINFMeRaA03S02U20201212 date, sort lcolor(blue)) /// 47
(line DayINFMeRaA03S02U20201220 date, sort lcolor(blue)) /// 48
(line DayINFMeRaA03S02U20201226 date, sort lcolor(blue)) /// 49
(line DayINFMeRaA03S02U20210104 date, sort lcolor(blue)) /// 50
(line DayINFMeRaA03S02U20210110 date, sort lcolor(blue)) /// 51
(line DayINFMeRaA03S02U20210112 date, sort lcolor(blue)) /// 52 
(line DayINFMeRaA03S02U20210118 date, sort lcolor(green)) /// 53 v7
(line DayINFMeRaA03S02U20210124 date, sort lcolor(green)) /// 54
(line DayINFMeRaA03S02U20210130 date, sort lcolor(green)) /// 55
(line DayINFMeRaA03S02U20210203 date, sort lcolor(green)) /// 56
(line DayINFMeRaA03S02U20210210 date, sort lcolor(green)) /// 57
(line DayINFMeRaA03S02U20210217 date, sort lcolor(green)) /// 58
(line DayINFMeRaA03S02U20210226 date, sort lcolor(green)) /// 59
(line DayINFMeRaA03S02U20210305 date, sort lcolor(green)) /// 60
(line DayINFMeRaA03S02U20210312 date, sort lcolor(green)) /// 61
(line DayINFMeRaA03S02U20210319 date, sort lcolor(green)) /// 62
(line DayINFMeRaA03S02U20210329 date, sort lcolor(green)) /// 63
(line DayINFMeRaA03S02U20210406 date, sort lcolor(green)) /// 64
(line DayINFMeRaA03S02U20210417 date, sort lcolor(green)) /// 65
(line DayINFMeRaA03S02U20210424 date, sort lcolor(green)) /// 66 
(line DayINFMeRaA03S02U20210510 date, sort lcolor(red)) /// 67 v8
(line DayINFMeRaA03S02U20210516 date, sort lcolor(red)) /// 68
(line DayINFMeRaA03S02U20210522 date, sort lcolor(red)) /// 69
(line DayINFMeRaA03S02U20210527 date, sort lcolor(red)) /// 70
(line DayINFMeRaA03S02U20210604 date, sort lcolor(red)) /// 71
(line DayINFMeRaA03S02U20210611 date, sort lcolor(red)) /// 72
(line DayINFMeRaA03S02U20210618 date, sort lcolor(red)) /// 73
(line DayINFMeRaA03S02U20210626 date, sort lcolor(red)) /// 74
(line DayINFMeRaA03S02U20210702 date, sort lcolor(red)) /// 75
(line DayINFMeRaA03S02U20210709 date, sort lcolor(red)) /// 76 
(line DayCasMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 77
, xtitle(Date) xlabel(#21, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily infections) title("COVID-19 daily infections, $country, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200619 to 20210709; reference scenario", size(small)) ///
legend(order(1 "v4" 16 "v5" 41 "v6" 53 "v7" 67 "v8" 77 "JOHN cases") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 21a COVID-19 daily infections, $country, IMPE.gph", replace
qui graph export "graph 21a COVID-19 daily infections, $country, IMPE.pdf", replace





* total deaths

**************************************



* total deaths, Absolute value, individual updates


foreach l of global IMPEupdatelist { 

twoway  /// 
(line TotDeaMeRaA00S00 date, lcolor(cyan*1.2)) /// 
(line TotDeaMeRaA03S02U`l' date, sort lcolor(red)) /// 
, xtitle(Date) xlabel(#21, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, IMPE, update `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(2 "IMPE `l'" 1 "JOHN smooth") size(small) rows(1))	

qui graph save "graph 31i COVID-19 total deaths, $country, IMPE update `l'.gph", replace
qui graph export "graph 31i COVID-19 total deaths, $country, IMPE update `l'.pdf", replace

}
*





* total deaths, Absolute value, together

twoway  ///
(line TotDeaMeRaA03S02U20200619 date, sort lcolor(gray)) /// 1 v4
(line TotDeaMeRaA03S02U20200623 date, sort lcolor(gray)) /// 2
(line TotDeaMeRaA03S02U20200702 date, sort lcolor(gray)) /// 3
(line TotDeaMeRaA03S02U20200703 date, sort lcolor(gray)) /// 4
(line TotDeaMeRaA03S02U20200704 date, sort lcolor(gray)) /// 5
(line TotDeaMeRaA03S02U20200707 date, sort lcolor(gray)) /// 6
(line TotDeaMeRaA03S02U20200711 date, sort lcolor(gray)) /// 7
(line TotDeaMeRaA03S02U20200714 date, sort lcolor(gray)) /// 8
(line TotDeaMeRaA03S02U20200715 date, sort lcolor(gray)) /// 9
(line TotDeaMeRaA03S02U20200718 date, sort lcolor(gray)) /// 10
(line TotDeaMeRaA03S02U20200720 date, sort lcolor(gray)) /// 11
(line TotDeaMeRaA03S02U20200722 date, sort lcolor(gray)) /// 12
(line TotDeaMeRaA03S02U20200725 date, sort lcolor(gray)) /// 13
(line TotDeaMeRaA03S02U20200727 date, sort lcolor(gray)) /// 14
(line TotDeaMeRaA03S02U20200731 date, sort lcolor(gray)) /// 15 
(line TotDeaMeRaA03S02U20200808 date, sort lcolor(gold)) /// 16 v5
(line TotDeaMeRaA03S02U20200810 date, sort lcolor(gold)) /// 17
(line TotDeaMeRaA03S02U20200811 date, sort lcolor(gold)) /// 18
(line TotDeaMeRaA03S02U20200813 date, sort lcolor(gold)) /// 19
(line TotDeaMeRaA03S02U20200814 date, sort lcolor(gold)) /// 20
(line TotDeaMeRaA03S02U20200817 date, sort lcolor(gold)) /// 21
(line TotDeaMeRaA03S02U20200823 date, sort lcolor(gold)) /// 22
(line TotDeaMeRaA03S02U20200825 date, sort lcolor(gold)) /// 23
(line TotDeaMeRaA03S02U20200827 date, sort lcolor(gold)) /// 24
(line TotDeaMeRaA03S02U20200831 date, sort lcolor(gold)) /// 25
(line TotDeaMeRaA03S02U20200902 date, sort lcolor(gold)) /// 26
(line TotDeaMeRaA03S02U20200906 date, sort lcolor(gold)) /// 27
(line TotDeaMeRaA03S02U20200908 date, sort lcolor(gold)) /// 28
(line TotDeaMeRaA03S02U20200912 date, sort lcolor(gold)) /// 29
(line TotDeaMeRaA03S02U20200915 date, sort lcolor(gold)) /// 30
(line TotDeaMeRaA03S02U20200919 date, sort lcolor(gold)) /// 31
(line TotDeaMeRaA03S02U20200923 date, sort lcolor(gold)) /// 32
(line TotDeaMeRaA03S02U20200925 date, sort lcolor(gold)) /// 33
(line TotDeaMeRaA03S02U20201003 date, sort lcolor(gold)) /// 34
(line TotDeaMeRaA03S02U20201006 date, sort lcolor(gold)) /// 35
(line TotDeaMeRaA03S02U20201012 date, sort lcolor(gold)) /// 36
(line TotDeaMeRaA03S02U20201019 date, sort lcolor(gold)) /// 37
(line TotDeaMeRaA03S02U20201025 date, sort lcolor(gold)) /// 38
(line TotDeaMeRaA03S02U20201028 date, sort lcolor(gold)) /// 39
(line TotDeaMeRaA03S02U20201101 date, sort lcolor(gold)) /// 40 
(line TotDeaMeRaA03S02U20201110 date, sort lcolor(blue)) /// 41 v6
(line TotDeaMeRaA03S02U20201114 date, sort lcolor(blue)) /// 42
(line TotDeaMeRaA03S02U20201118 date, sort lcolor(blue)) /// 43
(line TotDeaMeRaA03S02U20201123 date, sort lcolor(blue)) /// 44
(line TotDeaMeRaA03S02U20201129 date, sort lcolor(blue)) /// 45
(line TotDeaMeRaA03S02U20201204 date, sort lcolor(blue)) /// 46
(line TotDeaMeRaA03S02U20201212 date, sort lcolor(blue)) /// 47
(line TotDeaMeRaA03S02U20201220 date, sort lcolor(blue)) /// 48
(line TotDeaMeRaA03S02U20201226 date, sort lcolor(blue)) /// 49
(line TotDeaMeRaA03S02U20210104 date, sort lcolor(blue)) /// 50
(line TotDeaMeRaA03S02U20210110 date, sort lcolor(blue)) /// 51
(line TotDeaMeRaA03S02U20210112 date, sort lcolor(blue)) /// 52 
(line TotDeaMeRaA03S02U20210118 date, sort lcolor(green)) /// 53 v7
(line TotDeaMeRaA03S02U20210124 date, sort lcolor(green)) /// 54
(line TotDeaMeRaA03S02U20210130 date, sort lcolor(green)) /// 55
(line TotDeaMeRaA03S02U20210203 date, sort lcolor(green)) /// 56
(line TotDeaMeRaA03S02U20210210 date, sort lcolor(green)) /// 57
(line TotDeaMeRaA03S02U20210217 date, sort lcolor(green)) /// 58
(line TotDeaMeRaA03S02U20210226 date, sort lcolor(green)) /// 59
(line TotDeaMeRaA03S02U20210305 date, sort lcolor(green)) /// 60
(line TotDeaMeRaA03S02U20210312 date, sort lcolor(green)) /// 61
(line TotDeaMeRaA03S02U20210319 date, sort lcolor(green)) /// 62
(line TotDeaMeRaA03S02U20210329 date, sort lcolor(green)) /// 63
(line TotDeaMeRaA03S02U20210406 date, sort lcolor(green)) /// 64
(line TotDeaMeRaA03S02U20210417 date, sort lcolor(green)) /// 65
(line TotDeaMeRaA03S02U20210424 date, sort lcolor(green)) /// 66 
(line TotDeaMeRaA03S02U20210510 date, sort lcolor(red)) /// 67 v8
(line TotDeaMeRaA03S02U20210516 date, sort lcolor(red)) /// 68
(line TotDeaMeRaA03S02U20210522 date, sort lcolor(red)) /// 69
(line TotDeaMeRaA03S02U20210527 date, sort lcolor(red)) /// 70
(line TotDeaMeRaA03S02U20210604 date, sort lcolor(red)) /// 71
(line TotDeaMeRaA03S02U20210611 date, sort lcolor(red)) /// 72
(line TotDeaMeRaA03S02U20210618 date, sort lcolor(red)) /// 73
(line TotDeaMeRaA03S02U20210626 date, sort lcolor(red)) /// 74
(line TotDeaMeRaA03S02U20210702 date, sort lcolor(red)) /// 75
(line TotDeaMeRaA03S02U20210709 date, sort lcolor(red)) /// 76 
(line TotDeaMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 77
, xtitle(Date) xlabel(#21, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths) title("COVID-19 total deaths, $country, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200619 to 20210709; reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "v4" 16 "v5" 41 "v6" 53 "v7" 67 "v8" 77 "JOHN") size(small) rows(1)) yscale(titlegap(2))
  	   
qui graph save "graph 31a COVID-19 total deaths, $country, IMPE.gph", replace
qui graph export "graph 31a COVID-19 total deaths, $country, IMPE.pdf", replace





*********

* total deaths, Difference, together

twoway  ///
(line TotDeaMeRaA03S02U20200619D date, sort lcolor(gray)) /// 1 v4
(line TotDeaMeRaA03S02U20200623D date, sort lcolor(gray)) /// 2
(line TotDeaMeRaA03S02U20200702D date, sort lcolor(gray)) /// 3
(line TotDeaMeRaA03S02U20200703D date, sort lcolor(gray)) /// 4
(line TotDeaMeRaA03S02U20200704D date, sort lcolor(gray)) /// 5
(line TotDeaMeRaA03S02U20200707D date, sort lcolor(gray)) /// 6
(line TotDeaMeRaA03S02U20200711D date, sort lcolor(gray)) /// 7
(line TotDeaMeRaA03S02U20200714D date, sort lcolor(gray)) /// 8
(line TotDeaMeRaA03S02U20200715D date, sort lcolor(gray)) /// 9
(line TotDeaMeRaA03S02U20200718D date, sort lcolor(gray)) /// 10
(line TotDeaMeRaA03S02U20200720D date, sort lcolor(gray)) /// 11
(line TotDeaMeRaA03S02U20200722D date, sort lcolor(gray)) /// 12
(line TotDeaMeRaA03S02U20200725D date, sort lcolor(gray)) /// 13
(line TotDeaMeRaA03S02U20200727D date, sort lcolor(gray)) /// 14
(line TotDeaMeRaA03S02U20200731D date, sort lcolor(gray)) /// 15 
(line TotDeaMeRaA03S02U20200808D date, sort lcolor(gold)) /// 16 v5
(line TotDeaMeRaA03S02U20200810D date, sort lcolor(gold)) /// 17
(line TotDeaMeRaA03S02U20200811D date, sort lcolor(gold)) /// 18
(line TotDeaMeRaA03S02U20200813D date, sort lcolor(gold)) /// 19
(line TotDeaMeRaA03S02U20200814D date, sort lcolor(gold)) /// 20
(line TotDeaMeRaA03S02U20200817D date, sort lcolor(gold)) /// 21
(line TotDeaMeRaA03S02U20200823D date, sort lcolor(gold)) /// 22
(line TotDeaMeRaA03S02U20200825D date, sort lcolor(gold)) /// 23
(line TotDeaMeRaA03S02U20200827D date, sort lcolor(gold)) /// 24
(line TotDeaMeRaA03S02U20200831D date, sort lcolor(gold)) /// 25
(line TotDeaMeRaA03S02U20200902D date, sort lcolor(gold)) /// 26
(line TotDeaMeRaA03S02U20200906D date, sort lcolor(gold)) /// 27
(line TotDeaMeRaA03S02U20200908D date, sort lcolor(gold)) /// 28
(line TotDeaMeRaA03S02U20200912D date, sort lcolor(gold)) /// 29
(line TotDeaMeRaA03S02U20200915D date, sort lcolor(gold)) /// 30
(line TotDeaMeRaA03S02U20200919D date, sort lcolor(gold)) /// 31
(line TotDeaMeRaA03S02U20200923D date, sort lcolor(gold)) /// 32
(line TotDeaMeRaA03S02U20200925D date, sort lcolor(gold)) /// 33
(line TotDeaMeRaA03S02U20201003D date, sort lcolor(gold)) /// 34
(line TotDeaMeRaA03S02U20201006D date, sort lcolor(gold)) /// 35
(line TotDeaMeRaA03S02U20201012D date, sort lcolor(gold)) /// 36
(line TotDeaMeRaA03S02U20201019D date, sort lcolor(gold)) /// 37
(line TotDeaMeRaA03S02U20201025D date, sort lcolor(gold)) /// 38
(line TotDeaMeRaA03S02U20201028D date, sort lcolor(gold)) /// 39
(line TotDeaMeRaA03S02U20201101D date, sort lcolor(gold)) /// 40 
(line TotDeaMeRaA03S02U20201110D date, sort lcolor(blue)) /// 41 v6
(line TotDeaMeRaA03S02U20201114D date, sort lcolor(blue)) /// 42
(line TotDeaMeRaA03S02U20201118D date, sort lcolor(blue)) /// 43
(line TotDeaMeRaA03S02U20201123D date, sort lcolor(blue)) /// 44
(line TotDeaMeRaA03S02U20201129D date, sort lcolor(blue)) /// 45
(line TotDeaMeRaA03S02U20201204D date, sort lcolor(blue)) /// 46
(line TotDeaMeRaA03S02U20201212D date, sort lcolor(blue)) /// 47
(line TotDeaMeRaA03S02U20201220D date, sort lcolor(blue)) /// 48
(line TotDeaMeRaA03S02U20201226D date, sort lcolor(blue)) /// 49
(line TotDeaMeRaA03S02U20210104D date, sort lcolor(blue)) /// 50
(line TotDeaMeRaA03S02U20210110D date, sort lcolor(blue)) /// 51
(line TotDeaMeRaA03S02U20210112D date, sort lcolor(blue)) /// 52 
(line TotDeaMeRaA03S02U20210118D date, sort lcolor(green)) /// 53 v7
(line TotDeaMeRaA03S02U20210124D date, sort lcolor(green)) /// 54
(line TotDeaMeRaA03S02U20210130D date, sort lcolor(green)) /// 55
(line TotDeaMeRaA03S02U20210203D date, sort lcolor(green)) /// 56
(line TotDeaMeRaA03S02U20210210D date, sort lcolor(green)) /// 57
(line TotDeaMeRaA03S02U20210217D date, sort lcolor(green)) /// 58
(line TotDeaMeRaA03S02U20210226D date, sort lcolor(green)) /// 59
(line TotDeaMeRaA03S02U20210305D date, sort lcolor(green)) /// 60
(line TotDeaMeRaA03S02U20210312D date, sort lcolor(green)) /// 61
(line TotDeaMeRaA03S02U20210319D date, sort lcolor(green)) /// 62
(line TotDeaMeRaA03S02U20210329D date, sort lcolor(green)) /// 63
(line TotDeaMeRaA03S02U20210406D date, sort lcolor(green)) /// 64
(line TotDeaMeRaA03S02U20210417D date, sort lcolor(green)) /// 65
(line TotDeaMeRaA03S02U20210424D date, sort lcolor(green)) /// 66 
(line TotDeaMeRaA03S02U20210510D date, sort lcolor(red)) /// 67 v8
(line TotDeaMeRaA03S02U20210516D date, sort lcolor(red)) /// 68
(line TotDeaMeRaA03S02U20210522D date, sort lcolor(red)) /// 69
(line TotDeaMeRaA03S02U20210527D date, sort lcolor(red)) /// 70
(line TotDeaMeRaA03S02U20210604D date, sort lcolor(red)) /// 71
(line TotDeaMeRaA03S02U20210611D date, sort lcolor(red)) /// 72
(line TotDeaMeRaA03S02U20210618D date, sort lcolor(red)) /// 73
(line TotDeaMeRaA03S02U20210626D date, sort lcolor(red)) /// 74
(line TotDeaMeRaA03S02U20210702D date, sort lcolor(red)) /// 75
(line TotDeaMeRaA03S02U20210709D date, sort lcolor(red)) /// 76 
, xtitle(Date) xlabel(#21, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths IMPE minus JOHN) title("COVID-19 total deaths, $country, IMPE minus JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200619 to 20210709; reference scenario", size(small)) ///
legend(order(1 "v4" 16 "v5" 41 "v6" 53 "v7" 67 "v8") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 32a COVID-19 total deaths, $country, IMPE, Difference.gph", replace
qui graph export "graph 32a COVID-19 total deaths, $country, IMPE, Difference.pdf", replace




*


*********

* total deaths, Times, together

twoway  ///
(line TotDeaMeRaA03S02U20200619T date, sort lcolor(gray)) /// 1 v4
(line TotDeaMeRaA03S02U20200623T date, sort lcolor(gray)) /// 2
(line TotDeaMeRaA03S02U20200702T date, sort lcolor(gray)) /// 3
(line TotDeaMeRaA03S02U20200703T date, sort lcolor(gray)) /// 4
(line TotDeaMeRaA03S02U20200704T date, sort lcolor(gray)) /// 5
(line TotDeaMeRaA03S02U20200707T date, sort lcolor(gray)) /// 6
(line TotDeaMeRaA03S02U20200711T date, sort lcolor(gray)) /// 7
(line TotDeaMeRaA03S02U20200714T date, sort lcolor(gray)) /// 8
(line TotDeaMeRaA03S02U20200715T date, sort lcolor(gray)) /// 9
(line TotDeaMeRaA03S02U20200718T date, sort lcolor(gray)) /// 10
(line TotDeaMeRaA03S02U20200720T date, sort lcolor(gray)) /// 11
(line TotDeaMeRaA03S02U20200722T date, sort lcolor(gray)) /// 12
(line TotDeaMeRaA03S02U20200725T date, sort lcolor(gray)) /// 13
(line TotDeaMeRaA03S02U20200727T date, sort lcolor(gray)) /// 14
(line TotDeaMeRaA03S02U20200731T date, sort lcolor(gray)) /// 15 
(line TotDeaMeRaA03S02U20200808T date, sort lcolor(gold)) /// 16 v5
(line TotDeaMeRaA03S02U20200810T date, sort lcolor(gold)) /// 17
(line TotDeaMeRaA03S02U20200811T date, sort lcolor(gold)) /// 18
(line TotDeaMeRaA03S02U20200813T date, sort lcolor(gold)) /// 19
(line TotDeaMeRaA03S02U20200814T date, sort lcolor(gold)) /// 20
(line TotDeaMeRaA03S02U20200817T date, sort lcolor(gold)) /// 21
(line TotDeaMeRaA03S02U20200823T date, sort lcolor(gold)) /// 22
(line TotDeaMeRaA03S02U20200825T date, sort lcolor(gold)) /// 23
(line TotDeaMeRaA03S02U20200827T date, sort lcolor(gold)) /// 24
(line TotDeaMeRaA03S02U20200831T date, sort lcolor(gold)) /// 25
(line TotDeaMeRaA03S02U20200902T date, sort lcolor(gold)) /// 26
(line TotDeaMeRaA03S02U20200906T date, sort lcolor(gold)) /// 27
(line TotDeaMeRaA03S02U20200908T date, sort lcolor(gold)) /// 28
(line TotDeaMeRaA03S02U20200912T date, sort lcolor(gold)) /// 29
(line TotDeaMeRaA03S02U20200915T date, sort lcolor(gold)) /// 30
(line TotDeaMeRaA03S02U20200919T date, sort lcolor(gold)) /// 31
(line TotDeaMeRaA03S02U20200923T date, sort lcolor(gold)) /// 32
(line TotDeaMeRaA03S02U20200925T date, sort lcolor(gold)) /// 33
(line TotDeaMeRaA03S02U20201003T date, sort lcolor(gold)) /// 34
(line TotDeaMeRaA03S02U20201006T date, sort lcolor(gold)) /// 35
(line TotDeaMeRaA03S02U20201012T date, sort lcolor(gold)) /// 36
(line TotDeaMeRaA03S02U20201019T date, sort lcolor(gold)) /// 37
(line TotDeaMeRaA03S02U20201025T date, sort lcolor(gold)) /// 38
(line TotDeaMeRaA03S02U20201028T date, sort lcolor(gold)) /// 39
(line TotDeaMeRaA03S02U20201101T date, sort lcolor(gold)) /// 40 
(line TotDeaMeRaA03S02U20201110T date, sort lcolor(blue)) /// 41 v6
(line TotDeaMeRaA03S02U20201114T date, sort lcolor(blue)) /// 42
(line TotDeaMeRaA03S02U20201118T date, sort lcolor(blue)) /// 43
(line TotDeaMeRaA03S02U20201123T date, sort lcolor(blue)) /// 44
(line TotDeaMeRaA03S02U20201129T date, sort lcolor(blue)) /// 45
(line TotDeaMeRaA03S02U20201204T date, sort lcolor(blue)) /// 46
(line TotDeaMeRaA03S02U20201212T date, sort lcolor(blue)) /// 47
(line TotDeaMeRaA03S02U20201220T date, sort lcolor(blue)) /// 48
(line TotDeaMeRaA03S02U20201226T date, sort lcolor(blue)) /// 49
(line TotDeaMeRaA03S02U20210104T date, sort lcolor(blue)) /// 50
(line TotDeaMeRaA03S02U20210110T date, sort lcolor(blue)) /// 51
(line TotDeaMeRaA03S02U20210112T date, sort lcolor(blue)) /// 52 
(line TotDeaMeRaA03S02U20210118T date, sort lcolor(green)) /// 53 v7
(line TotDeaMeRaA03S02U20210124T date, sort lcolor(green)) /// 54
(line TotDeaMeRaA03S02U20210130T date, sort lcolor(green)) /// 55
(line TotDeaMeRaA03S02U20210203T date, sort lcolor(green)) /// 56
(line TotDeaMeRaA03S02U20210210T date, sort lcolor(green)) /// 57
(line TotDeaMeRaA03S02U20210217T date, sort lcolor(green)) /// 58
(line TotDeaMeRaA03S02U20210226T date, sort lcolor(green)) /// 59
(line TotDeaMeRaA03S02U20210305T date, sort lcolor(green)) /// 60
(line TotDeaMeRaA03S02U20210312T date, sort lcolor(green)) /// 61
(line TotDeaMeRaA03S02U20210319T date, sort lcolor(green)) /// 62
(line TotDeaMeRaA03S02U20210329T date, sort lcolor(green)) /// 63
(line TotDeaMeRaA03S02U20210406T date, sort lcolor(green)) /// 64
(line TotDeaMeRaA03S02U20210417T date, sort lcolor(green)) /// 65
(line TotDeaMeRaA03S02U20210424T date, sort lcolor(green)) /// 66 
(line TotDeaMeRaA03S02U20210510T date, sort lcolor(red)) /// 67 v8
(line TotDeaMeRaA03S02U20210516T date, sort lcolor(red)) /// 68
(line TotDeaMeRaA03S02U20210522T date, sort lcolor(red)) /// 69
(line TotDeaMeRaA03S02U20210527T date, sort lcolor(red)) /// 70
(line TotDeaMeRaA03S02U20210604T date, sort lcolor(red)) /// 71
(line TotDeaMeRaA03S02U20210611T date, sort lcolor(red)) /// 72
(line TotDeaMeRaA03S02U20210618T date, sort lcolor(red)) /// 73
(line TotDeaMeRaA03S02U20210626T date, sort lcolor(red)) /// 74
(line TotDeaMeRaA03S02U20210702T date, sort lcolor(red)) /// 75
(line TotDeaMeRaA03S02U20210709T date, sort lcolor(red)) /// 76 
, xtitle(Date) xlabel(#21, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths IMPE divided by JOHN) title("COVID-19 total deaths, $country, IMPE divided by JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200619 to 20210709; reference scenario", size(small)) ///
legend(order(1 "v4" 16 "v5" 41 "v6" 53 "v7" 67 "v8") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
 
qui graph save "graph 33a COVID-19 total deaths, $country, IMPE, Times.gph", replace
qui graph export "graph 33a COVID-19 total deaths, $country, IMPE, Times.pdf", replace





*********

* total deaths, Percent, together

twoway  ///
(line TotDeaMeRaA03S02U20200619P date, sort lcolor(gray)) /// 1 v4
(line TotDeaMeRaA03S02U20200623P date, sort lcolor(gray)) /// 2
(line TotDeaMeRaA03S02U20200702P date, sort lcolor(gray)) /// 3
(line TotDeaMeRaA03S02U20200703P date, sort lcolor(gray)) /// 4
(line TotDeaMeRaA03S02U20200704P date, sort lcolor(gray)) /// 5
(line TotDeaMeRaA03S02U20200707P date, sort lcolor(gray)) /// 6
(line TotDeaMeRaA03S02U20200711P date, sort lcolor(gray)) /// 7
(line TotDeaMeRaA03S02U20200714P date, sort lcolor(gray)) /// 8
(line TotDeaMeRaA03S02U20200715P date, sort lcolor(gray)) /// 9
(line TotDeaMeRaA03S02U20200718P date, sort lcolor(gray)) /// 10
(line TotDeaMeRaA03S02U20200720P date, sort lcolor(gray)) /// 11
(line TotDeaMeRaA03S02U20200722P date, sort lcolor(gray)) /// 12
(line TotDeaMeRaA03S02U20200725P date, sort lcolor(gray)) /// 13
(line TotDeaMeRaA03S02U20200727P date, sort lcolor(gray)) /// 14
(line TotDeaMeRaA03S02U20200731P date, sort lcolor(gray)) /// 15 
(line TotDeaMeRaA03S02U20200808P date, sort lcolor(gold)) /// 16 v5
(line TotDeaMeRaA03S02U20200810P date, sort lcolor(gold)) /// 17
(line TotDeaMeRaA03S02U20200811P date, sort lcolor(gold)) /// 18
(line TotDeaMeRaA03S02U20200813P date, sort lcolor(gold)) /// 19
(line TotDeaMeRaA03S02U20200814P date, sort lcolor(gold)) /// 20
(line TotDeaMeRaA03S02U20200817P date, sort lcolor(gold)) /// 21
(line TotDeaMeRaA03S02U20200823P date, sort lcolor(gold)) /// 22
(line TotDeaMeRaA03S02U20200825P date, sort lcolor(gold)) /// 23
(line TotDeaMeRaA03S02U20200827P date, sort lcolor(gold)) /// 24
(line TotDeaMeRaA03S02U20200831P date, sort lcolor(gold)) /// 25
(line TotDeaMeRaA03S02U20200902P date, sort lcolor(gold)) /// 26
(line TotDeaMeRaA03S02U20200906P date, sort lcolor(gold)) /// 27
(line TotDeaMeRaA03S02U20200908P date, sort lcolor(gold)) /// 28
(line TotDeaMeRaA03S02U20200912P date, sort lcolor(gold)) /// 29
(line TotDeaMeRaA03S02U20200915P date, sort lcolor(gold)) /// 30
(line TotDeaMeRaA03S02U20200919P date, sort lcolor(gold)) /// 31
(line TotDeaMeRaA03S02U20200923P date, sort lcolor(gold)) /// 32
(line TotDeaMeRaA03S02U20200925P date, sort lcolor(gold)) /// 33
(line TotDeaMeRaA03S02U20201003P date, sort lcolor(gold)) /// 34
(line TotDeaMeRaA03S02U20201006P date, sort lcolor(gold)) /// 35
(line TotDeaMeRaA03S02U20201012P date, sort lcolor(gold)) /// 36
(line TotDeaMeRaA03S02U20201019P date, sort lcolor(gold)) /// 37
(line TotDeaMeRaA03S02U20201025P date, sort lcolor(gold)) /// 38
(line TotDeaMeRaA03S02U20201028P date, sort lcolor(gold)) /// 39
(line TotDeaMeRaA03S02U20201101P date, sort lcolor(gold)) /// 40 
(line TotDeaMeRaA03S02U20201110P date, sort lcolor(blue)) /// 41 v6
(line TotDeaMeRaA03S02U20201114P date, sort lcolor(blue)) /// 42
(line TotDeaMeRaA03S02U20201118P date, sort lcolor(blue)) /// 43
(line TotDeaMeRaA03S02U20201123P date, sort lcolor(blue)) /// 44
(line TotDeaMeRaA03S02U20201129P date, sort lcolor(blue)) /// 45
(line TotDeaMeRaA03S02U20201204P date, sort lcolor(blue)) /// 46
(line TotDeaMeRaA03S02U20201212P date, sort lcolor(blue)) /// 47
(line TotDeaMeRaA03S02U20201220P date, sort lcolor(blue)) /// 48
(line TotDeaMeRaA03S02U20201226P date, sort lcolor(blue)) /// 49
(line TotDeaMeRaA03S02U20210104P date, sort lcolor(blue)) /// 50
(line TotDeaMeRaA03S02U20210110P date, sort lcolor(blue)) /// 51
(line TotDeaMeRaA03S02U20210112P date, sort lcolor(blue)) /// 52 
(line TotDeaMeRaA03S02U20210118P date, sort lcolor(green)) /// 53 v7
(line TotDeaMeRaA03S02U20210124P date, sort lcolor(green)) /// 54
(line TotDeaMeRaA03S02U20210130P date, sort lcolor(green)) /// 55
(line TotDeaMeRaA03S02U20210203P date, sort lcolor(green)) /// 56
(line TotDeaMeRaA03S02U20210210P date, sort lcolor(green)) /// 57
(line TotDeaMeRaA03S02U20210217P date, sort lcolor(green)) /// 58
(line TotDeaMeRaA03S02U20210226P date, sort lcolor(green)) /// 59
(line TotDeaMeRaA03S02U20210305P date, sort lcolor(green)) /// 60
(line TotDeaMeRaA03S02U20210312P date, sort lcolor(green)) /// 61
(line TotDeaMeRaA03S02U20210319P date, sort lcolor(green)) /// 62
(line TotDeaMeRaA03S02U20210329P date, sort lcolor(green)) /// 63
(line TotDeaMeRaA03S02U20210406P date, sort lcolor(green)) /// 64
(line TotDeaMeRaA03S02U20210417P date, sort lcolor(green)) /// 65
(line TotDeaMeRaA03S02U20210424P date, sort lcolor(green)) /// 66 
(line TotDeaMeRaA03S02U20210510P date, sort lcolor(red)) /// 67 v8
(line TotDeaMeRaA03S02U20210516P date, sort lcolor(red)) /// 68
(line TotDeaMeRaA03S02U20210522P date, sort lcolor(red)) /// 69
(line TotDeaMeRaA03S02U20210527P date, sort lcolor(red)) /// 70
(line TotDeaMeRaA03S02U20210604P date, sort lcolor(red)) /// 71
(line TotDeaMeRaA03S02U20210611P date, sort lcolor(red)) /// 72
(line TotDeaMeRaA03S02U20210618P date, sort lcolor(red)) /// 73
(line TotDeaMeRaA03S02U20210626P date, sort lcolor(red)) /// 74
(line TotDeaMeRaA03S02U20210702P date, sort lcolor(red)) /// 75
(line TotDeaMeRaA03S02U20210709P date, sort lcolor(red)) /// 76 
, xtitle(Date) xlabel(#21, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total deaths IMPE percent JOHN) title("COVID-19 total deaths, $country, % (IMPE minus JOHN) / JOHN", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200619 to 20210709; reference scenario", size(small)) ///
legend(order(1 "v4" 16 "v5" 41 "v6" 53 "v7" 67 "v8") size(small) rows(1)) legend(region(lcolor(none))) legend(bexpand) yscale(titlegap(2))
  	   
qui graph save "graph 34a COVID-19 total deaths, $country, IMPE, Percent.gph", replace
qui graph export "graph 34a COVID-19 total deaths, $country, IMPE, Percent.pdf", replace












* total infections

**************************************




* total infections, Absolute value, individual updates


foreach l of global IMPEupdatelist { 

twoway  /// 
(line TotCasMeRaA00S00 date, lcolor(cyan*1.2)) ///  
(line TotINFMeRaA03S02U`l' date, sort lcolor(red)) ///
, xtitle(Date) xlabel(#21, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%15.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Total infections) title("COVID-19 total infections, $country, IMPE, update `l'", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN cases smooth" 2 "IMPE infections `l'") size(small) rows(1))	

qui graph save "graph 41i COVID-19 total infections, $country, IMPE update `l'.gph", replace
qui graph export "graph 41i COVID-19 total infections, $country, IMPE update `l'.pdf", replace

}
*





* total infections, Absolute value, together

twoway  ///
(line TotINFMeRaA03S02U20200619 date, sort lcolor(gray)) /// 1 v4
(line TotINFMeRaA03S02U20200623 date, sort lcolor(gray)) /// 2
(line TotINFMeRaA03S02U20200702 date, sort lcolor(gray)) /// 3
(line TotINFMeRaA03S02U20200703 date, sort lcolor(gray)) /// 4
(line TotINFMeRaA03S02U20200704 date, sort lcolor(gray)) /// 5
(line TotINFMeRaA03S02U20200707 date, sort lcolor(gray)) /// 6
(line TotINFMeRaA03S02U20200711 date, sort lcolor(gray)) /// 7
(line TotINFMeRaA03S02U20200714 date, sort lcolor(gray)) /// 8
(line TotINFMeRaA03S02U20200715 date, sort lcolor(gray)) /// 9
(line TotINFMeRaA03S02U20200718 date, sort lcolor(gray)) /// 10
(line TotINFMeRaA03S02U20200720 date, sort lcolor(gray)) /// 11
(line TotINFMeRaA03S02U20200722 date, sort lcolor(gray)) /// 12
(line TotINFMeRaA03S02U20200725 date, sort lcolor(gray)) /// 13
(line TotINFMeRaA03S02U20200727 date, sort lcolor(gray)) /// 14
(line TotINFMeRaA03S02U20200731 date, sort lcolor(gray)) /// 15 
(line TotINFMeRaA03S02U20200808 date, sort lcolor(gold)) /// 16 v5
(line TotINFMeRaA03S02U20200810 date, sort lcolor(gold)) /// 17
(line TotINFMeRaA03S02U20200811 date, sort lcolor(gold)) /// 18
(line TotINFMeRaA03S02U20200813 date, sort lcolor(gold)) /// 19
(line TotINFMeRaA03S02U20200814 date, sort lcolor(gold)) /// 20
(line TotINFMeRaA03S02U20200817 date, sort lcolor(gold)) /// 21
(line TotINFMeRaA03S02U20200823 date, sort lcolor(gold)) /// 22
(line TotINFMeRaA03S02U20200825 date, sort lcolor(gold)) /// 23
(line TotINFMeRaA03S02U20200827 date, sort lcolor(gold)) /// 24
(line TotINFMeRaA03S02U20200831 date, sort lcolor(gold)) /// 25
(line TotINFMeRaA03S02U20200902 date, sort lcolor(gold)) /// 26
(line TotINFMeRaA03S02U20200906 date, sort lcolor(gold)) /// 27
(line TotINFMeRaA03S02U20200908 date, sort lcolor(gold)) /// 28
(line TotINFMeRaA03S02U20200912 date, sort lcolor(gold)) /// 29
(line TotINFMeRaA03S02U20200915 date, sort lcolor(gold)) /// 30
(line TotINFMeRaA03S02U20200919 date, sort lcolor(gold)) /// 31
(line TotINFMeRaA03S02U20200923 date, sort lcolor(gold)) /// 32
(line TotINFMeRaA03S02U20200925 date, sort lcolor(gold)) /// 33
(line TotINFMeRaA03S02U20201003 date, sort lcolor(gold)) /// 34
(line TotINFMeRaA03S02U20201006 date, sort lcolor(gold)) /// 35
(line TotINFMeRaA03S02U20201012 date, sort lcolor(gold)) /// 36
(line TotINFMeRaA03S02U20201019 date, sort lcolor(gold)) /// 37
(line TotINFMeRaA03S02U20201025 date, sort lcolor(gold)) /// 38
(line TotINFMeRaA03S02U20201028 date, sort lcolor(gold)) /// 39
(line TotINFMeRaA03S02U20201101 date, sort lcolor(gold)) /// 40 
(line TotINFMeRaA03S02U20201110 date, sort lcolor(blue)) /// 41 v6
(line TotINFMeRaA03S02U20201114 date, sort lcolor(blue)) /// 42
(line TotINFMeRaA03S02U20201118 date, sort lcolor(blue)) /// 43
(line TotINFMeRaA03S02U20201123 date, sort lcolor(blue)) /// 44
(line TotINFMeRaA03S02U20201129 date, sort lcolor(blue)) /// 45
(line TotINFMeRaA03S02U20201204 date, sort lcolor(blue)) /// 46
(line TotINFMeRaA03S02U20201212 date, sort lcolor(blue)) /// 47
(line TotINFMeRaA03S02U20201220 date, sort lcolor(blue)) /// 48
(line TotINFMeRaA03S02U20201226 date, sort lcolor(blue)) /// 49
(line TotINFMeRaA03S02U20210104 date, sort lcolor(blue)) /// 50
(line TotINFMeRaA03S02U20210110 date, sort lcolor(blue)) /// 51
(line TotINFMeRaA03S02U20210112 date, sort lcolor(blue)) /// 52 
(line TotINFMeRaA03S02U20210118 date, sort lcolor(green)) /// 53 v7
(line TotINFMeRaA03S02U20210124 date, sort lcolor(green)) /// 54
(line TotINFMeRaA03S02U20210130 date, sort lcolor(green)) /// 55
(line TotINFMeRaA03S02U20210203 date, sort lcolor(green)) /// 56
(line TotINFMeRaA03S02U20210210 date, sort lcolor(green)) /// 57
(line TotINFMeRaA03S02U20210217 date, sort lcolor(green)) /// 58
(line TotINFMeRaA03S02U20210226 date, sort lcolor(green)) /// 59
(line TotINFMeRaA03S02U20210305 date, sort lcolor(green)) /// 60
(line TotINFMeRaA03S02U20210312 date, sort lcolor(green)) /// 61
(line TotINFMeRaA03S02U20210319 date, sort lcolor(green)) /// 62
(line TotINFMeRaA03S02U20210329 date, sort lcolor(green)) /// 63
(line TotINFMeRaA03S02U20210406 date, sort lcolor(green)) /// 64
(line TotINFMeRaA03S02U20210417 date, sort lcolor(green)) /// 65
(line TotINFMeRaA03S02U20210424 date, sort lcolor(green)) /// 66 
(line TotINFMeRaA03S02U20210510 date, sort lcolor(red)) /// 67 v8
(line TotINFMeRaA03S02U20210516 date, sort lcolor(red)) /// 68
(line TotINFMeRaA03S02U20210522 date, sort lcolor(red)) /// 69
(line TotINFMeRaA03S02U20210527 date, sort lcolor(red)) /// 70
(line TotINFMeRaA03S02U20210604 date, sort lcolor(red)) /// 71
(line TotINFMeRaA03S02U20210611 date, sort lcolor(red)) /// 72
(line TotINFMeRaA03S02U20210618 date, sort lcolor(red)) /// 73
(line TotINFMeRaA03S02U20210626 date, sort lcolor(red)) /// 74
(line TotINFMeRaA03S02U20210702 date, sort lcolor(red)) /// 75
(line TotINFMeRaA03S02U20210709 date, sort lcolor(red)) /// 76 
(line TotCasMeRaA00S00 date, lcolor(cyan*1.2) lwidth(thick)) /// 77	   
, xtitle(Date) xlabel(#21, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(total infections) title("COVID-19 total infections, $country, IMPE", size(medium)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) ///
subtitle("all updates 20200619 to 20210709; total infections starting on 20201009; reference scenario", size(small)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "v4" 16 "v5" 41 "v6" 53 "v7" 67 "v8" 77 "JOHN cases") size(small) rows(1)) yscale(titlegap(2))
  	   
qui graph save "graph 41a COVID-19 total infections, $country, IMPE.gph", replace
qui graph export "graph 41a COVID-19 total infections, $country, IMPE.pdf", replace















view "log country IMPE 2 merge updates.smcl"

log close

exit, clear



