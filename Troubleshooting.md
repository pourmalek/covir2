# Troubleshooting

### for this repository, covir2, and related repositories:

### repository [`CovidVisualizedCountry`](https://github.com/pourmalek/CovidVisualizedCountry) 

### repository [`CovidVisualizedGlobal`](https://github.com/pourmalek/CovidVisualizedGlobal)

**********

********************************************************************************************************************************************

Once you have started executing the downloaded code that is expected to be located in your local machine's |Downloads|covir2-main|20210405|code|master|do Iran merge.do, `Stata` may return *ERRORs*, or may *RESTART*. The following are among possible causes and treatments. | denotes / or \ for Mac or Windows respectively. 
<br/><br/>

## KNOWN ISSUES
Déjà diagnostiqué 

<br/><br/>


********************************************************************************************************************************************

********************************************************************************************************************************************


On 20210824, the Imperial College COVID-19 model/study removed their "old fits" – all previously released updates from day 1 up to and including IMPE update 20210719. 

This means the Imperial College COVID-19 model/study is no more a periodically updated study with ACCESSIBLE updates – short of early retirement of the study. The predictive performance of the Imperial College model is no longer assessable. 

Several thousand lines of codes that used their previously released updates will not work. 

The remedy for CovidVisualized repositories (https://github.com/pourmalek/covir2 for Iran, https://github.com/pourmalek/CovidVisualizedCountry for Canada, and https://github.com/pourmalek/CovidVisualizedGlobal for the global level) is to comment out the command line reading csv data from https://github.com/mrc-ide/global-lmic-reports/tree/master/data. 


<br/><br/> 

 
To -comment out-, 

For https://github.com/pourmalek/covir2, 

In files:

/Users/username/Downloads/covir2-main/20210806/code/master/do country master.do, _downloaded to your local machine_, 
 
where 20210806 denotes uptake 20210806 in this repository that uses IMPE update 20210719, or earlier uptake here that use earlier updates of IMPE, 

in line 130, that currently reads as:

do "$pathcovir2/IMPE/do country IMPE.do"

put // at the beginning of the line, so that it reads as:

// do "$pathcovir2/IMPE/do country IMPE.do"
 
save the do file and then run the file. 

.

For https://github.com/pourmalek/CovidVisualizedCountry, 

In files:

/Users/username/Downloads/CovidVisualizedCountry-main/20210806/code/master/do CovidVisualizedCountry master.do, _downloaded to your local machine_, 
 
where 20210806 denotes uptake 20210806 in this repository that uses IMPE update 20210719, or earlier uptake here that use earlier updates of IMPE, 

in line 124, that currently reads as:

do "$pathCovidVisualizedCountry/IMPE/do CovidVisualizedCountry IMPE.do" 

put // at the beginning of the line, so that it reads as:

// do "$pathCovidVisualizedGlobal/IMPE/do CovidVisualizedGlobal IMPE.do"
 
save the do file and then run the file. 

.

For https://github.com/pourmalek/CovidVisualizedGlobal,

In files:

/Users/username/Downloads/CovidVisualizedGlobal-main/20210727/code/master

/Users/username/Downloads/CovidVisualizedGlobal-main/20210806/code/master/do do CovidVisualizedGlobal master.do, _downloaded to your local machine_, 
 
where 20210806 denotes uptake 20210806 in this repository that uses IMPE update 20210719, or earlier uptake here that use earlier updates of IMPE, 

in line 124, that currently reads as:

do "$pathCovidVisualizedGlobal/IMPE/do CovidVisualizedGlobal IMPE.do" 

put // at the beginning of the line, so that it reads as:

// do "$pathCovidVisualizedGlobal/IMPE/do CovidVisualizedGlobal IMPE.do" 
 
save the do file and then run the file. 


<br/><br/>

********************************************************************************************************************************************

********************************************************************************************************************************************
* **Problem** (1): If the *ERROR* message is about file path or directory clash, e.g., the error message reads as, -unable to change to (some directory name)-. 

* **Treatment**: Make sure the file path to directory |code| on the local machine is: 

"/Users/local-user-name/Downloads/covir2-main/20210506/code" [for Mac]

"C:\Users\local-user-name\Downloads\covir2-main\20210506\code" [for Windows].

Manually rearrange the directories so that the expected file path leading to |code| reads as mentioned above. 
<br/><br/>
This code is set up to work from "|Users|local-user-name|Downloads|covir2-main|20210506|code|master|do Iran master.do". Sometimes users chose destinations other than |Downloads| folder. Before editing the code, it will not work from anywhere else.
<br/><br/>
Sometime, if the downloaded zip file is unzipped manually (in Windows), there might be a possibility that the file path is not identical to the correct path, that is created after auto-inflation of the zip file and shown above. In any case, rearrange the directories so that the expected file path mentioned above leads to |Data|master|do Iran master.do"   

A relatively frequent problem with unzipping in Windows is that the file path might become something like:

"C:\Users\local-user-name\Downloads\covir2-main\covir2-main\20210506\code\master\do Iran master.do"

<br/><br/>

Note: |20210401| or other later updates an be similary used instead of original |20210506|. For instance, run "|Users|local-user-name|Downloads|covir2-main|20210424|code|master|do Iran master.do" on local machine for the 20210424 update.

********************************************************************************************************************************************
* **Problem** (2): If the *ERROR* message is about unavailability / unresponsiveness of a component study site server, or less frequently, web server unresponsiveness might occur during downloading `-renvars-` `Stata` command. For instance, the error message might be -r(691); I/O error- that is usually an internet connection issue. See -r(691) I/O error- on [statalist](https://www.statalist.org/forums/forum/general-stata-discussion/general/1475517-update-all-r-691-i-o-error). For other errors regarding connecting to the Internet from within `Stata`, e.g., error -r(610);- see [common-connection-error-messages](https://www.stata.com/support/faqs/web/common-connection-error-messages/)

* Intermittent good and bad internet connection: 
In cases where one or more component study files have been downloaded but then the internet connection fails to download a next component study file in the row of files to be downloaded, see _(4) Palliative treatment_  below.

* **Treatment**: (1) Close all running programs / applications except `Stata` and try again. (2) Try a better internet connection. (3) Try again later. 
Unresponsiveness of a component study site server (or `-renvars-` ) should be temporary, and is usually resolved in about a day. In the meanwhile, one can check the previously created results in [`20210506 output`](https://github.com/pourmalek/covir2/tree/main/20210506/output) or [`20210506 output`](https://github.com/pourmalek/covir2/tree/main/20210506/output) or later outputs. _(4) Palliative treatment_ for Intermittent good and bad internet connection: one can -// comment out- the code lines that read from internet and the files have already been successfully downloaded and then rerun the code. 
<br/><br/>
********************************************************************************************************************************************
* **Problem** (3): `Stata` spontaneously *RESTARTs* and shows start logo - on a local machine using Mac OS Big Sur - this is due to a change in behavior Apple made in Big Sur, not a bug in `Stata`.

* **Treatment**: (1) Quit all other open applications / programs until `Stata` runs the codes and the last output, that is "log Iran merge.smcl" is shown up. Even better: Restarting the local machine (to empty the cache), invoking no program, and running the code can be more efficient than running the code on the local machine even with closing all running programs. (2) Provide more memory available for older `Stata`s: In older versions of `Stata`, manually set a higher memory, e.g., `-set mem 1000m`-. In modern `Statas`, memory is no longer needed to be manually set, as memory adjustments are automatically performed.
<br/><br/>
********************************************************************************************************************************************
* **Problem** (4): With less expected frequency, your local machine (OS) might stop responding or *RESTART*, due to oversaturation of RAM, CPU. Fan noise might be heard (on a PC that is not being used as a terminal connected to a crunch machine or cluster). 

* **Treatment**: (1) If this happens during running the code while all programs except `Stata` and the web browser are NOT already closed, you may want to retry after all other programs and applications except `Stata` and the web browser are closed. (2) If this happens during running the code while all programs except `Stata` and the web browser ARE closed, the RAM and CPU of the local machine cannot afford running the code. You may want to try running the code on another computer with better RAM, CPU.
<br/><br/>
********************************************************************************************************************************************
* **Problem** (5): Occasionally, some studies (e.g. IHME) might (change / alter rename / omit) the (file names, directory names, variables variable names, etc.) in one or more of their released updates after the updates were release. Occasionally, some studies (e.g. IMPE) might change the directory and files structure of their estimates release web pages. The rationale for such changes are quite understandable, similar to the situation where I also realize that occasional changes from a lowest level such as changes in variable names up to a higher level like change in directory and files structure is necessary for optimized continuation of the work process. Dependent users of sources, like this covir2 repository which is dependent on the component studies, need to adapt to the changes in the sources - as would be the case for any potential users of the covir2 repository. See [Levels of changes that might affect the uptakes here](https://github.com/pourmalek/covir2#-levels-of-changes-that-might-affect-the-uptakes-here). 

As such, the codes in this repo work as long as the updates released by component studies are not altered (not in value, but in format) or revoked, and the directory and files structure of study estimates release web pages are not altered. 

* **Treatment**: If the creator of these codes encounters such incidents during rerun of the previously created codes, the codes will be amended, or the uptake directory will be archived if necessary. If you encounter such incidents you might create an Issue, mention is Discussions or email (pourmalek_farshad@yahoo.com). 
<br/><br/>
********************************************************************************************************************************************
<br/><br/>

## INCIDENT ISSUES
Jamais diagnostiqué

* To report an incident issue or error in running the code, create an [`issue`](https://github.com/pourmalek/covir2/issues), use [`covir2 Discussions`](https://github.com/pourmalek/covir2/discussions), or 📫 email repo owner via pourmalek_farshad@yahoo.com

********************************************************************************************************************************************

<br/><br/>

<br/><br/>


* All codes are copyrighted by the author under Apache License 2.0.

* See [`LICENSE`](https://github.com/pourmalek/covir2/blob/main/LICENSE)

<br/><br/>
