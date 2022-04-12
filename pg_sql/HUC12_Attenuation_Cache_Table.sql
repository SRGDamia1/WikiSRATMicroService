﻿
-- tables to build

-- 1) that holds an array for all comids from top to bottom of the dissolve frac

-- comid, {.74,.95,.78,...,}

--1 a table (or the same table that contains the reduction by mulltyipling the 
--2 nested calc reduction (eg.84 for tn) (1 * (1- (.74*.84))* (1-(.95*.84)) etc coeficients
--3 to calculate for each huc12 simply multiply 2 * eac comid's percent of the huc12 and sum. giving overall percent..




-- based on converstion with Barry evans
Alter Table wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019
Add Column  rdc_0 float ;

Alter Table wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019
Add Column  rdc_22 float;

Alter Table wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019
Add Column  rdc_42 float;

Alter Table wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019
Add Column  rdc_75 float;

Alter Table wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019
Add Column  rdc_21 float;

Alter Table wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019
Add Column  rdc_12 float;

Alter Table wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019
Add Column  rdc_11 float;

Alter Table wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019
Add Column  rdc_10 float;

Alter Table wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019
Add Column  rdc_5 float;

Alter Table wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019
Add Column  rdc_13 float;

Select * from wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019
where rdc_13 is not null limit 2



Drop Table if Exists wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019;
 
Create Table wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019
(
comid integer not null,
rte float[],
rdc_84 float,
rdc_29 float,
rdc_12 float,
rdc_0 float,
rdc_22 float,
rdc_42 float,
rdc_75 float,
rdc_21 float,
rdc_11 float,
rdc_10 float,
rdc_5 float,
rdc_13 float,

rdc_02 float,
rdc_16 float,
rdc_20 float,
rdc_19 float,
rdc_24 float,
rdc_28 float
);

ALTER TABLE wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019 ALTER COLUMN comid SET NOT NULL;

set enable_seqscan = off;

truncate table wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019 ;

-- This table calculates the percent reduction from above for each comid in each huc12.

Insert Into wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019 
(comid,
--rte,
rdc_84,
rdc_29,
rdc_12,
rdc_42,
rdc_22,
rdc_0,
rdc_75,
rdc_21,
rdc_11,
rdc_10,
rdc_5,
rdc_13,
-- ADDED BASED ON CONVO WITH BARRY 04/2022
rdc_02,
rdc_16,
rdc_20,
rdc_19,
rdc_24,
rdc_28
)

-- I had to make a major fix here 6-8-18
-- based on the fact that some nhdplus catchments do not have areas and therefore were stopping 
-- the routing from happengin allowing zeroes to move forward solved the problem for area


(
With Recursive included_parts(step, comid,comid2, rte, plce, huc12, dnhydroseq,areasqkm, calc84,calc29,calc12, calc42, calc22, calc0, calc75, calc21,calc11,calc10,calc5,calc13, calc02,calc16,calc20,calc19,calc24,calc28) As 
(
Select * From
(
Select 1 step,lnx.comid,lnx.comid, (shed.shedareadrainlake/100), 1::integer as plce, huc12, dnhydroseq, areasqkm
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.84)::float ) calc84
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.29)::float ) calc29
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.12)::float ) calc12
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.42)::float ) calc42
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.22)::float ) calc22
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.0)::float  ) calc0
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.75)::float ) calc75
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.21)::float ) calc21
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.11)::float ) calc11
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.10)::float ) calc10
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.05)::float ) calc5
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.13)::float ) calc13
-- ADDED BASED ON CONVO WITH BARRY 04/2022
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.02)::float ) calc02
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.16)::float ) calc16
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.20)::float ) calc20
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.19)::float ) calc19
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.24)::float ) calc24
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.28)::float ) calc28
From wikiwtershed.nhdplus_stream_nsidx lnx join wikiwtershed.cache_nhdcoefs_2019 shed
On lnx.comid = shed.comid --and shed.huc12 like '020402050401' and shed.comid = 4652300
 
