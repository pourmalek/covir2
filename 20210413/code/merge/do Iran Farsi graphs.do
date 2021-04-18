
clear all

cd "$pathcovir2"

cd merge

capture log close 

capture log using "log Iran LANL.smcl", replace

***************************************************************************
* This is "do Iran Farsi graphs.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Create Farsi graphs
***************************************************************************

capture log close

log using "log Iran Farsi graphs.smcl", replace

pwd


/*


covir2 20210413 (14000124) dates of component studies updates used

This is the 20210413 update version of covir2 codes. Date of collection of component studies' updates is 20210413 (14000124).

The following dates are the update dates of component studies' estimates used in this version of covir2 codes.




DELP

Date used 2021-04-13 download date 13apr2021

Web1 https://www.covidanalytics.io/projections

Dates covered 10apr2021,15jul2021





IHME

Date used 2021-04-09

Web1 http://www.healthdata.org/covid/data-downloads

Web2 https://ihmecovid19storage.blob.core.windows.net/archive/2021-04-09/ihme-covid19.zip

Dates covered 04feb2020,01aug2021




IMPE

Date used 2021-03-29

Web1 https://github.com/mrc-ide/global-lmic-reports/tree/master/IRN/2021-03-29

Web2 https://raw.githubusercontent.com/mrc-ide/global-lmic-reports/master/IRN/2021-03-29/projections.csv

Dates covered 04jan2020,26jun2021




LANL

Date used 2021-04-11

Web1 https://covid-19.bsvgateway.org

Web2 https://covid-19.bsvgateway.org/forecast/global/2021-04-11/files/2021-04-11globalcumulativedailycases_website.csv

Dates covered 22jan2020,29may2021




SRIV

Date used 2021-04-13

Web1 https://github.com/scc-usc/ReCOVER-COVID-19

Web2 https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historicalforecasts/2021-04-13/globalforecasts_deaths.csv

Dates covered 12apr2021,22jul2021


*/




grstyle init

grstyle color background white





**********************************************
* graphs Farsi (a) black and white (b) color *
**********************************************




use "Iran.dta", clear



sort date

gen day1is01jan2020 = _n

list date day1is01jan2020 if date == td(21jan2020) | date == td(20feb2020) | date == td(20mar2020) | date == td(20apr2020) | date == td(21may2020) /// 
| date == td(21jun2020) | date == td(22jul2020) | date == td(22aug2020) | date == td(22sep2020) ///
| date == td(22oct2020) | date == td(21nov2020) | date == td(21dec2020) | date == td(20jan2021) ///
| date == td(19feb2021) | date == td(21mar2021) | date == td(21apr2021) | date == td(22may2021) ///
| date == td(22jun2021) | date == td(23jul2021) ///
, noobs clean 


/*

ttext(0 21jan2020  "Bah" 0 20feb2020  "Esf" 0 20mar2020  "Far" 0 20apr2020  "Ord" 0 21may2020  "Kho" ///
0 21jun2020  "Tir" 0 22jul2020  "Mor" 0 22aug2020  "Sha" 0 22sep2020  "Meh" ///
0 22oct2020  "Aba" 0 21nov2020  "Aza" 0 21dec2020  "Dey" 0 20jan2021  "Bah" ///
0 19feb2021  "Esf" 0 21mar2021  "Far" 0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir" 0 23jul2021  "Mor" , size(small) color(black) placement(south))


21 51 80 111 142 173 204 235 266 296 326 356 386 416 446 477 508 539 570
1  2  3  4   5   6   7   8   9   10  11  12  13  14  15  16  17  18  19

1     21Jan2020         21  Bah
2     20Feb2020         51  Esf
3     20Mar2020         80  Far
4     20Apr2020        111  Ord
5     21May2020        142  Kho

6     21Jun2020        173  Tir
7     22Jul2020        204  Mor
8     22Aug2020        235  Sha
9     22Sep2020        266  Meh

10    22Oct2020        296  Aba
11    21Nov2020        326  Aza
12    21Dec2020        356  Dey
13    20Jan2021        386  Bah

14    19Feb2021        416  Esf
15    21Mar2021        446  Far
16    21Apr2021        477  Ord
17    22May2021        508  Kho

18    22Jun2021        539  Tir
19    23Jul2021        570  Mor

*/








************

* graph 1a daily deaths bw

* daily deaths, median or reference scenario

* "graph 11a COVID-19 daily deaths, Iran, reference scenarios.gph"

