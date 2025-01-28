use role sysadmin;
use database DMAS;
use schema AOEC;

use warehouse DMAS_2X;
alter warehouse DMAS_2X resume;

put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.HS_92/hs92_country_country_product\hs92_country_country_product_year_1.dta
	@AOEC_FILES_HS92
;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.HS_92/hs92_country_country_product\hs92_country_country_product_year_6_1995_1999.dta
	@AOEC_FILES_HS92
;

alter warehouse DMAS_2X suspend;
