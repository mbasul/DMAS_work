select * from DMAS.INFORMATION_SCHEMA.TABLES
    where TABLE_CATALOG = 'DMAS'
      and TABLE_SCHEMA = 'AOEC'
      and TABLE_NAME like 'RAW%'
    order by TABLE_NAME
;

select * from DMAS.INFORMATION_SCHEMA.COLUMNS
    where TABLE_CATALOG = 'DMAS'
      and TABLE_SCHEMA = 'AOEC'
      and TABLE_NAME like 'RAW%'
    order by TABLE_NAME
;

select *
    from (select TABLE_NAME, COLUMN_NAME, 'X' as C
              from DMAS.INFORMATION_SCHEMA.COLUMNS
              where TABLE_CATALOG = 'DMAS'
                and TABLE_SCHEMA = 'AOEC'
                and TABLE_NAME like 'RAW_HS12_COUNTRY%'
         )
    pivot (max(C) for COLUMN_NAME in (any order by COLUMN_NAME))
    order by TABLE_NAME
;

          select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1' as Tab, NVAL, count(*) as FRQ 
              from (select COUNTRY_ID, PARTNER_COUNTRY_ID, PRODUCT_ID, YEAR, count(*) as NVAL 
                        from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1 group by COUNTRY_ID, PARTNER_COUNTRY_ID, PRODUCT_ID, YEAR)
              group by NVAL
union all select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2' as Tab, NVAL, count(*) as FRQ 
              from (select COUNTRY_ID, PARTNER_COUNTRY_ID, PRODUCT_ID, YEAR, count(*) as NVAL 
                        from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2
                        group by COUNTRY_ID, PARTNER_COUNTRY_ID, PRODUCT_ID, YEAR)
              group by NVAL
union all select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016' as Tab, NVAL, count(*) as FRQ 
              from (select COUNTRY_ID, PARTNER_COUNTRY_ID, PRODUCT_ID, YEAR, count(*) as NVAL 
                        from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016
                        group by COUNTRY_ID, PARTNER_COUNTRY_ID, PRODUCT_ID, YEAR)
              group by NVAL
;

with ALL_DATA as (
    select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1' as Tab, 
           COUNTRY_ID, PARTNER_COUNTRY_ID, PRODUCT_ID, YEAR
        from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1
    union all 
    select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2' as Tab, 
           COUNTRY_ID, PARTNER_COUNTRY_ID, PRODUCT_ID, YEAR
        from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2
    union all 
    select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016' as Tab, 
           COUNTRY_ID, PARTNER_COUNTRY_ID, PRODUCT_ID, YEAR
        from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016
)
select *
    from (select x.TAB as TAB_A, y.TAB as TAB_B, count(*) as N_TOGETHER
              from ALL_DATA x
                   inner join
                   ALL_DATA y
                       on (    -- x.TAB < y.TAB and 
                           --and x.COUNTRY_ID =y.COUNTRY_ID and
                           x.PARTNER_COUNTRY_ID =y.PARTNER_COUNTRY_ID and 
                           x.PRODUCT_ID =y.PRODUCT_ID and
                           x.YEAR = y.YEAR
                          )
              group by x.TAB, y.TAB
         )
    pivot(sum(N_TOGETHER) for TAB_B in (any order by TAB_B))
    order by TAB_A
;
