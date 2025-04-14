use warehouse DMAS_2X;
use role sysadmin;
use database DMAS;
use schema DMAS.AOEC_MASTER;

put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.Product/location_country.csv @FILES_MASTERDATA;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.Product/location_group.csv @FILES_MASTERDATA;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.Product/location_group_member.csv @FILES_MASTERDATA;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.Product/product_hs12.csv @FILES_MASTERDATA;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.Product/product_services_unilateral.csv @FILES_MASTERDATA;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.Product/product_sitc.csv @FILES_MASTERDATA;

alter warehouse DMAS_2X suspend;
