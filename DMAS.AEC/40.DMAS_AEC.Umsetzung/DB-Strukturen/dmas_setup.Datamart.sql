-- DMAS HS12
-- =========
--      Datamart

select * from DMAS.INFORMATION_SCHEMA.COLUMNS
    where TABLE_CATALOG = 'DMAS'
      and TABLE_SCHEMA = 'AOEC'
      and TABLE_NAME = 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1'
    order by TABLE_NAME, ORDINAL_POSITION
;

-- ------------------------------------------------------------------------------------
select * 
    from (select COLUMN_NAME, 
                 replace(replace(replace(TABLE_NAME, 'PRODUCT', 'PROD'), 'COUNTRY', 'CTRY'), 'YEAR', 'Y') AS TAB,
                 1 as CNT 
              from INFORMATION_SCHEMA.COLUMNS
              where TABLE_CATALOG = 'DMAS' and TABLE_SCHEMA = 'AOEC' and TABLE_NAME like 'HS12%'
         ) x
         pivot (sum(x.CNT) 
             for TAB in (any order by TAB)
        )
    order by COLUMN_NAME
;

-- ------------------------------------------------------------------------------------
create or replace transient table DTAMART_HS12_TRANSACTIONS (
    ID                                  integer identity,
    TAB                                 varchar(16),
    SRC_ID                              integer,
    
    COUNTRY_ID                          number,
    COUNTRY_ISO_3                       varchar(3),
    PARTNER_COUNTRY_ID                  number,
    PARTNER_COUNTRY_ISO_3               varchar(3),
    YEAR                                number,
    PRODUCT_ID                          number,
    EXPORT_VALUE                        float,
    IMPORT_VALUE                        float,
    COI                                 float,
    ECI                                 float
);              

insert into DTAMART_HS12_TRANSACTIONS (
        TAB, SRC_ID, COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, EXPORT_VALUE, IMPORT_VALUE, COI, ECI
    )
    with ALL_DATA as (
        select 'CCPY_1' as Tab, 
               ID, COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, EXPORT_VALUE, IMPORT_VALUE, COI, ECI
            from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1
        union all 
        select 'CCPY_2' as Tab, 
               ID, COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, EXPORT_VALUE, IMPORT_VALUE, COI, ECI
            from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2
        union all 
        select 'CCPY_4_12_16' as Tab, 
               ID, COUNTRY_ID, PARTNER_COUNTRY_ID, YEAR, PRODUCT_ID, EXPORT_VALUE, IMPORT_VALUE, COI, ECI
            from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016
    )
    select * from ALL_DATA
;

select TAB, count(*) as "#" from DTAMART_HS12_TRANSACTIONS group by TAB order by 1;

create or replace view DMAS_COUNTRIES
as
select COUNTRY_ID, NAME_SHORT_EN
    from RAW_LOCATION_COUNTRY
;
select * from DMAS_COUNTRIES limit 10;
