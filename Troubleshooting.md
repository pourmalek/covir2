# Troubleshooting


Once you have started executing the downloaded code that is expected to be located in your local machine's |Downloads|covir2-main|Data|master|do Iran merge.do, `Stata` may return *ERRORs*, or may *RESTART*. The following are among possible causes and treatments. | denotes / or \ for Mac or Windows respectively. 
<br/><br/>

## KNOWN ISSUES
Déjà diagnostiqué 

<br/><br/>

********************************************************************************************************************************************
* **Problem** (1): If the *ERROR* message is about file path or directory clash, e.g., the error message reads as, -unable to change to (some directory name)-. 

* **Treatment**: Make sure the file path to directory |Data| is: 

"/Users/local-user-name/Downloads/covir2-main/Data/" [for Mac]

"C:\Users\local-user-name\Downloads\covir2-main\Data\\" [for Windows].

Manually rearrange the directories so that the expected file path leading to |Data| reads as mentioned above. 
<br/><br/>
This code is set up to work from "Users\local-user-name\Downloads\covir2-main\Data\master\do Iran master.do". Sometimes users chose destinations other than |Downloads| folder. Before editing the code, it will not work from anywhere else.
<br/><br/>
Sometime, if the downloaded zip file is unzipped manually (in Windows), there might be a possibility that the file path is not identical to the correct path, that is created after auto-inflation of the zip file and shown above. In any case, rearrange the directories so that the expected file path mentioned above leads to |Data| (in root of which is located the "do Iran master.do").   
<br/><br/>

********************************************************************************************************************************************
* **Problem** (2): If the *ERROR* message is about unavailability / unresponsiveness of a component study site server, or less frequently, web server unresponsiveness might occur during downloading `-renvars-` `Stata` command. For instance, the error message might be -r(691); I/O error- that is usually an internet connection issue. See -r(691) I/O error- on [statalist](https://www.statalist.org/forums/forum/general-stata-discussion/general/1475517-update-all-r-691-i-o-error)
* Intermittent good and bad internet connection: 
In cases where one or more component study files have been downloaded but then the internet connection fails to download a next component study file in the row of files to be downloaded, see _(4) Palliative treatment_  below.

* **Treatment**: (1) Close all running programs / applications except `Stata` and try again. (2) Try a better internet connection. (3) Try again later. 
Unresponsiveness of a component study site server (or `-renvars-` ) should be temporary, and is usually resolved in about a day. In the meanwhile, one can check the previously created results in [`covir2-output`](https://github.com/pourmalek/covir2-output) _(4) Palliative treatment_ for Intermittent good and bad internet connection: one can -// comment out- the code lines that read from internet and the files have already been successfully downloaded and then rerun the code. 

<br/><br/>

********************************************************************************************************************************************
* **Problem** (3): `Stata` spontaneously *RESTARTs* and shows start logo. If during running the codes, the demand and supply of memory needed by and available for `Stata` get critically unbalanced, it might be possible that `Stata` restarts by itself without warning and shows a fresh start logo and empty memory. 

* **Treatment**: (1) Quit all other open applications / programs until `Stata` runs the codes and the last output, that is "log Iran merge.smcl" is shown up. Even better: Restarting the local machine (to empty the cache), invoking no program, and running the code can be more efficient than running the code on the local machine even with closing all running programs. (2) Provide more memory available for older `Stata`s: In older versions of `Stata`, manually set a higher memory, e.g., `-set mem 1000m`-. In modern `Statas`, memory is no longer needed to be manually set, as memory adjustments are automatically performed.
<br/><br/>

********************************************************************************************************************************************
* **Problem** (4): With less expected frequency, your local machine might stop responding or restart, due to oversaturation of CPU and RAM. Fan noise might be heard. 
* **Treatment**: (1) If this happens during running the code while all programs except `Stata` and the web browser are NOT already closed, you may want to retry after all other programs and applications except `Stata` and the web browser are closed. (2) If this happens during running the code while all programs except `Stata` and the web browser ARE closed, the CPU and RAM of the local machine cannot afford running the code. You may want to try running the code on another computer with better CPU and RAM.



<br/><br/>
<br/><br/>


## INCIDENT ISSUES
Jamais diagnostiqué

* To report an incident issue or error in running the code, create an [`issue`](https://github.com/pourmalek/covir2/issues), use [`covir2 Discussions`](https://github.com/pourmalek/covir2/discussions), or email repo owner via pourmalek_farshad@yahoo.com

********************************************************************************************************************************************

<br/><br/>

<br/><br/>


* All codes are copyrighted by the author under Apache License 2.0.

* See [`LICENSE`](https://github.com/pourmalek/covir2/blob/main/LICENSE)

<br/><br/>
