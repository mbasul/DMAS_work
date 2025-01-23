create warehouse DMAS_2X with
    warehouse_type = standard
    warehouse_size = medium
    auto_suspend = 30
    initially_suspended = true
;

create transient database if not exists DMAS
    data_retention_time_in_days = 0
;

create or replace schema AOEC
    comment = 'Atlas of Economic Complexity'
;

create stage DMAS.PUBLIC.FILES_UPLOAD
    encryption = (type = 'SNOWFLAKE_SSE')
;
list @DMAS.PUBLIC.FILES_UPLOAD;

create stage DMAS.AOEC.AOEC_FILES_HS92
    encryption = (type = 'SNOWFLAKE_SSE')
;
list @DMAS.AOEC.AOEC_FILES_HS92;