twoway ///
(line DayDeaMeRaA00S00V00 day1is01jan2020, sort lcolor(black) lwidth(medthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA01S00V03 day1is01jan2020, sort lcolor(gray*0.5) lwidth(thick)) /// 2 "DELP"
(line DayDeaMeSmA02S01V03 day1is01jan2020, sort lcolor(black) lpattern(shortdash_dot)) /// 3 "IHME"
(line DayDeaMeRaA03S02V07 day1is01jan2020, sort lcolor(black) lwidth(medthick)) /// 4 "IMPE"
(line DayDeaMeRaA04S00V02 day1is01jan2020, sort lcolor(gray*0.5) lwidth(thin)) /// 5 "LANL"
(line DayDeaMeRaA05S00V02 day1is01jan2020, sort lcolor(black) lwidth(thick)) /// 6 "SRIV"
if date > td(01feb2020) & date < td(30jul2021) ///
, xtitle(تاریخ) ///
xlabel(21 51 80 111 142 173 204 235 266 296 326 356 386 416 446 477 508 539 570) xlabel(, grid) ///
ytitle(مرگ های روزانه) ///
xlabel(, nolabels) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five) ) ///
title("برآورد میانگین مرگ های روزانه کووید-۱۹ در ایران در سناریو های اصلی مطالعات ", size(small)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
ttext(0 21  "بهمن" ///
0 51  "اسفند" ///
0 80  "۱۳۹۹" ///
0 111 "اردیب" /// 
0 142  "خرداد" ///
0 173  "تیر" ///
0 204  "مرداد" ///
0 235  "شهریور" ///
0 266  "مهر" ///
0 296  "آبان" ///
0 326  "آذر" ///
0 356  "دی" ///
0 386  "بهمن" ///
0 416  "اسفند" ///
0 446  "۱۴۰۰" ///
0 477 "اردیب" ///
0 508  "خرداد" ///
0 539  "تیر" ///
0 570  "مرداد" ///
, size(small) color(black)) ///
legend(order( ///
1 "وزارت بهداشت " ///
2 "دلفی " ///
3 "آی اچ ام ای " ///
4 "ایمپریال " ///
5 "لس آلاموس " ///
6 "اسریواستاوا " ///
) size(small) row(2)) 

graph save "graph 1a daily deaths bw.gph", replace
graph export "graph 1a daily deaths bw.pdf", replace



*******


* graph 1a2 daily deaths bw, wo SRIV

* daily deaths, median or reference scenario

* "graph 11a COVID-19 daily deaths, Iran, reference scenarios.gph"

twoway ///
(line DayDeaMeRaA00S00V00 day1is01jan2020, sort lcolor(black) lwidth(medthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA01S00V03 day1is01jan2020, sort lcolor(gray*0.5) lwidth(thick)) /// 2 "DELP"
(line DayDeaMeSmA02S01V03 day1is01jan2020, sort lcolor(black) lpattern(shortdash_dot)) /// 3 "IHME"
(line DayDeaMeRaA03S02V07 day1is01jan2020, sort lcolor(black) lwidth(medthick)) /// 4 "IMPE"
(line DayDeaMeRaA04S00V02 day1is01jan2020, sort lcolor(gray*0.5) lwidth(thin)) /// 5 "LANL"
if date > td(01feb2020) & date < td(30jul2021) ///
, xtitle(تاریخ) ///
xlabel(21 51 80 111 142 173 204 235 266 296 326 356 386 416 446 477 508 539 570) xlabel(, grid) ///
ytitle(مرگ های روزانه) ///
xlabel(, nolabels) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five) ) ///
title("برآورد میانگین مرگ های روزانه کووید-۱۹ در ایران در سناریو های اصلی مطالعات ", size(small)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
ttext(0 21  "بهمن" ///
0 51  "اسفند" ///
0 80  "۱۳۹۹" ///
0 111 "اردیب" /// 
0 142  "خرداد" ///
0 173  "تیر" ///
0 204  "مرداد" ///
0 235  "شهریور" ///
0 266  "مهر" ///
0 296  "آبان" ///
0 326  "آذر" ///
0 356  "دی" ///
0 386  "بهمن" ///
0 416  "اسفند" ///
0 446  "۱۴۰۰" ///
0 477 "اردیب" ///
0 508  "خرداد" ///
0 539  "تیر" ///
0 570  "مرداد" ///
, size(small) color(black)) ///
legend(order( ///
1 "وزارت بهداشت " ///
2 "دلفی " ///
3 "آی اچ ام ای " ///
4 "ایمپریال " ///
5 "لس آلاموس " ///
) size(small) row(2))

graph save "graph 1a2 daily deaths bw wo SRIV.gph", replace
graph export "graph 1a2 daily deaths bw wo SRIV.pdf", replace



************

* graph 1b daily deaths color

twoway ///
(line DayDeaMeRaA00S00V00 day1is01jan2020, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA01S00V03 day1is01jan2020, sort lcolor(red)) /// 2 "DELP"
(line DayDeaMeSmA02S01V03 day1is01jan2020, sort lcolor(black)) /// 3 "IHME"
(line DayDeaMeRaA03S02V07 day1is01jan2020, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDeaMeRaA04S00V02 day1is01jan2020, sort lcolor(gold)) /// 5 "LANL"
(line DayDeaMeRaA05S00V02 day1is01jan2020, sort lcolor(green)) /// 6 "SRIV"
if date > td(01feb2020) & date < td(30jul2021) ///
, xtitle(تاریخ) ///
title("برآورد میانگین مرگ های روزانه کووید-۱۹ در ایران در سناریو های اصلی مطالعات ", size(small)) ///
xlabel(21 51 80 111 142 173 204 235 266 296 326 356 386 416 446 477 508 539 570) xlabel(, grid) ///
ytitle(مرگ های روزانه) ///
xlabel(, nolabels) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
ttext(0 21  "بهمن" ///
0 51  "اسفند" ///
0 80  "۱۳۹۹" ///
0 111 "اردیب" /// 
0 142  "خرداد" ///
0 173  "تیر" ///
0 204  "مرداد" ///
0 235  "شهریور" ///
0 266  "مهر" ///
0 296  "آبان" ///
0 326  "آذر" ///
0 356  "دی" ///
0 386  "بهمن" ///
0 416  "اسفند" ///
0 446  "۱۴۰۰" ///
0 477 "اردیب" ///
0 508  "خرداد" ///
0 539  "تیر" ///
0 570  "مرداد" ///
, size(small) color(black)) ///
legend(order( ///
1 "وزارت بهداشت " ///
2 "دلفی " ///
3 "آی اچ ام ای " ///
4 "ایمپریال " ///
5 "لس آلاموس " ///
6 "اسریواستاوا " ///
) size(small) row(2))

graph save "graph 1b daily deaths color.gph", replace
graph export "graph 1b daily deaths color.pdf", replace




************

* graph 1b2 daily deaths color, wo SRIV

twoway ///
(line DayDeaMeRaA00S00V00 day1is01jan2020, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA01S00V03 day1is01jan2020, sort lcolor(red)) /// 2 "DELP"
(line DayDeaMeSmA02S01V03 day1is01jan2020, sort lcolor(black)) /// 3 "IHME"
(line DayDeaMeRaA03S02V07 day1is01jan2020, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDeaMeRaA04S00V02 day1is01jan2020, sort lcolor(gold)) /// 5 "LANL"
if date > td(01feb2020) & date < td(30jul2021) ///
, xtitle(تاریخ) ///
title("برآورد میانگین مرگ های روزانه کووید-۱۹ در ایران در سناریو های اصلی مطالعات ", size(small)) ///
xlabel(21 51 80 111 142 173 204 235 266 296 326 356 386 416 446 477 508 539 570) xlabel(, grid) ///
ytitle(مرگ های روزانه) ///
xlabel(, nolabels) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
ttext(0 21  "بهمن" ///
0 51  "اسفند" ///
0 80  "۱۳۹۹" ///
0 111 "اردیب" /// 
0 142  "خرداد" ///
0 173  "تیر" ///
0 204  "مرداد" ///
0 235  "شهریور" ///
0 266  "مهر" ///
0 296  "آبان" ///
0 326  "آذر" ///
0 356  "دی" ///
0 386  "بهمن" ///
0 416  "اسفند" ///
0 446  "۱۴۰۰" ///
0 477 "اردیب" ///
0 508  "خرداد" ///
0 539  "تیر" ///
0 570  "مرداد" ///
, size(small) color(black)) ///
legend(order( ///
1 "وزارت بهداشت " ///
2 "دلفی " ///
3 "آی اچ ام ای " ///
4 "ایمپریال " ///
5 "لس آلاموس " ///
) size(small) row(2))

graph save "graph 1b2 daily deaths color wo SRIV.gph", replace
graph export "graph 1b2 daily deaths color wo SRIV.pdf", replace




************

* graph 2a daily cases bw

* daily cases, median or reference scenario

* "graph 21a COVID-19 daily cases, Iran, reference scenarios.gph"

twoway ///
(line DayCasMeRaA00S00V00 day1is01jan2020, sort lcolor(black) lwidth(medthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA01S00V03 day1is01jan2020, sort lcolor(gray*0.5) lwidth(thick)) /// 2 "DELP"
(line DayCasMeRaA02S01V03 day1is01jan2020, sort lcolor(black) lpattern(shortdash_dot)) /// 3 "IHME"
(line DayCasMeRaA03S02V07 day1is01jan2020, sort lcolor(black)  lwidth(medthick)) /// 4 "IMPE"
(line DayCasMeRaA04S00V02 day1is01jan2020, sort lcolor(gray*0.5) lwidth(thin)) /// 5 "LANL"
(line DayCasMeRaA05S00V02 day1is01jan2020, sort lcolor(black) lwidth(thick)) /// 6 "SRIV"
if date > td(01feb2020) & date < td(30jul2021) ///
, xtitle(تاریخ) ///
title("برآورد میانگین موارد جدید روزانه بیماری کووید-۱۹ در ایران در سناریو های اصلی مطالعات", size(small)) ///
xlabel(21 51 80 111 142 173 204 235 266 296 326 356 386 416 446 477 508 539 570) xlabel(, grid) ///
ytitle(موارد جدید روزانه بیماری ) /// 
xlabel(, nolabels) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
ttext(0 21  "بهمن" ///
0 51  "اسفند" ///
0 80  "۱۳۹۹" ///
0 111 "اردیب" /// 
0 142  "خرداد" ///
0 173  "تیر" ///
0 204  "مرداد" ///
0 235  "شهریور" ///
0 266  "مهر" ///
0 296  "آبان" ///
0 326  "آذر" ///
0 356  "دی" ///
0 386  "بهمن" ///
0 416  "اسفند" ///
0 446  "۱۴۰۰" ///
0 477 "اردیب" ///
0 508  "خرداد" ///
0 539  "تیر" ///
0 570  "مرداد" ///
, size(small) color(black)) ///
legend(order( ///
1 "وزارت بهداشت " ///
2 "دلفی " ///
3 "آی اچ ام ای " ///
4 "ایمپریال " ///
5 "لس آلاموس " ///
6 "اسریواستاوا " ///
) size(small) row(2))

graph save "graph 2a daily cases bw.gph", replace
graph export "graph 2a daily cases bw.pdf", replace





************

* graph 2b daily cases color

twoway ///
(line DayCasMeRaA00S00V00 day1is01jan2020, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA01S00V03 day1is01jan2020, sort lcolor(red)) /// 2 "DELP"
(line DayCasMeRaA02S01V03 day1is01jan2020, sort lcolor(black)) /// 3 "IHME"
(line DayCasMeRaA03S02V07 day1is01jan2020, sort lcolor(magenta)) /// 4 "IMPE"
(line DayCasMeRaA04S00V02 day1is01jan2020, sort lcolor(gold)) /// 5 "LANL"
(line DayCasMeRaA05S00V02 day1is01jan2020, sort lcolor(green)) /// 6 "SRIV"
if date > td(01feb2020) & date < td(30jul2021) ///
, xtitle(تاریخ) ///
title("برآورد میانگین موارد جدید روزانه بیماری کووید-۱۹ در ایران در سناریو های اصلی مطالعات", size(small)) ///
xlabel(21 51 80 111 142 173 204 235 266 296 326 356 386 416 446 477 508 539 570) xlabel(, grid) ///
ytitle(موارد جدید روزانه بیماری ) ///
xlabel(, nolabels) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five) ) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
ttext(0 21  "بهمن" ///
0 51  "اسفند" ///
0 80  "۱۳۹۹" ///
0 111 "اردیب" /// 
0 142  "خرداد" ///
0 173  "تیر" ///
0 204  "مرداد" ///
0 235  "شهریور" ///
0 266  "مهر" ///
0 296  "آبان" ///
0 326  "آذر" ///
0 356  "دی" ///
0 386  "بهمن" ///
0 416  "اسفند" ///
0 446  "۱۴۰۰" ///
0 477 "اردیب" ///
0 508  "خرداد" ///
0 539  "تیر" ///
0 570  "مرداد" ///
, size(small) color(black)) ///
legend(order( ///
1 "وزارت بهداشت " ///
2 "دلفی " ///
3 "آی اچ ام ای " ///
4 "ایمپریال " ///
5 "لس آلاموس " ///
6 "اسریواستاوا " ///
) size(small) row(2))

