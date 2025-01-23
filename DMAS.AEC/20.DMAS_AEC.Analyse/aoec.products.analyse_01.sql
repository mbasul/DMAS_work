select * from DMAS.AOEC.RAW_PRODUCT_HS92 
    where PRODUCT_LEVEL = 4
    limit 30;

select PRODUCT_LEVEL, count(*) from DMAS.AOEC.RAW_PRODUCT_HS92 group by PRODUCT_LEVEL order by 1;

select PRODUCT_ID as ProdID, CODE, 
       space(3*case PRODUCT_LEVEL when 1 then 0 when 2 then 1 when 4 then 2 when 6 then 3 end)||NAME_SHORT_EN as BEZ, 
       PRODUCT_ID_HIERARCHY, PRODUCT_LEVEL as LVL
    from DMAS.AOEC.RAW_PRODUCT_HS92 
    where PRODUCT_ID_HIERARCHY like '2%'
    order by PRODUCT_ID_HIERARCHY;
