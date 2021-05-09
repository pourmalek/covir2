### Description of rule for uptakes of covir2

This is description of rule of adding uptakes to covir2 repository, either prospectively, i.e., uptakes with new calendar time dates, or retrospectively, i.e., uptakes with calendar time dates in the past. 

Uptake is a term used here to differentiate from updates. Updates belong to models. Uptake belongs to covir2 repository. Updates are released by studies. Uptakes are added to this repository by its creator. 

The old rule for adding uptakes to covir2 repository lacked documentation. The present rule for adding uptakes to covir2 repository is documented here. 

**The overarching principle for creation of uptakes in covir2, is creation of an uptake for each calendar date on which an uptake is available for either _IHME or IMPE_, and using the most recent update for the other study (IMPE or IHME) for that uptake.**

The rationale for not including every new update by LANL or SRIV in the overarching principle is that it would lead to too frequent uptakes, which would defy the purpose of gaining new insight with each uptake in covir2. 

Algorithmic details of the rule for adding uptakes to covir2 repository are as follows. 


For every single calendar date, 

(1) Check for new updates by IHME.
(2) If a new update by IHME is available, start a new uptake with today's date, and use this new update by IHME.
(3) Look for latest available update by IMPE, and include that in this uptake.
(4) Look for the latest available update by LANL, and include that in this uptake.
(5) Look for update by SRIV for which the date is equal to date for IHME. 

(6) If no new update by IHME is available (from step 1), check for new updates by IMPE. If a new update by IMPE is available, start a new uptake with today's date, and use this new update by IMPE.
(7) Look for the latest available update by IHME, and include that in this uptake.
(8) Look for the latest available update by LANL, and include that in this uptake. 
(9) Look for update by SRIV for which the date is equal to date for IMPE.
(10) If no new update by IMPE is available (from step 6), there is no new uptake for this calendar date. End. 


date	uptake_date	uptake_no	IHME_uptake_no	IHME_uptake_date	IMPE_uptake_no	IMPE_uptake_date	LANL_uptake_no	LANL_uptake_date	SRIV_uptake_no	SRIV_uptake_date	sdate