graph save "graph 2b daily cases color.gph", replace
graph export "graph 2b daily cases color.pdf", replace




************

* daily active cases, wo GHAN, Hijri

* "graph 62.1 COVID-19 daily active cases wo GHAN Hijri.gph"



/*

20feb2020 to 23oct2021


1398  1399  1399  1399  1399  1399  1399  1399  1399  1399  1399  1399  1399  1400  1400  1400  1400  1400  1400  1400  1400  
Esf   Far   Ord   Kho   Tir   Mor   Sha   Meh   Aba   Aza   Dey   Bah   Esf   Far   Ord   Kho   Tir   Mor   Sha   Meh   Aba   
21965 21994 22025 22056 22087 22118 22149 22180 22210 22240 22270 22300 22330 22360 22391 22422 22453 22484 22515 22546 22576 
20feb 20mar 20apr 21may 21jun 22jul 22aug 22sep 22oct 21nov 21dec 20jan 19feb 21mar 21apr 22may 22jun 23jul 23aug 23sep 23oct 
2020  2020  2020  2020  2020  2020  2020  2020  2020  2020  2020  2021  2021  2021  2021  2021  2021  2021  2021  2021  2021  




list date day1is01jan2020 if date == td(20feb2020) | date == td(20mar2020) | date == td(20apr2020) | date == td(21may2020) /// 
| date == td(21jun2020) | date == td(22jul2020) | date == td(22aug2020) | date == td(22sep2020) ///
| date == td(22oct2020) | date == td(21nov2020) | date == td(21dec2020) | date == td(20jan2021) ///
| date == td(19feb2021) | date == td(21mar2021) | date == td(21apr2021) | date == td(22may2021) ///
| date == td(22jun2021) | date == td(23jul2021) | date == td(23aug2021) | date == td(23sep2021) ///
| date == td(23oct2021) , noobs clean 






1  2  3   4   5   6   7   8   9   10  11  12  13  14  15  16  17  18  19 20   21
50 80 111 142 173 204 235 266 296 326 356 386 416 446 477 508 539 570 601 632 662




1	  20feb2020	        51  Esf
2     20Mar2020         80  Far
3     20Apr2020        111  Ord
4     21May2020        142  Kho
5     21Jun2020        173  Tir

6     22Jul2020        204  Mor
	
7     22Aug2020        235  Sha
8     22Sep2020        266  Meh
9     22Oct2020        296  Aba
10    21Nov2020        326  Aza
11    21Dec2020        356  Dey
	
12    20Jan2021        386  Bah
13    19Feb2021        416  Esf
14    21Mar2021        446  Far
15    21Apr2021        477  Ord
16    22May2021        508  Kho
	
17    22Jun2021        539  Tir
18    23Jul2021        570  Mor
19    23Aug2021        601  Sha
20    23Sep2021        632  Meh
21    23Oct2021        662  Aba



*/




