# covir2



### Combine and visualize international periodically updating estimates of COVID-19 

### <div align="center"> at the country level, countries without subnational level estimates 
 
## <div align="center"> :iran: Iran 

## <div align="center"> covir2 = COVID Iran review number 2
 
 
  *****************************
  
#### :eyes: SEE graphs, code, and data of periodical updates of COVID-19 epidemic models’ estimates: 
  
#### [Delphi](https://covidanalytics.io/projections), [IHME](https://covid19.healthdata.org/canada?view=daily-deaths&tab=trend), [Imperial college](https://github.com/mrc-ide/global-lmic-reports/blob/master/CAN/2021-06-18/index.pdf), [Los Alamos](https://covid-19.bsvgateway.org), and [Srivastava](https://scc-usc.github.io/ReCOVER-COVID-19/#/), 
  
#### for daily (and total) [deaths](https://github.com/pourmalek/covir2#graph-4-iran---daily-deaths-2021-reference-scenario-with-uncertainty-ihme), [cases](https://github.com/pourmalek/covir2#graph-8-iran---daily-cases-or-infections-2021), [infections](https://github.com/pourmalek/covir2#graph-7-iran---daily-cases-or-infections-all-time), and [hospitalizations](https://github.com/pourmalek/covir2#graph-10-iran---hospital-related-outcomes-2021),
  
#### for Iran
 
#### or other countries via code adjustment, e.g., [Afghanistan](https://github.com/pourmalek/covir2/tree/main/ADAPTATIONS_EXAMPLES/Afghanistan_%2020210625/20210625), [Pakistan](https://github.com/pourmalek/covir2/tree/main/ADAPTATIONS_EXAMPLES/Pakistan_20210704)

 
 
 
 
