use warehouse DMAS_2X;
use database DMAS;
use schema AOEC_DMART;
use role sysadmin;

--show grants on warehouse DMAS_2X;
--revoke usage on warehouse DMAS_2X from sysadmin;
--grant ownership on warehouse DMAS_2X to sysadmin;
alter warehouse DMAS_2X resume;

truncate table DMAS.AOEC_DMART.HS12_PROD_FLOW_TOTALS;
insert into DMAS.AOEC_DMART.HS12_PROD_FLOW_TOTALS (
        CONTINENT, COUNTRY_ID, COUNTRY_ISO3, COUNTRY_NAME,
		PARTNER_CONTINENT, PARTNER_COUNTRY_ID, PARTNER_COUNTRY_ISO3, PARTNER_COUNTRY_NAME, PRODUCT_ID, 
		YEAR, 
		EXPORT_VALUE, IMPORT_VALUE, COI, ECI
    )
	with 
		ALL_DATA (TAB, COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, EXPORT_VALUE, IMPORT_VALUE, COI, ECI)as (
                      select 'CCPY_1' as TAB, COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, sum(EXPORT_VALUE), sum(IMPORT_VALUE), sum(COI), sum(ECI) 
                                  from DMAS.AOEC_FACTS.RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1 group by COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID
            union all select 'CCPY_2' as TAB, COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, sum(EXPORT_VALUE), sum(IMPORT_VALUE), sum(COI), sum(ECI) 
                                  from DMAS.AOEC_FACTS.RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2 group by COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID
            union all select 'CCPY_4_2012_2016' as TAB, COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, sum(EXPORT_VALUE), sum(IMPORT_VALUE), sum(COI), sum(ECI) 
                                  from DMAS.AOEC_FACTS.RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016 group by COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID
            union all select 'CCPY_4_2017_2021' as TAB, COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, sum(EXPORT_VALUE), sum(IMPORT_VALUE), sum(COI), sum(ECI) 
                                  from DMAS.AOEC_FACTS.RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2017_2021 group by COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID
            union all select 'CCPY_4_2022' as TAB, COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, sum(EXPORT_VALUE), sum(IMPORT_VALUE), sum(COI), sum(ECI) 
                                  from DMAS.AOEC_FACTS.RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2022 group by COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID
            union all select 'CCPY_6_2012_2016' as TAB, COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, sum(EXPORT_VALUE), sum(IMPORT_VALUE), sum(COI), sum(ECI) 
                                  from DMAS.AOEC_FACTS.RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_6_2012_2016 group by COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID
            union all select 'CCPY_6_2017_2021' as TAB, COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, sum(EXPORT_VALUE), sum(IMPORT_VALUE), sum(COI), sum(ECI) 
                                  from DMAS.AOEC_FACTS.RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_6_2017_2021 group by COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID
            union all select 'CCPY_6_2022' as TAB, COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, sum(EXPORT_VALUE), sum(IMPORT_VALUE), sum(COI), sum(ECI) 
                                  from DMAS.AOEC_FACTS.RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_6_2022 group by COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID
            --imit 100
        ),
		COUNTRY_FULL as (
			select a.GROUP_NAME as CONTINENT, a.COUNTRY_ID, b.ISO3_CODE, b.NAME_SHORT_EN 
				from DMAS.AOEC_MASTER.RAW_LOCATION_GROUP_MEMBER a
					 inner join DMAS.AOEC_MASTER.RAW_LOCATION_COUNTRY b
						 on (a.COUNTRY_ID = b.COUNTRY_ID)
				where GROUP_TYPE = 'continent'
		)
	select c.CONTINENT, x.COUNTRY_ID, c.ISO3_CODE, c.NAME_SHORT_EN,
		   p.CONTINENT as PARTNER_CONTINENT, x.PARTNER_COUNTRY_ID, p.ISO3_CODE, p.NAME_SHORT_EN, x.PRODUCT_ID,
		   YEAR, 
		   sum(EXPORT_VALUE), sum(IMPORT_VALUE), sum(COI), sum(ECI)
		from ALL_DATA x
			 inner join
			 COUNTRY_FULL c
				 on (c.COUNTRY_ID = x.COUNTRY_ID)
			 inner join
			 COUNTRY_FULL p
				 on (p.COUNTRY_ID = x.PARTNER_COUNTRY_ID)
        group by 
	       c.CONTINENT, x.COUNTRY_ID, c.ISO3_CODE, c.NAME_SHORT_EN,
		   p.CONTINENT, x.PARTNER_COUNTRY_ID, p.ISO3_CODE, p.NAME_SHORT_EN, x.PRODUCT_ID,
		   YEAR
	--limit 100
