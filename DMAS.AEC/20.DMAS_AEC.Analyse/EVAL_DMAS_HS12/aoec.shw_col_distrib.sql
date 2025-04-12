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

