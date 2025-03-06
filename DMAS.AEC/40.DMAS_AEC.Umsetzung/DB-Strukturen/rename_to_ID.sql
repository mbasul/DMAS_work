select TABLE_NAME, COLUMN_NAME
    from INFORMATION_SCHEMA.COLUMNS
    where COLUMN_NAME like 'Unnamed: 0'
    order by 1, 2
;

select TABLE_NAME, COLUMN_NAME,
       'alter table '||TABLE_NAME||' rename column "'||COLUMN_NAME||'" to ID;' as CMD
    from INFORMATION_SCHEMA.COLUMNS
    where COLUMN_NAME like 'Unnamed: 0'
    order by 1, 2
;

alter table HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1 rename column "Unnamed: 0" to ID;
alter table HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2 rename column "Unnamed: 0" to ID;
alter table HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016 rename column "Unnamed: 0" to ID;
alter table HS12_COUNTRY_PRODUCT_YEAR_1 rename column "Unnamed: 0" to ID;
alter table HS12_COUNTRY_PRODUCT_YEAR_2 rename column "Unnamed: 0" to ID;
alter table HS12_COUNTRY_PRODUCT_YEAR_4 rename column "Unnamed: 0" to ID;
alter table HS12_COUNTRY_PRODUCT_YEAR_6 rename column "Unnamed: 0" to ID;