"""
import_HS12_directly.py   --   Importieren von HS12-Daten im .dta-Format (STATA) in jeweils eigene Tabellen

Synopsis:
    python import_HS12_directly.stata.py

Description:
	.dta file given by a list will be used to automatically create Snowflake tables.
	The data content of these file will then be loaded into the newly created tables.

"""

import sys
import os
import time
import pandas as pd
import sqlalchemy as sqac
from sqlalchemy.dialects import registry
 
registry.register('snowflake', 'snowflake.sqlalchemy', 'dialect')
engine = sqac.create_engine(
    'snowflake://{u}:{p}@{a}/{d}/{s}?warehouse={w}&role={r}'.format(
        u='MBASUL250317',
        p='gOkmN+6cF=6Yj5jeKRxtN',
        a='APXGJLP-SB58316',
        r='sysadmin',
        d='DMAS',
        s='AOEC',
        w='COMPUTE_WH',
    )
)

src_path = r'C:\Users\balzer\Documents\Projekte\Sulzer\UserStories_Sulzer\DMAS\DMAS.AEC\10.DMAS_AEC.Materialien\Dataset.HS12'
input_file_list = [
    'hs12_country_country_product_year_1.dta',
    'hs12_country_country_product_year_2.dta',
    'hs12_country_country_product_year_4_2012_2016.dta',
    'hs12_country_country_product_year_4_2017_2021.dta',
    'hs12_country_country_product_year_4_2022.dta',
    'hs12_country_country_product_year_6_2012_2016.dta',
    'hs12_country_country_product_year_6_2017_2021.dta',
    'hs12_country_country_product_year_6_2022.dta',
    'hs12_country_product_year_1.dta',
    'hs12_country_product_year_2.dta',
    'hs12_country_product_year_4.dta',
    'hs12_country_product_year_6.dta',
]
 
os.chdir(src_path)
try:
    for path in input_file_list:
 
        file_name, _ext = os.path.splitext(os.path.basename(path))
        table_name = 'RAW_'+file_name.upper()

        start_sec = time.time()
        start = time.localtime(start_sec)
        print("=== Reading:   {0:s}  (Start: {1:02d}:{2:02d}:{3:02d})".format(path, start.tm_hour, start.tm_min, start.tm_sec))
        data = pd.read_stata(path)

        load_sec = time.time()
        print("=== Loading:   {0:s}  (Load: {1:02d}:{2:02d}:{3:02d})".format(path, start.tm_hour, start.tm_min, start.tm_sec))
        with engine.begin() as tx:
            try:
                data.to_sql(table_name, engine, index = False, chunksize = 20000, if_exists = 'replace')
            except:
                print("*** (Error):   to_sql({0:s}):  error={1:s}".format(file_name, repr(sys.exception())))
        ende_sec = time.time()

        ende = time.localtime(ende_sec)
        print("---     Ready:   {0:5d} [sec]  (Ende: {1:02d}:{2:02d}:{3:02d})".format(int(ende_sec-start_sec), ende.tm_hour, ende.tm_min, ende.tm_sec))
 
finally:
    engine.dispose()
