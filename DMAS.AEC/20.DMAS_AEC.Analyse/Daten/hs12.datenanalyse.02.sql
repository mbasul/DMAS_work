with COLUMNS as (
    select TABLE_NAME, COLUMN_NAME, 'X' as C
        from DMAS.INFORMATION_SCHEMA.COLUMNS
        where TABLE_CATALOG = 'DMAS'
          and TABLE_SCHEMA = 'AOEC'
          and TABLE_NAME like 'RAW_HS12_COUNTRY_PRODUCT_YEAR%'
)
select a.*, b.NCOLS
    from COLUMNS
         pivot (max(C) for TABLE_NAME in (any order by TABLE_NAME)) a
         inner join
         (select COLUMN_NAME, count(*) as NCOLS
              from COLUMNS
              group by COLUMN_NAME
         ) b
             on (a.COLUMN_NAME = b.COLUMN_NAME)
    order by COLUMN_NAME
;
select * from table(result_scan('01bb17a6-0104-3531-0000-000351b6f205'));

select 'union all select '''||TABLE_NAME||''' as Tab, min(YEAR) as Y_MIN, max(YEAR) as Y_MAX from '||TABLE_NAME as CMD
    from INFORMATION_SCHEMA.TABLES t
    where TABLE_CATALOG = 'DMAS'
      and TABLE_SCHEMA = 'AOEC'
      and TABLE_NAME like 'RAW%'
      and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'YEAR' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
    order by TABLE_NAME
;
---
          select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1' as Tab, min(YEAR) as Y_MIN, max(YEAR) as Y_MAX from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1
union all select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2' as Tab, min(YEAR) as Y_MIN, max(YEAR) as Y_MAX from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2
union all select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016' as Tab, min(YEAR) as Y_MIN, max(YEAR) as Y_MAX from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016
union all select 'RAW_HS12_COUNTRY_PRODUCT_YEAR_1' as Tab, min(YEAR) as Y_MIN, max(YEAR) as Y_MAX from RAW_HS12_COUNTRY_PRODUCT_YEAR_1
union all select 'RAW_HS12_COUNTRY_PRODUCT_YEAR_2' as Tab, min(YEAR) as Y_MIN, max(YEAR) as Y_MAX from RAW_HS12_COUNTRY_PRODUCT_YEAR_2
union all select 'RAW_HS12_COUNTRY_PRODUCT_YEAR_4' as Tab, min(YEAR) as Y_MIN, max(YEAR) as Y_MAX from RAW_HS12_COUNTRY_PRODUCT_YEAR_4
union all select 'RAW_HS12_COUNTRY_PRODUCT_YEAR_6' as Tab, min(YEAR) as Y_MIN, max(YEAR) as Y_MAX from RAW_HS12_COUNTRY_PRODUCT_YEAR_6
;


-- ===================================================================================================================================================
-- Werteverteilung: YEAR, COUNTRY, PARTNER, PRODUCT
with
    TABS_SELECTED as (
        select TABLE_NAME
            from INFORMATION_SCHEMA.TABLES t
            where TABLE_CATALOG = 'DMAS'
              and TABLE_SCHEMA = 'AOEC'
              and TABLE_NAME like 'RAW%'
              and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'YEAR' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
              and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'COUNTRY_ID' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
              and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'PARTNER_COUNTRY_ID' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
              and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'PRODUCT_ID' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
    )
select x.TABLE_NAME, 
       'union all select '''||TABLE_NAME||''' as TAB, YEAR as YR, count(*) as N_TAB, count(distinct COUNTRY_ID) as N_COUNTRY, count(distinct PARTNER_COUNTRY_ID) as N_PARTNER, count(distinct PRODUCT_ID) as N_PROD 
                      from '||x.TABLE_NAME||' group by YEAR' as CMD
    from TABS_SELECTED x
    order by x.TABLE_NAME
;
-- ---
select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1' as TAB, YEAR as YR, count(*) as N_TAB, count(distinct COUNTRY_ID) as N_COUNTRY, count(distinct PARTNER_COUNTRY_ID) as N_PARTNER, count(distinct PRODUCT_ID) as N_PROD 
                      from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1 group by YEAR
union all select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2' as TAB, YEAR as YR, count(*) as N_TAB, count(distinct COUNTRY_ID) as N_COUNTRY, count(distinct PARTNER_COUNTRY_ID) as N_PARTNER, count(distinct PRODUCT_ID) as N_PROD 
                      from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2 group by YEAR
union all select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016' as TAB, YEAR as YR, count(*) as N_TAB, count(distinct COUNTRY_ID) as N_COUNTRY, count(distinct PARTNER_COUNTRY_ID) as N_PARTNER, count(distinct PRODUCT_ID) as N_PROD 
                      from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016 group by YEAR
order by 1, 2
;
select * from table(result_scan('01bb1897-0104-3531-0000-000351b6f499'));
-- ===================================================================================================================================================
select 'QRY_'||TABLE_NAME||' as ( select distinct '''||TABLE_NAME||''' as TAB, YEAR, COUNTRY_ID, PARTNER_COUNTRY_ID from '||TABLE_NAME||'),' as CMD_WITH
    from INFORMATION_SCHEMA.TABLES t
    where TABLE_CATALOG = 'DMAS'
      and TABLE_SCHEMA = 'AOEC'
      and TABLE_NAME like 'RAW%'
      and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'YEAR' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
      and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'COUNTRY_ID' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
      and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'PARTNER_COUNTRY_ID' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
    order by TABLE_NAME
;
---
describe table INFORMATION_SCHEMA.TABLES;
with
    TABS_SELECTED as (
        select TABLE_NAME
            from INFORMATION_SCHEMA.TABLES t
            where TABLE_CATALOG = 'DMAS'
              and TABLE_SCHEMA = 'AOEC'
              and TABLE_NAME like 'RAW%'
              and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'YEAR' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
              and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'COUNTRY_ID' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
              and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'PARTNER_COUNTRY_ID' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
              and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'PRODUCT_ID' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
    )
select x.TABLE_NAME, y.TABLE_NAME,
       'union all select a.TAB as A_TAB, b.TAB as B_TAB, coalesce(a.YEAR, b.YEAR) as YR, sum(case when a.TAB is not null and b.TAB is not null then 1 else 0 end) as CNT_BOTH, sum(case when a.TAB is not null and b.TAB is null then 1 else 0 end) as CNT_NUR_A, sum(case when a.TAB is null and b.TAB is not null then 1 else 0 end) as CNT_NUR_B, sum(a.NPROD) as A_PROD, sum(b.NPROD) as B_PROD
                      from (select '''||x.TABLE_NAME||''' as TAB, YEAR, COUNTRY_ID as COUNTRY, PARTNER_COUNTRY_ID as PARTNER, COUNT(*) as CNT, count(distinct PRODUCT_ID) as NPROD from '||x.TABLE_NAME||' group by TAB, YEAR, COUNTRY,PARTNER) a
                           full outer join
                           (select '''||y.TABLE_NAME||''' as TAB, YEAR, COUNTRY_ID as COUNTRY, PARTNER_COUNTRY_ID as PARTNER, COUNT(*) as CNT, count(distinct PRODUCT_ID) as NPROD from '||y.TABLE_NAME||' group by TAB, YEAR, COUNTRY,PARTNER) b
                               on (a.TAB<b.TAB and a.YEAR=b.YEAR and a.COUNTRY=b.COUNTRY and a.PARTNER=b.PARTNER)
                      group by A_TAB, B_TAB, YR' as CMD
    from TABS_SELECTED x
         inner join
         TABS_SELECTED y
            on (x.TABLE_NAME < y.TABLE_NAME)
    order by x.TABLE_NAME, y.TABLE_NAME
;

--- ---
select a.TAB as A_TAB, b.TAB as B_TAB, coalesce(a.YEAR, b.YEAR) as YR, sum(case when a.TAB is not null and b.TAB is not null then 1 else 0 end) as CNT_BOTH, sum(case when a.TAB is not null and b.TAB is null then 1 else 0 end) as CNT_NUR_A, sum(case when a.TAB is null and b.TAB is not null then 1 else 0 end) as CNT_NUR_B, sum(a.NPROD) as A_PROD, sum(b.NPROD) as B_PROD
                      from (select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1' as TAB, YEAR, COUNTRY_ID as COUNTRY, PARTNER_COUNTRY_ID as PARTNER, COUNT(*) as CNT, count(distinct PRODUCT_ID) as NPROD from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1 group by TAB, YEAR, COUNTRY,PARTNER) a
                           full outer join
                           (select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2' as TAB, YEAR, COUNTRY_ID as COUNTRY, PARTNER_COUNTRY_ID as PARTNER, COUNT(*) as CNT, count(distinct PRODUCT_ID) as NPROD from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2 group by TAB, YEAR, COUNTRY,PARTNER) b
                               on (a.TAB<b.TAB and a.YEAR=b.YEAR and a.COUNTRY=b.COUNTRY and a.PARTNER=b.PARTNER)
                      group by A_TAB, B_TAB, YR
union all select a.TAB as A_TAB, b.TAB as B_TAB, coalesce(a.YEAR, b.YEAR) as YR, sum(case when a.TAB is not null and b.TAB is not null then 1 else 0 end) as CNT_BOTH, sum(case when a.TAB is not null and b.TAB is null then 1 else 0 end) as CNT_NUR_A, sum(case when a.TAB is null and b.TAB is not null then 1 else 0 end) as CNT_NUR_B, sum(a.NPROD) as A_PROD, sum(b.NPROD) as B_PROD
                      from (select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1' as TAB, YEAR, COUNTRY_ID as COUNTRY, PARTNER_COUNTRY_ID as PARTNER, COUNT(*) as CNT, count(distinct PRODUCT_ID) as NPROD from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1 group by TAB, YEAR, COUNTRY,PARTNER) a
                           full outer join
                           (select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016' as TAB, YEAR, COUNTRY_ID as COUNTRY, PARTNER_COUNTRY_ID as PARTNER, COUNT(*) as CNT, count(distinct PRODUCT_ID) as NPROD from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016 group by TAB, YEAR, COUNTRY,PARTNER) b
                               on (a.TAB<b.TAB and a.YEAR=b.YEAR and a.COUNTRY=b.COUNTRY and a.PARTNER=b.PARTNER)
                      group by A_TAB, B_TAB, YR
union all select a.TAB as A_TAB, b.TAB as B_TAB, coalesce(a.YEAR, b.YEAR) as YR, sum(case when a.TAB is not null and b.TAB is not null then 1 else 0 end) as CNT_BOTH, sum(case when a.TAB is not null and b.TAB is null then 1 else 0 end) as CNT_NUR_A, sum(case when a.TAB is null and b.TAB is not null then 1 else 0 end) as CNT_NUR_B, sum(a.NPROD) as A_PROD, sum(b.NPROD) as B_PROD
                      from (select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2' as TAB, YEAR, COUNTRY_ID as COUNTRY, PARTNER_COUNTRY_ID as PARTNER, COUNT(*) as CNT, count(distinct PRODUCT_ID) as NPROD from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2 group by TAB, YEAR, COUNTRY,PARTNER) a
                           full outer join
                           (select 'RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016' as TAB, YEAR, COUNTRY_ID as COUNTRY, PARTNER_COUNTRY_ID as PARTNER, COUNT(*) as CNT, count(distinct PRODUCT_ID) as NPROD from RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016 group by TAB, YEAR, COUNTRY,PARTNER) b
                               on (a.TAB<b.TAB and a.YEAR=b.YEAR and a.COUNTRY=b.COUNTRY and a.PARTNER=b.PARTNER)
                      group by A_TAB, B_TAB, YR
order by 1, 2, 3
;

-- ===================================================================================================================================================
-- Join ueber: YEAR, COUNTRY, PARTNER, PRODUCT
with
    TABS_SELECTED as (
        select TABLE_NAME
            from INFORMATION_SCHEMA.TABLES t
            where TABLE_CATALOG = 'DMAS'
              and TABLE_SCHEMA = 'AOEC'
              and TABLE_NAME like 'RAW%'
              and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'YEAR' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
              and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'COUNTRY_ID' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
              and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'PARTNER_COUNTRY_ID' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
              and exists (select 0 from INFORMATION_SCHEMA.COLUMNS x where x.COLUMN_NAME = 'PRODUCT_ID' and x.TABLE_CATALOG = t.TABLE_CATALOG and x.TABLE_SCHEMA = t.TABLE_SCHEMA and x.TABLE_NAME = t.TABLE_NAME )
    )
select x.TABLE_NAME, y.TABLE_NAME,
       'union all select a.TAB as A_TAB, b.TAB as B_TAB, coalesce(a.YEAR, b.YEAR) as YR, sum(case when a.TAB is not null and b.TAB is not null then 1 else 0 end) as CNT_BOTH, sum(case when a.TAB is not null and b.TAB is null then 1 else 0 end) as CNT_NUR_A, sum(case when a.TAB is null and b.TAB is not null then 1 else 0 end) as CNT_NUR_B, sum(a.NPROD) as A_PROD, sum(b.NPROD) as B_PROD
                      from (select '''||x.TABLE_NAME||''' as TAB, YEAR, COUNTRY_ID as COUNTRY, PARTNER_COUNTRY_ID as PARTNER, COUNT(*) as CNT, count(distinct PRODUCT_ID) as NPROD from '||x.TABLE_NAME||' group by TAB, YEAR, COUNTRY,PARTNER) a
                           full outer join
                           (select '''||y.TABLE_NAME||''' as TAB, YEAR, COUNTRY_ID as COUNTRY, PARTNER_COUNTRY_ID as PARTNER, COUNT(*) as CNT, count(distinct PRODUCT_ID) as NPROD from '||y.TABLE_NAME||' group by TAB, YEAR, COUNTRY,PARTNER) b
                               on (a.TAB<b.TAB and a.YEAR=b.YEAR and a.COUNTRY=b.COUNTRY and a.PARTNER=b.PARTNER)
                      group by A_TAB, B_TAB, YR' as CMD
    from TABS_SELECTED x
         inner join
         TABS_SELECTED y
            on (x.TABLE_NAME < y.TABLE_NAME)
    order by x.TABLE_NAME, y.TABLE_NAME
;

