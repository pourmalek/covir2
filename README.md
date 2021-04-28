# covir2

# COVID-19 Iran Review No 2, Stata codes

<br/><br/>



Farsi README for covir2
<div dir="rtl">

## نحوه داونلود و استفاده از کد های نرم افزار استیتا 
در تارنمای گیت هاب (https://github.com/pourmalek/covir2) 
که در زیر با نام (سایت covir2) به آن اشاره می شود. 
<br/><br/>

### مرور برآوردهای مطالعات بین المللی برای همه گیری کووید-۱۹ در ایران، نسخه دوم
<br/><br/>

 (الف)‌ کلیات،‌ (ب) نحوه داونلود و استفاده از کد های نرم افزار
<br/><br/>


### (الف)‌ کلیات

کلیاتی از مطالعه در (اینجا) توضیح داده شده است. (لینک به نوشته اصلی فارسی اضافه شود)

نمودارهای برآوردهای پیامدها در هر یک از مطالعات بررسی شده در (سایت covir2) قابل دیدن هستند.
نمودارهای برآوردهای پیامدها در مجموعه مطالعات بررسی شده به صورت یکجا نیز قابل دیدن هستند.

برآوردهای پنج مطالعه بین المللی به صورت دوره ای به روز می شوند. در (سایت covir2) نیز نتایج این به روز-رسانی ها به صورت دوره ای به سایت اضافه می شود. به روز رسانی نتایج مدل ها در این بررسی تا کنون چهار مرتبه صورت گرفته است، در تاریخ های:
<br/><br/>
[20210405](https://github.com/pourmalek/covir2/tree/main/20210405)
<br/><br/>
[20210413](https://github.com/pourmalek/covir2/tree/main/20210413)
<br/><br/>
[20210416](https://github.com/pourmalek/covir2/tree/main/20210416)
<br/><br/>
[20210423](https://github.com/pourmalek/covir2/tree/main/20210423)


 هر بار یک دایرکتوری با نام تاریخ به روز رسانی ایجاد می گردد. 

در داخل دایرکتوری هر یک از به روز رسانی ها،‌ دو دایرکتوری [code](https://github.com/pourmalek/covir2/tree/main/20210423/code) و [output](https://github.com/pourmalek/covir2/tree/main/20210423/ouput) که به ترتیب حاوی کد های نرم افزار استیتا و خروجی کد ها می باشند. در داخل هر یک از این دو دایرکتوری،‌ دایرکتوری هایی برای هر مطالعه وجود دارد (اسامی اختصاری در [اینجا](https://github.com/pourmalek/covir2/blob/main/Variable%20name%20structure.pdf) توضیح داده شده اند) و دو دایرکتوری دیگر به نام های [master](https://github.com/pourmalek/covir2/tree/main/20210423/code/master) ‌و [merge](https://github.com/pourmalek/covir2/tree/main/20210423/code/merge). دایرکتوری [master](https://github.com/pourmalek/covir2/tree/main/20210423/code/master) حاوی یک کد استیتا است به نام [do Iran master.do](https://github.com/pourmalek/covir2/blob/main/20210423/code/master/do%20Iran%20master.do) که اجرای آن روی کامپیوتر کاربر،‌ بعد از داونلود به کامپیوتر کاربر، ‌باعث اجرای سایر کدها و تولید نمودارها و سایر خروجی ها می گردد. دایرکتوری [merge](https://github.com/pourmalek/covir2/tree/main/20210423/code/merge) حاوی کدی است که نتایج حاصل شده از کدهای مربوط به هر یک از مطالعات را گردآوری کرده و برای هر پیامد (مثلا مرگ های روزانه) نمودار حاصل از همه مطالعات را ترسیم می کند. 

تفاوتی که این ریپوزیتوری حاضر در (سایت covir2) با ریپوزیتوری های  مشابه دارد این است که کد های استیتا در (سایت covir2)، برآوردهای مطالعات بین المللی را تارنمای مربوط به هر مطالعه داونلود و آماده می کند. 

اگر یک کاربر بخواهد کد های نرم افزار استیتای موجود در (سایت covir2) را اجرا کند، می بایست ابتدا آن ها را داونلود نماید،‌که در زیر توضیح داده شده است. لازم است  به مفاد و محتوی مجوز مربوطه [در اینجا](https://github.com/pourmalek/covir2/blob/main/LICENSE) توجه
شود. این کد های نرم افزار ممکن است حاوی اشتباهاتی باشند و به صورت ("as is") به اشتراک گذاشته شده اند و هر گونه عواقب هر گونه تصمیم گیری بر مبنای کد ها و نمودارهای موجود در این سایت (سایت covir2) بر عهده تصمیم گیرنده یا تصمیم گیرندگان است و نه بر عهده پدید آورنده یا عهده پدید آورندگان این سایت (سایت covir2). 

<br/><br/>

### (ب) نحوه داونلود و استفاده از کد های نرم افزار

خلاصه: 
کل ریپوزیتوری covir2 را داونلود نموده و فایل زیر را در استیتا اجرا نمایید:

"Users\local-user-name\Downloads\covir2-main\20210423\code\master\do Iran master.do"
 
 <br/><br/>

توضیحات: 
در بالا و سمت راست صفحه اصلی (سایت covir2) یک مستطیل سبز رنگ وجود دارد ![image](https://user-images.githubusercontent.com/30849720/116341281-759b2680-a795-11eb-8dff-3d9d19271aa3.png)
 

که با کلیک کردن روی آن منوی زیر باز می شود.
 
![image](https://user-images.githubusercontent.com/30849720/116341334-8f3c6e00-a795-11eb-8750-266a9af037bd.png)


با کلیک کردن روی سطر آخر منو (DOWNLOAD ZIP)،‌ کل محتوی (سایت covir2) بر روی کامپیوتر کاربر داونلود می شود. کلیک کردن روی لینک [اینجا](https://codeload.github.com/pourmalek/covir2/zip/refs/heads/main) نیز همان کار را می کند. بسته به تنظیمات و سیستم کامل کامپیوتر کاربر،‌ حاصل داونلود دو نوع ممکن است باشد: یک فایل زیپ به نام covir2-main.zip یا یک دیرکتوری به نام covir2-main. فایل زیپ به نام covir2-main.zip را باید unzip کرد به قراری که دیرکتوری حاصله در ریشه Downloads باشد. 

پس از داونلود، فایل "Iran master.do" را اجرا کنید،‌که در مسیر زیر قرار دارد:

"Users\local-user-name\Downloads\covir2-main\20210423\code\master\do Iran master.do"

نام کاربر، جایگزین (local-user-name) خواهد شد. علامت / برای کاربران مک اینتاش جایگزین علامت \ می گردد. 
قسمت \20210423\ در مسیر فوق برای به روز رسانی مربوط به این تاریخ میلادی می باشد. 

در صورت مواجهه با اشکال در اجرای کد،‌ به قسمت رفع مشکلات در [اینجا](https://github.com/pourmalek/covir2/blob/main/Troubleshooting.pdf) مراجعه شود. در صورت رفع نشدن اشکال، و همچنین در صورت مشاهده اشتباه (bug) در کد ها، می توان به [اینجا](https://github.com/pourmalek/covir2/tree/main/.github/ISSUE_TEMPLATE) مراجعه نمود، یا به پدید آورنده ای-میل زد. 







********************************************************************************************************************************************
* Project: Rapid review of estimates of COVID-19 Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10
* **OBJECTIVE** of these `Stata` codes: Get and prepare component studies' estimates for Iran, locate peak dates and values, graph estimates
********************************************************************************************************************************************

<br/><br/>

********************************************************************************************************************************************

## Selected graphs from latest update 20210423

*

[COVID-19 daily deaths, Iran, reference scenarios](https://github.com/pourmalek/covir2/blob/main/20210423/ouput/merge/graph%2011a%20COVID-19%20daily%20deaths%2C%20Iran%2C%20reference%20scenarios.pdf)

![image](https://user-images.githubusercontent.com/30849720/115951644-9feb9c00-a496-11eb-80e6-1f80516cfcdb.png)

*
[COVID-19 daily cases, Iran, reference scenarios](https://github.com/pourmalek/covir2/blob/main/20210423/ouput/merge/graph%2021a%20COVID-19%20daily%20cases%2C%20Iran%2C%20reference%20scenarios.pdf)

![image](https://user-images.githubusercontent.com/30849720/115951713-16889980-a497-11eb-9fd9-f2337a946120.png)

*
[COVID-19 daily active cases, Iran](https://github.com/pourmalek/covir2/blob/main/20210423/ouput/merge/graph%2062.1%20COVID-19%20daily%20active%20cases%20wo%20GHAN%20Hijri.pdf)

![image](https://user-images.githubusercontent.com/30849720/115951918-2785da80-a498-11eb-9feb-701bd3bfa869.png)

*
[COVID-19 daily hospital-related outcomes Iran, median scenarios](https://github.com/pourmalek/covir2/blob/main/20210423/ouput/merge/graph%2071%20COVID-19%20hospital-related%20outcomes.pdf)

![image](https://user-images.githubusercontent.com/30849720/115951799-931b7800-a497-11eb-94bb-cb4f9f6114f0.png)

*
[COVID-19 hospital-related outcomes, without extremes, 2020-12-01 on](https://github.com/pourmalek/covir2/blob/main/20210423/ouput/merge/graph%2073%20COVID-19%20hospital-related%20outcomes%2C%20wo%20extremes%2C%202020-12-01%20on.pdf)

![image](https://user-images.githubusercontent.com/30849720/115951851-ccec7e80-a497-11eb-92dd-1631adaecd4c.png)


********************************************************************************************************************************************

<br/><br/>


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



