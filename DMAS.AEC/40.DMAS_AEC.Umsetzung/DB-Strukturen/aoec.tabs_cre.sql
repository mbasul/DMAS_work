-- create or replace transient table DMAS.AOEC.RAW_PRODUCT_HS92 (
--         "product_id"                  integer,
--         "code"                        string,
--         "name_short_en"               string,
--         "product_level"               integer,
--         "vtop_parent_id"              integer,
--         "product_id_hierarchy"        string
--     )
--     data_retention_time_in_days = 0
-- ;

create or replace transient table DMAS.AOEC.RAW_PRODUCT_HS92 (
        PRODUCT_ID      integer,
        CODE      string,
        NAME_SHORT_EN      string,
        PRODUCT_LEVEL      integer,
        TOP_PARENT_ID      integer,
        PRODUCT_ID_HIERARCHY      string
    )
    data_retention_time_in_days = 0
;



create or replace transient table DMAS.AOEC.RAW_PRODUCT_COUNTRY2_HS92 (
        ID			integer,
	COUNTRY_ID      	integer,
	PARTNER_COUNTRY_ID      integer,
        YEAR                    integer,
        PRODUCT_ID              integer,
        EXPORT_VALUE            float,
        IMPORT_VALUE            float,
        ECI                     float,
        COI                     float
    )
    data_retention_time_in_days = 0
;
