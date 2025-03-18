use warehouse COMPUTE_WH;
use role sysadmin;
use database DMAS;
use schema AOEC;
-- ==================================================================================
create or replace transient table RAW_LOCATION_COUNTRY (
    country_id                          varchar,
    name_short_en                       varchar,
    iso3_code                           varchar,
    legacy_location_id                  varchar
);
create or replace transient table RAW_LOCATION_GROUP (
    group_id                            varchar,
    group_type                          varchar,
    group_name                          varchar,
    parent_id                           varchar,
    parent_type                         varchar
);
create or replace transient table RAW_LOCATION_GROUP_MEMBER (
    group_type                          varchar,
    group_name                          varchar,
    group_id                            varchar,
    country_id                          varchar
);
create or replace transient table RAW_PRODUCT_HS12 (
    product_id                          varchar,
    code                                varchar,
    name_short_en                       varchar,
    product_level                       varchar,
    top_parent_id                       varchar,
    product_id_hierarchy                varchar
);
create or replace transient table RAW_PRODUCT_HS92 (
    product_id                          varchar,
    code                                varchar,
    name_short_en                       varchar,
    product_level                       varchar,
    top_parent_id                       varchar,
    product_id_hierarchy                varchar
);
create or replace transient table RAW_PRODUCT_SERVICES_UNILATERAL (
    product_id                          varchar,
    code                                varchar,
    name_short_en                       varchar,
    product_level                       varchar,
    top_parent_id                       varchar,
    product_id_hierarchy                varchar
);
create or replace transient table RAW_PRODUCT_SITC (
    product_id                          varchar,
    code                                varchar,
    name_short_en                       varchar,
    product_level                       varchar,
    top_parent_id                       varchar,
    product_id_hierarchy                varchar
);

-- ==================================================================================
create or replace transient table RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_1 (
    ID                                  integer identity,
    country_id                          integer,
    partner_country_id                  integer,
    year                                integer,
    product_id                          integer,
    export_value                        float,
    import_value                        float,
    coi                                 float,
    eci                                 float
);
create or replace transient table RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_2 (
    ID                                  integer identity,
    country_id                          integer,
    partner_country_id                  integer,
    year                                integer,
    product_id                          integer,
    export_value                        float,
    import_value                        float,
    coi                                 float,
    eci                                 float
);
create or replace transient table RAW_HS12_COUNTRY_COUNTRY_PRODUCT_YEAR_4_2012_2016 (
    ID                                  integer identity,
    country_id                          integer,
    partner_country_id                  integer,
    year                                integer,
    product_id                          integer,
    export_value                        float,
    import_value                        float,
    coi                                 float,
    eci                                 float,
    pci                                 float
);
create or replace transient table RAW_HS12_COUNTRY_PRODUCT_YEAR_1 (
    ID                                  integer identity,
    country_id                          integer,
    product_id                          integer,
    product_level                       integer,
    year                                integer,
    export_value                        float,
    import_value                        float,
    global_market_share                 float,
    cog                                 float,
    distance                            float,
    coi                                 float,
    eci                                 float
);
create or replace transient table RAW_HS12_COUNTRY_PRODUCT_YEAR_2 (
    ID                                  integer identity,
    country_id                          integer,
    product_id                          integer,
    product_level                       integer,
    year                                integer,
    export_value                        float,
    import_value                        float,
    global_market_share                 float,
    cog                                 float,
    distance                            float,
    coi                                 float,
    eci                                 float
);
create or replace transient table RAW_HS12_COUNTRY_PRODUCT_YEAR_4 (
    ID                                  integer identity,
    country_id                          integer,
    product_id                          integer,
    product_level                       integer,
    year                                integer,
    export_value                        float,
    import_value                        float,
    global_market_share                 float,
    export_rca                          float,
    cog                                 float,
    distance                            float,
    normalized_export_rca               float,
    normalized_distance                 float,
    normalized_cog                      float,
    normalized_pci                      float,
    pci                                 float
);
create or replace transient table RAW_HS12_COUNTRY_PRODUCT_YEAR_6 (
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
create or replace transient table DTAMART_HS12_TRANSACTIONS (
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
