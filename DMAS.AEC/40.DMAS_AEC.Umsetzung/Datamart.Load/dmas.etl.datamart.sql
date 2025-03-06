-- DMAS HS12
-- =========
--      Datamart

insert into DTAMART_HS12_TRANSACTIONS (
        TAB, SRC_ID, 
		CONTINENT, COUNTRY_ID, 
		PARTNER_CONTINENT, PARTNER_COUNTRY_ID, 
		YEAR, 
		PRODUCT_ID, 
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
	select TAB, x.ID, 
		   c.GROUP_NAME as CONTINENT, x.COUNTRY_ID, 
		   p.GROUP_NAME as PARTNER_CONTINENT, x.PARTNER_COUNTRY_ID, 
		   YEAR, 
		   PRODUCT_ID, 
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

select TAB, count(*) as "#" from DTAMART_HS12_TRANSACTIONS group by TAB order by 1;
