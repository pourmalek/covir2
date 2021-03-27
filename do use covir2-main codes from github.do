

***************************************************************************
* This is "do use covir2-main codes from github.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10

* OBJECTIVE: Get and prepare component studies' estimates for Iran, Locate peak dates and values
***************************************************************************


* Objective of this "do use covir2-main codes from github.do" is,

* , to use Stata to download the covir2-main codes to the local machine and execute them.

* This do file is set to be executed _from Downloads folder_ of the local machine.


cd 

cd Downloads 


clear

copy https://github.com/pourmalek/covir2/archive/refs/heads/main.zip main.zip

unzipfile main.zip, replace
erase main.zip


cd covir2-main

cd Data

cd master

do "do Iran master.do"