********************************************************************************************************************************************
********************************************************************************************************************************************
* Project: Combine and visualize international periodically updating estimates of COVID-19 at the country level (CovidVisualizedCountry) Countries without subnational estimates: Iran
* Project name at conception: Rapid review of estimates of COVID-19 Iran - No 2
* Person: Farshad Pourmalek (pourmalek_farshad at yahoo dot com)   [![Orcid](https://info.orcid.org/wp-content/uploads/2019/11/orcid_16x16.png)](https://orcid.org/0000-0002-2134-0771)    [`PubMed`](https://pubmed.ncbi.nlm.nih.gov/?term=Pourmalek+F&sort=pubdate&size=200)
* Time (initial): 2021-02-10
********************************************************************************************************************************************
******************************************************************************************************************************************** 
 
 <br/><br/>

 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 
### Related repositories:

THREE “CovidVisualized” repositories, use a common template and logic for visualization of the results of estimates of FIVE international and periodically updating COVID-19 models for the future of the epidemic:

[`CovidVisualizedGlobal`]( https://github.com/pourmalek/CovidVisualizedGlobal) for the [`GLOBAL`](https://github.com/pourmalek/CovidVisualizedGlobal#covidvisualizedglobal) level

[`CovidVisualizedCountry`](https://github.com/pourmalek/CovidVisualizedCountry) for countries with subnational estimates: [`CANADA`](https://github.com/pourmalek/CovidVisualizedCountry#covidvisualizedcountry)

[`covir2`](https://github.com/pourmalek/covir2) for countries without subnational estimates: [`IRAN`](https://github.com/pourmalek/covir2#covir2)

These results in these three repositories get periodically updated. 

The codes in these repositories can be adapted for use for any country or region in the world. 
 
* For a sample application of “covir2” to a country without subnational estimates see [`Afghanistan`](https://github.com/pourmalek/covir2/blob/main/ADAPTATIONS_EXAMPLES/Afghanistan_%2020210625/20210625/README.md) 
 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  


<br/><br/>
 
   
********************************************************************************************************************************************  
  *
## Notice: Nomenclature CORRECTION is being applied: 
  
### IHME and IMPE estimate INFECTIONS (not CASES). 
  
#### Their Case Fatality Ratio (CFR) -> Infection Fatality ratio (IFR).
 
Has been performed for [`Iran 20210625`](https://github.com/pourmalek/covir2/tree/main/20210625) and [`Afghanistan 20210625`](https://github.com/pourmalek/covir2/tree/main/ADAPTATIONS_EXAMPLES/Afghanistan_%2020210625/20210625)

  *
********************************************************************************************************************************************   
  
 
 
 
# TOC

[I. SELCTED GRAPHS FROM LATEST UPTAKE](https://github.com/pourmalek/covir2#i-selcted-graphs-from-latest-uptake)

[II. METHODS AND RESULTS OF THIS WORK](https://github.com/pourmalek/covir2#ii-methods-and-results-of-this-work)

[III. INNER WORKS OF THIS REPOSITORY](https://github.com/pourmalek/covir2#iii-inner-works-of-this-repository)

[IV. SELCTED GRAPHS FROM PREVIOUS UPTAKES](https://github.com/pourmalek/covir2#iv-selcted-graphs-from-previous-uptakes)
****

********************************************************************************************************************************************
### Merged graphs of uptake 20210618 [here](https://github.com/pourmalek/covir2/blob/main/20210618/graphs%20merged%2020210618.pdf)

********************************************************************************************************************************************
  
********************************************************************************************************************************************
  
********************************************************************************************************************************************
****

## I. SELCTED GRAPHS FROM LATEST UPTAKE
<br/><br/>

********************************************************************************************************************************************
********************************************************************************************************************************************

 
#### LATEST UPTAKE: uptake 20210704
 
#### DELP 20210704, IHME 20210702, **_IMPE 20210626_**, LANL 20210704, SRIV 20210704 
 

 
 
****

(1) [Daily deaths, all time](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2011%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677648-c43ffd80-de75-11eb-9454-64cd4a06b67f.png)

****

(2) [Daily deaths, 2021](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2012%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenarios.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677690-da4dbe00-de75-11eb-8c45-c92e7a1e30d9.png)

****

(3) [Daily deaths, 2021, reference scenario with uncertainty, IHME](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2014%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenario%20with%20uncertainty%2C%20IHME.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677735-ee91bb00-de75-11eb-84b5-04841d1cfd0a.png)

****

(4) [Daily deaths, 2021, 3 scenarios, IHME](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2015%20COVID-19%20daily%20deaths%2C%20Iran%2C%203%20scenarios%2C%20IHME.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677793-0701d580-de76-11eb-8680-15eee5bedb39.png)

****

(5) [Daily deaths, 2021, reference scenario with uncertainty, IMPE](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2016%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenario%20with%20uncertainty%2C%20IMPE.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677827-1bde6900-de76-11eb-8aa8-04e33bd6b8ab.png)

****

(6) [Daily deaths, 2021, 3 scenarios, IMPE](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2017%20COVID-19%20daily%20deaths%2C%20Iran%2C%203%20scenarios%2C%20IMPE.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677876-34e71a00-de76-11eb-87b9-2657c903d8ed.png)

****

(7) [Daily cases or infections, all time](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2021%20COVID-19%20daily%20cases%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677915-4b8d7100-de76-11eb-9643-148227f8efc7.png)
  
****

(8) [Daily cases or infections, 2021](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2022%20COVID-19%20daily%20cases%2C%20Iran%2C%20reference%20scenarios.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677956-6233c800-de76-11eb-9566-45df7d8d3f25.png)
  
****

(9) [Hospital-related outcomes, all time](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2071%20COVID-19%20hospital-related%20outcomes%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677986-77105b80-de76-11eb-921e-67f9d0f27004.png)

****

(10) [Hospital-related outcomes, 2021](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2072%20COVID-19%20hospital-related%20outcomes%2C%20wo%20extremes%2C%202021.pdf)

![image](https://user-images.githubusercontent.com/30849720/124678012-8b545880-de76-11eb-8c86-35d258573497.png)

****

(11) [Daily deaths estimated to reported, all time](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2091%20COVID-19%20daily%20deaths%20estimated%20to%20reported%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124678053-a2934600-de76-11eb-99d4-f63f37beba0b.png)
  
****

(12) [Daily cases or infections estimated to reported cases, 2021](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2094%20COVID-19%20daily%20cases%20estimated%20to%20reported%2C%20Iran%2C%20reference%20scenarios.pdf) 

![image](https://user-images.githubusercontent.com/30849720/124678088-b8087000-de76-11eb-8952-8b97e4088f6d.png)
  
****
 
 
 

********************************************************************************************************************************************
********************************************************************************************************************************************
********************************************************************************************************************************************
********************************************************************************************************************************************


## II. METHODS AND RESULTS OF THIS WORK
<br/><br/>


**SUMMARY**
  
Five international and periodically updating models of COVID-19 pandemic are identified and the results of their estimates are gathered, combined, and graphed for the progression of the pandemic at the country level. Periodical releases of these studies’ estimates undergo processing and visualization in this repository.  
<br/><br/>

  
**BACKGROUND**

The idea put to work here is to combine and visualize international periodically updating studies / models of COVID-19 pandemic, for the global level. The end result being sharable codes and outputs, for estimates files and graphs, for individual studies, and for combination of them, and repeat the process periodically. 
<br/><br/>
  
**METHODS**

Eligibility for target (component) studies (models) of COVID-19 pandemic, are set as those that (1) provide estimates for at least one of the four outcomes of interests, i.e., daily deaths, daily incident cases, cumulative (total) deaths, and cumulative (total) incident cases, (2) at the global level, (3) as sum of estimates at the country level, (4) periodically updating into 2021, (5) provide a list of input data and their sources, and (6) provide explanation on methods of using input data and generation of model outputs. 

Target studies were found via hand search using google. After “Additional file 1 of Rapid review of COVID-19 epidemic estimation studies for Iran”, Page 39, [here](https://s3-eu-west-1.amazonaws.com/pstorage-npg-968563215/26271814/12889_2021_10183_MOESM1_ESM.docx)

Methods generally follow, with alterations, this article: Pourmalek F, Rezaei Hemami M, Janani L, Moradi-Lakeh M. Rapid review of COVID-19 epidemic estimation studies for Iran. BMC Public Health. 2021 Feb 1;21(1):257. doi: 10.1186/s12889-021-10183-3. https://bmcpublichealth.biomedcentral.com/articles/10.1186/s12889-021-10183-3
<br/><br/>

**RESULTS**
<br/><br/>


**RESULTS, (A) Studies:**
<br/><br/>

Five studies (models) meeting the eligibility criteria: DELP, IHME, IMPE, LANL, SRIV, details below. Results of estimates for each study are stored in Stata data files and graphs. Results for combination of all five studies’ estimates are also are stored in data files and combined graphs. 
<br/><br/>

(1) DELP  
. DELP = DELPHI: Differential Equations Lead to Predictions of Hospitalizations and Infections  
. Citation: COVID Analytics. DELPHI epidemiological case predictions. Cambridge: Operations Research Center, Massachusetts Institute of Technology. https://www.covidanalytics.io/projections  
. Study website: https://www.covidanalytics.io/projections  
. Estimates web site: https://www.covidanalytics.io/projections, down the page, link that reads, "Download Most Recent Predictions"  
. License: https://github.com/COVIDAnalytics/DELPHI/blob/master/LICENSE  
. Institution: Operations Research Center, Massachusetts Institute of Technology, Cambridge  
. Among articles: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7883965/ , https://www.medrxiv.org/content/10.1101/2020.06.23.20138693v1, https://www.covidanalytics.io/DELPHI_documentation_pdf  
. Periodically updating: Yes   
. Periodical updates accessible: No  
  
(2) IHME
. IHME = Institute for Health Metrics and Evaluation  
. Citation: Institute for Health Metrics and Evaluation (IHME). COVID-19 mortality, infection, testing, hospital resource use, and social distancing projections. Seattle: Institute for Health Metrics and Evaluation (IHME), University of Washington. http://www.healthdata.org/covid  
. Study web site: http://www.healthdata.org/covid  
. Estimates web site: http://www.healthdata.org/covid/data-downloads  
. License: http://www.healthdata.org/about/terms-and-conditions  
. Institution: IHME, University of Washington, Seattle   
. Among articles: https://www.nature.com/articles/s41591-020-1132-9  
. Periodically updating: Yes  
. Periodical updates accessible: Yes  
  
(3) IMPE  
. IMPE = Imperial College  
. Citation: MRC Centre for Global Infectious Disease Analysis (MRC GIDA). Future scenarios of the healthcare burden of COVID-19 in low- or middle-income countries. London: MRC Centre for Global Infectious Disease Analysis, Imperial College London. https://mrc-ide.github.io/global-lmic-reports/  
. Study web site: https://mrc-ide.github.io/global-lmic-reports/  
. Estimates web site: https://github.com/mrc-ide/global-lmic-reports/tree/master/data  
. License: https://github.com/mrc-ide/global-lmic-reports  
. Institution: Imperial College, London  
. Among articles: https://science.sciencemag.org/content/369/6502/413  
. Periodically updating: Yes  
. Periodical updates accessible: Yes  
  
(4) LANL  
. LANL = Los Alamos National Laboratories  
. Citation: Los Alamos National Laboratory (LANL). COVID-19 cases and deaths forecasts. Los Alamos: Los Alamos National Laboratory (LANL). https://covid-19.bsvgateway.org  
. Study web site: https://covid-19.bsvgateway.org  
. Estimates web site: https://covid-19.bsvgateway.org, Model Outputs, Global  
. License: https://covid-19.bsvgateway.org  
. Institution: Los Alamos National Laboratories, Los Alamos  
. Among documents: https://covid-19.bsvgateway.org/static/COFFEE-methodology.pdf  
. Periodically updating: Yes  
. Periodical updates accessible: Yes  
  
(5) SRIV  
. SRIV = Srivastava, Ajitesh  
. Citation: University of Southern California (USC). COVID-19 forecast. Los Angeles: University of Southern California. https://scc-usc.github.io/ReCOVER-COVID-19  
. Study web site: https://scc-usc.github.io/ReCOVER-COVID-19/  
. Estimates web site: https://github.com/scc-usc/ReCOVER-COVID-19/tree/master/results/historical_forecasts  
. License: https://github.com/scc-usc/ReCOVER-COVID-19/blob/master/LICENSE  
. Institution: University of Southern California, Los Angeles  
. Among articles: https://arxiv.org/abs/2007.05180  
. Periodically updating: Yes  
. Periodical updates accessible: Yes  
  
(0) JOHN  
. JOHN = Johns Hopkins University. Coronavirus resource center. https://coronavirus.jhu.edu  
. Not a target study, but a benchmark for comparison.  
. Citation: "COVID-19 Data Repository by the Center for Systems Science and Engineering (CSSE) at Johns Hopkins University"  
. Study web site: https://coronavirus.jhu.edu  
. Estimates web site: https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series , "COVID-19 Data Repository by the Center for Systems Science and Engineering (CSSE) at Johns Hopkins University"  
. License: https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series  
. Institution: Johns Hopkins University, Baltimore  
. Among articles: Dong E, Du H, Gardner L. An interactive web-based dashboard to track COVID-19 in real time. Lancet Infect Dis. 2020 May;20(5):533-534. doi: 10.1016/S1473-3099(20)30120-1. Epub 2020 Feb 19.  
. Periodically updating: Yes   
. Periodical updates accessible: Yes  
<br/><br/>

  
**RESULTS, (B) Periodical updates of component studies:** 
<br/><br/>

Periodical updates of component studies are performed here according to release of new estimates updates by the two studies with less frequent estimates updates releases, i.e., IHME and IMPE. LANL updates every 3-4 days, SRIV every day, and DELP updates frequency is not discoverable to me. With each update release by IHME or IMPE, the whole set of five studies’ estimates updates are processed (updated here) and the results are stored in a directory named after the calendar date on which update was performed. 
<br/><br/>
  
**RESULTS, (C) Longitudinal visualization of component studies’ estimates updates:**

Within each study, estimates for any given person-place-time unit – that is any specific outcome (e.g., daily deaths), any given location (e.g., the global level), and given calendar time period (e.g., May 2021) – might vary (in terms of height and trajectory of outcome estimates), across consecutive releases of updated estimates. Analysis of such variations should – based on my understanding – reflect that the largest proportion of variance originates from the use of new data input to the model. This is true across all-time variations. Other sources of variation include input of new data types to the model, and less frequently, major and minor updates in the modeling process, that are known as “model version”, and are quite distinct from “model estimates updates”. Based on such variation of model estimates updates for any given person-place-time unit, looking at the estimates of the same person-place-time unit across consecutive model estimates updates of any given model might be expected to provide additional insight about how model estimates evolve along with progression of the pandemic. This leads to longitudinal view of component studies’ estimates updates: e.g., look at IHME estimates for daily global deaths for May 2021 across consecutive IHME estimates releases. Timing of longitudinal visualization is set for the end of each calendar month, to minimize the role of calendar time as source of the above-described variation. 
<br/><br/>

**LIMITATIONS**
<br/><br/>

The search for target studies is not performed in a replicable method. A systematic review might reveal more target studies that meet the eligibility criteria. Software codes use a propriety software package. Use of  R or Phyton are preferable in terms of user accessibility. 

<br/><br/>
  
**FUTURE DIRECTIONS AND COLLABOATIONS** 
<br/><br/>

The idea of this work originated from looking at estimates for COVID-19 epidemic in one location, Iran, in repository covir2. Then I thought about creating a template that can be used for any location and its sub-locations – from global level, to regional (e.g., continents, WHO regions, GBD regions, etc.), national, and subnational levels (where available). Also thought about a visualization hub, that creates (combined results and) graphs for all locations for which COVID-19 estimates are available via the international periodically updating models. For writing the code, I lack the knowledge and experience with Python to do the job. I am looking for suggestions, collaboration, and help; please e-mail me (pourmalek_farshad@yahoo.com)
<br/><br/>

********************************************************************************************************************************************
********************************************************************************************************************************************

## III. INNER WORKS OF THIS REPOSITORY 

The Stata _codes_ can be executed on local machines:

Run in Stata "Users|local-user-name|Downloads|GlobalCovidCombineVisualizeCombineVisualize-main|20210428|code|master|do GlobalCovidCombineVisualizeCombineVisualizemaster.do" on local machine after the directory |GlobalCovidCombineVisualizeCombineVisualize-main| is downloaded into and is located in the root of |Downloads| folder of your local machine, for update 20210428; and later instances of 202YMMDD for later updates.  

Preproduced _outputs_ are stored for each update, e.g., [`20210428`](https://github.com/pourmalek/ GlobalCovidCombineVisualizeCombineVisualize /tree/main/20210428), in folder [`output`](https://github.com/pourmalek/ GlobalCovidCombineVisualizeCombineVisualize /tree/main/20210428/output), for each component study, i.e. [`DELP`](https://github.com/pourmalek/ GlobalCovidCombineVisualizeCombineVisualize /tree/main/20210428/output/DELP), [`IHME`](https://github.com/pourmalek/GlobalCovidCombineVisualize/tree/main/20210428/output/IHME), [`IMPE`](https://github.com/pourmalek/ GlobalCovidCombineVisualizeCombineVisualize /tree/main/20210428/output/IMPE), [`LANL`](https://github.com/pourmalek/GlobalCovidCombineVisualize/tree/main/20210428/output/LANL), and [`SRIV`](https://github.com/pourmalek/GlobalCovidCombineVisualize/tree/main/20210428/output/SRIV), plus [`JOHN`](https://github.com/pourmalek/GlobalCovidCombineVisualize/tree/main/20210428/output/JOHN) as benchmark. Combined results stored in [`merge`](https://github.com/pourmalek/GlobalCovidCombineVisualize/tree/main/20210428/output/merge). 

[`longitudinal`](https://github.com/pourmalek/GlobalCovidCombineVisualize/tree/main/longitudinal) assessment of models will be added later. 

Selected _graphs_ are shown below. 

_Component studies and their scenarios_ are mentioned below after the selected _graphs_.

[`Variable name structure`](https://github.com/pourmalek/GlobalCovidCombineVisualize/blob/main/Variable%20name%20structure.md)

[`Troubleshooting`](https://github.com/pourmalek/GlobalCovidCombineVisualize/blob/main/Troubleshooting.md)



### Scenario number within component study


[Names within brackets assigned by this review study.]

#### A00 JOHN
* S00 = [Not Applicable]
<br/><br/>

#### A01 DELP
* S00 = [Single scenario]
<br/><br/>

#### A02 IHME
* S01 = Reference scenario [Status Quo] 
* S02 = Best scenario (Universal masks) [Best]
* S03 = Worse scenario (Mandates easing) [Worst] 
<br/><br/>

#### A03 IMPE
* S01 = Additional 50% Reduction [Best]	
* S02 = Current level of interventions [Reference] 			
* S03 = Relax Interventions 50% [Worst]
* S04 = Surged Additional 50% Reduction [Best, Surged]
* S05 = Surged Maintain Status Quo [Reference, Surged] 	
* S06 = Surged Relax Interventions 50% [Worst, Surged]	
<br/><br/>

#### A04 LANL
* S00 = [Single scenario]
<br/><br/>

#### A05 SRIV
* S00 = [current]
* Note: SRIV has 3 sets of scenrios, here (add). 
<br/><br/>



### uptakes in this repository, since April 2021 


**bold fonts** show the uptake was triggered by IHME or IMPE. 

.

(uptake number) uptake date: study update date, study update date

.
 
 
 
 
(24) uptake 20210704: DELP 20210704, IHME 20210702, **_IMPE 20210626_**, LANL 20210704, SRIV 20210704 
 
(23) uptake 20210703: DELP 20210703, **_IHME 20210702_**, IMPE 20210618, LANL 20210627, SRIV 20210703 
 
(22) uptake 20210625: DELP 20210625, **_IHME 20210625_**, IMPE 20210618, LANL 20210613, SRIV 20210624 

(21) uptake 20210624: DELP 20210624, IHME 20210618, **_IMPE 20210618_**, LANL 20210613, SRIV 20210624 
 
(20) uptake 20210618: DELP 20210618, **_IHME 20210618_**, IMPE 20210611, LANL 20210613, SRIV 20210618 
 
(19) uptake 20210611: DELP 20210611, IHME 20210610, **_IMPE 20210611_**, LANL 20210606, SRIV 20210611 
 
(18) uptake 20210610: DELP 20210610, **_IHME 20210610_**, IMPE 20210604, LANL 20210606, SRIV 20210610
 
(17) uptake 20210605: DELP 20210604, IHME 20210604, **_IMPE 20210604_**, LANL 20210602, SRIV 20210605, UCLA 20210507
 
(16) uptake 20210604: DELP 20210604, **_IHME 20210604_**, IMPE 20210527, LANL 20210602, SRIV 20210604, UCLA 20210507 
 
(15) uptake 20210603: DELP 20210603, IHME 20210528, **_IMPE 20210527_**, LANL 20210526, SRIV 20210603, UCLA 20210507 
 
(14) uptake 20210528: DELP 20210528, **_IHME 20210528_**, IMPE 20210522, LANL 20210526, SRIV 20210528, UCLA 20210507
 
(13) uptake 20210522: DELP 20210522, IHME 20210521, **_IMPE 20210522_**, LANL 20210519, SRIV 20210522 
 
(12) uptake 20210521: DELP 20210521, **_IHME 20210521_**, IMPE 20210516, LANL 20210519, SRIV 20210521  
 
(11) uptake 20210516: DELP 20210516, IHME 20210514, **_IMPE 20210516_**, LANL 20210516, SRIV 20210516 
 
(10) uptake 20210515: DELP 20210515, IHME 20210514, **_IMPE 20210510_**, LANL 20210512, SRIV 20210515  
 
(09) uptake 20210514: DELP 20210514, **_IHME 20210514_**, IMPE 20210424, LANL 20210512, SRIV 20210514
 
(00) uptake 20210507: DELP 20210507, **_IHME 20210507_**, IMPE 20210424, LANL 20210505, SRIV 20210507. IHME update 20210507 spirited away after release. 
 
(08) uptake 20210506: DELP 20210506, **_IHME 20210506_**, IMPE 20210424, LANL 20210505, SRIV 20210506 
 
(00) uptake 20210430: DELP 20210430, **_IHME 20210430_**, IMPE 20210424, LANL 20210428, SRIV 20210430. IHME update 20210430 spirited away after release. 
 
(07) uptake 20210424: DELP 20210424, IHME 20210422, **_IMPE 20210424_**, LANL 20210421, SRIV 20210424 
 
(06) uptake 20210422: DELP N20210422, **_IHME 20210422_**, IMPE 2010417, LANL 20210421, SRIV 20210422
 
(05) uptake 20210417: DELP 20210417, IHME 20210416, **_IMPE 20210417_**, LANL 20210414, SRIV 20210417 
 
(04) uptake 20210416: DELP 20210416, **_IHME 20210416_**, IMPE 20210406, LANL 20210414, SRIV 20210416 
 
(03) uptake 20210409: DELP 20210409, **_IHME 20210409_**, IMPE 20210406, LANL 20210407, SRIV 20210409 
  
(02) uptake 20210406: DELP 20210406, IHME 20210401, **_IMPE 20210406_**, LANL 20210404, SRIV 20210406

(01) uptake 20210401: DELP 20210401, **_IHME 20210401_**, IMPE 20210329, LANL 20210331, SRIV 20210401


********************************************************************************************************************************************
********************************************************************************************************************************************

## IV. SELCTED GRAPHS FROM PREVIOUS UPTAKES
  
### List of graphs  
  
[graph (1) Daily deaths, reference scenarios, all time](https://github.com/pourmalek/covir2#graph-1-iran---daily-deaths-reference-scenarios-all-time)

[graph (2) Daily deaths, reference scenarios, 2021](https://github.com/pourmalek/covir2#graph-2-iran---daily-deaths-reference-scenarios-2021) 
  
[graph (3) Daily deaths, 2021, reference scenario with uncertainty, IHME, 2021](https://github.com/pourmalek/covir2#graph-3-iran---daily-deaths-2021-reference-scenario-with-uncertainty-ihme)
  
[graph (4) Iran - Daily deaths, 2021, reference scenario with uncertainty, IHME](https://github.com/pourmalek/covir2#graph-4-iran---daily-deaths-2021-reference-scenario-with-uncertainty-ihme)
  
[graph (5) Iran - Daily deaths, 2021, reference scenario with uncertainty, IMPE](https://github.com/pourmalek/covir2#graph-5-iran---daily-deaths-2021-reference-scenario-with-uncertainty-impe) 
 
[graph (6) Iran - Daily deaths, 2021, 3 scenarios, IMPE](https://github.com/pourmalek/covir2#graph-6-iran---daily-deaths-2021-3-scenarios-impe) 

[graph (7) Iran - Daily cases or infections, all time](https://github.com/pourmalek/covir2#graph-7-iran---daily-cases-or-infections-all-time) 
 
[graph (8) Iran - Daily cases or infections, 2021](https://github.com/pourmalek/covir2#graph-8-iran---daily-cases-or-infections-2021) 
 
[graph (9) Iran - Hospital-related outcomes, all time](https://github.com/pourmalek/covir2#graph-9-iran---hospital-related-outcomes-all-time) 
 
[graph (10) Iran - Hospital-related outcomes, 2021](https://github.com/pourmalek/covir2#graph-10-iran---hospital-related-outcomes-2021) 
 
[graph (11) Iran - Daily deaths estimated to reported, all time](https://github.com/pourmalek/covir2#graph-11-iran---daily-deaths-estimated-to-reported-all-time) 
 
[graph (12) Iran - Daily cases or infections estimated to reported cases, 2021](https://github.com/pourmalek/covir2#graph-12-iran---daily-cases-or-infections-estimated-to-reported-cases-2021) 

****
    
### Logical order of graphs

1.	Location level: National, followed by 3 select provinces (two most affected, and BC)
  
    . To follow prediction for the national level, and further examine if province-level increases are predicted
  
2.	Uptake date: Most recent uptake, followed by less recent uptakes
  
    . To examine changes in predictions across consecutive uptakes
  
3.	Outcomes: Daily deaths, Daily cases or infections, Hospital-related outcomes, Daily deaths estimated to reported, Daily cases or infections estimated to reported cases.
  
    . To examine different outcomes with different public health consequences and model performance implications
  
4.	Calendar time of estimates coverage: All-time, followed by 2021
  
    . To view the whole epidemic trajectory, and further focus on near future
  
5.	Scenarios: Reference scenarios, followed by alternative scenarios
  
    . To examine the main (aka. status quo) scenario, and alternative (better and worse) scenarios
  
6.	Models: Different models within each graph (for which model estimates update release dates are maximally synchronized), plus official reports of the country to WHO (curated by Johns Hopkins university) as under-reported benchmark for trends 
  
    . To examine how heterogeneity in methods used by different models results in heterogenous results for the same outcome (same time-place-person aggregated units)
  
7. Graphs for other outcomes (e.g., Total deaths) are stored individually in [`/merge/`](https://github.com/pourmalek/covir2/tree/main/20210704/output/merge) directory https://github.com/pourmalek/covir2/tree/main/20210704/output/merge, and stored in a single file ["graphs merge 20210704.pdf"](https://github.com/pourmalek/covir2/blob/main/20210704/graphs%20merged%2020210704.pdf)  https://github.com/pourmalek/covir2/blob/main/20210704/graphs%20merged%2020210704.pdf (and similar files, e.g., with /[`20210401`]https://github.com/pourmalek/covir2/blob/main/20210401/graphs%20merged%20uptake%2020210401.pdf)/), where /20210704/ denotes the uptake date. Graphs include all the provinces and territories available in JOHN, DELP, and IHME. Graphs from individual models are stored in study namesake directories, e.g., [`20210704/output/IHME`](https://github.com/pourmalek/CovidVisualizedCountry/tree/main/20210704/output/IHME)  

  
  
  
<br/><br/>



### Selected graphs - Iran
  
**** 
****  
  
********************************************************************************************************************************************

#### graph (1) Iran - Daily deaths, reference scenarios, all time 

 
 
 
 
*
 
uptake 20210704: DELP 20210704, IHME 20210702, **_IMPE 20210626_**, LANL 20210704, SRIV 20210704 
 
(1) [Daily deaths, all time](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2011%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677648-c43ffd80-de75-11eb-9454-64cd4a06b67f.png)
 
* 
 
uptake 20210703: DELP 20210703, **_IHME 20210702_**, IMPE 20210618, LANL 20210627, SRIV 20210703  

(1) [Daily deaths, all time](https://github.com/pourmalek/covir2/blob/main/20210703/output/merge/graph%2011%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124501527-92943d00-dd76-11eb-8d04-9f7c314d96ff.png)
 
* 

uptake 20210625: DELP 20210625, **_IHME 20210625_**, IMPE 20210618, LANL 20210613, SRIV 20210624 
 
(1) [Daily deaths, all time](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2011%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124479220-ea24af80-dd5a-11eb-8c9a-f5dda0124941.png)
 
* 
 
uptake 20210624: DELP 20210624, IHME 20210618, **_IMPE 20210618_**, LANL 20210613, SRIV 20210624 
 
(1) [Daily deaths, all time](https://github.com/pourmalek/covir2/blob/main/20210624/output/merge/graph%2011%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124546133-09fdb700-dddf-11eb-8df8-deb7883f176a.png)
 
*
 
uptake 20210618: DELP 20210618, **_IHME 20210618_**, IMPE 20210611, LANL 20210613, SRIV 20210618 
 
(1) [Daily deaths, all time](https://github.com/pourmalek/covir2/blob/main/20210618/output/merge/graph%2011%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124673288-70311b00-de6d-11eb-8859-a47c519fc157.png)
 
* 
 
 
 
 
 
 
 
 
 
 
 
 
 
********************************************************************************************************************************************
 
#### graph (2) Iran - Daily deaths, reference scenarios, 2021

 
 
 
 
*
 
uptake 20210704: DELP 20210704, IHME 20210702, **_IMPE 20210626_**, LANL 20210704, SRIV 20210704 
 
(2) [Daily deaths, 2021](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2012%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenarios.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677690-da4dbe00-de75-11eb-8c45-c92e7a1e30d9.png)
 
* 
 
uptake 20210703: DELP 20210703, **_IHME 20210702_**, IMPE 20210618, LANL 20210627, SRIV 20210703   

(2) [Daily deaths, 2021](https://github.com/pourmalek/covir2/blob/main/20210703/output/merge/graph%2012%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenarios.pdf)

![image](https://user-images.githubusercontent.com/30849720/124501564-a8096700-dd76-11eb-9864-058c5eb14c44.png)
 
* 

uptake 20210625: DELP 20210625, **_IHME 20210625_**, IMPE 20210618, LANL 20210613, SRIV 20210624 
 
(2) [Daily deaths, 2021](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2012%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenarios.pdf)

![image](https://user-images.githubusercontent.com/30849720/124479420-1b9d7b00-dd5b-11eb-9842-ffe0ae8d8337.png)
 
* 
 
uptake 20210624: DELP 20210624, IHME 20210618, **_IMPE 20210618_**, LANL 20210613, SRIV 20210624 
 
(2) [Daily deaths, 2021](https://github.com/pourmalek/covir2/blob/main/20210624/output/merge/graph%2012%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenarios.pdf)

![image](https://user-images.githubusercontent.com/30849720/124546269-3a455580-dddf-11eb-9535-4c5bd39b3d22.png)
 
*
 
uptake 20210618: DELP 20210618, **_IHME 20210618_**, IMPE 20210611, LANL 20210613, SRIV 20210618 
 
(2) [Daily deaths, 2021](https://github.com/pourmalek/covir2/blob/main/20210618/output/merge/graph%2012%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenarios.pdf)

![image](https://user-images.githubusercontent.com/30849720/124673338-8a6af900-de6d-11eb-8f0d-4d95b3ffb0b5.png)
 
* 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
********************************************************************************************************************************************
 
#### graph (3) Iran - Daily deaths, 2021, reference scenario with uncertainty, IHME
 
 
 
 
 
*
 
uptake 20210704: DELP 20210704, IHME 20210702, **_IMPE 20210626_**, LANL 20210704, SRIV 20210704 
 
(3) [Daily deaths, 2021, reference scenario with uncertainty, IHME](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2014%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenario%20with%20uncertainty%2C%20IHME.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677735-ee91bb00-de75-11eb-84b5-04841d1cfd0a.png)
 
* 

uptake 20210703: DELP 20210703, **_IHME 20210702_**, IMPE 20210618, LANL 20210627, SRIV 20210703  
 
(3) [Daily deaths, 2021, reference scenario with uncertainty, IHME](https://github.com/pourmalek/covir2/blob/main/20210703/output/merge/graph%2014%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenario%20with%20uncertainty%2C%20IHME.pdf)

![image](https://user-images.githubusercontent.com/30849720/124501617-c1aaae80-dd76-11eb-8eaf-231cc8eb1839.png)

* 

uptake 20210625: DELP 20210625, **_IHME 20210625_**, IMPE 20210618, LANL 20210613, SRIV 20210624 
 
(3) [Daily deaths, 2021, reference scenario with uncertainty, IHME](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2014%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenario%20with%20uncertainty%2C%20IHME.pdf)

![image](https://user-images.githubusercontent.com/30849720/124489074-7340e400-dd65-11eb-82fa-7d585cea5710.png)
 
* 
 
uptake 20210624: DELP 20210624, IHME 20210618, **_IMPE 20210618_**, LANL 20210613, SRIV 20210624 
 
(3) [Daily deaths, 2021, reference scenario with uncertainty, IHME](https://github.com/pourmalek/covir2/blob/main/20210624/output/merge/graph%2014%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenario%20with%20uncertainty%2C%20IHME.pdf)

![image](https://user-images.githubusercontent.com/30849720/124546328-4fba7f80-dddf-11eb-97a8-e7deaf1a6328.png)
 
*
 
uptake 20210618: DELP 20210618, **_IHME 20210618_**, IMPE 20210611, LANL 20210613, SRIV 20210618 
 
(3) [Daily deaths, 2021, reference scenario with uncertainty, IHME](https://github.com/pourmalek/covir2/blob/main/20210618/output/merge/graph%2014%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenario%20with%20uncertainty%2C%20IHME.pdf)

![image](https://user-images.githubusercontent.com/30849720/124673397-a1115000-de6d-11eb-9b73-4e5bee805936.png)
 
* 

 
 
 
 
 
 
 
 
 
 
 
 
 
********************************************************************************************************************************************
  
#### graph (4) Iran - Daily deaths, 2021, reference scenario with uncertainty, IHME
 
 
 
 
 
*
 
uptake 20210704: DELP 20210704, IHME 20210702, **_IMPE 20210626_**, LANL 20210704, SRIV 20210704 
 
(4) [Daily deaths, 2021, 3 scenarios, IHME](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2015%20COVID-19%20daily%20deaths%2C%20Iran%2C%203%20scenarios%2C%20IHME.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677793-0701d580-de76-11eb-8680-15eee5bedb39.png)
 
* 

uptake 20210703: DELP 20210703, **_IHME 20210702_**, IMPE 20210618, LANL 20210627, SRIV 20210703  
 
(4) [Daily deaths, 2021, 3 scenarios, IHME](https://github.com/pourmalek/covir2/blob/main/20210703/output/merge/graph%2015%20COVID-19%20daily%20deaths%2C%20Iran%2C%203%20scenarios%2C%20IHME.pdf)

![image](https://user-images.githubusercontent.com/30849720/124501667-d7b86f00-dd76-11eb-86c0-5608bae6aea1.png)
 
* 

uptake 20210625: DELP 20210625, **_IHME 20210625_**, IMPE 20210618, LANL 20210613, SRIV 20210624 
 
(4) [Daily deaths, 2021, 3 scenarios, IHME](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2015%20COVID-19%20daily%20deaths%2C%20Iran%2C%203%20scenarios%2C%20IHME.pdf)

![image](https://user-images.githubusercontent.com/30849720/124489225-9cfa0b00-dd65-11eb-8dd1-e6bdd10eb6b8.png)
 
* 
 
uptake 20210624: DELP 20210624, IHME 20210618, **_IMPE 20210618_**, LANL 20210613, SRIV 20210624 
 
(4) [Daily deaths, 2021, 3 scenarios, IHME](https://github.com/pourmalek/covir2/blob/main/20210624/output/merge/graph%2015%20COVID-19%20daily%20deaths%2C%20Iran%2C%203%20scenarios%2C%20IHME.pdf)

![image](https://user-images.githubusercontent.com/30849720/124546377-652fa980-dddf-11eb-839e-24985fe28a19.png)
 
*
 
uptake 20210618: DELP 20210618, **_IHME 20210618_**, IMPE 20210611, LANL 20210613, SRIV 20210618 
 
(4) [Daily deaths, 2021, 3 scenarios, IHME](https://github.com/pourmalek/covir2/blob/main/20210618/output/merge/graph%2015%20COVID-19%20daily%20deaths%2C%20Iran%2C%203%20scenarios%2C%20IHME.pdf)

![image](https://user-images.githubusercontent.com/30849720/124673478-bd14f180-de6d-11eb-92d5-6e21d57bcd77.png)
 
* 

 
 
 
 
 
 
 
 
 
 
 
 
 
********************************************************************************************************************************************
 
#### graph (5) Iran - Daily deaths, 2021, reference scenario with uncertainty, IMPE

 
 
 
 
*
 
uptake 20210704: DELP 20210704, IHME 20210702, **_IMPE 20210626_**, LANL 20210704, SRIV 20210704 
 
(5) [Daily deaths, 2021, reference scenario with uncertainty, IMPE](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2016%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenario%20with%20uncertainty%2C%20IMPE.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677827-1bde6900-de76-11eb-8aa8-04e33bd6b8ab.png)
 
* 

uptake 20210703: DELP 20210703, **_IHME 20210702_**, IMPE 20210618, LANL 20210627, SRIV 20210703  
 
(5) [Daily deaths, 2021, reference scenario with uncertainty, IMPE](https://github.com/pourmalek/covir2/blob/main/20210703/output/merge/graph%2016%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenario%20with%20uncertainty%2C%20IMPE.pdf)

![image](https://user-images.githubusercontent.com/30849720/124501716-ed2d9900-dd76-11eb-9262-d7426149d026.png)

* 

uptake 20210625: DELP 20210625, **_IHME 20210625_**, IMPE 20210618, LANL 20210613, SRIV 20210624 
 
(5) [Daily deaths, 2021, reference scenario with uncertainty, IMPE](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2016%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenario%20with%20uncertainty%2C%20IMPE.pdf)

![image](https://user-images.githubusercontent.com/30849720/124489361-bbf89d00-dd65-11eb-8f36-cf0e282fff9e.png)
 
* 
 
uptake 20210624: DELP 20210624, IHME 20210618, **_IMPE 20210618_**, LANL 20210613, SRIV 20210624 
 
(5) [Daily deaths, 2021, reference scenario with uncertainty, IMPE](https://github.com/pourmalek/covir2/blob/main/20210624/output/merge/graph%2016%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenario%20with%20uncertainty%2C%20IMPE.pdf)

![image](https://user-images.githubusercontent.com/30849720/124546424-7aa4d380-dddf-11eb-9df2-67d536c5db3d.png)
 
*
 
uptake 20210618: DELP 20210618, **_IHME 20210618_**, IMPE 20210611, LANL 20210613, SRIV 20210618 
 
(5) [Daily deaths, 2021, reference scenario with uncertainty, IMPE](https://github.com/pourmalek/covir2/blob/main/20210618/output/merge/graph%2016%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenario%20with%20uncertainty%2C%20IMPE.pdf)

![image](https://user-images.githubusercontent.com/30849720/124673543-d7e76600-de6d-11eb-9eba-6a51ee3798bd.png)
 
* 

 
 
 
 
 
 
 
 
 
 
 
 
 
********************************************************************************************************************************************
 
#### graph (6) Iran - Daily deaths, 2021, 3 scenarios, IMPE
  

 
 
*
 
uptake 20210704: DELP 20210704, IHME 20210702, **_IMPE 20210626_**, LANL 20210704, SRIV 20210704 
 
(6) [Daily deaths, 2021, 3 scenarios, IMPE](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2017%20COVID-19%20daily%20deaths%2C%20Iran%2C%203%20scenarios%2C%20IMPE.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677876-34e71a00-de76-11eb-87b9-2657c903d8ed.png)
 
* 
 
uptake 20210703: DELP 20210703, **_IHME 20210702_**, IMPE 20210618, LANL 20210627, SRIV 20210703  
 
(6) [Daily deaths, 2021, 3 scenarios, IMPE](https://github.com/pourmalek/covir2/blob/main/20210703/output/merge/graph%2017%20COVID-19%20daily%20deaths%2C%20Iran%2C%203%20scenarios%2C%20IMPE.pdf)

![image](https://user-images.githubusercontent.com/30849720/124501762-059db380-dd77-11eb-91dd-c3b7f967f25a.png)
 
* 

uptake 20210625: DELP 20210625, **_IHME 20210625_**, IMPE 20210618, LANL 20210613, SRIV 20210624 
 
(6) [Daily deaths, 2021, 3 scenarios, IMPE](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2017%20COVID-19%20daily%20deaths%2C%20Iran%2C%203%20scenarios%2C%20IMPE.pdf)

![image](https://user-images.githubusercontent.com/30849720/124489430-d894d500-dd65-11eb-8a75-dc417d97401f.png)
 
* 
 
uptake 20210624: DELP 20210624, IHME 20210618, **_IMPE 20210618_**, LANL 20210613, SRIV 20210624 
 
(6) [Daily deaths, 2021, 3 scenarios, IMPE](https://github.com/pourmalek/covir2/blob/main/20210624/output/merge/graph%2017%20COVID-19%20daily%20deaths%2C%20Iran%2C%203%20scenarios%2C%20IMPE.pdf)

![image](https://user-images.githubusercontent.com/30849720/124546496-914b2a80-dddf-11eb-813c-3ec664c9b3c3.png)
 
*
 
uptake 20210618: DELP 20210618, **_IHME 20210618_**, IMPE 20210611, LANL 20210613, SRIV 20210618 
 
(6) [Daily deaths, 2021, 3 scenarios, IMPE](https://github.com/pourmalek/covir2/blob/main/20210618/output/merge/graph%2017%20COVID-19%20daily%20deaths%2C%20Iran%2C%203%20scenarios%2C%20IMPE.pdf)

![image](https://user-images.githubusercontent.com/30849720/124673588-efbeea00-de6d-11eb-811d-9f147dd24d43.png)
 
* 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
********************************************************************************************************************************************
 
#### graph (7) Iran - Daily cases or infections, all time
 
 
 
 
 
*
 
uptake 20210704: DELP 20210704, IHME 20210702, **_IMPE 20210626_**, LANL 20210704, SRIV 20210704 
 
(7) [Daily cases or infections, all time](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2021%20COVID-19%20daily%20cases%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677915-4b8d7100-de76-11eb-9643-148227f8efc7.png)
 
* 
 
uptake 20210703: DELP 20210703, **_IHME 20210702_**, IMPE 20210618, LANL 20210627, SRIV 20210703  
 
(7) [Daily cases or infections, all time](https://github.com/pourmalek/covir2/blob/main/20210703/output/merge/graph%2021%20COVID-19%20daily%20cases%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124501821-1cdca100-dd77-11eb-8ea2-dbd12671295b.png)
  
* 

uptake 20210625: DELP 20210625, **_IHME 20210625_**, IMPE 20210618, LANL 20210613, SRIV 20210624 

(7) [Daily cases or infections, all time](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2021%20COVID-19%20daily%20cases%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124481194-e42fce00-dd5c-11eb-88d4-878e22696b38.png)
 
* 
 
uptake 20210624: DELP 20210624, IHME 20210618, **_IMPE 20210618_**, LANL 20210613, SRIV 20210624 
 
(7) [Daily cases or infections, all time](https://github.com/pourmalek/covir2/blob/main/20210624/output/merge/graph%2021%20COVID-19%20daily%20cases%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124546561-aaec7200-dddf-11eb-870c-cc627c4a6bf6.png)
 
*
 
uptake 20210618: DELP 20210618, **_IHME 20210618_**, IMPE 20210611, LANL 20210613, SRIV 20210618 
 
(7) [Daily cases or infections, all time](https://github.com/pourmalek/covir2/blob/main/20210618/output/merge/graph%2021%20COVID-19%20daily%20cases%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124673612-06fdd780-de6e-11eb-974f-757af0505396.png)
 
* 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
********************************************************************************************************************************************
 
#### graph (8) Iran - Daily cases or infections, 2021
 
 
 
 
 
*
 
uptake 20210704: DELP 20210704, IHME 20210702, **_IMPE 20210626_**, LANL 20210704, SRIV 20210704 
 
(8) [Daily cases or infections, 2021](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2022%20COVID-19%20daily%20cases%2C%20Iran%2C%20reference%20scenarios.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677956-6233c800-de76-11eb-9566-45df7d8d3f25.png)
 
* 
 
uptake 20210703: DELP 20210703, **_IHME 20210702_**, IMPE 20210618, LANL 20210627, SRIV 20210703  
 
(8) [Daily cases or infections, 2021](https://github.com/pourmalek/covir2/blob/main/20210703/output/merge/graph%2022%20COVID-19%20daily%20cases%2C%20Iran%2C%20reference%20scenarios.pdf)

![image](https://user-images.githubusercontent.com/30849720/124501868-3382f800-dd77-11eb-8400-e647dea08794.png)
 
* 

uptake 20210625: DELP 20210625, **_IHME 20210625_**, IMPE 20210618, LANL 20210613, SRIV 20210624 
 
(8) [Daily cases or infections, 2021](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2022%20COVID-19%20daily%20cases%2C%20Iran%2C%20reference%20scenarios.pdf)

![image](https://user-images.githubusercontent.com/30849720/124481415-18a38a00-dd5d-11eb-8473-fba112efebb1.png)
 
* 
 
uptake 20210624: DELP 20210624, IHME 20210618, **_IMPE 20210618_**, LANL 20210613, SRIV 20210624 
 
(8) [Daily cases or infections, 2021](https://github.com/pourmalek/covir2/blob/main/20210624/output/merge/graph%2022%20COVID-19%20daily%20cases%2C%20Iran%2C%20reference%20scenarios.pdf)

![image](https://user-images.githubusercontent.com/30849720/124546623-c5265000-dddf-11eb-9238-c40645bb5679.png)
 
*
 
uptake 20210618: DELP 20210618, **_IHME 20210618_**, IMPE 20210611, LANL 20210613, SRIV 20210618 
 
(8) [Daily cases or infections, 2021](https://github.com/pourmalek/covir2/blob/main/20210618/output/merge/graph%2022%20COVID-19%20daily%20cases%2C%20Iran%2C%20reference%20scenarios.pdf)

![image](https://user-images.githubusercontent.com/30849720/124673653-1da42e80-de6e-11eb-96b0-d51627062df2.png)
 
* 
 
 
 
 
 
 
 
 
 
 
 
 
 
******************************************************************************************************************************************** 
 
#### graph (9) Iran - Hospital-related outcomes, all time
 
 
 
 
 
*
 
uptake 20210704: DELP 20210704, IHME 20210702, **_IMPE 20210626_**, LANL 20210704, SRIV 20210704 
 
(9) [Hospital-related outcomes, all time](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2071%20COVID-19%20hospital-related%20outcomes%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124677986-77105b80-de76-11eb-921e-67f9d0f27004.png)
 
* 

uptake 20210703: DELP 20210703, **_IHME 20210702_**, IMPE 20210618, LANL 20210627, SRIV 20210703  
 
(9) [Hospital-related outcomes, all time](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2071%20COVID-19%20hospital-related%20outcomes%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124512004-418f4380-dd8c-11eb-8062-8ae36fae5676.png)

* 

uptake 20210625: DELP 20210625, **_IHME 20210625_**, IMPE 20210618, LANL 20210613, SRIV 20210624 
 
(9) [Hospital-related outcomes, all time](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2071%20COVID-19%20hospital-related%20outcomes%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124481614-50123680-dd5d-11eb-80ab-f1a7d2706dac.png)
 
* 
 
uptake 20210624: DELP 20210624, IHME 20210618, **_IMPE 20210618_**, LANL 20210613, SRIV 20210624 
 
(9) [Hospital-related outcomes, all time](https://github.com/pourmalek/covir2/blob/main/20210624/output/merge/graph%2071%20COVID-19%20hospital-related%20outcomes%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124546670-dbcca700-dddf-11eb-944c-81696957f6b7.png)
 
*
 
uptake 20210618: DELP 20210618, **_IHME 20210618_**, IMPE 20210611, LANL 20210613, SRIV 20210618 
 
(9) [Hospital-related outcomes, all time](https://github.com/pourmalek/covir2/blob/main/20210618/output/merge/graph%2071%20COVID-19%20hospital-related%20outcomes%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124673845-7a9fe480-de6e-11eb-88cd-3598504f8206.png)
 
* 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
********************************************************************************************************************************************
 
#### graph (10) Iran - Hospital-related outcomes, 2021
 
 
 
 
*
 
uptake 20210704: DELP 20210704, IHME 20210702, **_IMPE 20210626_**, LANL 20210704, SRIV 20210704 
 

(10) [Hospital-related outcomes, 2021](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2072%20COVID-19%20hospital-related%20outcomes%2C%20wo%20extremes%2C%202021.pdf)

![image](https://user-images.githubusercontent.com/30849720/124678012-8b545880-de76-11eb-8c86-35d258573497.png)
 
* 

uptake 20210703: DELP 20210703, **_IHME 20210702_**, IMPE 20210618, LANL 20210627, SRIV 20210703  
 
(10) [Hospital-related outcomes, 2021](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2072%20COVID-19%20hospital-related%20outcomes%2C%20wo%20extremes%2C%202021.pdf)

![image](https://user-images.githubusercontent.com/30849720/124511926-10af0e80-dd8c-11eb-9073-a862d211b3d4.png)

* 

uptake 20210625: DELP 20210625, **_IHME 20210625_**, IMPE 20210618, LANL 20210613, SRIV 20210624 
 
(10) [Hospital-related outcomes, 2021](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2072%20COVID-19%20hospital-related%20outcomes%2C%20wo%20extremes%2C%202020-12-01%20on.pdf)

![image](https://user-images.githubusercontent.com/30849720/124481771-82bc2f00-dd5d-11eb-8017-94db5ec5ad6c.png)
 
* 
 
uptake 20210624: DELP 20210624, IHME 20210618, **_IMPE 20210618_**, LANL 20210613, SRIV 20210624 
 
(10) [Hospital-related outcomes, 2021](https://github.com/pourmalek/covir2/blob/main/20210624/output/merge/graph%2072%20COVID-19%20hospital-related%20outcomes%2C%20wo%20extremes%2C%202021.pdf)

![image](https://user-images.githubusercontent.com/30849720/124546861-19c9cb00-dde0-11eb-8123-f4d89c22934b.png)
 
*
 
uptake 20210618: DELP 20210618, **_IHME 20210618_**, IMPE 20210611, LANL 20210613, SRIV 20210618 
 
(10) [Hospital-related outcomes, 2021](https://github.com/pourmalek/covir2/blob/main/20210618/output/merge/graph%2072%20COVID-19%20hospital-related%20outcomes%2C%20wo%20extremes%2C%202021.pdf)

![image](https://user-images.githubusercontent.com/30849720/124673972-b6d34500-de6e-11eb-8fd1-2d799745f4e6.png)
 
* 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
********************************************************************************************************************************************

#### graph (11) Iran - Daily deaths estimated to reported, all time
 
 
 
 
 
*
 
uptake 20210704: DELP 20210704, IHME 20210702, **_IMPE 20210626_**, LANL 20210704, SRIV 20210704 
 
(11) [Daily deaths estimated to reported, all time](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2091%20COVID-19%20daily%20deaths%20estimated%20to%20reported%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124678053-a2934600-de76-11eb-99d4-f63f37beba0b.png)
 
* 

uptake 20210703: DELP 20210703, **_IHME 20210702_**, IMPE 20210618, LANL 20210627, SRIV 20210703  
 
(11) [Daily deaths estimated to reported, all time](https://github.com/pourmalek/covir2/blob/main/20210703/output/merge/graph%2091%20COVID-19%20daily%20deaths%20estimated%20to%20reported%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124502044-88bf0980-dd77-11eb-97d0-dea3170d8de7.png)
  
* 

uptake 20210625: DELP 20210625, **_IHME 20210625_**, IMPE 20210618, LANL 20210613, SRIV 20210624 
 
(11) [Daily deaths estimated to reported, all time](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2091%20COVID-19%20daily%20deaths%20estimated%20to%20reported%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124481972-af704680-dd5d-11eb-9f37-0b3652cbf910.png)
 
* 
 
uptake 20210624: DELP 20210624, IHME 20210618, **_IMPE 20210618_**, LANL 20210613, SRIV 20210624 
 
(11) [Daily deaths estimated to reported, all time](https://github.com/pourmalek/covir2/blob/main/20210624/output/merge/graph%2091%20COVID-19%20daily%20deaths%20estimated%20to%20reported%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124546920-3239e580-dde0-11eb-89e3-da86daf2db0d.png)
 
*
 
uptake 20210618: DELP 20210618, **_IHME 20210618_**, IMPE 20210611, LANL 20210613, SRIV 20210618 
 
(11) [Daily deaths estimated to reported, all time](https://github.com/pourmalek/covir2/blob/main/20210618/output/merge/graph%2091%20COVID-19%20daily%20deaths%20estimated%20to%20reported%2C%20Iran%2C%20reference%20scenarios%2C%20all%20time.pdf)

![image](https://user-images.githubusercontent.com/30849720/124674127-031e8500-de6f-11eb-9bb2-8bc6ee24e104.png)
 
* 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
********************************************************************************************************************************************
 
#### graph (12) Iran - Daily cases or infections estimated to reported cases, 2021
 
 
 
 
 
*
 
uptake 20210704: DELP 20210704, IHME 20210702, **_IMPE 20210626_**, LANL 20210704, SRIV 20210704 
 
(12) [Daily cases or infections estimated to reported cases, 2021](https://github.com/pourmalek/covir2/blob/main/20210704/output/merge/graph%2094%20COVID-19%20daily%20cases%20estimated%20to%20reported%2C%20Iran%2C%20reference%20scenarios.pdf) 

![image](https://user-images.githubusercontent.com/30849720/124678088-b8087000-de76-11eb-8952-8b97e4088f6d.png)
 
* 

uptake 20210703: DELP 20210703, **_IHME 20210702_**, IMPE 20210618, LANL 20210627, SRIV 20210703  
 
(12) [Daily cases or infections estimated to reported cases, 2021](https://github.com/pourmalek/covir2/blob/main/20210703/output/merge/graph%2094%20COVID-19%20daily%20cases%20estimated%20to%20reported%2C%20Iran%2C%20reference%20scenarios.pdf) 

![image](https://user-images.githubusercontent.com/30849720/124502086-a12f2400-dd77-11eb-883d-d34b5f28e1bb.png)
  
* 

uptake 20210625: DELP 20210625, **_IHME 20210625_**, IMPE 20210618, LANL 20210613, SRIV 20210624 
 
(12) [Daily cases or infections estimated to reported cases, 2021](https://github.com/pourmalek/covir2/blob/main/20210625/output/merge/graph%2094%20COVID-19%20daily%20cases%20estimated%20to%20reported%2C%20Iran%2C%20reference%20scenarios.pdf) 

![image](https://user-images.githubusercontent.com/30849720/124482159-d9c20400-dd5d-11eb-95ec-541ba0be1429.png)
 
* 
 
uptake 20210624: DELP 20210624, IHME 20210618, **_IMPE 20210618_**, LANL 20210613, SRIV 20210624 

(12) [Daily cases or infections estimated to reported cases, 2021](https://github.com/pourmalek/covir2/blob/main/20210624/output/merge/graph%2094%20COVID-19%20daily%20cases%20estimated%20to%20reported%2C%20Iran%2C%20reference%20scenarios.pdf) 

![image](https://user-images.githubusercontent.com/30849720/124546976-4a116980-dde0-11eb-96e5-7de83998ff08.png)
 
*
 
uptake 20210618: DELP 20210618, **_IHME 20210618_**, IMPE 20210611, LANL 20210613, SRIV 20210618 
 
(12) [Daily cases or infections estimated to reported cases, 2021](https://github.com/pourmalek/covir2/blob/main/20210618/output/merge/graph%2094%20COVID-19%20daily%20cases%20estimated%20to%20reported%2C%20Iran%2C%20reference%20scenarios.pdf) 

![image](https://user-images.githubusercontent.com/30849720/124674180-19c4dc00-de6f-11eb-88a4-9b176e9d5c63.png)
 
* 
 
 
 
 
 
 
 

 
 
 
 
 
********************************************************************************************************************************************
********************************************************************************************************************************************
 
 
## Licenses / Copyrights of data and / or graphs used in this repository:
 
All the data and / or graphs used in this repository are at non-individual and aggregate level, publicly available on the Internet, and under pertinent licenses and copyrights for non-commercial use, reproduction, and distribution for scientific research, provided that the conditions mentioned in the respective licenses and copyrights are met, as provided below.   

.

(1) ABBREVIATED NAME IN THIS REPOSITORY: **DELP**

CITATION: COVID Analytics. DELPHI epidemiological case predictions. Cambridge: Operations Research Center, Massachusetts Institute of Technology. https://www.covidanalytics.io/projections and https://github.com/COVIDAnalytics/website/tree/master/data/predicted

SOURCE REPOSITORY: https://github.com/COVIDAnalytics/DELPHI

SOURCE REPOSITORY LICENCE: https://github.com/COVIDAnalytics/website/blob/master/LICENSE

.

(2) ABBREVIATED NAME IN THIS REPOSITORY: **IHME**

CITATION: Institute for Health Metrics and Evaluation (IHME). COVID-19 mortality, infection, testing, hospital resource use, and social distancing projections. Seattle: Institute for Health Metrics and Evaluation (IHME), University of Washington. http://www.healthdata.org/covid/ and http://www.healthdata.org/covid/data-downloads

SOURCE REPOSITORY: http://www.healthdata.org/covid/data-downloads

SOURCE REPOSITORY LICENCE: http://www.healthdata.org/about/terms-and-conditions

.

(3) ABBREVIATED NAME IN THIS REPOSITORY: **IMPE**

CITATION: MRC Centre for Global Infectious Disease Analysis (MRC GIDA). Future scenarios of the healthcare burden of COVID-19 in low- or middle-income countries. London: MRC Centre for Global Infectious Disease Analysis, Imperial College London. https://mrc-ide.github.io/global-lmic-reports/ and https://github.com/mrc-ide/global-lmic-reports/tree/master/data

SOURCE REPOSITORY: https://github.com/mrc-ide/global-lmic-reports/tree/master/data

SOURCE REPOSITORY LICENCE: https://mrc-ide.github.io/global-lmic-reports/

.

(4) ABBREVIATED NAME IN THIS REPOSITORY: **LANL**

CITATION: Los Alamos National Laboratory (LANL). COVID-19 cases and deaths forecasts. Los Alamos: Los Alamos National Laboratory (LANL). https://covid-19.bsvgateway.org

SOURCE REPOSITORY: https://covid-19.bsvgateway.org

SOURCE REPOSITORY LICENCE: https://covid-19.bsvgateway.org
.

(5) ABBREVIATED NAME IN THIS REPOSITORY: **SRIV**

CITATION: Srivastava, Ajitesh. University of Southern California (USC). COVID-19 forecast. Los Angeles: University of Southern California. https://scc-usc.github.io/ReCOVER-COVID-19 and https://github.com/scc-usc/ReCOVER-COVID-19/tree/master/results/historical_forecasts

SOURCE REPOSITORY: https://github.com/scc-usc/ReCOVER-COVID-19/tree/master/results/historical_forecasts

SOURCE REPOSITORY LICENCE: https://github.com/scc-usc/ReCOVER-COVID-19/blob/master/LICENSE

.

(6) ABBREVIATED NAME IN THIS REPOSITORY: **JOHN**

CITATION: "COVID-19 Data Repository by the Center for Systems Science and Engineering (CSSE) at Johns Hopkins University" https://coronavirus. jhu.edu/map.html and https://github.com/CSSEGISandData/COVID-19

SOURCE REPOSITORY: https://github.com/CSSEGISandData/COVID-19

SOURCE REPOSITORY LICENCE: https://github.com/CSSEGISandData/COVID-19

.

(7) ABBREVIATED NAME IN THIS REPOSITORY: **YYGU**

CITATION: Gu, Youyang. COVID-19 Projections Using Machine Learning. https://covid19-projections.com and https://github.com/youyanggu/covid19_projections

SOURCE REPOSITORY: https://github.com/youyanggu/covid19_projections

SOURCE REPOSITORY LICENCE: https://github.com/youyanggu/covid19_projections/blob/master/LICENSE

.

(8) ABBREVIATED NAME IN THIS REPOSITORY: **UCLA**

CITATION: Statistical Machine Learning Lab, Computer Science Department, University of California, Los Angeles.   Combating COVID-19. https://covid19.uclaml.org/info.html and https://github.com/uclaml/ucla-covid19-forecasts/tree/master/current_projection

SOURCE REPOSITORY: https://github.com/uclaml/ucla-covid19-forecasts/tree/master/current_projection

SOURCE REPOSITORY LICENCE: https://www.uclaml.org

.

(9) ABBREVIATED NAME IN THIS REPOSITORY: **covidcompare**

CITATION: Friedman J, Liu P, Akre S. The covidcompare tool. https://covidcompare.io/about

SOURCE REPOSITORY: https://covidcompare.io/

SOURCE REPOSITORY LICENCE: https://covidcompare.io/about

.


********************************************************************************************************************************************
********************************************************************************************************************************************

## License, DOI, and suggested Citation of this reposirory 
  
* All codes are copyrighted by the author under Apache License 2.0.
 
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)  

* See [`LICENSE`](https://github.com/pourmalek/covir2/blob/main/LICENSE)
 
<div dir="rtl">
 
 ## این نمودارها و کد های نرم افزار ممکن است حاوی اشتباهاتی باشند و به صورت ("as is") به اشتراک گذاشته شده اند و هر گونه عواقب هر گونه تصمیم گیری بر مبنای کد ها و نمودارهای موجود در این سایت (سایت covir2) بر عهده تصمیم گیرنده یا تصمیم گیرندگان است و نه بر عهده پدید آورنده یا عهده پدید آورندگان این سایت (سایت covir2).


<div dir="ltr"> 

<br/><br/>
  
  
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5020797.svg)](https://doi.org/10.5281/zenodo.5020797)
 

[`DOI`](https://zenodo.org/record/5020797#.YNOP5C297-Y)
  
<br/><br/>
  
  
Pourmalek, F. GitHub repository “covid2”: Combine and visualize international periodically updating estimates of COVID-19 at the country level, countries without subnational level estimates: Iran. Version 2.2, Released June 23, 2021. http://doi.org/10.5281/zenodo.5020797 https://github.com/pourmalek/covir2 
 
 
 