25-Jun-20	25-Jun-20	1	30	25-Jun-20			18	23-Jun-20	55	25-Jun-20	20200625
29-Jun-20	29-Jun-20	2	31	29-Jun-20			19	28-Jun-20	59	29-Jun-20	20200629
02-Jul-20	02-Jul-20	3	31	29-Jun-20	53	02-Jul-20	20	01-Jul-20	62	02-Jul-20	20200702
03-Jul-20	03-Jul-20	4	31	29-Jun-20	54	03-Jul-20	20	01-Jul-20	63	03-Jul-20	20200703
04-Jul-20	04-Jul-20	5	31	29-Jun-20	55	04-Jul-20	20	01-Jul-20	64	04-Jul-20	20200704
07-Jul-20	07-Jul-20	6	32	07-Jul-20	56	07-Jul-20	21	05-Jul-20	67	07-Jul-20	20200707
11-Jul-20	11-Jul-20	7	32	07-Jul-20	57	11-Jul-20	22	08-Jul-20	71	11-Jul-20	20200711
14-Jul-20	14-Jul-20	8	33	14-Jul-20	58	14-Jul-20	23	12-Jul-20	74	14-Jul-20	20200714
15-Jul-20	15-Jul-20	9	33	14-Jul-20	59	15-Jul-20	24	15-Jul-20	75	15-Jul-20	20200715
18-Jul-20	18-Jul-20	10	33	14-Jul-20	60	18-Jul-20	24	15-Jul-20	78	18-Jul-20	20200718
20-Jul-20	20-Jul-20	11	33	14-Jul-20	61	20-Jul-20	25	19-Jul-20	80	20-Jul-20	20200720
22-Jul-20	22-Jul-20	12	34	22-Jul-20	62	22-Jul-20	26	22-Jul-20	82	22-Jul-20	20200722
25-Jul-20	25-Jul-20	13	34	22-Jul-20	63	25-Jul-20	26	22-Jul-20	85	25-Jul-20	20200725
27-Jul-20	27-Jul-20	14	34	22-Jul-20	64	27-Jul-20	27	26-Jul-20	87	27-Jul-20	20200727
30-Jul-20	30-Jul-20	15	35	30-Jul-20	64	27-Jul-20	28	29-Jul-20	90	30-Jul-20	20200730
31-Jul-20	31-Jul-20	16	35	30-Jul-20	65	31-Jul-20	28	29-Jul-20	91	31-Jul-20	20200731
06-Aug-20	06-Aug-20	17	36	06-Aug-20	65	31-Jul-20	30	05-Aug-20	97	06-Aug-20	20200806
08-Aug-20	08-Aug-20	18	36	06-Aug-20	66	08-Aug-20	30	05-Aug-20	99	08-Aug-20	20200808
10-Aug-20	10-Aug-20	19	36	06-Aug-20	67	10-Aug-20	31	09-Aug-20	101	10-Aug-20	20200810
11-Aug-20	11-Aug-20	20	36	06-Aug-20	68	11-Aug-20	31	09-Aug-20	102	11-Aug-20	20200811
13-Aug-20	13-Aug-20	21	36	06-Aug-20	69	13-Aug-20	32	12-Aug-20	104	13-Aug-20	20200813
14-Aug-20	14-Aug-20	22	36	06-Aug-20	70	14-Aug-20	32	12-Aug-20	105	14-Aug-20	20200814
17-Aug-20	17-Aug-20	23	36	06-Aug-20	71	17-Aug-20	33	16-Aug-20	108	17-Aug-20	20200817
21-Aug-20	21-Aug-20	24	37	21-Aug-20	71	17-Aug-20	34	19-Aug-20	112	21-Aug-20	20200821
23-Aug-20	23-Aug-20	25	37	21-Aug-20	72	23-Aug-20	35	23-Aug-20	114	23-Aug-20	20200823
25-Aug-20	25-Aug-20	26	37	21-Aug-20	73	25-Aug-20	35	23-Aug-20	116	25-Aug-20	20200825
27-Aug-20	27-Aug-20	27	38	27-Aug-20	74	27-Aug-20	36	26-Aug-20	118	27-Aug-20	20200827
31-Aug-20	31-Aug-20	28	38	27-Aug-20	75	31-Aug-20	37	30-Aug-20	122	31-Aug-20	20200831
02-Sep-20	02-Sep-20	29	38	27-Aug-20	76	02-Sep-20	38	02-Sep-20	124	02-Sep-20	20200902
03-Sep-20	03-Sep-20	30	39	03-Sep-20	76	02-Sep-20	38	02-Sep-20	125	03-Sep-20	20200903
06-Sep-20	06-Sep-20	31	39	03-Sep-20	77	06-Sep-20	39	06-Sep-20	128	06-Sep-20	20200906
08-Sep-20	08-Sep-20	32	39	03-Sep-20	78	08-Sep-20	39	06-Sep-20	130	08-Sep-20	20200908
11-Sep-20	11-Sep-20	33	40	11-Sep-20	78	08-Sep-20	40	09-Sep-20	133	11-Sep-20	20200911
12-Sep-20	12-Sep-20	34	40	11-Sep-20	79	12-Sep-20	40	09-Sep-20	134	12-Sep-20	20200912
15-Sep-20	15-Sep-20	35	40	11-Sep-20	80	15-Sep-20	41	13-Sep-20	137	15-Sep-20	20200915
18-Sep-20	18-Sep-20	36	41	18-Sep-20	80	15-Sep-20	42	16-Sep-20	140	18-Sep-20	20200918
19-Sep-20	19-Sep-20	37	41	18-Sep-20	81	19-Sep-20	42	16-Sep-20	141	19-Sep-20	20200919
23-Sep-20	23-Sep-20	38	41	18-Sep-20	82	23-Sep-20	44	23-Sep-20	145	23-Sep-20	20200923
24-Sep-20	24-Sep-20	39	42	24-Sep-20	82	23-Sep-20	44	23-Sep-20	146	24-Sep-20	20200924
25-Sep-20	25-Sep-20	40	42	24-Sep-20	83	25-Sep-20	44	23-Sep-20	147	25-Sep-20	20200925
02-Oct-20	02-Oct-20	41	43	02-Oct-20	83	25-Sep-20	46	30-Sep-20	154	02-Oct-20	20201002
03-Oct-20	03-Oct-20	42	43	02-Oct-20	84	03-Oct-20	46	30-Sep-20	155	03-Oct-20	20201003
06-Oct-20	06-Oct-20	43	43	02-Oct-20	85	06-Oct-20	47	04-Oct-20	158	06-Oct-20	20201006
09-Oct-20	09-Oct-20	44	44	09-Oct-20	85	06-Oct-20	48	07-Oct-20	161	09-Oct-20	20201009
12-Oct-20	12-Oct-20	45	44	09-Oct-20	86	12-Oct-20	49	11-Oct-20	164	12-Oct-20	20201012
15-Oct-20	15-Oct-20	46	45	15-Oct-20	86	12-Oct-20	50	14-Oct-20	167	15-Oct-20	20201015
19-Oct-20	19-Oct-20	47	45	15-Oct-20	87	19-Oct-20	51	18-Oct-20	171	19-Oct-20	20201019
22-Oct-20	22-Oct-20	48	46	22-Oct-20	87	19-Oct-20	52	21-Oct-20	174	22-Oct-20	20201022
25-Oct-20	25-Oct-20	49	46	22-Oct-20	88	25-Oct-20	53	25-Oct-20	177	25-Oct-20	20201025
28-Oct-20	28-Oct-20	50	46	22-Oct-20	89	28-Oct-20	54	28-Oct-20	180	28-Oct-20	20201028
29-Oct-20	29-Oct-20	51	47	29-Oct-20	89	28-Oct-20	54	28-Oct-20	181	29-Oct-20	20201029
01-Nov-20	01-Nov-20	52	47	29-Oct-20	90	01-Nov-20	55	01-Nov-20	184	01-Nov-20	20201101
10-Nov-20	10-Nov-20	53	47	29-Oct-20	91	10-Nov-20	57	08-Nov-20	193	10-Nov-20	20201110
12-Nov-20	12-Nov-20	54	48	12-Nov-20	91	10-Nov-20	58	11-Nov-20	195	12-Nov-20	20201112
14-Nov-20	14-Nov-20	55	48	12-Nov-20	92	14-Nov-20	58	11-Nov-20	197	14-Nov-20	20201114
18-Nov-20	18-Nov-20	56	48	12-Nov-20	93	18-Nov-20	60	18-Nov-20	201	18-Nov-20	20201118
19-Nov-20	19-Nov-20	57	49	19-Nov-20	93	18-Nov-20	60	18-Nov-20	202	19-Nov-20	20201119
23-Nov-20	23-Nov-20	58	49	19-Nov-20	94	23-Nov-20	61	22-Nov-20	206	23-Nov-20	20201123
29-Nov-20	29-Nov-20	59	49	19-Nov-20	95	29-Nov-20	63	29-Nov-20	212	29-Nov-20	20201129
03-Dec-20	03-Dec-20	60	50	03-Dec-20	95	29-Nov-20	64	02-Dec-20	216	03-Dec-20	20201203
04-Dec-20	04-Dec-20	61	50	03-Dec-20	96	04-Dec-20	64	02-Dec-20	217	04-Dec-20	20201204
10-Dec-20	10-Dec-20	62	51	10-Dec-20	96	04-Dec-20	66	09-Dec-20	223	10-Dec-20	20201210
12-Dec-20	12-Dec-20	63	51	10-Dec-20	97	12-Dec-20	66	09-Dec-20	225	12-Dec-20	20201212
17-Dec-20	17-Dec-20	64	52	17-Dec-20	97	12-Dec-20	68	16-Dec-20	229	17-Dec-20	20201217
20-Dec-20	20-Dec-20	65	52	17-Dec-20	98	20-Dec-20	69	20-Dec-20	232	20-Dec-20	20201220
23-Dec-20	23-Dec-20	66	53	23-Dec-20	98	20-Dec-20	70	23-Dec-20	235	23-Dec-20	20201223
26-Dec-20	26-Dec-20	67	53	23-Dec-20	99	26-Dec-20	70	23-Dec-20	238	26-Dec-20	20201226
04-Jan-21	04-Jan-21	68	53	23-Dec-20	100	04-Jan-21	71	03-Jan-21	246	04-Jan-21	20210104
10-Jan-21	10-Jan-21	69	53	23-Dec-20	101	10-Jan-21	73	10-Jan-21	252	10-Jan-21	20210110
12-Jan-21	12-Jan-21	70	53	23-Dec-20	102	12-Jan-21	73	10-Jan-21	254	12-Jan-21	20210112
15-Jan-21	15-Jan-21	71	54	15-Jan-21	102	12-Jan-21	74	13-Jan-21	257	15-Jan-21	20210115
18-Jan-21	18-Jan-21	72	54	15-Jan-21	103	18-Jan-21	75	17-Jan-21	260	18-Jan-21	20210118
22-Jan-21	22-Jan-21	73	55	22-Jan-21	103	18-Jan-21	76	20-Jan-21	264	22-Jan-21	20210122
24-Jan-21	24-Jan-21	74	55	22-Jan-21	104	24-Jan-21	77	24-Jan-21	266	24-Jan-21	20210124
28-Jan-21	28-Jan-21	75	56	28-Jan-21	104	24-Jan-21	78	27-Jan-21	270	28-Jan-21	20210128
30-Jan-21	30-Jan-21	76	56	28-Jan-21	105	30-Jan-21	78	27-Jan-21	272	30-Jan-21	20210130
03-Feb-21	03-Feb-21	77	56	28-Jan-21	106	03-Feb-21	80	03-Feb-21	276	03-Feb-21	20210203
04-Feb-21	04-Feb-21	78	57	04-Feb-21	106	03-Feb-21	80	03-Feb-21	277	04-Feb-21	20210204
10-Feb-21	10-Feb-21	79	57	04-Feb-21	107	10-Feb-21	82	10-Feb-21	283	10-Feb-21	20210210
12-Feb-21	12-Feb-21	80	58	12-Feb-21	107	10-Feb-21	82	10-Feb-21	285	12-Feb-21	20210212
17-Feb-21	17-Feb-21	81	58	12-Feb-21	108	17-Feb-21	84	17-Feb-21	290	17-Feb-21	20210217
20-Feb-21	20-Feb-21	82	59	20-Feb-21	108	17-Feb-21	84	17-Feb-21	293	20-Feb-21	20210220
25-Feb-21	25-Feb-21	83	60	25-Feb-21	108	17-Feb-21	86	24-Feb-21	298	25-Feb-21	20210225
26-Feb-21	26-Feb-21	84	60	25-Feb-21	109	26-Feb-21	86	24-Feb-21	299	26-Feb-21	20210226
05-Mar-21	05-Mar-21	85	60	25-Feb-21	110	05-Mar-21	88	03-Mar-21	306	05-Mar-21	20210305
06-Mar-21	06-Mar-21	86	61	06-Mar-21	110	05-Mar-21	88	03-Mar-21	307	06-Mar-21	20210306
11-Mar-21	11-Mar-21	87	62	11-Mar-21	110	05-Mar-21	90	10-Mar-21	312	11-Mar-21	20210311
12-Mar-21	12-Mar-21	88	62	11-Mar-21	111	12-Mar-21	90	10-Mar-21	313	12-Mar-21	20210312
17-Mar-21	17-Mar-21	89	63	17-Mar-21	111	12-Mar-21	91	14-Mar-21	318	17-Mar-21	20210317
19-Mar-21	19-Mar-21	90	63	17-Mar-21	112	19-Mar-21	91	14-Mar-21	320	19-Mar-21	20210319
25-Mar-21	25-Mar-21	91	64	25-Mar-21	112	19-Mar-21	93	24-Mar-21	326	25-Mar-21	20210325
29-Mar-21	29-Mar-21	92	64	25-Mar-21	113	29-Mar-21	94	28-Mar-21	330	29-Mar-21	20210329
01-Apr-21	01-Apr-21	93	65	01-Apr-21	113	29-Mar-21	95	31-Mar-21	333	01-Apr-21	20210401
06-Apr-21	06-Apr-21	94	65	01-Apr-21	114	06-Apr-21	96	04-Apr-21	338	06-Apr-21	20210406
09-Apr-21	09-Apr-21	95	66	09-Apr-21	114	06-Apr-21	97	07-Apr-21	341	09-Apr-21	20210409
16-Apr-21	16-Apr-21	96	67	16-Apr-21	114	06-Apr-21	99	14-Apr-21	348	16-Apr-21	20210416
17-Apr-21	17-Apr-21	97	67	16-Apr-21	115	17-Apr-21	99	14-Apr-21	349	17-Apr-21	20210417
22-Apr-21	22-Apr-21	98	68	22-Apr-21	115	17-Apr-21	101	21-Apr-21	354	22-Apr-21	20210422
24-Apr-21	24-Apr-21	99	68	22-Apr-21	116	24-Apr-21	101	21-Apr-21	356	24-Apr-21	20210424
06-May-21	06-May-21	100	69	06-May-21	116	24-Apr-21	105	05-May-21	368	06-May-21	20210506