--where lnx.comid not in (select comid from wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019)
--limit 100000
)t
Union All
Select included_parts.step + 1, included_parts.comid,t1.comid, shd, included_parts.plce + 1 as plce, included_parts.huc12, t1.dnhydroseq, t1.areasqkm,
	case when (included_parts.calc84 * ( 1 - ( coalesce(shd,0) * (0.84)::float ))) < .01 then 0 else (included_parts.calc84 * ( 1 - ( coalesce(shd,0) * (0.84)::float ))) end,
	case when (included_parts.calc29 * ( 1 - ( coalesce(shd,0) * (0.29)::float ))) < .01 then 0 else (included_parts.calc29 * ( 1 - ( coalesce(shd,0) * (0.29)::float ))) end, 
	case when (included_parts.calc12 * ( 1 - ( coalesce(shd,0) * (0.12)::float ))) < .01 then 0 else (included_parts.calc12 * ( 1 - ( coalesce(shd,0) * (0.12)::float ))) end,
	case when (included_parts.calc42 * ( 1 - ( coalesce(shd,0) * (0.42)::float ))) < .01 then 0 else (included_parts.calc42 * ( 1 - ( coalesce(shd,0) * (0.42)::float ))) end,
	case when (included_parts.calc22 * ( 1 - ( coalesce(shd,0) * (0.22)::float ))) < .01 then 0 else (included_parts.calc22 * ( 1 - ( coalesce(shd,0) * (0.22)::float ))) end, 
	case when (included_parts.calc0  * ( 1 - ( coalesce(shd,0) * (0.0) ::float ))) < .01 then 0 else (included_parts.calc0  * ( 1 - ( coalesce(shd,0) * (0.0 )::float ))) end,
	case when (included_parts.calc75 * ( 1 - ( coalesce(shd,0) * (0.75)::float ))) < .01 then 0 else (included_parts.calc75 * ( 1 - ( coalesce(shd,0) * (0.75)::float ))) end,
	case when (included_parts.calc21 * ( 1 - ( coalesce(shd,0) * (0.21)::float ))) < .01 then 0 else (included_parts.calc21 * ( 1 - ( coalesce(shd,0) * (0.21)::float ))) end,
	case when (included_parts.calc11 * ( 1 - ( coalesce(shd,0) * (0.11)::float ))) < .01 then 0 else (included_parts.calc11 * ( 1 - ( coalesce(shd,0) * (0.11)::float ))) end,
	case when (included_parts.calc10 * ( 1 - ( coalesce(shd,0) * (0.10)::float ))) < .01 then 0 else (included_parts.calc10 * ( 1 - ( coalesce(shd,0) * (0.10)::float ))) end,
	case when (included_parts.calc5  * ( 1 - ( coalesce(shd,0) * (0.05)::float ))) < .01 then 0 else (included_parts.calc5  * ( 1 - ( coalesce(shd,0) * (0.05)::float ))) end,
	case when (included_parts.calc13 * ( 1 - ( coalesce(shd,0) * (0.13)::float ))) < .01 then 0 else (included_parts.calc13 * ( 1 - ( coalesce(shd,0) * (0.13)::float ))) end,
-- ADDED BASED ON CONVO WITH BARRY 04/2022
	case when (included_parts.calc02 * ( 1 - ( coalesce(shd,0) * (0.02)::float ))) < .01 then 0 else (included_parts.calc02 * ( 1 - ( coalesce(shd,0) * (0.02)::float ))) end,
	case when (included_parts.calc16 * ( 1 - ( coalesce(shd,0) * (0.16)::float ))) < .01 then 0 else (included_parts.calc16 * ( 1 - ( coalesce(shd,0) * (0.16)::float ))) end,
	case when (included_parts.calc20 * ( 1 - ( coalesce(shd,0) * (0.20)::float ))) < .01 then 0 else (included_parts.calc20 * ( 1 - ( coalesce(shd,0) * (0.20)::float ))) end,
	case when (included_parts.calc19 * ( 1 - ( coalesce(shd,0) * (0.19)::float ))) < .01 then 0 else (included_parts.calc19 * ( 1 - ( coalesce(shd,0) * (0.19)::float ))) end,
	case when (included_parts.calc24 * ( 1 - ( coalesce(shd,0) * (0.24)::float ))) < .01 then 0 else (included_parts.calc24 * ( 1 - ( coalesce(shd,0) * (0.24)::float ))) end,
	case when (included_parts.calc28 * ( 1 - ( coalesce(shd,0) * (0.28)::float ))) < .01 then 0 else (included_parts.calc28 * ( 1 - ( coalesce(shd,0) * (0.28)::float ))) end
	 	 
