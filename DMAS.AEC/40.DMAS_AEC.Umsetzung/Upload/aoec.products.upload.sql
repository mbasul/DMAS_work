use warehouse DMAS_2X;
use role sysadmin;
use database DMAS;
use schema AOEC;

put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.HS_92/product_hs92/product_hs92.csv
	@AOEC_FILES_UPLOAD
;

put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.Product/location_country.csv @AOEC_FILES_UPLOAD;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.Product/location_group.csv @AOEC_FILES_UPLOAD;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.Product/location_group_member.csv @AOEC_FILES_UPLOAD;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.Product/product_hs12.csv @AOEC_FILES_UPLOAD;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.Product/product_hs92.csv @AOEC_FILES_UPLOAD;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.Product/product_services_unilateral.csv @AOEC_FILES_UPLOAD;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.Product/product_sitc.csv @AOEC_FILES_UPLOAD;

alter warehouse DMAS_2X suspend;
