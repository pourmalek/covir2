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


* Details: This is a review study of estimates of COVID-19 in Iran for time period December 2020 onwards. The codes in this repository get the estimations performed by the component studies, prepare them, locate peak dates and values, and produce graphs using `Stata`. This repo can be used to replicate the results of the review study ('Computational reproducibility').


* Iteration one, here: [Rapid review of COVID-19 epidemic estimation studies for Iran]( https://bmcpublichealth.biomedcentral.com/articles/10.1186/s12889-021-10183-3)

<br/><br/>



### SUMMARY of how to use the codes in this repo

0. Save all unsaved works and files on your local machine and exit all open programs and applications. This is a cautionary measure for not losing unsaved parts of files in case the local machine stops responding or restarts due to oversaturation of RAM, CPU. Even better: Restarting the local machine (to empty the cache), invoking no program, and running the code can be more efficient than running the code on the local machine even with closing all running programs.

The whole code can be executed with less than ten clicks. 

# **Express: Run "Users\local-user-name\Downloads\covir2-main\20210405\code\master\do Iran master.do" on local machine after the directory \covir2-main\ is downloaded into and is located in the root of \Downloads\ folder of your local machine.** Read \ as / if using a Mac. Or read the follwing. 

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




* Directory structure:

Do files are located in directories: 

[`covir2`](https://github.com/pourmalek/covir2) / [`DELP`](https://github.com/pourmalek/covir2/tree/main/Data/DELP), [`GHAN`](https://github.com/pourmalek/covir2/tree/main/Data/GHAN), [`IHME`](https://github.com/pourmalek/covir2/tree/main/Data/IHME), [`IMPE`](https://github.com/pourmalek/covir2/tree/main/Data/IMPE), [`JOHN`](https://github.com/pourmalek/covir2/tree/main/Data/JOHN), [`JOHNEMR`](https://github.com/pourmalek/covir2/tree/main/Data/JOHNEMR), [`LANL`](https://github.com/pourmalek/covir2/tree/main/Data/LANL), [`SOLT`](https://github.com/pourmalek/covir2/tree/main/Data/SOLT), [`SRIV`](https://github.com/pourmalek/covir2/tree/main/Data/SRIV), [`master`](https://github.com/pourmalek/covir2/tree/main/Data/master), [`merge`](https://github.com/pourmalek/covir2/tree/main/Data/merge)

[`JOHNEMR`](https://github.com/pourmalek/covir2/tree/main/Data/JOHNEMR) looks at temporal succession of daily cases and daily deaths peaks in individual countries in Eastern Mediterranean Region (EMR), EMR as a whole, and the Global level

<br/><br/>


* **List of descriptive texts in other md files in this repo**

* For description of variable name structure used in codes, see covir2 / [`Variable name structure`](https://github.com/pourmalek/covir2/blob/main/Variable%20name%20structure.md)

* For troubleshooting possible errors returned during running the codes, see covir2 / [`troubleshooting`](https://github.com/pourmalek/covir2/blob/main/Troubleshooting.md)

* [`Frequently Asked Questions`](https://github.com/pourmalek/covir2/blob/main/FAQs.md)

<br/><br/>

### Related repositories 
* [`covir2`](https://github.com/pourmalek/covir2) is the current and main repo, contains **_codes_**, and to which are related the following:

* [`covir2-output`](https://github.com/pourmalek/covir2-output) contains a copy of previously created **_outputs_**

### * [`covir2-updates`](https://github.com/pourmalek/covir2-updates) contains periodical UPDATES for **_codes_**

### * [`covir2-output-updates`](https://github.com/pourmalek/covir2-output-updates) contains periodical UPDATES for **_outputs_**

<br/><br/>

#### Rationale for related repositories:

* Users might want to see the outputs without (or before or after) running the codes. [`covir2-output`](https://github.com/pourmalek/covir2-output) provides such outputs.

* Structures of estimates files, scenarios, and variables from component studies do change partially and periodically. Writing a universal code that is set to anticipate and intake all such future changes is doable but not cost-effective. As such, codes are periodically updated and stored in [`covir2-updates`](https://github.com/pourmalek/covir2-updates)

*  Users might want to see the outputs of updated codes without running the codes. [`covir2-output-updates`](https://github.com/pourmalek/covir2-output-updates) provides such outputs.


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



