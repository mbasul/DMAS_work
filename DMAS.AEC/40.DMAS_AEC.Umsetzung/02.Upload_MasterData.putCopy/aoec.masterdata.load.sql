
list @DMAS.AOEC_MASTER_MASTER.FILES_MASTERDATA;

-- select $1, $2 from @FILES_MASTERDATA/product_hs92.csv.gz;

truncate table DMAS.AOEC_MASTER.RAW_LOCATION_COUNTRY;
copy into DMAS.AOEC_MASTER.RAW_LOCATION_COUNTRY
    from @DMAS.AOEC_MASTER.FILES_MASTERDATA
    files = ('location_country.csv.gz')
    file_format = (format_name = DMAS.AOEC_MASTER.HS12_CSV)
;
truncate table DMAS.AOEC_MASTER.RAW_LOCATION_GROUP;
copy into DMAS.AOEC_MASTER.RAW_LOCATION_GROUP
    from @DMAS.AOEC_MASTER.FILES_MASTERDATA
    files = ('location_group.csv.gz')
    file_format = (format_name = DMAS.AOEC_MASTER.HS12_CSV)
;
truncate table DMAS.AOEC_MASTER.RAW_LOCATION_GROUP_MEMBER;
copy into DMAS.AOEC_MASTER.RAW_LOCATION_GROUP_MEMBER
    from @DMAS.AOEC_MASTER.FILES_MASTERDATA
    files = ('location_group_member.csv.gz')
    file_format = (format_name = DMAS.AOEC_MASTER.HS12_CSV)
;
truncate table DMAS.AOEC_MASTER.RAW_PRODUCT_HS12;
copy into DMAS.AOEC_MASTER.RAW_PRODUCT_HS12
    from @DMAS.AOEC_MASTER.FILES_MASTERDATA
    files = ('product_hs12.csv.gz')
    file_format = (format_name = DMAS.AOEC_MASTER.HS12_CSV)
;
truncate table DMAS.AOEC_MASTER.RAW_PRODUCT_SERVICES_UNILATERAL;
copy into DMAS.AOEC_MASTER.RAW_PRODUCT_SERVICES_UNILATERAL
    from @DMAS.AOEC_MASTER.FILES_MASTERDATA
    files = ('product_services_unilateral.csv.gz')
    file_format = (format_name = DMAS.AOEC_MASTER.HS12_CSV)
;
truncate table DMAS.AOEC_MASTER.RAW_PRODUCT_SITC;
copy into DMAS.AOEC_MASTER.RAW_PRODUCT_SITC
    from @DMAS.AOEC_MASTER.FILES_MASTERDATA
    files = ('product_sitc.csv.gz')
    file_format = (format_name = DMAS.AOEC_MASTER.HS12_CSV)
;