;

truncate table DMAS.AOEC_DMART.HS12_FLOW_TOTALS;
insert into DMAS.AOEC_DMART.HS12_FLOW_TOTALS (
        CONTINENT, COUNTRY_ID, COUNTRY_ISO3, COUNTRY_NAME, 
		PARTNER_CONTINENT, PARTNER_COUNTRY_ID, PARTNER_COUNTRY_ISO3, PARTNER_COUNTRY_NAME, 
		YEAR, 
		EXPORT_VALUE, IMPORT_VALUE, COI, ECI
    )
	select CONTINENT, COUNTRY_ID, COUNTRY_ISO3, COUNTRY_NAME,
		   PARTNER_CONTINENT, PARTNER_COUNTRY_ID, PARTNER_COUNTRY_ISO3, PARTNER_COUNTRY_NAME, 
		   YEAR, 
		   sum(EXPORT_VALUE), sum(IMPORT_VALUE), sum(COI), sum(ECI)
		from DMAS.AOEC_DMART.HS12_PROD_FLOW_TOTALS
        group by 
	       CONTINENT, COUNTRY_ID, COUNTRY_ISO3, COUNTRY_NAME,
		   PARTNER_CONTINENT, PARTNER_COUNTRY_ID, PARTNER_COUNTRY_ISO3, PARTNER_COUNTRY_NAME, 
		   YEAR
	--limit 100
;

-- Wertfluesse, die geringer sind als der Wert von VALUE_LIMIT werden nicht ausgewiese.
set VALUE_LIMIT = 10000000;

truncate table DMAS.AOEC_DMART.HS12_FLOW_DENORM;
-- Exporte und Importe beim Partnerland
insert into DMAS.AOEC_DMART.HS12_FLOW_DENORM (
        YEAR, COUNTRY_ISO3, COUNTRY_NAME, PARTNER_COUNTRY_ISO3,PARTNER_COUNTRY_NAME, DIRECTION,
        IMPORT_VALUE, EXPORT_VALUE, 
        NROWS
    )
    select YEAR, COUNTRY_ISO3, COUNTRY_NAME,
           PARTNER_COUNTRY_ISO3, PARTNER_COUNTRY_NAME, 'PART', 
            case when sum(IMPORT_VALUE) >= $VALUE_LIMIT then sum(IMPORT_VALUE) else 0 end,
            case when sum(EXPORT_VALUE) >= $VALUE_LIMIT then sum(EXPORT_VALUE) else 0 end,
            count(*)
        from HS12_FLOW_TOTALS
        where IMPORT_VALUE >= $VALUE_LIMIT
           or EXPORT_VALUE >= $VALUE_LIMIT
        group by
           YEAR, COUNTRY_ISO3, COUNTRY_NAME,
           PARTNER_COUNTRY_ISO3, PARTNER_COUNTRY_NAME
;

-- Exporte und Importe beim betrachteten Land (MAIN)
insert into DMAS.AOEC_DMART.HS12_FLOW_DENORM (
        YEAR, COUNTRY_ISO3, COUNTRY_NAME, PARTNER_COUNTRY_ISO3,PARTNER_COUNTRY_NAME, DIRECTION,
        IMPORT_VALUE, EXPORT_VALUE, NROWS
    )
    select coalesce(e.YEAR, i.YEAR) as YR, coalesce(e.COUNTRY_ISO3, i.COUNTRY_ISO3) as CNTRY_ISO3, coalesce(e.COUNTRY_NAME, i.COUNTRY_NAME) as CNTRY_NAME,
           coalesce(e.COUNTRY_ISO3, i.COUNTRY_ISO3), coalesce(e.COUNTRY_NAME, i.COUNTRY_NAME), 'MAIN',
           i.IMPORT_VALUE, e.EXPORT_VALUE, 
           greatest(e.NROWS, i.NROWS)
        from (select YEAR, COUNTRY_ISO3, COUNTRY_NAME, sum(IMPORT_VALUE) as IMPORT_VALUE, count(*) as NROWS from HS12_FLOW_TOTALS group by YEAR, COUNTRY_ISO3, COUNTRY_NAME) i
             full outer join
             (select YEAR, COUNTRY_ISO3, COUNTRY_NAME, sum(EXPORT_VALUE) as EXPORT_VALUE, count(*) as NROWS from HS12_FLOW_TOTALS group by YEAR, COUNTRY_ISO3, COUNTRY_NAME) e
                 on (e.YEAR = i.YEAR and e.COUNTRY_ISO3 = i.COUNTRY_ISO3)
        order by 1, 2
;
alter warehouse DMAS_2x suspend;
