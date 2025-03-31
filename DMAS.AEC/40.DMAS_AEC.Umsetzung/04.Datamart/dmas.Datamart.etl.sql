use warehouse DMAS_2X;
use database DMAS;
use schema AOEC;
use role sysadmin;

--show grants on warehouse DMAS_2X;
--revoke usage on warehouse DMAS_2X from sysadmin;
--grant ownership on warehouse DMAS_2X to sysadmin;
alter warehouse DMAS_2X resume;

truncate table DTAMART_HS12_FLOWS_TOTALS;
insert into DTAMART_HS12_FLOWS_TOTALS (
        CONTINENT, COUNTRY_ID, COUNTRY_ISO3, COUNTRY_NAME, 
	PARTNER_CONTINENT, PARTNER_COUNTRY_ID, PARTNER_COUNTRY_ISO3, PARTNER_COUNTRY_NAME, 
	YEAR, 
	EXPORT_VALUE, IMPORT_VALUE, COI, ECI
    )
	with 
		ALL_DATA as (
			select 'CCPY_1' as Tab, ID,
				   COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, EXPORT_VALUE, IMPORT_VALUE, COI, ECI
				from HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1
			union all 
			select 'CCPY_2' as Tab, ID,
				   COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, EXPORT_VALUE, IMPORT_VALUE, COI, ECI
				from HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2
			union all 
			select 'CCPY_4_12_16' as Tab,  ID,
				   COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, EXPORT_VALUE, IMPORT_VALUE, COI, ECI
				from HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016
		),
		COUNTRY_FULL as (
			select a.GROUP_NAME, a.COUNTRY_ID, b.ISO3_CODE, b.NAME_SHORT_EN 
				from LOCATION_GROUP_MEMBER a
					 inner join LOCATION_COUNTRY b
						 on (a.COUNTRY_ID = b.COUNTRY_ID)
				where GROUP_TYPE = 'continent'
		)
	select c.GROUP_NAME as CONTINENT, x.COUNTRY_ID, c.ISO3_CODE, c.NAME_SHORT_EN,
		   p.GROUP_NAME as PARTNER_CONTINENT, x.PARTNER_COUNTRY_ID, p.ISO3_CODE, p.NAME_SHORT_EN,
		   YEAR, 
		   EXPORT_VALUE, IMPORT_VALUE, COI, ECI
		from ALL_DATA x
			 inner join
			 COUNTRY_FULL c
				 on (c.COUNTRY_ID = x.COUNTRY_ID)
			 inner join
			 COUNTRY_FULL p
				 on (p.COUNTRY_ID = x.PARTNER_COUNTRY_ID)
	--limit 100
;

truncate table DTAMART_HS12_COUNTRIES_TOTALS;
insert into DTAMART_HS12_COUNTRIES_TOTALS (
        CONTINENT, COUNTRY_ID, COUNTRY_ISO3, COUNTRY_NAME, 
	YEAR, 
	EXPORT_VALUE, IMPORT_VALUE,
        CNT
    )
	select CONTINENT, COUNTRY_ID, COUNTRY_ISO3, COUNTRY_NAME,
	       YEAR, 
	       sum(EXPORT_VALUE) as EXPORT_VALUE, 
               sum(IMPORT_VALUE) as IMPORT_VALUE,
               count(*) as CNT
	    from DTAMART_HS12_FLOWS_TOTALS x
	    group by CONTINENT, COUNTRY_ID, COUNTRY_ISO3, COUNTRY_NAME, YEAR
	--limit 100
;
alter warehouse DMAS_2x suspend;