From  
	(
	Select lnx.comid, (shed.shedareadrainlake/100)::float as shd,  huc12, hydroseq, dnhydroseq, areasqkm
	
	From wikiwtershed.nhdplus_stream_nsidx lnx left outer join wikiwtershed.cache_nhdcoefs_2019 shed
	On lnx.comid = shed.comid
	) t1 
	join included_parts 
	-- on t1.dnhydroseq = included_parts.hydroseq 
	 on t1.hydroseq = included_parts.dnhydroseq 
	and ( t1.huc12 = included_parts.huc12 or t1.areasqkm < .01)
)
Select 
	comid, 
	--array_agg(rte order by plce asc)::float[],
	min(calc84), min(calc29), min(calc12),min(calc42), min(calc22), min(calc0), min(calc75), min(calc21), min(calc11), min(calc10), min(calc5), min(calc13), min(calc02),min(calc16),min(calc20),min(calc19),min(calc24),min(calc28)
	--*	
From included_parts
Group By comid  
order by comid
) ;
-- runs in 1438120

--Select * From wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019 where comid = 4650820





ALTER TABLE wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019
  ADD PRIMARY KEY (comid);

Select * from wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019 limit 100


-- Ran from here 04 12 22 because I put in new pt source data

Drop Table if Exists wikiwtershed.HUC12_att_2019;
Create Table wikiwtershed.HUC12_att_2019
(
huc12 character varying not null,

ow2011_tp_att_coef float,
ice2011_tp_att_coef float,
urbop2011_tp_att_coef float,
urblo2011_tp_att_coef float,
urbmd2011_tp_att_coef float,
urbhi2011_tp_att_coef float,
bl2011_tp_att_coef float,
decid2011_tp_att_coef float,
conif2011_tp_att_coef float,
mxfst2011_tp_att_coef float,
shrb2011_tp_att_coef float,
grs2011_tp_att_coef float,
hay2011_tp_att_coef float,
crop2011_tp_att_coef float,
wdwet2011_tp_att_coef float,
hbwet2011_tp_att_coef float,
pt_2011_tp_att_coef float,
-- Add New ones based on convesation with Barry 

all_wetland2011cat_tp_att_coef float,
lowdensity2011cat_tp_att_coef float,
all_forest2011cat_tp_att_coef float,
all_farm2011cat_tp_att_coef float,
streambnk_tp_att_coef float,

-- add in ground water 5_22_18
grnd_tp_att_coef float,


ow2011_tn_att_coef float,
ice2011_tn_att_coef float,
urbop2011_tn_att_coef float,
urblo2011_tn_att_coef float,
urbmd2011_tn_att_coef float,
urbhi2011_tn_att_coef float,
bl2011_tn_att_coef float,
decid2011_tn_att_coef float,
conif2011_tn_att_coef float,
mxfst2011_tn_att_coef float,
shrb2011_tn_att_coef float,
grs2011_tn_att_coef float,
hay2011_tn_att_coef float,
crop2011_tn_att_coef float,
wdwet2011_tn_att_coef float,
hbwet2011_tn_att_coef float,
pt_2011_tn_att_coef float,

all_wetland2011cat_tn_att_coef float,
lowdensity2011cat_tn_att_coef float,
all_forest2011cat_tn_att_coef float,
all_farm2011cat_tn_att_coef float,
streambnk_tn_att_coef float,

-- add in ground water 5_22_18
grnd_tn_att_coef float,

ow2011_tss_att_coef float,
ice2011_tss_att_coef float,
urbop2011_tss_att_coef float,
urblo2011_tss_att_coef float,
urbmd2011_tss_att_coef float,
urbhi2011_tss_att_coef float,
bl2011_tss_att_coef float,
decid2011_tss_att_coef float,
conif2011_tss_att_coef float,
mxfst2011_tss_att_coef float,
shrb2011_tss_att_coef float,
grs2011_tss_att_coef float,
hay2011_tss_att_coef float,
crop2011_tss_att_coef float,
wdwet2011_tss_att_coef float,
hbwet2011_tss_att_coef float,

all_wetland2011cat_tss_att_coef float,
lowdensity2011cat_tss_att_coef float,
all_forest2011cat_tss_att_coef float,
all_farm2011cat_tss_att_coef float,
streambnk_tss_att_coef float

);

