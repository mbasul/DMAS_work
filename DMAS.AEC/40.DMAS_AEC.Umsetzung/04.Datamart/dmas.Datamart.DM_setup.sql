-- DMAS HS12
-- =========
--      Datamart

-- =======================================================================================
create or replace transient table DMAS.AOEC_DMART.HS12_TRANSACTIONS (
    ID                                  integer identity,
    country_id                          integer,
    product_id                          integer,
    product_level                       integer,
    year                                integer,
    export_value                        float,
    import_value                        float,
    global_market_share                 float,
    coi                                 float,
    eci                                 float
);

-- =======================================================================================
create or replace transient table DMAS.AOEC_DMART.HS12_COUNTRIES (
	ID NUMBER(38,0) autoincrement start 1 increment 1 noorder,
	CONTINENT varchar,
    COUNTRY_ID NUMBER(38,0),
	COUNTRY_ISO3 VARCHAR(3),
	COUNTRY_NAME varchar,
    YEAR NUMBER(4,0),
	EXPORT_VALUE FLOAT,
	IMPORT_VALUE FLOAT,
	COI FLOAT,
	ECI FLOAT,
	CNT number
);

create or replace transient table DMAS.AOEC_DMART.HS12_FLOWS (
	ID NUMBER(38,0) autoincrement start 1 increment 1 noorder,
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

create or replace view DMAS.AOEC_DMART.HS12_TX_C_C_Y (
	CONTINENT,
    COUNTRY_ISO3,
	PARTNER_CONTINENT,
	PARTNER_COUNTRY_ISO3,
	YEAR,
	EXPORT_VALUE
) as
    select CONTINENT,
           COUNTRY_ISO3,
           PARTNER_COUNTRY_ISO3,
           YEAR,
           sum(EXPORT_VALUE) as EXPORT_VALUE
        from DMAS.AOEC_DMART.HS12_TRANSACTIONS
        group by COUNTRY_ISO3, PARTNER_COUNTRY_ISO3, YEAR
;

update DMAS.AOEC_DMART.HS12_TRANSACTIONS
        set CONTINENT = y.GROUP_NAME
    from DMAS.AOEC.LOCATION_GROUP_MEMBER y
    where y.GROUP_TYPE = 'continent'
      and y.COUNTRY_ID = DTAMART_HS12_TRANSACTIONS.COUNTRY_ID
;

update DMAS.AOEC_DMART.HS12_TRANSACTIONS
        set PARTNER_CONTINENT = y.GROUP_NAME
    from DMAS.AOEC.LOCATION_GROUP_MEMBER y
    where y.GROUP_TYPE = 'continent'
      and y.COUNTRY_ID = DTAMART_HS12_TRANSACTIONS.PARTNER_COUNTRY_ID
;
