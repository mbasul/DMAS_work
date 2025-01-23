
list @AOEC_FILES_UPLOAD;

-- select $1, $2 from @AOEC_FILES_UPLOAD/product_hs92.csv.gz;

truncate table DMAS.AOEC.RAW_PRODUCT_HS92;
copy into DMAS.AOEC.RAW_PRODUCT_HS92
     from @AOEC_FILES_UPLOAD
    files = ('product_hs92.csv.gz')
    file_format = (type = csv field_delimiter = ',' field_optionally_enclosed_by = '"' skip_header = 1)
;

select * from DMAS.AOEC.RAW_PRODUCT_HS92 limit 100;