set enable_seqscan = off; 


Truncate table wikiwtershed.HUC12_att_2019;

insert into wikiwtershed.HUC12_att_2019
(
huc12,
ow2011_tp_att_coef,
ice2011_tp_att_coef,
urbop2011_tp_att_coef,
urblo2011_tp_att_coef,
urbmd2011_tp_att_coef,
urbhi2011_tp_att_coef,
bl2011_tp_att_coef,
decid2011_tp_att_coef,
conif2011_tp_att_coef,
mxfst2011_tp_att_coef,
shrb2011_tp_att_coef,
grs2011_tp_att_coef,
hay2011_tp_att_coef,
crop2011_tp_att_coef,
wdwet2011_tp_att_coef,
hbwet2011_tp_att_coef,
pt_2011_tp_att_coef,

all_wetland2011cat_tp_att_coef,
lowdensity2011cat_tp_att_coef,
all_forest2011cat_tp_att_coef,
all_farm2011cat_tp_att_coef,
streambnk_tp_att_coef,
-- Added in 5_22_18
grnd_tp_att_coef,

ow2011_tn_att_coef,
ice2011_tn_att_coef,
urbop2011_tn_att_coef,
urblo2011_tn_att_coef,
urbmd2011_tn_att_coef,
urbhi2011_tn_att_coef,
bl2011_tn_att_coef,
decid2011_tn_att_coef,
conif2011_tn_att_coef,
mxfst2011_tn_att_coef,
shrb2011_tn_att_coef,
grs2011_tn_att_coef,
hay2011_tn_att_coef,
crop2011_tn_att_coef,
wdwet2011_tn_att_coef,
hbwet2011_tn_att_coef,
pt_2011_tn_att_coef,
all_wetland2011cat_tn_att_coef,
lowdensity2011cat_tn_att_coef,
all_forest2011cat_tn_att_coef,
all_farm2011cat_tn_att_coef,
streambnk_tn_att_coef,
-- Added in 5_22_18
grnd_tn_att_coef,

ow2011_tss_att_coef,
ice2011_tss_att_coef,
urbop2011_tss_att_coef,
urblo2011_tss_att_coef,
urbmd2011_tss_att_coef,
urbhi2011_tss_att_coef,
bl2011_tss_att_coef,
decid2011_tss_att_coef,
conif2011_tss_att_coef,
mxfst2011_tss_att_coef,
shrb2011_tss_att_coef,
grs2011_tss_att_coef,
hay2011_tss_att_coef,
crop2011_tss_att_coef,
wdwet2011_tss_att_coef,
hbwet2011_tss_att_coef,
all_wetland2011cat_tss_att_coef,
lowdensity2011cat_tss_att_coef,
all_forest2011cat_tss_att_coef,
all_farm2011cat_tss_att_coef,
streambnk_tss_att_coef
)

Select 
hcn.huc12,

sum(coalesce(p_ow2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_ice2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_urbop2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_urblo2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_urbmd2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_urbhi2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_bl2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_decid2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_conif2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_mxfst2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_shrb2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_grs2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_hay2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_crop2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_wdwet2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_hbwet2011catcomid_x_huc12,0) 	* rdc_16),
sum(coalesce(p_pt_kgp_yr_x_huc12,0) 		* rdc_16),

sum(coalesce(p_all_wetland2011cat_x_huc12,0) 	* rdc_16),
sum(coalesce(p_all_lowdensity2011cat_x_huc12,0) * rdc_16),
sum(coalesce(p_all_forest2011cat_x_huc12,0) 	* rdc_16),
sum(coalesce(p_all_farm2011cat_x_huc12,0) 	* rdc_16),
--streambank is special
(
( sum(coalesce(p_imparea_x_huc12,0) 	* rdc_16) * 0.60 ) +
( sum(coalesce(p_catarea_x_huc12,0) 	* rdc_16) * 0.40 )
),

-- Add in subsurface
sum(coalesce(p_tnsumgrnd_x_huc12,0) 	* rdc_16),




sum(coalesce(p_ow2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_ice2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_urbop2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_urblo2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_urbmd2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_urbhi2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_bl2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_decid2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_conif2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_mxfst2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_shrb2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_grs2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_hay2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_crop2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_wdwet2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_hbwet2011catcomid_x_huc12,0) 	* rdc_02),
sum(coalesce(p_pt_kgn_yr_x_huc12	,0) 	* rdc_02),

