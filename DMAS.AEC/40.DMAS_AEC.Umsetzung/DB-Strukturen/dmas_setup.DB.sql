create warehouse DMAS_2X with
    warehouse_type = standard
    warehouse_size = medium
    auto_suspend = 30
    initially_suspended = true
;
grant usage on warehouse DMAS_2X to sysadmin;

grant ownership on schema DMAS.PUBLIC to sysadmin;

use role sysadmin;

create transient database if not exists DMAS
    data_retention_time_in_days = 0
;
grant ownership on database DMAS to sysadmin;

create transient schema if not exists AOEC
    comment = 'Atlas of Economic Complexity'
;

create or replace stage DMAS.PUBLIC.FILES_UPLOAD
    encryption = (type = 'SNOWFLAKE_SSE')
;
list @DMAS.PUBLIC.FILES_UPLOAD;

create or replace stage DMAS.AOEC.AOEC_FILES_HS92
    encryption = (type = 'SNOWFLAKE_SSE')
;
list @DMAS.AOEC.AOEC_FILES_HS92;


create or replace stage DMAS.AOEC.AOEC_FILES_HS12
    encryption = (type = 'SNOWFLAKE_SSE')
;
list @DMAS.AOEC.AOEC_FILES_HS12;
