# covir2

# COVID-19 Iran Review No 2, Stata codes

<br/><br/>


********************************************************************************************************************************************
* Project: Rapid review of estimates of COVID-19 Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10
* **OBJECTIVE** of these `Stata` codes: Get and prepare component studies' estimates for Iran, locate peak dates and values, graph estimates
********************************************************************************************************************************************

<br/><br/>

********************************************************************************************************************************************

Graphs from latest update 20210416

[COVID-19 daily deaths, Iran, reference scenarios, 2020-12-01 on](https://github.com/pourmalek/covir2/blob/main/20210416/output/merge/graph%2012a%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenarios%2C%202020-12-01%20on.pdf)

![image](https://user-images.githubusercontent.com/30849720/115594893-20d64800-a28b-11eb-89d4-8216678cb397.png)

![image](https://user-images.githubusercontent.com/30849720/115595275-94785500-a28b-11eb-858b-f6eda09cfcfb.png)








********************************************************************************************************************************************

<br/><br/>

* Details: This is a review study of estimates of COVID-19 in Iran for time period December 2020 onwards. The codes in this repository get the estimations performed by the component studies, prepare them, locate peak dates and values, and produce graphs using `Stata`. This repo can be used to replicate the results of the review study ('Computational reproducibility').


* Journal article for iteration one, here: [Rapid review of COVID-19 epidemic estimation studies for Iran]( https://bmcpublichealth.biomedcentral.com/articles/10.1186/s12889-021-10183-3)
* Journal article for iteration two (this iteration), here: (soon)
<br/><br/>


### SUMMARY of how to use the codes in this repo

0. Save all unsaved works and files on your local machine and exit all open programs and applications. This is a cautionary measure for not losing unsaved parts of files in case the local machine stops responding or restarts due to oversaturation of RAM, CPU. Even better: Restarting the local machine (to empty the cache), invoking no program, and running the code can be more efficient than running the code on the local machine even with closing all running programs.

The whole code can be executed with less than ten clicks. 

# Express: Run "Users\local-user-name\Downloads\covir2-main\20210405\code\master\do Iran master.do" on local machine after the directory \covir2-main\ is downloaded into and is located in the root of \Downloads\ folder of your local machine, for original update.
# Use "Users\local-user-name\Downloads\covir2-main\2021MMDD\code\master\do Iran master.do" for other updates.

  Read \ as / if using a Mac. Or read the follwing. 
  <br/><br/>
1. **CLICK HERE ON THIS**  [`Download ZIP`](https://github.com/pourmalek/covir2/archive/refs/heads/main.zip) **TO DOWNLOAD THE ZIPPED CODE TO YOUR LOCAL MACHINE.** 

By the way, clicking on [`Download ZIP`](https://github.com/pourmalek/covir2/archive/refs/heads/main.zip) is equivalent to clicking on the green box ![image](https://user-images.githubusercontent.com/30849720/113066810-061f2080-9170-11eb-8775-c2973d4b226d.png)
on top-right side of page https://github.com/pourmalek/covir2, then clicking on ![image](https://user-images.githubusercontent.com/30849720/113066904-35ce2880-9170-11eb-8169-793013512025.png)
on the dropdown menu. 

![image](https://user-images.githubusercontent.com/30849720/113066678-cc4e1a00-916f-11eb-8092-997db9a695c3.png)


2. Locate the file covir2-main.zip or directory covir2-main on your local machine - by default in the Downloads folder. File or directory depends on zip-file auto-inflation setting of the local machine. If it is the file covir2-main.zip, unzip and move the unzipped covir2-main directory to the root of Downloads folder. If the unzipped covir2-main directory is not located at the root of the Downloads folder, running the code will return error. Cl 2-4.

3. Locate file *"do Iran master.do"* in your local directory |Downloads|covir2-main|20210405|code|master| and run this do file. This "do Iran master.do" initiates all other codes. | denotes / for Mac or \ for Windows. Cl 5-6.

- Once all the codes have run, the final outputs would show up: "log Iran merge.smcl", and the last graph. This signifies the end of the code implementation. Graph files are stored in your local system's directory Downloads/covir2-main/20210405/code/merge/ (Mac) or Downloads\covir2-main\20210405\code\merge\ (Windows).

4. Go to your local directory |Downloads|covir2-main|20210405|code|merge|. Files "Iran.dta" and "Iran.csv" contain all the combined data. The combined graphs are stored in this directory. 

## * Farsi-dated graphs:

Files "graph 1a" to "graph 5b" stored in "Users|local-user-name|Downloads|covir2-main|20210405|code|merge|" of the local machine (your computer) will be the final graphs that use Farsi (Hijri Solar) dates. 



5. If `Stata` returns error codes, check the [`troubleshooting`](https://github.com/pourmalek/covir2/blob/main/Troubleshooting.md)

<br/><br/>

* Details of do files:

`Stata` do files get and prepare component studies' estimates for Iran, using the component studies' web pages that contain their estimates’ files - studies "SOLT" and "GHAN" graphs digitized. The file "do Iran master.do" is the only file that needs to be run. 

<br/><br/>




* Updates and directory structure:



Updates and directory structure:
<br/><br/>
1- Level 1 of directories || dates on which the current codes were updated:

[`20210405`](https://github.com/pourmalek/covir2/tree/main/20210405) --> see selected graphs here: 
[`Update 20210405 selected graphs English`](https://github.com/pourmalek/covir2/blob/main/20210405/output/Update%2020210405%20selected%20graphs%20English.pdf) [`Update 20210405 selected graphs Farsi`](https://github.com/pourmalek/covir2/blob/main/20210405/output/Update%2020210405%20selected%20graphs%20Farsi.pdf)

[`20210413`](https://github.com/pourmalek/covir2/tree/main/20210413) --> see selected graphs here: 
[`Update 20210413 selected graphs English`](https://github.com/pourmalek/covir2/blob/main/20210413/output/Update%2020210413%20selected%20graphs%20English.pdf) [`Update 20210413 selected graphs Farsi`](https://github.com/pourmalek/covir2/blob/main/20210413/output/Update%2020210413%20selected%20graphs%20Farsi.pdf)
<br/><br/>
2- Level 2 of directories || The direcory named 'code' contains Stata codes, and 'output' contains codes' output (see the output w/o running the code):

[`code`](https://github.com/pourmalek/covir2/tree/main/20210405/code) and [`output`](https://github.com/pourmalek/covir2/tree/main/20210405/output) 
<br/><br/>
3- Level 3 of directories || component studies, master, and merge:

[`DELP`](https://github.com/pourmalek/covir2/tree/main/20210405/code/DELP)  [`GHAN`](https://github.com/pourmalek/covir2/tree/main/20210405/code/GHAN)  [`IHME`](https://github.com/pourmalek/covir2/tree/main/20210405/code/IHME)  [`IMPE`](https://github.com/pourmalek/covir2/tree/main/20210405/code/IMPE)  [`JOHN`](https://github.com/pourmalek/covir2/tree/main/20210405/code/JOHN)  [`JOHNEMR`](https://github.com/pourmalek/covir2/tree/main/20210405/code/JOHNEMR) [`LANL`](https://github.com/pourmalek/covir2/tree/main/20210405/code/LANL)  [`SOLT`](https://github.com/pourmalek/covir2/tree/main/20210405/code/SOLT) 
[`SRIV`](https://github.com/pourmalek/covir2/tree/main/20210405/code/SRIV)

[`master`](https://github.com/pourmalek/covir2/tree/main/20210405/code/master) contains the master code (i.e. "do Iran master.do") to run the whole codes 

[`merge`](https://github.com/pourmalek/covir2/tree/main/20210405/code/merge) contains the combined estimates and graphs from component studies

component study directory [`JOHNEMR`](https://github.com/pourmalek/covir2/tree/main/20210405/output/JOHNEMR) looks at temporal succession of daily cases and daily deaths peaks in individual countries in Eastern Mediterranean Region (EMR), EMR as a whole, and the Global level


<br/><br/>


* **List of descriptive texts in other md files in this repo**

* For description of variable name structure used in codes, see covir2 / [`Variable name structure`](https://github.com/pourmalek/covir2/blob/main/Variable%20name%20structure.md)

* For troubleshooting possible errors returned during running the codes, see covir2 / [`troubleshooting`](https://github.com/pourmalek/covir2/blob/main/Troubleshooting.md)

* [`Frequently Asked Questions`](https://github.com/pourmalek/covir2/blob/main/FAQs.md)

<br/><br/>

<br/><br/>

### Troubleshooting, Errors, Bugs, and Vulnerabilities

* For Troubleshooting and Errors, see [`troubleshooting`](https://github.com/pourmalek/covir2/blob/main/Troubleshooting.md)

* To report an incident issue or error in running the code, create an [`issue`](https://github.com/pourmalek/covir2/issues), use [`covir2 Discussions`](https://github.com/pourmalek/covir2/discussions), or email repo owner via pourmalek_farshad@yahoo.com

* To report a Bug, use [`bug_report`](https://github.com/pourmalek/covir2/blob/main/.github/ISSUE_TEMPLATE/bug_report.md) or [`covir2 Discussions`](https://github.com/pourmalek/covir2/discussions)

* To report a Vulnerability, create an [`issue`](https://github.com/pourmalek/covir2/issues), use [`covir2 Discussions`](https://github.com/pourmalek/covir2/discussions), or email repo owner via pourmalek_farshad@yahoo.com

<br/><br/>


* All codes are copyrighted by the author under Apache License 2.0.

* See [`LICENSE`](https://github.com/pourmalek/covir2/blob/main/LICENSE)

<br/><br/>

[![DOI](https://zenodo.org/badge/344389637.svg)](https://zenodo.org/badge/latestdoi/344389637)



[`DOI`](https://zenodo.org/record/4584122#.YGPaTi295O0)



