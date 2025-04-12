create warehouse DMAS_2X with
    warehouse_type = standard
    warehouse_size = medium
    auto_suspend = 15
    initially_suspended = true
;
grant operate on warehouse DMAS_2X to sysadmin;
grant usage on warehouse DMAS_2X to sysadmin;
use warehouse COMPUTE_WH;

create transient database if not exists DMAS
    data_retention_time_in_days = 0
;
grant ownership on database DMAS to sysadmin;
grant ownership on schema DMAS.PUBLIC to sysadmin;

use role sysadmin;

create transient schema if not exists AOEC_MASTER
    comment = 'Atlas of Economic Complexity'
;
create transient schema if not exists AOEC_FACTS
    comment = 'Atlas of Economic Complexity'
;
create transient schema if not exists AOEC_DMART
    comment = 'Atlas of Economic Complexity'
;

create or replace stage DMAS.AOEC_MASTER.FILES_MASTERDATA
    encryption = (type = 'SNOWFLAKE_SSE')
;
create or replace stage DMAS.AOEC_FACTS.FILES_HS12
    encryption = (type = 'SNOWFLAKE_SSE')
;
create or replace stage DMAS.PUBLIC.FILES_UPLOAD
    encryption = (type = 'SNOWFLAKE_SSE')
;

create or replace file format DMAS.AOEC_MASTER.HS12_CSV
    type = csv
    field_delimiter = ','
    skip_header = 1
    trim_space = true
;

create or replace file format DMAS.AOEC_FACTS.HS12_CSV
    type = csv
    field_delimiter = ','
    skip_header = 1
    trim_space = true
;