sum(coalesce(p_all_wetland2011cat_x_huc12,0) 	* rdc_02),
sum(coalesce(p_all_lowdensity2011cat_x_huc12,0) * rdc_02),
sum(coalesce(p_all_forest2011cat_x_huc12,0) 	* rdc_02),
sum(coalesce(p_all_farm2011cat_x_huc12,0) 	* rdc_02),
--streambank is special
(
( sum(coalesce(p_imparea_x_huc12,0) 	* rdc_02) * 0.60 ) +
( sum(coalesce(p_catarea_x_huc12,0) 	* rdc_02) * 0.40 )
),

-- Add in subsurface
sum(coalesce(p_tnsumgrnd_x_huc12,0) 	* rdc_02),


sum(coalesce(p_ow2011catcomid_x_huc12,0) 	* rdc_20),
sum(coalesce(p_ice2011catcomid_x_huc12,0) 	* rdc_20),
sum(coalesce(p_urbop2011catcomid_x_huc12,0) 	* rdc_20),
sum(coalesce(p_urblo2011catcomid_x_huc12,0) 	* rdc_20),
sum(coalesce(p_urbmd2011catcomid_x_huc12,0) 	* rdc_20),
sum(coalesce(p_urbhi2011catcomid_x_huc12,0) 	* rdc_20),
sum(coalesce(p_bl2011catcomid_x_huc12,0) 	* rdc_20),
sum(coalesce(p_decid2011catcomid_x_huc12,0) 	* rdc_20),
sum(coalesce(p_conif2011catcomid_x_huc12,0) 	* rdc_20),
sum(coalesce(p_mxfst2011catcomid_x_huc12,0) 	* rdc_20),
sum(coalesce(p_shrb2011catcomid_x_huc12,0) 	* rdc_20),
sum(coalesce(p_grs2011catcomid_x_huc12,0) 	* rdc_20),
sum(coalesce(p_hay2011catcomid_x_huc12,0) 	* rdc_20),
sum(coalesce(p_crop2011catcomid_x_huc12,0) 	* rdc_20),
sum(coalesce(p_wdwet2011catcomid_x_huc12,0) 	* rdc_20),
sum(coalesce(p_hbwet2011catcomid_x_huc12,0) 	* rdc_20), 

sum(coalesce(p_all_wetland2011cat_x_huc12,0) 	* rdc_20),
sum(coalesce(p_all_lowdensity2011cat_x_huc12,0) * rdc_20),
sum(coalesce(p_all_forest2011cat_x_huc12,0) 	* rdc_20),
sum(coalesce(p_all_farm2011cat_x_huc12,0) 	* rdc_20),
--streambank is special
(
( sum(coalesce(p_imparea_x_huc12,0) 	* rdc_20) * 0.60 ) +
( sum(coalesce(p_catarea_x_huc12,0) 	* rdc_20) * 0.40 )
)



From 
	wikiwtershed.cache_nhdcoefs_2019 ncfs
	join
	wikiwtershed.nhdplus_x_huc12 hcn
	ON ncfs.comid = hcn.comid

	join
	wikiwtershed.HUC12_att_tmptbl1_comidextarray_2019 ncfsa
	on ncfs.comid = ncfsa.comid
Where hcn.Huc12 is not null	
Group By hcn.huc12;	 

grant select on wikiwtershed.HUC12_att_2019  to ms_select;

-- DONT RUN
Alter Table wikiwtershed.HUC12_att_2019 Rename TO HUC12_att_new;

Select count(*), sum(pt_2011_tn_att_coef) from wikiwtershed.HUC12_att_new
union all
Select count(*), sum(pt_2011_tn_att_coef)  from wikiwtershed.HUC12_att




Alter Table wikiwtershed.HUC12_att_new add constraint pkhuc12_att11a Primary Key (huc12);

select * from wikiwtershed.HUC12_att_new  limit 100


grant select on wikiwtershed.HUC12_att_new  to ms_select;
Drop Table If Exists wikiwtershed.HUC12_att_old;
Alter Table wikiwtershed.HUC12_att Rename TO HUC12_att_old;
Alter Table wikiwtershed.HUC12_att_new Rename TO HUC12_att;






 