************

* "graph 3a daily active cases bw.gph"

twoway ///
(line DayActMeRaA00S00V00 day1is01jan2020, sort lcolor(black) lwidth(thick) lpattern(tight_dot)) /// 1 "JOHN" 
(line DayActMeRaA01S00V03 day1is01jan2020, sort lcolor(gray*0.5) lwidth(thick)) /// 2 "DELP" 
(line DayActMeRaA06S01V00 day1is01jan2020, sort lcolor(black) lpattern(dashdot)) /// 3 "SOLT S1"
(line DayActMeRaA06S02V00 day1is01jan2020, sort lcolor(black) lpattern(dash)) /// 4 "SOLT S2"
if date >= td(20feb2020) & date <= td(23oct2021) ///
, xtitle(تاریخ) ///
title("برآورد میانگین موارد موجود روزانه بیماری کووید-۱۹ در ایران در سناریو های اصلی مطالعات", size(medium)) ///
xlabel(80 111 142 173 204 235 266 296 326 356 386 416 446 477 508 539 570 601 632 662) xlabel(, grid) ///
xlabel(, nolabels) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(موارد موجود روزانه بیماری ) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
ttext( ///
0 51  "اسفند " ///
0 80   "۱۳۹۹ " ///
0 111  "اردیب " ///
0 142  "خرداد " ///
0 173  "تیر " ///
0 204  "مرداد " ///
0 235  "شهریور " ///
0 266  "مهر " ///
0 296  "آبان " ///
0 326  "آذر " ///
0 356  "دی " ///
0 386  "بهمن " ///
0 416  "اسفند " ///
0 446  "۱۴۰۰" ///
0 477  "اردیب " ///
0 508  "خرداد " ///
0 539  "تیر " ///
0 570  "مرداد " ///
0 601  "شهریور " ///
0 632  "مهر " ///
0 662  "آبان " ///
, size(small) color(black)) ///
legend(order( ///
1 "وزارت بهداشت " ///
2 "دلفی " ///
3 "سلطانی سناریوی ۱" ///
4 "سلطانی سناریوی ۲" ///
) size(small) row(1))

