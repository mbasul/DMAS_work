-- DMAS HS12
-- =========
--      Datamart

-- ------------------------------------------------------------------------------------
create or replace transient table DMAS.AOEC_DMART.HS12_PROD_FLOW_TOTALS (
	--ID NUMBER(38,0) autoincrement start 1 increment 1 noorder,
	CONTINENT varchar,
    COUNTRY_ID NUMBER(38,0),
	COUNTRY_ISO3 VARCHAR(3),
	COUNTRY_NAME varchar,
	PARTNER_CONTINENT varchar,
    PARTNER_COUNTRY_ID NUMBER(38,0),
	PARTNER_COUNTRY_ISO3 VARCHAR(3),
	PARTNER_COUNTRY_NAME varchar,
	YEAR NUMBER(38,0),
	PRODUCT_ID NUMBER(38,0),
	EXPORT_VALUE FLOAT,
	IMPORT_VALUE FLOAT,
	COI FLOAT,
	ECI FLOAT
);

create or replace transient table DMAS.AOEC_DMART.HS12_FLOW_TOTALS (
	--ID NUMBER(38,0) autoincrement start 1 increment 1 noorder,
	CONTINENT varchar,
    COUNTRY_ID NUMBER(38,0),
	COUNTRY_ISO3 VARCHAR(3),
	COUNTRY_NAME varchar,
	PARTNER_CONTINENT varchar,
    PARTNER_COUNTRY_ID NUMBER(38,0),
	PARTNER_COUNTRY_ISO3 VARCHAR(3),
	PARTNER_COUNTRY_NAME varchar,
	YEAR NUMBER(38,0),
	EXPORT_VALUE FLOAT,
	IMPORT_VALUE FLOAT,
	COI FLOAT,
	ECI FLOAT
);

create or replace transient table DMAS.AOEC_DMART.HS12_FLOW_DENORM (
	YEAR					number(4),
	COUNTRY_ISO3			varchar(3), 
	COUNTRY_NAME			varchar,
    PARTNER_COUNTRY_ISO3	varchar(3), 
	PARTNER_COUNTRY_NAME	varchar,
	DIRECTION				varchar(3), 
    IMPORT_VALUE			float, 
	EXPORT_VALUE			float, 
	NROWS					number
);

create or replace view DMAS.AOEC_DMART.HS12_FLOW_TABLEAU
as
    select * from DMAS.AOEC_DMART.HS12_FLOW_DENORM
;
