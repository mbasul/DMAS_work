!set echo=true
!set log_file=hs12.statistics.dta.all.upload.log

use role sysadmin;
use database DMAS;
use schema AOEC;

use warehouse DMAS_2X;
alter warehouse DMAS_2X resume;

select current_timestamp;

put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.HS12/hs12_country_country_product_year_1.dta				@AOEC_FILES_HS12;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.HS12/hs12_country_country_product_year_2.dta				@AOEC_FILES_HS12;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.HS12/hs12_country_country_product_year_4_2012_2016.dta	@AOEC_FILES_HS12;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.HS12/hs12_country_country_product_year_4_2017_2021.dta	@AOEC_FILES_HS12;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.HS12/hs12_country_country_product_year_4_2022.dta			@AOEC_FILES_HS12;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.HS12/hs12_country_country_product_year_6_2012_2016.dta	@AOEC_FILES_HS12;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.HS12/hs12_country_country_product_year_6_2017_2021.dta	@AOEC_FILES_HS12;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.HS12/hs12_country_country_product_year_6_2022.dta			@AOEC_FILES_HS12;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.HS12/hs12_country_product_year_1.dta						@AOEC_FILES_HS12;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.HS12/hs12_country_product_year_2.dta						@AOEC_FILES_HS12;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.HS12/hs12_country_product_year_4.dta						@AOEC_FILES_HS12;
put file://c:/Users/balzer/Documents/Projekte/Sulzer/UserStories_Sulzer/DMAS/DMAS.AEC/10.DMAS_AEC.Materialien/Dataset.HS12/hs12_country_product_year_6.dta						@AOEC_FILES_HS12;

select current_timestamp;

alter warehouse DMAS_2X suspend;