graph save "graph 3a daily active cases bw.gph", replace
graph export "graph 3a daily active cases bw.pdf", replace



************

* "graph 3b daily active cases color.gph"

twoway ///
(line DayActMeRaA00S00V00 day1is01jan2020, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN" 
(line DayActMeRaA01S00V03 day1is01jan2020, sort lcolor(red)) /// 2 "DELP" 
(line DayActMeRaA06S01V00 day1is01jan2020, sort lcolor(red) lpattern(dash)) /// 3 "SOLT S1"
(line DayActMeRaA06S02V00 day1is01jan2020, sort lcolor(blue) lpattern(dash)) /// 4 "SOLT S2"
if date >= td(20feb2020) & date <= td(23oct2021) ///
, xtitle(تاریخ) ///
title("برآورد میانگین موارد موجود روزانه بیماری کووید-۱۹ در ایران در سناریو های اصلی مطالعات", size(medium)) ///
xlabel(80 111 142 173 204 235 266 296 326 356 386 416 446 477 508 539 570 601 632 662)xlabel(, grid) ///
xlabel(, nolabels) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(موارد موجود روزانه بیماری ) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
ttext( ///
0 51  "اسفند " ///
0 80   "۱۳۹۹ " ///
0 111  "اردیب " ///
0 142  "خرداد " ///
0 173  "تیر " ///
0 204  "مرداد " ///
0 235  "شهریور " ///
0 266  "مهر " ///
0 296  "آبان " ///
0 326  "آذر " ///
0 356  "دی " ///
0 386  "بهمن " ///
0 416  "اسفند " ///
0 446  "۱۴۰۰" ///
0 477  "اردیب " ///
0 508  "خرداد " ///
0 539  "تیر " ///
0 570  "مرداد " ///
0 601  "شهریور " ///
0 632  "مهر " ///
0 662  "آبان " ///
, size(small) color(black)) ///
legend(order( ///
1 "وزارت بهداشت " ///
2 "دلفی " ///
3 "سلطانی سناریوی ۱" ///
4 "سلطانی سناریوی ۲" ///
) size(small) row(1))


graph save "graph 3b daily active cases color.gph", replace
graph export "graph 3b daily active cases color.pdf", replace




************

* graph 4a daily deaths estimated to reported bw

twoway ///
(line DayDERMeRaA00S00V00 day1is01jan2020, sort lcolor(black) lwidth(medthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDERMeRaA02S01V03 day1is01jan2020, sort lcolor(black) lpattern(shortdash_dot)) /// 2 "IHME"
(line DayDERMeRaA03S02V07 day1is01jan2020, sort lcolor(black) lwidth(medthick)) /// 3 "IMPE"
(line DayDERMeRaA04S00V02 day1is01jan2020, sort lcolor(gray*0.5) lwidth(thin)) /// 4 "LANL"
(line DayDERMeRaA05S00V02 day1is01jan2020, sort lcolor(black) lwidth(thick)) /// 5 "SRIV"
if date >= td(19feb2021) & date <= td(21apr2021) ///
, xtitle(تاریخ) ///
title("نسبت میانگین برآورد مرگ های روزانه کووید-۱۹ در ایران به گزارش رسمی از اسفند  ۹۹ به بعد", size(medium)) /// 
xlabel(416 430 446 460 477) xlabel(, grid) ///
xlabel(, nolabels) ylabel(0(0.25)2, format(%12.2fc) labsize(small)) ylabel(, labsize(small) angle(forty_five)) ///
ytitle(نسبت برآورد مرگ های روزانه به گزارش رسمی) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
ttext( ///
0 419 "۱ اسفند ۱۳۹۹" ///
0 430 "۱۵ اسفند ۱۳۹۹" ///
0 446 "۱ فروردین ۱۴۰۰" ///
0 460 "۱۵ فروردین ۱۴۰۰" ///
0 474 "۱ اردیبهشت ۱۴۰۰" ///
, size(small) color(black)) ///
legend(order( ///
1 "وزارت بهداشت " ///
2 "آی اچ ام ای " ///
3 "ایمپریال " ///
4 "لس آلاموس " ///
5 "اسریواستاوا" ///
) size(small) row(1))

graph save "graph 4a.gph", replace
graph export "graph 4a.pdf", replace



************

* graph 4b daily deaths estimated to reported color

* "graph 92.1 COVID-19 daily deaths estimated to reported, Iran, reference scenarios, 19feb2021 1399-12-01 on.gph"


/*


21 02 19 Esf 01
21 03 05 Esf 15
21 03 21 Far 01
21 04 04 Far 15
21 04 21 Ord 01

list date day1is01jan2020 if ///
  date == td(19feb2021) ///
| date == td(05mar2021) ///
| date == td(21mar2021) ///
| date == td(04apr2021) ///
| date == td(21apr2021) ///
, noobs clean 

1    19Feb2021        416  Esf 01
2    05Mar2021        430  Esf 15
3    21Mar2021        446  Far 01
4    04Apr2021        460  Far 15
5    21Apr2021        477  Ord 01

416 430 446 460 477


1399  1400  1400  
Esf   Far   Ord   
22330 22360 22391 
19feb 21mar 21apr 
2021  2021  2021 

*/


twoway ///
(line DayDERMeRaA00S00V00 day1is01jan2020, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDERMeRaA02S01V03 day1is01jan2020, sort lcolor(black)) /// 2 "IHME"
(line DayDERMeRaA03S02V07 day1is01jan2020, sort lcolor(magenta) lwidth(medthick)) /// 3 "IMPE"
(line DayDERMeRaA04S00V02 day1is01jan2020, sort lcolor(gold) lwidth(thin)) /// 4 "LANL"
(line DayDERMeRaA05S00V02 day1is01jan2020, sort lcolor(green) lwidth(thick)) /// 5 "SRIV"
if date >= td(19feb2021) & date <= td(21apr2021) ///
, xtitle(تاریخ) ///
title("نسبت میانگین برآورد مرگ های روزانه کووید-۱۹ در ایران به گزارش رسمی از اسفند  ۹۹ به بعد", size(medium)) /// 
xlabel(416 430 446 460 477) xlabel(, grid) ///
xlabel(, nolabels) ylabel(0(0.25)2, format(%12.2fc) labsize(small)) ylabel(, labsize(small) angle(forty_five)) ///
ytitle(نسبت برآورد مرگ های روزانه به گزارش رسمی) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
ttext( ///
0 419 "۱ اسفند ۱۳۹۹" ///
0 430 "۱۵ اسفند ۱۳۹۹" ///
0 446 "۱ فروردین ۱۴۰۰" ///
0 460 "۱۵ فروردین ۱۴۰۰" ///
0 474 "۱ اردیبهشت ۱۴۰۰" ///
, size(small) color(black)) ///
legend(order( ///
1 "وزارت بهداشت " ///
2 "آی اچ ام ای " ///
3 "ایمپریال " ///
4 "لس آلاموس " ///
5 "اسریواستاوا" ///
) size(small) row(1))

graph save "graph 4b.gph", replace
graph export "graph 4b.pdf", replace




************

* graph 5a daily cases estimated to reported color

twoway ///
(line DayCERMeRaA00S00V00 day1is01jan2020, sort lcolor(black) lwidth(medthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCERMeRaA02S01V03 day1is01jan2020, sort lcolor(black) lpattern(shortdash_dot)) /// 2 "IHME"
(line DayCERMeRaA03S02V07 day1is01jan2020, sort lcolor(black) lwidth(medthick)) /// 3 "IMPE"
(line DayCERMeRaA04S00V02 day1is01jan2020, sort lcolor(gray*0.5) lwidth(thin)) /// 4 "LANL"
(line DayCERMeRaA05S00V02 day1is01jan2020, sort lcolor(black) lwidth(thick)) /// 5 "SRIV"
if date >= td(19feb2021) & date <= td(21apr2021) ///
, xtitle(تاریخ) ///
title("نسبت میانگین برآورد موارد جدید روزانه بیماری کووید-۱۹ در ایران به گزارش رسمی از اسفند  ۹۹", size(medium)) ///
xlabel(416 430 446 460 477) xlabel(, grid) ///
xlabel(, nolabels) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(نسبت برآورد موارد جدید روزانه بیماری به گزارش رسمی) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
ttext( ///
0 419 "۱ اسفند ۱۳۹۹" ///
0 430 "۱۵ اسفند ۱۳۹۹" ///
0 446 "۱ فروردین ۱۴۰۰" ///
0 460 "۱۵ فروردین ۱۴۰۰" ///
0 474 "۱ اردیبهشت ۱۴۰۰" ///
, size(small) color(black)) ///
legend(order( ///
1 "وزارت بهداشت " ///
2 "آی اچ ام ای " ///
3 "ایمپریال " ///
4 "لس آلاموس " ///
5 "اسریواستاوا" ///
) size(small) row(1))



graph save "graph 5a.gph", replace
graph export "graph 5a.pdf", replace





************


* graph 5b daily cases estimated to reported color

twoway ///
(line DayCERMeRaA00S00V00 day1is01jan2020, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCERMeRaA02S01V03 day1is01jan2020, sort lcolor(black)) /// 2 "IHME"
(line DayCERMeRaA03S02V07 day1is01jan2020, sort lcolor(magenta)) /// 3 "IMPE"
(line DayCERMeRaA04S00V02 day1is01jan2020, sort lcolor(gold)) /// 4 "LANL"
(line DayCERMeRaA05S00V02 day1is01jan2020, sort lcolor(green)) /// 5 "SRIV"
if date >= td(19feb2021) & date <= td(21apr2021) ///
, xtitle(تاریخ) ///
title("نسبت میانگین برآورد موارد جدید روزانه بیماری کووید-۱۹ در ایران به گزارش رسمی از اسفند  ۹۹", size(medium)) ///
xlabel(416 430 446 460 477) xlabel(, grid) ///
xlabel(, nolabels) ylabel(, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(forty_five)) ///
ytitle(نسبت برآورد موارد جدید روزانه بیماری به گزارش رسمی) ///
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
ttext( ///
0 419 "۱ اسفند ۱۳۹۹" ///
0 430 "۱۵ اسفند ۱۳۹۹" ///
0 446 "۱ فروردین ۱۴۰۰" ///
0 460 "۱۵ فروردین ۱۴۰۰" ///
0 474 "۱ اردیبهشت ۱۴۰۰" ///
, size(small) color(black)) ///
legend(order( ///
1 "وزارت بهداشت " ///
2 "آی اچ ام ای " ///
3 "ایمپریال " ///
4 "لس آلاموس " ///
5 "اسریواستاوا" ///
) size(small) row(1))

graph save "graph 5b.gph", replace
graph export "graph 5b.pdf", replace


clear 


pwd






****************
* export excel *
****************


/* remove /* comment out /* in order to create Excel file for crating graphs in Excel


* graph 1

* daily deaths, median or reference scenario 

* "graph 11a COVID-19 daily deaths, Iran, reference scenarios.gph"

use "Iran.dta", clear

keep if date >= td(01feb2020) & date <= td(30jul2021)

keep ///
DayDeaMeRaA00S00V00 ///
DayDeaMeRaA01S00V03 ///
DayDeaMeSmA02S01V03 ///
DayDeaMeRaA03S02V07 ///
DayDeaMeRaA04S00V02 ///
DayDeaMeRaA05S00V02 ///
date


twoway ///
(line DayDeaMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDeaMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP"
(line DayDeaMeSmA02S01V03 date, sort lcolor(black)) /// 3 "IHME"
(line DayDeaMeRaA03S02V07 date, sort lcolor(magenta)) /// 4 "IMPE"
(line DayDeaMeRaA04S00V02 date, sort lcolor(gold)) /// 5 "LANL"
(line DayDeaMeRaA05S00V02 date, sort lcolor(green)) /// 6 "SRIV"
if date > td(01feb2020) & date < td(30jul2021) ///
, xtitle(Date) xlabel(21935 21965 21994 22025 22056 22087 22118 22149 22180 22210 22240 22270 22300 22330 22360 22391 22422 22453 22484, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths) title("COVID-19 daily deaths, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV") size(small) row(1)) ///
subtitle("  .", size(small) color(white)) ///
ttext(0 21jan2020  "Bah" 0 20feb2020  "Esf" 0 20mar2020  "Far" 0 20apr2020  "Ord" 0 21may2020  "Kho" ///
0 21jun2020  "Tir" 0 22jul2020  "Mor" 0 22aug2020  "Sha" 0 22sep2020  "Meh" ///
0 22oct2020  "Aba" 0 21nov2020  "Aza" 0 21dec2020  "Dey" 0 20jan2021  "Bah" ///
0 19feb2021  "Esf" 0 21mar2021  "Far" 0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir" 0 23jul2021  "Mor" , size(small) color(black) placement(south))


graph save "graph1.gph", replace
graph export "graph1.pdf", replace


rename DayDeaMeRaA00S00V00 JOHN
rename DayDeaMeRaA01S00V03 DELP
rename DayDeaMeSmA02S01V03 IHME
rename DayDeaMeRaA03S02V07 IMPE
rename DayDeaMeRaA04S00V02 LANL
rename DayDeaMeRaA05S00V02 SRIV


export excel using "Iran graphs.xlsx", replace firstrow(variables) sheet("graph1") 



* graph 2

* daily cases, median or reference scenario

* "graph 21a COVID-19 daily cases, Iran, reference scenarios.gph"

use "Iran.dta", clear

keep if date >= td(01feb2020) & date <= td(30jul2021)s

keep ///
DayCasMeRaA00S00V00 ///
DayCasMeRaA01S00V03 ///
DayCasMeRaA02S01V03 ///
DayCasMeRaA03S02V07 ///
DayCasMeRaA04S00V02 ///
DayCasMeRaA05S00V02 ///
date


twoway ///
(line DayCasMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCasMeRaA01S00V03 date, sort lcolor(red)) /// 4 "DELP"
(line DayCasMeRaA02S01V03 date, sort lcolor(black)) /// 5 "IHME"
(line DayCasMeRaA03S02V07 date, sort lcolor(magenta)) /// 6 "IMPE"
(line DayCasMeRaA04S00V02 date, sort lcolor(gold)) /// 7 "LANL"
(line DayCasMeRaA05S00V02 date, sort lcolor(green)) /// 8 "SRIV"
if date > td(01feb2020) & date < td(30jul2021) ///
, xtitle(Date) xlabel(21935 21965 21994 22025 22056 22087 22118 22149 22180 22210 22240 22270 22300 22330 22360 22391 22422 22453 22484, ///
format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%9.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases) title("COVID-19 daily cases, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "IHME" 4 "IMPE" 5 "LANL" 6 "SRIV" ) size(small) row(1)) ///
subtitle("  .", size(small) color(white)) ///
ttext(0 21jan2020  "Bah" 0 20feb2020  "Esf" 0 20mar2020  "Far" 0 20apr2020  "Ord" 0 21may2020  "Kho" ///
0 21jun2020  "Tir" 0 22jul2020  "Mor" 0 22aug2020  "Sha" 0 22sep2020  "Meh" ///
0 22oct2020  "Aba" 0 21nov2020  "Aza" 0 21dec2020  "Dey" 0 20jan2021  "Bah" ///
0 19feb2021  "Esf" 0 21mar2021  "Far" 0 21apr2021  "Ord" 0 22may2021  "Kho" ///
0 22jun2021  "Tir" 0 23jul2021  "Mor" , size(small) color(black) placement(south))

graph save "graph2.gph", replace
graph export "graph2.pdf", replace


export excel using "Iran graphs.xlsx", sheetmodify firstrow(variables) sheet("graph2")  




* graph 3

* daily active cases, w GHAN

* "graph 62 COVID-19 daily active cases wo GHAN.gph"


use "Iran.dta", clear

keep if date >= td(01jan2020) & date <= td(01jan2022)

keep ///
DayActMeRaA00S00V00 ///
DayActMeRaA01S00V03 ///
DayActMeRaA07S09V00 ///
DayActMeRaA06S01V00 ///
DayActMeRaA06S02V00 ///
date



twoway ///
(line DayActMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN" 
(line DayActMeRaA01S00V03 date, sort lcolor(red)) /// 2 "DELP" 
(line DayActMeRaA06S01V00 date, sort lcolor(red) lpattern(dash)) /// 3 "SOLT S1"
(line DayActMeRaA06S02V00 date, sort lcolor(blue) lpattern(dash)) /// 4 "SOLT S2"
if date > td(01jan2020) & date < td(01jan2022) ///
, xtitle(Date) xlabel(#24, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(, format(%12.0fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily active cases) title("COVID-19 daily active cases, Iran", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "DELP" 3 "SOLT S1" 4 "SOLT S2") size(small) row(1)) ///
subtitle("without GHAN", size(small))

graph save "graph3.gph", replace
graph export "graph3.pdf", replace


export excel using "Iran graphs.xlsx", sheetmodify firstrow(variables) sheet("graph3")  





* graph 4

* daily deaths estimated to reported (DER) all studies, 19feb2021 1399-12-01 on, reference scenarios

* "graph 92.1 COVID-19 daily deaths estimated to reported, Iran, reference scenarios, 19feb2021 1399-12-01 on.gph"


use "Iran.dta", clear

keep if date >= td(19feb2021) & date <= td(21apr2021)

keep ///
DayDERMeRaA00S00V00 ///
DayDERMeRaA02S01V03 ///
DayDERMeRaA03S02V07 ///
DayDERMeRaA04S00V02 ///
DayDERMeRaA05S00V02 ///
date


twoway ///
(line DayDERMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayDERMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line DayDERMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayDERMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayDERMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(19feb2021) & date <= td(21apr2021) ///
, xtitle(Date) xlabel(22330 22344 22360 22374 22391, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(0(0.25)2, format(%12.2fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily deaths estimated to reported) title("COVID-19 daily deaths estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("after 1399-12-01, no backcasting in DELPHI", size(small)) ///
ttext(0 19feb2021  "Esf 01" 0 05mar2021  "Esf 15" 0 21mar2021  "Far 01" 0 04apr2021  "Far 15" 0 21apr2021  "Ord 01" ///
, size(small) color(black))

graph save "graph4.gph", replace
graph export "graph4.pdf", replace


export excel using "Iran graphs.xlsx", sheetmodify firstrow(variables) sheet("graph4")  







* graph 5

* daily cases estimated to reported (CER) all studies, 19feb2021 1399-12-01 on, reference scenarios

* "graph 93.1 COVID-19 daily cases estimated to reported, Iran, reference scenarios, 19feb2021 1399-12-01 on.gph"


use "Iran.dta", clear

keep if date >= td(19feb2021) & date <= td(21apr2021)

keep ///
DayCERMeRaA00S00V00 ///
DayCERMeRaA02S01V03 ///
DayCERMeRaA03S02V07 ///
DayCERMeRaA04S00V02 ///
DayCERMeRaA05S00V02 ///
date


twoway ///
(line DayCERMeRaA00S00V00 date, sort lcolor(cyan) lwidth(vthick) lpattern(tight_dot)) /// 1 "JOHN"
(line DayCERMeRaA02S01V03 date, sort lcolor(black)) /// 2 "IHME"
(line DayCERMeRaA03S02V07 date, sort lcolor(magenta)) /// 3 "IMPE"
(line DayCERMeRaA04S00V02 date, sort lcolor(gold)) /// 4 "LANL"
(line DayCERMeRaA05S00V02 date, sort lcolor(green)) /// 5 "SRIV"
if date >= td(19feb2021) & date <= td(21apr2021) ///
, xtitle(Date) xlabel(22330 22344 22360 22374 22391, format(%tdYY-NN-DD) labsize(small)) xlabel(, grid) xlabel(, grid) ///
xlabel(, angle(forty_five)) ylabel(0(1)6, format(%12.1fc) labsize(small))  ylabel(, labsize(small) angle(horizontal)) ///
ytitle(Daily cases estimated to reported) title("COVID-19 daily cases estimated to reported, Iran, reference scenarios", size(medium)) /// 
xscale(lwidth(vthin) lcolor(gray*.2)) yscale(lwidth(vthin) lcolor(gray*.2)) legend(region(lcolor(none))) legend(bexpand) ///
legend(order(1 "JOHN" 2 "IHME" 3 "IMPE" 4 "LANL" 5 "SRIV") size(small) row(1)) ///
subtitle("after 1399-12-01, no backcasting in DELPHI", size(small)) ///
ttext(0 19feb2021  "Esf 01" 0 05mar2021  "Esf 15" 0 21mar2021  "Far 01" 0 04apr2021  "Far 15" 0 21apr2021  "Ord 01" ///
, size(small) color(black))

graph save "graph5.gph", replace
graph export "graph5.pdf", replace


export excel using "Iran graphs.xlsx", sheetmodify firstrow(variables) sheet("graph5")  


*/
*/
*/



pwd


view "log Iran Farsi graphs.smcl"

log close

exit, clear



